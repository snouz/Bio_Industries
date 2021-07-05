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

      common.is_debug = ((mods and mods["_debug"]) or
                         (script and script.active_mods["_debug"])) and true or default


    --~ --------------------------------------------------------------------
    --~ --- DeBug Messages
    --~ common.writeDebug = function (message)
      --~ if common.is_debug then
        --~ log(tostring(message))
        --~ if game then
          --~ game.print(tostring(message))
        --~ end
      --~ end
    --~ end

  -- Output debugging text
  common.writeDebug = function(msg, tab, ...)
    local args = {}
--~ log("msg: " .. msg .. "\ttab: " .. serpent.line(tab))
    -- Use serpent.line instead of serpent.block if this is true!
    local line = ... and
                  (string.lower(...) == "line" or string.lower(...) == "l") and
                  true or false

    if common.is_debug then
      if type(tab) ~= "table" then
        tab = { tab }
      end
--~ log("tab: " .. serpent.line(tab))
--~ log("table_size(tab): " .. table_size(tab) .. "\t#tab: " .. #tab)
      local v
      --~ for k in pairs(tab or {}) do
      for k = 1, #tab do
        v = tab[k]
--~ log("k: " .. k .. "\tv: " .. serpent.line(v))
        -- NIL
        if v == nil then
          args[#args + 1] = "NIL"
--~ log(serpent.line(args[#args]))
        -- TABLE
        elseif type(v) == "table" then
          --~ if table_size(v) == 0 then
            --~ args[#args + 1] = "{}"
            --~ args[#args + 1] = "EMPTY_TABLE"
          --~ else
            --~ args[#args + 1] = line and { [k] = serpent.line(v) } or { [k] = serpent.block(v) }
            --~ args[#args + 1] = line and serpent.line({ [k] = v }) or
                                        --~ serpent.block({ [k] = v })
          --~ end
          args[#args + 1] = line and serpent.line(table.deepcopy(v)) or
                                      serpent.block(table.deepcopy(v))
--~ log(serpent.line(args[#args]))
        -- OTHER VALUE
        else
          args[#args + 1] = v
--~ log(serpent.line(args[#args]))
        end
      end
      if #args == 0 then
        args[1] = "nil"
      end
      args.n = #args
--~ log("args: " .. serpent.block(args))
      if common.is_debug then
        log(string.format(tostring(msg), table.unpack(args)))
      end
      --~ if common.is_debug and game then
        --~ game.print(string.format(tostring(msg), table.unpack(args)))
      --~ end
    end
  end

  -- Simple helper to show values
  common.show = function(desc, term)
    if common.is_debug then
      --~ common.dprint(tostring(desc) .. ": %s", term or "NIL")
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
        local AB = game.item_prototypes["fertiliser"].place_as_tile_result.result.name
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
    -- Determine which version of Factorio is running. Based on this result, we can set
    -- icon sizes of vanilla icons correctly, thus making the same code usable for both
    -- Factorio versions using the old 32x32 icons, and for new versions with 64x64 icons.
    common.check_base_version = function(target)

      local F_version = util.split(mods["base"], '.')
      local required = util.split(target, '.')
      local ret

      for i = 1, 3 do
        F_version[i] = tonumber(F_version[i])
        required[i] = tonumber(required[i])
      end

      common.writeDebug("Factorio version: %s", {F_version}, "line")
      common.writeDebug("Required version: %s", {required}, "line")

      -- First number may not be smaller
      if F_version[1] < required[1] then
        --~ common.writeDebug("Major number is too small: %g < %g", {F_version[1], required[1]})
        ret = false
      -- First number is greater: Hit!
      elseif F_version[1] > required[1] then
        --~ common.writeDebug("Major number is greater: %g > %g", {F_version[1], required[1]})
        ret = true
      -- First number is same, second number is greater: Hit!
      elseif F_version[2] > required[2] then
        --~ common.writeDebug("Minor number is greater: %g > %g", {F_version[2], required[2]})
        ret = true
      -- First number is same, second number is same, third number is same or greater: Hit!
      elseif F_version[2] == required[2] and F_version[3] >= required[3] then
        --~ common.writeDebug("Least number is greater or equal: %g >= %g", {F_version[3], required[3]})
        ret = true
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
------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
return common
end
