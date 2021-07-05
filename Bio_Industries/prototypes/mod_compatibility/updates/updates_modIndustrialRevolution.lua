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

-- Adjust localization of remnants
prototype = data.raw.corpse[BI.additional_remnants.BI_Wood_Products.big_pole.name]
if prototype then
  prototype.localised_name = {"entity-name.bi-wooden-pole-bigger-remnant"}
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
-- Replace in ingredients (all difficulties)
thxbob.lib.recipe.replace_ingredient_in_all(i_old, i_new)
BioInd.writeDebug("Exchanged \"%s\" in ingredients of all recipes with %s:\t%s",
                  {i_old, i_new, recipe})

-- Replace in results (all difficulties)
thxbob.lib.recipe.replace_result_in_all(i_old, i_new)
BioInd.writeDebug("Exchanged \"%s\" in ingredients of all recipes with %s:\t%s",
                  {i_old, i_new, recipe})



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
      --~ recipe.localised_name = {
        --~ "recipe-name.bi-crushed-stone-IR",
        --~ {"item-name." .. r_data.item}
      --~ }
      recipe.localised_name = {
        "recipe-name.bi-crushed-stone",
        {"item-name.gravel"},
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
-- the recipes that can be made by IR2's Copper crusher ("grinding", "grinding-1")
-- and Electric crusher ("grinding-2").
------------------------------------------------------------------------------------
local crusher = BI.additional_entities.BI_Stone_Crushing.stone_crusher
crusher = crusher and data.raw[crusher.type][crusher.name]

if crusher then
  for c, category in ipairs({
    "grinding", "grinding-1", "grinding-2",
  }) do

    crusher.crafting_categories[#crusher.crafting_categories + 1] = category
    BioInd.modified_msg("category \"" .. category .. "\"", crusher, "Added")
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
