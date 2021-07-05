------------------------------------------------------------------------------------
--  Trigger: Change prerequisites of "Military 2" (depends on "Rubber" + "Darts") --
--                      (BI.Triggers.BI_Trigger_Rubber_Darts)                     --
------------------------------------------------------------------------------------
-- Settings: BI.Settings.BI_Rubber and BI.Settings.BI_Darts/NE Buildings
local trigger = "BI_Trigger_Rubber_Darts"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local techs = data.raw.technology
local tech, new_tech

------------------------------------------------------------------------------------
--                        Adjustments to Military science 2                       --
------------------------------------------------------------------------------------

new_tech = BI.additional_techs.BI_Rubber.rubber_mat
tech = techs["military-2"]
--~ BioInd.writeDebug("Must add %s to prerequisites of %s!", {new_tech.name, tech and tech.name})

if tech then
  -- Add "Rubber mat" to prerequisites
  thxbob.lib.tech.add_prerequisite(tech.name, new_tech.name)
  BioInd.modified_msg("prerequisites", tech)

  for p, prerequisite in ipairs({"logistic-science-pack", "military", "steel-processing"}) do
    thxbob.lib.tech.remove_prerequisite(tech.name, prerequisite)
    BioInd.modified_msg("prerequisites", tech, "Removed")
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
