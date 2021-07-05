local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(false)

local update_interval = 30
local floor = math.floor
global.Pollution_Detectors = {}

-- stepping from tick modulo with stride by eradicator
local function OnTick(event)
  local offset = event.tick % update_interval
  for i=#global.Pollution_Detectors - offset, 1, -1 * update_interval do  
    local pollution_detector = global.Pollution_Detectors[i]
    local pollution_count = floor(pollution_detector.surface.get_pollution({pollution_detector.position.x, pollution_detector.position.y}) + 0.9999) -- * 60)
    local poll_signal = {
      {index = 1, signal = {type = "virtual", name = "bi_signal_pollution_particle"}, count = pollution_count}
    }
    local clean_signal = {
      {index = 1, signal = {type = "virtual", name = "bi_signal_clean_particle"}, count = 1}
    }
    if pollution_count > 0 then
      pollution_detector.get_control_behavior().parameters = poll_signal
    else
      pollution_detector.get_control_behavior().parameters = clean_signal
    end
  end
end


local function OnEntityRemoved(event)
  if event.entity.name == "bi-pollution-sensor" then

    for i=#global.Pollution_Detectors, 1, -1 do
      if global.Pollution_Detectors[i].unit_number == event.entity.unit_number then
        table.remove(global.Pollution_Detectors, i)
      end
    end
    
    -- unregister when last sensor was removed
    if #global.Pollution_Detectors == 0 then
      Event.register(defines.events.on_tick, nil)
      Event.register({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, nil)
    end
  end
end

---- runtime Events ----
local function OnEntityCreated(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end

  if entity.name == "bi-pollution-sensor" then
    table.insert(global.Pollution_Detectors, entity)
    
    -- register to events after placing the first sensor
    if #global.Pollution_Detectors == 1 then
      Event.register(defines.events.on_tick, OnTick)
      Event.register({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, OnEntityRemoved)
    end
  end
end

do---- Init ----
local function init_Pollution_Detectors()
  -- gather all pollution detectors on every surface in case another mod added some
  
   for _, surface in pairs(game.surfaces) do
    global.pollution_detectors = surface.find_entities_filtered {
      name = "bi-pollution-sensor",
    }
    for _, pollution_detector in pairs(global.pollution_detectors) do
      table.insert(global.Pollution_Detectors, pollution_detector)
    end
  end
end

local function init_events()
  Event.register({defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive, defines.events.on_entity_cloned}, OnEntityCreated)
  if global.Pollution_Detectors and next(global.Pollution_Detectors) then
    Event.register(defines.events.on_tick, OnTick)
    Event.register({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, OnEntityRemoved)
  end
end

Event.on_load(function()
  init_events()
end)

Event.on_init(function()
  init_Pollution_Detectors()
  init_events()
end)

end
