BioInd.entered_file()

BI.additional_items = BI.additional_items or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath

local items = data.raw.fluid
local techs = data.raw.technology
local recipes = data.raw.recipe
local tech, item, recipe


------------------------------------------------------------------------------------
--                            Data of additional items                            --
------------------------------------------------------------------------------------
--~ -- Resin
--~ BI.additional_items.resin = {
  --~ type = "item",
  --~ name = "resin",
  --~ icon = ICONPATH .. "resin.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ subgroup = "bio-bio-farm-raw",
  --  order = "a[bi]-a-b[bi-resin]",
  --~ order = "a[bi]-a-bb[bi-resin]",
  --~ stack_size = 200
--~ }

-- Ash
BI.additional_items.ash = {
  type = "item",
  name = "bi-ash",
  icon = ICONPATH .. "ash.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ fuel_value = "1MJ",
  --~ fuel_category = "chemical",
  subgroup = "raw-material",
  order = "a[bi]-a-b[bi-ash]",
  stack_size = 400
}
BI.additional_items.ash.pictures = BioInd.add_pix("ash", 4)


-- Status report
BioInd.readdata_msg(BI.additional_items, nil, "additional items")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
