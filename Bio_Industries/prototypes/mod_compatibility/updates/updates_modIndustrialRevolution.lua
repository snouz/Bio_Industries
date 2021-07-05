------------------------------------------------------------------------------------
--                             Industrial Revolution 2                            --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe, item, entity

local items = data.raw.item
local recipes = data.raw.recipe

-- This isn't needed anymore because we now have our own techs!''
--~ ------------------------------------------------------------------------------------
--~ -- Our large wooden poles are unlocked by the "Logistics" research and require small
--~ -- electric poles, which are unlocked by IR2 after the Iron Age has been reached. So,
--~ -- if IR2 is active, we won't unlock our poles and use IR2's large wooden poles for
--~ -- our huge poles instead.
--~ ------------------------------------------------------------------------------------
--~ local big_pole = "bi-wooden-pole-big"
--~ thxbob.lib.tech.remove_recipe_unlock ("logistics", big_pole)
--~ thxbob.lib.tech.add_recipe_unlock ("electric-energy-distribution-1", big_pole)
--~ thxbob.lib.tech.add_recipe_unlock ("electric-energy-distribution-2", "bi-wooden-pole-huge")

-- Adjust localizations
for k, v in ipairs({"electric-pole", "item", "recipe"}) do
  prototype = data.raw[v]["bi-wooden-pole-big"]
  if prototype then
    prototype.localised_name = {"prototype-name.bi-wooden-pole-bigger"}
    prototype.localised_description = {"prototype-description.bi-wooden-pole-bigger"}
    BioInd.modified_msg("localization", prototype)
  end
end


------------------------------------------------------------------------------------
-- Put recipe for Bio stone bricks in the same subgroup as concrete!
------------------------------------------------------------------------------------
recipe = recipes["bi-stone-brick"]
if recipe then
  recipe.subgroup = "ir2-tiles"
  BioInd.modified_msg("subgroup", recipe)
end

------------------------------------------------------------------------------------
-- Replace "crushed stone" with "gravel"!
------------------------------------------------------------------------------------
local i_old = "stone-crushed"
local i_new = "gravel"
local replaced, check, add

for recipe_name, recipe in pairs(recipes) do
  -- Ingredients
  replaced = thxbob.lib.recipe.replace_ingredient(recipe_name, i_old, i_new)
  BioInd.writeDebug("Replaced ingredient %s with %s in recipe %s: %s",
                    {i_old, i_new, recipe_name, replaced})

  -- Results
  for t, tab in ipairs({"", "normal", "expensive"}) do
    check = (tab == "") and recipe or recipe[tab]
    thxbob.lib.result_check(check) -- Make sure we have results!
    BioInd.writeDebug("Recipe%s: %s",
                      {tab == "" and "" or " for difficulty " .. tab, check or "nil"})
    for r, result in ipairs(check and check.results or {}) do
      if result.name == i_old then
        -- Store the properties of the original result
        add = {
          type = result.type,
          name = i_new,
          amount = result.amount
        }
        thxbob.lib.recipe.remove_result(recipe_name, i_old)
        thxbob.lib.item.add(check.results, add)
        BioInd.writeDebug("Exchanged %s in %sresults of %s with %s:\t%s",
                          {i_old, tab == "" and tab or " " .. tab .. " ", recipe_name, i_new, recipe})
      else
        BioInd.show("Skipping", result.name)
      end
    end

    -- Don't forget to change main_product as well!
    if check and check.main_product and check.main_product == i_old then
      check.main_product = i_new
      BioInd.writeDebug("Exchanged %s in main_product%s of %s with %s:\t%s",
                        {i_old, tab == "" and tab or " (" .. tab .. ")", recipe_name, i_new, recipe})
    end
  end
end

-- Add recipe unlocks
local crushing = {
  ["bi-crushed-stone-1"] = "grinding-1",
  ["bi-crushed-stone-2"] = "grinding-2",
  ["bi-crushed-stone-3"] = "grinding-2",
  ["bi-crushed-stone-4"] = "grinding-3",
  ["bi-crushed-stone-5"] = "grinding-3",
}

for r_name, r_category in pairs(crushing) do
  recipe = recipes[r_name]
  if recipe then
    -- Change category
    recipe.category = category
    BioInd.modified_msg("category", recipe)

    -- Change localization
    recipe.localised_name = {"recipe-name." .. r_name .. "_IR"}
    if r_name == "bi-crushed-stone-1" then
      recipe.localised_description = {"recipe-description.bi-crushed-stone-1_IR"}
    else
      recipe.localised_description = {"recipe-description.bi-crushed-stone_IR"}
    end
    BioInd.modified_msg("localization", recipe)

    -- Add unlock
    thxbob.lib.tech.add_recipe_unlock("ir2-" .. category, r_name)
    BioInd.modified_msg("unlock", recipe)
  end
end

-- Our stone crusher should be able to craft the recipes that can be made by
-- IR2's Copper crusher ("grinding-1") and Electric crusher ("grinding-2")!
local crusher = data.raw.furnace["bi-stone-crusher"]
if crusher then
  for c, category in ipairs({
    "grinding-1", "grinding-2",
    "powdering-1", "powdering-2"
  }) do
    table.insert(crusher.crafting_categories, category)
    BioInd.modified_msg("category \"" .. category .. "\"", crusher, "Added")
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
