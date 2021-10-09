------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                   MUSK FLOOR                                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

-- ManagedLuaBootstrap instance from ErLib
local musk_floor_script = BioInd.erlib.Events.get_managed_script("musk_floor")

-- Eradicator's Library uses the on_configuration_changed event for on_init as well.
-- If the mod is added to an existing game, the event will trigger two times, but
-- we only need to run the code once, so we check for this flag.
local initialized

local BI_musk_floor = {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                             Local variables/tables                             --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                          Actually place the Musk floor                         --
------------------------------------------------------------------------------------
local function place_musk_floor(force, position, surface)
  BioInd.debugging.entered_function({force, position, surface})

  BioInd.debugging.check_args(force, "string")
  position = BioInd.normalize_position(position) or BioInd.debugging.arg_err(position, "position")
  surface = BioInd.is_surface(surface) or BioInd.debugging.arg_err(surface, "surface")

  local x, y = position.x, position.y
  local created
  for n, name in ipairs({
    BioInd.musk_floor_stuff.musk_floor_pole_name,
    BioInd.musk_floor_stuff.musk_floor_panel_name
  }) do
    -- We won't raise events because that would be too expensive (Musk floor is
    -- placed in bulk, and an event would be triggered for both pole and panel)
    created = surface.create_entity({name = name, position = {x + 0.5, y + 0.5}, force = force})
    created.minable = false
    created.destructible = false
    BioInd.debugging.writeDebug("Created %s: %s", {name, created.unit_number})
    -- As we didn't raise the event, we have to check the pole connections directly!
    if name == BioInd.musk_floor_stuff.musk_floor_pole_name then
      BI_scripts.poles.connect_poles(created)
    end
  end

  -- Add to global tables!
  global.bi_musk_floor_table.tiles[x] = global.bi_musk_floor_table.tiles[x] or {}
  global.bi_musk_floor_table.tiles[x][y] = force

  global.bi_musk_floor_table.forces[force] = global.bi_musk_floor_table.forces[force] or {}
  global.bi_musk_floor_table.forces[force][x] = global.bi_musk_floor_table.forces[force][x] or {}
  global.bi_musk_floor_table.forces[force][x][y] = true

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                           Musk floor has been removed                          --
------------------------------------------------------------------------------------
local function solar_mat_removed(event)
  BioInd.debugging.entered_function({event})

  local surface = game.surfaces[event.surface_index]
  local tiles = event.tiles

  local pos, x, y
  -- tiles contains an array of the old tiles and their position
  for t, tile in pairs(tiles) do
    if tile.old_tile and tile.old_tile.name == BioInd.musk_floor_stuff.musk_floor_tile_name then
      pos = BioInd.normalize_position(tile.position)
      x, y = pos.x, pos.y

BioInd.debugging.writeDebug("Looking for hidden entities to remove")
      for _, o in pairs(surface.find_entities_filtered{
        name = {
          BioInd.musk_floor_stuff.musk_floor_pole_name,
          BioInd.musk_floor_stuff.musk_floor_panel_name
        },
        position = {x + 0.5, y + 0.5}
      } or {}) do
BioInd.debugging.show("Removing", o.name)
        o.destroy()
      end

      -- Remove tile from global tables
      local force_name = global.bi_musk_floor_table.tiles and
                          global.bi_musk_floor_table.tiles[x] and
                          global.bi_musk_floor_table.tiles[x][y]
      if force_name then
BioInd.debugging.writeDebug("Removing Musk floor tile from tables!")
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

  BioInd.debugging.writeDebug("bi-solar-mat: removed %g tiles", {table_size(tiles)})
  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                           Musk floor has been built                            --
