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


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                       Change ingredients of some recipes                       --
------------------------------------------------------------------------------------
local recipe
local recipes = data.raw.recipe


--- Concrete (Replace iron ore with iron sticks)
recipe = recipes["concrete"]
if recipe then
  thxbob.lib.recipe.remove_ingredient(recipe.name, "iron-ore")
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "iron-stick",
    amount = 2
  })
  BioInd.modified_msg("ingredients", recipe)
end


--- Stone wall (Add iron stick)
recipe = recipes["stone-wall"]
if recipe then
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "iron-stick",
    amount = 1
  })
  BioInd.modified_msg("ingredients", recipe)
end


-- Rails (Replace stone with crushed stone)
if data.raw.item["stone-crushed"] then
  recipe = recipes["rail"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "stone")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "stone-crushed",
      amount = 6
    })
    BioInd.modified_msg("ingredients", recipe)
  end

  recipe = recipes["bi-rail-wood"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "stone")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "stone-crushed",
      amount = 6
    })
    BioInd.modified_msg("ingredients", recipe)
  end
end


-- Vanilla rails (Add concrete)
recipe = recipes["rail"]
if recipe then
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "concrete",
    amount = 6
  })
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
