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
--                                 Create recipes                                 --
------------------------------------------------------------------------------------
--~ for r, r_data in pairs(BI.additional_recipes[setting] or {}) do
  --~ data:extend({r_data})
  --~ BioInd.created_msg(r_data)
--~ end
BioInd.create_stuff(BI.additional_recipes[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
