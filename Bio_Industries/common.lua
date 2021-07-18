log("Entered file " .. debug.getinfo(1).source)
require("util")

local compound_entities = require("prototypes.compound_entities.main_list")

return function(mod_name)
  local common = {}

  ------------------------------------------------------------------------------------
  -- Get mod name and path to mod
  common.modName = script and script.mod_name or mod_name
  common.modRoot = "__" .. common.modName .. "__"

  ------------------------------------------------------------------------------------
  -- Get the value of a startup setting
  common.get_startup_setting = function(setting_name)
    return settings and settings.startup[setting_name] and settings.startup[setting_name].value
  end

  ------------------------------------------------------------------------------------
  -- Get values of all startup settings
  common.get_startup_settings = function()
    for var, name in pairs({
      BI_Bio_Fuel                               = "BI_Bio_Fuel",
      BI_Bio_Garden                             = "BI_Bio_Garden",
      BI_Coal_Processing                        = "BI_Coal_Processing",
      BI_Darts                                  = "BI_Darts",
      BI_Disassemble                            = "BI_Disassemble",
      BI_Explosive_Planting                     = "BI_Explosive_Planting",
      BI_Rails                                  = "BI_Rails",
      BI_Rubber                                 = "BI_Rubber",
      BI_Pollution_Detector                     = "BI_Pollution_Detector",
      BI_Power_Production                       = "BI_Power_Production",
      BI_Stone_Crushing                         = "BI_Stone_Crushing",
      BI_Terraforming                           = "BI_Terraforming",
      BI_Wood_Gasification                      = "BI_Wood_Gasification",
      BI_Wood_Products                          = "BI_Wood_Products",
      Bio_Cannon                                = "BI_Bio_Cannon",
      BI_Game_Tweaks_Bot                        = "BI_Game_Tweaks_Bot",
      BI_Game_Tweaks_Easy_Bio_Gardens           = "BI_Game_Tweaks_Easy_Bio_Gardens",
      BI_Game_Tweaks_Emissions_Multiplier       = "BI_Game_Tweaks_Emissions_Multiplier",
      BI_Game_Tweaks_Fuel_Values                = "BI_Game_Tweaks_Fuel_Values",
      BI_Game_Tweaks_Player                     = "BI_Game_Tweaks_Player",
      BI_Game_Tweaks_Production_Science         = "BI_Game_Tweaks_Production_Science",
      BI_Game_Tweaks_Recipe                     = "BI_Game_Tweaks_Recipe",
      BI_Game_Tweaks_Small_Tree_Collisionbox    = "BI_Game_Tweaks_Small_Tree_Collisionbox",
      BI_Game_Tweaks_Stack_Size                 = "BI_Game_Tweaks_Stack_Size",
      BI_Game_Tweaks_Tree                       = "BI_Game_Tweaks_Tree",
      BI_Debug_To_Game                          = "BI_Debug_To_Game",
      BI_Debug_To_Log                           = "BI_Debug_To_Log",
    }) do
      BI.Settings[var] = common.get_startup_setting(name)
    end
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
      local mod_version = (mods and mods[mod_name]) or (script and script.active_mods[mod_name])
      return map[operator](mod_version, need_version)
    end
  end


  ------------------------------------------------------------------------------------
  -- List of compound entities
  -- Key:       name of the base entity
  -- tab:       name of the global table where data of these entity are stored
  -- hidden:    table containing the hidden entities needed by this entity
  --            (Key:   name under which the hidden entity will be stored in the table;
  --             Value: name of the entity that should be placed)
  common.compound_entities = compound_entities.get_HE_list("complete")
