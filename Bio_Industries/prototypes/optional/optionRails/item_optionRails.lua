------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
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
BI.entered_file("leave")
