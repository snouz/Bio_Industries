local BioInd = require('common')('Bio_Industries')

if mods["IndustrialRevolution"] then
  ------------------------------------------------------------------------------------
  -- Our large wooden poles are unlocked by the "Logistics" research and require small
  -- electric poles, which are unlocked by IR2 after the Iron Age has been reached. So,
  -- if IR2 is active, we won't unlock our poles and use IR2's large wooden poles for
  -- our huge poles instead.
  ------------------------------------------------------------------------------------
  local big_pole = "bi-wooden-pole-big"
  thxbob.lib.tech.remove_recipe_unlock ("logistics", big_pole)
  thxbob.lib.tech.add_recipe_unlock ("electric-energy-distribution-1", big_pole)
  --~ thxbob.lib.tech.add_recipe_unlock ("electric-energy-distribution-2", "bi-wooden-pole-huge")

  -- Adjust localizations
  for k, v in ipairs({"electric-pole", "item", "recipe"}) do
BioInd.show("Changing localization for", v)
    data.raw[v][big_pole].localised_name = {"entity-name.bi-wooden-pole-bigger"}
    data.raw[v][big_pole].localised_description = {"entity-description.bi-wooden-pole-bigger"}
  end


  ------------------------------------------------------------------------------------
  -- Replace "crushed stone" with "gravel"!
  ------------------------------------------------------------------------------------
  local i_old = "stone-crushed"
  local i_new = "gravel"
  local replaced, check, add

  for recipe_name, recipe in pairs(data.raw.recipe) do
    -- Ingredients
    replaced = thxbob.lib.recipe.replace_ingredient(recipe_name, i_old, i_new)
BioInd.writeDebug("Replaced ingredient %s with %s in recipe %s: %s", {i_old, i_new, recipe_name, replaced})

    -- Results
    for t, tab in ipairs({"", "normal", "expensive"}) do
BioInd.show("tab", tab)
      check = (tab == "") and recipe or recipe[tab]
      thxbob.lib.result_check(check) -- Make sure we have results!

--~ BioInd.show("check", check)
      for r, result in ipairs(check and check.results or {}) do
BioInd.show("result", result)
        if result.name == i_old then
--~ BioInd.show("Must replace", result.name)
          -- Store the properties of the original result
          add = {
            type = result.type,
            name = i_new,
            amount = result.amount
          }
--~ BioInd.show("Must add", add)
          thxbob.lib.recipe.remove_result(recipe_name, i_old)
--~ BioInd.show("Removed results", recipe)
          thxbob.lib.item.add(check.results, add)
BioInd.writeDebug("Exchanged %s in %s results of %s with %s:\t%s",
                  {i_old, tab, recipe_name, i_new, recipe})
        else
BioInd.show("Skipping", result.name)
        end
      end
    end
  end

  -- Add unlocks
  local crushing = {
    ["bi-crushed-stone-1"] = "grinding-1",
    ["bi-crushed-stone-2"] = "grinding-2",
    ["bi-crushed-stone-3"] = "grinding-2",
    ["bi-crushed-stone-4"] = "grinding-3",
    ["bi-crushed-stone-5"] = "grinding-3",
  }
  local r
  for recipe, category in pairs(crushing) do
    r = data.raw.recipe[recipe]
    r.category = category
    r.localised_name = {"recipe-name." .. recipe .. "_IR"}
    if recipe == "bi-crushed-stone-1" then
      r.localised_description = {"recipe-description.bi-crushed-stone-1_IR"}
    else
      r.localised_description = {"recipe-description.bi-crushed-stone_IR"}
    end
    thxbob.lib.tech.add_recipe_unlock("ir2-" .. category, recipe)
  end
end
