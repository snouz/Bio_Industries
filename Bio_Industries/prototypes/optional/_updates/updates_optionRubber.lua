------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
local setting = "BI_Rubber"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

BI.additional_entities = BI.additional_entities or {}
BI.additional_entities[setting] = BI.additional_entities[setting] or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local item, resin


------------------------------------------------------------------------------------
--                                   Create items                                 --
------------------------------------------------------------------------------------
-- Resin
item = BI.additional_items.BI_Rubber.resin
-- Check if we need to create resin
if not items[item.name] then
  BioInd.create_stuff(item)

-- Otherwise adjust icon and localization
else
  resin = items[item.name]
  BioInd.BI_change_icon(resin, item.icon)
  BioInd.modified_msg("icon", resin)

  resin.localised_name = {"item-name.bi-resin"}
  resin.localised_description = {"item-description.bi-resin"}
  BioInd.modified_msg("localization", resin)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
