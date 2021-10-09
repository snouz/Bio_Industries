------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                 Event handlers and the functions called by them                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                Local definitions                               --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Use eradicator's EventManagerLite!
script = BioInd.erlib.Events.get_managed_script("BI_generic_script")

-- Things that are only needed when a new game starts or an existing game is loaded
--~ local set_startup_items         = require("scripts.startup_items")
local init_functions            = require("scripts.init_functions")
local settings_changed          = require("scripts.settings_changed")

local event_handlers = {}


------------------------------------------------------------------------------------
--                   Define default and optional event handlers                   --
------------------------------------------------------------------------------------
local BI_events = {
  -- We will always need these events!
  On_Built = {
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.script_raised_built,
    defines.events.script_raised_revive
  },

  On_Pre_Remove = {
    defines.events.on_pre_player_mined_item,
    defines.events.on_robot_pre_mined,
    --~ defines.events.on_player_mined_entity,
    --~ defines.events.on_robot_mined_entity,
  },

  On_Death = {
    defines.events.on_entity_died,
    defines.events.script_raised_destroy
  },
}

BioInd.mod_events = {}

local function add_optional_events()
  BioInd.debugging.entered_function()

-- Depending on "Picker Dollies"
  BioInd.mod_events.picker = remote.interfaces["PickerDollies"] and
                              remote.interfaces["PickerDollies"]["dolly_moved_entity_id"] and
                              remote.call("PickerDollies", "dolly_moved_entity_id")
BioInd.debugging.show("PickerDollies event ID", BioInd.mod_events.picker)

  if BioInd.mod_events.picker then
    BI_events.On_Moved = BioInd.mod_events.picker
    BioInd.event_names[BioInd.mod_events.picker] = "dolly_moved_entity"
    BioInd.debugging.writeDebug("Added handler for \"%s\" from \"PickerDollies\".",
                                {BioInd.event_names[BioInd.mod_events.picker]})
  end

  BioInd.debugging.entered_function("leave")
end


