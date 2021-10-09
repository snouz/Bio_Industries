log("Entered file " .. debug.getinfo(1).source)

local common = {}
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

  common.debugging.debug_to_log   = common.get_startup_setting("BI_Debug_To_Log") or
                                    (mods and mods["_debug"] and true) or
                                    (script and script.active_mods["_debug"] and true) or
                                    default
  common.debugging.debug_to_game  = common.get_startup_setting("BI_Debug_To_Game") or
                                    --~ (mods and mods["_debug"] and true) or
                                    --~ (script and script.active_mods["_debug"] and true) or
                                    default

  common.debugging.is_debug       = common.debug_to_log or common.debug_to_game

  ------------------------------------------------------------------------------------
  --                               DEBUGGING FUNCTIONS                              --
  ------------------------------------------------------------------------------------



  ------------------------------------------------------------------------------------
  -- Output arguments a function was called with
  --~ common.argprint = function(arg)
    --~ -- Debugging is off
    --~ if not common.is_debug then
      --~ return "nil"
    --~ -- No argument
    --~ elseif not arg then
      --~ return "nil"
    --~ -- Argument was player.index or vehicle.unit_number
    --~ elseif type(arg) == "number" then
      --~ return tostring(arg)
    --~ -- Argument was player entity (Check for a function before calling it!)
    --~ elseif type(arg) == "table" and arg.object_name == "LuaPlayer" and arg.valid then
      --~ return "player " .. tostring(arg.index) .. " (\"" .. arg.name .. "\")"
    --~ -- Argument was an entity
    --~ elseif type(arg) == "table" and arg.object_name == "LuaEntity" and arg.valid then
      --~ return arg.type .. " \"" .. arg.name .. "\" (" .. tostring(arg.unit_number) .. ")"
    --~ -- Argument was a recipe
    --~ elseif type(arg) == "table" and arg.object_name == "LuaRecipe" and arg.valid then
      --~ return arg.type .. " \"" .. arg.name .. "\""
    --~ -- Argument was something else
    --~ else
      --~ return serpent.line(arg)
    --~ end
  --~ end
  common.argprint = function(arg)
    -- Debugging is off
    local ret = common.is_debug and "nil" or nil

    -- Debugging must be on, and arg must not be nil
    if common.is_debug and arg then
      local arg_type = type(arg)
      --~ -- Argument was a string
      --~ if arg_type == "string" then
        --~ ret = arg
      -- Argument was a table. Look inside it!
      if arg_type == "table" then
        -- Control stage
        if game then
          -- Argument was player entity
          if arg.object_name == "LuaPlayer" and arg.valid then
            --~ return "player " .. tostring(arg.index) .. " (\"" .. arg.name .. "\")"
            ret = string.format("%s %s (\"%s\")", arg.object_name, arg.index, arg.name)

          -- Argument was a force
          elseif arg.object_name == "LuaForce" and arg.valid then
            --~ return arg.type .. " \"" .. arg.name .. "\" (" .. tostring(arg.unit_number) .. ")"
            ret = string.format("%s %s (\"%s\")", arg.object_name, arg.index, arg.name)

          -- Argument was a surface
          elseif arg.object_name == "LuaSurface" and arg.valid then
            --~ return arg.type .. " \"" .. arg.name .. "\" (" .. tostring(arg.unit_number) .. ")"
            ret = string.format("%s %s (\"%s\")", arg.object_name, arg.index, arg.name)

          -- Argument was a recipe
          elseif arg.object_name == "LuaRecipe" and arg.valid then
            --~ return arg.type .. " \"" .. arg.name .. "\""
            ret = string.format("%s \"%s\"", arg.object_name, arg.name)

          -- Argument was an entity
          elseif arg.object_name == "LuaEntity" and arg.valid then
            --~ return arg.type .. " \"" .. arg.name .. "\" (" .. tostring(arg.unit_number) .. ")"
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
          --~ args[#args + 1] = line and serpent.line(table.deepcopy(v)) or
                                      --~ serpent.block(table.deepcopy(v))
          args[#args + 1] = line and serpent.line(v) or serpent.block(v)
        -- OTHER VALUE
        else
          args[#args + 1] = v
        end
      end
      if #args == 0 then
        args[1] = "nil"
      end
      args.n = #args


      --~ -- Print the message text to log
      --~ if common.debug_to_log then
        --~ log(string.format(tostring(msg), table.unpack(args)))
      --~ end

      --~ -- Print the message text to the game
      --~ if game and common.debug_to_game then
        --~ game.print(string.format(tostring(msg), table.unpack(args)))
      --~ end

      -- Format the message just once!
      msg = string.format(tostring(msg), table.unpack(args))
      -- Print the message text to log
      if common.debug_to_log then
        log(msg)
      end

      -- Print the message text to the game
      if game and common.debug_to_game then
        game.print(msg)
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
  -- Print message if data for additional prototypes have been read
  -- data:      Prototype data
  -- list:      List of the subtables in data that we must check
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

    --~ local proto_name = proto and proto.name or common.arg_err(proto)
    --~ local proto_type = proto and proto.type or common.arg_err(proto)

    common.check_args(proto, "table")
    common.check_args(proto.name, "string")
    common.check_args(proto.type, "string")

    mode = (type(mode) == "string") and mode or "Changed"
    local preposition = (mode:lower() == "added") and "to" or
                          (mode:lower() == "removed") and "from" or
                          "of"
    --~ common.writeDebug("%s %s %s %s \"%s\".", {mode, desc, preposition, proto_type, proto_name})
    common.writeDebug("%s %s %s %s \"%s\".", {mode, desc, preposition, proto.type, proto.name})
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
--~ -- common.entered_function({arg, arg_type, desc})
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
common.writeDebug("Argument is a table!")
      --~ -- local object_type = arg.object_name and arg.object_name:lower() or
                            --~ -- arg.type and arg.type:lower() or
                            --~ -- "table"
      local object_type = arg.object_name and arg.object_name:lower() or
                            arg.type and arg.type:lower()
common.show("Expect arg_type", arg_type)
common.show("Type of argument", object_type)
      --~ -- if arg_type ~= id and arg_type ~= "table" then
      if arg_type ~= object_type and arg_type ~= "table" then
        check = false
      end
    -- Default argument, it should match the string returned by the type() function!
    elseif type(arg) ~= arg_type then
      check = false
    end

    if not check then
      common.arg_err(arg or "nil", desc or arg_type or "nil")
    end
--~ -- common.entered_function("leave")
    return true
  end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
  log("Leaving file " .. debug.getinfo(1).source)

return common
