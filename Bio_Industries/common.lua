return function (mod_name)
  local common = {}

  ------------------------------------------------------------------------------------
  -- Get mod name and path to mod
  common.modName = mod_name
  common.modRoot = "__" .. mod_name .. "__"

  ------------------------------------------------------------------------------------
  -- Sane values for collision masks
  common.RAIL_BRIDGE_MASK = {"floor-layer", "object-layer", "consider-tile-transitions"}
  common.RAIL_MASK = {"item-layer", "floor-layer", "object-layer", "water-tile", "consider-tile-transitions"}


  ------------------------------------------------------------------------------------
  -- Set maximum_wire_distance of Power-to-rail connectors
  common.POWER_TO_RAIL_WIRE_DISTANCE = 4


  --~ ------------------------------------------------------------------------------------
  --~ -- Set some values for Musk floor tiles (bi-solar-mat), so we can use these with
  --~ -- confidence when filtering for the prototype
  --~ common.MUSK_FLOOR_walking_speed_modifier = 1.45
  --~ common.MUSK_FLOOR_decorative_removal_probability = 1

  ------------------------------------------------------------------------------------
  -- Enable writing to log file until startup options are set, so debugging output
  -- from the start of a game session can be logged. This depends on a locally
  -- installed dummy mod to allow debugging output during development without
  -- spamming real users.

  ------------------------------------------------------------------------------------
  -- If the "_debug" dummy mod is active, debugging will always be on. If you don't
  -- have this dummy mod but want to turn on logging anyway, set the default value
  -- to "true"!
  local default = false

  common.is_debug = ( (mods and mods["_debug"]) or
                      (script and script.active_mods["_debug"])) and
                    true or default


  --------------------------------------------------------------------
  -- Output debugging text
  common.writeDebug = function(msg, tab, print_line)
    local args = {}
    -- Use serpent.line instead of serpent.block if this is true!
    local line = print_line and
                  (string.lower(print_line) == "line" or string.lower(print_line) == "l") and
                  true or false

    if common.is_debug then
      if type(tab) ~= "table" then
        tab = { tab }
      end
      local v
      for k = 1, #tab do
        v = tab[k]
        -- NIL
        if v == nil then
          args[#args + 1] = "NIL"
        -- TABLE
        elseif type(v) == "table" then
          args[#args + 1] = line and serpent.line(table.deepcopy(v)) or
                                      serpent.block(table.deepcopy(v))
        -- OTHER VALUE
        else
          args[#args + 1] = v
        end
      end
      if #args == 0 then
        args[1] = "nil"
      end
      args.n = #args
      if common.is_debug then
        log(string.format(tostring(msg), table.unpack(args)))

        if game then
          game.print(string.format(tostring(msg), table.unpack(args)))
        end
      end
    end
  end

  -- Simple helper to show values
  common.show = function(desc, term)
    if common.is_debug then
      common.writeDebug(tostring(desc) .. ": %s", type(term) == "table" and { term } or term)
    end
  end

  -- Print "entityname (id)"
  common.print_name_id = function(entity)
    local id
    local name = "unknown entity"

    if entity and entity.valid then
    -- Stickers don't have an index or unit_number!
      id =  (entity.type == "sticker" and entity.type) or
            entity.unit_number or entity.type

      name = entity.name
    end

    --~ return name .. " (" .. tostring(id) .. ")"
    return string.format("%s (%s)", name, id)
  end

  -- Print "entityname"
  common.print_name = function(entity)
    return entity and entity.valid and entity.name or ""
  end

    ------------------------------------------------------------------------------------
    -- Are tiles from Alien Biomes available? (Returns true or false)
    common.AB_tiles = function()

      local ret = false

      if game then
        local AB = game.item_prototypes["fertilizer"].place_as_tile_result.result.name
        -- In data stage, place_as_tile is only changed to Alien Biomes tiles if
        -- both "vegetation-green-grass-1" and "vegetation-green-grass-3" exist. Therefore,
        -- we only need to check for one tile in the control stage.
        ret = (AB == "vegetation-green-grass-3") and true or false
      else
        ret = data.raw.tile["vegetation-green-grass-1"] and
              data.raw.tile["vegetation-green-grass-3"] and true or false
      end

      return ret
    end


    ------------------------------------------------------------------------------------
    -- Greatly improved version check for mods (thanks to eradicator!)
    common.Version = {}
    do
      local V = common.Version

      local function parse_version(vstr) -- string "Major.Minor.Patch"
        local err = function()
          error('Invalid Version String: <' .. tostring(vstr) .. '>')
        end
        local r = {vstr:match('^(%d+)%.(%d+)%.(%d+)$')}

        if #r ~= 3 then
          err()
        end

        for i=1, 3 do
          r[i] = tonumber(r[i])
        end

        return r
      end

      V.gtr = function(verA, verB)
        local a, b, c = unpack(parse_version(verA))
        local x, y, z = unpack(parse_version(verB))
        return (a > x) or (a == x and b > y) or (a == x and b == y and c > z)
      end
      local map = {
        ['=' ] = function(A, B) return not (V.gtr(A, B)   or V.gtr(B, A)) end,
        ['>' ] = V.gtr,
        ['!='] = function(A, B) return (V.gtr(A, B)       or V.gtr(B, A)) end,
        ['<='] = function(A, B) return V.gtr(B, A)        or (not V.gtr(A, B)) end,
        ['>='] = function(A, B) return V.gtr(A, B)        or (not V.gtr(B, A)) end,
        ['~='] = function(A, B) return (V.gtr(A, B)       or V.gtr(B, A)) end,
        ['<' ] = function(A, B) return V.gtr(B, A) end,
      }

      --~ common.Version.compare = function(mod_name, operator, need_version)
      common.check_version = function(mod_name, operator, need_version)
common.writeDebug("modname: %s\toperator: %s\tneeded version: %s", {mod_name, operator, need_version})
        --~ local mod_version = script and script.active_mods[mod_name] or
                             --~ game and game.active_mods[mod_name]
        local mod_version = (mods and mods[mod_name]) or (script and script.active_mods[mod_name])
        return map[operator](mod_version, need_version)
      end
    end

    -- Function for removing all parts of compound entities
    common.remove_entity = function(entity)
      if entity and entity.valid then
        entity.destroy()
      end
    end


    -- Function to normalize positions
    common.normalize_position = function(pos)
      if pos and type(pos) == "table" and table_size(pos) == 2 then
        local x = pos.x or pos[1]
        local y = pos.y or pos[2]
        if x and y and type(x) == "number" and type(y) == "number" then
          return { x = x, y = y }
        end
      end
    end


    -- Check if argument is a valid surface
    common.is_surface = function(surface)
      local t = type(surface)
      surface = (t == "number" or t == "string" and game.surfaces[surface]) or
                (t == "table" and surface.object_name and
                                  surface.object_name == "LuaSurface" and surface)
      return surface
    end


    -- Throw an error if a wrong argument has been passed to a function
    common.arg_err = function(arg, arg_type)
      error(string.format(
          "Wrong argument! %s is not %s!",
          (arg or "nil"), (arg_type and "a valid " .. arg_type or "valid")
        )
      )
    end

    -- Rudimentary check of the arguments passed to a function
    common.check_args = function(arg, arg_type, desc)
      if not (arg and type(arg) == arg_type) then
        common.arg_err(arg or "nil", desc or arg_type or "nil")
      end
    end
------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
return common
end
