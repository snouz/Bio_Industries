require("util")
local compound_entities = require("prototypes.compound_entities.main_list")

return function(mod_name)
  local common = {}

  ------------------------------------------------------------------------------------
  -- Get mod name and path to mod
  common.modName = script and script.mod_name or mod_name
  common.modRoot = "__" .. common.modName .. "__"


  common.graphicsmod = "__Bio_Industries_NE_graphics__"
  common.graphics = common.graphicsmod .. "/graphics"
  common.iconpath = common.graphics .. "/icons/"
  common.techiconpath = common.graphics .. "/technology/"
  common.entitypath = common.graphics .. "/entities/"

  common.soundpath = common.graphicsmod .. "/sound/"


  ------------------------------------------------------------------------------------
  -- Table with the difficulties we may need to check
  common.difficulties = {"", "normal", "expensive"}

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
  -- Sane values for collision masks
  -- Default: {"item-layer", "object-layer", "rail-layer", "floor-layer", "water-tile"}
  common.RAIL_BRIDGE_MASK = {"floor-layer", "object-layer", "consider-tile-transitions"}
  --~ common.RAIL_BRIDGE_MASK = {"object-layer", "consider-tile-transitions"}

  --~ -- "Transport Drones" removes "object-layer" from rails, so if bridges have only
  --~ -- {"object-layer"}, there collision mask will be empty, and they can be built even
  --~ -- over cliffs. So we need to add another layer to bridges ("floor-layer").
  --~ -- As of Factorio 1.1.0, rails need to have "rail-layer" in their mask. This will work
  --~ -- alright, but isn't available in earlier versions of Factorio, so we will use
  --~ -- "floor-layer" there instead.
  --~ local need = common.check_version("base", ">=", "1.1.0") and "rail-layer" or "floor-layer"
  --~ table.insert(common.RAIL_BRIDGE_MASK, need)
  --~ common.RAIL_BRIDGE_MASK = {"floor-layer", "object-layer", "consider-tile-transitions"}
  common.RAIL_BRIDGE_MASK = {"object-layer", "rail-layer", "consider-tile-transitions"}


  -- Rails use basically the same mask as rail bridges, ...
  common.RAIL_MASK = util.table.deepcopy(common.RAIL_BRIDGE_MASK)
  -- ... we just need to add some layers so our rails have the same mask as vanilla rails.
  table.insert(common.RAIL_MASK, "item-layer")
  table.insert(common.RAIL_MASK, "water-tile")
--~ log("common.RAIL_BRIDGE_MASK: " .. serpent.block(common.RAIL_BRIDGE_MASK))
--~ log("common.RAIL_MASK: " .. serpent.block(common.RAIL_MASK))



  ------------------------------------------------------------------------------------
  -- Set maximum_wire_distance of Power-to-rail connectors
  common.POWER_TO_RAIL_WIRE_DISTANCE = 4



  ------------------------------------------------------------------------------------
  -- List of compound entities
  -- Key:       name of the base entity
  -- tab:       name of the global table where data of these entity are stored
  -- hidden:    table containing the hidden entities needed by this entity
  --            (Key:   name under which the hidden entity will be stored in the table;
  --             Value: name of the entity that should be placed)
  common.compound_entities = compound_entities.get_HE_list("complete")
  --~ common.compound_entities = {}
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




  -- 0.17.42/0.18.09 fixed a bug where musk floor was created for the force "enemy".
  -- Because it didn't belong to any player, in map view the electric grid overlay wasn't
  -- shown for musk floor. Somebody complained about seeing it now, so starting with version
  -- 0.17.45/0.18.13, there is a setting to hide the overlay again. If it is set to "true",
  -- a new force will be created that the hidden electric poles of musk floor belong to.
  -- (UPDATE: 0.18.29 reversed the setting -- if active, tiles will now be visible in map
  -- view, not hidden. The definition of UseMuskForce has been changed accordingly.)
  -- (UPDATE: In 1.2.0, Musk floor will be dependent on the setting "Power production", so
  -- we only need to create this force if the setting is on!)
  common.MuskForceName = "BI-Musk_floor_general_owner"
  --~ common.UseMuskForce = not settings.startup["BI_Game_Tweaks_Show_musk_floor_in_mapview"].value
  common.UseMuskForce = common.get_startup_setting("BI_Power_Production") and
                        not common.get_startup_setting("BI_Game_Tweaks_Show_musk_floor_in_mapview")

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
  --~ local default = true

  common.debug_to_log   = common.get_startup_setting("BI_Debug_To_Log") or
                          (mods and mods["_debug"] and true) or
                          (script and script.active_mods["_debug"] and true) or
                          default
--~ log(string.format("BI_Debug_To_Log: %s", tostring(common.get_startup_setting("BI_Debug_To_Log"))))
--~ log(string.format("common.debug_to_log: %s", tostring(common.debug_to_log)))
  common.debug_to_game  = common.get_startup_setting("BI_Debug_To_Game") or
                          --~ (mods and mods["_debug"] and true) or
                          --~ (script and script.active_mods["_debug"] and true) or
                          default
