------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                 Event handlers and the functions called by them                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.entered_file()

local set_startup_items         = require("scripts.startup_items")
local init_functions            = require("scripts.init_functions")
local settings_changed          = require("scripts.settings_changed")

local event_handlers = {}

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                Local definitions                               --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- We can't just check if Alien Biomes is active, because we need to know if
-- the tiles we need from it exist in the game! To check this, we must call
-- game.get_tile_prototypes(), but this will crash in script.on_load(). So,
-- let's just declare the variable here and fill it later.
local AlienBiomes

local function add_optional_events()

  -- Musk floor
  if BioInd.get_startup_setting("BI_Power_Production") then
    BioInd.events.Solar_Mat_Built = {
      defines.events.on_player_built_tile,
      defines.events.on_robot_built_tile
    }

    BioInd.events.Solar_Mat_Removed = {
      defines.events.on_player_mined_tile,
      defines.events.on_robot_mined_tile
    }

    BioInd.events.Tile_Changed = defines.events.script_raised_set_tiles
  end

  -- Seedbombs
  if BioInd.get_startup_setting("BI_Explosive_Planting") then
    BioInd.events.On_Trigger_Created_Entity = defines.events.on_trigger_created_entity
  end

  -- "Picker Dollies"
  local picker = remote.interfaces["PickerDollies"] and
                  remote.interfaces["PickerDollies"]["dolly_moved_entity_id"] and
                  remote.call("PickerDollies", "dolly_moved_entity_id")

  if picker then
    BioInd.event_names[picker] = "dolly_moved_entity"
    BioInd.events["On_Moved"] = picker
    BioInd.writeDebug("Added handler for \"%s\" from \"PickerDollies\".",
                      {BioInd.event_names[picker]})
  end


  -- Arboretums/Terraformers
  -- These need to be re-registered once we have rebuilt the compound entities list
  -- and can set the filters!
  if BioInd.get_startup_setting("BI_Terraforming") then
    BioInd.events.Set_Filters = {
      defines.events.on_entity_damaged,
      defines.events.on_sector_scanned,
    }
  end
end


------------------------------------------------------------------------------------
--                           Dummy force for Musk floor                           --
------------------------------------------------------------------------------------
local function Create_dummy_force()
  BioInd.entered_function()
  -- Create dummy force for musk floor if electric grid overlay should NOT be shown in map view
    local f = game.create_force(BioInd.MuskForceName)
    -- Set new force as neutral to every other force
    for name, force in pairs(game.forces) do
      if name ~= BioInd.MuskForceName then
        f.set_friend(force, false)
        f.set_cease_fire(force, true)
      end
    end
    -- New force won't share chart data with any other force
    f.share_chart = false

    BioInd.writeDebug("Created force: %s", {game.forces[BioInd.MuskForceName].name})
  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--        Generate dictionary with the names of ingredients for arboretums        --
--                  (Other mods could have changed the recipes!)                  --
------------------------------------------------------------------------------------
local function get_arboretum_recipes()
  if not BioInd.get_startup_setting("BI_Terraforming") then
    BioInd.nothing_to_do("*")
    return
  else
    BioInd.entered_function()
  end

  local list = {}

  local recipes = game.recipe_prototypes
  local name

  for i = 1, 5 do
    name = "bi-arboretum-r" .. i
    list[name] = {}
    list[name].items = {}
    list[name].fluids = {}

    for i, ingredient in pairs(recipes[name].ingredients) do
      if ingredient.type == "item" then
        list[name].items[ingredient.name] = ingredient.amount
      else
        list[name].fluids[ingredient.name] = ingredient.amount
      end
    end
  end

  BioInd.show("Terraformer recipes", list)
  BioInd.entered_function("leave")
  return list
end


------------------------------------------------------------------------------------
--                          A solar mat must be placed                            --
------------------------------------------------------------------------------------
local function place_musk_floor(force, position, surface)
  BioInd.entered_function({force, position, surface})

  BioInd.check_args(force, "string")
  position = BioInd.normalize_position(position) or BioInd.arg_err(position, "position")
  surface = BioInd.is_surface(surface) or BioInd.arg_err(surface, "surface")

  local x, y = position.x, position.y
  local created
  for n, name in ipairs({BioInd.musk_floor_pole_name, BioInd.musk_floor_panel_name}) do
    -- We won't raise events because that would be too expensive (Musk floor is placed in bulk,
    -- and an event would be triggered for both pole and panel)''
    created = surface.create_entity({name = name, position = {x + 0.5, y + 0.5}, force = force})
    created.minable = false
    created.destructible = false
    BioInd.writeDebug("Created %s: %s", {name, created.unit_number})
    -- As we didn't raise the event, we have to check the pole connections directly!
    if name == BioInd.musk_floor_pole_name then
      BI_scripts.poles.connect_poles(created)
    end
  end

  -- Add to global tables!
  global.bi_musk_floor_table.tiles[x] = global.bi_musk_floor_table.tiles[x] or {}
  global.bi_musk_floor_table.tiles[x][y] = force

  global.bi_musk_floor_table.forces[force] = global.bi_musk_floor_table.forces[force] or {}
  global.bi_musk_floor_table.forces[force][x] = global.bi_musk_floor_table.forces[force][x] or {}
  global.bi_musk_floor_table.forces[force][x][y] = true

  BioInd.entered_function("leave")
