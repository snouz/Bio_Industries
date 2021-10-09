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
local tech, new_tech, recipe, item


------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
if not mods["IndustrialRevolution"] then
  BioInd.create_stuff(BI.additional_techs[trigger])
end

------------------------------------------------------------------------------------
--  Move unlocks for refined concrete/hazard concrete from "Concrete" to new tech --
------------------------------------------------------------------------------------
tech = techs["concrete"]
new_tech = BI.additional_techs.BI_Trigger_Concrete.refined_concrete

if tech and new_tech then
  for r, r_name in ipairs({"refined-concrete", "refined-hazard-concrete"}) do
    recipe = recipes[r_name]

    if recipe then
      thxbob.lib.tech.remove_recipe_unlock(tech.name, r_name)
      BioInd.debugging.modified_msg("unlock for " .. r_name, tech, "Removed")

      recipe.BI_add_to_tech = {new_tech.name}
      BioInd.debugging.modified_msg("BI_add_to_tech", recipe, "Added")
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
