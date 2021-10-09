------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               POLLUTION DETECTOR                               --
--  Should have better performance than mods like Shorty's "Pollution detector"!  --
--  The pollution value will be the same at any location inside a chunk. If there --
--  are several sensors in one chunk, checking each sensor individually is more   --
--  expensive then fetching the pollution value once and sharing it between all   --
--  sensors in the same chunk. Also, when checking each sensor individually, it's --
--  possible that sensors inside the same chunk will not be in sync because they  --
--  are updated on different ticks.                                               --
--  In the best case (no change of pollution value), we just check the pollution  --
--  of each cunk with at least one sensor inside it. We only need to set signals  --
--  on the individual sensors when they are placed and when the pollution value   --
--  has changed.                                                                  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()


local BI_sensors = {}
local pollution_sensor_script = BioInd.erlib.Events.get_managed_script("pollution_sensor")

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                             Local variables/tables                             --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local update_interval = 60

-- Signals shown by the sensors
local clean = {
  {index = 1, signal = {type = "virtual", name = "bi_signal_clean_particle"}, count = 1}
}

local dirty = { -- This is just a template: we'll set count later to real data!
  {index = 1, signal = {type = "virtual", name = "bi_signal_pollution_particle"}}
}

-- Eradicator's Library uses the on_configuration_changed event for on_init as well.
-- If the mod is added to an existing game, the event will trigger two times, but
-- we only need to run the code once, so we check for this flag.
local initialized

-- If a game is loaded and the mod has been updated, both on_load and
-- on_configuration_changed will trigger. Use this flag to skip checking for the
-- "Picker Dollies" event in on_configuration_changed!
local checked_picker



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                     Get chunk position from entity position                    --
------------------------------------------------------------------------------------
local function get_chunk(entity)
  local position, chunk

  if entity then
    -- Make sure we have position.x and position.y
    position = BioInd.normalize_position(entity.position)

    -- surface.get_pollution works at the position of a tile on the surface, but we
    -- want to store chunks (32 tiles x 32 tiles). So we first transform tile position
    -- to chunk position and then transform that again to get a position representing
    -- all tiles in that chunk.
    chunk = position and {
      x = math.floor(position.x / 32) * 32,
      y = math.floor(position.y / 32) * 32
      --~ x = math.floor(position.x / 32),
      --~ y = math.floor(position.y / 32)
    }
  end
  return chunk
end


------------------------------------------------------------------------------------
--                   Check whether entity is a pollution sensor                   --
------------------------------------------------------------------------------------
local function is_sensor(entity)
  --~ BioInd.debugging.entered_function({entity})
  return type(entity) == "table" and
          entity.object_name == "LuaEntity" and
          entity.name == BioInd.pollution_sensor_name
end


------------------------------------------------------------------------------------
--                       Choose signal shown by the sensors                       --
------------------------------------------------------------------------------------
local function get_signal(pollution)
  BioInd.debugging.entered_function({pollution})

  local signal

  if (pollution or 0) > 0 then
    signal = dirty
    signal[1].count = pollution
  else
    signal = clean
  end

  BioInd.debugging.entered_function("leave")
  return signal
end


