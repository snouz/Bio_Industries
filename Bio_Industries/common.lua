log("Entered file " .. debug.getinfo(1).source)
require("util")

--~ local compound_entities = require("prototypes.compound_entities.main_list")
local compound_entities = require("prototypes.compound_entities.main_list")

return function(mod_name)
  local common = {}
  common.debugging = {}

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

  --~ ------------------------------------------------------------------------------------
  --~ -- Get debugging and output functions
  --~ common.debugging = require("common-debugging")


  --~ ------------------------------------------------------------------------------------
  --~ -- Greatly improved version check for mods (thanks to eradicator!)
  --~ common.Version = {}
  --~ do
    --~ local V = common.Version

    --~ local function parse_version(vstr) -- string "Major.Minor.Patch"
      --~ local err = function()
        --~ error('Invalid Version String: <' .. tostring(vstr) .. '>')
      --~ end
      --~ local r = {vstr:match('^(%d+)%.(%d+)%.(%d+)$')}

      --~ if #r ~= 3 then
        --~ err()
      --~ end

      --~ for i=1, 3 do
        --~ r[i] = tonumber(r[i])
      --~ end

      --~ return r
    --~ end

    --~ V.gtr = function(verA, verB)
      --~ local a, b, c = unpack(parse_version(verA))
      --~ local x, y, z = unpack(parse_version(verB))
      --~ return (a > x) or (a == x and b > y) or (a == x and b == y and c > z)
    --~ end
    --~ local map = {
      --~ ['=' ] = function(A, B) return not (V.gtr(A, B)   or V.gtr(B, A)) end,
      --~ ['>' ] = V.gtr,
      --~ ['!='] = function(A, B) return (V.gtr(A, B)       or V.gtr(B, A)) end,
      --~ ['<='] = function(A, B) return V.gtr(B, A)        or (not V.gtr(A, B)) end,
      --~ ['>='] = function(A, B) return V.gtr(A, B)        or (not V.gtr(B, A)) end,
      --~ ['~='] = function(A, B) return (V.gtr(A, B)       or V.gtr(B, A)) end,
      --~ ['<' ] = function(A, B) return V.gtr(B, A) end,
    --~ }

    --~ common.check_version = function(mod_name, operator, need_version)
      --~ local mod_version = (mods and mods[mod_name]) or (script and script.active_mods[mod_name])
      --~ return map[operator](mod_version, need_version)
    --~ end
  --~ end


  ------------------------------------------------------------------------------------
  -- List of compound entities
  -- Key:       name of the base entity
  -- tab:       name of the global table where data of these entity are stored
  -- hidden:    table containing the hidden entities needed by this entity
  --            (Key:   name under which the hidden entity will be stored in the table;
  --             Value: name of the entity that should be placed)
  --~ common.compound_entities = compound_entities.get_HE_list("complete")
  --~ -- We'll need the complete list in the data stage.
  --~ if data then
    --~ common.compound_entities = compound_entities.get_HE_list()

  --~ -- In the control stage, we use AutoCache for creating the table of the compound
  --~ -- entities actually used in the game. However, we'll need the complete list when
  --~ -- a game is loaded, so we can remove tables of unused compound entity from the
  --~ -- global table. This list will be discarded after use!
  --~ else
    --~ common.all_compound_entities = compound_entities.get_HE_list()
  --~ end
