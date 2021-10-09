------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
local setting = "BI_Rubber"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Perhaps some other mod will create these. We'll see in data-updates!
local create_later = {
  [BI.additional_items.BI_Rubber.resin.name] = true,
  [BI.additional_items.BI_Rubber.rubber.name] = true,
}


------------------------------------------------------------------------------------
--                                  Create items                                  --
------------------------------------------------------------------------------------
for i, i_data in pairs(BI.additional_items[setting]) do
  if not create_later[i_data.name] then
    BioInd.create_stuff(i_data)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
