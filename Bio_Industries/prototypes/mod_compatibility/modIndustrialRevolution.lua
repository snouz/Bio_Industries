------------------------------------------------------------------------------------
--                             Industrial Revolution 2                            --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
-- We only want to create crushed stone if IR2 is NOT active!
if BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item


------------------------------------------------------------------------------------
--               If the stone crusher exists, create crushed stone!               --
------------------------------------------------------------------------------------
if items[BI.additional_items.BI_Stone_Crushing.stone_crusher.name] then
  BioInd.create_stuff(BI.additional_items.BI_Stone_Crushing.crushed_stone)
else
  BioInd.nothing_to_do("")
end

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