--~ log(string.format("BI_Debug_To_Game: %s", tostring(common.get_startup_setting("BI_Debug_To_Game"))))
--~ log(string.format("common.debug_to_game: %s", tostring(common.debug_to_game)))

  common.is_debug       = common.debug_to_log or common.debug_to_game
  --~ common.is_debug       = false
--~ log(string.format("common.is_debug: %s", tostring(common.is_debug)))

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


  --~ ------------------------------------------------------------------------------------
  --~ -- Print message if something has been removed
  --~ -- proto:         Prototype that has been changed
  --~ -- desc:  What has the prototype been removed from?
  --~ common.removed_msg = function(proto, desc)
    --~ local proto_name = proto and proto.name or common.arg_err(proto)
    --~ local proto_type = proto and proto.type or common.arg_err(proto)

    --~ local desc_name = desc and desc.name and " \"" .. desc_name .. "\"" or ""
    --~ local desc_type = desc and desc.type and " \"" .. desc_type .. "\"" or ""
    --~ local desc_string = desc and string.format("%s%s%s",
                                                  --~ desc_type or desc_name and " from",
                                                  --~ desc_type, desc_name
                                                --~ )

    --~ common.writeDebug("Removed %s \"%s\"%s.", {proto_type, proto_name, desc_string})
  --~ end

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


  --~ ------------------------------------------------------------------------------------
  --~ -- File has been entered
  --~ common.entered_file = function(leave)
    -- local sep = string.rep("*", 100) .. "\n" .. string.rep("*", 100)
    --~ local sep = string.rep("*", 100)
    --~ local prefix = leave and "Leaving" or "Entered"
    --~ print_on_entered(prefix .. " file " .. debug.getinfo(2).source .. "!", sep)
  --~ end


  --~ ------------------------------------------------------------------------------------
  --~ -- Function has been entered
  --~ common.entered_function = function(leave)
    --~ local file = debug.getinfo(2)
    --~ local function_name = debug.getinfo(2, "n").name or "NIL"
    -- local sep = string.rep("-", 100) .. "\n" .. string.rep("-", 100)
    --~ local sep = string.rep("-", 100)
    --~ local prefix = leave and "Leaving" or "Entered"

    --~ print_on_entered(prefix .. " function " .. function_name .. "\n" ..
                    --~ "(" .. file.source .. ": " .. file.currentline ..")", sep)
  --~ end


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


  --~ ------------------------------------------------------------------------------------
  --~ -- File or function has been entered, but there's nothing to do
  common.nothing_to_do = function(sep)
    sep = string.rep(sep or "-", 100)

    local file = debug.getinfo(2)
    local function_name = debug.getinfo(2, "n").name
    local msg = function_name and
                  function_name .. "\n(" .. file.source .. ": " .. file.currentline .. ")" or
                  file.source
    --~ print_on_entered("Nothing to do in " .. msg, sep)
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
    --~ common.show("Return", ret)
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
      --~ local AB = game.tile_prototypes["vegetation-green-grass-1"] and
                  --~ game.item_prototypes["fertilizer"].place_as_tile_result
--~ BioInd.show("Tiles from Alien Biomes", game.tile_prototypes["vegetation-green-grass-1"])
--~ BioInd.show("AB", AB)
      --~ AB = AB and AB.result and AB.result.name
      -- In data stage, place_as_tile is only changed to Alien Biomes tiles if
      -- both "vegetation-green-grass-1" and "vegetation-green-grass-3" exist. Therefore,
      -- we only need to check for one tile in the control stage.
      ret = game.tile_prototypes["vegetation-green-grass-1"] and true or false
    else --if data then
      ret = data.raw.tile["vegetation-green-grass-1"] and
            data.raw.tile["vegetation-green-grass-3"] and true or false
    end

    return ret
  end

  ------------------------------------------------------------------------------------
  -- Function for removing individual entities
  common.remove_entity = function(entity)
    if entity and entity.valid then
      entity.destroy{raise_destroy = true}
    end
  end

  --~ ------------------------------------------------------------------------------------
  --~ -- Function for removing invalid prototypes from list of compound entities
  --~ common.rebuild_compound_entity_list = function()
    --~ local f_name = "rebuild_compound_entity_list"
    --~ common.writeDebug("Entered function %s()", {f_name})

    --~ local ret = {}
    --~ local h_type

    --~ for c_name, c_data in pairs(common.compound_entities) do
--~ common.show("base_name", c_name)
--~ common.show("data", c_data)
      --~ -- Is the base entity in the game?
      --~ if c_data.base and c_data.base.name and game.entity_prototypes[c_data.base.name] then
        --~ -- Make a copy of the compound-entity data
        --~ common.writeDebug("%s exists -- copying data", {c_name})
        --~ ret[c_name] = util.table.deepcopy(c_data)

        --~ -- Check hidden entities
        --~ for h_key, h_data in pairs(ret[c_name].hidden) do
          --  h_type = common.HE_map[h_key]
