BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

local items = data.raw.fluid
local techs = data.raw.technology
local recipes = data.raw.recipe
local tech, item, recipe

local create_items = {}

------------------------------------------------------------------------------------
--                            Data of additional items                            --
------------------------------------------------------------------------------------
-- Resin
create_items.resin = {
  type = "item",
  name = "resin",
  icon = ICONPATH .. "resin.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "bio-bio-farm-raw",
  --~ order = "a[bi]-a-b[bi-resin]",
  order = "a[bi]-a-bb[bi-resin]",
  stack_size = 200
}


------------------------------------------------------------------------------------
--                            Create additional items                            --
------------------------------------------------------------------------------------
for i, item in pairs(create_items) do
  if not items[item.name] then
    data:extend({item})
    BioInd.created_msg(item)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
