------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local items = data.raw.items
local recipe, item, rail


------------------------------------------------------------------------------------
--           Adjust the vanilla rails -- they are "Concrete rails" now!           --
------------------------------------------------------------------------------------
BioInd.writeDebug("Adjusting vanilla rails")
item = data.raw["rail-planner"]["rail"]
if item then
  item.order = "a[train-system]-b[rail]",
  BioInd.modified_msg("order", item)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
