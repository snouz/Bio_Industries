------------------------------------------------------------------------------------
--                              Game tweaks: Recipes                              --
--                       (BI.Settings.BI_Game_Tweaks_Recipe)                      --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Recipe"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe
local recipes = data.raw.recipe

--- Concrete (Replace iron ore with iron sticks)
recipe = recipes["concrete"]
if recipe then
  --~ thxbob.lib.recipe.remove_ingredient("concrete", "iron-ore")
  --~ thxbob.lib.recipe.add_new_ingredient("concrete", {
  thxbob.lib.recipe.remove_ingredient(recipe, "iron-ore")
  thxbob.lib.recipe.add_new_ingredient(recipe, {
    type = "item",
    name = "iron-stick",
    amount = 2
  })
  --~ BioInd.writeDebug("Replaced \"iron-ore\" with \"iron-stick\" in concrete recipe.")
  BioInd.modified_msg("ingredients", recipe)
end

--- Stone wall (Add iron stick)
recipe = recipes["stone-wall"]
if recipe then
  thxbob.lib.recipe.add_new_ingredient(recipe, {
    type = "item",
    name = "iron-stick",
    amount = 1
  })
  --~ BioInd.writeDebug("Added \"iron-stick\" to stone-wall recipe.")
  BioInd.modified_msg("ingredients", recipe)
end


-- Rails (Replace stone with crushed stone)
if data.raw.item["stone-crushed"] then
  recipe = recipes["rail"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient("rail", "stone")
    thxbob.lib.recipe.add_new_ingredient("rail", {
      type = "item",
      name = "stone-crushed",
      amount = 6
    })
    --~ BioInd.writeDebug("Replaced \"stone\" with \"stone-crushed\" in rail recipe.")
    BioInd.modified_msg("ingredients", recipe)
  end

  recipe = recipes["bi-rail-wood"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient("bi-rail-wood", "stone")
    thxbob.lib.recipe.add_new_ingredient("bi-rail-wood", {
      type = "item",
      name = "stone-crushed",
      amount = 6
    })
    --~ BioInd.writeDebug("Replaced \"stone\" with \"stone-crushed\" in wooden-rail recipe.")
    BioInd.modified_msg("ingredients", recipe)
  end
end

-- Vanilla rails (Add concrete)
recipe = recipes["rail"]
if recipe then
  thxbob.lib.recipe.add_new_ingredient("rail", {
    type = "item",
    name = "concrete",
    amount = 6
  })
  --~ BioInd.writeDebug("Added \"concrete\" to vanilla rail recipe.")
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
