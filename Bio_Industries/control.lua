-- Add support for the Lua API global Variable Viewer (gvv)
-- (Setting will only exist if the mod is active!)
do
  local setting = settings.startup["BI_Enable_gvv_support"]
  if setting and setting.value then
    log("Activating support for gvv!")
    require("__gvv__/gvv")()
  end
end

-- Check if "omnimatter_fluid" is active
local OMNImatter_fluid
if script.active_mods["omnimatter_fluid"] then
  OMNImatter_fluid = true
end


local BioInd = require('common')('Bio_Industries')

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

--------------------------------------------------------------------
local function On_Init()
log("Entered On_Init!")
game.check_prototype_translations()

  if global.Bio_Cannon_Table ~= nil then
    Event.register(defines.events.on_tick, function(event) end)
  end

  if global.bi == nil then
    global.bi = {}
    global.bi.tree_growing = {}
    global.bi.tree_growing_stage_1 = {}
    global.bi.tree_growing_stage_2 = {}
    global.bi.tree_growing_stage_3 = {}
    global.bi.tree_growing_stage_4 = {}
    global.bi.terrains = {}
    global.bi.trees = {}
  end

  global.bi.seed_bomb = {}
  global.bi.seed_bomb["seedling"] = "seedling"
  global.bi.seed_bomb["seedling-2"] = "seedling-2"
  global.bi.seed_bomb["seedling-3"] = "seedling-3"

  -- Global table for bio farm
  global.bi_bio_farm_table = global.bi_bio_farm_table or {}

  -- Global table for solar boiler
  global.bi_solar_boiler_table = global.bi_solar_boiler_table or {}

  -- Global table for solar farm
  global.bi_solar_farm_table = global.bi_solar_farm_table or {}

  -- Global table for power rail
  global.bi_power_rail_table = global.bi_power_rail_table or {}

  -- Global table for arboretum
  global.Arboretum_Table = global.Arboretum_Table or {}

  -- Global table for arboretum radars
  global.Arboretum_Radar_Table = global.Arboretum_Radar_Table or {}

  -- enable researched recipes
  for i, force in pairs(game.forces) do
    force.reset_technologies()
    force.reset_recipes()
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


  -- Reset technologies
  for f, force in pairs(game.forces) do
    force.reset_technology_effects()
  end
  BioInd.writeDebug("Reset technologies for all forces!")

  if global.bi == nil then
    global.bi = {}
    global.bi.tree_growing = {}
    global.bi.tree_growing_stage_1 = {}
    global.bi.tree_growing_stage_2 = {}
    global.bi.tree_growing_stage_3 = {}
    global.bi.tree_growing_stage_4 = {}
    global.bi.terrains = {}
    global.bi.trees = {}
  end

  global.bi.seed_bomb = {}
  global.bi.seed_bomb["seedling"] = "seedling"
  global.bi.seed_bomb["seedling-2"] = "seedling-2"
  global.bi.seed_bomb["seedling-3"] = "seedling-3"

  -- Global table for bio farm
  global.bi_bio_farm_table = global.bi_bio_farm_table or {}

  -- Global table for solar boiler
  global.bi_solar_boiler_table = global.bi_solar_boiler_table or {}

  -- Global table for solar farm
  global.bi_solar_farm_table = global.bi_solar_farm_table or {}

  -- Global table for power rail
  global.bi_power_rail_table = global.bi_power_rail_table or {}

  -- Global table for arboretum
  global.Arboretum_Table = global.Arboretum_Table or {}

  -- Global table for arboretum radars
  global.Arboretum_Radar_Table = global.Arboretum_Radar_Table or {}

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

  -- Has setting BI_Show_musk_floor_in_mapview changed?
  if ConfigurationChangedData.mod_startup_settings_changed then
    -- Create dummy force if necessary
    if UseMuskForce and not game.forces[MuskForceName] then
      Create_dummy_force()
    end

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
      techs['bi-tech-fertiliser'].reload()
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

  local AlienBiomes = BioInd.AB_tiles()

  -- Basic
  if global.bi.seed_bomb[ent.name] == "seedling" then
    BioInd.writeDebug("Seed Bomb Activated - Basic")
    seed_planted_trigger(event)

  -- Standard
  elseif global.bi.seed_bomb[ent.name] == "seedling-2" then
    BioInd.writeDebug("Seed Bomb Activated - Standard")
    local terrain_name_s
    --~ if game.active_mods["alien-biomes"] then
    if AlienBiomes then
      terrain_name_s = "vegetation-green-grass-3"
    else
      terrain_name_s = "grass-3"
    end
    surface.set_tiles{{name = terrain_name_s, position = position}}
    seed_planted_trigger(event)

  -- Advanced
  elseif global.bi.seed_bomb[ent.name] == "seedling-3" then
    BioInd.writeDebug("Seed Bomb Activated - Advanced")
    local terrain_name_a
    --~ if game.active_mods["alien-biomes"] then
    if AlienBiomes then
      terrain_name_a = "vegetation-green-grass-1"
    else
      terrain_name_a = "grass-1"
    end
    surface.set_tiles{{name = terrain_name_a, position = position}}
    seed_planted_trigger(event)
  end