--~ log("compound entities: " .. serpent.block(common.compound_entities))

  -- Make this function available to the init functions from the control stage!
  common.get_HE_list = compound_entities.get_HE_list

  -- Map the short handles of hidden entities (e.g. "pole") to real prototype types
  -- (e.g. "electric-pole")
  common.HE_map = compound_entities.HE_map

  -- Reverse lookup
  common.HE_map_reverse = compound_entities.HE_map_reverse

  -- We can't store Musk floor with the compound_entities because it has no unit_number
  -- but must be identified by its position. So let's store the names of its hidden
  -- entities so we can use them later on!
  common.musk_floor_stuff = {
    musk_floor_pole_name = "bi-musk-mat-hidden-pole",
    musk_floor_panel_name = "bi-musk-mat-hidden-panel",
    musk_floor_tile_name = "bi-solar-mat"
  }

  -- Pollution sensors are no compound entity, so we better store it's name here for
  -- referencing it during prototype creation and in the control script.
  common.pollution_sensor_name = "bi-pollution-sensor"
  common.pollution_sensor_type = "constant-combinator"

  ------------------------------------------------------------------------------------
  -- There may be trees for which we don't want to create variations. These patterns
  -- are used to build a list of trees we want to ignore.
  common.tree_stuff = {}
  common.tree_stuff.tree_ignore_name_patterns = {
    -- Ignore our own trees
    "bio%-tree%-.+%-%d",
    -- Tree prototypes created by "Robot Tree Farm" or "Tral's Robot Tree Farm"
    "rtf%-.+%-%d+",
    -- Tree prototypes created by "Industrial Revolution 2"
    ".*%-*ir2%-.+",
  }


  -- Get list of tree prototypes that we want to ignore
  common.tree_stuff.get_tree_ignore_list = function()
    local ignore = {}
    local trees = game and
                    game.get_filtered_entity_prototypes({{filter = "type", type = "tree"}}) or
                    data.raw.tree
    for tree_name, tree in pairs(trees) do
      for p, pattern in ipairs(common.tree_stuff.tree_ignore_name_patterns) do
        if tree_name:match(pattern) then
          ignore[tree_name] = true
          break
        end
      end
    end
    return ignore
  end

  ------------------------------------------------------------------------------------
  -- Get the tiles that result from fertilizing the ground with common od advanced
  -- fertilizer (different tiles will be used when "Alien Biomes" is active).
  -- The argument to this function is only needed in the control stage, and the return
  -- value only in the data stage.
  common.tree_stuff.AB_tiles = function(list)
    common.debugging.entered_function({list})

    local tiles = (game and game.tile_prototypes) or (data and data.raw.tile)

    -- In the control stage, AutoCache will pass on an empty table as list, in the
    -- data stage, we must create list.
    list = list or {}

    if tiles and tiles["vegetation-green-grass-1"] and tiles["vegetation-green-grass-3"] then
      list.advanced, list.common = "vegetation-green-grass-1", "vegetation-green-grass-3"
    else
      list.advanced, list.common = "grass-1", "grass-3"
    end
