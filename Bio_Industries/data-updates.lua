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
--~ --if recipes[BI.additional_recipes.sand.name] then
  --~ --recipe = recipes["bi-stone-crusher"]
  --~ --if recipe then
    --~ --for _, t in ipairs({"furnace", "item", "recipe"}) do
      --~ --data.raw[t][recipe.name].localised_description = {
        --~ --"entity-description." .. recipe.name .. "-sand"
      --~ --}
      --~ --BioInd.modified_msg("localization", data.raw[t][recipe.name])
    --~ --end
  --~ --end
--~ --end


------------------------------------------------------------------------------------
--                        Enable "Productivity" in recipes                        --
------------------------------------------------------------------------------------
require("prototypes.default.updates.productivity")
--~ for recipe, r in pairs(recipes) do
  --~ for p, pattern in ipairs({
    --~ "bi%-acid",
    --~ "bi%-basic%-gas%-processing",
    --~ "bi%-battery",
    --~ "bi%-biomass%-%d",
    --~ "bi%-biomass%-conversion%-%d",
    --~ "bi%-cellulose%-%d",
    --~ "bi%-crushed%-stone%-%d",
    --~ "bi%-liquid%-air",
    --~ "bi%-logs%-%d",
    --~ "bi%-nitrogen",
    --~ "bi%-plastic%-%d",
    --~ "bi%-press%-wood",
    --~ "bi%-production%-science%-pack",
    --~ "bi%-resin%-pulp",
    --~ "bi%-resin%-wood",
    --~ "bi%-seed%-%d",
    --~ "bi%-seedling%-%d",
    --~ "bi%-stone%-brick",
    --~ "bi%-sulfur",
    --~ "bi%-sulfur%-angels",
    --~ "bi%-wood%-from%-pulp",
    --~ "bi%-woodpulp",
  --~ }) do
    --~ if recipe:match(pattern) then
      --~ BI_Functions.lib.allow_productivity(recipe)
      --~ break
    --~ end
  --~ end
--~ end




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


--~ ------------------------------------------------------------------------------------
--~ --                             Enable: Coal processing                            --
--~ --                        (BI.Settings.BI_Coal_Processing)                        --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional._updates.updates_optionCoalProcessing")


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
require("prototypes.optional._updates.updates_optionWoodProducts")





------------------------------------------------------------------------------------
--                          Game tweaks: Easy Bio gardens                         --
--                  (BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens)                 --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_tweaksEasyBioGardens")


------------------------------------------------------------------------------------
--                              Game tweaks: Recipes                              --
--                       (BI.Settings.BI_Game_Tweaks_Recipe)                      --
------------------------------------------------------------------------------------
require("prototypes.optional._updates.updates_tweaksRecipeTweaks")


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


--~ ------------------------------------------------------------------------------------
--~ --                     Add resistances to our hidden entities                     --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.compound_entities.updates.resistances")


--~ ------------------------------------------------------------------------------------
--~ --    Use alternative descriptions for stone crusher if our sand recipe exists!   --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.default.updates.sand_stonecrusher")
--if recipes[BI.additional_recipes.sand.name] then
  --recipe = recipes["bi-stone-crusher"]
  --if recipe then
    --for _, t in ipairs({"furnace", "item", "recipe"}) do
      --data.raw[t][recipe.name].localised_description = {
        --"entity-description." .. recipe.name .. "-sand"
      --}
      --BioInd.modified_msg("localization", data.raw[t][recipe.name])
    --end
  --end
--end


--~ ------------------------------------------------------------------------------------
--~ --         If the Alien Artifact is in the game, use it for some recipes!         --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.default.updates.alien_artifact")
--~ if items["alien-artifact"] then
  --~ --- Alternative recipe for advanced fertilizer
  --~ local recipe = recipes["bi-adv-fertilizer-1"]
  --~ if recipe then
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "bi-biomass")
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "alien-artifact",
      --~ amount = 5
    --~ })
    -- BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})
    --~ BioInd.modified("ingredients", recipe)
  --~ end
--~ end



--~ ------------------------------------------------------------------------------------
--~ -- If the Py-Suite is installed, we move our coal-processing unlocks to their techs!
--~ local check, set
--~ if mods["pyrawores"] then
  --~ -- Are all techs there?
  --~ check = true
  --~ for i = 1, 3 do
    --~ if not data.raw.technology["coal-mk0" .. i] then
      --~ check = false
      --~ break
    --~ end
  --~ end

  --~ if check then
    --~ set = true
    --~ --local unlocks = require("prototypes.Bio_Farm.coal_processing")
    --~ for i = 1, 3 do
      --~ for u, unlock in ipairs(unlocks[i]) do
        --~ thxbob.lib.tech.add_recipe_unlock("coal-mk0" .. i, unlock.recipe)
--~ BioInd.writeDebug("Added recipe %s to unlocks of %s", {unlock.recipe, "coal-mk0" .. i})
      --~ end
    --~ end
  --~ end
--~ end
--~ -- PyRawOres has priority!
--~ if mods["pycoalprocessing"] and not set then
   --~ -- Are all techs there?
  --~ check = true
  --~ for i = 1, 3 do
    --~ if not data.raw.technology["coal-processing-" .. i] then
      --~ check = false
      --~ break
    --~ end
  --~ end

  --~ if check then
    --~ set = true
    --~ --local unlocks = require("prototypes.Bio_Farm.coal_processing")
    --~ for i = 1, 3 do
      --~ for u, unlock in ipairs(unlocks[i]) do
        --~ thxbob.lib.tech.add_recipe_unlock("coal-processing-" .. i, unlock.recipe)
--~ BioInd.writeDebug("Added recipe %s to unlocks of %s", {unlock.recipe, "coal-processing-" .. i})
      --~ end
    --~ end
  --~ end
--~ end
--~ if set then
  --~ for i = 1, 3 do
    --~ data.raw.technology["bi-tech-coal-processing-" .. i] = nil
--~ BioInd.writeDebug("Removed technology " .. "bi-tech-coal-processing-" .. i)
  --~ end
--~ end




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
