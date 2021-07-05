------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Stone_Crushing"
if BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
-- If Stone crushing has been disabled, we need to replace "Crushed stone" as an  --
-- ingredient with "Stone" in all recipes.
------------------------------------------------------------------------------------
local ingredients, name, amount
local name = BI.optional_items.BI_Stone_Crushing.crushed_stone.name


for r_name, recipe in pairs(data.raw.recipe) do
  -- Get list of ingredients, indexed by ingredient name
BioInd.show("Checking recipe", r_name)
  for i, i_list in pairs({
    recipe.ingredients or {},
    recipe.normal and recipe.normal.ingredients or {},
    recipe.expensive and recipe.expensive.ingredients or {},
  }) do
--~ BioInd.show("i", i)
--~ BioInd.show("i_list", i_list)
    ingredients = BI_Functions.lib.get_recipe_ingredients(i_list)
--~ BioInd.show("ingredients", ingredients)

    if ingredients[name] then
      amount = math.max(1, math.ceil(ingredients[name].amount/2))
      thxbob.lib.recipe.remove_ingredient(recipe.name, name)
      thxbob.lib.recipe.add_new_ingredient(recipe.name, {
        type = "item",
        name = "stone",
        amount = amount
      })
      BioInd.modified_msg("ingredients", recipe)
    break
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
