------------------------------------------------------------------------------------
--                      Trigger: Create item "crushed stone"?                     --
--                  (BI.Triggers.BI_Trigger_Crushed_Stone_Create)                 --
------------------------------------------------------------------------------------
-- Mods: not "IndustrialRevolution"
-- Setting: BI.Settings.BI_Stone_Crushing
local trigger = "BI_Trigger_Crushed_Stone_Create"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local refinery, addit


------------------------------------------------------------------------------------
--               If the stone crusher exists, create crushed stone!               --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_items[trigger])


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
