BioInd = require("__" .. script.mod_name .. "__.common-control")
BioInd.entered_file()

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                  REQUIRE FILES                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                          Require files from other mods                         --
------------------------------------------------------------------------------------
-- External
if BioInd.get_startup_setting("BI_Debug_gvv") then
  BioInd.writeDebug("Activating support for gvv!")
  require("__gvv__/gvv")()
end

--~ local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(false)
--~ local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(true)


BI_cache = require('__eradicators-library__/erlib/factorio/Cache')()

------------------------------------------------------------------------------------
--                           Require additional scripts                           --
------------------------------------------------------------------------------------
BI_scripts = {
  -- Only load these functions if terraformers are used in the game. As these are
  -- compound entities, their tables will be created/removed automatically.
  arboretum            = BioInd.get_startup_setting("BI_Terraforming") and
                          require("scripts.control_arboretum") or nil,
  -- Pollution sensors are not a compound entity, so we must be careful to check if
  -- tables/functions/entities exist later!
  pollution_sensor     = BioInd.get_startup_setting("BI_Pollution_Detector") and
                          require("scripts.control_pollution_sensor"),
  -- Trees can grow from manually planted seeds. We will always need these functions!
  trees                = require("scripts.control_trees"),
  -- We will have at least the hidden poles from the Bio farms (default entity, not
  -- depending on a setting!) to take care of, so we'll always need these functions.
  poles                = require("scripts.control_poles"),
}

local event_handlers   = require("scripts.event_handlers")

-- This will only be run if the Cannon is active. We may want to remove this later!
--~ require("scripts/control_bio_cannon")


---************** Used for Testing -----
--require ("Test_Spawn")
---*************



------------------------------------------------------------------------------------
--                                 Register events                                --
------------------------------------------------------------------------------------
-- These are not events listed in defines.events, but we need an event name for the
-- debugging functions!
script.on_configuration_changed(function(event)
  event.name = "on_configuration_changed"
  event_handlers.On_Config_Change(event)
end)
script.on_init(function() event_handlers.Init({name = "on_init"}) end)
script.on_load(function() event_handlers.On_Load({name = "on_load"}) end)

--~ Event.register(defines.events.on_tick, event_handlers.On_Tick)


--~ Event.build_events = {
  --~ defines.events.on_built_entity,
  --~ defines.events.on_robot_built_entity,
  --~ defines.events.script_raised_built,
  --~ defines.events.script_raised_revive
--~ }
--~ Event.pre_remove_events = {
  --~ defines.events.on_pre_player_mined_item,
  --~ defines.events.on_robot_pre_mined,
  --~ defines.events.on_player_mined_entity,
  --~ defines.events.on_robot_mined_entity,
--~ }
--~ Event.death_events = {
  --~ defines.events.on_entity_died,
  --~ defines.events.script_raised_destroy
--~ }
--~ Event.tile_build_events = {
  --~ defines.events.on_player_built_tile,
  --~ defines.events.on_robot_built_tile
--~ }
--~ Event.tile_remove_events = {
  --~ defines.events.on_player_mined_tile,
  --~ defines.events.on_robot_mined_tile
--~ }
--~ Event.tile_script_action = {
  --~ defines.events.script_raised_set_tiles
--~ }

--~ Event.register(Event.build_events, event_handlers.On_Built)
--~ Event.register(Event.pre_remove_events, event_handlers.On_Pre_Remove)
--~ Event.register(Event.death_events, event_handlers.On_Death)
--~ Event.register(Event.tile_build_events, event_handlers.Solar_Mat_Built)
--~ Event.register(Event.tile_remove_events, event_handlers.Solar_Mat_Removed)

--~ if BioInd.get_startup_setting("BI_Terraforming") then
  --~ Event.register(defines.events.on_entity_damaged, event_handlers.On_Damage, function(event)
    --~ -- A function is needed for event filtering with stdlib!
    --~ local entity = event.entity

    --~ -- Ignore damage without effect (invulnerable/resistant entities)
    --~ if event.final_damage_amount ~= 0 and
        --~ -- Terraformer/Terraformer radar was damaged
        --~ (global.bi_arboretum_table and global.bi_arboretum_table[entity.unit_number] or
         --~ global.bi_arboretum_radar_table and global.bi_arboretum_radar_table[entity.unit_number]) then
      --~ return true
    --~ end
  --~ end)

  --~ -- Radar scan
  --~ Event.register(defines.events.on_sector_scanned, event_handlers.On_Sector_Scanned, function(event)
    --~ -- A function is needed for event filtering with stdlib!
    --~ if event.radar.name == BioInd.compound_entities["bi-arboretum"].hidden.radar.name then
      --~ return true
    --~ end
  --~ end)
--~ end

--~ -- Trees planted with a seed bomb
--~ if BioInd.get_startup_setting("BI_Explosive_Planting") then
  --~ Event.register(defines.events.on_trigger_created_entity, event_handlers.On_Trigger_Created_Entity)
--~ end

--~ -- Tile changed
--~ if BioInd.get_startup_setting("BI_Power_Production") then
  --~ Event.register(Event.tile_script_action, event_handlers.Tile_Changed)
--~ end


------------------------------------------------------------------------------------
--                    FIND LOCAL VARIABLES THAT ARE USED GLOBALLY                 --
--                              (Thanks to eradicator!)                           --
------------------------------------------------------------------------------------
setmetatable(_ENV, {
  __newindex = function (self, key, value) --locked_global_write
    error('\n\n[ER Global Lock] Forbidden global *write*:\n'
      .. serpent.line{key = key or '<nil>', value = value or '<nil>'} .. '\n')
    end,
  __index = function (self, key) --locked_global_read
    if not (key == "game" or key == "mods" or key == "data") then
      error('\n\n[ER Global Lock] Forbidden global *read*:\n'
        .. serpent.line{key = key or '<nil>'} .. '\n')
    end
  end
})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
