------------------------------------------------------------------------------------
--                              Game tweaks: Recipes                              --
--                       (BI.Settings.BI_Game_Tweaks_Recipe)                      --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Recipe"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe
local recipes = data.raw.recipe
local items = data.raw.item


------------------------------------------------------------------------------------
--                       Change ingredients of some recipes                       --
------------------------------------------------------------------------------------

--- Concrete (Replace iron ore with iron sticks)
recipe = recipes["concrete"]
if recipe then
  thxbob.lib.recipe.remove_ingredient(recipe.name, "iron-ore")
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "iron-stick",
    amount = 2
  })
  BioInd.debugging.modified_msg("ingredients", recipe)
end


--- Stone wall (Add iron stick)
recipe = recipes["stone-wall"]
if recipe then
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "iron-stick",
    amount = 1
  })
  BioInd.debugging.modified_msg("ingredients", recipe)
end


-- Rails (Replace stone with crushed stone)
--~ if data.raw.item["stone-crushed"] then
if BI.Triggers.BI_Trigger_Crushed_Stone_Create then
  for _, r in ipairs({"rail", "bi-rail-wood"}) do
   recipe = recipes[r]
    if recipe then
      thxbob.lib.recipe.remove_ingredient(recipe.name, "stone")
      thxbob.lib.recipe.add_new_ingredient(recipe.name, {
        type = "item",
        name = "stone-crushed",
        amount = 6
      })
      BioInd.debugging.modified_msg("ingredients", recipe)
    end
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
  BioInd.debugging.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
