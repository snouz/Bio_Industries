------------------------------------------------------------------------------------
--                  Enable: Bio power production and distribution                 --
--                        (BI.Settings.BI_Power_Production)                       --
------------------------------------------------------------------------------------
local setting = "BI_Power_Production"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                  Create items                                  --
------------------------------------------------------------------------------------
--~ for i, i_data in pairs(BI.additional_items[setting] or {}) do
  --~ data:extend({i_data})
  --~ BioInd.created_msg(i_data)
--~ end
BioInd.create_stuff(BI.additional_items[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