log("compound entities: " .. serpent.block(common.compound_entities))

  -- Map the short handles of hidden entities (e.g. "pole") to real prototype types
  -- (e.g. "electric-pole")
  common.HE_map = compound_entities.HE_map

  -- Reverse lookup
  common.HE_map_reverse = compound_entities.HE_map_reverse

  -- We can't store Musk floor with the compound_entities because it has no unit_number
  -- but must be identified by its position. So let's store the names of its hidden
  -- entities so we can use them later on!
  common.musk_floor_pole_name = "bi-musk-mat-hidden-pole"
  common.musk_floor_panel_name = "bi-musk-mat-hidden-panel"

  -- Pollution sensors are no compound entity, so we better store it's name here for
  -- referencing it during prototype creation and in the control script.
  common.pollution_sensor_name = "bi-pollution-sensor"
  common.pollution_sensor_type = "constant-combinator"

  ------------------------------------------------------------------------------------
  -- There may be trees for which we don't want to create variations. These patterns
  -- are used to build a list of trees we want to ignore.
  common.tree_ignore_name_patterns = {
    -- Ignore our own trees
    "bio%-tree%-.+%-%d",
    -- Tree prototypes created by "Robot Tree Farm" or "Tral's Robot Tree Farm"
    "rtf%-.+%-%d+",
    -- Tree prototypes created by "Industrial Revolution 2"
    ".*%-*ir2%-.+",
  }


  -- Get list of tree prototypes that we want to ignore
  common.get_tree_ignore_list = function()
    local ignore = {}
    local trees = game and
                    game.get_filtered_entity_prototypes({{filter = "type", type = "tree"}}) or
                    data.raw.tree
    for tree_name, tree in pairs(trees) do
      for p, pattern in ipairs(common.tree_ignore_name_patterns) do
        if tree_name:match(pattern) then
          ignore[tree_name] = true
          break
        end
      end
    end
    return ignore
  end



  ------------------------------------------------------------------------------------
  -- Enable writing to log file until startup options are set, so debugging output
  -- from the start of a game session can be logged. This depends on a locally
  -- installed dummy mod to allow debugging output during development without
  -- spamming real users.
  -- If the "_debug" dummy mod is active, debugging will always be on. If you don't
  -- have this dummy mod but want to turn on logging anyway, set the default value
  -- to "true"!
  local default = false
  --~ local default = true

  common.debug_to_log   = common.get_startup_setting("BI_Debug_To_Log") or
                          (mods and mods["_debug"] and true) or
                          (script and script.active_mods["_debug"] and true) or
                          default
  common.debug_to_game  = common.get_startup_setting("BI_Debug_To_Game") or
                          --~ (mods and mods["_debug"] and true) or
                          --~ (script and script.active_mods["_debug"] and true) or
                          default

  common.is_debug       = common.debug_to_log or common.debug_to_game

  ------------------------------------------------------------------------------------
  --                               DEBUGGING FUNCTIONS                              --
  ------------------------------------------------------------------------------------



  ------------------------------------------------------------------------------------
  -- Output arguments a function was called with
  common.argprint = function(arg)
    -- Debugging is off
    --~ if not (common.debug_in_log or common.debug_in_game) then
    if not common.is_debug then
      return "nil"
    -- No argument
    elseif not arg then
      return "nil"
    -- Argument was player.index or vehicle.unit_number
    elseif type(arg) == "number" then
      return tostring(arg)
    -- Argument was player entity (Check for a function before calling it!)
    elseif type(arg) == "table" and arg.valid and arg.object_name == "LuaPlayer" then
      return "player " .. tostring(arg.index) .. " (\"" .. arg.name .. "\")"
    -- Argument was an entity
    elseif type(arg) == "table" and arg.object_name == "LuaEntity" and arg.valid then
      return arg.type .. " \"" .. arg.name .. "\" (" .. tostring(arg.unit_number) .. ")"
    -- Argument was a recipe
    elseif type(arg) == "table" and arg.object_name == "LuaRecipe" and arg.valid then
      return arg.type .. " \"" .. arg.name .. "\""
    -- Argument was something else
    else
      return serpent.line(arg)
    end
  end



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

      -- Print the message text to log
      if common.debug_to_log then
        log(string.format(tostring(msg), table.unpack(args)))
      end

      -- Print the message text to the game
      if game and common.debug_to_game then
        game.print(string.format(tostring(msg), table.unpack(args)))
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
    return string.format("%s (%s)", name, id or "nil")
  end

  ------------------------------------------------------------------------------------
  -- Print "entityname"
  common.print_name = function(entity)
    return entity and entity.valid and entity.name or ""
  end

  ------------------------------------------------------------------------------------
  -- Print message if something has been created
  -- proto:     Prototype that has been changed
  common.created_msg = function(proto)
    local proto_name = proto and proto.name or common.arg_err(proto)
    local proto_type = proto and proto.type or common.arg_err(proto)

    common.writeDebug("Created %s \"%s\".", {proto_type, proto_name})
  end

  ------------------------------------------------------------------------------------
  -- Print message if data for additional prototype have been read
  -- data:      Prototype data
  -- list:      List of the subtables that in data that we must check
  -- name:      Name of the thing that has been changed
  -- list_name: The type of list (settings, triggers etc.)
  common.readdata_msg = function(data, list, name, list_name)
    local read_data = false

    if list then
      for t, tab in pairs(list) do
        if next(data[tab]) then
          read_data = true
          break
        end
      end
    elseif next(data) then
      read_data = true
    end

    if read_data then
      common.writeDebug("Read data for %s%s.", {name, list_name and " (" .. list_name .. ")" or ""})
    else
      common.writeDebug("No data for %s read.", {name})
    end
  end


  ------------------------------------------------------------------------------------
  -- Print message if something has been modified
  -- desc:      Description of the changed thing (e.g. "ingredients", "localization")
  -- proto:     Prototype that has been changed
  -- mode:      What happened to the prototype (e.g. "Changed", "Replaced")
  common.modified_msg = function(desc, proto, mode)
    common.check_args(desc, "string")

    local proto_name = proto and proto.name or common.arg_err(proto)
    local proto_type = proto and proto.type or common.arg_err(proto)

    mode = (type(mode) == "string") and mode or "Changed"
    local preposition = (mode:lower() == "added") and "to" or
                          (mode:lower() == "removed") and "from" or
                          "of"
    common.writeDebug("%s %s %s %s \"%s\".", {mode, desc, preposition, proto_type, proto_name})
  end


  ------------------------------------------------------------------------------------
  --   Function to print info when a file/function/event script is entered or left  --
  ------------------------------------------------------------------------------------
  local function print_on_entered(data)
    if data then
      local args = data.args
      local leave = data.leave
      local bail_out = data.bail_out
      local file = data.file or {}
      local f_name = data.f_name or "NIL"
      local description = data.description
      local sep = data.sep
      local is_event = data.is_event
      local is_file = data.is_file

      local msg, format_string

      -- Function could have been called with short form function(leave, bail_out),
      -- so we must adjust the values of "args" and "leave"
      if args and type(args) ~= "table" and not leave then
        args = {}
        leave = true
      elseif not args then
        args = {}
      end

      -- Preserve nil/false (normal exit) and strings (reason for leaving early)
      if bail_out and type(bail_out) ~= "string" then
        bail_out = ""
      end

      -- Pretty-format the arguments
      local arg_list = ""
      for k, v in pairs(args) do
        arg_list = type(k) == "number" and
                    arg_list .. common.argprint(v) or
                    arg_list .. k .. " = " .. common.argprint(v)
        arg_list = next(args, k) and arg_list .. ", " or arg_list
      end

      -- Unlike function arguments, event data will be listed on their own line!
      if is_event and arg_list ~= "" then
        arg_list = "\nEvent data: " .. arg_list
      -- Files won't have any arguments!
      elseif is_file then
         arg_list = ""
      end

      local format_string =
        is_event and    "%s %s %s%s%s\n(%s: %s)" or
        is_file and     "%s %s %s%s%s" or
                        "%s %s %s(%s)%s\n(%s: %s)"

      msg = string.format(format_string,
              leave and "Leaving" or "Entered", description, f_name, arg_list,
              (bail_out and (bail_out ~= "" and " early: " .. bail_out or " early!") or ""),
              file.source, file.currentline
            )

      -- Output the formatted text
      common.writeDebug("\n%s\n%s\n%s\n", {sep, msg, sep})

    end
  end


 ------------------------------------------------------------------------------------
  -- File has been entered
  common.entered_file = function(leave, bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.is_debug then
      local sep = string.rep("*", 100)

      local f_name = debug.getinfo(2)
      f_name = f_name and f_name.source or "NIL"

      print_on_entered({
        leave = leave, bail_out = bail_out,
        f_name = f_name, description = "file", sep = sep,
        is_file = true
      })
    end
  end


  ------------------------------------------------------------------------------------
  -- Function has been entered
  common.entered_function = function(args, leave, bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.is_debug then

      local file = debug.getinfo(2)
      file = file and {source = file.source, currentline = file.currentline} or {}
      local f_name = debug.getinfo(2, "n").name or "NIL"
      local sep = string.rep("-", 100)

      print_on_entered({
        args = args, leave = leave, bail_out = bail_out,
        file = file, f_name = f_name, description = "function", sep = sep
      })
    end
  end


  ------------------------------------------------------------------------------------
  -- Function for a /command has been entered
  common.entered_command = function(args, leave, bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.is_debug then

      local file = debug.getinfo(2)
      local f_name = args and (args.name or args[1]) and util.table.deepcopy(args.name or args[1])
      local sep = string.rep(":", 100)

      file = file and {source = file.source, currentline = file.currentline} or {}

      -- If we have only args[1], that will be the command name. We don't want that!
      args = (args and args[1] and not next(args, 1)) and {} or util.table.deepcopy(args)
      args.name = nil

      print_on_entered({
          args = args, leave = leave, bail_out = bail_out,
          file = file, f_name = f_name, description = "function for command", sep = sep
      })
    end
  end


  ------------------------------------------------------------------------------------
  -- Event script has been entered
  common.entered_event = function(event, leave, bail_out)
--~ common.show("event", event)
--~ common.show("leave", leave)
--~ common.show("bail_out", bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.is_debug then

      local file = debug.getinfo(2)
      file = file and {source = file.source, currentline = file.currentline} or {}
      local sep = string.rep("=", 100)
      local args, f_name, event_data

      if event then
        f_name = event.name and common.event_names[event.name]
        args = util.table.deepcopy(event)
        args.name = nil
      end
      args = (args and next(args)) and args or {}

      print_on_entered({
        args = args, leave = leave, bail_out = bail_out,
        file = file, f_name = f_name or "unnamed event", description = "event script for", sep = sep,
        is_event = true
      })
    end
  end


  ------------------------------------------------------------------------------------
  -- File or function has been entered, but there's nothing to do
  common.nothing_to_do = function(sep)
    sep = string.rep(sep or "-", 100)

    local file = debug.getinfo(2)
    local function_name = debug.getinfo(2, "n").name
    local msg = function_name and
                  function_name .. "\n(" .. file.source .. ": " .. file.currentline .. ")" or
                  file.source
    common.writeDebug("\n%s\nNothing to do in %s\n%s\n", {sep, msg, sep})
  end


  ------------------------------------------------------------------------------------
  -- Throw an error if a wrong argument has been passed to a function
  common.arg_err = function(arg, arg_type)
    error(string.format(
      "Wrong argument! %s is not %s!",
      (arg or "nil"), (arg_type and "a valid " .. arg_type or "valid")
    ))
  end

  ------------------------------------------------------------------------------------
  -- Rudimentary check of the arguments passed to a function
  common.check_args = function(arg, arg_type, desc)
    if not (arg and type(arg) == arg_type) then
      common.arg_err(arg or "nil", desc or arg_type or "nil")
    end
    return true
  end


  ------------------------------------------------------------------------------------
  -- Check if a mod (or several mods, or any of several mods) is installed
  -- modlist: Name(s) of mod(s) we need to check (string or array of strings)
  -- mode:    Any ("or") or all ("and") mods in modlist must be active.
  common.check_mods = function(modlist, mode)
    --~ common.writeDebug("Entered function check_mods(%s, %s)",
                      --~ {modlist or "nil", mode or "nil"})
    modlist = type(modlist) == "string" and {modlist} or
              type(modlist) == "table" and modlist or
              common.arg_err(modlist or "nil", "string or array of strings")
    mode = mode and mode:lower() or "or"

    local active_mods = script and script.active_mods or mods
    local ret

    for m, mod_name in pairs(modlist) do
      -- We've found a required mod_name!
      if active_mods[mod_name] then
        ret = true
        -- If mode is "or", we've struck gold!
        if mode == "or" then
          if #modlist > 1 then
            common.writeDebug("Mod %s has been found and mode is \"or\". Return: %s", {mod_name, ret})
          end
          break
        end
      -- Mod is not active
      else
        -- If mode is "and", the test has failed!
        ret = false
        if mode == "and" then
          if #modlist > 1 then
            common.writeDebug("Mod %s isn't active and mode is \"and\". Return: %s", {mod_name, ret})
          end
          break
        end
      end
    end
    return ret
  end


  ------------------------------------------------------------------------------------
  --                                  MOD SPECIFIC                                  --
  ------------------------------------------------------------------------------------

  ------------------------------------------------------------------------------------
  -- Are tiles from Alien Biomes available? (Returns true or false)
  common.AB_tiles = function()

    local ret

    if game then
      -- In data stage, place_as_tile is only changed to Alien Biomes tiles if
      -- both "vegetation-green-grass-1" and "vegetation-green-grass-3" exist. Therefore,
      -- we only need to check for one tile in the control stage.
      ret = game.tile_prototypes["vegetation-green-grass-1"] and true or false
    elseif data then
      ret = data.raw.tile["vegetation-green-grass-1"] and
            data.raw.tile["vegetation-green-grass-3"] and true or false
    end

    return ret
  end

  --~ ------------------------------------------------------------------------------------
  --~ -- Function for removing individual entities
  --~ common.remove_entity = function(entity)
    --~ if entity and entity.valid then
      --~ entity.destroy{raise_destroy = true}
    --~ end
  --~ end

  ------------------------------------------------------------------------------------
  -- Function for removing invalid prototypes from list of compound entities
  common.rebuild_compound_entity_list = function()
    common.entered_function()

    local ret = {}

    local base_prototype, h_prototype, base_name, base_type

    for c_name, c_data in pairs(common.compound_entities) do
common.show("base_name", c_name)
common.show("data", c_data)
      -- Is the base entity in the game? (Data and control stage!)
      base_name = c_data.base and c_data.base.name
      base_type = c_data.base and c_data.base.type

      base_prototype = game and game.entity_prototypes[base_name] or
                        data and base_type and base_name and
                        data.raw[base_type] and data.raw[base_type][base_name]
      if base_prototype then
        -- Make a copy of the compound-entity data
        common.writeDebug("%s exists -- copying data", {c_name})
        ret[c_name] = util.table.deepcopy(c_data)

        -- Check hidden entities
        for h_key, h_data in pairs(ret[c_name].hidden) do
common.writeDebug("h_key: %s\th_data: %s", {h_key, h_data})
          --~ -- Remove hidden entity if it doesn't exist
          --~ if game and not game.entity_prototypes[h_data.name] then
            --~ common.writeDebug("Removing %s (%s) from list of hidden entities!", {h_data.name, h_key})
            --~ ret[c_name].hidden[h_key] = nil
          --~ end
          -- Control stage only
          if game then
            h_prototype = game.entity_prototypes[h_data.name]

            -- Remove hidden entities that don't exist from table
            if not h_prototype then
              common.writeDebug("Removing %s (%s) from list of hidden entities!", {h_data.name, h_key})
              ret[c_name].hidden[h_key] = nil
            -- If the hidden entity is an electric pole, store its wire reach!
            elseif h_data.type == "electric-pole" then
              ret[c_name].hidden[h_key].max_wire_distance = h_prototype.max_wire_distance
              common.writeDebug("Added wire_reach to data of %s (%s): %s",
                                {h_data.name, h_key, h_prototype.max_wire_distance})
              if h_prototype.max_circuit_wire_distance > 0 then
                ret[c_name].hidden[h_key].max_circuit_wire_distance = h_prototype.max_circuit_wire_distance
                common.writeDebug("Added circuit wire_reach to data of %s (%s): %s",
                                  {h_data.name, h_key, h_prototype.max_circuit_wire_distance})
              end
            end
          end
        end

      -- Clean table (Control stage only!)
      elseif game then
        local tab = c_data.tab
        if tab then
          -- Remove main table from global
          common.writeDebug("Removing %s (%s obsolete entries)", {tab, #tab})
          global[tab] = nil
        end

        -- If this compound entity requires additional tables in global, remove them!
        local related_tables = c_data.add_global_tables
common.show("related_tables", related_tables)
        if related_tables then
          for t, tab in ipairs(related_tables or {}) do
            common.writeDebug("Removing global[%s] (%s values)",
                              {tab, table_size(global[tab] or {})})
            global[tab] = nil
          end
        end

        -- If this compound entity requires additional values in global, remove them!
        local related_vars = c_data.add_global_values
        if related_vars then
          for var_name, value in pairs(related_vars or {}) do
            common.writeDebug("Removing global[%s] (was: %s)",
                              {var_name, global[var_name] or "nil"})
            global[var_name] = nil
          end
        end
      end
    end
    common.show("ret", ret)
    common.entered_function("leave")
    return ret
  end



------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
  log("Leaving file " .. debug.getinfo(1).source)

  return common
end