end



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                   Register these events again and add filters                  --
------------------------------------------------------------------------------------
event_handlers.Set_Filters = function(event)
  BioInd.entered_event(event)

  -- Entity was damaged
  if event.name == defines.events.on_entity_damaged then
    -- Re-register event
    script.on_event(event.name, event_handlers.On_Damage, {
      {filter = "type", type = global.compound_entities["bi-arboretum-area"].hidden.radar.type},
      {filter = "name", name = global.compound_entities["bi-arboretum-area"].hidden.radar.name, mode = "and"},
      {filter = "final-damage-amount", comparison = "!=", value = 0, mode = "and"},
    })
    -- Manually call the new handler this time
    if event.final_damage_amount ~= 0 and
        event.entity.type == global.compound_entities["bi-arboretum-area"].hidden.radar.type and
        event.entity.name == global.compound_entities["bi-arboretum-area"].hidden.radar.name then

      event_handlers.On_Damage(event)
    end

  -- Finished sector scan
  elseif event.name == defines.events.on_sector_scanned then
    -- Re-register event
    script.on_event(event.name, event_handlers.On_Sector_Scanned, {
      {filter = "name", name = global.compound_entities["bi-arboretum-area"].hidden.radar.name},
    })
    -- Manually call the new handler this time
    if event.radar.name == global.compound_entities["bi-arboretum-area"].hidden.radar.name then
      event_handlers.On_Sector_Scanned(event)
    end
  end

  BioInd.entered_event(event)
end


