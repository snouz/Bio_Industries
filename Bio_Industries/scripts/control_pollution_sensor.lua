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
BioInd.entered_file()


local BI_sensors = {}


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
    }
  end
  return chunk
end


------------------------------------------------------------------------------------
--                   Check whether entity is a pollution sensor                   --
------------------------------------------------------------------------------------
local function is_sensor(entity)
  --~ BioInd.entered_function({entity})
  return type(entity) == "table" and
          entity.object_name == "LuaEntity" and
          entity.name == BioInd.pollution_sensor_name
end


------------------------------------------------------------------------------------
--                       Choose signal shown by the sensors                       --
------------------------------------------------------------------------------------
local function get_signal(pollution)
  BioInd.entered_function({pollution})

  local signal

  if (pollution or 0) > 0 then
    signal = dirty
    signal[1].count = pollution
  else
    signal = clean
  end

  BioInd.entered_function("leave")
  return signal
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
  BioInd.entered_function({entity})

  entity = is_sensor(entity) and entity.valid and
            entity or BioInd.arg_err(entity, "pollution sensor")

  if entity.name == BioInd.pollution_sensor_name then
    local tab = global.bi_pollution_tables

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
  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--                            Remove sensor from lists                            --
------------------------------------------------------------------------------------
BI_sensors.remove_sensor = function(entity)
  BioInd.entered_function({entity})

  entity = is_sensor(entity) and entity or BioInd.arg_err(entity, "pollution sensor")

  local tab = global.bi_pollution_tables

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

  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--                Sensor was moved ("Picker Dollies") or teleported               --
--   We already checked in the event handler that the entity is a valid sensor!   --
------------------------------------------------------------------------------------
BI_sensors.moved_entity = function(entity)
  BioInd.entered_function({entity})

  local tab = global.bi_pollution_tables

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
      BioInd.writeDebug("%s has been moved to another chunk!", {BioInd.argprint(entity)})
    end

  -- For some reason, the sensor hasn't been registered yet. Add it to the tables!
  else
    BI_sensors.add_sensor(entity)
  end

  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--                          Check pollution in the chunks                         --
------------------------------------------------------------------------------------
BI_sensors.check_chunks = function(event)
  BioInd.entered_function({event})

  local tab = global.bi_pollution_tables
  local chunk, surface, pollution, signal
  local sensor, x, y

  -- Don't check all chunks at once (Thanks to eradicator!)
  local offset = event.tick % update_interval
  for i = table_size(tab.chunk_positions) - offset, 1, -1 * update_interval do
    chunk = tab.chunk_positions[i] and tab.chunk_positions[i].chunk
    surface = chunk and tab.chunk_positions[i].surface

    -- Remove chunk from tab.chunk_positions if there is no sensor in it!
    -- (The following chunks will be moved down, so we must decrement i or we'll miss the
    -- next chunk.)
    x, y = chunk.x, chunk.y
    if not (tab.chunk_sensors[surface] and
            tab.chunk_sensors[surface][x] and tab.chunk_sensors[surface][x][y]) then
      table.remove(tab.chunk_positions, i)
      i = i - 1

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
          BioInd.writeDebug("sensor: %s\ts: %s", {sensor, s})
          tab.sensors[sensor].pollution = pollution
          tab.sensors[sensor].entity.get_control_behavior().parameters = signal
        end
      end
    end
  end

  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")

return BI_sensors