common.debugging.show("Tiles used for fertilizers", list)

    common.debugging.entered_function("leave")
    -- Return value is ignored in control stage!
    return data and list
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
  --~ -- local default = true

  common.debugging.debug_to_log   = common.get_startup_setting("BI_Debug_To_Log") or
                                    (mods and mods["_debug"] and true) or
                                    (script and script.active_mods["_debug"] and true) or
                                    default
  common.debugging.debug_to_game  = common.get_startup_setting("BI_Debug_To_Game") or
                                    --(mods and mods["_debug"] and true) or
                                    --(script and script.active_mods["_debug"] and true) or
                                    default

  common.debugging.is_debug       = common.debugging.debug_to_log or common.debugging.debug_to_game

  --~ ------------------------------------------------------------------------------------
  --~ --                               DEBUGGING FUNCTIONS                              --
  --~ ------------------------------------------------------------------------------------



  --~ ------------------------------------------------------------------------------------
  -- Output arguments a function was called with
  --~ --common.debugging.argprint = function(arg)
    --~ ---- Debugging is off
    --~ --if not common.debugging.is_debug then
      --~ --return "nil"
    --~ ---- No argument
    --~ --elseif not arg then
      --~ --return "nil"
    --~ ---- Argument was player.index or vehicle.unit_number
    --~ --elseif type(arg) == "number" then
      --~ --return tostring(arg)
    --~ ---- Argument was player entity (Check for a function before calling it!)
    --~ --elseif type(arg) == "table" and arg.object_name == "LuaPlayer" and arg.valid then
      --~ --return "player " .. tostring(arg.index) .. " (\"" .. arg.name .. "\")"
    --~ ---- Argument was an entity
    --~ --elseif type(arg) == "table" and arg.object_name == "LuaEntity" and arg.valid then
      --~ --return arg.type .. " \"" .. arg.name .. "\" (" .. tostring(arg.unit_number) .. ")"
    --~ ---- Argument was a recipe
    --~ --elseif type(arg) == "table" and arg.object_name == "LuaRecipe" and arg.valid then
      --~ --return arg.type .. " \"" .. arg.name .. "\""
    --~ ---- Argument was something else
    --~ --else
      --~ --return serpent.line(arg)
    --~ --end
  --~ --end
  common.debugging.argprint = function(arg)
    -- Debugging is off
    local ret = "nil"
    local arg_type = type(arg)

    -- Debugging must be on, and arg must not be nil
    if common.debugging.is_debug and arg then
      -- Argument was a string
      if arg_type == "table" then
        -- Control stage
        if game then
          -- Argument was player entity
          if arg.object_name == "LuaPlayer" and arg.valid then
            ret = string.format("%s %s (\"%s\")", arg.object_name, arg.index, arg.name)

          -- Argument was a force
          elseif arg.object_name == "LuaForce" and arg.valid then
            ret = string.format("%s %s (\"%s\")", arg.object_name, arg.index, arg.name)

          -- Argument was a surface
          elseif arg.object_name == "LuaSurface" and arg.valid then
            ret = string.format("%s %s (\"%s\")", arg.object_name, arg.index, arg.name)

          -- Argument was a recipe
          elseif arg.object_name == "LuaRecipe" and arg.valid then
            ret = string.format("%s \"%s\"", arg.object_name, arg.name)

          -- Argument was an entity
          elseif arg.object_name == "LuaEntity" and arg.valid then
            ret = string.format("%s \"%s\" (%s)", arg.type, arg.name, arg.unit_number)
          -- Argument was something else
          else
            ret = serpent.line(arg)
          end

        -- Data stage
        elseif data then
          -- Argument was something from data.raw
          if arg.type then
            ret = string.format("%s \"%s\"", arg.type, arg.name)
          -- Argument was something else
          else
            ret = serpent.line(arg)
          end
        end
      -- Argument was something else
      else
        ret = serpent.line(arg)
      end
    end

    return ret
  end



  ------------------------------------------------------------------------------------
  -- Output debugging text
  common.debugging.writeDebug = function(msg, tab, print_line)
    local args = {}
    -- Use serpent.line instead of serpent.block if this is true!
    local line = print_line and
                  (string.lower(print_line) == "line" or string.lower(print_line) == "l") and
                  true or false

    if common.debugging.is_debug then
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
          args[#args + 1] = line and serpent.line(v) or
                                      serpent.block(v)
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
      if common.debugging.debug_to_log then
        log(string.format(tostring(msg), table.unpack(args)))
      end

      -- Print the message text to the game
      if game and common.debugging.debug_to_game then
        game.print(string.format(tostring(msg), table.unpack(args)))
      end
    end
  end

  ------------------------------------------------------------------------------------
  -- Simple helper to show a single value with descriptive text
  common.debugging.show = function(desc, term)
    if common.debugging.is_debug then
      common.debugging.writeDebug(tostring(desc) .. ": %s", type(term) == "table" and { term } or term)
    end
  end

  ------------------------------------------------------------------------------------
  -- Print "entityname (id)"
  common.debugging.print_name_id = function(entity)
    local id
    local name = "unknown entity"

    if entity and entity.valid then
    -- Stickers don't have an index or unit_number!
      id =  (entity.type == "sticker" and entity.type) or
            entity.unit_number or entity.type

      name = entity.name
    end

    return string.format("%s (%s)", name, id or "nil")
  end

  ------------------------------------------------------------------------------------
  -- Print "entityname"
  common.debugging.print_name = function(entity)
    return entity and entity.valid and entity.name or ""
  end

  ------------------------------------------------------------------------------------
  -- Print message if something has been created
  -- proto:     Prototype that has been changed
  common.debugging.created_msg = function(proto)
    local proto_name = proto and proto.name or common.debugging.arg_err(proto)
    local proto_type = proto and proto.type or common.debugging.arg_err(proto)

    common.debugging.writeDebug("Created %s \"%s\".", {proto_type, proto_name})
  end

  ------------------------------------------------------------------------------------
  -- Print message if data for additional prototypes have been read
  -- data:      Prototype data
  -- list:      List of the subtables in data that we must check
  -- name:      Name of the thing that has been changed
  -- list_name: The type of list (settings, triggers etc.)
  common.debugging.readdata_msg = function(data, list, name, list_name)
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
      common.debugging.writeDebug("Read data for %s%s.", {name, list_name and " (" .. list_name .. ")" or ""})
    else
      common.debugging.writeDebug("No data for %s read.", {name})
    end
  end


  ------------------------------------------------------------------------------------
  -- Print message if something has been modified
  -- desc:      Description of the changed thing (e.g. "ingredients", "localization")
  -- proto:     Prototype that has been changed
  -- mode:      What happened to the prototype (e.g. "Changed", "Replaced")
  common.debugging.modified_msg = function(desc, proto, mode)
    common.debugging.check_args(desc, "string")

    common.debugging.check_args(proto, "table")
    common.debugging.check_args(proto.name, "string")
    common.debugging.check_args(proto.type, "string")

    mode = (type(mode) == "string") and mode or "Changed"
    local preposition = (mode:lower() == "added") and "to" or
                          (mode:lower() == "removed") and "from" or
                          "of"
    common.debugging.writeDebug("%s %s %s %s \"%s\".", {mode, desc, preposition, proto.type, proto.name})
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
                    arg_list .. common.debugging.argprint(v) or
                    arg_list .. k .. " = " .. common.debugging.argprint(v)
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
      common.debugging.writeDebug("\n%s\n%s\n%s\n", {sep, msg, sep})

    end
  end


 ------------------------------------------------------------------------------------
  -- File has been entered
  common.debugging.entered_file = function(leave, bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.debugging.is_debug then
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
  common.debugging.entered_function = function(args, leave, bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.debugging.is_debug then

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
  common.debugging.entered_command = function(args, leave, bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.debugging.is_debug then

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
  common.debugging.entered_event = function(event, leave, bail_out)
    -- Skip all the string casting unless we really want to log something!
    if common.debugging.is_debug then

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
  common.debugging.nothing_to_do = function(sep)
    sep = string.rep(sep or "-", 100)

    local file = debug.getinfo(2)
    local function_name = debug.getinfo(2, "n").name
    local msg = function_name and
                  function_name .. "\n(" .. file.source .. ": " .. file.currentline .. ")" or
                  file.source
    common.debugging.writeDebug("\n%s\nNothing to do in %s\n%s\n", {sep, msg, sep})
  end


  ------------------------------------------------------------------------------------
  -- Throw an error if a wrong argument has been passed to a function
  common.debugging.arg_err = function(arg, arg_type)
    error(string.format(
      "Wrong argument! %s is not %s!",
      (arg or "nil"), (arg_type and "a valid " .. arg_type or "valid")
    ))
  end

  ------------------------------------------------------------------------------------
  -- Rudimentary check of the arguments passed to a function
  common.debugging.check_args = function(arg, arg_type, desc)
--~ -- common.debugging.entered_function({arg, arg_type, desc})
    local check = true
    arg_type = arg_type and arg_type:lower() or ""

    --~ -- -- Special arguments: Entities, recipes etc. are stored in tables, but that's not
    --~ -- -- enough to make sure they really are such a thing
    --~ -- if type(arg) == "table" then
      --~ -- if
          --~ -- (arg_type == "entity"         and arg.object_name ~= "LuaEntity") or
          --~ -- (arg_type == "player"         and arg.object_name ~= "LuaPlayer") or
          --~ -- (arg_type == "force"          and arg.object_name ~= "LuaForce") or
          --~ -- (arg_type == "surface"        and arg.object_name ~= "LuaSurface")
          --~ -- arg_type ~= "table" then
        --~ -- check = false
      --~ -- end
    --~ -- -- Default argument, it should match the string returned by the type() function!
    --~ -- elseif type(arg) ~= arg_type then
      --~ -- check = false
    --~ -- end
    -- Special arguments: Entities, recipes etc. are stored in tables, but that's not
    -- enough to make sure they really are such a thing
    if type(arg) == "table" then
      local object_type = arg.object_name and arg.object_name:lower() or
                            arg.type and arg.type:lower()
      if arg_type ~= object_type and arg_type ~= "table" then
        check = false
      end
    -- Default argument, it should match the string returned by the type() function!
    elseif type(arg) ~= arg_type then
      check = false
    end

    if not check then
      common.debugging.arg_err(arg or "nil", desc or arg_type or "nil")
    end
--~ -- common.debugging.entered_function("leave")
    return true
  end


  ------------------------------------------------------------------------------------
  -- Check if a mod (or several mods, or any of several mods) is installed
  -- modlist: Name(s) of mod(s) we need to check (string or array of strings)
  -- mode:    Any ("or") or all ("and") mods in modlist must be active.
  common.check_mods = function(modlist, mode)
    --~ common.debugging.writeDebug("Entered function check_mods(%s, %s)",
                      --~ {modlist or "nil", mode or "nil"})
    modlist = type(modlist) == "string" and {modlist} or
              type(modlist) == "table" and modlist or
              common.debugging.arg_err(modlist or "nil", "string or array of strings")
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
            common.debugging.writeDebug("Mod %s has been found and mode is \"or\". Return: %s", {mod_name, ret})
          end
          break
        end
      -- Mod is not active
      else
        -- If mode is "and", the test has failed!
        ret = false
        if mode == "and" then
          if #modlist > 1 then
            common.debugging.writeDebug("Mod %s isn't active and mode is \"and\". Return: %s", {mod_name, ret})
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
  -- Function for removing invalid prototypes from list of compound entities
  --~ common.rebuild_compound_entity_list = function(list)
  --~ common.prune_compound_entity_list = function(list)
  common.build_compound_entity_list = function(list)
    common.debugging.entered_function({list})

    -- In the control stage, this function is called by AutoCache, and "list" will be
    -- the name of the final table that AutoCache passes on to the constructor. But in
    -- the data stage, we must initialize this table!
    list = list or {}

    --
    local base_prototype, h_prototype, base_name, base_type

    for c_name, c_data in pairs(common.get_HE_list()) do
common.debugging.show("base_name", c_name)
common.debugging.show("data", c_data)
      -- Is the base entity in the game? (Data and control stage!)
      base_name = c_data.base and c_data.base.name
      base_type = c_data.base and c_data.base.type

      base_prototype = (game and game.entity_prototypes[base_name]) or (
                        data and base_type and base_name and
                        data.raw[base_type] and data.raw[base_type][base_name])

      if base_prototype then
        -- Make a copy of the compound-entity data
        common.debugging.writeDebug("%s exists -- copying data", {c_name})
        list[c_name] = util.table.deepcopy(c_data)

        -- Check hidden entities
        for h_key, h_data in pairs(list[c_name].hidden) do
common.debugging.writeDebug("h_key: %s\th_data: %s", {h_key, h_data})
          -- Control stage only
          if game then
            h_prototype = game.entity_prototypes[h_data.name]

            -- Remove hidden entities that don't exist from table. (Currently needed
            -- for hidden poles of Bio gardens if the "Easy Gardens" setting is off.)
            if not h_prototype then
              common.debugging.writeDebug("Removing %s (%s) from list of hidden entities!", {h_data.name, h_key})
              list[c_name].hidden[h_key] = nil
            -- If the hidden entity is an electric pole, store its wire reach!
            elseif h_data.type == "electric-pole" then
              list[c_name].hidden[h_key].max_wire_distance = h_prototype.max_wire_distance
              common.debugging.writeDebug("Added wire_reach to data of %s (%s): %s",
                                {h_data.name, h_key, h_prototype.max_wire_distance})
              if h_prototype.max_circuit_wire_distance > 0 then
                list[c_name].hidden[h_key].max_circuit_wire_distance = h_prototype.max_circuit_wire_distance
                common.debugging.writeDebug("Added circuit wire_reach to data of %s (%s): %s",
                                  {h_data.name, h_key, h_prototype.max_circuit_wire_distance})
              end
            end
          end
        end
      end
    end

    common.debugging.show("list", list)
    common.debugging.entered_function("leave")

    -- In the data stage, we must return the list. In the control stage, it will be
    -- set directly by AutoCache.
    return data and list
  end



------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
  log("Leaving file " .. debug.getinfo(1).source)

  return common
end
