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
  subgroup = BI.default_item_subgroup.biofarm.name,
  --~ order = "x[bi]-ab[bi-bio-farm]",
  order = "x[bi]-a[wood-production]-[buildings]-b[bi-bio-farm]",
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
  subgroup = BI.default_item_subgroup.biofarm.name,
  --~ order = "x[bi]-aa[bi-bio-greenhouse]",
  order = "x[bi]-a[wood-production]-[buildings]-a[bi-bio-greenhouse]",
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
  subgroup = BI.default_item_subgroup.biofarm.name,
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
  subgroup = BI.default_item_subgroup.biofarm.name,
  order = "x[bi]-b[bi-cokery]",
  place_result = "bi-cokery",
  stack_size = 10
}

--~ -- Pollution sensor
--~ BI.default_items.pollution_sensor = {
  --~ type = "item",
  --~ name = "bi-pollution-sensor",
  --~ icon = ICONPATH .. "entity/pollution_sensor.png",
  --~ icon_size = 64, icon_mipmaps = 3,
  --~ BI_add_icon = true,
  --~ subgroup = "circuit-network",
  --~ order = "c[combinators]-cb[pollution-detector]",
  --~ place_result = "bi-pollution-sensor",
  --~ stack_size = 50,
  --~ -- Group/subgroup if "5Dim's mod - New Core" is used
  --~ group_5d = "logistic",
  --~ subgroup_5d = "logistic-comb",
--~ --  subgroup_order_5d = "n-a",
  --~ order_5d = "d-[Bio_Industries]-[combinators]-[bi-pollution-sensor]",
--~ }


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
  category = BI.default_recipe_categories.greenhouse.name,
  --~ subgroup = "raw-material",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "a-a2[bi-seed]",
  order = "x[bi]-a[wood-production]-[growing]-a[bi-seed]",
  -- Order for "DeadlockCrating"
  order_crating = "a[wood-production]-a[growing]-a[bi-seed]",
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
  --~ subgroup = "raw-material",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "a-a2[bi-seedling]",
  order = "x[bi]-a[wood-production]-[growing]-b[bi-seedling]",
  -- Order for "DeadlockCrating"
  order_crating = "a[wood-production]-a[growing]-b[bi-seedling]",
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
  --~ subgroup = "raw-material",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "a-b[bi-woodpulp]",
  order = "x[bi]-a[wood-production]-[products]-aa[bi-woodpulp]",
  -- Order for "DeadlockCrating"
  order_crating = "a[wood-production]-b[products]-aa[bi-woodpulp]",
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
  --~ subgroup = "raw-material",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "a[bi]-a-d[bi-woodbrick]",
  order = "x[bi]-a[wood-production]-[products]-ab[wood-bricks]",
  -- Order for "DeadlockCrating"
  order_crating = "a[wood-production]-b[products]-ab[wood-bricks]",
  fuel_category = "chemical",
  fuel_value = "20MJ",
  stack_size = 200
}

-- Fertilizer
BI.default_items.fertilizer = {
  type = "item",
  name = "fertilizer",
  localised_name = {"item-name.fertilizer"},
  localised_description = {"item-description.fertilizer"},
  icon = ICONPATH .. "fertilizer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ subgroup = "intermediate-product",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "b[fertilizer]",
  order = "x[bi]-a[wood-production]-[growing]-d1[fertilizer]",
  -- Order for "DeadlockCrating"
  order_crating = "a[wood-production]-a[growing]-d1[fertilizer]",
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
  localised_name = {"item-name.bi-adv-fertilizer"},
  localised_description = {"item-description.bi-adv-fertilizer"},
  icon = ICONPATH .. "fertilizer_advanced.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ subgroup = "intermediate-product",
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "b[fertilizer]-b[bi-adv-fertilizer]",
  order = "x[bi]-a[wood-production]-[growing]-d2[bi-adv-fertilizer]",
  -- Order for "DeadlockCrating"
  order_crating = "a[wood-production]-a[growing]-d2[bi-adv-fertilizer]",
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