--~ common.writeDebug("h_key: %s\th_data: %s", {h_key, h_data})
          --~ -- Remove hidden entity if it doesn't exist
          --~ if not game.entity_prototypes[h_data.name] then
            --~ common.writeDebug("Removing %s (%s) from list of hidden entities!", {h_data.name, h_key})
            --~ ret[c_name].hidden[h_key] = nil
          --~ end
        --~ end

      --~ -- Clean table
      --~ else
        --~ local tab = c_data.tab
        --~ if tab then
          --~ -- Remove main table from global
          --~ common.writeDebug("Removing %s (%s obsolete entries)", {tab, #tab})
          --~ global[tab] = nil
        --~ end

        --~ -- If this compound entity requires additional tables in global, remove them!
        --~ local related_tables = c_data.add_global_tables
        --~ if related_tables then
          --~ for t, tab in ipairs(related_tables or {}) do
            --~ common.writeDebug("Removing global[%s] (%s values)", {tab, table_size(global[tab])})
            --~ global[tab] = nil
          --~ end
        --~ end

        --~ -- If this compound entity requires additional values in global, remove them!
        --~ local related_vars = c_data.add_global_values
        --~ if related_vars then
          --~ for var_name, value in pairs(related_vars or {}) do
            --~ common.writeDebug("Removing global[%s] (was: %s)",
                              --~ {var_name, global[var_name] or "nil"})
            --~ global[var_name] = nil
          --~ end
        --~ end
      --~ end
    --~ end
    --~ common.show("ret", ret)
    --~ return ret
  --~ end

  ------------------------------------------------------------------------------------
  -- Function for removing invalid prototypes from list of compound entities
  common.rebuild_compound_entity_list = function()
    --~ local f_name = "rebuild_compound_entity_list"
    --~ common.writeDebug("Entered function %s()", {f_name})
    common.entered_function()

    local ret = {}
    local h_type

    local base_prototype, base_name, base_type

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
          --~ h_type = common.HE_map[h_key]
common.writeDebug("h_key: %s\th_data: %s", {h_key, h_data})
          -- Remove hidden entity if it doesn't exist
          if game and not game.entity_prototypes[h_data.name] then
            common.writeDebug("Removing %s (%s) from list of hidden entities!", {h_data.name, h_key})
            ret[c_name].hidden[h_key] = nil
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
  -- Function to add all optional values for a compound entity to the table entry.
  common.add_optional_data = function(base)
    --~ local f_name = "add_optional_data"
--~ common.writeDebug("Entered function %s(%s)", {f_name, common.print_name_id(base)})
    common.entered_function()

    if not (base and base.valid and global.compound_entities[base.name]) then
      common.arg_err(base, "base of a compound entity")
    end

    -- Add optional values to global table
    local data = global.compound_entities[base.name]
common.show("data", data)
    local tab = data.tab
common.show("tab", tab)
common.show("global[tab]", global[tab] or "nil")

    local entry = global[tab][base.unit_number]

    for k, v in pairs(data.optional or {}) do
      if entry[k] then
        common.writeDebug("%s already exists: %s", {k, entry[k]})
      else
        entry[k] = v
        common.writeDebug("Added data to %s: %s = %s", {common.print_name_id(base), k, v})
      end
    end
    common.entered_function("leave")
  end


  ------------------------------------------------------------------------------------
  -- Function for removing all parts of invalid compound entities
  common.clean_global_compounds_table = function(entity_name)
    common.entered_function()
    --~ local f_name = "clean_table"
--~ common.writeDebug("Entered function %s(%s)", {f_name, entity_name or "nil"})
common.writeDebug("Entries in common.compound_entities[%s]: %s", {entity_name, table_size(global.compound_entities[entity_name])})

    --~ local entity_table = global[common.compound_entities[entity_name].tab]
    --~ local hidden_entities = common.compound_entities[entity_name].hidden
    local entity_table = global.compound_entities[entity_name]
common.show("entity_table", entity_table and entity_table.tab)
    entity_table = entity_table and entity_table.tab and global[entity_table.tab]
common.writeDebug("entity_table: %s", {entity_table}, "line")
    local hidden_entities = global.compound_entities[entity_name].hidden
common.show("hidden_entities", hidden_entities)
    local removed = 0
    -- Scan the whole table
    for c, compound in pairs(entity_table) do
common.writeDebug ("c: %s\tcompound: %s", {c, compound})
      -- No or invalid base entity!
      if not (compound.base and compound.base.valid) then
common.writeDebug("%s (%s) has no valid base entity -- removing entry!", {entity_name, c})

        for h_name, h_entity in pairs(hidden_entities) do
common.writeDebug("Removing %s (%s)", {h_name, h_entity.name})
          common.remove_entity(compound[h_name])
        end
        entity_table[c] = nil
        removed = removed + 1
common.writeDebug("Removed %s %s", {entity_name, c})
      end
    end
common.show("Removed entities", removed)
common.show("Pruned list size", table_size(entity_table))
--~ common.show("Pruned list", entity_table)
    common.entered_function("leave")
    return removed
  end


  ------------------------------------------------------------------------------------
  -- Function to resore missing parts of compound entities
  common.restore_missing_entities = function(entity_name)
    common.entered_function()
    --~ local f_name = "restore_missing_entities"
--~ common.writeDebug("Entered function %s(%s)", {f_name, entity_name or "nil"})
--~ common.writeDebug("global.compound_entities[%s]: %s", {entity_name, global.compound_entities[entity_name]})
common.writeDebug("global.compound_entities[%s]: %s entries", {entity_name, table_size(global.compound_entities[entity_name])})

    local check = global.compound_entities[entity_name]
    local entity_table = check and global[check.tab] or {}
    local hidden_entities = check and check.hidden or {}

    local checked = 0
    local restored = 0
    -- Scan the whole table
    for c, compound in pairs(entity_table) do
      -- Base entity is valid!
      if (compound.base and compound.base.valid) then
common.writeDebug("%s is valid -- checking hidden entities!", {common.print_name_id(compound.base)})
        for h_name, h_entity in pairs(hidden_entities) do
          -- Hidden entity is missing
          if not (compound[h_name] and compound[h_name].valid) then
            common.writeDebug("%s: MISSING!", {h_name})
            common.create_entities(entity_table, compound.base, {[h_name] = h_entity.name})
            restored = restored + 1
            common.writeDebug("Created %s (%s) for %s",
                              {h_name, h_entity.name, common.print_name_id(compound.base)})
          else
            common.writeDebug("%s: OK", {h_name})
          end
        end
        checked = checked + 1
--~ common.writeDebug("Restored %s %s", {entity_name, c})
      end
    end
common.writeDebug("Checked %s compound entities", {checked})
common.writeDebug("Restored %s entities", {restored})
--~ common.show("Fixed list", entity_table)
    common.entered_function("leave")
    return {checked = checked, restored = restored}
  end


  ------------------------------------------------------------------------------------
  -- Function to find all unregistered compound entities of a particular type
  common.register_in_compound_entity_tab = function(compound_name)
    common.entered_function()
  --~ local f_name = "register_in_compound_entity_tab"
    --~ common.writeDebug("Entered function %s(%s)", {f_name, compound_name})

    local cnt = 0
    local h_cnt = 0
    local data = global.compound_entities[compound_name]
    if not data then
      common.arg_err(compound_name, "name of a compound entity")
    end

    local g_tab = global[data.tab]
    local found, h_found ,created

    -- Scan all surfaces
    for s, surface in pairs(game.surfaces) do
      -- Check the bases of all compound entities on the surface
      found = surface.find_entities_filtered({name = compound_name})
      for b, base in ipairs(found) do
        -- Base entity isn't registered yet!
        if not g_tab[base.unit_number] then
          common.writeDebug("Found unregistered entity: %s!", {common.print_name_id(base)})
          -- Create an entry in the global table
          g_tab[base.unit_number] = {base = base}
          -- Add optional data to the table, if there are any
          common.add_optional_data(base)


          -- Check if it already has any hidden entities
          for h_name, h_data in pairs(data.hidden) do
            h_found = surface.find_entities_filtered({
              name = h_data.name,
              type = h_data.type,
              position = common.offset_position(base.position, h_data.base_offset),
            })

            -- Check for multiple hidden entities of the same type in the same position!
            if #h_found > 1 then
              local cnt = 0
              for duplicate = 2, #h_found do
                h_found[duplicate].destroy({raise_destroy = true})
                cnt = cnt + 1
              end
              common.writeDebug("Removed %s duplicate entities (%s)!", {cnt, h_data.name})
            end

            -- There still is one hidden entity left. Add it to the table!
            if next(h_found) then
              common.writeDebug("Found %s -- adding it to the table.", {common.print_name_id(base)})
              g_tab[base.unit_number][h_name] = h_found[1]

            -- Create hidden entity! This will automatically add it to the table.
            else
              created = common.create_entities(g_tab, base, {[h_name] = h_data})
              common.writeDebug("Created hidden %s: %s",
                                {h_name, created and common.print_name_id(created) or "nil"})
              h_cnt = h_cnt + 1
            end
          end
          cnt = cnt + 1
        end
      end
    end
    common.writeDebug("Registered %s compound entities and created %s hidden entities", {cnt, h_cnt})

    common.entered_function("leave")
    return cnt
  end

  ------------------------------------------------------------------------------------
  -- Function to find all unregistered compound entities
  common.find_unregistered_entities = function()
    common.entered_function()
    --~ local f_name = "find_unregistered_entities"
    --~ common.writeDebug("Entered function %s()", {f_name})

    local cnt = 0
    for compound_entity, c in pairs(global.compound_entities) do
      cnt = cnt + common.register_in_compound_entity_tab(compound_entity)
    end

    common.writeDebug("Registered %s compound entities.", {cnt})
    common.entered_function("leave")
    return cnt
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
  -- Calculate the offset position of a hidden entity
  common.offset_position = function(base_pos, offset)
    common.check_args(base_pos, "table", "position")
    offset = offset or {x = 0, y = 0}
    common.check_args(offset, "table", "position")

    base_pos = common.normalize_position(base_pos)
    offset = common.normalize_position(offset)

    return {x = base_pos.x + offset.x, y = base_pos.y + offset.y}
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
  --~ common.create_entities = function(g_table, base_entity, hidden_entity_names, position, ...)
  common.create_entities = function(g_table, base_entity, hidden_entities)
    common.entered_function()
    --~ local f_name = "create_entities"
    --~ common.writeDebug("Entered function %s(%s, %s, %s)",
                      --~ {f_name, "g_table", base_entity, hidden_entities})
    common.show("#g_table", g_table and table_size(g_table))
    --~ common.show("hidden_entities", hidden_entities)

    common.check_args(g_table, "table")
    common.check_args(base_entity, "table")

    if not base_entity.valid then
      common.arg_err(base_entity, "base entity")
    -- A table is required, but it may be empty! (This is needed for the
    -- bio gardens, which only have a hidden pole if the "Easy Gardens"
    -- setting is enabled.)
    elseif not (hidden_entities and type(hidden_entities) == "table") then
      common.arg_err(hidden_entities, "array of hidden-entity names")
    end
    local base_pos = common.normalize_position(base_entity.position) or
                      common.arg_err(position or "nil", "position")

    local entity, offset, pos

    -- Initialize entry in global table
    g_table[base_entity.unit_number] = g_table[base_entity.unit_number] or {}
    g_table[base_entity.unit_number].base = base_entity

    -- Create hidden entities
    local data
    for key, tab in pairs(hidden_entities) do
common.writeDebug("key: %s\tname: %s", {key, tab})
--~ data = common.compound_entities[base_entity.name].hidden[key]
      data = global.compound_entities[base_entity.name].hidden[key]
--~ common.show("common.compound_entities[base_entity.name].hidden",
            --~ common.compound_entities[base_entity.name].hidden)
common.show("data", data)
      entity = base_entity.surface.create_entity({
        name = data.name,
        type = data.type,
        position = common.offset_position(base_pos, data.base_offset),
        force = base_entity.force,
      })
      -- Raise the event manually, so we can pass on extra data!
      script.raise_event(defines.events.script_raised_built, {
        entity = entity,
        base_entity = base_entity
      })

      -- Make hidden entity unminable/undestructible
      make_unminable({entity})

      -- Add hidden entity to global table
      g_table[base_entity.unit_number][key] = entity
    end

    -- Add optional values to global table
    common.add_optional_data(base_entity)
    common.writeDebug("g_table[%s]: %s", {base_entity.unit_number, g_table[base_entity.unit_number]})

    common.entered_function("leave")
  end


  --------------------------------------------------------------------
  -- Make a list of the pole types that Bio gardens may connect to
  common.get_garden_pole_connectors = function()
    common.entered_function()

    local ret
    if common.get_startup_setting("BI_Game_Tweaks_Easy_Bio_Gardens") then
common.writeDebug("\"Easy gardens\": Compiling list of poles they can connect to!" )
      ret = {}
      local poles = game.get_filtered_entity_prototypes({
        {filter = "type", type = "electric-pole"},
        {filter = "name", name = {
            -- Poles named here will be ignored!
            "bi-bio-garden-hidden-pole",
            "bi-rail-power-hidden-pole",
            BioInd.musk_floor_pole_name,
          }, invert = "true", mode = "and"
        }
      })
      for p, pole in pairs(poles) do
        ret[#ret + 1] = pole.name
      end
    else
common.nothing_to_do("\"Easy gardens\": Not active -- nothing to do!" )
    end

    common.entered_function("leave")
    return ret
  end

  --------------------------------------------------------------------
  -- Connect hidden poles of Bio gardens!
  -- (This function may be called for hidden poles that have not been
  -- added to the table yet if the pole has just been built. In this
  -- case, we pass on the new pole explicitly!)
  common.connect_garden_pole = function(base, new_pole)
    common.entered_function({common.argprint(base), common.argprint(new_pole)})
    local compound_entity = global.compound_entities["bi-bio-garden"]
    --~ local pole_type = "electric-pole"
    --~ local pole = global[compound_entity.tab][base.unit_number] and
                  --~ global[compound_entity.tab][base.unit_number][pole_type] or
                  --~ new_pole
    local pole = global[compound_entity.tab][base.unit_number] and
                  global[compound_entity.tab][base.unit_number].pole or
                  new_pole

    --~ if pole and pole.valid then
      --~ local wire_reach = game.entity_prototypes[compound_entity.hidden[pole_type]] and
                          --~ game.entity_prototypes[compound_entity.hidden[pole_type]].max_wire_distance
    if pole and pole.valid and  compound_entity.hidden and
                                compound_entity.hidden.pole and
                                compound_entity.hidden.pole.name then
      local wire_reach = game.entity_prototypes[compound_entity.hidden.pole.name] and
                          game.entity_prototypes[compound_entity.hidden.pole.name].max_wire_distance
      if not wire_reach then
        error("Prototype for hidden pole of Bio gardens doesn't exist!")
      end

      pole.disconnect_neighbour()

      -- Each pole can only have 5 connections. Let's connect to other hidden
      -- poles first!
      local connected
      local neighbours = pole.surface.find_entities_filtered({
        position = pole.position,
        radius = wire_reach,
        type = "electric-pole",
        name = compound_entity.hidden.pole.name
      })
common.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours - 1})

      for n, neighbour in pairs(neighbours or{}) do
        if pole ~= neighbour then
          connected = pole.connect_neighbour(neighbour)
common.writeDebug("Connected pole %g to %s %g: %s",
                  {pole.unit_number, neighbour.name, neighbour.unit_number, connected})
        end
      end

      --~ -- Connect hidden poles to other poles that may be in reach.
      --~ common.garden_pole_connectors = common.garden_pole_connectors and next() or
                                      --~ common.get_garden_pole_connectors()
--~ common.show("Poles hidden bio-garden poles may connect to", global.mod_settings.garden_pole_connectors)

      -- Look for other poles around this one
      neighbours = pole.surface.find_entities_filtered({
        position = pole.position,
        radius = wire_reach,
        type = "electric-pole",
        name = global.mod_settings.garden_pole_connectors,
      })
common.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours})
      for n, neighbour in pairs(neighbours or{}) do
        connected = pole.connect_neighbour(neighbour)