end)

--------------------------------------------------------------------
local function On_Built(event)
  local entity = event.created_entity or event.entity
  local surface = entity.surface
  local force = entity.force
  local position = entity.position
BioInd.writeDebug("Entered function On_Built with these data: " .. serpent.block(event))
BioInd.writeDebug("Entity name: %s", {entity.name})

  -- We can ignore ghosts -- if ghosts are revived, there will be
  -- another event that triggers where actual entities are placed!
  if entity.name == "entity-ghost" then
    BioInd.writeDebug("Built ghost of %s -- return!", {entity.ghost_name})
    return
  end

  --- Seedling planted
  if entity.valid and entity.name == "seedling" then
    seed_planted (event)
  -- Make it all one big if-then-elseif-statement! Otherwise, we may get a crash later on when
  -- an entity has been replaced but is still referred to in following blocks. (Pi-C)
  --~ end

    --- Bio Farm has been built
  elseif entity.valid and entity.name == "bi-bio-farm" then
    BioInd.writeDebug("Bio Farm has been built")
    local b_farm = entity

    local pole_name = "bi-bio-farm-electric-pole"
    local panel_name = "bi-bio-farm-solar-panel"
    local lamp_name = "bi-bio-farm-light"

    -- Hidden Power Pole
    local create_pole = surface.create_entity({
      name = pole_name,
      position = position,
      force = force
    })

    -- Hidden Solar Panel
    local create_panel = surface.create_entity({
      name = panel_name,
      position = position,
      force = force
    })

    -- Hidden Lamp
    local create_lamp = surface.create_entity({
      name = lamp_name,
      position = position,
      force = force
    })

    create_pole.minable = false
    create_pole.destructible = false
    create_panel.minable = false
    create_panel.destructible = false
    create_lamp.minable = false
    create_lamp.destructible = false

    -- Group Multiple Entities Together
    global.bi_bio_farm_table[b_farm.unit_number] = {
      base = b_farm,
      pole = create_pole,
      panel = create_panel,
      lamp = create_lamp
    }
    BioInd.writeDebug("Stored Biofarm %g in table: %s", {b_farm.unit_number,    global.bi_bio_farm_table[b_farm.unit_number]})
  --~ end

  --- Bio Solar Boiler / Solar Plant has been built
  elseif entity.valid and entity.name == "bi-solar-boiler" then
   BioInd.writeDebug("Bio Solar Boiler has been built")
    local solar_plant = entity
    --local boiler_solar = "bi-solar-boiler-2"
    --local boiler_solar = "bi-solar-boiler"
    local boiler_solar = "bi-solar-boiler-panel"
    local sm_pole_name = "bi-hidden-power-pole"

    -- Hidden Solar Panel
    local create_solar_boiler = surface.create_entity({
      name = boiler_solar,
      position = position,
      force = force
    })

    -- Hidden Power Pole
    local create_sm_pole = surface.create_entity({
      name = sm_pole_name,
      position = position,
      force = force
    })

    create_solar_boiler.minable = false
    create_solar_boiler.destructible = false
    create_sm_pole.minable = false
    create_sm_pole.destructible = false

    -- Group Multiple Entities Together
    global.bi_solar_boiler_table[solar_plant.unit_number] = {
      base = solar_plant,
      boiler = create_solar_boiler,
      pole = create_sm_pole
    }
    BioInd.writeDebug("Stored solar boiler %g in table: %s", {solar_plant.unit_number, global.bi_solar_boiler_table[solar_plant.unit_number]})
  --~ end

    --- Solar Farm has been built
  elseif entity.valid and entity.name == "bi-bio-solar-farm" then
    BioInd.writeDebug("Bio Solar Farm has been built")
    local solar_farm = entity
    local sm_pole_name = "bi-hidden-power-pole"

    -- Hidden Power Pole
    local create_sm_pole = surface.create_entity({
      name = sm_pole_name,
      position = position,
      force = force
    })
    create_sm_pole.minable = false
    create_sm_pole.destructible = false

    -- Group Multiple Entities Together
    global.bi_solar_farm_table[solar_farm.unit_number] = {
      base = solar_farm,
      pole = create_sm_pole
    }
    BioInd.writeDebug("Bio Solar Farm %g in table: %s", {solar_farm.unit_number, global.bi_solar_farm_table[solar_farm.unit_number]})
  --~ end

  --- Bio Cannon has been built
  elseif entity.valid and
      -- Built normally
      (entity.name == "bi-bio-cannon-area" or
      -- Built from blueprint
       entity.name == "bi-bio-cannon") then
    local New_Bio_Cannon
    local New_Bio_CannonR

    BioInd.writeDebug("Bio Cannon has been built")

    -- Hidden Radar
    New_Bio_CannonR = surface.create_entity({
      name = "Bio-Cannon-r",
      position = position,
      direction = event.created_entity.direction,
      force = force
    })
    New_Bio_CannonR.operable = false
    New_Bio_CannonR.destructible = false
    New_Bio_CannonR.minable = false

    -- New Cannon, the first was just used for Radius overlay
    -- (If normally built -- if built from blueprint we just use the same code anyway.)
    New_Bio_Cannon = surface.create_entity({
      name = "bi-bio-cannon",
      position = position,
      direction = event.created_entity.direction,
      force = force
    })
    New_Bio_Cannon.health = event.created_entity.health

    if not global.Bio_Cannon_Table then
      global.Bio_Cannon_Table = {}
      Event.register(defines.events.on_tick, function(event) end)
    end

    -- Group Multiple Entities Together
    --~ table.insert(global.Bio_Cannon_Table, {New_Bio_Cannon, New_Bio_CannonR, 0})
    global.Bio_Cannon_Table[New_Bio_Cannon.unit_number] = {
      base = New_Bio_Cannon,
      radar = New_Bio_CannonR,
      delay = 0
    }
    -- Remove the "Overlay" Entity
    event.created_entity.destroy()
    BioInd.writeDebug("Stored Bio Cannon %g in table: %s", {#global.Bio_Cannon_Table, global.Bio_Cannon_Table})
  -- end

  --- Arboretum has been built
  --~ if entity.valid and entity.name == "bi-arboretum-area" then
  elseif entity.valid and
      -- Built normally
      (entity.name == "bi-arboretum-area" or
      -- Built from blueprint
      entity.name == "bi-arboretum") then
    BioInd.writeDebug("Arboretum has been built")
    local arboretum_new = "bi-arboretum"
    local radar_name = "bi-arboretum-radar"
    local pole_name = "bi-hidden-power-pole"
    local lamp_name = "bi-bio-farm-light"

    -- New Arboretum, the first was just used for Radius overlay
    local create_arboretum = surface.create_entity({
      name = arboretum_new,
      position = position,
      direction = entity.direction,
      force = force
    })
    local position_c = {position.x - 3.5, position.y + 3.5}

    -- Radar
    local create_radar = surface.create_entity({
      name = radar_name,
      position = position_c,
      direction = entity.direction,
      force = force
    })

    -- Hidden pole
    local create_pole = surface.create_entity({
      name = pole_name,
      position = position,
      direction = entity.direction,
      force = force
    })

    -- Hidden Lamp
    local create_lamp = surface.create_entity({
      name = lamp_name,
      position = position,
      force = force
    })

    create_radar.minable = false
    create_radar.destructible = false
    create_pole.minable = false
    create_pole.destructible = false
    create_lamp.minable = false
    create_lamp.destructible = false

    -- Group Multiple Entities Together
    global.Arboretum_Table[create_arboretum.unit_number] = {
      base = create_arboretum,
      radar = create_radar,
      pole = create_pole,
      lamp = create_lamp
    }

    BioInd.writeDebug("built: entity unit_number: %s", {create_arboretum.unit_number})
    BioInd.writeDebug("built: global.Arboretum_Table: %s", {global.Arboretum_Table[create_arboretum.unit_number]})

    -- Remove the "Overlay" Entity
    event.created_entity.destroy()
  --~ end

  -- Power Rail
  elseif entity.valid and
          (entity.name == "bi-straight-rail-power" or
           entity.name == "bi-curved-rail-power") then
    BioInd.writeDebug("Power Rail has been built")

    local rail_track = entity
    local pole_name = "bi-rail-hidden-power-pole"

    -- Create Hidden Power Pole
    local create_rail_pole = surface.create_entity({
      name = pole_name,
      position = position,
      force = force
    })

    create_rail_pole.minable = false
    create_rail_pole.destructible = false

    -- Group Multiple Entities Together Together
    global.bi_power_rail_table[rail_track.unit_number] = {base = rail_track, pole = create_rail_pole}

    if global.bi_power_rail_table[rail_track.unit_number].pole.valid then
      -- Remove all copper wires from new pole
      create_rail_pole.disconnect_neighbour()
BioInd.writeDebug("Removed all wires from %s %g", {create_rail_pole.name,  create_rail_pole.unit_number})

      -- Look for connecting rails at front and back of the new rail
      for s, side in ipairs( {"front", "back"} ) do
BioInd.writeDebug("Looking for rails at %s", {side})
        local neighbour
        -- Look in all three directions
        for d, direction in ipairs( {"left", "straight", "right"} ) do
BioInd.writeDebug("Looking for rails in %s direction", {direction})
          neighbour = rail_track.get_connected_rail{
            rail_direction = defines.rail_direction[side],
            rail_connection_direction = defines.rail_connection_direction[direction]
          }
BioInd.writeDebug("Rail %s of %s (%s): %s (%s)", {direction, rail_track.name, rail_track.unit_number, tostring(neighbour and neighbour.name), tostring(neighbour and neighbour.unit_number)})

          -- Only make a connection if found rail is a powered rail
          -- (We'll know it's the right type if we find it in our table!)
          neighbour = neighbour and neighbour.valid and global.bi_power_rail_table[neighbour.unit_number]
          if neighbour then
            create_rail_pole.connect_neighbour(neighbour.pole)
            BioInd.writeDebug("Connected poles!")
          end
        end
      end

      -- Look for Power-rail connectors
      local connector = rail_track.surface.find_entities_filtered{
        position = rail_track.position,
        radius = BioInd.POWER_TO_RAIL_WIRE_DISTANCE,    -- maximum_wire_distance of Power-to-rail-connectors
        name = "bi-power-to-rail-pole"
      }
      -- Connect to first Power-rail connector we've found
      if connector and table_size(connector) > 0 then
        create_rail_pole.connect_neighbour(connector[1])
        BioInd.writeDebug("Connected " .. create_rail_pole.name .. " (" .. create_rail_pole.unit_number ..
                          ") to " .. connector[1].name .. " (" .. connector[1].unit_number .. ")")
        BioInd.writeDebug("Connected %s (%g) to %s (%g)", {create_rail_pole.name, create_rail_pole.unit_number, connector[1].name, connector[1].unit_number})
      end
      BioInd.writeDebug("Stored %s (%g) in global table", {rail_track.name, rail_track.unit_number})
    end

  -- Electric poles -- we need to take care that they don't hook up to hidden poles!
  elseif entity.valid and entity.type == "electric-pole" and
          entity.name ~= "bi-rail-hidden-power-pole" and
          entity.name ~= "bi-power-to-rail-pole" then

    BioInd.writeDebug("Electric pole has been built")

    local pole = entity
    local neighbours = pole.neighbours["copper"]

    for n, neighbour in ipairs(neighbours) do
      if neighbour.name == "bi-rail-hidden-power-pole" then
        pole.disconnect_neighbour(neighbour)
        BioInd.writeDebug("Disconnected %s (%g) from %s (%g)", {pole.name, pole.unit_number, neighbour.name, neighbour.unit_number})
      end
    end
  end
  BioInd.writeDebug("End of function On_Built")
end


--------------------------------------------------------------------
local function On_Remove(event)
  local entity = event.created_entity or event.entity
  --- Bio Farm has been removed
  if entity.valid and entity.name == "bi-bio-farm" then
  BioInd.writeDebug("Bio Farm has been removed")
    local bi_bio_farm = global.bi_bio_farm_table[entity.unit_number]
    if bi_bio_farm then
      for e, ent in ipairs({"pole", "panel", "lamp"}) do
        BioInd.remove_entity(bi_bio_farm[ent])
      end
      global.bi_bio_farm_table[entity.unit_number] = nil
    end
  end

  --- Bio Solar Farm has been removed
  if entity.valid and entity.name == "bi-bio-solar-farm" then
    BioInd.writeDebug("Solar Farm has been removed")
    local bi_solar_farm = global.bi_solar_farm_table[entity.unit_number]
    if bi_solar_farm then
      BioInd.remove_entity(bi_solar_farm.pole)
      global.bi_solar_farm_table[entity.unit_number] = nil
    end
  end

  --- Bio Solar Boiler has been removed
  if entity.valid and entity.name == "bi-solar-boiler" then
    BioInd.writeDebug("Solar Boiler has been removed")
    local bi_solar_boiler = global.bi_solar_boiler_table[entity.unit_number]
    if bi_solar_boiler then
      BioInd.remove_entity(bi_solar_boiler.boiler)
      BioInd.remove_entity(bi_solar_boiler.pole)
      global.bi_solar_boiler_table[entity.unit_number] = nil
    end
  end

  --- Power Rail has been removed
  if (entity.valid and entity.name == "bi-straight-rail-power") or
     (entity.valid and entity.name == "bi-curved-rail-power") then
    BioInd.writeDebug("Power-Rail has been removed")
    local bi_power_rail = global.bi_power_rail_table[entity.unit_number]
    if bi_power_rail then
      -- Connections must be explicitely removed, otherwise the poles from the
      -- remaining rails will automatically connect and gap the bridge in the
      -- powersupply
      bi_power_rail.pole.disconnect_neighbour()
      BioInd.remove_entity(bi_power_rail.pole)
      global.bi_power_rail_table[entity.unit_number] = nil
    end
  end

  --- Rail-to-power connector has been removed
  if entity.valid and entity.name == "bi-power-to-rail-pole" then
    BioInd.writeDebug("Rail-to-power connector has been removed")
    -- Connections must be explicitely removed, otherwise the poles from the
    -- different rail tracks hooked up to this connector will automatically
    -- keep the separate power networks connected
    entity.disconnect_neighbour()
    BioInd.writeDebug("Removed copper wires from %s (%g)", {entity.name, entity.unit_number})
  end

  --- Arboretum has been removed
  if entity.valid and entity.name == "bi-arboretum" then

    local arboretum = global.Arboretum_Table[entity.unit_number]
    if arboretum then
    --game.print("passed if statement: global.Arboretum_Table[entity.unit_number]")  -- it does not get here now!
      if arboretum.radar then
        global.Arboretum_Radar_Table[arboretum.radar.unit_number] = nil
      end

      for e, ent in ipairs({"radar", "pole", "lamp"}) do
        BioInd.remove_entity(arboretum[ent])
      end

      global.Arboretum_Table[entity.unit_number] = nil
    end
  end

  --- Seedling Removed
  if entity.valid and entity.name == "seedling" then
    BioInd.writeDebug("Seedling has been removed")
    for k, v in pairs(global.bi.tree_growing) do
      if v.position.x == entity.position.x and v.position.y == entity.position.y then
        table.remove(global.bi.tree_growing, k)
        return
      end
    end
  end

  --- Tree Stage 1 Removed
  if entity.valid and entity.type == "tree" then --and global.bi.trees[entity.name] then
    BioInd.writeDebug("Tree Removed removed name: %s", {entity.name})
    local tree_name = (string.find(entity.name, "bio%-tree%-"))
    BioInd.writeDebug("Tree Removed removed name: %s", {tree_name})
    if tree_name then
      local tree_stage_1 = (string.find(entity.name, '1.-$'))
      if tree_stage_1 then
        BioInd.writeDebug("1: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_1})
        for k, v in pairs(global.bi.tree_growing_stage_1) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_1, k)
            return
          end
        end
      end

      local tree_stage_2 = (string.find(entity.name, '2.-$'))
      if tree_stage_2 then
        BioInd.writeDebug("2: Entity Name: %s (%g)\tTree last two digits: %s", {entity.name, tree_stage_2})
        for k, v in pairs(global.bi.tree_growing_stage_2) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_2, k)
            return
          end
        end
      end

      local tree_stage_3 = (string.find(entity.name, '3.-$'))
      if tree_stage_3 then
        BioInd.writeDebug("3: Entity Name: %s (%g)\tTree last two digits: %s", {entity.name, tree_stage_3})
        for k, v in pairs(global.bi.tree_growing_stage_3) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_3, k)
            return
          end
        end
      end

      local tree_stage_4 = (string.find(entity.name, '4.-$'))
      if tree_stage_4 then
        BioInd.writeDebug("4: Entity Name: %s (%g)\tTree last two digits: %s", {entity.name, tree_stage_4})
        for k, v in pairs(global.bi.tree_growing_stage_4) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_4, k)
            return
          end
        end
      end
    end
  end
