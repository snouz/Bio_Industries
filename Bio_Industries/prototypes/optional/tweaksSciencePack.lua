------------------------------------------------------------------------------------
--           Game tweaks: Alternative recipe for Production Science Pack          --
--                 (BI.Settings.BI_Game_Tweaks_Production_Science)                --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Production_Science"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local item = BI.additional_items.BI_Rails.rail_wood


------------------------------------------------------------------------------------
-- Add alternative Production Science Pack using wooden instead of regular rails. --
------------------------------------------------------------------------------------
--~ recipe = BI.additional_recipes[setting].production_science_pack
--~ data:extend({recipe})
--~ BioInd.created_msg(recipe)
-- This will only work if wooden rails are enabled!
if data.raw[item.type][item.name] then
  BioInd.create_stuff(BI.additional_recipes[setting].production_science_pack)
else
  BioInd.writeDebug("Can't create recipe %s because %ss have been turned off!", {
    BI.additional_recipes[setting].production_science_pack.name,
    BI.additional_items.BI_Rails.rail_wood.name
  })
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