------------------------------------------------------------------------------------
--                                     on_init                                    --
------------------------------------------------------------------------------------
event_handlers.Init = function(event)
  if event then
    BioInd.entered_event(event)
  else
    BioInd.entered_function()
  end

  ----------------------------------------------------------------------------------
  -- If "Early wooden defenses" (setting BI_Darts) is active, set the items players
  -- get on starting a new game or on respawning!
  ----------------------------------------------------------------------------------
  BioInd.writeDebug("Checking whether we need to change startup items.")
  if BioInd.get_startup_setting("BI_Darts") then
    set_startup_items()
  end

  --------------------------------------------------------------------
  -- Settings
  --------------------------------------------------------------------
  -- Global table for storing the last state of certain mod settings
  BioInd.writeDebug("Setting up table for storing mod settings.")
  global.mod_settings = global.mod_settings or {}
  if BioInd.get_startup_setting("BI_Game_Tweaks_Easy_Bio_Gardens") then
    BioInd.writeDebug("Making list for setting \"%s\".",
                      {"mod-setting-name.BI_Game_Tweaks_Easy_Bio_Gardens"})
    global.mod_settings.garden_pole_connectors = BI_scripts.poles.get_garden_pole_connectors()
  else
    global.mod_settings.garden_pole_connectors = nil
  end

  -- Global table for storing the data of compound entities. They may
  -- change between saves (e.g. Bio gardens only need hidden poles when
  --  the "Easy gardens" setting is active).
  BioInd.writeDebug("Compile list of required compound entities.")
  global.compound_entities = BioInd.rebuild_compound_entity_list()


  --------------------------------------------------------------------
  -- Tree stuff!
  -- We'll always need this because seedlings can be planted manually.
  --------------------------------------------------------------------
  BioInd.writeDebug("Creating/restoring tables for tree growing.")
  global.bi = global.bi or {}
  global.bi.tree_growing = global.bi.tree_growing or {}
  for i = 1, 4 do
    global.bi["tree_growing_stage_" .. i] = global.bi["tree_growing_stage_" .. i] or {}
  end

  -- List of tree prototypes created by BI
  --~ global.bi.trees = get_bi_trees()
  global.bi.trees = BI_scripts.trees.get_bi_trees()

  -- List of tile prototypes that can't be fertilized
  global.bi.barren_tiles = BI_scripts.trees.get_fixed_tiles()

  -- 'AlienBiomes' is a bool value -- we don't want to read it again if it's false,
  -- but only if it hasn't been set yet!
  AlienBiomes = (AlienBiomes ~= nil) and AlienBiomes or BioInd.AB_tiles()


  --------------------------------------------------------------------
  -- Pollution detector
  --------------------------------------------------------------------
  if BioInd.get_startup_setting("BI_Pollution_Detector") then
    BioInd.writeDebug("Initialize tables for pollution detector.")
    global.bi_pollution_tables = global.bi_pollution_tables or {
      -- Stores the sensors in a chunk
      chunk_sensors = {},
      -- List of chunk positions (needed for distributing checks over ticks)
      chunk_positions = {},
      -- Stores entity and its chunk position
      sensors = {}
    }
  else
    global.bi_pollution_tables = nil
  end
  --------------------------------------------------------------------
  -- Compound entities
  --------------------------------------------------------------------
  BioInd.writeDebug("Initialize tables for compound entities.")
  local compound_entity_tables = {}
  init_functions.check_compound_entity_tabs()


  --------------------------------------------------------------------
  -- Musk floor
  --------------------------------------------------------------------
  -- Initialize tables
  if BioInd.get_startup_setting("BI_Power_Production") then
    BioInd.writeDebug("Setting up tables for musk floor.")
    global.bi_musk_floor_table = global.bi_musk_floor_table or {}
    global.bi_musk_floor_table.tiles = global.bi_musk_floor_table.tiles or {}
    global.bi_musk_floor_table.forces = global.bi_musk_floor_table.forces or {}
  end

  -- Create dummy force for Musk floor if electric grid overlay should
  -- NOT be shown in map view
  if BioInd.UseMuskForce and not game.forces[BioInd.MuskForceName] then
    BioInd.writeDebug("Must create force for Musk floor!")
    Create_dummy_force()
  end


  --------------------------------------------------------------------
  -- Arboretum
  --------------------------------------------------------------------
  if BioInd.get_startup_setting("BI_Terraforming") then
    BioInd.writeDebug("Setting up tables for terraformers/arboretums.")
    -- Global table for arboretum radars
    global.bi_arboretum_radar_table = global.bi_arboretum_radar_table or {}

    -- Global table of ingredients for terraformer recipes
    global.bi_arboretum_recipe_table = get_arboretum_recipes()
  end

  --------------------------------------------------------------------
  -- Compatibility with other mods
  --------------------------------------------------------------------
  BioInd.writeDebug("Creating table for storing compatibility data.")
  global.compatible = global.compatible or {}
  BioInd.writeDebug("Check for tiles from \"Alien Biomes\".")
  global.compatible.AlienBiomes = BioInd.AB_tiles()

  --------------------------------------------------------------------
  -- Enable researched recipes
  --------------------------------------------------------------------
  for i, force in pairs(game.forces) do
    BioInd.writeDebug("Reset technology effects for force %s.", {force.name})
    force.reset_technology_effects()
  end

  --------------------------------------------------------------------
  -- Attach events
  --------------------------------------------------------------------
  -- Add handler for entity-moved event
  add_optional_events()

  -- Register event handlers
  for handler, events in pairs(BioInd.events) do
    script.on_event(events, event_handlers[handler])
    BioInd.writeDebug("Added event handler %s.", {handler})
  end

  --------------------------------------------------------------------
  --                              DONE
  --------------------------------------------------------------------
  if event then
    BioInd.entered_event(event, "leave")
  else
    BioInd.entered_function("leave")
  end
end


------------------------------------------------------------------------------------
--                                     on_load                                    --
------------------------------------------------------------------------------------
event_handlers.On_Load = function()
  log("Entered On_Load!")
  --~ if global.bi_bio_cannon_table ~= nil then
    --~ Event.register(defines.events.on_tick, function(event) end)
  --~ end

  -- Add handler for events that are only needed with certain mods/settings
  add_optional_events()

  -- Register event handlers
  for handler, events in pairs(BioInd.events) do
    script.on_event(events, event_handlers[handler])
    BioInd.writeDebug("Added event handler %s.", {handler})
  end
end

