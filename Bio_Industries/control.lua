-- Add support for the Lua API global Variable Viewer (gvv)
-- (Setting will only exist if the mod is active!)
do
  local setting = settings.startup["BI_Enable_gvv_support"]
  if setting and setting.value then
    log("Activating support for gvv!")
    require("__gvv__/gvv")()
  end
end

--~ -- Check if "omnimatter_fluid" is active
--~ local OMNImatter_fluid
--~ if script.active_mods["omnimatter_fluid"] then
  --~ OMNImatter_fluid = true
--~ end


local BioInd = require('common')('Bio_Industries')

-- We can't just check if Alien Biomes is active, because we need to know if
-- the tiles we need from it exist in the game! To check this, we must call
-- game.get_tile_prototypes(), but this will crash in script.on_load(). So,
-- let's just declare the variable here and fill it later.
local AlienBiomes

--~ local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(true)
local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(false)
require ("util")
require ("libs/util_ext")
require ("control_tree")
require ("control_bio_cannon")
require ("control_arboretum")

---************** Used for Testing -----
--require ("Test_Spawn")
---*************

-- 0.17.42/0.18.09 fixed a bug where musk floor was created for the force "enemy".
-- Because it didn't belong to any player, in map view the electric grid overlay wasn't
-- shown for musk floor. Somebody complained about seeing it now, so starting with version
-- 0.17.45/0.18.13, there is a setting to hide the overlay again. If it is set to "true",
-- a new force will be created that the hidden electric poles of musk floor belong to.
-- (UPDATE: 0.18.29 reversed the setting -- if active, tiles will now be visible in map
-- view, not hidden. The definition of UseMuskForce has been changed accordingly.)
local MuskForceName = "BI-Musk_floor_general_owner"
local UseMuskForce = not settings.startup["BI_Show_musk_floor_in_mapview"].value

local function Create_dummy_force()
  -- Create dummy force for musk floor if electric grid overlay should NOT be shown in map view
    local f = game.create_force(MuskForceName)
    -- Set new force as neutral to every other force
    for name, force in pairs(game.forces) do
      if name ~= MuskForceName then
        f.set_friend(force, false)
        f.set_cease_fire(force, true)
      end
    end
    -- New force won't share chart data with any other force
    f.share_chart = false

    BioInd.writeDebug("Created force: %s", {game.forces[MuskForceName].name})
end


-- Generate a look-up table with the names of our trees
local function get_bi_trees()
  local list = {}

  local trees = game.get_filtered_entity_prototypes({{filter = "type", type = "tree"}})
  for tree_name, tree in pairs(trees) do
    if tree_name:match("^bio%-tree%-.+%-%d$") then
BioInd.show("Found matching tree", tree_name)
      list[tree_name] = true
    end
  end

  return list
end


-- Generate a look-up table with the names of tiles that can't be changed by fertilizer
local tile_patterns = {
  ".*concrete.*",
  ".*stone%-path.*",
  "^bi%-solar%-mat$",
  "^bi%-wood%-floor$",
}
local function get_fixed_tiles()
  local list = {}

  local tiles = game.tile_prototypes

  for tile_name, tile in pairs(tiles) do
    for p, pattern in ipairs(tile_patterns) do
      if tile_name:match(pattern) then
BioInd.show("Found matching tile", tile_name)
        -- If a tile is minable and fertilizer is used on it, we must deduct the mined
        -- tiles from the player/robot again!
        list[tile_name] = tile.mineable_properties.products or true
      end
    end
  end
BioInd.show("Forbidden tiles", list)
  return list
end


-- Generate a look-up table with recipe ingredients, as other mods may have changed them
local function get_arboretum_recipes()
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
  return list
end


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
local function create_entities(g_table, base_entity, hidden_entity_names, position, ...)
BioInd.show("#g_table", g_table and table_size(g_table))
BioInd.show("hidden_entity_names", hidden_entity_names)

  BioInd.check_args(g_table, "table")
  BioInd.check_args(base_entity, "table")
  if not base_entity.valid then
    BioInd.arg_err(base_entity, "base entity")
  elseif not next(hidden_entity_names) then
    BioInd.arg_err(hidden_entity_names, "array of hidden-entity names")
  end
  local pos = BioInd.normalize_position(position)
  if not pos then
    BioInd.arg_err(position or "nil", "position")
  end

  local entity

  -- Initialize entry in global table
  g_table[base_entity.unit_number] = {}
  g_table[base_entity.unit_number].base = base_entity

  -- Create hidden entities
  for key, name in pairs(hidden_entity_names) do
    entity = base_entity.surface.create_entity({
      name = name,
      position = pos,
      force = base_entity.force
    })

    -- Make hidden entity unminable/undestructible
    make_unminable({entity})

    -- Add hidden entity to global table
    g_table[base_entity.unit_number][key] = entity
  end

  -- Add optional values to global table
  for k, v in pairs(... or {}) do
    g_table[base_entity.unit_number][k] = v
  end
BioInd.writeDebug("g_table[base.unit_number]", g_table[base_entity.unit_number])
end


--------------------------------------------------------------------
--~ local function On_Init()
--~ log("Entered On_Init!")
local function init()
BioInd.writeDebug("Entered init!")
  if BioInd.is_debug then
    game.check_prototype_translations()
  end

  --~ if global.Bio_Cannon_Table ~= nil then
    --~ Event.register(defines.events.on_tick, function(event) end)
  --~ end
  global.Bio_Cannon_Table = global.Bio_Cannon_Table or {}

  global.bi = global.bi or {}
  global.bi.tree_growing = global.bi.tree_growing or {}
  for i = 1, 4 do
    global.bi["tree_growing_stage_" .. i] = global.bi["tree_growing_stage_" .. i] or {}
  end

  -- List of tree prototypes created by BI
  global.bi.trees = get_bi_trees()

  -- List of tile prototypes that can't be fertilized
  global.bi.barren_tiles = get_fixed_tiles()

  -- Global table for bio farm
  global.bi_bio_farm_table = global.bi_bio_farm_table or {}

  -- Global table for solar boiler
  global.bi_solar_boiler_table = global.bi_solar_boiler_table or {}

  -- Global table for solar farm
  global.bi_solar_farm_table = global.bi_solar_farm_table or {}

  -- Global table for power rail
  global.bi_power_rail_table = global.bi_power_rail_table or {}

  -- Global table for Musk floor
  global.bi_musk_floor_table = global.bi_musk_floor_table or {}
  global.bi_musk_floor_table.tiles = global.bi_musk_floor_table.tiles or {}
  global.bi_musk_floor_table.forces = global.bi_musk_floor_table.forces or {}

  -- Global table for arboretum
  global.Arboretum_Table = global.Arboretum_Table or {}

  -- Global table for arboretum radars
  global.Arboretum_Radar_Table = global.Arboretum_Radar_Table or {}

  -- Global table for mod compatibilities
  global.compatible = global.compatible or {}
  global.compatible.AlienBiomes = BioInd.AB_tiles()
  --~ global.compatible.OmniFluid = script.active_mods["omnimatter_fluid"] and true or false

  -- Global table of ingredients for terraformer recipes
  global.Arboretum_Recipes = get_arboretum_recipes()

  --~ -- enable researched recipes
  --~ for i, force in pairs(game.forces) do
    --~ force.reset_technologies()
    --~ force.reset_recipes()
  --~ end
 -- enable researched recipes
  for i, force in pairs(game.forces) do
    for _, tech in pairs(force.technologies) do
      if tech.researched then
        for _, effect in pairs(tech.effects) do
          if effect.type == "unlock-recipe" then
            force.recipes[effect.recipe].enabled = false
            force.recipes[effect.recipe].enabled = true
          end
        end
      end
    end
  end

  -- Create dummy force for musk floor if electric grid overlay should NOT be shown in map view
  if UseMuskForce and not game.forces[MuskForceName] then
    --~ BioInd.writeDebug("Force for musk floor is required but doesn't exist.")
    Create_dummy_force()
  end


  --[[
  if QC_Mod then
    ---*************
    --local surface = game.surfaces['nauvis']
    Test_Spawn()
    ---*************
  end
  ]]
