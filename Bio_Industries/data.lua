BioInd = require('common-data')
BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
local flag  = require('__eradicators-library__/erlib/shared')[5]
local elreq = require('__eradicators-library__/erlib/shared')[4]
local Lock  = elreq('erlib/lua/Lock')()

if flag.IS_DEV_MODE then
  Lock.auto_lock(_ENV, '_ENV')
  end

------------------------------------------------------------------------------------
--                                      Init                                      --
------------------------------------------------------------------------------------
-- Initialize tables
BI = BI or {}
BI.Settings = BI.Settings or {}

--~ BI_Config = BI_Config or {}
--~ BI_Config.mod = BI_Config.mod or {}
BI_Functions = BI_Functions or {}
BI_Functions.lib = BI_Functions.lib or {}

thxbob = thxbob or {}
thxbob.lib = thxbob.lib or {}

-- Populate BI.Settings with the setting values
BioInd.get_startup_settings()
for k, v in pairs(BI.Settings) do
  BioInd.debugging.writeDebug("Setting %s: %s", {k, v})
end

-- Set triggers depending on multiple settings/mods
require('set_triggers')
for k, v in pairs(BI.Triggers) do
  BioInd.debugging.writeDebug("Trigger %s: %s", {k, v})
end


-- Allow mods to register names or patterns for black-/whitelisting items as
-- fuel_items (see prototypes/fuel_values/read_filters.lua!)
BI_FuelItem_Filters = {}

------------------------------------------------------------------------------------
-- Modders may use the following code in data-updates.lua to add/remove filters.  --
-- Adjust strings/boolean values to your needs! If there are any presets for      --
-- your mod, setting a filter to "false" will remove it from the presets.         --
-- Patterns are parsed by string.match as regular expressions, so special         --
-- characters must be escaped!                                                    --
------------------------------------------------------------------------------------
--[[
  if BI_FuelItem_Filters then
    BI_FuelItem_Filters["your_mod_name"] = {
    -- All of these lists may be nil or an empty table, i.e. "{}"!

      whitelist_items = {
        -- Contains a list of item_name and item_type
        ["wood-beam"]                     = "item",
        ["my-special-item"]               = "capsule",

        -- Setting a value to false will remove this item from the presets (if any)
        -- whitelist_items of mod "your_mod_name"
        ["dont-whitelist-this-item"]      = false,
      },

      blacklist_items = {
        -- Contains a list of item_name and item_type
        ["wood-beam"]                     = "item",
        ["my-special-weapon"]             = "gun",

        -- Setting a value to false will remove this item from the presets (if any)
        -- blacklist_items of mod "your_mod_name"
        ["dont-blacklist-this-item"]      = false,
      },

      whitelist_patterns = {
        -- Add this pattern
        [".*wood.*"]                      = true,

        -- Remove this pattern from presets (if there are any)
        ["my%-patterns"]                  = false,
      },

      blacklist_patterns = {
        -- Add this pattern
        [".*wood.*"]                      = true,

        -- Remove this pattern from presets (if there are any)
        ["my%-items"]                       = false,
      },
    }
  end
]]

------------------------------------------------------------------------------------
--                                 Auxiliary files                                --
------------------------------------------------------------------------------------
-- From Bob's libary
require("libs.item-functions")
require("libs.recipe-functions")
require("libs.technology-functions")
require("libs.functions")
require("libs.category-functions")

-- Some functions of our own
require("libs.bi_functions")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                         DEFAULT -- ALWAYS CREATE THESE!                        --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                          Categories, item groups, sigals etc.                          --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.categories")
require("prototypes.default.signal")
require("prototypes.default.sprites")

------------------------------------------------------------------------------------
--                                     Fluids                                     --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.fluids")


------------------------------------------------------------------------------------
--                                    Entities                                    --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.entity")


------------------------------------------------------------------------------------
--                                      Items                                     --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.item")


------------------------------------------------------------------------------------
--                                     Recipes                                    --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.recipe_forEntity")
require("prototypes.default.recipe")