end


--------------------------------------------------------------------
local function On_Death(event)
  local entity = event.created_entity or event.entity

  --- Bio Farm has been destroyed
  if entity.valid and entity.name == "bi-bio-farm" then
  BioInd.writeDebug("Bio Farm has been destroyed")
    local bio_farm = global.bi_bio_farm_table[entity.unit_number]
    if bio_farm then
      for e, ent in ipairs({"pole", "panel", "lamp"}) do
        BioInd.remove_entity(bio_farm[ent])
      end
      global.bi_bio_farm_table[entity.unit_number] = nil
    end
  end

  --- Bio Solar Farm has been destroyed
  if entity.valid and entity.name == "bi-bio-solar-farm" then
  BioInd.writeDebug("Solar Farm has been destroyed")
    local bi_solar_farm = global.bi_solar_farm_table[entity.unit_number]
    if bi_solar_farm then
      BioInd.remove_entity(bi_solar_farm.pole)
      global.bi_solar_farm_table[entity.unit_number] = nil
    end
  end

  --- Bio Solar Boiler has been destroyed
  if entity.valid and entity.name == "bi-solar-boiler" then
  BioInd.writeDebug("Solar Boiler has been destroyed")
    local bi_solar_boiler = global.bi_solar_boiler_table[entity.unit_number]
    if bi_solar_boiler then
      BioInd.remove_entity(bi_solar_boiler.boiler)
      BioInd.remove_entity(bi_solar_boiler.pole)
      global.bi_solar_boiler_table[entity.unit_number] = nil
    end
  end

  --- Power Rail has been destroyed
  if (entity.valid and entity.name == "bi-straight-rail-power") or
     (entity.valid and entity.name == "bi-curved-rail-power") then
    BioInd.writeDebug("Power-Rail has been destroyed")
    local bi_power_rail = global.bi_power_rail_table[entity.unit_number]
    if bi_power_rail then
      BioInd.remove_entity(bi_power_rail.pole)
      global.bi_power_rail_table[entity.unit_number] = nil
    end
  end

  --- Arboretum has been removed
  if entity.valid and entity.name == "bi-arboretum" then
    BioInd.writeDebug("Arboretum has been removed")
    BioInd.show("entity unit_number", entity.unit_number)
    BioInd.show("global.Arboretum_Table", global.Arboretum_Table[entity.unit_number])

    local Arboretum = global.Arboretum_Table[entity.unit_number]
    if Arboretum then
    --game.print("passed if statement: global.Arboretum_Table[entity.unit_number]")  -- it does not get here now!
      for e, ent in ipairs("radar", "pole", "lamp") do
        BioInd.remove_entity(Arboretum[ent])
      end
      global.Arboretum_Table[entity.unit_number] = nil
    end
  end

  --- Seedling destroyed
  if entity.valid and entity.name == "seedling" then
  BioInd.writeDebug("Seedling has been destroyed")
    for k, v in pairs(global.bi.tree_growing) do
      if v.position.x == entity.position.x and v.position.y == entity.position.y then
        table.remove(global.bi.tree_growing, k)
        return
      end
    end
  end

  --- Tree Stage 1 Removed
  if entity.valid and entity.type == "tree" then --and global.bi.trees[entity.name] then
    BioInd.show("Tree Removed removed name", entity.name)
    local tree_name = (string.find(entity.name, "bio%-tree%-"))
    BioInd.show("Tree Removed removed name", tree_name)
    if tree_name then
      local tree_stage_1 = (string.find(entity.name, '1.-$'))
      if tree_stage_1 then
        BioInd.writeDebug("1: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_1})
        for k, v in pairs(global.bi.tree_growing_stage_1) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_1, k)
            return
          end
        end
      end

      local tree_stage_2 = (string.find(entity.name, '2.-$'))
      if tree_stage_2 then
        BioInd.writeDebug("2: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_2})
        for k, v in pairs(global.bi.tree_growing_stage_2) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_2, k)
            return
          end
        end
      end

      local tree_stage_3 = (string.find(entity.name, '3.-$'))
      if tree_stage_3 then
        BioInd.writeDebug("3: Entity Name: %s\tTree last two digits: %s", {entity.name, tree_stage_3})
        for k, v in pairs(global.bi.tree_growing_stage_3) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_3, k)
            return
          end
        end
      end

      local tree_stage_4 = (string.find(entity.name, '4.-$'))
      if tree_stage_4 then
        BioInd.writeDebug("4: Entity Name: %s\tTree last two digits: %s", {entity.nametree_stage_4})
        for k, v in pairs(global.bi.tree_growing_stage_4) do
          if v.position.x == entity.position.x and v.position.y == entity.position.y then
            table.remove(global.bi.tree_growing_stage_4, k)
            return
          end
        end
      end
    end
  end