end


--------------------------------------------------------------------
local function On_Load()
  log("Entered On_Load!")
  if global.Bio_Cannon_Table ~= nil then
    Event.register(defines.events.on_tick, function(event) end)
  end
end


--------------------------------------------------------------------
local function On_Config_Change(ConfigurationChangedData)
BioInd.writeDebug("On Configuration changed: %s", {ConfigurationChangedData})
  if global.Bio_Cannon_Table ~= nil then
    Event.register(defines.events.on_tick, function(event) end)
  end

  -- Re-initialize global tables etc.
  init()

  -- Has setting BI_Show_musk_floor_in_mapview changed?
  if ConfigurationChangedData.mod_startup_settings_changed then
    --~ -- Create dummy force if necessary (Moved to init()!)
    --~ if UseMuskForce and not game.forces[MuskForceName] then
      --~ Create_dummy_force()
    --~ end


  -- Look for solar panels on every surface. They determine the force poles will use
  -- if the electric grid overlay will be shown in mapview.
    local sm_panel_name = "bi-musk-mat-solar-panel"
    local sm_pole_name = "bi-musk-mat-pole"

    -- If dummy force is not used, force of a hidden pole should be that of the hidden solar panel.
    -- That force will be "enemy" for poles/solar panels created with versions of Bio Industries
    -- prior to 0.17.45/0.18.13 because of the bug. We can fix that for singleplayer games by setting
    -- the force to player force. In multiplayer games, we can do this as well if all players are
    -- on the same force. If there are several forces that have players, it's impossible to find out
    -- which force built a certain musk floor tile, so "enemy" will still be used.
    -- (Only fix in this case: Players must remove and rebuild all existing musk floor tiles!)
    --~ local single_player_force = game.is_multiplayer() and nil or game.players[1].force.name
    local force = nil

    -- Always use dummy force if option is set
    if UseMuskForce then
      force = MuskForceName
    -- Singleplayer mode: use force of first player
    elseif not game.is_multiplayer() then
      force = game.players[1].force.name
    -- Multiplayer game
    else
      local count = 0
      -- Count forces with players
      for _, check_force in pairs(game.forces) do
        if check_force.players ~= {} then
          force = check_force.name
          count = count + 1
        end
      end
      -- Several forces with players: reset force to nil now and use force of panel later
      -- (If this happens in a game were musk floor was created the buggy way with "force == nil",
      --  it will be impossible to determine which force built it, so the force will still be
      --  the default, i.e. "enemy".)
      if count > 1 then
        --~ force = panel.force
        force = nil
      end
    end

    for name, surface in pairs(game.surfaces) do
      BioInd.writeDebug("Looking for %s on surface %s", {sm_panel_name, name})
      local sm_panel = surface.find_entities_filtered{name = sm_panel_name}
      local sm_pole = {}

      -- Look for hidden poles on position of hidden panels
      for p, panel in ipairs(sm_panel) do
        sm_pole = surface.find_entities_filtered{
          name = sm_pole_name,
          position = panel.position,
          --~ limit = 1
        }
        -- If more than one hidden pole exists at that position for some reason, remove all but the first!
        if #sm_pole > 1 then
