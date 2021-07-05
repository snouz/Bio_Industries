--------------------------------------------------------------------
-- If startup settings have been changed, we need to check some stuff.
-- Keep that in a separate file so the main control.lua is easier to
-- read!
--------------------------------------------------------------------

local BioInd = require('common')('Bio_Industries')

local settings_changed = {}

-- Adjust the force of hidden poles on Musk floor!
settings_changed.musk_floor = function()
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
  if BioInd.UseMuskForce then
    force = BioInd.MuskForceName
  -- Singleplayer mode: use force of first player
  elseif not game.is_multiplayer() then
    force = game.players[1].force.name
  -- Multiplayer game
  else
    local count = 0
    -- Count forces with players
    for _, check_force in pairs(game.forces) do
      if next(check_force.players) then
        force = check_force.name
        count = count + 1
      end
    end
    -- Several forces with players: reset force to nil now and use force of panel later
    -- (If this happens in a game were musk floor was created the buggy way with "force == nil",
    --  it will be impossible to determine which force built it, so the force will still be
    --  the default, i.e. "enemy".)
    if count > 1 then
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
  BioInd.writeDebug("Electric grid overlay of musk floor will be %s in map view.",
                    {BioInd.UseMuskForce and "hidden" or "displayed"})
end


-- If the setting for Bio Gardens (fluid fertilizer etc.) has been changed, we need
-- to disconnect or rewire the hidden poles!

-- Electric poles we want to connect to
local good_poles

local function get_good_poles()
  local ret = {}
  local poles = game.get_filtered_entity_prototypes({
    {filter = "type", type = "electric-pole"},
    {filter = "name", name = {
        -- Poles named here will be ignored!
        "bi-rail-hidden-power-pole",
        "bi-musk-mat-pole",
        "bi-bio-garden-hidden-pole"
        }, invert = "true", mode = "and"
    }
  })
  for p, pole in pairs(poles) do
    ret[#ret + 1] = pole.name
  end
  return ret
end


settings_changed.bio_garden = function()
  BioInd.writeDebug("Entered function settings_changed.bio_garden!")

  -- Has this setting been changed since the last time the game was run?
  local current = BioInd.get_startup_setting("BI_Easy_Bio_Gardens")
BioInd.show("Last state of BI_Easy_Bio_Gardens", global.mod_settings.BI_Easy_Bio_Gardens)
BioInd.show("Current state of BI_Easy_Bio_Gardens", current)

  if global.mod_settings.BI_Easy_Bio_Gardens ~= current then
BioInd.writeDebug("Setting has been changed!")
    local pole, neighbours
    local wire_reach = game.entity_prototypes["bi-bio-garden-hidden-pole"].max_wire_distance
BioInd.show("wire_reach", wire_reach)

    -- Setting is on, so we need to hook up the hidden poles
    if current then
BioInd.writeDebug("Need to reconnect hidden poles for %s Bio Gardens!",
                  {table_size(global.bi_bio_garden_table) })

      -- Connect all hidden poles that are in reach of each other. Each pole can
      -- have just 5 connections, so we do this first!
      for g, garden in pairs(global.bi_bio_garden_table or {}) do
        pole = garden.pole
        -- Look for other hidden poles around this one
        neighbours = pole.surface.find_entities_filtered({
          position = pole.position,
          radius = wire_reach,
          type = "electric-pole",
          name = "bi-bio-garden-hidden-pole"
        })
BioInd.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours - 1})
        for n, neighbour in pairs(neighbours or{}) do
          if pole ~= neighbour then
            pole.connect_neighbour(neighbour)
BioInd.writeDebug("Connected pole %g to %s %g",
                  {pole.unit_number, neighbour.name, neighbour.unit_number})
          end
        end
      end

      -- Connect hidden poles to other poles that may be in reach.
      good_poles = good_poles or get_good_poles()
BioInd.show("Good poles", good_poles)

      for g, garden in pairs(global.bi_bio_garden_table or {}) do
        pole = garden.pole
        -- Look for other hidden poles around this one
        neighbours = pole.surface.find_entities_filtered({
          position = pole.position,
          radius = wire_reach,
          type = "electric-pole",
          name = good_poles
        })
BioInd.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours})
        for n, neighbour in pairs(neighbours or{}) do
          pole.connect_neighbour(neighbour)
BioInd.writeDebug("Connected pole %g to neighbour %s (%g)",
                  {pole.unit_number, neighbour.name, neighbour.unit_number})
        end
      end

    -- Setting is off -- disconnect hidden poles!
    else
BioInd.writeDebug("%s Bio Gardens found -- must disconnect hidden poles!",
                  {table_size(global.bi_bio_garden_table) })
      -- Connect hidden poles to other poles that may be in reach.
      for g, garden in pairs(global.bi_bio_garden_table or {}) do
        if garden.pole and garden.pole.valid then
          garden.pole.disconnect_neighbour()
BioInd.show("Disconnected pole", garden.pole.unit_number)
        end
      end
    end
    -- Update setting!
    global.mod_settings.BI_Easy_Bio_Gardens = current
BioInd.show("Updated setting to", global.mod_settings.BI_Easy_Bio_Gardens)
  else
BioInd.writeDebug("Nothing to do!")
  end
end

return settings_changed
