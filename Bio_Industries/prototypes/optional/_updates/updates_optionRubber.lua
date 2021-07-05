------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
local setting = "BI_Rubber"
if not BI.Settings[setting] then
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
local item, item_data, entity, recipe_list, ingredients, amount, tech, new_tech


------------------------------------------------------------------------------------
--                                   Create items                                 --
------------------------------------------------------------------------------------
for i, item_data in ipairs({
  BI.additional_items.BI_Rubber.resin,
  BI.additional_items.BI_Rubber.rubber,
}) do
  -- Check if we need to create the item
  if not items[item_data.name] then
    BioInd.create_stuff(item_data)

  -- Otherwise adjust icon and localization
  else
    item = items[item_data.name]
    BioInd.BI_change_icon(item, item_data.icon)
    BioInd.modified_msg("icon", item)

    item.localised_name = item_data.localised_name
    item.localised_description = item_data.localised_description
    BioInd.modified_msg("localization", item)
  end
end


------------------------------------------------------------------------------------
--                           Add rubber to some recipes                           --
------------------------------------------------------------------------------------
item_data = BI.additional_items.BI_Rubber.rubber

-- Vanilla poles
recipe_list = { "medium-electric-pole", "big-electric-pole", "substation" }

for r, r_name in ipairs(recipe_list) do
  recipe = recipes[r_name]
  if recipe then
    thxbob.lib.recipe.difficulty_split(recipe.name)
    for m, mode in pairs({"normal", "expensive" }) do
      ingredients = BI_Functions.lib.get_recipe_ingredients(recipe[mode].ingredients)

      -- Either amount of copper cables in vanilla recipe or fixed value multiplied
      -- with index in recipe_list (list is ordered by entity size)
      amount = ingredients and ingredients["copper-cable"] and
                ingredients["copper-cable"].amount > 0 and ingredients["copper-cable"].amount or
                r * 5

      thxbob.lib.recipe.add_difficulty_ingredient(recipe.name, mode, {item_data.name, amount})
    end
    recipe.ingredients = nil
    BioInd.modified_msg("ingredients", recipe)
  end
end


-- Fast (red) transport belts
recipe = recipes["fast-transport-belt"]
if recipe then
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {item_data.name, 2})
  BioInd.modified_msg("ingredients", recipe)
end


-- Fast (red) underground belts
recipe = recipes["fast-underground-belt"]
entity = data.raw["underground-belt"]["fast-underground-belt"]
if recipe and entity then
  amount = entity.max_distance * 2
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {item_data.name, amount})
  BioInd.modified_msg("ingredients", recipe)
end


-- Fast (red) splitters
recipe = recipes["fast-splitter"]
if recipe then
  amount = 5
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {item_data.name, amount})
  BioInd.modified_msg("ingredients", recipe)
end


-- Engines
--~ recipe_list = {"engine-unit", "electric-engine-unit"}
recipe_list = {"engine-unit"}
for r, r_name in ipairs(recipe_list) do
  recipe = recipes[r_name]
  if recipe then
    amount = 2
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {item_data.name, amount})
    BioInd.modified_msg("ingredients", recipe)
  end
end


-- Logistic science pack
recipe = recipes["logistic-science-pack"]
if recipe then
  amount = 2
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {item_data.name, amount})
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                      Adjustments to Logistic science pack                      --
------------------------------------------------------------------------------------
new_tech = BI.additional_techs.BI_Rubber.rubber_production

tech = techs["logistic-science-pack"]
if tech then
  -- Add "Rubber production" to prerequisites
  thxbob.lib.tech.add_prerequisite(tech.name, new_tech.name)
  BioInd.modified_msg("prerequisites", tech)

  -- Increase amount of needed science packs
  local count = 120
  local time = 30

  if tech.unit then
    tech.unit.count = count
    tech.unit.time = time
    BioInd.modified_msg("unit.count", tech)
  else
    tech.unit = {
      count = count,
      ingredients = {
        {"automation-science-pack", 1},
      },
      time = time,
    }
    BioInd.modified_msg("unit", tech, "Added")
  end
end


------------------------------------------------------------------------------------
--                        Adjustments to Military science 2                       --
------------------------------------------------------------------------------------
new_tech = BI.additional_techs.BI_Rubber.rubber_mat

tech = techs["military-2"]
if tech then
  -- Add "Rubber mat" to prerequisites
  thxbob.lib.tech.add_prerequisite(tech.name, new_tech.name)
  BioInd.modified_msg("prerequisites", tech)
end


------------------------------------------------------------------------------------
--             Remove obsolete prerequisites from several technologies            --
------------------------------------------------------------------------------------
local tech_map = {
  ["advanced-material-processing"] = {"steel-processing"},
  ["automation-2"] = {"steel-processing"},
  ["bi-tech-explosive-planting-1"] = {"bi-tech-bio-farming-1"},
  ["bi-tech-stone-crushing-2"] = {"bi-tech-stone-crushing-1"},
  ["bi-terraforming-1"] = {"bi-tech-bio-farming-1"},
  ["electric-energy-distribution-1"] = {"steel-processing"},
  ["engine"] = {"steel-processing"},
  ["military-2"] = {"logistic-science-pack", "military", "steel-processing"},
  ["solar-energy"] = {"optics", "steel-processing"},
  ["laser"] = {"optics"},
}
for tech, prerequisites in pairs(tech_map) do
  if techs[tech] then
    for p, prerequisite in ipairs(prerequisites) do
      thxbob.lib.tech.remove_prerequisite(tech, prerequisite)
      BioInd.modified_msg("prerequisite " .. prerequisite, techs[tech])
    end
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
