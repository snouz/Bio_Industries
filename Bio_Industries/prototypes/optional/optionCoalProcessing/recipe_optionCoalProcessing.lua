------------------------------------------------------------------------------------
--                             Enable: Coal processing                            --
--                        (BI.Settings.BI_Coal_Processing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Coal_Processing"
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
for r, r_data in pairs(BI.additional_recipes[setting] or {}) do
  BioInd.show(r_data.name, r_data)
end
BioInd.create_stuff(BI.additional_recipes[setting])

for r, r_data in pairs(BI.additional_recipes[setting] or {}) do
  BioInd.show(r_data.name, r_data)
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
