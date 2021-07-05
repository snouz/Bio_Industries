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
local tech, new_tech, recipe, item


------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_techs[trigger])


------------------------------------------------------------------------------------
--  Move unlocks for refined concrete/hazard concrete from "Concrete" to new tech --
------------------------------------------------------------------------------------
tech = techs["concrete"]
new_tech = BI.additional_techs.BI_Trigger_Concrete.refined_concrete

if tech then
  for r, r_name in ipairs({"refined-concrete", "refined-hazard-concrete"}) do
    recipe = recipes[r_name]

    if recipe then
      thxbob.lib.tech.remove_recipe_unlock(tech.name, r_name)
      BioInd.modified_msg("unlock for " .. r_name, tech, "Removed")

      recipe.BI_add_to_tech = {new_tech.name}
      BioInd.modified_msg("BI_add_to_tech", recipe, "Added")
    end
  end
end


--~ ------------------------------------------------------------------------------------
--~ --                          Make tech "Concrete" cheaper                          --
--~ ------------------------------------------------------------------------------------
--~ if tech then
  --~ thxbob.lib.tech.replace_unit(tech.name, {
    --~ count = 100,
    --~ ingredients = {
      --~ {"automation-science-pack", 1},
      --~ {"logistic-science-pack", 1},
    --~ },
    --~ time = 30,
  --~ })
  --~ BioInd.modified_msg("unit", tech, "Replaced")
  --~ BioInd.show(tech.name, tech)
--~ end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