common.writeDebug("Connected pole %g to neighbour %s (%g): %s",
                  {pole.unit_number, neighbour.name, neighbour.unit_number, connected})
      end
    end
    common.entered_function("leave")
  end

  --------------------------------------------------------------------
  -- Connect hidden poles of powered rails -- this is also used in
  -- migration scripts, so make it a function in common.lua!
  -- (This function may be called for hidden poles that have not been
  -- added to the table yet if the pole has just been built. In this
  -- case, we pass on the new pole explicitly!)
  common.connect_power_rail = function(base, new_pole)
    common.entered_function({common.argprint(base), common.argprint(new_pole)})
    --~ local pole_type = "electric-pole"

    local pole = global.bi_power_rail_table[base.unit_number].pole or new_pole
    if pole and pole.valid then
      -- Remove all copper wires from new pole
      pole.disconnect_neighbour()
common.writeDebug("Removed all wires from %s %g", {pole.name, pole.unit_number})

      -- Look for connecting rails at front and back of the new rail
      for s, side in ipairs( {"front", "back"} ) do
common.writeDebug("Looking for rails at %s", {side})
        local neighbour
        -- Look in all three directions
        for d, direction in ipairs( {"left", "straight", "right"} ) do
common.writeDebug("Looking for rails in %s direction", {direction})
          neighbour = base.get_connected_rail{
            rail_direction = defines.rail_direction[side],
            rail_connection_direction = defines.rail_connection_direction[direction]
          }
