------------------------------------------------------------------------------------
--                             Industrial Revolution 2                            --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe
local techs = data.raw.technology
local recipe, item, entity, tech, p_type, prototype


------------------------------------------------------------------------------------
--                       Adjustments to our big wooden poles                      --
------------------------------------------------------------------------------------
-- Adjust localization of entity, item, and recipe
--~ for k, v in ipairs({"electric-pole", "item", "recipe"}) do
  --~ prototype = data.raw[v]["bi-wooden-pole-big"]
  --~ if prototype then
    --~ p_type = (v == "electric-pole") and "entity" or v
    --~ prototype.localised_name = {"entity-name.bi-wooden-pole-bigger"}
    --~ prototype.localised_description = {"entity-description.bi-wooden-pole-bigger"}
    --~ BioInd.modified_msg("localization", prototype)
  --~ end
--~ end
for k, v in ipairs({
    BI.additional_recipes.BI_Wood_Products and BI.additional_recipes.BI_Wood_Products.big_pole,
    BI.additional_items.BI_Wood_Products and BI.additional_items.BI_Wood_Products.big_pole,
    BI.additional_entities.BI_Wood_Products and BI.additional_entities.BI_Wood_Products.big_pole
  }) do

  prototype = data.raw[v.type][v.name]
  if prototype then
    prototype.localised_name = {"entity-name.bi-wooden-pole-bigger"}
    prototype.localised_description = {"entity-description.bi-wooden-pole-bigger"}
    BioInd.modified_msg("localization", prototype)
  end
end


-- Adjust localization of technology
tech = techs[BI.additional_techs.BI_Wood_Products.wooden_pole_1.name]
p_type = BI.additional_entities.BI_Wood_Products.big_pole

prototype = p_type and data.raw[p_type.type] and data.raw[p_type.type][p_type.name]

if tech and prototype then
  tech.localised_name = {
    "technology-name.bi-tech-wooden-pole-1",
    {"entity-name.bi-wooden-pole-bigger"}
  }
  tech.localised_description = {
    "technology-description.bi-tech-wooden-pole-1",
    {"entity-name.bi-wooden-pole-bigger"},
    prototype.maximum_wire_distance
  }
  BioInd.modified_msg("localization", tech)
end


------------------------------------------------------------------------------------
-- Put recipe for Bio stone bricks in the same subgroup as concrete!
------------------------------------------------------------------------------------
--~ recipe = recipes["bi-stone-brick"]
recipe = recipes[BI.additional_recipes.BI_Stone_Crushing.stone_brick.name]
if recipe then
  recipe.subgroup = "ir2-tiles"
  BioInd.modified_msg("subgroup", recipe)
end

------------------------------------------------------------------------------------
-- Replace "crushed stone" with "gravel" in all recipes
------------------------------------------------------------------------------------
local i_old = "stone-crushed"
local i_new = "gravel"
--~ local replaced, check, add

--~ for recipe_name, recipe in pairs(recipes) do
--~ BioInd.writeDebug("Replacing crushed stone in %s?", {recipe_name})
  --~ thxbob.lib.recipe.replace_ingredient(recipe_name, i_old, i_new)
  --~ BioInd.modified_msg("ingredient " .. i_old, recipe)

  --~ -- Results
  --~ -- for d, difficulty in ipairs({"", "normal", "expensive"}) do
  --~ for d, difficulty in ipairs(BioInd.difficulties) do
--~ BioInd.show("difficulty", difficulty)
    --~ check = (difficulty == "") and recipe or recipe[difficulty]
