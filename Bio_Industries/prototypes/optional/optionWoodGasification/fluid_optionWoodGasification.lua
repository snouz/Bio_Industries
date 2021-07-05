------------------------------------------------------------------------------------
--                            Enable: Wood gasification                           --
--                       (BI.Settings.BI_Wood_Gasification)                       --
------------------------------------------------------------------------------------
local setting = "BI_Wood_Gasification"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                  Create fluids                                  --
------------------------------------------------------------------------------------
for f, f_data in pairs(BI.additional_fluids[setting] or {}) do
  -- Only create these fluids if no other mod has done so yet!
  if not data.raw.fluid[f_data.name] then
    BioInd.create_stuff(f_data)
  end
end
--~ BioInd.create_stuff(BI.additional_fluids[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
