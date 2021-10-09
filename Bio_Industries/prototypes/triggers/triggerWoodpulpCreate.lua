------------------------------------------------------------------------------------
--                        Trigger: Create item "wood pulp"?                       --
--                    (BI.Triggers.BI_Trigger_Woodpulp_Create)                    --
------------------------------------------------------------------------------------
-- Mods: not "IndustrialRevolution"
local trigger = "BI_Trigger_Woodpulp_Create"
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
--                                Create the item!                                --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_items[trigger])


------------------------------------------------------------------------------------
--                 Create base recipe to make woodpulp from wood!                 --
--          (IR2's recipe yields twice as much pulp for the same input.)          --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_recipes[trigger])


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