------------------------------------------------------------------------------------
--                       Register event for "Picker Dollies"                      --
------------------------------------------------------------------------------------
local function check_picker_dollies()
  BioInd.debugging.entered_function()

  if BioInd.mod_events.picker then
    pollution_sensor_script.on_event(BioInd.mod_events.picker,
      BI_sensors.moved_entity)
    BioInd.debugging.writeDebug("Registered on_moved event (\"Picker Dollies\") for pollution sensors!")
  end

  -- Set flag to avoid that the function is called again
  checked_picker = true

  BioInd.debugging.entered_function("leave")
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Functions visible from other files                       --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                               Register new sensor                              --
------------------------------------------------------------------------------------
BI_sensors.add_sensor = function(entity)
  BioInd.debugging.entered_function({entity})

  entity = is_sensor(entity) and entity.valid and
            entity or BioInd.debugging.arg_err(entity, "pollution sensor")

  if entity.name == BioInd.pollution_sensor_name then
    local tab = global.checks.bi_pollution_sensor

    local chunk = get_chunk(entity)
    local x, y = chunk.x, chunk.y
    local surface = entity.surface.name

    -- No need to open the combinator, changing the signal won't have any effect!
    entity.operable = false


    -- Store entity and position data
    tab.sensors[entity.unit_number] = {
      entity = entity,
      chunk = chunk,
      surface = surface
    }

    -- Add entity to chunk data
    tab.chunk_sensors[surface] = tab.chunk_sensors[surface] or {}
    tab.chunk_sensors[surface][x] = tab.chunk_sensors[surface][x] or {}

    -- New chunk?
    if not tab.chunk_sensors[surface][x][y] then
      -- Add new chunk to list of chunk positions. This way, we can easily get the
      -- number of chunks that we must check when distributing chunks over ticks.
      tab.chunk_positions[#tab.chunk_positions + 1] = {chunk = chunk, surface = surface}

      -- Initialize table for entities in the new chunk
      tab.chunk_sensors[surface][x][y] = {}

    -- There are already sensors in this chunk. Get the pollution value
    -- from the first sensor we can find and set the signal!
    else
      local refer_to = next(tab.chunk_sensors[surface][x][y])
      local pollution = tab.sensors[refer_to].pollution
      tab.sensors[entity.unit_number].pollution = pollution or 0
      entity.get_control_behavior().parameters = get_signal(pollution)
    end

    tab.chunk_sensors[surface][x][y][entity.unit_number] = true
  end
  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                            Remove sensor from lists                            --
------------------------------------------------------------------------------------
BI_sensors.remove_sensor = function(entity)
  BioInd.debugging.entered_function({entity})

  entity = is_sensor(entity) and entity or BioInd.debugging.arg_err(entity, "pollution sensor")

  local tab = global.checks.bi_pollution_sensor

  if tab.sensors[entity.unit_number] then

    local chunk = tab.sensors[entity.unit_number].chunk
    local surface = tab.sensors[entity.unit_number].surface
    local x, y = chunk.x, chunk.y

    -- Remove entity from chunk tables
    if tab.chunk_sensors[surface] and
          tab.chunk_sensors[surface][x] and
          tab.chunk_sensors[surface][x][y] then
      tab.chunk_sensors[surface][x][y][entity.unit_number] = nil

      -- Remove chunks from table if there are no sensors in it!
      if not next(tab.chunk_sensors[surface][x][y]) then
        tab.chunk_sensors[surface][x][y] = nil

        if not next(tab.chunk_sensors[surface][x]) then
          tab.chunk_sensors[surface][x] = nil

          if not next(tab.chunk_sensors[surface]) then
            tab.chunk_sensors[surface] = nil
          end
        end
      end
    end

    -- Remove entity from sensor table
    tab.sensors[entity.unit_number] = nil
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                Sensor was moved ("Picker Dollies") or teleported               --
------------------------------------------------------------------------------------
BI_sensors.moved_entity = function(event)
  BioInd.debugging.entered_event(event)

  local tab = global.checks.bi_pollution_sensor
  local entity = event.moved_entity

  -- We've already registered the sensor. Check if we must update its chunk data!
  if tab.sensors[entity.unit_number] then
    local old_chunk     = tab.sensors[entity.unit_number].chunk
    local old_surface   = tab.sensors[entity.unit_number].surface
    local new_chunk     = get_chunk(entity)
    local new_surface   = entity.surface.name

    -- Sensor has been moved to new chunk, update the tables!
    if (old_surface ~= new_surface) or
        (old_chunk.x ~= new_chunk.x) or
        (old_chunk.y ~= new_chunk.y) then
      BI_sensors.remove_sensor(entity)
      BI_sensors.add_sensor(entity)
      BioInd.debugging.writeDebug("%s has been moved to another chunk!", {BioInd.debugging.argprint(entity)})
    end

  -- For some reason, the sensor hasn't been registered yet. Add it to the tables!
  else
    BI_sensors.add_sensor(entity)
  end

  BioInd.debugging.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                          Check pollution in the chunks                         --
------------------------------------------------------------------------------------
BI_sensors.check_chunks = function(event)
  BioInd.debugging.entered_event(event)

  local tab = global.checks.bi_pollution_sensor
  local chunk, surface, pollution, signal
  local sensor, x, y

  -- Don't check all chunks at once (Thanks to eradicator!)
  local offset = event.tick % update_interval
  for i = table_size(tab.chunk_positions) - offset, 1, -1 * update_interval do
  BioInd.debugging.show("Tick", game.tick)
    chunk = tab.chunk_positions[i] and tab.chunk_positions[i].chunk
    surface = chunk and tab.chunk_positions[i].surface

    -- Remove chunk from tab.chunk_positions if there is no sensor in it!
    x, y = chunk.x, chunk.y
    if not (tab.chunk_sensors[surface] and
            tab.chunk_sensors[surface][x] and tab.chunk_sensors[surface][x][y]) then
      table.remove(tab.chunk_positions, i)

    -- Get pollution for the chunk
    else
      pollution = math.floor(game.surfaces[surface].get_pollution(chunk) + 0.9999)

      -- Much cheaper than other mods that act per sensor instead of chunk!
      if pollution ~= tab.chunk_positions[i].pollution then
        -- Update value stored with the chunk
        tab.chunk_positions[i].pollution = pollution
        signal = get_signal(pollution)

        -- Update sensors and set signals
        for sensor, s in pairs(tab.chunk_sensors[surface][x][y]) do
          BioInd.debugging.writeDebug("sensor: %s\ts: %s", {sensor, s})
          tab.sensors[sensor].pollution = pollution
          tab.sensors[sensor].entity.get_control_behavior().parameters = signal
        end
      end
    end
  end

  BioInd.debugging.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--   New pollution sensor: Add it to tables and register on_tick, if necessary!   --
------------------------------------------------------------------------------------
pollution_sensor_script.on_event(BioInd.erlib.Events.events.on_entity_created, function(event)
  BioInd.debugging.entered_event(event)

  -- Bail out early if the created entity was not a pollution sensor!
  local entity = event.created_entity
  if entity.name ~= BioInd.pollution_sensor_name or entity.type ~= BioInd.pollution_sensor_type then
    BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    return
  end

  -- If no sensor is registered yet, activate on_tick!
  if not (global.checks.bi_pollution_sensor and next(global.checks.bi_pollution_sensor.sensors)) then
    pollution_sensor_script.on_event(defines.events.on_tick, BI_sensors.check_chunks)
    BioInd.debugging.writeDebug("Turned on on_tick for pollution sensors!")
  end

  -- Register the new sensor
  BioInd.debugging.writeDebug("Adding %s!", {BioInd.debugging.argprint(entity)})
  BI_sensors.add_sensor(entity)

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--      Removed pollution sensor: Remove it from tables and turn off on_tick!     --
------------------------------------------------------------------------------------
local remove_events = {
  defines.events.on_pre_player_mined_item,
  defines.events.on_robot_pre_mined,
  --~ defines.events.on_player_mined_entity,
  --~ defines.events.on_robot_mined_entity,
  defines.events.on_entity_died,
  defines.events.script_raised_destroy
}

pollution_sensor_script.on_event(remove_events, function(event)
  BioInd.debugging.entered_event(event)

  -- Bail out early if the created entity was not a pollution sensor!
  local entity = event.entity
  if entity.name ~= BioInd.pollution_sensor_name or entity.type ~= BioInd.pollution_sensor_type then
    BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    return
  end

  -- Remove sensor from tables
  BioInd.debugging.writeDebug("Unregistering %s!", {BioInd.debugging.argprint(entity)})
  BI_sensors.remove_sensor(entity)

  -- If there is no sensor left, deactivate on_tick!
  local tab = global.checks.bi_pollution_sensor
  if not (tab and tab.sensors and next(tab.sensors)) then
    pollution_sensor_script.on_event(defines.events.on_tick, nil)
    BioInd.debugging.writeDebug("Turned off on_tick for pollution sensors!")

    -- Clean up tables
    tab.chunk_positions = {}
    tab.chunk_sensors   = {}
  end

  BioInd.debugging.entered_event(event, "leave")
end)



------------------------------------------------------------------------------------
--                       Register event for "Picker Dollies"                      --
------------------------------------------------------------------------------------
if BioInd.mod_events.picker then
  pollution_sensor_script.on_event(BioInd.mod_events.picker, function(event)
    BioInd.debugging.entered_event(event)

    local entity = event.moved_entity
    if entity and entity.valid then
      BI_sensors.moved_entity(entity)
    end

    BioInd.debugging.entered_event(event, "leave")
  end)
  BioInd.debugging.writeDebug("Registered event for \"Picker Dollies\"!")
end


------------------------------------------------------------------------------------
--                        Register events on loading a game                       --
------------------------------------------------------------------------------------
pollution_sensor_script.on_load(function()
  local event = {name = "on_load"}
  BioInd.debugging.entered_event(event)

  -- If "Picker Dollies" is active, register its event!
  check_picker_dollies()

  -- If there already are pollution sensors, activate on_tick for pollution checks!
  if global.checks.bi_pollution_sensor then
    local enabled = BioInd.recheck_conditional_handlers({
      tables = {global.checks.bi_pollution_sensor.sensors},
      bootstrap_instance = pollution_sensor_script,
      event_name = defines.events.on_tick,
      event_handler = BI_scripts.pollution_sensor.check_chunks
    })
    BioInd.debugging.writeDebug("Turned %s on_tick for pollution sensors!", {enabled and "on" or "off"})
  end

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                         Initialize a new or loaded game                        --
------------------------------------------------------------------------------------
pollution_sensor_script.on_configuration_changed(function(event)
  event = event or {}; event.name = "on_configuration_changed"
  BioInd.debugging.entered_event(event)

  -- If the mod was added to an existing game, this event has already been triggered
  -- for on_init, so we can skip it for on_configuration_changed!
  if initialized then
    BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    return
  end

  -- Initialize tables
  global.checks.bi_pollution_sensor = global.checks.bi_pollution_sensor or {
    -- Stores the sensors in a chunk
    chunk_sensors = {},
    -- List of chunk positions (needed for distributing checks over ticks)
    chunk_positions = {},
    -- Stores entity and its chunk position
    sensors = {}
  }
  BioInd.debugging.writeDebug("Initialize tables for pollution detector.")


  -- Register event from "Picker Dollies", if necessary!
  if not checked_picker then
    check_picker_dollies()
  end

  -- Mark game as initialized
  initialized = true

  BioInd.debugging.entered_event(event, "leave")
end)

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_sensors
