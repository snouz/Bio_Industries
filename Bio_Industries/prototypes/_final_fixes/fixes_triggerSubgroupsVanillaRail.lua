------------------------------------------------------------------------------------
--                  Trigger: Change order of vanilla rail recipe                  --
--                     (BI.Triggers.BI_Trigger_Subgroups_rail)                    --
------------------------------------------------------------------------------------
-- Mods:        "5dim_core",
-- Setting:     BI.Settings.BI_Rails
local trigger = "BI_Trigger_Subgroups_rail"
--~ if not BI.Triggers[trigger] then
  --~ BioInd.nothing_to_do("*")
  --~ return
--~ else
  BioInd.entered_file()
--~ end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local items = data.raw["rail-planner"]
local order


------------------------------------------------------------------------------------
--                     Change order of the vanilla rail recipe                    --
------------------------------------------------------------------------------------

-- Adjust order for item-subgroup from other mods
if BI.Triggers[trigger] then
  order = "[Bio_Industries]-[rails]-b[concrete]-a[rail]"

-- Adjust order for vanilla item-subgroup
else
  order = "a[train-system]-[Bio_Industries]-b[concrete]-a[rail]"
end

items["rail"].order = order
recipes["rail"].order = order


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