------------------------------------------------------------------------------------
--                                  Technologies                                  --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.technology")





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                    OPTIONAL -- THINGS DEPENDENT ON A SETTING                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--             Data of all additional things that depend on a setting             --
------------------------------------------------------------------------------------
require("prototypes.optional.additional_categories_ammo")
require("prototypes.optional.additional_categories_item")
require("prototypes.optional.additional_categories_recipe")
require("prototypes.optional.additional_fluids")
require("prototypes.optional.additional_items")
require("prototypes.optional.additional_recipes")
require("prototypes.optional.additional_remnants")
require("prototypes.optional.additional_technologies")


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
require("prototypes.optional.optionBioFuel.categories_optionBioFuel")
require("prototypes.optional.optionBioFuel.entity_optionBioFuel")
require("prototypes.optional.optionBioFuel.item_optionBioFuel")
require("prototypes.optional.optionBioFuel.recipe_optionBioFuel")
require("prototypes.optional.optionBioFuel.technology_optionBioFuel")


------------------------------------------------------------------------------------
--                               Enable: Bio gardens                              --
--                           (BI.Settings.BI_Bio_Garden)                          --
------------------------------------------------------------------------------------
require("prototypes.optional.optionBioGardens.categories_optionGarden")
require("prototypes.optional.optionBioGardens.entity_optionGarden")
require("prototypes.optional.optionBioGardens.item_optionGarden")
require("prototypes.optional.optionBioGardens.recipe_optionGarden")
require("prototypes.optional.optionBioGardens.technology_optionGarden")


------------------------------------------------------------------------------------
--                             Enable: Coal processing                            --
--                        (BI.Settings.BI_Coal_Processing)                        --
------------------------------------------------------------------------------------
require("prototypes.optional.optionCoalProcessing.item_optionCoalProcessing")
require("prototypes.optional.optionCoalProcessing.recipe_optionCoalProcessing")
--~ -- Moved to data-updates.lua! We'll first check if alternative techs already exist.
require("prototypes.optional.optionCoalProcessing.technology_optionCoalProcessing")


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
require("prototypes.optional.optionDarts.categories_optionDarts")
require("prototypes.optional.optionDarts.entity_optionDarts")
require("prototypes.optional.optionDarts.item_optionDarts")
require("prototypes.optional.optionDarts.recipe_optionDarts")
require("prototypes.optional.optionDarts.technology_optionDarts")


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
require("prototypes.optional.optionBioCannon.categories_optionCannon")
require("prototypes.optional.optionBioCannon.entity_optionCannon")
require("prototypes.optional.optionBioCannon.item_optionCannon")
require("prototypes.optional.optionBioCannon.recipe_optionCannon")
require("prototypes.optional.optionBioCannon.technology_optionCannon")


------------------------------------------------------------------------------------
--                           Enable: Disassemble recipes                          --
--                          (BI.Settings.BI_Disassemble)                          --
------------------------------------------------------------------------------------
require("prototypes.optional.optionDisassemble")


------------------------------------------------------------------------------------
--                          Enable: BI_Pollution_Detector                         --
--                       (BI.Settings.BI_Pollution_Detector)                      --
------------------------------------------------------------------------------------
require("prototypes.optional.optionPollutionSensor.entity_optionPollution")
require("prototypes.optional.optionPollutionSensor.item_optionPollution")
require("prototypes.optional.optionPollutionSensor.recipe_optionPollution")
require("prototypes.optional.optionPollutionSensor.technology_optionPollution")


------------------------------------------------------------------------------------
--                  Enable: Bio power production and distribution                 --
--                        (BI.Settings.BI_Power_Production)                       --
------------------------------------------------------------------------------------
require("prototypes.optional.optionPowerProduction.categories_optionPower")
require("prototypes.optional.optionPowerProduction.entity_optionPower")
require("prototypes.optional.optionPowerProduction.item_optionPower")
require("prototypes.optional.optionPowerProduction.recipe_optionPower")
require("prototypes.optional.optionPowerProduction.technology_optionPower")