--~ BioInd.show("check", check)
    --~ thxbob.lib.result_check(check) -- Make sure we have results!
    --~ BioInd.writeDebug("Recipe%s: %s",
                      --~ {difficulty == "" and "" or " for difficulty " .. difficulty, check or "nil"})
    --~ for r, result in ipairs(check and check.results or {}) do
  --~ BioInd.writeDebug("Checking result %s (difficulty %s): %s", {r, difficulty == "" and "raw" or difficulty, result})
      --~ if result.name == i_old then
        --~ -- Store the properties of the original result
        --~ add = {
          --~ type = result.type,
          --~ name = i_new,
          --~ amount = result.amount
        --~ }
        --~ thxbob.lib.recipe.remove_difficulty_result(recipe_name, difficulty, i_old)
  --~ BioInd.show("Trying to add", add)
        --~ thxbob.lib.recipe.add_difficulty_result(recipe_name, difficulty, add)
        --~ BioInd.writeDebug("Exchanged %s in %sresults of %s with %s:\t%s",
                          --~ {i_old, difficulty == "" and "" or difficulty .. " ", recipe_name, i_new, recipe})
      --~ else
        --~ BioInd.show("Skipping", result.name)
      --~ end
    --~ end

    --~ -- Don't forget to change main_product as well!
    --~ if check and check.main_product and check.main_product == i_old then
      --~ check.main_product = i_new
      --~ BioInd.writeDebug("Exchanged %s in main_product %s of %s with %s:\t%s",
                        --~ {i_old, difficulty == "" and difficulty or " (" .. difficulty .. ")", recipe_name, i_new, recipe})
    --~ end
  --~ BioInd.writeDebug("Finished with difficulty %s", {difficulty == "" and "raw" or difficulty})
  --~ end

  -- Replace in ingredients (all difficulties)
  thxbob.lib.recipe.replace_ingredient_in_all(i_old, i_new)
  BioInd.writeDebug("Exchanged \"%s\" in ingredients of all recipes with %s:\t%s",
                    {i_old, i_new, recipe})
  -- Replace in results (all difficulties)
  thxbob.lib.recipe.replace_result_in_all(i_old, i_new)
  BioInd.writeDebug("Exchanged \"%s\" in ingredients of all recipes with %s:\t%s",
                    {i_old, i_new, recipe})

--~ end


------------------------------------------------------------------------------------
-- Add unlocks for our stone-crushing recipes
------------------------------------------------------------------------------------
local crushing = {
  ["bi-crushed-stone-stone"]                   = {category = "grinding-1", item = "stone"},
  ["bi-crushed-stone-stone-brick"]             = {category = "grinding-1", item = "stone-brick"},
  ["bi-crushed-stone-concrete"]                = {category = "grinding-2", item = "concrete"},
  ["bi-crushed-stone-hazard-concrete"]         = {category = "grinding-2", item = "hazard-concrete"},
  ["bi-crushed-stone-refined-concrete"]        = {category = "grinding-3", item = "refined-concrete"},
  ["bi-crushed-stone-refined-hazard-concrete"] = {category = "grinding-3", item = "refined-hazard-concrete"},
}

for r_name, r_data in pairs(crushing) do
BioInd.writeDebug("r_name: %s\tr_data: %s", {r_name, r_data})
BioInd.show("r_data.category", r_data.category)
  recipe = recipes[r_name]
  if recipe then
    -- Change category
    recipe.category = r_data.category
    BioInd.modified_msg("category", recipe)

    -- Change localization
      recipe.localised_name = {
        "recipe-name.bi-crushed-stone-IR",
        {"item-name." .. r_data.item}
      }
      recipe.localised_description = {
        "recipe-description.bi-crushed-stone-IR",
        {"item-name." .. r_data.item}
      }
    BioInd.modified_msg("localization", recipe)

    -- Add unlock
    thxbob.lib.tech.add_recipe_unlock("ir2-" .. r_data.category, recipe.name)
    BioInd.modified_msg("unlock", recipe)
  end
end

------------------------------------------------------------------------------------
-- Add IR2's crafting categories to our stone crusher! It should be able to craft
-- the recipes that can be made by IR2's Copper crusher ("grinding-1") and Electric
-- crusher ("grinding-2").
------------------------------------------------------------------------------------
local crusher = BI.additional_entities.BI_Stone_Crushing.stone_crusher
crusher = crusher and data.raw[crusher.type][crusher.name]

if crusher then
  for c, category in ipairs({
    "grinding-1", "grinding-2",
    "powdering-1", "powdering-2"
  }) do
    --~ table.insert(crusher.crafting_categories, category)
    crusher.crafting_categories[#crusher.crafting_categories + 1] = category
    BioInd.modified_msg("category \"" .. category .. "\"", crusher, "Added")
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
