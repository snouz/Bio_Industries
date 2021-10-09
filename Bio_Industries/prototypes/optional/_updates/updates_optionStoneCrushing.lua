------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Stone_Crushing"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local items = data.raw.item
local techs = data.raw.technology
local recipe, ingredients, name, amount, item
local tech, prerequisite

------------------------------------------------------------------------------------
--      If Stone crushing is enabled, we add "Crushed stone" to some recipes.     --
------------------------------------------------------------------------------------
-- Vanilla rails
recipe = recipes["rail"]
item = items[BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone.name]

if recipe and item then
  -- Make sure the recipe has difficulties!
  thxbob.lib.recipe.difficulty_split(recipe.name)
  for m, mode in pairs({"normal", "expensive" }) do
    ingredients = recipe[mode] and recipe[mode].ingredients
    -- Get the amount of stone used in the original recipe
    amount = BI_Functions.lib.get_recipe_ingredients(ingredients)
    amount = (amount and amount["stone"].amount or 1.5) * 4
    thxbob.lib.recipe.add_difficulty_ingredient(recipe.name, mode, {item.name, amount})
  end
  recipe.ingredients = table.deepcopy(recipe.normal.ingredients)
  thxbob.lib.recipe.remove_ingredient(recipe.name, "stone")
  BioInd.debugging.modified_msg("ingredients", recipe)
end


--~ ------------------------------------------------------------------------------------
--~ -- If Stone crushing has been disabled, we need to replace "Crushed stone" as an  --
--~ -- ingredient with "Stone" in all recipes.                                        --
--~ ------------------------------------------------------------------------------------
--~ else
  --~ name = BI.additional_items.BI_Trigger_Crushed_Stone.crushed_stone.name

  --~ for r_name, recipe in pairs(recipes) do
    --~ -- Get list of ingredients, indexed by ingredient name
  --~ BioInd.debugging.show("Checking recipe", r_name)
    --~ -- Make sure the recipe has difficulties!
    --~ thxbob.lib.recipe.difficulty_split(recipe.name)
    --~ for m, mode in pairs({"normal", "expensive" }) do
      --~ ingredients = recipe[mode] and recipe[mode].ingredients
      --~ ingredients = BI_Functions.lib.get_recipe_ingredients(recipe[mode].ingredients)
      --~ if ingredients and ingredients[name] then
        --~ amount = math.max(1, math.ceil(ingredients[name].amount/2))
        --~ thxbob.lib.recipe.add_difficulty_ingredient(recipe.name, mode, {"stone", amount})
      --~ end
    --~ end
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, name)
    --~ BioInd.debugging.modified_msg("ingredients", recipe)
  --~ end
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
