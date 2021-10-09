------------------------------------------------------------------------------------
--                     Data for items that depend on settings.                    --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

BI.additional_items = BI.additional_items or {}

local triggers = {
  "BI_Trigger_Crushed_Stone_Create",
  "BI_Trigger_Wood_Charcoal_Create",
  "BI_Trigger_Woodpulp_Create",
}
for t, trigger in pairs(triggers) do
  BI.additional_items[trigger] = BI.additional_items[trigger] or {}
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local ICONPATHMIPS = BioInd.iconpath .. "mips/"


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                    Triggers                                    --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                      Trigger: Create item "crushed stone"?                     --
--                  (BI.Triggers.BI_Trigger_Crushed_Stone_Create)                 --
------------------------------------------------------------------------------------
-- Crushed Stone
BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone = {
  type = "item",
  name = "stone-crushed",
  icon = ICONPATH .. "crushed-stone.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ --icon_mipmaps = 4,
  --~ --pictures = {
    --~ --{ size = 64, filename = ICONPATHMIPS.."crush_1.png", scale = 0.2 },
    --~ --{ size = 64, filename = ICONPATHMIPS.."crush_2.png", scale = 0.2 },
    --~ --{ size = 64, filename = ICONPATHMIPS.."crush_3.png", scale = 0.2 },
    --~ --{ size = 64, filename = ICONPATHMIPS.."crush_4.png", scale = 0.2 }
  --~ --},
  --~ subgroup = "raw-material",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  order = "a[bi]-a-z[stone-crushed]",
  -- Order for "DeadlockCrating"
  order_crating = "c[stone-crushing]-[products]-a[stone-crushed]",
  stack_size = 400
}
BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone.pictures = BioInd.add_pix("crush", 4)



------------------------------------------------------------------------------------
--                      Trigger: Create item "wood-charcoal"?                     --
--                  (BI.Triggers.BI_Trigger_Wood_Charcoal_Create)                 --
------------------------------------------------------------------------------------
-- Charcoal
BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal = {
  type = "item",
  name = "wood-charcoal",
  icon = ICONPATH .. "charcoal.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  fuel_value = "6MJ",
  fuel_category = "chemical",
  --~ -- subgroup = "raw-material",
  subgroup = "raw-resource",
  --~ -- subgroup = "bio-bio-farm-raw",
  --~ -- order = "a[bi]-a-c[charcoal]",
  order = "b[charcoal]",
  -- Order for "DeadlockCrating"
  order_crating = "b[cokery]-a[wood-charcoal]",
  --~ -- stack_size = 400,
  stack_size = 200,
}
BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal.pictures = BioInd.add_pix("charcoal", 4)




------------------------------------------------------------------------------------
--                        Trigger: Create item "wood pulp"?                       --
--                    (BI.Triggers.BI_Trigger_Woodpulp_Create)                    --
------------------------------------------------------------------------------------
-- Wood Pulp
BI.additional_items.BI_Trigger_Woodpulp_Create.woodpulp = {
  type = "item",
  name = "bi-woodpulp",
  icon = ICONPATH .. "woodpulp.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  fuel_value = "1MJ",
  fuel_category = "chemical",
  --~ --subgroup = "raw-material",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ -- order = "a-b[bi-woodpulp]",
  order = "x[bi]-a[wood-production]-[products]-aa[bi-woodpulp]",
  -- Order for "DeadlockCrating"
  order_crating = "a[wood-production]-b[products]-aa[bi-woodpulp]",
  stack_size = 800
}
BI.additional_items.BI_Trigger_Woodpulp_Create.woodpulp.pictures = BioInd.add_pix("woodpulp", 4)


-- Status report
BioInd.debugging.readdata_msg(BI.additional_items, triggers, "optional items", "trigger")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
