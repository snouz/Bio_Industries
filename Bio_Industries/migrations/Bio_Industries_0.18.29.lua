------------------------------------------------------------------------------------
-- We didn't react to script_raised_revive before, so mods like Construction Drones
-- that filled in ghosts would just place the base entities, and not add the hidden
-- entities. Even worse: the base entities wouldn't be added to our lists! So, let's
-- rebuild everything once again!
------------------------------------------------------------------------------------

local BioInd = require('__Bio_Industries__/common')('Bio_Industries')
local cnt = 0

-- Removes the hidden entities at the position of a base entity
local function remove_entities(base, names)
  local entities = base.surface.find_entities_filtered{
    position = base.position,
    name = names,
  }

  for e, entity in ipairs(entities or {}) do
    entity.destroy()
  end
end

-- Removes the hidden entities stored with a base entity
local function remove_stored_entities(base, names)
  for e, entity in ipairs(names or {}) do
    if base[entity] and base[entity].valid then
      base[entity].destroy()
    end
  end
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


local base, boiler, lamp, pole, panel, radar
local base_name, boiler_name, lamp_name, pole_name, radar_name, panel_name, overlay_name

------------------------------------------------------------------------------------
--                                    Bio Farm                                    --
------------------------------------------------------------------------------------

-- Empty old list
for b, bio_farm in pairs(global.bi_bio_farm_table or {}) do
  -- Remove hidden entities from bio_farms in our table
  --~ for e, entity in ipairs({"pole", "panel", "lamp"}) do
    --~ if bio_farm[entity] and bio_farm[entity].valid then
      --~ bio_farm[entity].destroy()
    --~ end
  --~ end
  remove_stored_entities(bio_farm, {"pole", "panel", "lamp"})
  -- Remove entry from table
  global.bi_bio_farm_table[b] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Bio-farms.", {cnt})

-- Generate new list
--~ local bio_farms, pole, panel, lamp
local bio_farms
pole_name = "bi-bio-farm-electric-pole"
panel_name = "bi-bio-farm-solar-panel"
lamp_name = "bi-bio-farm-light"

cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all bio_farms on surface!
  bio_farms = surface.find_entities_filtered({name = "bi-bio-farm"})
  for b, bio_farm in ipairs(bio_farms or {}) do
    -- Make a clean slate!
    remove_entities(bio_farm, {pole_name, panel_name, lamp_name})

    -- Recreate hidden entities
    pole = surface.create_entity({
      name = pole_name,
      position = bio_farm.position,
      force = bio_farm.force
    })
    panel = surface.create_entity({
      name = panel_name,
      position = bio_farm.position,
      force = bio_farm.force
    })
    lamp = surface.create_entity({
      name = lamp_name,
      position = bio_farm.position,
      force = bio_farm.force
    })
    --~ for e, entity in ipairs({pole, panel, lamp}) do
      --~ entity.minable = false
      --~ entity.destructible = false
    --~ end
    make_unminable({pole, panel, lamp})
    -- Add to table
    global.bi_bio_farm_table[bio_farm.unit_number] = {
      base = bio_farm,
      pole = pole,
      panel = panel,
      lamp = lamp
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Bio-farms.", {cnt})


------------------------------------------------------------------------------------
--                          Bio Solar Boiler/Solar Plant                          --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for s, solar_boiler in pairs(global.bi_solar_boiler_table or {}) do
  -- Remove hidden entities from solar_boilers in our table
  --~ for e, entity in ipairs({"pole", "boiler"}) do
    --~ if solar_boiler[entity] and solar_boiler[entity].valid then
      --~ solar_boiler[entity].destroy()
    --~ end
  --~ end
  remove_stored_entities(solar_boiler, {"pole", "boiler"})
  -- Remove entry from table
  global.bi_solar_boiler_table[s] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Solar boilers/power plants.", {cnt})


-- Generate new list
--~ local solar_boilers, pole, boiler
local solar_boilers
pole_name = "bi-hidden-power-pole"
boiler_name = "bi-solar-boiler-panel"

cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all solar_boilers on surface!
  solar_boilers = surface.find_entities_filtered({name = "bi-solar-boiler"})
  for b, boiler_solar in ipairs(solar_boilers or {}) do
    -- Make a clean slate!
    remove_entities(boiler_solar, {pole_name, panel_name})
    -- Recreate hidden entities
    boiler = surface.create_entity({
      name = boiler_name,
      position = boiler_solar.position,
      force = boiler_solar.force
    })
    pole = surface.create_entity({
      name = pole_name,
      position = boiler_solar.position,
      force = boiler_solar.force
    })
    make_unminable({pole, boiler})
    -- Add to table
    global.bi_solar_boiler_table[boiler_solar.unit_number] = {
      base = boiler_solar,
      boiler = boiler,
      pole = pole
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Solar boilers/power plants.", {cnt})



------------------------------------------------------------------------------------
--                                       Solar Farm                                   --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for s, solar_farm in pairs(global.bi_solar_farm_table or {}) do
  -- Remove hidden entities from solar_boilers in our table
  --~ for e, entity in ipairs({"pole"}) do
    --~ if solar_farm[entity] and solar_farm[entity].valid then
      --~ solar_farm[entity].destroy()
    --~ end
  --~ end
  remove_stored_entities(solar_farm, {"pole"})
  -- Remove entry from table
  global.bi_solar_farm_table[s] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Solar farms.", {cnt})


-- Generate new list
--~ local solar_farms, pole
local solar_farms
pole_name = "bi-hidden-power-pole"

cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all solar_boilers on surface!
  solar_farms = surface.find_entities_filtered({name = "bi-bio-solar-farm"})
  for sf, solar_farm in ipairs(solar_farms or {}) do
    -- Make a clean slate!
    remove_entities(solar_farm, {pole_name})
    -- Recreate hidden entities
    pole = surface.create_entity({
      name = pole_name,
      position = solar_farm.position,
      force = solar_farm.force
    })
    make_unminable({pole})
    -- Add to table
    global.bi_solar_farm_table[solar_farm.unit_number] = {
      base = solar_farm,
      pole = pole
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Solar farms.", {cnt})



------------------------------------------------------------------------------------
--                                   Bio Cannon                                   --
--  Bio Cannons have a different table format -- make that the same as the others --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for b, bio_cannon in pairs(global.Bio_Cannon_Table or {}) do
  -- Remove hidden entities from Bio cannons in our table

  if bio_cannon[2] and bio_cannon[2].valid then
    bio_cannon[2].destroy()
  end
  -- Remove entry from table
  global.Bio_Cannon_Table[b] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Bio-Cannons.", {cnt})


-- Generate new list
--~ local bio_cannons, base, radar
local bio_cannons
base_name = "bi-bio-cannon"
overlay_name = "bi-bio-cannon-area"
radar_name = "Bio-Cannon-r"

cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all solar_boilers on surface!
  bio_cannons = surface.find_entities_filtered({name = {base_name, overlay_name}})
  for b, bio_cannon in ipairs(bio_cannons or {}) do
    -- Make a clean slate!
    remove_entities(bio_cannon, {radar_name})
    -- Recreate hidden entities
    radar = surface.create_entity({
      name = radar_name,
      position = bio_cannon.position,
      force = bio_cannon.force
    })
    make_unminable({radar})
    -- Make sure we don't use the overlay cannon!
    if bio_cannon.name == overlay_name then
      -- Create final cannon
      base = surface.create_entity({
        name = base_name,
        position = bio_cannon.position,
        force = bio_cannon.force
      })
      -- Set its health to that of overlay
      base.health = bio_cannon.health
      -- Remove overlay
      bio_cannon.destroy()
      BioInd.writeDebug("Replaced Bio-cannon overlay with Bio-cannon %s.", {base.unit_number})
    else
      base = bio_cannon
    end
    -- Add to table
    global.Bio_Cannon_Table[base.unit_number] = {
      base = base,
      radar = radar,
      -- Bio-cannons will be checked once per second. Delay is based on the ammo the
      -- cannon is loaded with. Let's use 20s (delay for best ammo) initially!
      delay = (base.unit_number * base.unit_number) % 20
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Bio-cannons.", {cnt})



------------------------------------------------------------------------------------
--                                    Arboretum                                   --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for a, arboretum in pairs(global.Arboretum_Table or {}) do
  -- Remove hidden entities from solar_boilers in our table (Don't call removal
  -- function because radar position has been shifted, so the radar won't be found!)
  --~ for e, entity in ipairs({"radar", "pole", "lamp"}) do
    --~ if arboretum[entity] and arboretum[entity].valid then
      --~ arboretum[entity].destroy()
    --~ end
  --~ end
  remove_stored_entities(arboretum, {"radar", "pole", "lamp"})
  -- Remove entry from table
  global.Arboretum_Table[a] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Arboretums.", {cnt})


-- Generate new list
--~ local arboretums, pole, radar, lamp
local arboretums
base_name = "bi-arboretum"
overlay_name = "bi-arboretum-area"
pole_name = "bi-hidden-power-pole"
radar_name = "bi-arboretum-radar"
lamp_name = "bi-bio-farm-light"

cnt = 0

-- We need to keep track of radars separately!
global.Arboretum_Radar_Table = {}

for s, surface in pairs(game.surfaces or {}) do
  -- Find all arboretums on surface!
  arboretums = surface.find_entities_filtered({name = {base_name, overlay_name}})
  for a, arboretum in ipairs(arboretums or {}) do
    -- Make a clean slate!
    remove_entities(arboretum, {pole_name, radar_name, lamp_name})
    -- Recreate hidden entities
    radar = surface.create_entity({
      name = radar_name,
      position = {arboretum.position.x - 3.5, arboretum.position.y + 3.5},
      force = arboretum.force
    })
    pole = surface.create_entity({
      name = pole_name,
      position = arboretum.position,
      force = arboretum.force
    })
    lamp = surface.create_entity({
      name = lamp_name,
      position = arboretum.position,
      force = arboretum.force
    })
    make_unminable({pole, radar, lamp})

    -- Make sure we don't use the overlay!
    if arboretum.name == overlay_name then
      -- Create final arboretum
      base = surface.create_entity({
        name = base_name,
        position = arboretum.position,
        force = arboretum.force
      })
      -- Set its health to that of overlay
      base.health = arboretum.health
      -- Remove overlay
      arboretum.destroy()
      BioInd.writeDebug("Replaced Arboretum overlay with Arboretum %s.", {base.unit_number})
    else
      base = arboretum
    end
BioInd.writeDebug("Arboretum base: %g", {base.unit_number})
    -- Add to table
    global.Arboretum_Table[base.unit_number] = {
      base = base,
      pole = pole,
      radar = radar,
      lamp = lamp
    }
    -- Link radar to arboretum
    global.Arboretum_Radar_Table[radar.unit_number] = base.unit_number

--~ BioInd.writeDebug("Added new arboretum: %s", {global.Arboretum_Table})

    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Arboretums.", {cnt})



------------------------------------------------------------------------------------
--                                       Power Rail                                   --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for p, power_rail in pairs(global.bi_power_rail_table or {}) do
  -- Remove hidden entities from power rails in our table
  for e, entity in ipairs({"pole"}) do
    if power_rail[entity] and power_rail[entity].valid then
      power_rail[entity].destroy()
    end
  end
  remove_stored_entities(power_rail, {"pole"})
  -- Remove entry from table
  global.bi_power_rail_table[p] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Powered rails.", {cnt})


-- Generate new list
--~ local local power_rails, pole
local power_rails
pole_name = "bi-hidden-power-pole"
cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all solar_boilers on surface!
  power_rails = surface.find_entities_filtered({
    name = {"bi-straight-rail-power","bi-curved-rail-power"}
  })
  for p, power_rail in ipairs(power_rails or {}) do
    -- Make a clean slate!
    remove_entities(power_rail, {pole_name})
    -- Recreate hidden entities
    pole = surface.create_entity({
      name = pole_name,
      position = power_rail.position,
      force = power_rail.force
    })
    make_unminable({pole})
    -- Disconnect pole
    pole.disconnect_neighbour()

    -- Look for connecting rails at front and back of the new rail
    for s, side in ipairs( {"front", "back"} ) do
BioInd.writeDebug("Looking for rails at %s", {side})
      local neighbour
      -- Look in all three directions
      for d, direction in ipairs( {"left", "straight", "right"} ) do
BioInd.writeDebug("Looking for rails in %s direction", {direction})
        neighbour = power_rail.get_connected_rail{
            rail_direction = defines.rail_direction[side],
            rail_connection_direction = defines.rail_connection_direction[direction]
          }

BioInd.writeDebug("Rail %s of %s (%g):\t%s (%s)", {direction, power_rail.name, power_rail.unit_number, tostring(neighbour and neighbour.name), tostring(neighbour and neighbour.unit_number)})

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
    local connectors = surface.find_entities_filtered{
      position = power_rail.position,
      radius = BioInd.POWER_TO_RAIL_WIRE_DISTANCE,    -- maximum_wire_distance of Power-to-rail-connectors
      name = "bi-power-to-rail-pole"
    }
    -- Connect to just one Power-rail connector!
    for c, connector in ipairs(connectors or {}) do
BioInd.writeDebug("Network ID pole %s: %s\tNetwork ID connector %s: %s",
  {pole.unit_number, pole.electric_network_id,
  connector.unit_number, connector.electric_network_id})
      if pole.electric_network_id ~= connector.electric_network_id then
       pole.connect_neighbour(connector)
BioInd.writeDebug("Connected %s (%s) to connector %s (%s)", {pole.name, pole.unit_number, connector.name, connector.unit_number})
BioInd.writeDebug("Network ID pole %s: %s\tNetwork ID connector %s: %s",
  {pole.unit_number, pole.electric_network_id,
  connector.unit_number, connector.electric_network_id})
        break
      end
    end
    -- Add to table
    global.bi_power_rail_table[power_rail.unit_number] = {
      base = power_rail,
      pole = pole
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Powered rails.", {cnt})



------------------------------------------------------------------------------------
--                                       Solar Farm                                   --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for s, solar_farm in pairs(global.bi_solar_farm_table or {}) do
  -- Remove hidden entities from solar_boilers in our table
  --~ for e, entity in ipairs({"pole"}) do
    --~ if solar_farm[entity] and solar_farm[entity].valid then
      --~ solar_farm[entity].destroy()
    --~ end
  --~ end
  remove_stored_entities(solar_farm, {"pole"})
  -- Remove entry from table
  global.bi_solar_farm_table[s] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Solar farms.", {cnt})


-- Generate new list
--~ local solar_farms, pole
local solar_farms
pole_name = "bi-hidden-power-pole"

cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all solar_boilers on surface!
  solar_farms = surface.find_entities_filtered({name = "bi-bio-solar-farm"})
  for sf, solar_farm in ipairs(solar_farms or {}) do
    -- Make a clean slate!
    remove_entities(solar_farm, {pole_name})
    -- Recreate hidden entities
    pole = surface.create_entity({
      name = pole_name,
      position = solar_farm.position,
      force = solar_farm.force
    })
    make_unminable({pole})
    -- Add to table
    global.bi_solar_farm_table[solar_farm.unit_number] = {
      base = solar_farm,
      pole = pole
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Solar farms.", {cnt})




------------------------------------------------------------------------------------
--                                       Solar Farm                                   --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for s, solar_farm in pairs(global.bi_solar_farm_table or {}) do
  -- Remove hidden entities from solar_boilers in our table
  --~ for e, entity in ipairs({"pole"}) do
    --~ if solar_farm[entity] and solar_farm[entity].valid then
      --~ solar_farm[entity].destroy()
    --~ end
  --~ end
  remove_stored_entities(solar_farm, {"pole"})
  -- Remove entry from table
  global.bi_solar_farm_table[s] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Solar farms.", {cnt})


-- Generate new list
--~ local solar_farms, pole
local solar_farms
pole_name = "bi-hidden-power-pole"

cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all solar_boilers on surface!
  solar_farms = surface.find_entities_filtered({name = "bi-bio-solar-farm"})
  for sf, solar_farm in ipairs(solar_farms or {}) do
    -- Make a clean slate!
    remove_entities(solar_farm, {pole_name})
    -- Recreate hidden entities
    pole = surface.create_entity({
      name = pole_name,
      position = solar_farm.position,
      force = solar_farm.force
    })
    make_unminable({pole})
    -- Add to table
    global.bi_solar_farm_table[solar_farm.unit_number] = {
      base = solar_farm,
      pole = pole
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Solar farms.", {cnt})



------------------------------------------------------------------------------------
--                                       Solar Farm                                   --
------------------------------------------------------------------------------------
cnt = 0

-- Empty old list
for s, solar_farm in pairs(global.bi_solar_farm_table or {}) do
  -- Remove hidden entities from solar_boilers in our table
  --~ for e, entity in ipairs({"pole"}) do
    --~ if solar_farm[entity] and solar_farm[entity].valid then
      --~ solar_farm[entity].destroy()
    --~ end
  --~ end
  remove_stored_entities(solar_farm, {"pole"})
  -- Remove entry from table
  global.bi_solar_farm_table[s] = nil

  cnt = cnt + 1
end
BioInd.writeDebug("Removed hidden entities from %s Solar farms.", {cnt})


-- Generate new list
--~ local solar_farms, pole
local solar_farms
pole_name = "bi-hidden-power-pole"

cnt = 0

for s, surface in pairs(game.surfaces or {}) do
  -- Find all solar_boilers on surface!
  solar_farms = surface.find_entities_filtered({name = "bi-bio-solar-farm"})
  for sf, solar_farm in ipairs(solar_farms or {}) do
    -- Make a clean slate!
    remove_entities(solar_farm, {pole_name})
    -- Recreate hidden entities
    pole = surface.create_entity({
      name = pole_name,
      position = solar_farm.position,
      force = solar_farm.force
    })
    make_unminable({pole})
    -- Add to table
    global.bi_solar_farm_table[solar_farm.unit_number] = {
      base = solar_farm,
      pole = pole
    }
    cnt = cnt + 1
  end
end
BioInd.writeDebug("Recreated hidden entities for %s Solar farms.", {cnt})



------------------------------------------------------------------------------------
--                                   Musk floor                                   --
------------------------------------------------------------------------------------
cnt = 0

-- Create tables for storing force information on tiles
global.bi_musk_floor_table = global.bi_musk_floor_table or {}
-- Lookup table for force at tile position
global.bi_musk_floor_table.tiles = global.bi_musk_floor_table.tiles or {}
-- Lookup table for tiles placed by force
global.bi_musk_floor_table.forces = global.bi_musk_floor_table.forces or {}


local musk_floor_tiles
local tile_name = "bi-solar-mat"
pole_name = "bi-musk-mat-pole"
panel_name = "bi-musk-mat-solar-panel"
local pole_type = "electric-pole"
local panel_type = "solar-panel"

-- Remove panels and poles without tile from surfaces
local cnt_panel = 0
local cnt_pole = 0
for s, surface in pairs(game.surfaces or {}) do
  local panels = surface.find_entities_filtered({name = panel_name, type = panel_type})
  for p, panel in ipairs(panels or {}) do
    local x = surface.count_tiles_filtered({
      position = panel.position,
      name = tile_name,
      limit = 1
    })
    if x == 0 then
      BioInd.writeDebug("Removing %s at position %s because there is no %s.", {panel.name, panel.position, tile_name})
      panel.destroy()
      cnt_panel = cnt_panel + 1
    end
  end

  local poles = surface.find_entities_filtered({name = pole_name, type = pole_type})
  for p, pole in ipairs(poles or {}) do
    local x = surface.count_tiles_filtered({
      position = pole.position,
      name = tile_name,
      radius = 0.5,
      limit = 1
    })
    if x == 0 then
      BioInd.writeDebug("Removing %s at position %s because there is no %s.", {pole.name, pole.position, tile_name})
      pole.destroy()
      cnt_pole = cnt_pole + 1
    end
  end
end
BioInd.writeDebug("Removed %g hidden solar panels and %g hidden poles because they were not on %s.", {cnt_panel, cnt_pole, tile_name})

cnt_panel = 0
cnt_pole = 0
-- Generate new list
local x, y, poles, pole, panels, panel, force_name
for s, surface in pairs(game.surfaces or {}) do
  local tiles = surface.find_tiles_filtered{name = tile_name}
  for t, tile in ipairs(tiles or {}) do
    x = tile.position.x or tile.position[1]
    y = tile.position.y or tile.position[2]

    -- Check that there's a solar panel
    panels = surface.find_entities_filtered({
      position = {x + 0.5, y + 0.5},
      name = panel_name,
      type = panel_type,
      limit = 1
    })
    panel = panels and panels[1]
    if panel then
      force_name = panel.force and panel.force.name
    end

    -- Check that there's a pole
    panels = surface.find_entities_filtered({
      position = {x + 0.5, y + 0.5},
      name = pole_name,
      type = pole_type,
      limit = 1
    })
    pole = poles and poles[1]
    if pole and not force then
      force_name = pole.force and pole.force.name
    end

    force_name = force_name or "BI-Musk_floor_general_owner"

    -- Create/set force for panel
    if panel then
      panel.force = force_name
    else
      panel = surface.create_entity({
        name = panel_name,
        type = panel_type,
        force = force_name,
        position = {x + 0.5, y + 0.5},
      })
      cnt_panel = cnt_panel + 1
    end
    -- Create/set force for pole
    if pole then
      pole.force = force_name
    else
      pole = surface.create_entity({
        name = pole_name,
        type = pole_type,
        force = force_name,
        position = {x + 0.5, y + 0.5},
      })
      cnt_pole = cnt_pole + 1
    end

    make_unminable({panel, pole})

    -- Add to global tables
    --~ x = tile.position.x or tile.position[1]
    --~ y = tile.position.y or tile.position[2]
    global.bi_musk_floor_table.tiles[x] = global.bi_musk_floor_table.tiles[x] or {}
    global.bi_musk_floor_table.tiles[x][y] = force_name

    global.bi_musk_floor_table.forces[force_name] = global.bi_musk_floor_table.forces[force_name] or {}
    global.bi_musk_floor_table.forces[force_name][x] = global.bi_musk_floor_table.forces[force_name][x] or {}
    global.bi_musk_floor_table.forces[force_name][x][y] = true
  end
end
BioInd.writeDebug("Created %g hidden solar panels and %g hidden poles.\nglobal.bi_musk_floor_table.tiles: %s\nglobal.bi_musk_floor_table.forces: %s", {cnt_panel, cnt_pole, global.bi_musk_floor_table.tiles, global.bi_musk_floor_table.forces})
