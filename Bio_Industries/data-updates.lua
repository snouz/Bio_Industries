BI.entered_file()

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath

--~ BioInd.get_startup_settings()

require('prototypes.mod_compatibility.additional_recipes')

local recipe, item, fluid
local recipes = data.raw.recipe
local items = data.raw.item
local fluids = data.raw.fluid




------------------------------------------------------------------------------------
--                        Data of things we may need to add                       --
------------------------------------------------------------------------------------
-- Liquid air/Nitrogen
require("prototypes.default.updates.additional_fluids")

-- Resin
require("prototypes.default.updates.additional_items")

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                         DEFAULT -- ALWAYS UPDATE THESE!                        --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ ------------------------------------------------------------------------------------
--~ --                          Update images of Wooden pipes                         --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.default.updates.update_pipes")


------------------------------------------------------------------------------------
--                            Update rail-related stuff                           --
------------------------------------------------------------------------------------
-- Rail collision masks and unlocks of vanilla rails
require("prototypes.default.updates.update_rail")

-- Update rail images/icons
require("prototypes.default.updates.update_tint_rails")

-- Wooden rail bridge
require("prototypes.default.updates.update_wooden_rail_bridge")


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                    OPTIONAL -- THINGS DEPENDENT ON A SETTING                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
require("prototypes.optional.updates.updates_optionCannon")


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
require("prototypes.optional.updates.updates_optionBioFuel")


------------------------------------------------------------------------------------
--                            Enable: Easy Bio gardens                            --
--                  (BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens)                 --
------------------------------------------------------------------------------------
require("prototypes.optional.updates.updates_optionEasyBioGardens")


------------------------------------------------------------------------------------
--                              Game tweaks: Recipes                              --
--                       (BI.Settings.BI_Game_Tweaks_Recipe)                      --
------------------------------------------------------------------------------------
require("prototypes.optional.updates.updates_optionRecipeTweaks")


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
require("prototypes.optional.updates.updates_optionWoodProducts")


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
require("prototypes.optional.updates.updates_optionStoneCrushing")


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--               MOD COMPATIBILITY -- THINGS DEPENDENT ON OTHER MODS              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ ------------------------------------------------------------------------------------
--~ --                   Alien Biomes: Remove tiles from blueprints!                  --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.mod_compatibility.updates.alien_biomes")


------------------------------------------------------------------------------------
--                          Angel's mods: Lots of changes                         --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.angels")


------------------------------------------------------------------------------------
--                          Bob's mods: Lots of changes                           --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.bobs")


------------------------------------------------------------------------------------
--                             Dectorio: Wooden floor                             --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.dectorio")


------------------------------------------------------------------------------------
--                     Industrial Revolution: Lots of changes                     --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.industrial_revolution")


------------------------------------------------------------------------------------
--                         Krastorio 2: Replace Liquid air                        --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.krastorio_2")


------------------------------------------------------------------------------------
--                         Omnifluid: Blacklist Bio boiler                        --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.omnifluid")


------------------------------------------------------------------------------------
--                      Pyanodon's mods: Coal processing, ash                     --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.py_mods")


------------------------------------------------------------------------------------
--                   Simple Silicon: Use solar cells in recipes                   --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.simple_silicon")


------------------------------------------------------------------------------------
--                           Natural Evolution: Weapons                           --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.updates.ne_buildings")



--~ ------------------------------------------------------------------------------------
--~ --                                     DARTS!                                     --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.mod_compatibility.updates.ne_buildings")

--~ if not mods["Natural_Evolution_Buildings"] and BI.Settings.Bio_Cannon then
  --~ -- add Prototype Artillery as pre req for artillery
  --~ thxbob.lib.tech.add_prerequisite("artillery", "bi-tech-bio-cannon")
--~ end







--~ ------------------------------------------------------------------------------------
--~ -- CLEAN THIS ONE OUT!
--~ require("prototypes.mod_compatibility.Bio_Farm_compatible_recipes") -- Bob and Angels mesh
--~ ------------------------------------------------------------------------------------





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Different things we need to change                       --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                        Enable "Productivity" in recipes                        --
------------------------------------------------------------------------------------
for recipe, r in pairs(recipes) do
  for p, pattern in ipairs({
    "bi%-acid",
    "bi%-basic%-gas%-processing",
    "bi%-battery",
    "bi%-biomass%-%d",
    "bi%-biomass%-conversion%-%d",
    "bi%-cellulose%-%d",
    "bi%-crushed%-stone%-%d",
    "bi%-liquid%-air",
    "bi%-logs%-%d",
    "bi%-nitrogen",
    "bi%-plastic%-%d",
    "bi%-press%-wood",
    "bi%-production%-science%-pack",
    "bi%-resin%-pulp",
    "bi%-resin%-wood",
    "bi%-seed%-%d",
    "bi%-seedling%-%d",
    "bi%-stone%-brick",
    "bi%-sulfur",
    "bi%-sulfur%-angels",
    "bi%-wood%-from%-pulp",
    "bi%-woodpulp",
  }) do
    if recipe:match(pattern) then
      BI_Functions.lib.allow_productivity(recipe)
      break
    end
  end
end


------------------------------------------------------------------------------------
--                     Add resistances to our hidden entities                     --
------------------------------------------------------------------------------------
require("prototypes.compound_entities.updates.resistances")


--~ ------------------------------------------------------------------------------------
--~ --                  Create Resin if no other mod provides it yet!                 --
--~ ------------------------------------------------------------------------------------
--~ if not items["resin"] then
  --~ data:extend({BI.optional_items.resin})
  --~ --BioInd.writeDebug("Created item \"resin\"!")
  --~ BioInd.created_msg(BI.optional_items.resin)
--~ end


------------------------------------------------------------------------------------
--         If the Alien Artifact is in the game, use it for some recipes!         --
------------------------------------------------------------------------------------
if items["alien-artifact"] then
  --- Alternative recipe for advanced fertilizer
  local recipe = recipes["bi-adv-fertilizer-1"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "bi-biomass")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "alien-artifact",
      amount = 5
    })
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})
    BioInd.modified("ingredients", recipe)
  end
end



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
--    Use alternative descriptions for stone crusher if our sand recipe exists!   --
------------------------------------------------------------------------------------
if recipes[BI.additional_recipes.sand.name] then
  recipe = recipes["bi-stone-crusher"]
  if recipe then
    for _, t in ipairs({"furnace", "item", "recipe"}) do
      data.raw[t][recipe.name].localised_description = {"entity-description." .. recipe.name .. "-sand"}
      --~ BioInd.writeDebug("Changed localization of %s \"%s\"!", {t, recipe.name})
      BioInd.modified_msg("localization", recipe)
    end
  end
end



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
BI.entered_file("leave")
