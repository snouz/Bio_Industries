------------------------------------------------------------------------------------
--                             Enable: Coal processing                            --
--                        (BI.Settings.BI_Coal_Processing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Coal_Processing"
if (not BI.Settings[setting]) or BioInd.check_mods({
  -- These mods provide their own coal processing techs -- use them instead of ours!
  "pycoalprocessing",
  "pyrawores",
}) then
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
-- for t_name, tech in pairs(BI.additional_techs[setting] or {}) do
  -- data:extend({tech})
  -- BioInd.created_msg(tech)
--end
BioInd.create_stuff(BI.additional_techs[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")