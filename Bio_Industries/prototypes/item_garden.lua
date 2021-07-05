local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

-------- Bio Garden

data:extend({

    {
    type = "item",
    name = "bi-bio-garden",
    icon = ICONPATH .. "entity/bio_garden_icon.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
        --~ {
            --~ icon = ICONPATH .. "bio_garden_icon.png",
            --~ icon_size = 64,
        --~ }
    --~ },
    subgroup = "production-machine",
    order = "x[bi]-b[bi-bio-garden1]",
    place_result = "bi-bio-garden",
    stack_size = 10
  },
  {
    type = "item",
    name = "bi-bio-garden-large",
    icon = ICONPATH .. "entity/bio_garden_large_icon.png",
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
    icon = ICONPATH .. "entity/bio_garden_huge_icon.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-b[bi-bio-garden3]",
    place_result = "bi-bio-garden-huge",
    stack_size = 10
  },

  {
    type = "item",
    name = "bi-purified-air",
    icon = ICONPATH .. "Clean_Air2.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
        --~ {
            --~ icon = ICONPATH .. "Clean_Air2.png",
            --~ icon_size = 64,
        --~ }
    --~ },
    flags = {"hidden"},
    subgroup = "bio-bio-gardens-fluid",
    order = "bi-purified-air",
    stack_size = 100
  },
})
