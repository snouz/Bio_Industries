------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                BIO-CANNON STUFF                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                             Local variables/tables                             --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- ManagedLuaBootstrap instance from ErLib
local bio_cannon_script = BioInd.erlib.Events.get_managed_script("bio_cannon")

-- Eradicator's Library uses the on_configuration_changed event for on_init as well.
-- If the mod is added to an existing game, the event will trigger two times, but
-- we only need to run the code once, so we check for this flag.
local initialized

-- Things put in here will be visible from other files
local BI_bio_cannon = {}

-- The global tables used for Bio cannons and their radars. We'll get them when the
-- game is initialized in on_configuration_changed!
local cannons, radars

-- How often do we check the radars for electricity?
local action_interval = 120


-- Firing the Bio cannon will have different effects, depending on the ammo used.
local Bio_Cannon_Fired = {
  base_pollution = 100,
  base_unit_count = 100,
  base_unit_search_distance = 500,
  modifiers = {
    ["BI_cannon-ammo-proto_create_pollution"] = 0.5,
    ["BI_cannon-ammo-basic_create_pollution"] = 0.75,
    ["BI_cannon-ammo-poison_create_pollution"] = 1,
  }
}

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Local functions                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
local function get_compound_entity_tables()
  cannons = cannons or global[BioInd.compound_entities["bi-bio-cannon"].tab]
  radars  = radars or global[BioInd.compound_entities["bi-bio-cannon"].add_global_tables.radar]
end


local function clean_up_check_tables()
  BioInd.debugging.entered_function()

  if not initialized then

    local checks = global.checks.bio_cannon
    local current_tick = game.tick

    for tick, t in pairs(check.ticks) do
      if tick < current.tick then
        check.ticks[tick] = nil
        BioInd.writeDebug("Removed global.checks.bio_cannon.tick[%s]", tick)
      end
    end

    for cannon, tick in pairs(check.cannons) do
      if not (cannons[cannon] and cannons[cannon].base and cannons[cannon].base.valid) then
        check.cannons[cannon] = nil
        BioInd.writeDebug("Removed global.checks.bio_cannon.cannons[%s]", cannon)
      end
    end

    initialized = true
  end

  BioInd.debugging.entered_function("leave")
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Functions visible from other files                       --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
--            Add the cannon to the table of entities to check at tick            --
------------------------------------------------------------------------------------
-- This will be called when a new Bio cannon radar has been placed (next tick), and
-- when checks are scheduled normally (action_interval)
--
BI_bio_cannon.add_cannon_to_checks = function(cannon_id, current_tick, delay)
  BioInd.debugging.entered_function({cannon_id, delay})

  BioInd.debugging.check_args(cannon_id, "number", "Bio-cannon unit_number")
  BioInd.debugging.check_args(current_tick, "number", "tick")
  BioInd.debugging.check_args(delay, "number", "delay")

  clean_up_check_tables()

  local next_action = current_tick + delay

  -- If this is the first Bio cannon to be checked on that tick, add it to
  -- the list and enqueue the action
  if not global.checks.bio_cannon.ticks[next_action] then
    global.checks.bio_cannon.ticks[next_action] = {cannon_id}
    BioInd.erlib.TickedAction.enqueue('bio_cannon', 'check_bio_cannon_radars', delay)
    BioInd.debugging.writeDebug("Scheduled next check for tick %s.", next_action)

  -- If we have already registered a TickedAction for that tick, just add
  -- the Bio cannon to the list
  else
    table.insert(global.checks.bio_cannon.ticks[next_action], cannon_id)
    BioInd.debugging.writeDebug("Added cannon %s to list of entities checked on tick %s.",
                                {cannon_id, next_action})
  end
  global.checks.bio_cannon.cannons[cannon_id] = next_action

  BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
--    If the radar has power, activate the cannon and schedule the next check!    --
------------------------------------------------------------------------------------
BI_bio_cannon.schedule_radar_check = function(cannon_id, tick)
  BioInd.debugging.entered_function({cannon_id, tick})

  BioInd.debugging.check_args(cannon_id, "number", "Bio-cannon unit_number")

  if not cannons then
    get_compound_entity_tables()
  end

  local cannon = cannons[cannon_id]

  -- A Bio-cannon with that unit_number is registered in our tables
  if cannon then

    local cannon_check = global.checks.bio_cannon.cannons[cannon_id]

    -- Get the entities!
    cannon = cannon.base
    local radar = cannons[cannon_id].radar

    -- Something has gone seriously wrong! Destroy the radar, and remove
    -- cannon + radar from the tables!
    if not (cannon and cannon.valid and radar and radar.valid) then
      BioInd.debugging.writeDebug("Cannon and/or radar don't exist. Cleaning up!")
      global.checks.bio_cannon.cannons[cannon_id] = nil
      BI_scripts.event_handlers.On_Pre_Remove({entity = cannon})

    -- Cannon exists, but radar has no power. Turn off the cannon!
    elseif radar.energy == 0 then
      if cannon.active then
        cannon.active = false
        global.checks.bio_cannon.cannons[cannon_id] = nil
        BioInd.debugging.writeDebug("Turned off %s because its radar doesn't have power!",
                          {BioInd.debugging.argprint(cannon)})
      end

    -- Everything is alright!
    else
      -- Activate cannon
      if not cannon.active then
        cannon.active = true
        BioInd.debugging.writeDebug("Turned on %s!", {BioInd.debugging.argprint(cannon)})
      end

      -- Don't schedule a new check for this cannon if it's already waiting for one!
      --~ if not global.checks.bio_cannon.cannons[cannon_id] then