------------------------------------------------------------------------------------
local function solar_mat_built(event)
  BioInd.debugging.entered_function({event})
  -- Called from player, bot and script-raised events, so event may
  -- contain "robot" or "player_index"

  local tile = event.tile

  -- Fertilizer tiles are handled in control_trees.lua!
  if tile.name ~= BioInd.tree_stuff.fertilizer_tiles.common and
      tile.name ~= BioInd.tree_stuff.fertilizer_tiles.advanced then

    local surface = game.surfaces[event.surface_index]
    local player = event.player_index and game.players[event.player_index]
    local robot = event.robot
    local force = (BioInd.musk_floor_stuff.UseMuskForce and BioInd.musk_floor_stuff.MuskForceName) or
                  (event.player_index and game.players[event.player_index].force.name) or
                  (event.robot and event.robot.force.name) or
                  event.force.name
  BioInd.debugging.show("Force.name", force)

    -- Item that was used to place the tile
    local item = event.item
    local old_tiles = event.tiles

    local position --, x, y

    -- Musk floor has been built -- create hidden entities!
    if tile.name == BioInd.musk_floor_stuff.musk_floor_tile_name then
      BioInd.debugging.writeDebug("Solar Mat has been built -- must create hidden entities!")
  BioInd.debugging.show("Tile data", tile )

      --~ for index, old_tile in pairs(old_tiles or {}) do
      for index, t in pairs(old_tiles or {tile}) do
  BioInd.debugging.show("Read old_tile inside loop", t)
        -- event.tiles will also contain landscape tiles like "grass-1",
        -- and it will always contain at least one tile
        position = BioInd.normalize_position(t.position)
        -- If we got here by a call from script_raised_built, force may be stored
        -- with the tile
        force = force or t.force
  BioInd.debugging.show("Got force from tile data", t.force or "false")
        BioInd.debugging.writeDebug("Building solar mat for force %s at position %s",
          {tostring(type(force) == "table" and force.name or force), position})

        place_musk_floor(force, position, surface)
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
            old_tile = {name = BioInd.musk_floor_stuff.musk_floor_tile_name},
            position = position
          }
        end
      end
      if next(removed_tiles) then
        solar_mat_removed({surface_index = event.surface_index, tiles = removed_tiles})
      else
        BioInd.debugging.writeDebug("%s has been built -- nothing to do!", {tile.name})
      end
    end
  end

  BioInd.debugging.entered_function("leave")
end


--------------------------------------------------------------------
-- A tile has been changed
local function Tile_Changed(event)
  BioInd.debugging.entered_function(event)

  -- The event gives us only a list of the new tiles that have been placed.
  -- So let's check if any Musk floor has been built!
  local new_musk_floor_tiles = {}
  local old_musk_floor_tiles = {}
  local remove_musk_floor_tiles = {}
  local pos, old_tile, force

  local tile_force

  for t, tile in ipairs(event.tiles) do
BioInd.debugging.show("t", t)
    pos = BioInd.normalize_position(tile.position)
    tile_force = global.bi_musk_floor_table.tiles[pos.x] and
                  global.bi_musk_floor_table.tiles[pos.x][pos.y]
                  --~ -- Fall back to MuskForceName if it is available
                 --~ UseMuskForce and MuskForceName or
                 --~ -- Fall back to "neutral"
                 --~ "neutral"
BioInd.debugging.show("Placed tile", tile.name)

    -- Musk floor was placed
    if tile.name == BioInd.musk_floor_stuff.musk_floor_tile_name then
      BioInd.debugging.writeDebug("Musk floor tile was placed!")
      new_musk_floor_tiles[#new_musk_floor_tiles + 1] = {
        old_tile = { name = tile.name },
        position = pos,
        force = tile_force or
                BioInd.musk_floor_stuff.UseMuskForce and BioInd.musk_floor_stuff.MuskForceName or
                "neutral"
      }
    -- Other tile was placed -- by one of our fertilizers?
    elseif tile.name == BioInd.tree_stuff.fertilizer_tiles.common or
            tile.name == BioInd.tree_stuff.fertilizer_tiles.advanced then
      BioInd.debugging.writeDebug("Fertilizer was used!")

      -- Fertilizer was used on a Musk floor tile -- restore the tile!
