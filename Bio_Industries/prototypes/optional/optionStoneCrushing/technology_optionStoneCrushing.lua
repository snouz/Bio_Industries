------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Stone_Crushing"
if not BI.Settings[setting] then
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
