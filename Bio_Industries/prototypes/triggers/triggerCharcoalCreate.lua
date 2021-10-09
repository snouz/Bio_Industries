------------------------------------------------------------------------------------
--                      Trigger: Create item "wood-charcoal"?                     --
--                  (BI.Triggers.BI_Trigger_Wood_Charcoal_Create)                 --
------------------------------------------------------------------------------------
-- Mods: not "IndustrialRevolution"
-- Setting: BI.Settings.BI_Coal_Processing
local trigger = "BI_Trigger_Wood_Charcoal_Create"
if not BI.Triggers[trigger] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ local items = data.raw.item
--~ local refinery, addit


------------------------------------------------------------------------------------
--               If the stone crusher exists, create crushed stone!               --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_items[trigger])


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
