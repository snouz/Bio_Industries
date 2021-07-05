BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath
local ICONPATHMIPS = BioInd.iconpath .. "mips/"

local item

------------------------------------------------------------------------------------
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
local function add_pix(icon, count)
  local ret = {}
  for i = 1, count do
    ret[i] = {
      size = 64,
      filename = ICONPATHMIPS .. icon .. "_" ..  i .. ".png",
      scale = 0.25
    }
  end
  return ret
end

------------------------------------------------------------------------------------
--                                  Wooden floor                                  --
------------------------------------------------------------------------------------
-- BioReactor (ENTITY)
data:extend(
{
  {
    type = "item",
    name = "bi-bio-reactor",
    icon = ICONPATH .. "entity/bioreactor.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "z[bi]-a[bi-bio-reactor]",
    place_result = "bi-bio-reactor",
    stack_size = 10
  },
})

-- Seed
item = {
  type = "item",
  name = "bi-seed",
  icon = ICONPATH .. "tree_seed.png",
  icon_size = 64,
  BI_add_icon = true,
  --~ icon_mipmaps = 4,
  --~ pictures = {
    --~ { size = 64, filename = ICONPATHMIPS.."bio_seed_1.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."bio_seed_2.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."bio_seed_3.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."bio_seed_4.png", scale = 0.25 }
  --~ },
  category = "biofarm-mod-greenhouse",
  subgroup = "bio-bio-farm",
  order = "x[bi]-a[bi-seed]",
  --fuel_value = "0.5MJ",
  --fuel_category = "chemical",
  stack_size = 800
}
item.pictures = add_pix("bio_seed", 4)
data:extend({item})

-- Seedling
item = {
  type = "item",
  name = "seedling",
  localised_name = {"entity-name.seedling"},
  --localised_description = {"entity-description.seedling"},
  icon = ICONPATH .. "seedling.png",
  icon_size = 64,
  BI_add_icon = true,
  --~ icon_mipmaps = 9,
  --~ pictures = {
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_1.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_2.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_3.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_4.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_5.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_6.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_7.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_8.png", scale = 0.25 },
    --~ { size = 64, filename = ICONPATHMIPS.."seedling_9.png", scale = 0.25 }
  --~ },
  subgroup = "bio-bio-farm",
  order = "x[bi]-b[bi-seedling]",
  place_result = "seedling",
  --fuel_value = "0.5MJ",
  --fuel_category = "chemical",
  stack_size = 400
}
item.pictures = add_pix("seedling", 9)
data:extend({item})

--Bio Farm
data:extend({
  {
    type= "item",
    name= "bi-bio-farm",
    localised_name = {"entity-name.bi-bio-farm"},
    localised_description = {"entity-description.bi-bio-farm"},
    icon = ICONPATH .. "entity/biofarm.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-ab[bi-bio-farm]",
    place_result = "bi-bio-farm",
    stack_size= 10,
  },
})

--Bio Greenhouse (Nursery)
data:extend({
  {
    type= "item",
    name= "bi-bio-greenhouse",
    localised_name = {"entity-name.bi-bio-greenhouse"},
    localised_description = {"entity-description.bi-bio-greenhouse"},
    icon = ICONPATH .. "entity/greenhouse.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-aa[bi-bio-greenhouse]",
    place_result = "bi-bio-greenhouse",
    stack_size= 10,
  },
})

-- Cokery
data:extend({
  {
    type = "item",
    name = "bi-cokery",
    icon = ICONPATH .. "entity/cokery.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-b[bi-cokery]",
    place_result = "bi-cokery",
    stack_size = 10
  },
})

--~ -- Stone Crusher
--~ data:extend({
  --~ {
    --~ type = "item",
    --~ name = "bi-stone-crusher",
    --~ localised_name = {"entity-name.bi-stone-crusher"},
    --~ localised_description = {"entity-description.bi-stone-crusher"},
    --~ icon = ICONPATH .. "entity/stone_crusher.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ subgroup = "production-machine",
    --~ order = "x[bi]-c[bi-stone-crusher]",
    --~ place_result = "bi-stone-crusher",
    --~ stack_size = 10
  --~ },
--~ })

-- Wood Pulp
item = {
  type = "item",
  name = "bi-woodpulp",
  icon = ICONPATH .. "woodpulp.png",
  icon_size = 64,
  BI_add_icon = true,
  --~ icon_mipmaps = 4,
  --~ pictures = {
    --~ { size = 64, filename = ICONPATHMIPS.."woodpulp_1.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."woodpulp_2.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."woodpulp_3.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."woodpulp_4.png", scale = 0.2 }
  --~ },
  fuel_value = "1MJ",
  fuel_category = "chemical",
  subgroup = "raw-material",
  order = "a-b[bi-woodpulp]",
  stack_size = 800
}
item.pictures = add_pix("woodpulp", 4)
data:extend({item})

-- Wood Bricks
data:extend({
  {
    type = "item",
    name = "wood-bricks",
    icon = ICONPATH .. "fuel_brick.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "bio-bio-farm-raw",
    order = "a[bi]-a-bx[bi-woodbrick]",
    fuel_category = "chemical",
    fuel_value = "20MJ",
    stack_size = 200
  },
})

-- Ash
item = {
  type = "item",
  name = "bi-ash",
  icon = ICONPATH .. "ash.png",
  icon_size = 64,
  BI_add_icon = true,
  --~ icon_mipmaps = 4,
  --~ pictures = {
    --~ { size = 64, filename = ICONPATHMIPS.."ash_1.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."ash_2.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."ash_3.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."ash_4.png", scale = 0.2 }
  --~ },
  --~ fuel_value = "1MJ",
  --~ fuel_category = "chemical",
  subgroup = "raw-material",
  order = "a[bi]-a-b[bi-ash]",
  stack_size = 400
}
item.pictures = add_pix("ash", 4)
data:extend({item})

-- Charcoal
item = {
  type = "item",
  name = "wood-charcoal",
  icon = ICONPATH .. "charcoal.png",
  icon_size = 64,
  BI_add_icon = true,
  --~ icon_mipmaps = 4,
  --~ pictures = {
    --~ { size = 64, filename = ICONPATHMIPS.."charcoal_1.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."charcoal_2.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."charcoal_3.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."charcoal_4.png", scale = 0.2 }
  --~ },
  fuel_value = "6MJ",
  fuel_category = "chemical",
  subgroup = "raw-material",
  order = "a[bi]-a-c[charcoal]",
  stack_size = 400
}
item.pictures = add_pix("charcoal", 4)
data:extend({item})


-- Coke Coal / Pellet Coke for Angels
data:extend({
  {
    type = "item",
    name = "pellet-coke",
    icon = ICONPATH .. "pellet_coke.png",
    icon_size = 64,
    BI_add_icon = true,
    fuel_value = "28MJ",
    fuel_category = "chemical",
    fuel_acceleration_multiplier = 1.2,
    fuel_top_speed_multiplier = 1.1,
    subgroup = "raw-material",
    order = "a[bi]-a-g[bi-coke-coal]",
    stack_size = 400
  },
})

--~ -- Crushed Stone
--~ item = {
  --~ type = "item",
  --~ name = "stone-crushed",
  --~ icon = ICONPATH .. "crushed-stone.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ -- icon_mipmaps = 4,
  --~ pictures = {
    --~ { size = 64, filename = ICONPATHMIPS.."crush_1.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."crush_2.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."crush_3.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."crush_4.png", scale = 0.2 }
  --~ },
  --~ subgroup = "raw-material",
  --~ order = "a[bi]-a-z[stone-crushed]",
  --~ -- Changed for 0.18.34/1.1.4
  --~ -- stack_size = 800
  --~ stack_size = 400
--~ }
--~ item.pictures = add_pix("crush", 4)
--~ data:extend({item})


-- Seeb Bomb - Basic
data:extend({
  {
    type = "ammo",
    name = "bi-seed-bomb-basic",
    icon = ICONPATH .. "weapon/seed-bomb-1.png",
    icon_size = 64,
    BI_add_icon = true,
    ammo_type = {
      range_modifier = 3,
      cooldown_modifier = 3,
      target_type = "position",
      category = "rocket",
      action = {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "seed-bomb-projectile-1",
          starting_speed = 0.05,
        }
      }
    },
    subgroup = "ammo",
    order = "a[rocket-launcher]-x[seed-bomb]-a",
    stack_size = 10
  },
})

-- Seeb Bomb - Standard
data:extend({
  {
    type = "ammo",
    name = "bi-seed-bomb-standard",
    icon = ICONPATH .. "weapon/seed-bomb-2.png",
    icon_size = 64,
    BI_add_icon = true,
    ammo_type = {
      range_modifier = 3,
      cooldown_modifier = 3,
      target_type = "position",
      category = "rocket",
      action = {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "seed-bomb-projectile-2",
          starting_speed = 0.05,
        }
      }
    },
    subgroup = "ammo",
    order = "a[rocket-launcher]-x[seed-bomb]-b",
    stack_size = 10
  },
})

-- Seeb Bomb - Advanced
data:extend({
  {
    type = "ammo",
    name = "bi-seed-bomb-advanced",
    icon = ICONPATH .. "weapon/seed-bomb-3.png",
    icon_size = 64,
    BI_add_icon = true,
    ammo_type = {
      range_modifier = 3,
      cooldown_modifier = 3,
      target_type = "position",
      category = "rocket",
      action = {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "seed-bomb-projectile-3",
          starting_speed = 0.05,
        }
      }
    },
    subgroup = "ammo",
    order = "a[rocket-launcher]-x[seed-bomb]-c",
    stack_size = 10
  },
})

-- Arboretum (Entity)
data:extend({
  {
    type= "item",
    name= "bi-arboretum-area",
    icon = ICONPATH .. "entity/terraformer.png",
    icon_size = 64,
    BI_add_icon = true,
    subgroup = "production-machine",
    order = "x[bi]-a[bi-arboretum]",
    place_result = "bi-arboretum-area",
    stack_size= 10,
  },
})

-- Arboretum (Hidden recipes)
data:extend({
  {
    type = "item",
    name = "bi-arboretum-r1",
    icon = ICONPATH .. "change_plant.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"hidden"},
    subgroup = "terrain",
    order = "bi-arboretum-r1",
    stack_size = 1,
  },

  --- Arboretum Hidden Recipe
  {
    type = "item",
    name = "bi-arboretum-r2",
    icon = ICONPATH .. "change_fert_1.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"hidden"},
    subgroup = "terrain",
    order = "bi-arboretum-r2",
    stack_size = 1,
  },

   --- Arboretum Hidden Recipe
  {
    type = "item",
    name = "bi-arboretum-r3",
    icon = ICONPATH .. "change_fert_2.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"hidden"},
    subgroup = "terrain",
    order = "bi-arboretum-r3",
    stack_size = 1,
  },

  --- Arboretum Hidden Recipe
  {
    type = "item",
    name = "bi-arboretum-r4",
    icon = ICONPATH .. "change_fert_plant_1.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"hidden"},
    subgroup = "terrain",
    order = "bi-arboretum-r4",
    stack_size = 1,
  },

  --- Arboretum Hidden Recipe
  {
    type = "item",
    name = "bi-arboretum-r5",
    icon = ICONPATH .. "change_fert_plant_2.png",
    icon_size = 64,
    BI_add_icon = true,
     flags = {"hidden"},
    subgroup = "terrain",
    order = "bi-arboretum-r5",
    stack_size = 1
  },
})

-- Fertilizer
data:extend({
  {
    type = "item",
    name = "fertilizer",
    icon = ICONPATH .. "fertilizer.png",
    icon_size = 64,
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
  },
})

-- Advanced fertilizer
data:extend({
  {
    type = "item",
    name = "bi-adv-fertilizer",
    icon = ICONPATH .. "fertilizer_advanced.png",
    icon_size = 64,
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
  },
})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
