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


--~ local recipe, item, entity

--~ local items = data.raw.item
local recipes = data.raw.recipe
local items = data.raw.item
local techs = data.raw.technology
local recipe, tech, entity_data, gun, old, new, amount


------------------------------------------------------------------------------------
--                  Lock shotgun and shotgun shells behind techs                  --
------------------------------------------------------------------------------------
entity_data = BI.additional_entities.BI_Darts and BI.additional_entities.BI_Darts.dart_rifle
gun = entity_data and data.raw[entity_data.type][entity_data.name]

if gun then
  -- IR makes the shotgun available right from the start. Lock it behind "Military 1".
  recipe = recipes["shotgun"]
  if recipe then
--~ BioInd.writeDebug("Trying to disable shotgun!")
    thxbob.lib.recipe.set_enabled(recipe, false)
    BioInd.modified_msg("enabled", recipe)
    recipe.BI_add_to_tech = {"military"}
--~ BioInd.show(recipe.name, recipe)
  end

  -- Lock shotgun shells behind "Scattergun turret".
  recipe = recipes["shotgun-shell"]
  if recipe then
    thxbob.lib.recipe.set_enabled(recipe, false)
    BioInd.modified_msg("enabled", recipe)
    recipe.BI_add_to_tech = {"ir2-scattergun-turret"}
  end

  -- Change prerequisites of some techs                       --
  local prerequisite_map = {
    ["ir2-scattergun-turret"]           = "ir2-bronze-milestone",
    ["weapon-shooting-speed-1"]         = "ir2-bronze-milestone",
    ["physical-projectile-damage-1"]    = "ir2-bronze-milestone",

  }
  for tech, prerequisite in pairs(prerequisite_map) do
    thxbob.lib.tech.add_prerequisite(tech, prerequisite)
    BioInd.modified_msg("prerequisites", data.raw.technology[tech])
  end

end


------------------------------------------------------------------------------------
-- If wooden rails exist, vanilla rails are renamed to "Concrete rails". We have
-- already added concrete to the recipe. Now we remove IR2's "wood-beam" and make
-- sure that they require more than just 1 gravel.
------------------------------------------------------------------------------------
BioInd.writeDebug("Change vanilla rails?")

if recipes[BI.additional_recipes.BI_Rails.rail_wood.name] then
BioInd.writeDebug("Wooden rails are active")
  recipe = recipes["rail"]
  -- Wood beam
  old = items["wood-beam"]
  new = items["steel-plate"]
  if old then
    if not new then
      thxbob.lib.recipe.remove_ingredient(recipe.name, old.name)
      BioInd.modified_msg("ingredient \"" .. item .. "\"", recipe, "Removed")
    else
      thxbob.lib.recipe.replace_ingredient(recipe.name, old.name, new.name)
      BioInd.modified_msg("ingredient \"" .. old.name .. "\"", recipe, "Replaced")
    end
  end

  local ingredients = recipe.ingredients or
                        recipe.normal and recipe.normal.ingredients or
                        recipe.expensive and recipe.expensive.ingredients
  -- Gravel
  --~ old = ingredients and BI_Functions.lib.get_recipe_ingredients(ingredients)["gravel"]
  old = ingredients and BI_Functions.lib.get_recipe_ingredients(ingredients)
  old = old and old["gravel"]
  if old and old.amount < 6 and recipes[BI.additional_recipes.BI_Rails.rail_wood.name] then
    thxbob.lib.recipe.set_ingredient(recipe.name, {"gravel", 6})
    BioInd.modified_msg("ingredient \"" .. old.name .. "\"", recipe, "Replaced")
  end
end


------------------------------------------------------------------------------------
--                         Remove redundant prerequisites                         --
------------------------------------------------------------------------------------
-- These prerequisites have become redundant because after shuffling techs around,
-- they are already required by techs that are prerequisites of the moved techs.
local map = {
  -- Technology prerequisite 'tank' on 'artillery' is redundant as 'military-4' already contains it in its prerequisite tree.
  ["artillery"] = {"tank"},

  -- Technology prerequisite 'electric-energy-distribution-2' on 'bi-tech-electric-energy-super-accumulators' is redundant as 'electric-energy-accumulators' already contains it in its prerequisite tree.
  ["bi-tech-electric-energy-super-accumulators"] = {"electric-energy-distribution-2"},

  -- Technology prerequisite 'logistics' on 'bi-tech-wooden-storage-1' is redundant as 'bi-tech-timber' already contains it in its prerequisite tree.
  ["bi-tech-wooden-storage-1"] = {"logistics"},

  -- Technology prerequisite 'ir2-electronics-1' on 'gate' is redundant as 'stone-wall' already contains it in its prerequisite tree.
  -- Technology prerequisite 'ir2-iron-motor' on 'gate' is redundant as 'stone-wall' already contains it in its prerequisite tree.
  ["gate"] = {"ir2-electronics-1", "ir2-iron-motor"},

  -- Technology prerequisite 'ir2-iron-motor' on 'gun-turret' is redundant as 'military-2' already contains it in its prerequisite tree.
  -- Technology prerequisite 'military' on 'gun-turret' is redundant as 'military-2' already contains it in its prerequisite tree.
  ["gun-turret"] = {"ir2-iron-motor", "military"},

  -- Technology prerequisite 'ir2-steel-milestone' on 'ir2-steel-wall' is redundant as 'stone-wall' already contains it in its prerequisite tree.
  ["ir2-steel-wall"] = {"ir2-steel-milestone"},

  -- Technology prerequisite 'logistics-2' on 'logistics-3' is redundant as 'production-science-pack' already contains it in its prerequisite tree.
  ["logistics-3"] = {"logistics-2"},
}
for tech_name, prerequisites in pairs(map) do
  tech = techs[tech_name]
  if tech then
    for p, prerequisite in ipairs(prerequisites) do
      thxbob.lib.tech.remove_prerequisite(tech.name, prerequisite)
      BioInd.modified_msg("prerequisite " .. prerequisite, tech, "Removed")
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
