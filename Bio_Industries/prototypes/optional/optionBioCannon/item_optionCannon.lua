------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
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
for i, i_data in pairs(BI.additional_items[setting] or {}) do
  -- Don't create the Poison artillery shell yet -- other mods may have created one!
  if i_data.name ~= BI.additional_items[setting].poison_artillery_shell.name then
    BioInd.create_stuff(i_data)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
