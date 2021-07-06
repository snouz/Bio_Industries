------------------------------------------------------------------------------------
--                           Enable: Disassemble recipes                          --
--                          (BI.Settings.BI_Disassemble)                          --
------------------------------------------------------------------------------------
local setting = "BI_Disassemble"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                               Create groups etc.                               --
------------------------------------------------------------------------------------
--~ for m, m_data in pairs(BI.additional_misc[setting] or {}) do
  --~ data:extend({m_data})
  --~ BioInd.created_msg(m_data)
--~ end
BioInd.create_stuff(BI.additional_categories[setting])


------------------------------------------------------------------------------------
--                                 Create recipes                                 --
------------------------------------------------------------------------------------
--~ for r, r_data in pairs(BI.additional_recipes[setting]) do
  --~ data:extend({r_data})
  --~ BioInd.created_msg(r_data)
--~ end
BioInd.create_stuff(BI.additional_recipes[setting])

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")