------------------------------------------------------------------------------------
--                               Enable: Seed bombs                               --
--                       (BI.Settings.BI_Explosive_Planting)                      --
------------------------------------------------------------------------------------
require("prototypes.optional.optionSeedBombs.categories_optionSeedBombs")
require("prototypes.optional.optionSeedBombs.entity_optionSeedBombs")
require("prototypes.optional.optionSeedBombs.item_optionSeedBombs")
require("prototypes.optional.optionSeedBombs.recipe_optionSeedBombs")
require("prototypes.optional.optionSeedBombs.technology_optionSeedBombs")


------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
require("prototypes.optional.optionRails.entity_optionRails")
require("prototypes.optional.optionRails.item_optionRails")
require("prototypes.optional.optionRails.recipe_optionRails")
require("prototypes.optional.optionRails.technology_optionRails")


------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
require("prototypes.optional.optionRubber.entity_optionRubber")
require("prototypes.optional.optionRubber.item_optionRubber")
require("prototypes.optional.optionRubber.recipe_optionRubber")
require("prototypes.optional.optionRubber.technology_optionRubber")


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
require("prototypes.optional.optionStoneCrushing.categories_optionStoneCrushing")
require("prototypes.optional.optionStoneCrushing.entity_optionStoneCrushing")
require("prototypes.optional.optionStoneCrushing.item_optionStoneCrushing")
require("prototypes.optional.optionStoneCrushing.recipe_optionStoneCrushing")
require("prototypes.optional.optionStoneCrushing.technology_optionStoneCrushing")


------------------------------------------------------------------------------------
--                              Enable: Terraforming                              --
--                          (BI.Settings.BI_Terraforming)                         --
------------------------------------------------------------------------------------
require("prototypes.optional.optionTerraforming.categories_optionTerraforming")
require("prototypes.optional.optionTerraforming.entity_optionTerraforming")
require("prototypes.optional.optionTerraforming.item_optionTerraforming")
require("prototypes.optional.optionTerraforming.recipe_optionTerraforming")
require("prototypes.optional.optionTerraforming.technology_optionTerraforming")


------------------------------------------------------------------------------------
--                            Enable: Wood gasification                           --
--                       (BI.Settings.BI_Wood_Gasification)                       --
------------------------------------------------------------------------------------
require("prototypes.optional.optionWoodGasification.fluid_optionWoodGasification")
require("prototypes.optional.optionWoodGasification.recipe_optionWoodGasification")
require("prototypes.optional.optionWoodGasification.technology_optionWoodGasification")


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
require("prototypes.optional.optionWoodProducts.entity_optionWoodProducts")
require("prototypes.optional.optionWoodProducts.item_optionWoodProducts")
require("prototypes.optional.optionWoodProducts.recipe_optionWoodProducts")
require("prototypes.optional.optionWoodProducts.technology_optionWoodProducts")


------------------------------------------------------------------------------------
--           Game tweaks: Alternative recipe for Production Science Pack          --
--                 (BI.Settings.BI_Game_Tweaks_Production_Science)                --
------------------------------------------------------------------------------------
require("prototypes.optional.tweaksSciencePack")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                    TRIGGERS                                    --
--                   (Running before mod-compatibility scripts)                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--             Data of all additional things that depend on a trigger             --
------------------------------------------------------------------------------------
require("prototypes.triggers.additional_entities")
require("prototypes.triggers.additional_fluids")
require("prototypes.triggers.additional_items")
require("prototypes.triggers.additional_recipes")
require("prototypes.triggers.additional_technologies")


------------------------------------------------------------------------------------
--                                 Check triggers                                 --
------------------------------------------------------------------------------------
require("prototypes.triggers.triggerBiRefinery")
require("prototypes.triggers.triggerConcrete")
require("prototypes.triggers.triggerEasyBioGardens")
require("prototypes.triggers.triggerWoodfloor")
require("prototypes.triggers.triggerCrushedStoneCreate")
require("prototypes.triggers.triggerCharcoalCreate")
require("prototypes.triggers.triggerWoodpulpCreate")


