require("util")
return function (mod_name)
  local common = {}

  ------------------------------------------------------------------------------------
  -- Get mod name and path to mod
  common.modName = mod_name
  common.modRoot = "__" .. mod_name .. "__"


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
      local mod_version = (mods and mods[mod_name]) or (script and script.active_mods[mod_name])
      return map[operator](mod_version, need_version)
    end
  end

  ------------------------------------------------------------------------------------
  -- Sane values for collision masks
  -- Default: {"item-layer", "object-layer", "rail-layer", "floor-layer", "water-tile"}
  --~ common.RAIL_BRIDGE_MASK = {"floor-layer", "object-layer", "consider-tile-transitions"}
  common.RAIL_BRIDGE_MASK = {"object-layer", "consider-tile-transitions"}

  -- "Transport Drones" removes "object-layer" from rails, so if bridges have only
  -- {"object-layer"}, there collision mask will be empty, and they can be built even
  -- over cliffs. So we need to add another layer to bridges ("floor-layer").
  -- As of Factorio 1.1.0, rails need to have "rail-layer" in their mask. This will work
  -- alright, but isn't available in earlier versions of Factorio, so we will use
  -- "floor-layer" there instead.
  local need = common.check_version("base", ">=", "1.1.0") and "rail-layer" or "floor-layer"
  table.insert(common.RAIL_BRIDGE_MASK, need)

  -- Rails use basically the same mask as rail bridges, ...
  common.RAIL_MASK = util.table.deepcopy(common.RAIL_BRIDGE_MASK)
  -- ... we just need to add some layers so our rails have the same mask as vanilla rails.
  table.insert(common.RAIL_MASK, "item-layer")
  table.insert(common.RAIL_MASK, "water-tile")
log("common.RAIL_BRIDGE_MASK: " .. serpent.block(common.RAIL_BRIDGE_MASK))
log("common.RAIL_MASK: " .. serpent.block(common.RAIL_MASK))



  ------------------------------------------------------------------------------------
  -- Set maximum_wire_distance of Power-to-rail connectors
  common.POWER_TO_RAIL_WIRE_DISTANCE = 4

  ------------------------------------------------------------------------------------
  -- There may be trees for which we don't want to create variations. These patterns
  -- are used to build a list of trees we want to ignore.
  common.ignore_name_patterns = {
    -- Ignore our own trees
    "bio%-tree%-.+%-%d",
    -- Tree prototypes created by "Robot Tree Farm" or "Tral's Robot Tree Farm"
    "rtf%-.+%-%d+",
  }


  -- Get list of tree prototypes that we want to ignore
  common.get_tree_ignore_list = function()
  --~ log("Entered function get_tree_ignore_list!")
    local ignore = {}
    local trees = game and
                    game.get_filtered_entity_prototypes({{filter = "type", type = "tree"}}) or
                    data.raw.tree
    for tree_name, tree in pairs(trees) do
--~ log("tree_name: " .. tree_name)
      for p, pattern in ipairs(common.ignore_name_patterns) do
--~ log("Check for match against pattern " .. pattern)
        if tree_name:match(pattern) then
