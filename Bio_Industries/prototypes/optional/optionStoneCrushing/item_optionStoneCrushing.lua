------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Stone_Crushing"
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
  --~ -- We don't want to create crushed stone yet! There may be mods that provide
  --~ -- alternatives (e.g. IR2: gravel)
  --~ if i_data.name  ~= BI.additional_items.BI_Stone_Crushing.crushed_stone.name then
    --~ BioInd.create_stuff(i_data)
  --~ end
--~ end
    BioInd.create_stuff(BI.additional_items[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