end


----------------Radars Scanning Function, used by Terraformer (Arboretum)  -----------------------------
Event.register(defines.events.on_sector_scanned, function(event)
  BioInd.show("Entered script for on_sector_scanned", event)
  ---- Each time a Arboretum-Radar scans a sector  ----
  if event.radar.name == "bi-arboretum-radar" then
    local arboretum = (global.Arboretum_Radar_Table[event.radar.unit_number])

    if OMNImatter_fluid then
      Get_Arboretum_Recipe_omnimatter_fluid(global.Arboretum_Table[arboretum], event)
    else
      Get_Arboretum_Recipe(global.Arboretum_Table[arboretum], event)
    end
  end
end)

----- Solar Mat stuff
--------------------------------------------------------------------
local function solar_mat_removed(surface, tiles)
  BioInd.writeDebug("Entered solar_mat_removed (\"%s\", \"%s\")", {surface, tiles})

  local x, y

  for t, tile in pairs(tiles) do
    if tile.old_tile and tile.old_tile.name == "bi-solar-mat" then
      x = tile.position.x or tile.position[1]
      y = tile.position.y or tile.position[2]

      for _, o in pairs(surface.find_entities_filtered{
        name = 'bi-musk-mat-pole',
        --~ position = {tile.position.x + 0.5, tile.position.y + 0.5}
        position = {x + 0.5, y + 0.5}
      } or {}) do

        o.destroy()
      end
      for _, o in pairs(surface.find_entities_filtered{
          name = 'bi-musk-mat-solar-panel',
          --~ position = {tile.position.x + 0.5, tile.position.y + 0.5}
          position = {x + 0.5, y + 0.5}
      } or {}) do

        o.destroy()
      end

      -- Remove tile from global tables
      local force_name = global.bi_musk_floor_table.tiles and
                          global.bi_musk_floor_table.tiles[x] and
                          global.bi_musk_floor_table.tiles[x][y]
      if force_name then
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
--------------------------------------------------------------------
-- Called from player, bot and script-raised events, so event may
-- contain "robot" or "player_index"""
local function solar_mat_built(event)
BioInd.show("Entered function \"solar_mat_built\"", event)

  local tile = event.tile
