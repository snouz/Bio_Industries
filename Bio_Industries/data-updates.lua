BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe, item, fluid
local recipes = data.raw.recipe
local items = data.raw.item
local fluids = data.raw.fluid



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


--~ ------------------------------------------------------------------------------------
--~ --    Use alternative descriptions for stone crusher if our sand recipe exists!   --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.default.updates.sand_stonecrusher")


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
--                   (Running before mod-compatibility scripts)                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
require("prototypes.triggers._updates.updates_triggerConcrete")
require("prototypes.triggers._updates.updates_triggerEasyBioGardens")
require("prototypes.triggers._updates.updates_triggerRubberDarts")
require("prototypes.triggers._updates.updates_triggerRubberWoodgas")
require("prototypes.triggers._updates.updates_triggerStoneCrushingReplace")
require("prototypes.triggers._updates.updates_triggerSubgroups")
require("prototypes.triggers._updates.updates_triggerWoodfloor")
require("prototypes.triggers.triggerSand")


--~ ------------------------------------------------------------------------------------
--~ --                            Trigger: Easy Bio gardens                           --
--~ --                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional._updates.updates_triggerEasyBioGardens")


--~ ------------------------------------------------------------------------------------
--~ --                     Trigger: Make tech for Refined concrete                    --
--~ --                        (BI.Triggers.BI_Trigger_Concrete)                       --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional._updates.updates_triggerConcrete")


--~ ------------------------------------------------------------------------------------
--~ --  Trigger: Change prerequisites of "Military 2" (depends on "Rubber" + "Darts") --
--~ --                      (BI.Triggers.BI_Trigger_Rubber_Darts)                     --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional._updates.updates_triggerRubberDarts")


--~ ------------------------------------------------------------------------------------
--~ -- Trigger: Change prerequisites of "Rubber mat" if "Wood gasification" is active --
--~ --                      (BI.Triggers.BI_Trigger_Rubber_Woodgas)                   --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional._updates.updates_triggerRubberWoodgas")


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
--     Yuoki Industries: Allow our stone-crushing recipes in Yuoki's crushers     --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_modYuokiIndustries")


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                    TRIGGERS                                    --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                Trigger: Create missing item-subgroups ("5-Dim")                --
--                       (BI.Triggers.BI_Trigger_Subgroups)                       --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.updates_triggerSubgroups")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Different things we need to change                       --
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
--                                 Menu Simulations                               --
------------------------------------------------------------------------------------

local menu_simulations = require("__Bio_Industries__/menu-simulations/menu-simulations")
if data.raw["utility-constants"]["default"].main_menu_simulations then
	--data.raw["utility-constants"]["default"].main_menu_simulations = {}
	data.raw["utility-constants"]["default"].main_menu_simulations.bioindustries_1 = menu_simulations.bioindustries_1
	if settings.startup["BI_Power_Production"].value then
		data.raw["utility-constants"]["default"].main_menu_simulations.bioindustries_2 = menu_simulations.bioindustries_2
	end
	if settings.startup["BI_Bio_Garden"].value then
		data.raw["utility-constants"]["default"].main_menu_simulations.bioindustries_3 = menu_simulations.bioindustries_3
	end

end
------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