--~ ------------------------------------------------------------------------------------
--~ --           Trigger: Crafting of bioreactor recipes in the oil refinery          --
--~ --                       (BI.Triggers.BI_Trigger_BiRefinery)                      --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.mod_compatibility.triggerBiRefinery")


--~ ------------------------------------------------------------------------------------
--~ --                     Trigger: Make tech for Refined concrete                    --
--~ --                        (BI.Triggers.BI_Trigger_Concrete)                       --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional.triggerConcrete")


--~ ------------------------------------------------------------------------------------
--~ --                      Trigger: Create item "crushed stone"?                     --
--~ --                  (BI.Triggers.BI_Trigger_Crushed_Stone_Create)                 --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.mod_compatibility.triggerCrushedStone")


--~ ------------------------------------------------------------------------------------
--~ --                            Trigger: Easy Bio gardens                           --
--~ --                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional.triggerEasyBioGardens")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--               MOD COMPATIBILITY -- THINGS DEPENDENT ON OTHER MODS              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--            Data of all additional things that depend on another mod            --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.additional_categories_item")
--~ require("prototypes.mod_compatibility.additional_entities")
require("prototypes.mod_compatibility.additional_recipes")
require("prototypes.mod_compatibility.additional_recipes_IR2")
require("prototypes.mod_compatibility.additional_remnants")

------------------------------------------------------------------------------------
--                                  Alien biomes                                  --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modAlienBiomes")


------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modAngels")


------------------------------------------------------------------------------------
--                           Assembler Pipe Passthrough                           --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modAssemblerPipePassthrough")


------------------------------------------------------------------------------------
--                                     BioTech                                    --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modBioTech")


------------------------------------------------------------------------------------
--                                   Bob's mods                                   --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modBobs")


------------------------------------------------------------------------------------
--                                Deadlock Crating                                --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modDeadlockCrating")

------------------------------------------------------------------------------------
--                                    Dectorio                                    --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modDectorio")


--~ ------------------------------------------------------------------------------------
--~ --                             Industrial Revolution 2                            --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.mod_compatibility.modIndustrialRevolution")


------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modKrastorio2")


------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
--      (Replacing "bi-ash" with "ash" is now independent of specific mods!)      --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.modPyanodon")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 FINAL TRIGGERS                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--~ require("prototypes.triggers.posttriggerCrushedStoneCreate")


--~ ------------------------------------------------------------------------------------
--~ --                       Trigger: Create "wooden floor" tile                      --
--~ --                       (BI.Triggers.BI_Trigger_Woodfloor)                       --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.mod_compatibility.triggerWoodfloor")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--  ALL BASE ENTITIES EXIST -- NOW CREATE THE HIDDEN PARTS OF COMPOUND ENTITIES!  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- Compile a list of the compound entities we need!
BioInd.compound_entities = BioInd.build_compound_entity_list()
BioInd.debugging.show("LIST OF COMPOUND ENTITIES", BioInd.compound_entities)
-- Create the hidden entities. (This will load all other files we'll need!)
require("prototypes.compound_entities.hidden_entities")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                        FINAL ADJUSTMENTS FOR THIS STAGE                        --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Moved to data-final-fixes!
--~ ------------------------------------------------------------------------------------
--~ --                           Add icons to our prototypes                          --
--~ ------------------------------------------------------------------------------------
--~ BioInd.BI_add_icons()


------------------------------------------------------------------------------------
--                           Add unlocks to technologies                          --
------------------------------------------------------------------------------------
BioInd.BI_add_unlocks()


------------------------------------------------------------------------------------
--      Add difficulty to our recipes -- other mods may expect them to exist!     --
------------------------------------------------------------------------------------
BioInd.BI_add_difficulty()


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

if flag.IS_DEV_MODE then
  Lock.remove_lock(_ENV, '_ENV')
  end