--~ log("event: " .. serpent.block(event))
  local surface = game.surfaces[event.surface_index]

  local force = (UseMuskForce and MuskForceName) or
                (event.player_index and game.players[event.player_index].force) or
                (event.robot and event.robot.force) or
                event.force
  --~ local old_tiles = event.tiles or {}
  local old_tiles = event.tiles


  -- Musk floor has been built -- create hidden entities!
  if tile.name == "bi-solar-mat" then
    BioInd.writeDebug("Solar Mat has been built")
BioInd.show("Tile data", tile )
    local position

    --~ for index, old_tile in pairs(old_tiles or {}) do
    for index, old_tile in pairs(old_tiles or {tile}) do
BioInd.show("Read old_tile inside loop", old_tile)
      -- event.tiles will also contain landscape tiles like "grass-1", and it will always
      -- contain at least one tile
      position = old_tile.position

      BioInd.writeDebug("Building solar mat for force %s at position %s",
        {tostring(type(force) == "table" and force.name or force), position})

      local sm_pole_name = "bi-musk-mat-pole"
      local sm_panel_name = "bi-musk-mat-solar-panel"
      local create_sm_pole, create_sm_panel
      local x = position.x or position[1]
      local y = position.y or position[2]

      -- Create pole for same force as panel if it should be visible in map view's
      -- electric grid overlay, or use dummy force if overlay should be hidden
      local create_sm_pole = surface.create_entity({
        name = sm_pole_name,
        position = {x + 0.5, y + 0.5},
        force = force
      })
      local create_sm_panel = surface.create_entity({
        name = sm_panel_name,
        position = {x + 0.5, y + 0.5},
        force = force
      })
      create_sm_pole.minable = false
      create_sm_pole.destructible = false
      create_sm_panel.minable = false
      create_sm_panel.destructible = false
      BioInd.show("Created pole", create_sm_pole.unit_number)
      BioInd.show("Created panel", create_sm_panel.unit_number)

      -- Add to global tables!
      global.bi_musk_floor_table.tiles[x] = global.bi_musk_floor_table.tiles[x] or {}
      global.bi_musk_floor_table.tiles[x][y] = force

      global.bi_musk_floor_table.forces[force] =
        global.bi_musk_floor_table.forces[force] or {}
      global.bi_musk_floor_table.forces[force][x] =
        global.bi_musk_floor_table.forces[force][x] or {}
      global.bi_musk_floor_table.forces[force][x][y] = true

    end
  -- Some other tile has been built -- check if it replaced musk floor!
  else
    BioInd.writeDebug("%s has been built.", {tile.name})
    --~ solar_mat_removed(surface, old_tiles)
  end

