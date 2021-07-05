------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
local setting = "BI_Rubber"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local forbidden = {
  [BI.additional_items.BI_Rubber.resin.name] = true,
  [BI.additional_items.BI_Rubber.rubber.name] = true,
}


------------------------------------------------------------------------------------
--                                  Create items                                  --
------------------------------------------------------------------------------------
for i, i_data in pairs(BI.additional_items[setting]) do
  if not forbidden[i_data.name] then
    BioInd.create_stuff(i_data)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