common.writeDebug("Rail %s of %s (%s): %s (%s)", {direction, base.name, base.unit_number, (neighbour and neighbour.name or "nil"), (neighbour and neighbour.unit_number or "nil")})

          -- Only make a connection if found rail is a powered rail
          -- (We'll know it's the right type if we find it in our table!)
          neighbour = neighbour and neighbour.valid and global.bi_power_rail_table[neighbour.unit_number]
          if neighbour and neighbour.pole and neighbour.pole.valid then
            pole.connect_neighbour(neighbour.pole)
            common.writeDebug("Connected poles!")
          end
        end
      end

      -- Look for Power-rail connectors
      local connector = base.surface.find_entities_filtered{
        position = base.position,
        radius = common.POWER_TO_RAIL_WIRE_DISTANCE,    -- maximum_wire_distance of Power-to-rail-connectors
        name = "bi-power-to-rail-pole"
      }
      -- Connect to first Power-rail connector we've found
      if connector and next(connector) then
        pole.connect_neighbour(connector[1])
        common.writeDebug("Connected " .. pole.name .. " (" .. pole.unit_number ..
                          ") to " .. connector[1].name .. " (" .. connector[1].unit_number .. ")")
        common.writeDebug("Connected %s (%g) to %s (%g)", {pole.name, pole.unit_number, connector[1].name, connector[1].unit_number})
      end
      common.writeDebug("Stored %s (%g) in global table", {base.name, base.unit_number})
    end

    common.entered_function("leave")
  end


  ------------------------------------------------------------------------------------
  -- Make prototype.icons from prototype.icon
  ------------------------------------------------------------------------------------
  common.BI_add_icons = function()
    common.entered_function()
    common.writeDebug("Trying to convert \"icon\" to \"icons\"")

    for tab_name, tab in pairs(data.raw) do
      --~ common.writeDebug("Checking data.raw[%s]", {tab_name})
      for proto_type_name, proto_type in pairs(data.raw[tab_name] or {}) do