end


--------------------------------------------------------------------


Event.register(Event.core_events.configuration_changed, On_Config_Change)
Event.register(Event.core_events.init, On_Init)
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
Event.register(Event.pre_remove_events, On_Remove)
Event.register(Event.death_events, On_Death)
Event.register(Event.tile_build_events, solar_mat_built)
Event.register(Event.tile_remove_events, function(event)
  solar_mat_removed(game.surfaces[event.surface_index], event.tiles)
end)

Event.register(Event.tile_script_action, function(event)
  BioInd.show("Entered tile_script_action", event)

  --~ if not solar_mat_prototype then
    --~ solar_mat_prototype = game.tile_prototypes["bi-solar-mat"]
  --~ end

  if not game.forces[MuskForceName] then
    Create_dummy_force()
  end

  local tiles = {}
  for t, tile in ipairs(event.tiles) do
    if tile.name == "bi-solar-mat" then
      BioInd.writeDebug("Musk floor tile was placed!")
      tiles[#tiles + 1] = { position = tile.position }
    end
  end
BioInd.show("Made list for old_tiles", tiles)
      solar_mat_built({
        surface_index = event.surface_index,
        --~ tile =  tile,
        tile = {name = "bi-solar-mat"},
        force = MuskForceName,
        --~ tiles = {old_tile = tile, position = tile.position}
        tiles = tiles
      })

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
