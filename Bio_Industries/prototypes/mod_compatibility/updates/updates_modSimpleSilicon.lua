------------------------------------------------------------------------------------
--                                 Simple Silicon                                 --
------------------------------------------------------------------------------------
local mod_name = "SimpleSilicon"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local pattern = ".*solar%-cell.*"
local recipe = data.raw.recipe["bi-solar-mat"]
local add_it, ingredients


------------------------------------------------------------------------------------
--                 Add solar cell to Musk floor (solar mat) recipe                --
------------------------------------------------------------------------------------
if recipe then
  --~ -- Check ingredients for all/no difficulties
  --~ for i, i_list in ipairs({
    --~ recipe.ingredients,
    --~ recipe.normal and recipe.normal.ingredients,
    --~ recipe.expensive and recipe.expensive.ingredients
  --~ }) do

    --~ check = false

    --~ -- Ingredients list must exist!
    --~ if i_list then
      --~ -- Get normalized list of ingredients
      --~ ingredients = BI_Functions.lib.get_recipe_ingredients(i_list)

      --~ -- Check if any of the ingredients match the pattern "solar-cell"
      --~ for i_name, _ in pairs(ingredients or {}) do
        --~ if i_name:match(".*solar%-cell.*") then
          --~ check = true
          --~ break
        --~ end
      --~ end
    --~ end
  --~ end

  --~ -- Add solar-cell if there isn't any other yet!
  --~ if not check then
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "solar-cell",
      --~ amount = 1
    --~ })
    --~ BioInd.debugging.modified_msg("ingredients", recipe, "Added")
  --~ end

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
      BioInd.debugging.modified_msg("ingredients", recipe, "Added")
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