------------------------------------------------------------------------------------
--                            on_configuration_changed                            --
------------------------------------------------------------------------------------
event_handlers.On_Config_Change = function(event)
  BioInd.entered_event(event)

  -- Re-initialize global tables etc.
  event_handlers.Init()

  if event.mod_startup_settings_changed then
    -- Musk floor: Remove tiles if BI_Power_Production has been turned off
    --             Change force if BI_Game_Tweaks_Show_musk_floor_in_mapview has changed
    settings_changed.musk_floor()
    -- Has this been obsoleted by the new init process? Turn it off for now!
    --~ settings_changed.bio_garden()
  end

  -- We've made a list of the tree prototypes that are currently available. Now we
  -- need to make sure that the lists of growing trees don't contain removed tree
  -- prototypes! (This fix is needed when "Alien Biomes" has been removed; it should
  -- work with all other mods that create trees as well.)
  local trees = global.bi.trees
  local tab
  -- Growing stages
  for i = 1, 4 do
    tab = global.bi["tree_growing_stage_" .. i]
BioInd.writeDebug("Number of trees in growing stage %s: %s", {i, table_size(tab)})

    for t = #tab, 1, -1 do
      if not trees[tab[t].tree_name] then
        BioInd.writeDebug("Removing invalid tree %s (%s)", {t, tab[t].tree_name})
        table.remove(tab, t)
      end
    end
    -- Removing trees will create gaps in the table, but we need it as a continuous
    -- list. (Trees need to be sorted by growing time, and we always look at the
    -- tree with index 1 when checking if a tree has completed the growing stage, so
    -- lets sort the table after all invalid trees have been removed!)
    table.sort(tab, function(a, b) return a.time < b.time end)
