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
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_techs[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
