------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--       If startup settings have been changed, we need to check some stuff.      --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

--~ local set_startup_items = require("scripts.startup_items")

local settings_changed = {}

------------------------------------------------------------------------------------
--     Check if the setting has changed since the last time the gas was saved     --
------------------------------------------------------------------------------------
local function check_setting(setting)
  BioInd.debugging.entered_function()

  BioInd.debugging.check_args(setting, "string", "setting name")

  -- The startup settings have Boolean values, the values from global.mod_settings
  -- may be something else, so we must convert them to Boolean values!
  local last = not not global.mod_settings[setting]
  local now = BioInd.get_startup_setting(setting)

  local ret = nil

  -- Setting changed since last save
  if last ~= now then
    ret = now
  end

  BioInd.debugging.entered_function("leave")
  return ret
end


local function no_change(setting_name)
    BioInd.debugging.writeDebug("Setting \"%s\" didn't change -- nothing to do!", setting_name)
end


------------------------------------------------------------------------------------
--                 Adjust the force of hidden poles on Musk floor                 --
------------------------------------------------------------------------------------
settings_changed.musk_floor = function()
  BioInd.debugging.entered_function()

  -- We can leave immediately when a new game is started
  do
    local have_players
    BioInd.debugging.show("game.players", game.players)
    for p, player in pairs(game.players) do
    BioInd.debugging.writeDebug("Name: %s\tIndex: %s", {player.name, player.index})
      have_players = true
      break
    end
    BioInd.debugging.show("have_players", have_players)
    if not have_players then

      BioInd.debugging.writeDebug("No players in game yet -- nothing to do!")
      return
    end
  end

  -- We only need to run this if the setting has been changed!
  local setting_name = "BI_Power_Production"
  local new_setting = check_setting(setting_name)

  ------------------------------------------------------------------------------------
  -- Setting did not change since last save
  if new_setting == nil then
    --~ BioInd.writeDebug("Setting didn't change -- nothing to do!")
    no_change("BI_Power_Production")

  ------------------------------------------------------------------------------------
  -- Musk floor has been enabled since last save
  elseif new_setting then
    global.mod_settings[setting_name] = true


    -- Look for solar panels on every surface. They determine the force poles will use
    -- if the electric grid overlay will be shown in mapview.
    local sm_panel_name = BioInd.musk_floor_stuff.musk_floor_panel_name
    local sm_pole_name = BioInd.musk_floor_stuff.musk_floor_pole_name

    -- If dummy force is not used, force of a hidden pole should be that of the hidden solar panel.
    -- That force will be "enemy" for poles/solar panels created with versions of Bio Industries
    -- prior to 0.17.45/0.18.13 because of the bug. We can fix that for singleplayer games by setting
    -- the force to player force. In multiplayer games, we can do this as well if all players are
    -- on the same force. If there are several forces that have players, it's impossible to find out
    -- which force built a certain musk floor tile, so "enemy" will still be used.
    -- (Only fix in this case: Players must remove and rebuild all existing musk floor tiles!)

    --~ --local single_player_force = game.is_multiplayer() and nil or game.players[1].force.name
    local force = nil

    -- Always use dummy force if option is set
    if BioInd.musk_floor_stuff.UseMuskForce then
      force = BioInd.musk_floor_stuff.MuskForceName
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
      -- (If this happens in a game where musk floor was created the buggy way with
      -- "force == nil", it will be impossible to determine which force built it, so the force
      -- will still be the default, i.e. "enemy".)
      if count > 1 then
        force = nil
      end
    end

    for name, surface in pairs(game.surfaces) do
      BioInd.debugging.writeDebug("Looking for %s on surface %s", {sm_panel_name, name})
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
  BioInd.debugging.writeDebug("Number of poles for panel %g: %g", {p, #sm_pole})
          for i = 2, #sm_pole do
  BioInd.debugging.writeDebug("Destroying pole number %g", {i})
            sm_pole[i].destroy()
          end
        end

        -- Set force of the pole
        sm_pole[1].force = force or panel.force
      end
    end
    BioInd.debugging.writeDebug("Electric grid overlay of musk floor will be %s in map view.",
                      {BioInd.musk_floor_stuff.UseMuskForce and "hidden" or "displayed"})


  ------------------------------------------------------------------------------------
  -- Musk floor has been disabled since last save
  else
    -- Clean tables
    global.mod_settings[new_setting] = nil
    global.bi_musk_floor_table = nil

    -- Remove hidden entities!
    local hidden = {
      BioInd.musk_floor_stuff.musk_floor_pole_name,
      BioInd.musk_floor_stuff.musk_floor_panel_name,
    }

    for name, surface in pairs(game.surfaces) do
      BioInd.debugging.writeDebug("Looking for hidden poles of Musk floor on surface %s", {name})
      for e, entity in pairs(surface.find_entities_filtered({
        name = BioInd.musk_floor_stuff.musk_floor_pole_name,
        type = BioInd.HE_map.pole
      })) do
        BioInd.debugging.writeDebug("Removing %s", {BioInd.debugging.argprint(entity)})
        entity.destroy()
      end

      BioInd.debugging.writeDebug("Looking for hidden panels of Musk floor on surface %s", {name})
      for e, entity in pairs(surface.find_entities_filtered({
        name = BioInd.musk_floor_stuff.musk_floor_panel_name,
        type = BioInd.HE_map.panel
      })) do
        BioInd.debugging.writeDebug("Removing %s", {BioInd.debugging.argprint(entity)})
        entity.destroy()
      end
    end
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--      Compile list of poles the hidden poles of Bio Gardens may connect to      --
------------------------------------------------------------------------------------
settings_changed.easy_gardens = function()
  BioInd.debugging.entered_function()

  -- We only need to run this if the setting has been changed!
  local setting_name = "BI_Game_Tweaks_Easy_Bio_Gardens"
  local new_setting = check_setting(setting_name)

  ------------------------------------------------------------------------------------
  -- Setting did not change since last save
  if new_setting == nil then
    --~ BioInd.writeDebug("Setting didn't change -- nothing to do!")
    no_change("BI_Game_Tweaks_Easy_Bio_Gardens")

  ------------------------------------------------------------------------------------
  -- "Easy gardens" setting has been enabled since last save
  elseif new_setting then
    global.mod_settings[setting_name] = true
    global.mod_settings.garden_pole_connectors = BI_scripts.poles.get_garden_pole_connectors()
    BioInd.debugging.writeDebug("Made list for setting \"BI_Game_Tweaks_Easy_Bio_Gardens\".")

  ------------------------------------------------------------------------------------
  -- "Easy gardens" setting has been disabled since last save
  else
    global.mod_settings[setting_name] = nil
    global.mod_settings.garden_pole_connectors = nil
    BioInd.debugging.writeDebug("Removed list for setting \"BI_Game_Tweaks_Easy_Bio_Gardens\".")
  end

  BioInd.debugging.entered_function("leave")
end

------------------------------------------------------------------------------------
-- If "Early wooden defenses" (setting BI_Darts) is active, set the items players --
-- get on starting a new game or on respawning!                                   --
------------------------------------------------------------------------------------
settings_changed.early_wooden_defenses = function()
  BioInd.debugging.entered_function()

  -- We only need to run this if the setting has been changed!
  local setting_name = "BI_Darts"
  local new_setting = check_setting(setting_name)

  ------------------------------------------------------------------------------------
  -- Setting did not change since last save
  if new_setting == nil then
    no_change("BI_Darts")

  ------------------------------------------------------------------------------------
  -- "Early wooden defenses" setting has been enabled since last save
  elseif new_setting then
    global.mod_settings[setting_name] = true

    BioInd.debugging.writeDebug("Checking whether we need to change startup items.")
    BI_scripts.darts.use_darts()

  ------------------------------------------------------------------------------------
  -- "Early wooden defenses" setting has been disabled since last save
  else
    global.mod_settings[setting_name] = nil

    BioInd.debugging.writeDebug("Setting %s has been turned off -- resetting startup items!", setting_name)
    BI_scripts.darts.use_defaults()
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                         Remove tables for Bio cannons?                         --
------------------------------------------------------------------------------------
settings_changed.bio_cannon = function()
  BioInd.debugging.entered_function()

  -- We only need to run this if the setting has been changed!
  local setting_name = "BI_Bio_Cannon"
  local new_setting = check_setting("BI_Bio_Cannon")

  ------------------------------------------------------------------------------------
  -- Setting did not change since last save
  if new_setting == nil then
    no_change(setting_name)

  ------------------------------------------------------------------------------------
  -- "Bio cannon" setting has been enabled since last save
  elseif new_setting then
    global.mod_settings[setting_name] = true

  ------------------------------------------------------------------------------------
  -- "Bio cannon" setting has been disabled since last save
  --~ elseif not new_setting then
  else
    global.mod_settings[setting_name] = nil

    global.checks.bio_cannon = nil
    BioInd.debugging.writeDebug("Removed tables for Bio cannon checks!")
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                      Remove tables for pollution sensors?                      --
------------------------------------------------------------------------------------
settings_changed.pollution_sensor = function()
  BioInd.debugging.entered_function()

  -- We only need to run this if the setting has been changed!
  local setting_name = "BI_Pollution_Detector"
  local new_setting = check_setting(setting_name)

  ------------------------------------------------------------------------------------
  -- Setting did not change since last save
  if new_setting == nil then
    no_change(setting_name)

  ------------------------------------------------------------------------------------
  -- "Pollution sensor" setting has been enabled since last save
  elseif new_setting then
    global.mod_settings[setting_name] = true


  ------------------------------------------------------------------------------------
  -- "Pollution sensor" setting has been disabled since last save
  --~ elseif not new_setting then
  else
    global.checks.bi_pollution_sensor = nil
    BioInd.debugging.writeDebug("Removed tables for pollution sensors!")
  end

  BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return settings_changed