BioInd.debugging.show("Musk floor tile in position", tile_force)
      if tile_force then
        old_musk_floor_tiles[#old_musk_floor_tiles + 1] = {
          --~ old_tile = { name == BioInd.musk_floor_tile_name },
          old_tile = { name = BioInd.musk_floor_stuff.musk_floor_tile_name },
          position = pos,
          force = tile_force
        }
      end
    -- Other tile was placed on a Musk floor tile -- remove Musk floor from lists!
    elseif tile_force then
      remove_musk_floor_tiles[#remove_musk_floor_tiles + 1] = {
        --~ old_tile = { name == BioInd.musk_floor_tile_name },
        old_tile = { name = BioInd.musk_floor_stuff.musk_floor_tile_name },
        position = pos,
      }
    end
  end
BioInd.debugging.show("new_musk_floor_tiles", new_musk_floor_tiles)
BioInd.debugging.show("old_musk_floor_tiles", old_musk_floor_tiles)
BioInd.debugging.show("remove_musk_floor_tiles", remove_musk_floor_tiles)

  if next(new_musk_floor_tiles) then
    solar_mat_built({
      surface_index = event.surface_index,
      tile = {name = BioInd.musk_floor_stuff.musk_floor_tile_name},
      force = BioInd.musk_floor_stuff.MuskForceName,
      tiles = new_musk_floor_tiles
    })
  end
  if next(old_musk_floor_tiles) then
    solar_mat_built({
      surface_index = event.surface_index,
      tile = {name = BioInd.musk_floor_stuff.musk_floor_tile_name},
      tiles = old_musk_floor_tiles
    })
  end
  if next(remove_musk_floor_tiles) then
    solar_mat_removed({surface_index = event.surface_index, tiles = remove_musk_floor_tiles})
  end

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
--                         Initialize a new or loaded game                        --
------------------------------------------------------------------------------------
musk_floor_script.on_configuration_changed(function(event)
  event = event or {}; event.name = "on_configuration_changed"
  BioInd.debugging.entered_event(event)

  -- If the mod was added to an existing game, this event has already been triggered
  -- for on_init, so we can skip it for on_configuration_changed!
  if initialized then
    BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    return
  end

  -- Initialize tables
  BioInd.debugging.writeDebug("Setting up tables for musk floor.")
  global.bi_musk_floor_table = global.bi_musk_floor_table or {}
  global.bi_musk_floor_table.tiles = global.bi_musk_floor_table.tiles or {}
  global.bi_musk_floor_table.forces = global.bi_musk_floor_table.forces or {}

  -- Create dummy force for Musk floor if electric grid overlay should
  -- NOT be shown in map view
  if BioInd.musk_floor_stuff.UseMuskForce and
      not game.forces[BioInd.musk_floor_stuff.MuskForceName] then
    BioInd.debugging.writeDebug("Must create force for Musk floor!")
    --~ Create_dummy_force()
    local f = game.create_force(BioInd.musk_floor_stuff.MuskForceName)
    -- Set new force as neutral to every other force
    for name, force in pairs(game.forces) do
      if name ~= BioInd.musk_floor_stuff.MuskForceName then
        f.set_friend(force, false)
        f.set_cease_fire(force, true)
      end
    end
    -- New force won't share chart data with any other force
    f.share_chart = false
  end

  -- Mark game as initialized
  initialized = true

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                    on_player_mined_tile, on_robot_mined_tile                   --
------------------------------------------------------------------------------------
-- Solar mat was removed
local remove_events = {
  defines.events.on_player_mined_tile,
  defines.events.on_robot_mined_tile
}
musk_floor_script.on_event(remove_events, function(event)
  BioInd.debugging.entered_event(event)

  solar_mat_removed(event)

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                    on_player_built_tile, on_robot_built_tile                   --
------------------------------------------------------------------------------------
-- Solar mat was placed
local build_events = {
  defines.events.on_player_built_tile,
  defines.events.on_robot_built_tile
}
musk_floor_script.on_event(build_events, function(event)
  BioInd.debugging.entered_event(event)

  solar_mat_built(event)

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                           Tile was changed by script                           --
------------------------------------------------------------------------------------
musk_floor_script.on_event(defines.events.script_raised_set_tiles, function(event)
  BioInd.debugging.entered_event(event)

  Tile_Changed(event)

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_seedbombs