BioInd.writeDebug("Number of poles for panel %g: %g", {p, #sm_pole})
          for i = 2, #sm_pole do
BioInd.writeDebug("Destroying pole number %g", {i})
            sm_pole[i].destroy()
          end
        end

        -- Set force of the pole
        sm_pole[1].force = force or panel.force
      end
    end
    BioInd.writeDebug("Electric grid overlay of musk floor will be %s in map view.",            {UseMuskForce and "hidden" or "displayed"})
  end
end

--------------------------------------------------------------------
--- Used for some compatibility with Angels Mods
Event.register(defines.events.on_player_joined_game, function(event)
   local player = game.players[event.player_index]
   local force = player.force
   local techs = force.technologies

  if settings.startup["angels-use-angels-barreling"] and
     settings.startup["angels-use-angels-barreling"].value then
      techs['fluid-handling'].researched = false
      techs['bi-tech-fertilizer'].reload()
      local _t = techs['angels-fluid-barreling'].researched
      techs['angels-fluid-barreling'].researched = false
      techs['angels-fluid-barreling'].researched = _t
   end
end)

---------------------------------------------
Event.register(defines.events.on_trigger_created_entity, function(event)
  --- Used for Seed-bomb
  local ent = event.entity
  local surface = ent.surface
  local position = ent.position

  -- 'AlienBiomes' is a bool value -- we don't want to read it again if it's false,
  -- but only if it hasn't been set yet!
  AlienBiomes = AlienBiomes ~= nil and AlienBiomes or BioInd.AB_tiles()

  -- Basic
  if ent.name == "seedling" then
    BioInd.writeDebug("Seed Bomb Activated - Basic")
    seed_planted_trigger(event)

  -- Standard
  elseif ent.name == "seedling-2" then
    BioInd.writeDebug("Seed Bomb Activated - Standard")
    local terrain_name_s = AlienBiomes and "vegetation-green-grass-3" or "grass-3"
    surface.set_tiles{{name = terrain_name_s, position = position}}
    seed_planted_trigger(event)

  -- Advanced
  elseif ent.name == "seedling-3" then
    BioInd.writeDebug("Seed Bomb Activated - Advanced")
    local terrain_name_a = AlienBiomes and "vegetation-green-grass-1" or "grass-1"
    surface.set_tiles{{name = terrain_name_a, position = position}}
    seed_planted_trigger(event)
  end
end)

--------------------------------------------------------------------
local function On_Built(event)
  local entity = event.created_entity or event.entity
  if not (entity and entity.valid) then
    BioInd.arg_err(entity or "nil", "entity")
  end

  local surface = BioInd.is_surface(entity.surface) or
                    BioInd.arg_err(entity.surface or "nil", "surface")
  local position = BioInd.normalize_position(entity.position) or
                    BioInd.arg_err(entity.position or "nil", "position")
  local force = entity.force

BioInd.writeDebug("Entered function On_Built with these data: " .. serpent.block(event))
BioInd.writeDebug("Entity name: %s", {entity.name})

  -- We can ignore ghosts -- if ghosts are revived, there will be
  -- another event that triggers where actual entities are placed!
  if entity.name == "entity-ghost" then
    BioInd.writeDebug("Built ghost of %s -- return!", {entity.ghost_name})
    return
  end



  local base = entity
  local hidden_entities

local pole, connector
local boiler_name, lamp_name, pole_name, radar_name, panel_name, overlay_name

  --- Seedling planted
  if entity.name == "seedling" then
    seed_planted(event)
    --- Bio Farm has been built
  elseif entity.name == "bi-bio-farm" then
    BioInd.writeDebug("Bio Farm has been built")
    --~ local b_farm = entity

    --~ local pole_name = "bi-bio-farm-electric-pole"
    --~ local panel_name = "bi-bio-farm-solar-panel"
    --~ local lamp_name = "bi-bio-farm-light"
    pole_name = "bi-bio-farm-electric-pole"
    panel_name = "bi-bio-farm-solar-panel"
    lamp_name = "bi-bio-farm-light"
    hidden_entities = {pole = pole_name, panel = panel_name, lamp = lamp_name}
    --~ -- Hidden Power Pole
    --~ local create_pole = surface.create_entity({
      --~ name = pole_name,
      --~ position = position,
      --~ force = force
    --~ })

    --~ -- Hidden Solar Panel
    --~ local create_panel = surface.create_entity({
      --~ name = panel_name,
      --~ position = position,
      --~ force = force
    --~ })

    --~ -- Hidden Lamp
    --~ local create_lamp = surface.create_entity({
      --~ name = lamp_name,
      --~ position = position,
      --~ force = force
    --~ })

    --~ create_pole.minable = false
    --~ create_pole.destructible = false
    --~ create_panel.minable = false
    --~ create_panel.destructible = false
    --~ create_lamp.minable = false
    --~ create_lamp.destructible = false

    --~ -- Group Multiple Entities Together
    --~ global.bi_bio_farm_table[b_farm.unit_number] = {
      --~ base = b_farm,
      --~ pole = create_pole,
      --~ panel = create_panel,
      --~ lamp = create_lamp
    --~ }

    create_entities(global.bi_bio_farm_table, base, hidden_entities, base.position)
    BioInd.writeDebug("Stored Biofarm %g in table: %s", {base.unit_number,    global.bi_bio_farm_table[base.unit_number]})

  --- Bio Solar Boiler / Solar Plant has been built
  elseif entity.name == "bi-solar-boiler" then
   BioInd.writeDebug("Bio Solar Boiler has been built")
    --~ local solar_plant = entity
    --~ local boiler_solar = "bi-solar-boiler-panel"
    --~ local sm_pole_name = "bi-hidden-power-pole"
    boiler_name = "bi-solar-boiler-panel"
    pole_name = "bi-hidden-power-pole"
    hidden_entities = {boiler = boiler_name, pole = pole_name}

    --~ -- Hidden Solar Panel
    --~ local create_solar_boiler = surface.create_entity({
      --~ name = boiler_solar,
      --~ position = position,
      --~ force = force
    --~ })

    --~ -- Hidden Power Pole
    --~ local create_sm_pole = surface.create_entity({
      --~ name = sm_pole_name,
      --~ position = position,
      --~ force = force
    --~ })

    --~ create_solar_boiler.minable = false
    --~ create_solar_boiler.de,löstructible = false
    --~ create_sm_pole.minable = false
    --~ create_sm_pole.destructible = false

    --~ -- Group Multiple Entities Together
    --~ global.bi_solar_boiler_table[solar_plant.unit_number] = {
      --~ base = solar_plant,
      --~ boiler = create_solar_boiler,
      --~ pole = create_sm_pole
    --~ }
    create_entities(global.bi_solar_boiler_table, base, hidden_entities, base.position)
    BioInd.writeDebug("Stored solar boiler %g in table: %s", {base.unit_number, global.bi_solar_boiler_table[base.unit_number]})

    --- Solar Farm has been built
  elseif entity.name == "bi-bio-solar-farm" then
    BioInd.writeDebug("Bio Solar Farm has been built")
    --~ local solar_farm = entity
    --~ local sm_pole_name = "bi-hidden-power-pole"
    pole_name = "bi-hidden-power-pole"
    hidden_entities = {pole = pole_name}

    --~ -- Hidden Power Pole
    --~ local create_sm_pole = surface.create_entity({
      --~ name = sm_pole_name,
      --~ position = position,
      --~ force = force
    --~ })
    --~ create_sm_pole.minable = false
    --~ create_sm_pole.destructible = false

    --~ -- Group Multiple Entities Together
    --~ global.bi_solar_farm_table[solar_farm.unit_number] = {
      --~ base = solar_farm,
      --~ pole = create_sm_pole
    --~ }
    create_entities(global.bi_solar_farm_table, base, hidden_entities, base.position)

    BioInd.writeDebug("Bio Solar Farm %g in table: %s", {base.unit_number, global.bi_solar_farm_table[base.unit_number]})

  --- Bio Cannon has been built
  elseif
      -- Built normally
      (entity.name == "bi-bio-cannon-area" or
      -- Built from blueprint
       entity.name == "bi-bio-cannon") then
    --~ local New_Bio_Cannon, New_Bio_CannonR

    BioInd.writeDebug("Bio Cannon has been built")

    --~ -- Hidden Radar
    --~ New_Bio_CannonR = surface.create_entity({
      --~ name = "Bio-Cannon-r",
      --~ position = position,
      --~ direction = event.created_entity.direction,
      --~ force = force
    --~ })
    --~ New_Bio_CannonR.operable = false
    --~ New_Bio_CannonR.destructible = false
    --~ New_Bio_CannonR.minable = false

    --~ -- New Cannon, the first was just used for Radius overlay
    --~ -- (If normally built -- if built from blueprint we just use the same code anyway.)
    --~ New_Bio_Cannon = surface.create_entity({
      --~ name = "bi-bio-cannon",
      --~ position = position,
      --~ direction = event.created_entity.direction,
      --~ force = force
    --~ })
    --~ New_Bio_Cannon.health = event.created_entity.health

    --~ if not global.Bio_Cannon_Table then
      --~ global.Bio_Cannon_Table = {}
      --~ Event.register(defines.events.on_tick, function(event) end)
    --~ end

    --~ -- Group Multiple Entities Together
    --~ -- table.insert(global.Bio_Cannon_Table, {New_Bio_Cannon, New_Bio_CannonR, 0})
    --~ global.Bio_Cannon_Table[New_Bio_Cannon.unit_number] = {
      --~ base = New_Bio_Cannon,
      --~ radar = New_Bio_CannonR,
      --~ delay = 0
    --~ }

    radar_name = "Bio-Cannon-r"
    hidden_entities = {radar = radar_name}
    -- New Cannon, the first was just used for Radius overlay
    -- (If normally built -- if built from blueprint we just use the same code anyway.)
    base = surface.create_entity({
      name = "bi-bio-cannon",
      position = position,
      direction = entity.direction,
      force = force
    })
    base.health = entity.health

    --~ New_Bio_CannonR.operable = false

    -- Group Multiple Entities Together
    --~ global.Bio_Cannon_Table[New_Bio_Cannon.unit_number] = {
      --~ base = New_Bio_Cannon,
      --~ radar = New_Bio_CannonR,
      --~ delay = 0
    --~ }
    create_entities(global.Bio_Cannon_Table, base, hidden_entities, base.position, {delay = 0})
    global.Bio_Cannon_Table[base.unit_number].radar.operable = false

    -- Remove the "Overlay" Entity
    entity.destroy()
    BioInd.writeDebug("Stored Bio Cannon %g in table: %s", {#global.Bio_Cannon_Table, global.Bio_Cannon_Table})

  --- Arboretum has been built
  --~ if entity.valid and entity.name == "bi-arboretum-area" then
  elseif
      -- Built normally
      entity.name == "bi-arboretum-area" or
      -- Built from blueprint
      entity.name == "bi-arboretum" then
    BioInd.writeDebug("Arboretum has been built")

    local arboretum_new = "bi-arboretum"
    radar_name = "bi-arboretum-radar"
    pole_name = "bi-hidden-power-pole"
    lamp_name = "bi-bio-farm-light"
    hidden_entities = {pole = pole_name, lamp = lamp_name}
    --~ -- New Arboretum, the first was just used for Radius overlay
    --~ local create_arboretum = surface.create_entity({
      --~ name = arboretum_new,
      --~ position = position,
      --~ direction = entity.direction,
      --~ force = force
    --~ })
    --~ local position_c = {position.x - 3.5, position.y + 3.5}

    --~ -- Radar
    --~ local create_radar = surface.create_entity({
      --~ name = radar_name,
      --~ position = position_c,
      --~ direction = entity.direction,
      --~ force = force
    --~ })

    --~ -- Hidden pole
    --~ local create_pole = surface.create_entity({
      --~ name = pole_name,
      --~ position = position,
      --~ direction = entity.direction,
      --~ force = force
    --~ })

    --~ -- Hidden Lamp
    --~ local create_lamp = surface.create_entity({
      --~ name = lamp_name,
      --~ position = position,
      --~ force = force
    --~ })

    --~ create_radar.minable = false
    --~ create_radar.destructible = false
    --~ create_pole.minable = false
    --~ create_pole.destructible = false
    --~ create_lamp.minable = false
    --~ create_lamp.destructible = false

    --~ -- Group Multiple Entities Together
    --~ global.Arboretum_Table[create_arboretum.unit_number] = {
      --~ base = create_arboretum,
      --~ radar = create_radar,
      --~ pole = create_pole,
      --~ lamp = create_lamp
    --~ }
    --~ global.Arboretum_Radar_Table[create_radar.unit_number] = create_arboretum.unit_number

    -- New Arboretum, the first was just used for Radius overlay
    base = surface.create_entity({
      name = arboretum_new,
      position = position,
      direction = entity.direction,
      force = force
    })

    -- Radar
    local create_radar = surface.create_entity({
      name = radar_name,
      position = {position.x - 3.5, position.y + 3.5},
      direction = entity.direction,
      force = force
    })
    create_radar.minable = false
    create_radar.destructible = false

    create_entities(global.Arboretum_Table, base, hidden_entities, base.position,
                    {radar = create_radar})

    global.Arboretum_Radar_Table[create_radar.unit_number] = base.unit_number

    BioInd.show("built: entity unit_number", base.unit_number)
    BioInd.show("built: global.Arboretum_Table", global.Arboretum_Table[base.unit_number])
    BioInd.show("built: global.Arboretum_Radar_Table", global.Arboretum_Radar_Table[create_radar.unit_number])

    -- Remove the "Overlay" Entity
    entity.destroy()

  -- Power Rail
  --~ elseif
          --~ (entity.name == "bi-straight-rail-power" or
           --~ entity.name == "bi-curved-rail-power") then
  elseif entity.name:match("bi%-[^%-]+%-rail%-power") then
    BioInd.writeDebug("Power Rail has been built")

    --~ local rail_track = entity
    pole_name = "bi-rail-hidden-power-pole"
    hidden_entities = {pole = pole_name}

    --~ -- Create Hidden Power Pole
    --~ local create_rail_pole = surface.create_entity({
      --~ name = pole_name,
      --~ position = position,
      --~ force = force
    --~ })

    --~ create_rail_pole.minable = false
    --~ create_rail_pole.destructible = false

    --~ -- Group Multiple Entities Together Together
    --~ global.bi_power_rail_table[rail_track.unit_number] = {base = rail_track, pole = create_rail_pole}

    create_entities(global.bi_power_rail_table, base, hidden_entities, base.position)

    pole = global.bi_power_rail_table[base.unit_number].pole
    if pole.valid then
      -- Remove all copper wires from new pole
      pole.disconnect_neighbour()
BioInd.writeDebug("Removed all wires from %s %g", {pole.name, pole.unit_number})

      -- Look for connecting rails at front and back of the new rail
      for s, side in ipairs( {"front", "back"} ) do
BioInd.writeDebug("Looking for rails at %s", {side})
        local neighbour
        -- Look in all three directions
        for d, direction in ipairs( {"left", "straight", "right"} ) do
BioInd.writeDebug("Looking for rails in %s direction", {direction})
          neighbour = base.get_connected_rail{
            rail_direction = defines.rail_direction[side],
            rail_connection_direction = defines.rail_connection_direction[direction]
          }
BioInd.writeDebug("Rail %s of %s (%s): %s (%s)", {direction, base.name, base.unit_number, (neighbour and neighbour.name or "nil"), (neighbour and neighbour.unit_number or "nil")})

          -- Only make a connection if found rail is a powered rail
          -- (We'll know it's the right type if we find it in our table!)
          neighbour = neighbour and neighbour.valid and global.bi_power_rail_table[neighbour.unit_number]
          if neighbour then
            pole.connect_neighbour(neighbour.pole)
            BioInd.writeDebug("Connected poles!")
          end
        end
      end

      -- Look for Power-rail connectors
      connector = base.surface.find_entities_filtered{
        position = base.position,
        radius = BioInd.POWER_TO_RAIL_WIRE_DISTANCE,    -- maximum_wire_distance of Power-to-rail-connectors
        name = "bi-power-to-rail-pole"
      }
      -- Connect to first Power-rail connector we've found
      if connector and next(connector) then
        pole.connect_neighbour(connector[1])
        BioInd.writeDebug("Connected " .. pole.name .. " (" .. pole.unit_number ..
                          ") to " .. connector[1].name .. " (" .. connector[1].unit_number .. ")")
        BioInd.writeDebug("Connected %s (%g) to %s (%g)", {pole.name, pole.unit_number, connector[1].name, connector[1].unit_number})
      end
      BioInd.writeDebug("Stored %s (%g) in global table", {base.name, base.unit_number})
    end

  -- Electric poles -- we need to take care that they don't hook up to hidden poles!
  elseif entity.valid and entity.type == "electric-pole" and
          entity.name ~= "bi-rail-hidden-power-pole" and
          entity.name ~= "bi-power-to-rail-pole" then

    BioInd.writeDebug("Electric pole has been built")

    pole = entity
    --~ local neighbours = pole.neighbours["copper"]

    for n, neighbour in ipairs(pole.neighbours["copper"] or {}) do
      if neighbour.name == "bi-rail-hidden-power-pole" then
        pole.disconnect_neighbour(neighbour)
        BioInd.writeDebug("Disconnected %s (%g) from %s (%g)", {pole.name, pole.unit_number, neighbour.name, neighbour.unit_number})
      end
    end
  end
  BioInd.writeDebug("End of function On_Built")
end


local remove_compound_entities = {
  ["bi-bio-farm"] = {tab = "bi_bio_farm_table", hidden = {"pole", "panel", "lamp"}},
  ["bi-bio-solar-farm"] = {tab = "bi_solar_farm_table", hidden = {"pole"}},
  ["bi-solar-boiler"] = {tab = "bi_solar_boiler_table", hidden = {"boiler", "pole"}},
  ["bi-straight-rail-power"] = {tab = "bi_power_rail_table", hidden = {"pole"}},
  ["bi-curved-rail-power"] = {tab = "bi_power_rail_table", hidden = {"pole"}},
  ["bi-arboretum"] = {tab = "Arboretum_Table", hidden = {"radar", "pole", "lamp"}},
  ["bi-bio-cannon"] = {tab = "Bio_Cannon_Table", hidden = {"radar"}},
}

local function remove_plants(entity_position, tabl)
BioInd.writeDebug("Entered function remove_plants(%s, %s)", {entity_position or "nil", tabl or "nil"})
    local e = BioInd.normalize_position(entity_position)
    if not e then
      BioInd.arg_err(entity_position or "nil", "positio")
    end
    BioInd.check_args(tabl, "table")

    local pos

    for k, v in pairs(tabl or {}) do
      pos = BioInd.normalize_position(v.position)
      if pos and pos.x == e.x and pos.y == e.y then
BioInd.writeDebug("Removing entry %s from table: %s", {k, v})
        table.remove(tabl, k)
        break
      end
    end
end

--------------------------------------------------------------------
local function On_Pre_Remove(event)
BioInd.writeDebug("Entered function On_Pre_Remove(%s)", {event})
  local entity = event.entity

  if not (entity and entity.valid) then
    BioInd.writeDebug("No valid entity -- nothing to do!")
    return
  end

  --~ --- Bio Farm has been removed
  --~ if entity.name == "bi-bio-farm" then
  --~ BioInd.writeDebug("Bio Farm has been removed")
    --~ local bi_bio_farm = global.bi_bio_farm_table[entity.unit_number]
    --~ if bi_bio_farm then
      --~ for e, ent in ipairs({"pole", "panel", "lamp"}) do
        --~ BioInd.remove_entity(bi_bio_farm[ent])
      --~ end
      --~ global.bi_bio_farm_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Bio Solar Farm has been removed
  --~ if entity.valid and entity.name == "bi-bio-solar-farm" then
    --~ BioInd.writeDebug("Solar Farm has been removed")
    --~ local bi_solar_farm = global.bi_solar_farm_table[entity.unit_number]
    --~ if bi_solar_farm then
      --~ BioInd.remove_entity(bi_solar_farm.pole)
      --~ global.bi_solar_farm_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Bio Solar Boiler has been removed
  --~ if entity.valid and entity.name == "bi-solar-boiler" then
    --~ BioInd.writeDebug("Solar Boiler has been removed")
    --~ local bi_solar_boiler = global.bi_solar_boiler_table[entity.unit_number]
    --~ if bi_solar_boiler then
      --~ BioInd.remove_entity(bi_solar_boiler.boiler)
      --~ BioInd.remove_entity(bi_solar_boiler.pole)
      --~ global.bi_solar_boiler_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Power Rail has been removed
  -- if (entity.valid and entity.name == "bi-straight-rail-power") or
    -- (entity.valid and entity.name == "bi-curved-rail-power") then
  --~ if entity.valid and entity.name:match("bi%-%a+%-rail%-power") then
    --~ BioInd.writeDebug("Power-Rail has been removed")
    --~ local bi_power_rail = global.bi_power_rail_table[entity.unit_number]
    --~ if bi_power_rail then
      --~ -- Connections must be explicitely removed, otherwise the poles from the
      --~ -- remaining rails will automatically connect and gap the bridge in the
      --~ -- powersupply
      --~ bi_power_rail.pole.disconnect_neighbour()
      --~ BioInd.remove_entity(bi_power_rail.pole)
      --~ global.bi_power_rail_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Rail-to-power connector has been removed
  --~ if entity.valid and entity.name == "bi-power-to-rail-pole" then
    --~ BioInd.writeDebug("Rail-to-power connector has been removed")
    --~ -- Connections must be explicitely removed, otherwise the poles from the
    --~ -- different rail tracks hooked up to this connector will automatically
    --~ -- keep the separate power networks connected
    --~ entity.disconnect_neighbour()
    --~ BioInd.writeDebug("Removed copper wires from %s (%g)", {entity.name, entity.unit_number})
  --~ end

  --~ --- Arboretum has been removed
  --~ if entity.valid and entity.name == "bi-arboretum" then

    --~ local arboretum = global.Arboretum_Table[entity.unit_number]
    --~ if arboretum then
    --~ --game.print("passed if statement: global.Arboretum_Table[entity.unit_number]")  -- it does not get here now!
      --~ if arboretum.radar then
        --~ global.Arboretum_Radar_Table[arboretum.radar.unit_number] = nil
      --~ end

      --~ for e, ent in ipairs({"radar", "pole", "lamp"}) do
        --~ BioInd.remove_entity(arboretum[ent])
      --~ end

      --~ global.Arboretum_Table[entity.unit_number] = nil
    --~ end
  --~ end

  local compound_entity = remove_compound_entities[entity.name]
  local base_entry = compound_entity and global[compound_entity.tab][entity.unit_number]

  -- Found a compound entity from our list!
  if base_entry then
BioInd.show("Found compound entity", base_entry.base and base_entry.base.name)

    -- Arboretum: Need to separately remove the entry from the radar table
    if entity.name == "bi-arboretum" then
      global.Arboretum_Radar_Table[base_entry.radar.unit_number] = nil
BioInd.show("Removed arboretum radar! Table", global.Arboretum_Radar_Table)
    end

    -- Power rails: Connections must be explicitely removed, otherwise the poles
    -- from the remaining rails will automatically connect and bridge the gap in
    -- the power supply!
    if entity.name:match("bi%-%a+%-rail%-power") then
      BioInd.writeDebug("Disconnecting %s %s!", {base_entry.pole.name, base_entry.pole.unit_number})
      base_entry.pole.disconnect_neighbour()
    end

    -- Default: Remove all hidden entities!
    for _, hidden in ipairs(compound_entity.hidden or {}) do
BioInd.writeDebug("Removing hidden entity %s %s", {base_entry[hidden].name, base_entry[hidden].unit_number})
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
  --~ end

  -- Seedling
  --~ if entity.valid and entity.name == "seedling" then
    --~ BioInd.writeDebug("Seedling has been removed")
    --~ -- positions from entity and table
    --~ local e = BioInd.normalize_position(entity.position)
    --~ local t
    --~ for k, v in pairs(global.bi.tree_growing) do
      --~ t = BioInd.normalize_position(v.position)
      --~ if e and t and t.x == e.x and t.y == e.y then
        --~ table.remove(global.bi.tree_growing, k)
        --~ return
      --~ end
    --~ end
  --~ end
  elseif entity.name == "seedling" then
    BioInd.writeDebug("Seedling has been removed")
    remove_plants(entity.position, global.bi.tree_growing)
  --~ end

  --~ --- Tree Stage 1 Removed
  --~ if entity.valid and entity.type == "tree" and global.bi.trees[entity.name] then
    --~ BioInd.writeDebug("Tree Removed removed name: %s", {entity.name})
    --~ local tree_name = (string.find(entity.name, "bio%-tree%-"))
    --~ BioInd.writeDebug("Tree Removed removed name: %s", {tree_name})
    --~ if tree_name then
      --~ local tree_stage_1 = (string.find(entity.name, '1.-$'))
      --~ if tree_stage_1 then
        --~ BioInd.writeDebug("1: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_1})
        --~ for k, v in pairs(global.bi.tree_growing_stage_1) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_1, k)
            --~ return
          --~ end
        --~ end
      --~ end

      --~ local tree_stage_2 = (string.find(entity.name, '2.-$'))
      --~ if tree_stage_2 then
        --~ BioInd.writeDebug("2: Entity Name: %s (%g)", {entity.name, tree_stage_2})
        --~ for k, v in pairs(global.bi.tree_growing_stage_2) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_2, k)
            --~ return
          --~ end
        --~ end
      --~ end

      --~ local tree_stage_3 = (string.find(entity.name, '3.-$'))
      --~ if tree_stage_3 then
        --~ BioInd.writeDebug("3: Entity Name: %s (%g)", {entity.name, tree_stage_3})
        --~ for k, v in pairs(global.bi.tree_growing_stage_3) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_3, k)
            --~ return
          --~ end
        --~ end
      --~ end

      --~ local tree_stage_4 = (string.find(entity.name, '4.-$'))
      --~ if tree_stage_4 then
        --~ BioInd.writeDebug("4: Entity Name: %s (%g)", {entity.name, tree_stage_4})
        --~ for k, v in pairs(global.bi.tree_growing_stage_4) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_4, k)
            --~ return
          --~ end
        --~ end
      --~ end
    --~ end
  --~ end

  --- Removed tree
  elseif entity.type == "tree" and global.bi.trees[entity.name] then
    BioInd.show("Removed tree", entity.name)
    --~ local tree_name = (string.find(entity.name, "bio%-tree%-"))
    --~ BioInd.writeDebug("Tree Removed removed name: %s", {tree_name})
    local tree_stage = entity.name:match('^.+%-(%d)$')
BioInd.writeDebug("Removed tree %s (grow stage: %s)", {entity.name, tree_stage or nil})
    if tree_stage then
      remove_plants(entity.position, global.bi["tree_growing_stage_" .. tree_stage])
    else
      error(string.format("Tree %s does not have a valid tree_stage: %s", entity.name, tree_stage or "nil"))
    end

  -- Removed something else
  else
    BioInd.writeDebug("%s has been removed -- nothing to do!", {entity.name})
  end
end


--------------------------------------------------------------------
local function On_Death(event)
BioInd.writeDebug("Entered function On_Death(%s)", {event})
  local entity = event.entity

  -- Currently, we just want to remove hidden entities and clean up
  -- the tables etc. if an entity has been killed. But there may other
  -- things we'll have to do in the future, so let's filter out the
  -- entities On_Pre_Remove and keep the event handler open for other
  -- stuff.
  if entity and remove_compound_entities[entity.name] or
                global.bi.trees[entity.name] or
                entity.name == "bi-power-to-rail-pole" or
                entity.name == "seedling" then
    BioInd.writeDebug("Divert to On_Pre_Remove!")
    On_Pre_Remove(event)
  end

  --~ --- Bio Farm has been destroyed
  --~ if entity.valid and entity.name == "bi-bio-farm" then
  --~ BioInd.writeDebug("Bio Farm has been destroyed")
    --~ local bio_farm = global.bi_bio_farm_table[entity.unit_number]
    --~ if bio_farm then
      --~ for e, ent in ipairs({"pole", "panel", "lamp"}) do
        --~ BioInd.remove_entity(bio_farm[ent])
      --~ end
      --~ global.bi_bio_farm_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Bio Solar Farm has been destroyed
  --~ if entity.valid and entity.name == "bi-bio-solar-farm" then
  --~ BioInd.writeDebug("Solar Farm has been destroyed")
    --~ local bi_solar_farm = global.bi_solar_farm_table[entity.unit_number]
    --~ if bi_solar_farm then
      --~ BioInd.remove_entity(bi_solar_farm.pole)
      --~ global.bi_solar_farm_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Bio Solar Boiler has been destroyed
  --~ if entity.valid and entity.name == "bi-solar-boiler" then
  --~ BioInd.writeDebug("Solar Boiler has been destroyed")
    --~ local bi_solar_boiler = global.bi_solar_boiler_table[entity.unit_number]
    --~ if bi_solar_boiler then
      --~ BioInd.remove_entity(bi_solar_boiler.boiler)
      --~ BioInd.remove_entity(bi_solar_boiler.pole)
      --~ global.bi_solar_boiler_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Power Rail has been destroyed
  --~ if (entity.valid and entity.name == "bi-straight-rail-power") or
     --~ (entity.valid and entity.name == "bi-curved-rail-power") then
    --~ BioInd.writeDebug("Power-Rail has been destroyed")
    --~ local bi_power_rail = global.bi_power_rail_table[entity.unit_number]
    --~ if bi_power_rail then
      --~ BioInd.remove_entity(bi_power_rail.pole)
      --~ global.bi_power_rail_table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Arboretum has been removed
  --~ if entity.valid and entity.name == "bi-arboretum" then
    --~ BioInd.writeDebug("Arboretum has been removed")
    --~ BioInd.show("entity unit_number", entity.unit_number)
    --~ BioInd.show("global.Arboretum_Table", global.Arboretum_Table[entity.unit_number])

    --~ local Arboretum = global.Arboretum_Table[entity.unit_number]
    --~ if Arboretum then
      --~ for e, ent in ipairs("radar", "pole", "lamp") do
        --~ BioInd.remove_entity(Arboretum[ent])
      --~ end
      --~ global.Arboretum_Table[entity.unit_number] = nil
    --~ end
  --~ end

  --~ --- Seedling destroyed
  --~ if entity.valid and entity.name == "seedling" then
  --~ BioInd.writeDebug("Seedling has been destroyed")
    --~ for k, v in pairs(global.bi.tree_growing) do
      --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
        --~ table.remove(global.bi.tree_growing, k)
        --~ return
      --~ end
    --~ end
  --~ end

  --~ --- Tree Stage 1 Removed
  --~ if entity.valid and entity.type == "tree" then --and global.bi.trees[entity.name] then
    --~ BioInd.show("Tree Removed removed name", entity.name)
    --~ local tree_name = (string.find(entity.name, "bio%-tree%-"))
    --~ BioInd.show("Tree Removed removed name", tree_name)
    --~ if tree_name then
      --~ local tree_stage_1 = (string.find(entity.name, '1.-$'))
      --~ if tree_stage_1 then
        --~ BioInd.writeDebug("1: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_1})
        --~ for k, v in pairs(global.bi.tree_growing_stage_1) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_1, k)
            --~ return
          --~ end
        --~ end
      --~ end

      --~ local tree_stage_2 = (string.find(entity.name, '2.-$'))
      --~ if tree_stage_2 then
        --~ BioInd.writeDebug("2: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_2})
        --~ for k, v in pairs(global.bi.tree_growing_stage_2) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_2, k)
            --~ return
          --~ end
        --~ end
      --~ end

      --~ local tree_stage_3 = (string.find(entity.name, '3.-$'))
      --~ if tree_stage_3 then
        --~ BioInd.writeDebug("3: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_3})
        --~ for k, v in pairs(global.bi.tree_growing_stage_3) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_3, k)
            --~ return
          --~ end
        --~ end
      --~ end

      --~ local tree_stage_4 = (string.find(entity.name, '4.-$'))
      --~ if tree_stage_4 then
        --~ BioInd.writeDebug("4: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_4})
        --~ for k, v in pairs(global.bi.tree_growing_stage_4) do
          --~ if v.position.x == entity.position.x and v.position.y == entity.position.y then
            --~ table.remove(global.bi.tree_growing_stage_4, k)
            --~ return
          --~ end
        --~ end
      --~ end
    --~ end
  --~ end
end


----------------Radars Scanning Function, used by Terraformer (Arboretum)  -----------------------------
Event.register(defines.events.on_sector_scanned, function(event)
  BioInd.show("Entered script for on_sector_scanned", event)
  ---- Each time a Arboretum-Radar scans a sector  ----
  local arboretum = global.Arboretum_Radar_Table[event.radar.unit_number]
  if arboretum then
    Get_Arboretum_Recipe(global.Arboretum_Table[arboretum], event)
  end
end, function(event)
  return event.radar.name == "bi-arboretum-radar" and true or false
end)

----- Solar Mat stuff
--------------------------------------------------------------------
--~ local function solar_mat_removed(surface, tiles)
local function solar_mat_removed(event)
  BioInd.writeDebug("Entered solar_mat_removed (\"%s\")", {event})

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
        name = {'bi-musk-mat-pole', 'bi-musk-mat-solar-panel'},
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
end


local function place_musk_floor(force, position, surface)
  BioInd.check_args(force, "string")
  position = BioInd.normalize_position(position) or BioInd.arg_err(position, "position")
  surface = BioInd.is_surface(surface) or BioInd.arg_err(surface, "surface")

  local x, y = position.x, position.y
  local created
  for n, name in ipairs({"bi-musk-mat-pole", "bi-musk-mat-solar-panel"}) do
    created = surface.create_entity({name = name, position = {x + 0.5, y + 0.5}, force = force})
    created.minable = false
    created.destructible = false
    BioInd.writeDebug("Created %s: %s", {name, created.unit_number})
  end

  -- Add to global tables!
  global.bi_musk_floor_table.tiles[x] = global.bi_musk_floor_table.tiles[x] or {}
  global.bi_musk_floor_table.tiles[x][y] = force

  global.bi_musk_floor_table.forces[force] = global.bi_musk_floor_table.forces[force] or {}
  global.bi_musk_floor_table.forces[force][x] = global.bi_musk_floor_table.forces[force][x] or {}
  global.bi_musk_floor_table.forces[force][x][y] = true
end
--------------------------------------------------------------------
-- Called from player, bot and script-raised events, so event may
-- contain "robot" or "player_index"
local function solar_mat_built(event)
BioInd.show("Entered function \"solar_mat_built\"", event)

  local tile = event.tile
  local surface = game.surfaces[event.surface_index]
  local player = event.player_index and game.players[event.player_index]
  local robot = event.robot
  local force = (UseMuskForce and MuskForceName) or
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
      -- event.tiles will also contain landscape tiles like "grass-1", and it will always
      -- contain at least one tile
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
    --~ error("Break!")
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
      --~ solar_mat_removed(surface, removed_tiles)
      solar_mat_removed({surface_index = event.surface_index, tiles = removed_tiles})
    else
      BioInd.writeDebug("%s has been built -- nothing to do!", {tile.name})
    end
  end

end


--------------------------------------------------------------------


Event.register(Event.core_events.configuration_changed, On_Config_Change)
--~ Event.register(Event.core_events.init, On_Init)
Event.register(Event.core_events.init, init)
Event.register(Event.core_events.load, On_Load)


Event.build_events = {
  defines.events.on_built_entity,
  defines.events.on_robot_built_entity,
  defines.events.script_raised_built,
  defines.events.script_raised_revive
}
Event.pre_remove_events = {
  defines.events.on_pre_player_mined_item,
  defines.events.on_robot_pre_mined,
}
Event.death_events = {
  defines.events.on_entity_died,
  defines.events.script_raised_destroy
}
Event.tile_build_events = {
  defines.events.on_player_built_tile,
  defines.events.on_robot_built_tile
}
Event.tile_remove_events = {
  defines.events.on_player_mined_tile,
  defines.events.on_robot_mined_tile
}
Event.tile_script_action = {
  defines.events.script_raised_set_tiles
}

Event.register(Event.build_events, On_Built)
Event.register(Event.pre_remove_events, On_Pre_Remove)
Event.register(Event.death_events, On_Death)
--~ Event.register(Event.death_events, On_Pre_Remove)
Event.register(Event.tile_build_events, solar_mat_built)
--~ Event.register(Event.tile_remove_events, function(event)
  --~ solar_mat_removed(game.surfaces[event.surface_index], event.tiles)
--~ end)
Event.register(Event.tile_remove_events, solar_mat_removed)

Event.register(Event.tile_script_action, function(event)
  BioInd.show("Entered tile_script_action", event)


  -- The event gives us only a list of the new tiles that have been placed. So let's
  -- check if any Musk floor has been built
  local new_musk_floor_tiles = {}
  local old_musk_floor_tiles = {}
  local remove_musk_floor_tiles = {}
  local pos, old_tile, force

  local tile_force

  for t, tile in ipairs(event.tiles) do
BioInd.show("t", t)
    pos = BioInd.normalize_position(tile.position)
    tile_force = global.bi_musk_floor_table.tiles[pos.x] and
                  global.bi_musk_floor_table.tiles[pos.x][pos.y]
                  --~ -- Fall back to MuskForceName if it is available
                 --~ UseMuskForce and MuskForceName or
                 --~ -- Fall back to "neutral"
                 --~ "neutral"
BioInd.show("Placed tile", tile.name)

    -- Musk floor was placed
    if tile.name == "bi-solar-mat" then
      BioInd.writeDebug("Musk floor tile was placed!")
      new_musk_floor_tiles[#new_musk_floor_tiles + 1] = {
        old_tile = { name = tile.name },
        position = pos,
        force = tile_force or
                UseMuskForce and MuskForceName or
                "neutral"
      }
    -- Other tile was placed -- by one of our fertilizers?
    elseif tile.name:match("^vegetation%-green%-grass%-[13]$") or
            tile.name:match("^vegetation%-green%-grass%-[13]$") then
      BioInd.writeDebug("Fertilizer was used!")

      -- Fertilizer was used on a Musk floor tile -- restore the tile!
BioInd.show("Musk floor tile in position", tile_force)
      if tile_force then
        old_musk_floor_tiles[#old_musk_floor_tiles + 1] = {
          old_tile = { name == "bi-solar-mat" },
          position = pos,
          force = tile_force
        }

      -- Other tile was placed on a Musk floor tile -- remove Musk floor from lists!
      elseif tile_force then
        remove_musk_floor_tiles[#remove_musk_floor_tiles + 1] = {
          old_tile = { name == "bi-solar-mat" },
          position = pos,
        }
      end
    end
  end
BioInd.show("new_musk_floor_tiles", new_musk_floor_tiles)
BioInd.show("old_musk_floor_tiles", old_musk_floor_tiles)
BioInd.show("remove_musk_floor_tiles", remove_musk_floor_tiles)

  if next(new_musk_floor_tiles) then
    solar_mat_built({
      surface_index = event.surface_index,
      --~ tile =  tile,
      tile = {name = "bi-solar-mat"},
      force = MuskForceName,
      --~ tiles = {old_tile = tile, position = tile.position}
      tiles = new_musk_floor_tiles
    })
  end
  if next(old_musk_floor_tiles) then
    solar_mat_built({
      surface_index = event.surface_index,
      tile = {name = "bi-solar-mat"},
      --~ force = MuskForceName,
      tiles = old_musk_floor_tiles
    })
  end
  if next(remove_musk_floor_tiles) then
    --~ solar_mat_removed({
      --~ surface_index = event.surface_index,
      --~ tiles = remove_musk_floor_tiles
    --~ })
  --~ end
    --~ solar_mat_removed(event.surface_index, remove_musk_floor_tiles)
      solar_mat_removed({surface_index = event.surface_index, tiles = remove_musk_floor_tiles})
  end
  BioInd.show("End of tile_script_action", event)
end)


------------------------------------------------------------------------------------
--                    FIND LOCAL VARIABLES THAT ARE USED GLOBALLY                 --
--                              (Thanks to eradicator!)                           --
------------------------------------------------------------------------------------
setmetatable(_ENV, {
  __newindex = function (self, key, value) --locked_global_write
    error('\n\n[ER Global Lock] Forbidden global *write*:\n'
      .. serpent.line{key = key or '<nil>', value = value or '<nil>'} .. '\n')
    end,
  __index   =function (self, key) --locked_global_read
      if not (key == "game" or key == "mods") then
        error('\n\n[ER Global Lock] Forbidden global *read*:\n'
          .. serpent.line{key = key or '<nil>'} .. '\n')
      end
    end ,
  })
