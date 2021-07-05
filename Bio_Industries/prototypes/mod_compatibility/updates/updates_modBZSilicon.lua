------------------------------------------------------------------------------------
--                                Silica & Silicon                                --
------------------------------------------------------------------------------------
local mod_name = "bzsilicon"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local pattern = ".*solar%-cell.*"
local add_it, ingredients, recipe


------------------------------------------------------------------------------------
--                 Add solar cell to Musk floor (solar mat) recipe                --
------------------------------------------------------------------------------------
recipe = data.raw.recipe["bi-solar-mat"]

if recipe then

  -- Check ingredients for all/no difficulties
  --~ for d, difficulty in ipairs({"", "normal", "expensive"}) do
  for d, difficulty in ipairs(BioInd.difficulties) do
    add_it = true

    -- Get normalized list of ingredients
    ingredients = BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, difficulty)

    -- Check if any of the ingredients match the pattern "solar-cell"
    for i_name, i_data in pairs(ingredients or {}) do
      if i_name:match(pattern) then
        add_it = false
        break
      end
    end

    -- Add solar-cell if there isn't any other yet!
    if add_it then
      thxbob.lib.recipe.add_difficulty_ingredient(recipe, difficulty, {
        type = "item",
        name = "solar-cell",
        amount = 1
      })
      BioInd.modified_msg("ingredients", recipe, "Added")
    end
  end

end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