BioInd.show("Number of trees in final list", #tab)
  end

  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                                     on_tick                                    --
------------------------------------------------------------------------------------
event_handlers.On_Tick = function(event)
  --~ BioInd.entered_event(event)

  -- Check if any seedlings/trees must be transitioned to next growing stage
  BI_scripts.trees.check_tree_growing(event)

  -- Update pollution sensors?
  if global.bi_pollution_tables and
      next(global.bi_pollution_tables.chunk_positions) then
    BI_scripts.pollution_sensor.check_chunks(event)
  end

  --~ BioInd.entered_event(event, "leave")
end



------------------------------------------------------------------------------------
--                            on_trigger_created_entity                           --
------------------------------------------------------------------------------------
event_handlers.On_Trigger_Created_Entity = function(event)
  BioInd.entered_event(event)
  --- Used for Seed-bomb
  local ent = event.entity
  local surface = ent.surface
  local position = ent.position

  --~ -- 'AlienBiomes' is a bool value -- we don't want to read it again if it's false,
  --~ -- but only if it hasn't been set yet!
  --~ AlienBiomes = (AlienBiomes ~= nil) and AlienBiomes or BioInd.AB_tiles()

  -- Basic
  if ent.name == "seedling" then
    BioInd.writeDebug("Seed Bomb Activated - Basic")
    BI_scripts.trees.seed_planted_trigger(event)

  -- Standard
  elseif ent.name == "seedling-2" then
    BioInd.writeDebug("Seed Bomb Activated - Standard")
    local terrain_name_s = AlienBiomes and "vegetation-green-grass-3" or "grass-3"
    surface.set_tiles{{name = terrain_name_s, position = position}}
    BI_scripts.trees.seed_planted_trigger(event)

  -- Advanced
  elseif ent.name == "seedling-3" then
    BioInd.writeDebug("Seed Bomb Activated - Advanced")
    local terrain_name_a = AlienBiomes and "vegetation-green-grass-1" or "grass-1"
    surface.set_tiles{{name = terrain_name_a, position = position}}
    BI_scripts.trees.seed_planted_trigger(event)
  end

  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                    on_built_entity, on_robot_built_entity,                     --
--                   script_raised_built, script_raised_revive                    --
------------------------------------------------------------------------------------
event_handlers.On_Built = function(event)
  BioInd.entered_event(event)
  local entity = event.created_entity or event.entity
  if not (entity and entity.valid) then
    BioInd.arg_err(entity or "nil", "entity")
  end

  local surface = BioInd.is_surface(entity.surface) or
                    BioInd.arg_err(entity.surface or "nil", "surface")
  local position = BioInd.normalize_position(entity.position) or
                    BioInd.arg_err(entity.position or "nil", "position")
  local force = entity.force


  -- We can ignore ghosts -- if ghosts are revived, there will be
  -- another event that triggers where actual entities are placed!
  if entity.name == "entity-ghost" then
    BioInd.writeDebug("Built ghost of %s -- return!", {entity.ghost_name})
    return
  end

  BioInd.show("Built entity", BioInd.print_name_id(entity))

  local base_entry = global.compound_entities[entity.name]
  local base = base_entry and entity

  -- We've found a compound entity!
  if base then
    -- Make sure we work with a copy of the original table! We don't want to
    -- remove anything from it for real.
    local hidden_entities = util.table.deepcopy(base_entry.hidden)

    BioInd.writeDebug("%s (%s) is a compound entity. Need to create %s", {base.name, base.unit_number, hidden_entities})
BioInd.show("hidden_entities", hidden_entities)
    local new_base
    local new_base_name = base_entry.new_base_name
    -- If the base entity is only an overlay, we'll replace it with the real base
    -- entity and raise an event. The hidden entities will be created in the second
    -- pass (triggered by building the final entity).
BioInd.show("base_entry.new_base_name", base_entry.new_base_name)
BioInd.show("base_entry.new_base_name == base.name", base_entry.new_base_name == base.name)
BioInd.show("base_entry.optional", base_entry.optional)

    if new_base_name and new_base_name ~= base.name then
      new_base = surface.create_entity({
        name = new_base_name,
        position = base.position,
        direction = base.direction,
        force = base.force,
        raise_built = true
      })
      new_base.health = base.health
      BioInd.show("Created final base entity", BioInd.print_name_id(new_base))

      base.destroy({raise_destroy = true})
      base = new_base
      BioInd.writeDebug("Destroyed old base entity!")

    -- Second pass: We've placed the final base entity now, so we can create the
    -- the hidden entities!
    else
BioInd.writeDebug("Second pass -- creating hidden entities!")
BioInd.show("base_entry", base_entry)

BioInd.writeDebug("global[%s]: %s", {base_entry.tab, global[base_entry.tab]})
BioInd.show("base.name", base.name)
BioInd.show("base.unit_number", base.unit_number)
BioInd.show("hidden_entities", hidden_entities)

      -- We must call create_entities even if there are no hidden entities (e.g. if
      -- the "Easy Gardens" setting is disabled and no hidden poles are required)
      -- because the compound entity gets registered there!
      BioInd.create_entities(global[base_entry.tab], base, hidden_entities)
      BioInd.writeDebug("Stored %s in table: %s",
                        {BioInd.print_name_id(base), global[base_entry.tab][base.unit_number]})
    end

  -- The built entity isn't one of our compound entities.
  else
BioInd.writeDebug("%s is not a compound entity!", {BioInd.print_name_id(entity)})

    -- If one of our hidden entities has been built, we'll have raised this event
    -- ourselves and have passed on the base entity.
    base = event.base_entity

    local entities = BioInd.compound_entities
BioInd.show("Base entity", BioInd.print_name_id(base))

    -- The hidden entities are listed with a common handle ("pole", "panel" etc.). We
    -- can get it from the reverse-lookup list via the entity type!
    local h_key = BioInd.HE_map_reverse[entity.type]
    BioInd.show("h_key", h_key or "nil")

    -- Arboretum radar -- we need to add it to the table!
    if entity.type == "radar" and
      entity.name == entities["bi-arboretum-area"].hidden[h_key].name and base then
      global.bi_arboretum_radar_table[entity.unit_number] = base.unit_number
      entity.backer_name = ""
      BioInd.writeDebug("Added %s to global.bi_arboretum_radar_table", {BioInd.print_name_id(entity)})

    -- Electric poles -- we need to take care that they don't hook up to hidden poles!
    elseif entity.type == "electric-pole" then
BioInd.show("entities[\"bi-straight-rail-power\"].hidden[h_key].name", entities["bi-straight-rail-power"].hidden[h_key].name)
      local pole = entity
      BI_scripts.poles.connect_poles(pole, base)

    -- Pollution detector
    elseif entity.name == BioInd.pollution_sensor_name and
            entity.type == BioInd.pollution_sensor_type then
      BI_scripts.pollution_sensor.add_sensor(entity)
      BioInd.writeDebug("Pollution detector!")

    -- A seedling has been planted
    elseif entity.name == "seedling" then
      BI_scripts.trees.seed_planted(event)
      BioInd.writeDebug("Planted seedling!")

    -- Something else has been built
    else
      BioInd.writeDebug("Nothing to do for %s!", {entity.name})
    end
  end

  BioInd.entered_event(event, "leave")
end



------------------------------------------------------------------------------------
--                  on_pre_player_mined_item, on_robot_pre_mined,                 --
--                  on_player_mined_entity, on_robot_mined_entity                 --
------------------------------------------------------------------------------------
event_handlers.On_Pre_Remove = function(event)
  BioInd.entered_event(event)
  local entity = event.entity

  if not (entity and entity.valid) then
    BioInd.writeDebug("No valid entity -- nothing to do!")
    return
  end

  local compound_entity = global.compound_entities[entity.name]
  local base_entry = compound_entity and global[compound_entity.tab][entity.unit_number]
BioInd.show("entity.name", entity.name)
BioInd.show("entity.unit_number", entity.unit_number)

BioInd.show("compound_entity", compound_entity)
BioInd.show("base_entry", base_entry)
BioInd.show("compound_entity.tab", compound_entity and compound_entity.tab or "nil")
BioInd.writeDebug("global[%s]: %s", {compound_entity and compound_entity.tab or "nil", compound_entity and global[compound_entity.tab] or "nil"})

  -- Found a compound entity from our list!
  if base_entry then
BioInd.writeDebug("Found compound entity %s",
                  {base_entry.base and BioInd.print_name_id(base_entry.base)})

    -- Arboretum: Need to separately remove the entry from the radar table
    if entity.name == "bi-arboretum" and base_entry.radar and base_entry.radar.valid then
      global.bi_arboretum_radar_table[base_entry.radar.unit_number] = nil
BioInd.show("Removed arboretum radar! Table", global.bi_arboretum_radar_table)
    end

    -- Power rails: Connections must be explicitely removed, otherwise the poles
    -- from the remaining rails will automatically connect and bridge the gap in
    -- the power supply!
    if entity.name:match("bi%-%a+%-rail%-power") then
BioInd.writeDebug("Before")
      BioInd.writeDebug("Disconnecting %s!", {BioInd.print_name_id(base_entry.pole)})
BioInd.writeDebug("After")
      base_entry.pole.disconnect_neighbour()
    end

    -- Default: Remove all hidden entities!
    for hidden, h_name in pairs(compound_entity.hidden or {}) do
BioInd.show("hidden", hidden)

BioInd.writeDebug("Removing hidden entity %s", {BioInd.print_name_id(base_entry[hidden])})
      BioInd.remove_entity(base_entry[hidden])
      base_entry[hidden] = nil
    end
    global[compound_entity.tab][entity.unit_number] = nil

  -- Rail-to-power: Connections must be explicitely removed, otherwise the poles
  -- from the different rail tracks hooked up to this connector will automatically
  -- keep the separate power networks connected!
  elseif entity.name == "bi-power-to-rail-pole" then
    BioInd.writeDebug("Rail-to-power connector has been removed")
    entity.disconnect_neighbour()
    BioInd.writeDebug("Removed copper wires from %s (%g)", {entity.name, entity.unit_number})

  -- Pollution detector
  elseif entity.name == BioInd.pollution_sensor_name and
          entity.type == BioInd.pollution_sensor_type then
    BioInd.writeDebug("Pollution detector!")
    BI_scripts.pollution_sensor.remove_sensor(entity)

  -- Removed seedling
  elseif entity.name == "seedling" then
    BioInd.writeDebug("Seedling has been removed")
    --~ remove_plants(entity.position, global.bi.tree_growing)
    BI_scripts.trees.remove_plants(entity.position, global.bi.tree_growing)

  -- Removed tree
  elseif entity.type == "tree" and global.bi.trees[entity.name] then
    BioInd.show("Removed tree", entity.name)

    local tree_stage = entity.name:match('^.+%-(%d)$')
BioInd.writeDebug("Removed tree %s (grow stage: %s)", {entity.name, tree_stage or nil})
    if tree_stage then
      --~ remove_plants(entity.position, global.bi["tree_growing_stage_" .. tree_stage])
      BI_scripts.trees.remove_plants(entity.position, global.bi["tree_growing_stage_" .. tree_stage])
    else
      error(string.format("Tree %s does not have a valid tree_stage: %s", entity.name, tree_stage or "nil"))
    end

  -- Removed something else
  else
    BioInd.writeDebug("%s has been removed -- nothing to do!", {entity.name})
  end

  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                                on_entity_damaged                               --
------------------------------------------------------------------------------------
event_handlers.On_Damage = function(event)
  BioInd.entered_event(event)
  local entity = event.entity
  local final_health = event.final_health

  local arb = "bi-arboretum"
  local associated

  -- Base was damaged: Find the radar associated with it!
  if entity.name == arb then
    associated = global.bi_arboretum_table[entity.unit_number].radar
  -- Radar was damaged: Find the base entity!
  elseif entity.name == global.compound_entities[arb].hidden.radar.name then
    local base_id = global.bi_arboretum_radar_table[entity.unit_number]
    associated = global.bi_arboretum_table[base_id].base
  end

  if associated and associated.valid then
    associated.health = final_health
    BioInd.writeDebug("%s was damaged (%s). Reducing health of %s to %s!", {
                      BioInd.print_name_id(entity),
                      event.final_damage_amount,
                      entity.name == arb and "associated radar" or "base",
                      associated.health
                    })
  end

  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--       defines.events.on_entity_died, defines.events.script_raised_destroy      --
------------------------------------------------------------------------------------
event_handlers.On_Death = function(event)
  BioInd.entered_event(event)

  local entity = event.entity
  if not entity then
    error("Something went wrong -- no entity data!")
  end

  local arboretum = global.compound_entities["bi-arboretum"] and
                      global.compound_entities["bi-arboretum"].hidden
  local power_rail = global.compound_entities["bi-curved-rail-power"] and
                      global.compound_entities["bi-curved-rail-power"].hidden
  if
      -- Table checks
      global.compound_entities[entity.name] or
      global.bi.trees[entity.name] or
      -- Entity checks
      -- Hidden radar of terraformer
      entity.name == (arboretum and arboretum.radar and arboretum.radar.name) or
      -- Hidden pole of powered rails
      entity.name == (power_rail and power_rail.pole and power_rail.pole.name) or
      -- Pollution detector
      entity.name == BioInd.pollution_sensor_name or
      -- Seedlings
      entity.name == "seedling" then

    BioInd.writeDebug("Divert to On_Pre_Remove!")
    event_handlers.On_Pre_Remove(event)
  else
    BioInd.writeDebug("Nothing to do!")
  end
  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                                on_sector_scanned                               --
------------------------------------------------------------------------------------
-- Radar completed a sector scan
event_handlers.On_Sector_Scanned = function(event)
  BioInd.entered_event(event)

  ---- Each time an Arboretum-Radar scans a sector  ----
  local arboretum = global.bi_arboretum_radar_table[event.radar.unit_number]
  if arboretum then
    BI_scripts.arboretum.check_arboretum(global.bi_arboretum_table[arboretum], event)
  end

  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                    on_player_mined_tile, on_robot_mined_tile                   --
------------------------------------------------------------------------------------
-- Solar mat was removed
event_handlers.Solar_Mat_Removed = function(event)
  BioInd.entered_event(event)

  local surface = game.surfaces[event.surface_index]
  local tiles = event.tiles

  local pos, x, y
  -- tiles contains an array of the old tiles and their position
  for t, tile in pairs(tiles) do
    if tile.old_tile and tile.old_tile.name == "bi-solar-mat" then
      pos = BioInd.normalize_position(tile.position)
      x, y = pos.x, pos.y

BioInd.writeDebug("Looking for hidden entities to remove")
      for _, o in pairs(surface.find_entities_filtered{
        name = {'bi-musk-mat-hidden-pole', 'bi-musk-mat-hidden-panel'},
        position = {x + 0.5, y + 0.5}
      } or {}) do
BioInd.show("Removing", o.name)
        o.destroy()
      end

      -- Remove tile from global tables
      local force_name = global.bi_musk_floor_table.tiles and
                          global.bi_musk_floor_table.tiles[x] and
                          global.bi_musk_floor_table.tiles[x][y]
      if force_name then
BioInd.writeDebug("Removing Musk floor tile from tables!")
        global.bi_musk_floor_table.tiles[x][y] = nil
        if not next(global.bi_musk_floor_table.tiles[x]) then
          global.bi_musk_floor_table.tiles[x] = nil
        end

        if global.bi_musk_floor_table.forces[force_name] and
            global.bi_musk_floor_table.forces[force_name][x] then
          global.bi_musk_floor_table.forces[force_name][x][y] = nil
          if not next(global.bi_musk_floor_table.forces[force_name][x]) then
            global.bi_musk_floor_table.forces[force_name][x] = nil
          end
        end
      end

    end
  end

  BioInd.writeDebug("bi-solar-mat: removed %g tiles", {table_size(tiles)})
  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                    on_player_built_tile, on_robot_built_tile                   --
------------------------------------------------------------------------------------
event_handlers.Solar_Mat_Built = function(event)
  BioInd.entered_event(event)
  -- Called from player, bot and script-raised events, so event may
  -- contain "robot" or "player_index"

  local tile = event.tile
  local surface = game.surfaces[event.surface_index]
  local player = event.player_index and game.players[event.player_index]
  local robot = event.robot
  local force = (BioInd.UseMuskForce and BioInd.MuskForceName) or
                (event.player_index and game.players[event.player_index].force.name) or
                (event.robot and event.robot.force.name) or
                event.force.name
BioInd.show("Force.name", force)

  -- Item that was used to place the tile
  local item = event.item
  local old_tiles = event.tiles


  local position --, x, y


  -- Musk floor has been built -- create hidden entities!
  if tile.name == "bi-solar-mat" then
    BioInd.writeDebug("Solar Mat has been built -- must create hidden entities!")
BioInd.show("Tile data", tile )

    --~ for index, old_tile in pairs(old_tiles or {}) do
    for index, t in pairs(old_tiles or {tile}) do
BioInd.show("Read old_tile inside loop", t)
      -- event.tiles will also contain landscape tiles like "grass-1",
      -- and it will always contain at least one tile
      position = BioInd.normalize_position(t.position)
      -- If we got here by a call from script_raised_built, force may be stored
      -- with the tile
      force = force or t.force
BioInd.show("Got force from tile data", t.force or "false")
      BioInd.writeDebug("Building solar mat for force %s at position %s",
        {tostring(type(force) == "table" and force.name or force), position})

      place_musk_floor(force, position, surface)
    end

  -- Fertilizer/Advanced fertilizer has been used. Check if the tile was valid
  -- (no Musk floor, no wooden floor, no concrete etc.)
  elseif item and (item.name == "fertilizer" or item.name == "bi-adv-fertilizer") then

    local restore_tiles = {}
    local products

    for index, t in pairs(old_tiles or {tile}) do
BioInd.show("index", index)
BioInd.show("t.old_tile.name", t.old_tile.name)

      -- We want to restore removed tiles if nothing is supposed to grow on them!
      if global.bi.barren_tiles[t.old_tile.name] then
BioInd.writeDebug("%s was used on forbidden ground (%s)!", {item.name, t.old_tile.name})
        restore_tiles[#restore_tiles + 1] = {name = t.old_tile.name, position = t.position}

        -- Is that tile minable?
        products = global.bi.barren_tiles[t.old_tile.name]
        if type(products) == "table" then
          for p, product in ipairs(products) do
            if player then
BioInd.writeDebug("Removing %s (%s) from player %s", {product.name, product.amount, player.name})
              player.remove_item({name = product.name, count = product.amount})
            elseif robot then
BioInd.writeDebug("Removing %s (%s) from robot %s", {product.name, product.amount, robot.unit_number})
              robot.remove_item({name = product.name, count = product.amount})
            end
          end
        end
      end
    end
BioInd.show("restore_tiles", restore_tiles)
    if restore_tiles then
      surface.set_tiles(
        restore_tiles,
        true,         -- correct_tiles
        true,         -- remove_colliding_entities
        true,         -- remove_colliding_decoratives
        true          -- raise_event
      )
    end

  -- Some other tile has been built -- check if it replaced musk floor!
  else
    local test
    local removed_tiles = {}
    for index, t in pairs(old_tiles or {tile}) do
      position = BioInd.normalize_position(t.position)
      test = global.bi_musk_floor_table and
              global.bi_musk_floor_table.tiles and
              global.bi_musk_floor_table.tiles[position.x] and
              global.bi_musk_floor_table.tiles[position.x][position.y]
      if test then
        removed_tiles[#removed_tiles + 1] = {
          old_tile = {name = "bi-solar-mat"},
          position = position
        }
      end
    end
    if next(removed_tiles) then
      event_handlers.Solar_Mat_Removed({surface_index = event.surface_index, tiles = removed_tiles})
    else
      BioInd.writeDebug("%s has been built -- nothing to do!", {tile.name})
    end
  end

  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                           Event from "Picker Dollies"                          --
------------------------------------------------------------------------------------
event_handlers.On_Moved = function(event)
  BioInd.entered_event(event)

  local entity = event.moved_entity
  if entity and entity.valid then

    local data = global.compound_entities[entity.name]
BioInd.writeDebug("Check for compound entity")
    -- Compound entities
    if data then
BioInd.writeDebug("Compound entity has been moved!")
      local data = global.compound_entities[entity.name]
      local g_tab = global[data.tab][entity.unit_number]
      local new_pos

      if g_tab then
        for h_key, h_data in pairs(data.hidden) do
BioInd.writeDebug("Checking %s", {h_key})
          -- Move hidden entities
          if g_tab[h_key] and g_tab[h_key].valid then
            new_pos = BioInd.offset_position(entity.position, h_data.base_offset)
BioInd.show("New position", new_pos)
            g_tab[h_key].teleport(new_pos)
          end
        end

        -- Check that hidden poles aren't connected to anything beyond their reach
        BI_scripts.poles.disconnect_faraway(g_tab)
      end
    --~ end

    -- Pollution sensor
    elseif entity.name == BioInd.pollution_sensor_name then
      BioInd.writeDebug("%s has been moved!", {BioInd.argprint(entity)})
      BI_scripts.pollution_sensor.moved_entity(entity)
    end
  end

  BioInd.entered_event(event, "leave")
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")

return event_handlers
