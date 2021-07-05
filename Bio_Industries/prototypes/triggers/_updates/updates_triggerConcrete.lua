------------------------------------------------------------------------------------
--                     Trigger: Make tech for Refined concrete                    --
--                        (BI.Triggers.BI_Trigger_Concrete)                       --
------------------------------------------------------------------------------------
-- Settings: BI_Game_Tweaks_Recipe or BI_Rubber or BI_Stone_Crushing
local trigger = "BI_Trigger_Concrete"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local techs = data.raw.technology
local recipes = data.raw.recipe
local items = data.raw.item
local tech, prerequisite, recipe, item, old, new


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
  BioInd.modified_msg("unit", tech, "Replaced")
  BioInd.show(tech.name, tech)
end


------------------------------------------------------------------------------------
--          Make "Refined concrete" a prerequisite of "Stone crushing 3".         --
------------------------------------------------------------------------------------
tech = BI.additional_techs.BI_Stone_Crushing.stone_crushing_3
prerequisite = BI.additional_techs.BI_Trigger_Concrete.refined_concrete

if techs[tech.name] and techs[prerequisite.name] then
  thxbob.lib.tech.add_prerequisite(tech.name, prerequisite.name)
  BioInd.modified_msg("prerequisite " .. prerequisite.name, tech, "Added")
end


------------------------------------------------------------------------------------
--             Replace concrete with refined concrete in some recipes.            --
------------------------------------------------------------------------------------
old = "concrete"
new = "refined-concrete"

for r, recipe in ipairs({
  "artillery-turret", "centrifuge", "nuclear-reactor", "rocket-silo"}) do

  if recipes[recipe] then
    thxbob.lib.recipe.replace_ingredient(recipe, old, new)
    BioInd.modified_msg("ingredient " .. old, recipes[recipe], "Replaced")
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