BioInd.debugging.show("cannon_check", cannon_check)
BioInd.debugging.show("global.checks.bio_cannon.cannons[cannon_id]", global.checks.bio_cannon.cannons[cannon_id])
      if (not cannon_check) or cannon_check <= tick then
        BI_bio_cannon.add_cannon_to_checks(cannon_id, tick, action_interval)
      else
        BioInd.debugging.writeDebug("%s already has a check scheduled for tick %s!",
                                    {BioInd.debugging.argprint(cannon), cannon_check})
      end
    end
  -- The Bio cannon doesn't exist anymore. Remove it from the checks table!
  else
    global.checks.bio_cannon.cannons[cannon_id] = nil
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--            Bio cannon should only be active if the radar has power!            --
------------------------------------------------------------------------------------
BI_bio_cannon.check_radars = function(tick)
  BioInd.debugging.entered_function({tick})

    BioInd.debugging.writeDebug("Must check %s entities!", #global.checks.bio_cannon.ticks[tick])
    for c, cannon_id in pairs(global.checks.bio_cannon.ticks[tick] or {}) do
      BI_bio_cannon.schedule_radar_check(cannon_id, tick)
    end

    global.checks.bio_cannon.ticks[tick] = nil
    BioInd.debugging.writeDebug("Removed global.checks.bio_cannon.ticks[%s]!", tick)

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 AutoCache stuff                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--       Radar completed a sector scan. Activate cannon and schedule check!       --
------------------------------------------------------------------------------------
bio_cannon_script.on_event(defines.events.on_sector_scanned, function(event)
  BioInd.debugging.entered_event(event)

  local radar = event.radar

  if not radars then
    get_compound_entity_tables()
  end


  -- Only act if radar belongs to a bio-cannon!
  local bio_cannon_id = radars and radars[radar.unit_number]
  if bio_cannon_id then
    BI_bio_cannon.schedule_radar_check(bio_cannon_id, event.tick)
  end

  BioInd.debugging.entered_event(event, "leave")
end)



------------------------------------------------------------------------------------
--          Bio cannon has been fired: Create pollution and send enemies!         --
------------------------------------------------------------------------------------
bio_cannon_script.on_event(defines.events.on_script_trigger_effect, function(event)
  BioInd.debugging.entered_event(event)
  local Bio_Cannon = event.source_entity
  local position = Bio_Cannon and Bio_Cannon.position or event.source_position
  local surface = event.surface_index and game.surfaces[event.surface_index]

  local data = Bio_Cannon_Fired
  local modifier = event.effect_id and data.modifiers[event.effect_id]

  if modifier and position and surface then
    local unit_count = math.floor(game.forces.enemy.evolution_factor * data.base_unit_count * modifier)
    local unit_search_distance = data.base_unit_search_distance * modifier

    -- The firing of the Hive Buster will cause pollution
    surface.pollute(position, data.base_pollution * modifier)

    -- Send off enemies to retaliate
    if Bio_Cannon then
      -- Attack cannon
      surface.set_multi_command{
        command = {
          type = defines.command.attack,
          target = Bio_Cannon,
          distraction = defines.distraction.by_enemy
        },
        unit_count = unit_count,
        unit_search_distance = unit_search_distance
      }
      BioInd.debugging.writeDebug("Looking for %s enemies in a radius of %s tiles",
                        {unit_count, unit_search_distance})
    else
      -- If cannon doesn't exist anymore, attack position or anything on the way to it
      surface.set_multi_command{
        command = {
          type = defines.command.attack_area,
          destination = position,
          radius = 5,
          distraction = defines.distraction.by_anything
        },
        unit_count = unit_count,
        unit_search_distance = unit_search_distance
      }
      BioInd.debugging.writeDebug("Looking for %s enemies in a radius of %s tiles",
                        {unit_count, unit_search_distance})
    end
  end
  BioInd.debugging.entered_event(event, "leave")
end)



------------------------------------------------------------------------------------
--                         Initialize a new or loaded game                        --
------------------------------------------------------------------------------------
bio_cannon_script.on_configuration_changed(function(event)
  event = event or {}; event.name = "on_configuration_changed"
  BioInd.debugging.entered_event(event)

  -- If the mod was added to an existing game, this event has already been triggered
  -- for on_init, so we can skip it for on_configuration_changed!
  if initialized then
    BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    return
  end

  -- Make sure all bio cannons can be identified via their radars
  get_compound_entity_tables()

  for c, cannon in pairs(cannons or {}) do
    radars[cannon.radar.unit_number] = cannon.base.unit_number
  end

  -- Add a table where we can schedule checks for unpowered radars
  global.checks.bio_cannon = global.checks.bio_cannon or {
    -- Key: tick
    -- Value: Array of cannons that will be checked on that tick
    ticks   = {},
    -- Only schedule checks for cannons that aren't waiting for a check yet!
    -- Key: unit_number
    -- Value: tick for next action
    cannons = {}
  }

  -- Mark game as initialized
  initialized = true

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_bio_cannon