-- Register event handlers
local function register_events()
  BioInd.debugging.entered_function()

  for handler, events in pairs(BI_events) do
    script.on_event(events, event_handlers[handler])
    BioInd.debugging.writeDebug("Added event handler %s.", {handler})
  end

  BioInd.debugging.entered_function("leave")
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                            on_configuration_changed                            --
--   (ErLib uses only one event for both on_init and on_configuration_changed!)   --
------------------------------------------------------------------------------------
script.on_configuration_changed(function(event)
BioInd.debugging.show("event", event)
  event = event or {}; event.name = "on_configuration_changed"
  BioInd.debugging.entered_event(event)


  --------------------------------------------------------------------
  -- Restore tables for compound entities
  --------------------------------------------------------------------
  BioInd.debugging.writeDebug("Initialize tables for compound entities.")
--~ init_functions.remove_compound_entities_from_global()
  init_functions.check_compound_entity_tabs()


  --------------------------------------------------------------------
  -- Restore/clean up tables used for entity checks
  --------------------------------------------------------------------
  -- Global table for schedules/data used to check different entities
  global.checks = global.checks or {}


  --------------------------------------------------------------------
  -- Settings
  --------------------------------------------------------------------
  -- Global table for storing the last state of certain mod settings
  BioInd.debugging.writeDebug("Setting up table for storing mod settings.")
  global.mod_settings = global.mod_settings or {}


  --------------------------------------------------------------------
  -- Remove obsolete renderings
  --------------------------------------------------------------------
  BioInd.debugging.writeDebug("Looking for obsolete renderings.")
  init_functions.remove_expired_renderings()


  --------------------------------------------------------------------
  -- Check for changed mod settings (remove tabs from global etc.)
  --------------------------------------------------------------------
  --~ if event.mod_startup_settings_changed then
    for c, change_setting in pairs(settings_changed) do
      BioInd.debugging.writeDebug("Running function settings_changed.%s().", c)
      change_setting()
    end
  --~ end

  --------------------------------------------------------------------
  -- Enable researched recipes
  --------------------------------------------------------------------
  for i, force in pairs(game.forces) do
    BioInd.debugging.writeDebug("Reset technology effects for force %s.", {force.name})
    force.reset_technology_effects()
  end


  --------------------------------------------------------------------
  -- Attach events
  --------------------------------------------------------------------
  add_optional_events()
  register_events()


  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                                     on_load                                    --
------------------------------------------------------------------------------------
script.on_load(function()
  local event = {name = "on_load"}
  BioInd.debugging.entered_event(event)

  -- Attach events
  add_optional_events()
  register_events()

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                    on_built_entity, on_robot_built_entity,                     --
--                   script_raised_built, script_raised_revive                    --
------------------------------------------------------------------------------------
event_handlers.On_Built = function(event)
  BioInd.debugging.entered_event(event)
  local entity = event.created_entity or event.entity
  if not (entity and entity.valid) then
    BioInd.debugging.arg_err(entity or "nil", "entity")
  end

  local surface = BioInd.is_surface(entity.surface) or
                    BioInd.debugging.arg_err(entity.surface or "nil", "surface")
  local position = BioInd.normalize_position(entity.position) or
                    BioInd.debugging.arg_err(entity.position or "nil", "position")
  local force = entity.force


  -- We can ignore ghosts -- if ghosts are revived, there will be
  -- another event that triggers where actual entities are placed!
  if entity.name == "entity-ghost" then
    BioInd.debugging.writeDebug("Built ghost of %s -- return!", {entity.ghost_name})
    return
  end

  BioInd.debugging.show("Built entity", BioInd.debugging.print_name_id(entity))

  local base_entry = BioInd.compound_entities[entity.name]
  local base = base_entry and entity

  -- We've found a compound entity!
  if base then
    -- Make sure we work with a copy of the original table! We don't want to
    -- remove anything from it for real.
    local hidden_entities = util.table.deepcopy(base_entry.hidden)

    BioInd.debugging.writeDebug("%s (%s) is a compound entity. Need to create %s", {base.name, base.unit_number, hidden_entities})
BioInd.debugging.show("hidden_entities", hidden_entities)
    local new_base
    local new_base_name = base_entry.new_base_name
    -- If the base entity is only an overlay, we'll replace it with the real base
    -- entity and raise an event. The hidden entities will be created in the second
    -- pass (triggered by building the final entity).
BioInd.debugging.show("base_entry.new_base_name", base_entry.new_base_name)
BioInd.debugging.show("base_entry.new_base_name == base.name", base_entry.new_base_name == base.name)
BioInd.debugging.show("base_entry.optional", base_entry.optional)

    if new_base_name and new_base_name ~= base.name then
      new_base = surface.create_entity({
        name = new_base_name,
        position = base.position,
        direction = base.direction,
        force = base.force,
        raise_built = true
      })
      new_base.health = base.health
      BioInd.debugging.show("Created final base entity", BioInd.debugging.print_name_id(new_base))

      base.destroy({raise_destroy = true})
      base = new_base
      BioInd.debugging.writeDebug("Destroyed old base entity!")

    -- Second pass: We've placed the final base entity now, so we can create the
    -- the hidden entities!
    else
BioInd.debugging.writeDebug("Second pass -- creating hidden entities!")
BioInd.debugging.show("base_entry", base_entry)

BioInd.debugging.writeDebug("global[%s]: %s", {base_entry.tab, global[base_entry.tab]})
BioInd.debugging.show("base.name", base.name)
BioInd.debugging.show("base.unit_number", base.unit_number)
BioInd.debugging.show("hidden_entities", hidden_entities)

      -- We must call create_entities even if there are no hidden entities (e.g. if
      -- the "Easy Gardens" setting is disabled and no hidden poles are required)
      -- because the compound entity gets registered there!
      BioInd.create_entities(global[base_entry.tab], base, hidden_entities)
      BioInd.debugging.writeDebug("Stored %s in table: %s",
                        {BioInd.debugging.print_name_id(base), global[base_entry.tab][base.unit_number]})
    end

  -- The built entity isn't one of our compound entities.
  else
BioInd.debugging.writeDebug("%s is not a compound entity!", {BioInd.debugging.print_name_id(entity)})

    -- If one of our hidden entities has been built, we'll have raised this event
    -- ourselves and have passed on the base entity.
    base = event.base_entity

    local entities = BioInd.compound_entities
BioInd.debugging.show("Base entity", BioInd.debugging.print_name_id(base))

    -- The hidden entities are listed with a common handle ("pole", "panel" etc.). We
    -- can get it from the reverse-lookup list via the entity type!
    local h_key = BioInd.HE_map_reverse[entity.type]
    BioInd.debugging.show("h_key", h_key or "nil")

    -- Arboretum radar -- we must add it to the table!
    if entity.type == "radar" and
      entity.name == entities["bi-arboretum-area"].hidden[h_key].name and base then
      --~ global.bi_arboretum_radar_table[entity.unit_number] = base.unit_number
      local tab = BioInd.compound_entities["bi-arboretum"].add_global_tables.radar
      global[tab][entity.unit_number] = base.unit_number
      entity.backer_name = ""
      BioInd.debugging.writeDebug("Added %s to global.bi_arboretum_radar_table",
                                  {BioInd.debugging.print_name_id(entity)})

    -- Bio-cannon radar -- we must add it to the table!
    elseif entity.type == "radar" and
      entity.name == entities["bi-bio-cannon"].hidden[h_key].name and base then
      --~ global.bi_bio_cannon_radar_table[entity.unit_number] = base.unit_number
      local tab = BioInd.compound_entities["bi-bio-cannon"].add_global_tables.radar
      global[tab][entity.unit_number] = base.unit_number
      entity.backer_name = ""
      BioInd.debugging.writeDebug("Added %s to global.bi_bio_cannon_radar_table",
                                  {BioInd.debugging.print_name_id(entity)})
      -- Check on next tick whether radar has power
      BI_scripts.bio_cannon.add_cannon_to_checks(base.unit_number, event.tick, 1)

    -- Electric poles -- we need to take care that they don't hook up to hidden poles!
    elseif entity.type == "electric-pole" then
      BI_scripts.poles.connect_poles(entity, base)

    -- A seedling has been planted
    elseif entity.name == "seedling" and not event.seedbomb then
      BI_scripts.trees.seed_planted(event)
      BioInd.debugging.writeDebug("Planted seedling!")

    --~ -- Something else has been built
    --~ else
      --~ BioInd.debugging.writeDebug("Nothing to do for %s!", {entity.name})
    end
  end

  BioInd.debugging.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                  on_pre_player_mined_item, on_robot_pre_mined,                 --
--                  on_player_mined_entity, on_robot_mined_entity                 --
------------------------------------------------------------------------------------
event_handlers.On_Pre_Remove = function(event)
  BioInd.debugging.entered_event(event)
  local entity = event.entity

  if not (entity and entity.valid) then
    BioInd.debugging.writeDebug("No valid entity -- nothing to do!")
    return
  end

  local compound_entity = BioInd.compound_entities[entity.name]
  local base_entry = compound_entity and global[compound_entity.tab][entity.unit_number]
BioInd.debugging.show("entity.name", entity.name)
BioInd.debugging.show("entity.unit_number", entity.unit_number)

BioInd.debugging.show("compound_entity", compound_entity)
BioInd.debugging.show("base_entry", base_entry)
BioInd.debugging.show("compound_entity.tab", compound_entity and compound_entity.tab or "nil")
BioInd.debugging.writeDebug("global[%s]: %s", {compound_entity and compound_entity.tab or "nil", compound_entity and global[compound_entity.tab] or "nil"})

  -- Found a compound entity from our list!
  if base_entry then
BioInd.debugging.writeDebug("Found compound entity %s",
                  {base_entry.base and BioInd.debugging.print_name_id(base_entry.base)})

    -- Arboretum: Need to separately remove the entry from the radar table
    if entity.name == "bi-arboretum" and base_entry.radar and base_entry.radar.valid then
      global.bi_arboretum_radar_table[base_entry.radar.unit_number] = nil
BioInd.debugging.show("Removed arboretum radar! Table", global.bi_arboretum_radar_table)
    end

    -- Bio cannon: Need to separately remove the entry from the radar table
    if entity.name == "bi-bio-cannon" and base_entry.radar and base_entry.radar.valid then
      global.bi_bio_cannon_radar_table[base_entry.radar.unit_number] = nil
BioInd.debugging.show("Removed arboretum radar! Table", global.bi_arboretum_radar_table)
    end

    -- Power rails: Connections must be explicitely removed, otherwise the poles
    -- from the remaining rails will automatically connect and bridge the gap in
    -- the power supply!
    if entity.name:match("bi%-%a+%-rail%-power") then
BioInd.debugging.writeDebug("Before")
      BioInd.debugging.writeDebug("Disconnecting %s!", {BioInd.debugging.print_name_id(base_entry.pole)})
BioInd.debugging.writeDebug("After")
      base_entry.pole.disconnect_neighbour()
    end

    -- Default: Remove all renderings!
    if global.renderings then
      for r_name, r_id in pairs(base_entry.renderings or {}) do
        global.renderings[r_id] = nil
      end
BioInd.debugging.writeDebug("Removed renderings for entity %s", {BioInd.debugging.print_name_id(base_entry.base)})
      if not next(global.renderings) then
        global.renderings = nil
        BioInd.debugging.writeDebug("Removed empty table global.renderings!")
      end
    end

    -- Default: Remove all hidden entities!
    for hidden, h_name in pairs(compound_entity.hidden or {}) do
BioInd.debugging.show("hidden", hidden)

BioInd.debugging.writeDebug("Removing hidden entity %s", {BioInd.debugging.print_name_id(base_entry[hidden])})
      BioInd.remove_entity(base_entry[hidden])
      base_entry[hidden] = nil
    end
    global[compound_entity.tab][entity.unit_number] = nil


  -- Rail-to-power: Connections must be explicitely removed, otherwise the poles
  -- from the different rail tracks hooked up to this connector will automatically
  -- keep the separate power networks connected!
  elseif entity.name == "bi-power-to-rail-pole" then
    BioInd.debugging.writeDebug("Rail-to-power connector has been removed")
    entity.disconnect_neighbour()
    BioInd.debugging.writeDebug("Removed copper wires from %s (%g)", {entity.name, entity.unit_number})

  -- Removed seedling
  elseif entity.name == "seedling" or entity.name == "seedling-2" or entity.name == "seedling-3" then
    BioInd.debugging.writeDebug("Seedling has been removed")
    --~ remove_plants(entity.position, global.bi.tree_growing)
    BI_scripts.trees.remove_plants(global.checks.bi_trees.growing, entity.position)

  -- Removed tree
  elseif entity.type == "tree" and BioInd.tree_stuff.tree_types[entity.name] then
    BioInd.debugging.show("Removed tree", entity.name)

    local tree_stage = entity.name:match('^.+%-(%d)$')
BioInd.debugging.writeDebug("Removed tree %s (grow stage: %s)", {entity.name, tree_stage or nil})
    if tree_stage then
      BI_scripts.trees.remove_plants(global.bi["stage_" .. tree_stage], entity.position)
    -- This should never happen!
    else
      error(string.format("Tree %s does not have a valid tree_stage: %s", entity.name, tree_stage or "nil"))
    end

  -- Removed something else
  else
    BioInd.debugging.writeDebug("%s has been removed -- nothing to do!", {entity.name})
  end

  BioInd.debugging.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--       defines.events.on_entity_died, defines.events.script_raised_destroy      --
------------------------------------------------------------------------------------
event_handlers.On_Death = function(event)
  BioInd.debugging.entered_event(event)

  local entity = event.entity
  if not entity then
    error("Something went wrong -- no entity data!")
  end

  local arboretum = BioInd.compound_entities["bi-arboretum"] and
                      BioInd.compound_entities["bi-arboretum"].hidden
  local power_rail = BioInd.compound_entities["bi-curved-rail-power"] and
                      BioInd.compound_entities["bi-curved-rail-power"].hidden
  if
      -- Table checks
      BioInd.compound_entities[entity.name] or
      BioInd.tree_stuff.tree_types[entity.name] or
      -- Entity checks
      -- Hidden radar of terraformer
      entity.name == (arboretum and arboretum.radar and arboretum.radar.name) or
      -- Hidden pole of powered rails
      entity.name == (power_rail and power_rail.pole and power_rail.pole.name) or
      -- Pollution detector
      entity.name == BioInd.pollution_sensor_name or
      -- Seedlings
      entity.name == "seedling" or entity.name == "seedling-2" or entity.name == "seedling-3" then

    BioInd.debugging.writeDebug("Divert to On_Pre_Remove!")
    event_handlers.On_Pre_Remove(event)
  else
    BioInd.debugging.writeDebug("Nothing to do!")
  end
  BioInd.debugging.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                           Event from "Picker Dollies"                          --
------------------------------------------------------------------------------------
event_handlers.On_Moved = function(event)
  BioInd.debugging.entered_event(event)

  local entity = event.moved_entity
  if entity and entity.valid then

    local data = BioInd.compound_entities[entity.name]
BioInd.debugging.writeDebug("Check for compound entity")
    -- Compound entities
    if data then
BioInd.debugging.writeDebug("Compound entity has been moved!")
      local data = BioInd.compound_entities[entity.name]
      local g_tab = global[data.tab][entity.unit_number]
      local new_pos

      if g_tab then
        for h_key, h_data in pairs(data.hidden) do
BioInd.debugging.writeDebug("Checking %s", {h_key})
          -- Move hidden entities
          if g_tab[h_key] and g_tab[h_key].valid then
            new_pos = BioInd.offset_position(entity.position, h_data.base_offset)
BioInd.debugging.show("New position", new_pos)
            g_tab[h_key].teleport(new_pos)
          end
        end

        -- Check that hidden poles aren't connected to anything beyond their reach
        BI_scripts.poles.disconnect_faraway(g_tab)
      end
    end
  end

  BioInd.debugging.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return event_handlers
