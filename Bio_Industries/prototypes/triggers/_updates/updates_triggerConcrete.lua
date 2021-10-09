------------------------------------------------------------------------------------
--                     Trigger: Make tech for Refined concrete                    --
--                        (BI.Triggers.BI_Trigger_Concrete)                       --
------------------------------------------------------------------------------------
-- Settings: BI_Game_Tweaks_Recipe or BI_Rubber or BI_Stone_Crushing
local trigger = "BI_Trigger_Concrete"
if not BI.Triggers[trigger] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local techs = data.raw.technology
local recipes = data.raw.recipe
local items = data.raw.item
local tech, prerequisite, recipe, item, old, new
local ingredients, hazard, amount, amount_a



------------------------------------------------------------------------------------
--                          Make tech "Concrete" cheaper                          --
------------------------------------------------------------------------------------
tech = techs["concrete"]
if tech then
  thxbob.lib.tech.replace_unit(tech.name, {
    count = 100,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  })
  BioInd.debugging.modified_msg("unit", tech, "Replaced")
  BioInd.debugging.show(tech.name, tech)
end


------------------------------------------------------------------------------------
--          Make "Refined concrete" a prerequisite of "Stone crushing 3".         --
------------------------------------------------------------------------------------
tech = BI.additional_techs.BI_Stone_Crushing.stone_crushing_3
-- Let's use IR2's tech for refined concrete if it's active!
prerequisite = mods["IndustrialRevolution"] and techs["ir2-concrete-2"] or
                BI.additional_techs.BI_Trigger_Concrete.refined_concrete

if tech and prerequisite and techs[tech.name] and techs[prerequisite.name] then
  thxbob.lib.tech.add_prerequisite(tech.name, prerequisite.name)
  BioInd.debugging.modified_msg("prerequisite " .. prerequisite.name, tech, "Added")
end


------------------------------------------------------------------------------------
--        Replace concrete with refined (hazard) concrete in some recipes.        --
------------------------------------------------------------------------------------
-- IR2 already replaces concrete with refined concrete in these recipes!
old = mods["IndustrialRevolution"] and "refined-concrete" or "concrete"
new = "refined-concrete"
hazard = "refined-hazard-concrete"

for r, recipe in ipairs({
  "artillery-turret", "centrifuge", "nuclear-reactor", "rocket-silo"}) do

  if recipes[recipe] then
    for d, difficulty in pairs({"normal", "expensive"}) do
      ingredients = BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, difficulty)

      amount = ingredients[old] and ingredients[old].amount

      if amount then
        amount_a = math.floor(amount * 0.9)
        if amount_a == 0 then
          amount_a = 1
        end
        if amount ~= amount_a then
          -- Remove old ingredient
          thxbob.lib.recipe.remove_difficulty_ingredient(recipe, difficulty, old)
          -- Replace with 90% new ingredient …
          thxbob.lib.recipe.add_difficulty_ingredient(recipe, difficulty, {new, amount_a})
          -- … and 10% new hazard variety
          thxbob.lib.recipe.add_difficulty_ingredient(recipe, difficulty, {hazard, amount - amount_a})
  BioInd.debugging.writeDebug("Replaced %s in ingredients for difficulty %s of %s: %s",
                    {old, difficulty, recipe, recipes[recipe][difficulty].ingredients})
        end
      end
    end
  end
end


------------------------------------------------------------------------------------
--         Use tech "refined concrete" tech as prerequisite of some techs.        --
------------------------------------------------------------------------------------
old = "concrete"
new = BI.additional_techs.BI_Trigger_Concrete.refined_concrete and
      BI.additional_techs.BI_Trigger_Concrete.refined_concrete.name

if new then
  -- Replace "concrete" with "refined concrete"
  --~ for t, tech in ipairs({"artillery", "uranium-processing", "nuclear-power", "rocket-silo"}) do
  for t, tech in ipairs({"uranium-processing", "nuclear-power", "rocket-silo"}) do
    if techs[tech] then
      thxbob.lib.tech.replace_prerequisite(tech, old, new)
      BioInd.debugging.writeDebug("Replaced prerequisite %s of tech %s with %s", {old, tech, new})
    end
  end

  -- Add "refined concrete" as new prerequisite
  for t, tech in ipairs({"artillery"}) do
    if techs[tech] then
      thxbob.lib.tech.add_prerequisite(tech, new)
      BioInd.debugging.writeDebug("Added %s to prerequisites of tech %s", {new, tech})
    end
  end

end


------------------------------------------------------------------------------------
--       Add hazard concrete to ingredients of some recipes using concrete.       --
------------------------------------------------------------------------------------
old = "concrete"
hazard = "hazard-concrete"

for r, recipe in ipairs({
  BI.additional_recipes.BI_Bio_Fuel.bio_boiler.name,
  BI.additional_recipes.BI_Power_Production.huge_accumulator.name,
  BI.additional_recipes.BI_Power_Production.huge_substation.name,
  BI.additional_recipes.BI_Power_Production.solar_farm.name,
  BI.additional_recipes.Bio_Cannon.bio_cannon.name,
}) do

  if recipes[recipe] then
    for d, difficulty in pairs({"normal", "expensive"}) do
      ingredients = BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, difficulty)

      amount = ingredients[old] and ingredients[old].amount
      if amount then
        amount_a = math.floor(amount * 0.9)
        amount_a = (amount_a == 0) and 1 or amount_a

        if amount ~= amount_a then
          -- Set amount of old ingredient to 90% …
          thxbob.lib.recipe.set_difficulty_ingredient(recipe, difficulty, {old, amount_a})
          -- … and replace the 10% with the hazard variety
          thxbob.lib.recipe.add_difficulty_ingredient(recipe, difficulty, {hazard, amount - amount_a})
BioInd.debugging.writeDebug("Replaced %s in ingredients for difficulty %s of %s: %s",
                  {old, difficulty, recipe, recipes[recipe][difficulty].ingredients})
        end
      end
    end
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
