------------------------------------------------------------------------------------
--                          Enable: Bigger wooden chests                          --
--                      (BI.Settings.BI_Bigger_Wooden_Chests)                     --
------------------------------------------------------------------------------------
local setting = "BI_Bigger_Wooden_Chests"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ BioInd.writeDebug("Creating items for bigger wooden chests!")

--~ data:extend({
  --~ --- Large wooden chest 2 x 2
  --~ {
    --~ type = "item",
    --~ name = "bi-wooden-chest-large",
    --~ localised_name = {"entity-name.bi-wooden-chest-large"},
    --~ localised_description = {"entity-description.bi-wooden-chest-large"},
    --~ icon = ICONPATH .. "entity/large_wooden_chest_icon.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ --fuel_category = "chemical",
    --~ --fuel_value = "32MJ",
    --~ subgroup = "storage",
    --~ order = "a[items]-d[bigchest]",
    --~ place_result = "bi-wooden-chest-large",
    --~ stack_size = 48,
  --~ },

  --~ -- Huge wooden chest 3 x 3
  --~ {
    --~ type = "item",
    --~ name = "bi-wooden-chest-huge",
    --~ localised_name = {"entity-name.bi-wooden-chest-huge"},
    --~ localised_description = {"entity-description.bi-wooden-chest-huge"},
    --~ icon = ICONPATH .. "entity/huge_wooden_chest_icon.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ --fuel_category = "chemical",
    --~ --fuel_value = "200MJ",
    --~ subgroup = "storage",
    --~ order = "a[items]-e[hugechest]",
    --~ place_result = "bi-wooden-chest-huge",
    --~ stack_size = 32,
  --~ },

  --~ -- Gigantic wooden chest 6 x 6
  --~ {
    --~ type = "item",
    --~ name = "bi-wooden-chest-giga",
    --~ localised_name = {"entity-name.bi-wooden-chest-giga"},
    --~ localised_description = {"entity-description.bi-wooden-chest-giga"},
    --~ icon = ICONPATH .. "entity/giga_wooden_chest_icon.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ --fuel_category = "chemical",
    --~ --fuel_value = "400MJ",
    --~ subgroup = "storage",
    --~ order = "a[items]-f[gigachest]",
    --~ place_result = "bi-wooden-chest-giga",
    --~ stack_size = 16
  --~ },
--~ })


------------------------------------------------------------------------------------
--                                  Create items                                  --
------------------------------------------------------------------------------------
for i, i_data in pairs(BI.optional_items[setting] or {}) do
  data:extend({i_data})
  BioInd.created_msg(i_data)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
