------------------------------------------------------------------------------------
--                                 Simple Silicon                                 --
------------------------------------------------------------------------------------
local mod_name = "SimpleSilicon"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                 Add solar cell to Musk floor (solar mat) recipe                --
------------------------------------------------------------------------------------
recipe = data.raw.recipe["bi-solar-mat"]
local check, ingredients

if recipe then

  -- Check ingredients for all/no difficulties
  for i, i_list in ipairs({
    recipe.ingredients,
    recipe.normal and recipe.normal.ingredients,
    recipe.expensive and recipe.expensive.ingredients
  }) do

    check = false

    -- Ingredients list must exist!
    if i_list then
      -- Get normalized list of ingredients
      ingredients = BI_Functions.lib.get_recipe_ingredients(i_list)

      -- Check if any of the ingredients match the pattern "solar-cell"
      for i_name, _ in pairs(ingredients) do
        if i_name:match(".*solar%-cell.*") then
          check = true
          break
        end
      end
    end
  end

  -- Add solar-cell if there isn't any other yet!
  if not check then
    thxbob.lib.recipe.add_new_ingredient(recipe, {
      type = "item",
      name = "solar-cell",
      amount = 1
    })
    BioInd.modified_msg("ingredients", recipe, "Added")
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
