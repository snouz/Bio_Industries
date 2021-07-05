------------------------------------------------------------------------------------
--                       Trigger: Create "wooden floor" tile                      --
--                       (BI.Triggers.BI_Trigger_Woodfloor)                       --
------------------------------------------------------------------------------------
-- Mods: "Dectorio",
local trigger = "BI_Trigger_Woodfloor"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ local techs = data.raw.technology
--~ local recipes = data.raw.recipe
--~ local items = data.raw.item
--~ local tech, new_tech, recipe, item


------------------------------------------------------------------------------------
--                               Create tiles                              --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_entities[trigger])



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
