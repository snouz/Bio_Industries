BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

------------------------------------------------------------------------------------
--                                   Bio Gardens                                  --
------------------------------------------------------------------------------------

-- Gardens
data:extend({
    {
    type = "item",
    name = "bi-bio-garden",
    icon = ICONPATH .. "entity/garden_3x3.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-b[bi-bio-garden1]",
    place_result = "bi-bio-garden",
    stack_size = 10
  },
  {
    type = "item",
    name = "bi-bio-garden-large",
    icon = ICONPATH .. "entity/garden_9x9.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-b[bi-bio-garden2]",
    place_result = "bi-bio-garden-large",
    stack_size = 10
  },
  {
    type = "item",
    name = "bi-bio-garden-huge",
    icon = ICONPATH .. "entity/garden_27x27.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-b[bi-bio-garden3]",
    place_result = "bi-bio-garden-huge",
    stack_size = 10
  },
})

-- Purified air (This will never be created -- we just need it for the crafting icon!)
data:extend({
  {
    type = "item",
    name = "bi-purified-air",
    icon = ICONPATH .. "clean-air.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"hidden"},
    subgroup = "bio-bio-gardens-fluid",
    order = "bi-purified-air",
    stack_size = 1
  },
})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
