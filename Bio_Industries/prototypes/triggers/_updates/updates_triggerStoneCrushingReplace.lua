------------------------------------------------------------------------------------
--                Trigger: Replace item "crushed stone" in recipes?               --
--                 (BI.Triggers.BI_Trigger_Crushed_Stone_Replace)                 --
------------------------------------------------------------------------------------
-- Setting: not BI.Settings.BI_Stone_Crushing
local trigger = "BI_Trigger_Crushed_Stone_Replace"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local items = data.raw.item
local techs = data.raw.technology
local recipe, ingredients, name, amount, item
local tech, prerequisite


------------------------------------------------------------------------------------
-- If Stone crushing has been disabled, we need to replace "Crushed stone" as an  --
-- ingredient with "Stone" in all recipes.                                        --
------------------------------------------------------------------------------------
name = BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone.name

for r_name, recipe in pairs(recipes) do
  -- Get list of ingredients, indexed by ingredient name
  BioInd.show("Checking recipe", r_name)
  -- Make sure the recipe has difficulties!
  thxbob.lib.recipe.difficulty_split(recipe.name)
  for m, mode in pairs({"normal", "expensive" }) do
    --~ ingredients = recipe[mode] and recipe[mode].ingredients
    ingredients = BI_Functions.lib.get_recipe_ingredients(recipe[mode].ingredients)
    if ingredients and ingredients[name] then
      amount = math.max(1, math.ceil(ingredients[name].amount/2))
      thxbob.lib.recipe.add_difficulty_ingredient(recipe.name, mode, {"stone", amount})
    end
  end
  thxbob.lib.recipe.remove_ingredient(recipe.name, name)
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
