------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Fuel"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
--~ for t_name, tech in pairs(BI.additional_techs[setting] or {}) do
  --~ data:extend({tech})
  --~ BioInd.created_msg(tech)
--~ end
BioInd.create_stuff(BI.additional_techs[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")