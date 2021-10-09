------------------------------------------------------------------------------------
--        Trigger: Replace concrete/refined concrete techs in prerequisites       --
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
local old_tech, new_tech, recipe, item

------------------------------------------------------------------------------------
--                  Use concrete techs from IR2 as prerequisites                  --
------------------------------------------------------------------------------------
if mods["IndustrialRevolution"] then

  local replace = {["concrete"] = "ir2-concrete-1"}
  if BI.additional_techs.BI_Trigger_Concrete.refined_concrete then
    replace[BI.additional_techs.BI_Trigger_Concrete.refined_concrete.name] = "ir2-concrete-2"
  end

  for tech_name, tech in pairs(techs) do
    for old, new in pairs(replace) do
      thxbob.lib.tech.replace_prerequisite(tech_name, old, new)
      BioInd.debugging.writeDebug("Replaced prerequisite \"%s\" of tech \"%s\" with \"%s\"",
                                  {old, tech_name, new})
    end
  end

end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
