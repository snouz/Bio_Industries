BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe, item, fluid
local recipes = data.raw.recipe
local items = data.raw.item
local fluids = data.raw.fluid

BI.Triggers.BI_Trigger_Sand = BI.Settings.BI_Stone_Crushing and
                              recipes[BI.additional_recipes.mod_compatibility.sand.name]

BioInd.show("BI.Triggers.BI_Trigger_Sand", BI.Triggers.BI_Trigger_Sand)
BioInd.show("BI.additional_recipes.mod_compatibility.sand.name", BI.additional_recipes.mod_compatibility.sand.name)
BioInd.show("recipes[BI.additional_recipes.mod_compatibility.sand.name]", recipes[BI.additional_recipes.mod_compatibility.sand.name])


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                     DEFAULT                                    --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--                        Data of things we may need to add                       --
------------------------------------------------------------------------------------
require("prototypes.default.updates.additional_fluids")
require("prototypes.default.updates.additional_items")
require("prototypes.default.updates.additional_recipes")


------------------------------------------------------------------------------------
--               Create liquid air and nitrogen? (Fluids + recipes)               --
------------------------------------------------------------------------------------
require("prototypes.default.updates.liquid_air_+_nitrogen")


------------------------------------------------------------------------------------
--    If ash already exists, use it in recipes, otherwise create our own item!    --
------------------------------------------------------------------------------------
require("prototypes.default.updates.ash")


------------------------------------------------------------------------------------
--         If the Alien Artifact is in the game, use it for some recipes!         --
------------------------------------------------------------------------------------
require("prototypes.default.updates.alien_artifact")


------------------------------------------------------------------------------------
--                     Add resistances to our hidden entities                     --
------------------------------------------------------------------------------------
require("prototypes.compound_entities.updates.resistances")


------------------------------------------------------------------------------------
--    Use alternative descriptions for stone crusher if our sand recipe exists!   --
------------------------------------------------------------------------------------
require("prototypes.default.updates.sand_stonecrusher")


------------------------------------------------------------------------------------
--                        Enable "Productivity" in recipes                        --
------------------------------------------------------------------------------------
require("prototypes.default.updates.productivity")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                    OPTIONAL -- THINGS DEPENDENT ON A SETTING                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionCannon")


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionBioFuel")


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionDarts")


------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionRails")


------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionRubber")



------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionStoneCrushing")


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionWoodGasification")


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_optionWoodProducts")


------------------------------------------------------------------------------------
--                              Game tweaks: Recipes                              --
--                       (BI.Settings.BI_Game_Tweaks_Recipe)                      --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_tweaksRecipeTweaks")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                    TRIGGERS                                    --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                            Trigger: Easy Bio gardens                           --
--                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_triggerEasyBioGardens")


------------------------------------------------------------------------------------
--                     Trigger: Make tech for Refined concrete                    --
--                        (BI.Triggers.BI_Trigger_Concrete)                       --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_triggerConcrete")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--               MOD COMPATIBILITY -- THINGS DEPENDENT ON OTHER MODS              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
--                          Angel's mods: Lots of changes                         --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modAngels")


------------------------------------------------------------------------------------
--                          Bob's mods: Lots of changes                           --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modBobs")


------------------------------------------------------------------------------------
--                             Dectorio: Wooden floor                             --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modDectorio")


------------------------------------------------------------------------------------
--                     Industrial Revolution: Lots of changes                     --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modIndustrialRevolution")


------------------------------------------------------------------------------------
--                         Krastorio 2: Replace Liquid air                        --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modKrastorio2")


------------------------------------------------------------------------------------
--                           Natural Evolution: Weapons                           --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modNEBuildings")


------------------------------------------------------------------------------------
--                         Omnifluid: Blacklist Bio boiler                        --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modOmniFluid")


------------------------------------------------------------------------------------
--                      Pyanodon's mods: Coal processing, ash                     --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modPyanodon")


------------------------------------------------------------------------------------
--              Silica & Silicon: Add solar-cell to Musk floor recipe             --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modBZSilicon")


------------------------------------------------------------------------------------
--                   Simple Silicon: Use solar cells in recipes                   --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modSimpleSilicon")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Different things we need to change                       --
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
