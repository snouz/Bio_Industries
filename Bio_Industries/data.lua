local BioInd = require('common')('Bio_Industries')
BioInd.entered_file()

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

-- We don't want to require common.lua unnecessarily. Let's copy the function
-- that checks if required mods are active, so it's available in all other files!
BI.check_mods = BioInd.check_mods

-- Let's also copy some output functions!
BI.writeDebug = BioInd.writeDebug
BI.entered_function =  BioInd.entered_function
BI.entered_file = BioInd.entered_file
BI.nothing_to_do = BioInd.nothing_to_do

-- Populate BI.Settings with the setting values
BioInd.get_startup_settings()
for k, v in pairs(BI.Settings) do
BioInd.show("k", k)
BioInd.show("v", v)
end

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



-- Create the hidden entities
--require("prototypes.hidden_entities.hidden_entities")

--~ BioInd.show("BioInd.compound_entities", BioInd.compound_entities)
--~ error("Break!")


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                         DEFAULT -- ALWAYS CREATE THESE!                        --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                   Categories                                   --
------------------------------------------------------------------------------------
require("prototypes.default.categories_item")
require("prototypes.default.categories_recipe")
require("prototypes.default.damage-type")


------------------------------------------------------------------------------------
--                                     Fluids                                     --
------------------------------------------------------------------------------------
require("prototypes.default.fluids")


------------------------------------------------------------------------------------
--                                    Entities                                    --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.entity.entity_remnants")
require("prototypes.default.entity.entity")
require("prototypes.default.entity.entity_garden")
--~ require("prototypes.default.entity.entity_optionDarts")
require("prototypes.default.entity.entity_trees")
require("prototypes.default.entity.entity_woodproducts")


------------------------------------------------------------------------------------
--                                      Items                                     --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.item.item")
require("prototypes.default.item.item_garden")
require("prototypes.default.item.item_woodproducts")
--~ require("prototypes.default.item.item_optionDarts")


------------------------------------------------------------------------------------
--                                     Recipes                                    --
------------------------------------------------------------------------------------
-- Default
require("prototypes.default.recipe.recipe")
require("prototypes.default.recipe.recipe_forEntity")
require("prototypes.default.recipe.recipe_garden")
require("prototypes.default.recipe.recipe_woodproducts")
--~ require("prototypes.default.recipe.recipe_optionDarts")


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
require("prototypes.optional.additional_fluids")
require("prototypes.optional.additional_items")
require("prototypes.optional.additional_misc")
require("prototypes.optional.additional_recipes")
require("prototypes.optional.additional_remnants")
require("prototypes.optional.additional_technologies")


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
require("prototypes.optional.darts.entity_optionDarts")
require("prototypes.optional.darts.item_optionDarts")
require("prototypes.optional.darts.recipe_optionDarts")


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
require("prototypes.optional.bio_cannon.entity_optionCannon")
require("prototypes.optional.bio_cannon.item_optionCannon")
require("prototypes.optional.bio_cannon.recipe_optionCannon")
require("prototypes.optional.bio_cannon.technology_optionCannon")


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
require("prototypes.optional.bio_fuel.entity_optionBioFuel")
require("prototypes.optional.bio_fuel.item_optionBioFuel")
require("prototypes.optional.bio_fuel.recipe_optionBioFuel")
require("prototypes.optional.bio_fuel.technology_optionBioFuel")


--~ ------------------------------------------------------------------------------------
--~ --                          Enable: Bigger wooden chests                          --
--~ --                      (BI.Settings.BI_Bigger_Wooden_Chests)                     --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional.chests.entity_optionChests")
--~ require("prototypes.optional.chests.item_optionChests")
--~ require("prototypes.optional.chests.recipe_optionChests")
--~ require("prototypes.optional.chests.technology_optionChests")


------------------------------------------------------------------------------------
--                             Enable: Wooden products                            --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
require("prototypes.optional.wood_products.entity_optionWoodProducts")
require("prototypes.optional.wood_products.item_optionWoodProducts")
require("prototypes.optional.wood_products.recipe_optionWoodProducts")
require("prototypes.optional.wood_products.technology_optionWoodProducts")


------------------------------------------------------------------------------------
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
require("prototypes.optional.solar.entity_optionSolar")
require("prototypes.optional.solar.item_optionSolar")
require("prototypes.optional.solar.recipe_optionSolar")
require("prototypes.optional.solar.technology_optionSolar")


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
require("prototypes.optional.stone_crushing.entity_optionStoneCrushing")
require("prototypes.optional.stone_crushing.item_optionStoneCrushing")
require("prototypes.optional.stone_crushing.recipe_optionStoneCrushing")
require("prototypes.optional.stone_crushing.technology_optionStoneCrushing")


------------------------------------------------------------------------------------
--                            Enable: Easy Bio gardens                            --
--                  (BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens)                 --
------------------------------------------------------------------------------------
require("prototypes.optional.optionEasyBioGardens")



------------------------------------------------------------------------------------
--                        Game tweaks: Disassemble recipes                        --
--                    (BI.Settings.BI_Game_Tweaks_Disassemble)                    --
------------------------------------------------------------------------------------
require("prototypes.optional.optionDisassemble")


------------------------------------------------------------------------------------
--           Game tweaks: Alternative recipe for Production Science Pack          --
--                 (BI.Settings.BI_Game_Tweaks_Production_Science)                --
------------------------------------------------------------------------------------
require("prototypes.optional.optionSciencePack")





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--               MOD COMPATIBILITY -- THINGS DEPENDENT ON OTHER MODS              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--            Data of all additional things that depend on another mod            --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.additional_entities")
require("prototypes.mod_compatibility.additional_recipes")


------------------------------------------------------------------------------------
--                                  Alien biomes                                  --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.alien_biomes")

------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.angels")

------------------------------------------------------------------------------------
--                           Assembler Pipe Passthrough                           --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.assembler_pipe_passthrough")

------------------------------------------------------------------------------------
--                                     BioTech                                    --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.biotech")

------------------------------------------------------------------------------------
--                                   Bob's mods                                   --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.bobs")

------------------------------------------------------------------------------------
--                                    Dectorio                                    --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.dectorio")

------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.krastorio_2")





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--  ALL BASE ENTITIES EXIST -- NOW CREATE THE HIDDEN PARTS OF COMPOUND ENTITIES!  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- This will load all other files we need!
require("prototypes.compound_entities.hidden_entities")





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                        FINAL ADJUSTMENTS FOR THIS STAGE                        --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                           Add icons to our prototypes                          --
------------------------------------------------------------------------------------
BioInd.BI_add_icons()


------------------------------------------------------------------------------------
--                           Add unlocks to technologies                          --
------------------------------------------------------------------------------------
BioInd.BI_add_unlocks()


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
