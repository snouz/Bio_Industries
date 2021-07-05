BioInd.entered_file()

BI.default_items = BI.default_items or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local ICONPATHMIPS = BioInd.iconpath .. "mips/"


------------------------------------------------------------------------------------
--                               Items for entities                               --
------------------------------------------------------------------------------------
-- Bio Farm
BI.default_items.bio_farm = {
  type= "item",
  name= "bi-bio-farm",
  localised_name = {"entity-name.bi-bio-farm"},
  localised_description = {"entity-description.bi-bio-farm"},
  icon = ICONPATH .. "entity/biofarm.png",
  icon_size = 64,  icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-ab[bi-bio-farm]",
  place_result = "bi-bio-farm",
  stack_size = 10,
}

-- Bio Nursery (Greenhouse)
BI.default_items.bio_greenhouse = {
  type= "item",
  name= "bi-bio-greenhouse",
  localised_name = {"entity-name.bi-bio-greenhouse"},
  localised_description = {"entity-description.bi-bio-greenhouse"},
  icon = ICONPATH .. "entity/greenhouse.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-aa[bi-bio-greenhouse]",
  place_result = "bi-bio-greenhouse",
  stack_size= 10,
}

-- BioReactor
BI.default_items.bio_reactor = {
  type = "item",
  name = "bi-bio-reactor",
  icon = ICONPATH .. "entity/bioreactor.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "z[bi]-a[bi-bio-reactor]",
  place_result = "bi-bio-reactor",
  stack_size = 10
}

-- Cokery
BI.default_items.cokery = {
  type = "item",
  name = "bi-cokery",
  icon = ICONPATH .. "entity/cokery.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-b[bi-cokery]",
  place_result = "bi-cokery",
  stack_size = 10
}


------------------------------------------------------------------------------------
--                                   Seeds and seedlings                              --
------------------------------------------------------------------------------------
-- Seed
BI.default_items.seed = {
  type = "item",
  name = "bi-seed",
  icon = ICONPATH .. "tree_seed.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ --  icon_mipmaps = 4,
  --~ --  pictures = {
    --~ --  { size = 64, filename = ICONPATHMIPS.."bio_seed_1.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."bio_seed_2.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."bio_seed_3.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."bio_seed_4.png", scale = 0.25 }
  --~ --  },
  category = "biofarm-mod-greenhouse",
  subgroup = "raw-material",
  order = "a-a2[bi-seed]",
  --fuel_value = "0.5MJ",
  --fuel_category = "chemical",
  stack_size = 800,
}
BI.default_items.seed.pictures = BioInd.add_pix("bio_seed", 4)

-- Seedling
BI.default_items.seedling = {
  type = "item",
  name = "seedling",
  localised_name = {"entity-name.seedling"},
  --localised_description = {"entity-description.seedling"},
  icon = ICONPATH .. "seedling.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ --  pictures = {
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_1.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_2.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_3.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_4.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_5.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_6.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_7.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_8.png", scale = 0.25 },
    --~ --  { size = 64, filename = ICONPATHMIPS.."seedling_9.png", scale = 0.25 }
  --~ --  },
  subgroup = "raw-material",
  order = "a-a2[bi-seedling]",
  place_result = "seedling",
  --fuel_value = "0.5MJ",
  --fuel_category = "chemical",
  stack_size = 400,
}
BI.default_items.seedling.pictures = BioInd.add_pix("seedling", 9)


------------------------------------------------------------------------------------
--                              Intermediate products                             --
------------------------------------------------------------------------------------
--~ -- Ash
--~ BI.default_items.ash = {
  --~ type = "item",
  --~ name = "bi-ash",
  --~ icon = ICONPATH .. "ash.png",
  --~ icon_size = 64, icon_mipmaps = 3,
  --~ BI_add_icon = true,
  --~ subgroup = "raw-material",
  --~ order = "a[bi]-a-b[bi-ash]",
  --~ stack_size = 400
--~ }
--~ BI.default_items.ash.pictures = BioInd.add_pix("ash", 4)

-- Wood Pulp
BI.default_items.woodpulp = {
  type = "item",
  name = "bi-woodpulp",
  icon = ICONPATH .. "woodpulp.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  fuel_value = "1MJ",
  fuel_category = "chemical",
  subgroup = "raw-material",
  order = "a-b[bi-woodpulp]",
  stack_size = 800
}
BI.default_items.woodpulp.pictures = BioInd.add_pix("woodpulp", 4)

-- Wood Bricks
BI.default_items.wood_bricks = {
  type = "item",
  name = "wood-bricks",
  icon = ICONPATH .. "fuel_brick.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "raw-material",
  order = "a[bi]-a-d[bi-woodbrick]",
  fuel_category = "chemical",
  fuel_value = "20MJ",
  stack_size = 200
}

-- Fertilizer
BI.default_items.fertilizer = {
  type = "item",
  name = "fertilizer",
  icon = ICONPATH .. "fertilizer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "intermediate-product",
  order = "b[fertilizer]",
  stack_size = 200,
  -- 0.18.31/1.1.1: Moved to data-final-fixes.lua because we changed the name
  -- from "fertiliser" to "fertilizer" and now PyAlienLife removes place_as_tile!
  --~ place_as_tile = {
    --~ result = "vegetation-green-grass-3",
    --~ condition_size = 1,
    --~ condition = { "water-tile" }
  --~ },
}

-- Advanced fertilizer
BI.default_items.adv_fertilizer = {
  type = "item",
  name = "bi-adv-fertilizer",
  icon = ICONPATH .. "fertilizer_advanced.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "intermediate-product",
  order = "b[fertilizer]-b[bi-adv-fertilizer]",
  stack_size = 200,
  -- 0.18.31/1.1.1: Moved to data-final-fixes.lua because we changed the name
  -- from "bi-adv-fertiliser" to "bi-adv-fertilizer" and now PyAlienLife removes
  -- place_as_tile!
  --~ place_as_tile = {
    --~ result = "vegetation-green-grass-1",
    --~ condition_size = 1,
    --~ condition = { "water-tile" }
  --~ },
}


------------------------------------------------------------------------------------
--                                  Create items                                  --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_items)

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