--~ log("Pattern matches!")
          ignore[tree_name] = true
          break
        end
      end
    end
    --~ log("Tree ignore list (" .. table_size(ignore) .. "): " .. serpent.block(ignore))
    return ignore
  end


  -- 0.17.42/0.18.09 fixed a bug where musk floor was created for the force "enemy".
  -- Because it didn't belong to any player, in map view the electric grid overlay wasn't
  -- shown for musk floor. Somebody complained about seeing it now, so starting with version
  -- 0.17.45/0.18.13, there is a setting to hide the overlay again. If it is set to "true",
  -- a new force will be created that the hidden electric poles of musk floor belong to.
  -- (UPDATE: 0.18.29 reversed the setting -- if active, tiles will now be visible in map
  -- view, not hidden. The definition of UseMuskForce has been changed accordingly.)
  common.MuskForceName = "BI-Musk_floor_general_owner"
  common.UseMuskForce = not settings.startup["BI_Show_musk_floor_in_mapview"].value

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
  -- If the "_debug" dummy mod is active, debugging will always be on. If you don't
  -- have this dummy mod but want to turn on logging anyway, set the default value
  -- to "true"!
  local default = false

  common.is_debug = ( (mods and mods["_debug"]) or
                      (script and script.active_mods["_debug"])) and
                    true or default


  ------------------------------------------------------------------------------------
  --                               DEBUGGING FUNCTIONS                              --
  ------------------------------------------------------------------------------------


  ------------------------------------------------------------------------------------
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

  ------------------------------------------------------------------------------------
  -- Simple helper to show a single value with descriptive text
  common.show = function(desc, term)
    if common.is_debug then
      common.writeDebug(tostring(desc) .. ": %s", type(term) == "table" and { term } or term)
    end
  end

  ------------------------------------------------------------------------------------
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

  ------------------------------------------------------------------------------------
  -- Print "entityname"
  common.print_name = function(entity)
    return entity and entity.valid and entity.name or ""
  end


  ------------------------------------------------------------------------------------
  -- Throw an error if a wrong argument has been passed to a function
  common.arg_err = function(arg, arg_type)
    error(string.format(
        "Wrong argument! %s is not %s!",
        (arg or "nil"), (arg_type and "a valid " .. arg_type or "valid")
      )
    )
  end

  ------------------------------------------------------------------------------------
  -- Rudimentary check of the arguments passed to a function
  common.check_args = function(arg, arg_type, desc)
    if not (arg and type(arg) == arg_type) then
      common.arg_err(arg or "nil", desc or arg_type or "nil")
    end
  end



  ------------------------------------------------------------------------------------
  --                                  MOD SPECIFIC                                  --
  ------------------------------------------------------------------------------------

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
  -- Function for removing all parts of compound entities
  common.remove_entity = function(entity)
    if entity and entity.valid then
      entity.destroy()
    end
  end


  ------------------------------------------------------------------------------------
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
  -- Check if argument is a valid surface
  common.is_surface = function(surface)
    local t = type(surface)
    surface = (t == "number" or t == "string" and game.surfaces[surface]) or
              (t == "table" and surface.object_name and
                                surface.object_name == "LuaSurface" and surface)
    return surface
  end


  ------------------------------------------------------------------------------------
  -- Make hidden entities unminable and indestructible
  local function make_unminable(entities)
    for e, entity in ipairs(entities or {}) do
      if entity.valid then
        entity.minable = false
        entity.destructible = false
      end
    end
  end

  --------------------------------------------------------------------
  -- Create and register hidden entities
  common.create_entities = function(g_table, base_entity, hidden_entity_names, position, ...)
    common.show("#g_table", g_table and table_size(g_table))
    common.show("hidden_entity_names", hidden_entity_names)

    common.check_args(g_table, "table")
    common.check_args(base_entity, "table")
    if not base_entity.valid then
      common.arg_err(base_entity, "base entity")
    elseif not next(hidden_entity_names) then
      common.arg_err(hidden_entity_names, "array of hidden-entity names")
    end
    local pos = common.normalize_position(position)
    if not pos then
      common.arg_err(position or "nil", "position")
    end

    local entity

    -- Initialize entry in global table
    g_table[base_entity.unit_number] = {}
    g_table[base_entity.unit_number].base = base_entity

    -- Create hidden entities
    for key, name in pairs(hidden_entity_names) do
      entity = base_entity.surface.create_entity({
        name = name,
        position = pos,
        force = base_entity.force,
        raise_built = true
      })

      -- Make hidden entity unminable/undestructible
      make_unminable({entity})

      -- Add hidden entity to global table
      g_table[base_entity.unit_number][key] = entity
    end

    -- Add optional values to global table
    for k, v in pairs(... or {}) do
      g_table[base_entity.unit_number][k] = v
    end
    common.writeDebug("g_table[base.unit_number]", g_table[base_entity.unit_number])
  end


  common.get_startup_setting = function(setting_name)
    return settings.startup[setting_name] and settings.startup[setting_name].value
  end

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
return common
end