--~ common.show("proto_type.BI_add_icon", proto_type.BI_add_icon or "nil" )
        if proto_type.BI_add_icon then
          proto_type.icons = {
            {
              icon = proto_type.icon,
              icon_size = proto_type.icon_size,
              icon_mipmaps = proto_type.icon_mipmaps,
              scale = proto_type.scale
            }
          }
          proto_type.BI_add_icon = nil
          --~ common.writeDebug("Added \"icons\" property to data.raw[\"%s\"][\"%s\"]: %s",
                            --~ {tab_name, proto_type_name, proto_type.icons}, "line")
          common.modified_msg("icons", proto_type, "Added")
        end
      end
    end
    common.entered_function("leave")
  end



  -- snouz -- arguments need at least it1 = "item". it2, it3, shifts are optional.
  common.make_icons = function(args)
    common.entered_function()

    local it = {}
    table.insert(it, {ite = args.it1} or {})
    table.insert(it, {ite = args.it2} or {})
    table.insert(it, {ite = args.it3} or {})
    table.insert(it, {ite = args.it4} or {})
    table.insert(it, {ite = args.it5} or {})
    table.insert(it, {ite = args.it6} or {})
    table.insert(it[1], {sca = args.sc1} or {sca = 1})
    table.insert(it[2], {sca = args.sc2} or {sca = 1})
    table.insert(it[3], {sca = args.sc3} or {sca = 1})
    table.insert(it[4], {sca = args.sc4} or {sca = 1})
    table.insert(it[5], {sca = args.sc5} or {sca = 1})
    table.insert(it[6], {sca = args.sc6} or {sca = 1})
    table.insert(it[1], {shi = args.sh1} or {shi = {0,0}})
    table.insert(it[2], {shi = args.sh2} or {shi = {0,0}})
    table.insert(it[3], {shi = args.sh3} or {shi = {0,0}})
    table.insert(it[4], {shi = args.sh4} or {shi = {0,0}})
    table.insert(it[5], {shi = args.sh5} or {shi = {0,0}})
    table.insert(it[6], {shi = args.sh6} or {shi = {0,0}})
    local customicon_up = args.custom or nil
    local customicon_down = args.customunder or nil
    local custom_topright = args.custom_topright or nil

    local icontable = {{icon = common.iconpath .. "empty64.png", icon_size = 64, icon_mipmaps = 0, scale = 1, shift = {0,0}}}

    local function transform_item(it_name)
      local _type
      _type = it_name and (thxbob.lib.item.get_type(it_name) or thxbob.lib.item.get_type("bi-" .. it_name)) or nil
      return _type and (data.raw[_type][it_name] or data.raw[_type]["bi-" .. it_name]) or nil
    end
    
    if customicon_down then table.insert(icontable, {icon = customicon_down, icon_size = 64, mipmaps = 4}) end

    for k=1, #it do
      local _item = it[k].ite or nil
      local _scale = it[k].sca or 1
      local _shift = it[k].shi or {0,0}

      if k==2 then
        _scale = (_scale * 0.5)
        _shift = {(_shift[1] + 16),(_shift[2] - 16)}
      end
      if k==3 then
        _scale = (_scale * 0.5)
        _shift = {(_shift[1] - 16),(_shift[2] - 16)}
      end
      if k==4 then
        _scale = (_scale * 0.75)
        _shift = {(_shift[1] + 10),(_shift[2])}
      end
      if k==5 then
        _scale = (_scale * 0.75)
        _shift = {(_shift[1] - 10),(_shift[2])}
      end
      if k==6 then
        _scale = (_scale * 0.5)
        _shift = {(_shift[1] - 16),(_shift[2] + 16)}
      end

      _item = _item and transform_item(_item)
      if _item then
        if not _item.icon and _item.icons then
          for i=1,#_item.icons do
            local layer = {}
            local layershift = _item.icons[i].shift or {0,0}
            local relativescale = (64 / ((_item.icons[1].icon_size or 1) * (_item.icons[1].scale or 1)))
            local layerscale = _item.icons[i].scale or 1
            layer.icon = _item.icons[i].icon
            layer.icon_size = _item.icons[i].icon_size
            layer.icon_mipmaps = _item.icons[i].icon_mipmaps
            layer.shift = {(((layershift[1] * relativescale) * _scale)+ _shift[1]), (((layershift[2] * relativescale) * _scale) + _shift[2])}
            --layer.scale = _item.icons[i].scale or 1
            layer.scale = ((layerscale * relativescale) * _scale)
            if _item.icons[i].tint then layer.tint = _item.icons[i].tint end
            table.insert(icontable, layer)
          end
        else
          table.insert(icontable, {icon = _item.icon, icon_size = _item.icon_size, icon_mipmaps = _item.icon_mipmaps, scale = ((64 / _item.icon_size) * _scale), shift = _shift})
        end
      end
    end
    if customicon_up then table.insert(icontable, {icon = customicon_up, icon_size = 64, mipmaps = 4}) end
    if custom_topright then table.insert(icontable, {icon = custom_topright, icon_size = 64, mipmaps = 4, shift = {16, -16}}) end

    common.entered_function("leave")
    return icontable
  end

  ------------------------------------------------------------------------------------
  -- Combine icon mips to pictures
  ------------------------------------------------------------------------------------
  common.add_pix = function(icon, count)
    local ret = {}
    for i = 1, count do
      ret[i] = {
        size = 64,
        filename = common.iconpath .. "mips/" .. icon .. "_" ..  i .. ".png",
        scale = 0.25
      }
    end
    return ret
  end

  ------------------------------------------------------------------------------------
  -- Exchange icons
  ------------------------------------------------------------------------------------
  common.BI_change_icon = function(prototype, icon, ...)
    common.entered_function()
    common.check_args(icon, "string", "path to an icon")
    local proto_type = prototype and prototype.type or common.arg_err(prototype, "prototype")
    local proto_name = prototype and prototype.name or common.arg_err(prototype, "prototype")

    local icon_size, icon_mips = ...

    if data.raw[proto_type][proto_name] then
      prototype.icon = icon
      prototype.icon_size = icon_size or 64
      prototype.icon_mipmaps = icon_mips or prototype.icon_mipmaps or 0
      prototype.BI_add_icon = true

      common.modified_msg("icon", prototype)
    end
  end


  ------------------------------------------------------------------------------------
  --                       Add recipe unlocks to technologies                       --
  ------------------------------------------------------------------------------------
  common.BI_add_unlocks = function()
    common.entered_function()
    local techs = data.raw.technology

    for r, recipe in pairs(data.raw.recipe) do
      -- There may be several techs that unlock a recipe!
      for t, tech in pairs(recipe.BI_add_to_tech or {}) do
        if techs[tech] then
          thxbob.lib.tech.add_recipe_unlock(tech, recipe.name)
          common.modified_msg("unlock for recipe " .. r, techs[tech], "Added")
        end
      end
      recipe.BI_add_to_tech = nil
    end
  end


  ------------------------------------------------------------------------------------
  --                       Add difficulty to all our recipes                        --
  ------------------------------------------------------------------------------------
  common.BI_add_difficulty = function()
    common.entered_function()

    for r, recipe in pairs(BI.default_recipes) do
      thxbob.lib.recipe.difficulty_split(recipe)
      common.modified_msg("difficulties", recipe, "Added")
    end
    for l, recipe_list in pairs(BI.additional_recipes) do
      for r, recipe in pairs(recipe_list) do
        --~ thxbob.lib.recipe.difficulty_split(recipe)
        --~ common.modified_msg("difficulties", recipe, "Added")
        if thxbob.lib.recipe.difficulty_split(recipe) then
          common.modified_msg("difficulties", recipe, "Added")
        end
      end
    end

    common.entered_function("leave")
  end

  ------------------------------------------------------------------------------------
  --                           Make remnants for an entity                          --
  ------------------------------------------------------------------------------------
  common.make_remnants_for_entity = function(remnants, entity)
    --~ common.entered_function()
    local pattern = "^" .. entity.name:gsub("%-", "%%-") .. "%-remnant"

    -- We want to extend single items as well as complete arrays!
    remnants = remnants and (remnants.type and remnants.name) and
                {remnants} or
                remnants

    for r, remnant in pairs(remnants or {}) do
      if remnant.name:match(pattern) then
        data:extend({remnant})
        common.created_msg(remnant)
        break
      end
    end
  end

  ------------------------------------------------------------------------------------
  --                                  Create things                                 --
  ------------------------------------------------------------------------------------
  common.create_stuff = function(create_list)
    --~ common.entered_function()

    common.check_args (create_list, "table")

    -- We want to extend single items as well as complete arrays!
    create_list = (create_list.type and create_list.name) and {create_list} or create_list

    local ret = {}

    for entry, entry_data in pairs(create_list) do
      if not (data.raw[entry_data.type] and data.raw[entry_data.type][entry_data.name]) then
        data:extend({ table.deepcopy(entry_data) })
        BioInd.created_msg(entry_data)
      end
      ret[#ret + 1] = data.raw[entry_data.type] and
                      data.raw[entry_data.type][entry_data.name]
    end
    return ret
  end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
  return common
end
