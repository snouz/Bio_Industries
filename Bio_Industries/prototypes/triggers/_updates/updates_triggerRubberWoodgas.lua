------------------------------------------------------------------------------------
-- Trigger: Change prerequisites of "Rubber mat" if "Wood gasification" is active --
--                      (BI.Triggers.BI_Trigger_Rubber_Woodgas)                   --
------------------------------------------------------------------------------------
-- Settings: BI.Settings.BI_Rubber and BI.Settings.BI_Wood_Gasification
local trigger = "BI_Trigger_Rubber_Woodgas"
if not BI.Triggers[trigger] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local techs = data.raw.technology
local tech, new_tech

------------------------------------------------------------------------------------
--                        Adjustments to Military science 2                       --
------------------------------------------------------------------------------------

tech = BI.additional_techs.BI_Rubber.rubber_mat
new_tech = techs[BI.additional_techs.BI_Wood_Gasification.wood_gasification.name]
--~ BioInd.debugging.writeDebug("Must add %s to prerequisites of %s!", {new_tech.name, tech and tech.name})

if new_tech then
  -- Add "Rubber mat" to prerequisites
  thxbob.lib.tech.add_prerequisite(tech.name, new_tech.name)
  BioInd.debugging.modified_msg("prerequisites", tech)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
