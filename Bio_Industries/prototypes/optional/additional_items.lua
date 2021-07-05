------------------------------------------------------------------------------------
--                     Data for items that depend on settings.                    --
------------------------------------------------------------------------------------
BI.entered_file()

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath
local ICONPATHMIPS = BioInd.iconpath .. "mips/"

BI.optional_items = BI.optional_items or {}

for s, setting in pairs({
  "BI_Bio_Fuel",
  "Bio_Cannon",
  --~ "BI_Bigger_Wooden_Chests",
  "BI_Wood_Products",
  "BI_Solar_Additions",
  "BI_Darts",
  "BI_Stone_Crushing",
}) do
  BI.optional_items[setting] = BI.optional_items[setting] or {}
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
--- Dart turret
BI.optional_items.BI_Darts.dart_turret = {
  type = "item",
  name = "bi-dart-turret",
  icon = ICONPATH .. "entity/dart_turret.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "aa[turret]-a[gun-turret]",
  place_result = "bi-dart-turret",
  stack_size = 50
}


-- Wooden Fence
BI.optional_items.BI_Darts.wooden_fence = {
  type = "item",
  name = "bi-wooden-fence",
  localised_name = {"entity-name.bi-wooden-fence"},
  localised_description = {"entity-description.bi-wooden-fence"},
  icon = ICONPATH .. "entity/wooden-fence.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "a-a[stone-wall]-a[wooden-fence]",
  place_result = "bi-wooden-fence",
  --fuel_value = "4MJ",
  --fuel_category = "chemical",
  stack_size = 50
}

------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
-- Bio Cannon/Hive Buster Turret
BI.optional_items.Bio_Cannon.bio_cannon = {
  type = "item",
  name = "bi-bio-cannon-area",
  localised_name = {"entity-name.bi-bio-cannon"},
  localised_description = {"entity-description.bi-bio-cannon"},
  icon = ICONPATH .. "entity/biocannon_icon.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "x[turret]-x[gun-turret]",
  place_result = "bi-bio-cannon-area",
  stack_size = 1,
}


-- Prototype Ammo
BI.optional_items.Bio_Cannon.bio_cannon_proto_ammo = {
  type = "ammo",
  name = "bi-bio-cannon-proto-ammo",
  icon = ICONPATH .. "weapon/bio_cannon_proto_ammo_icon.png",
  icon_size = 64,
  BI_add_icon = true,
  ammo_type = {
    category = "Bio_Cannon_Ammo",
    target_type = "direction",
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "bi-bio-cannon-proto-ammo",
          starting_speed = 1,
          direction_deviation = 0.8,
          range_deviation = 0.8,
          max_range = 90
        }
      }
    }
  },
  subgroup = "ammo",
  order = "z[Bio_Cannon_Ammo]-a[Proto]",
  stack_size = 50,
}


-- Prototype Artillery Basic Ammo
BI.optional_items.Bio_Cannon.bio_cannon_basic_ammo = {
  type = "ammo",
  name = "bi-bio-cannon-basic-ammo",
  icon = ICONPATH .. "weapon/bio_cannon_basic_ammo_icon.png",
  icon_size = 64,
  BI_add_icon = true,
  ammo_type = {
    category = "Bio_Cannon_Ammo",
    target_type = "direction",
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "bi-bio-cannon-basic-ammo",
          starting_speed = 1,
          direction_deviation = 0.8,
          range_deviation = 0.8,
          max_range = 90
        }
      }
    }
  },
  subgroup = "ammo",
  order = "z[Bio_Cannon_Ammo]-b[Basic]",
  stack_size = 50,
}


-- Prototype Artillery Poison Ammo
BI.optional_items.Bio_Cannon.bio_cannon_poison_ammo = {
  type = "ammo",
  name = "bi-bio-cannon-poison-ammo",
  icon = ICONPATH .. "weapon/bio_cannon_poison_ammo_icon.png",
  icon_size = 64,
  BI_add_icon = true,
  ammo_type = {
    category = "Bio_Cannon_Ammo",
    target_type = "direction",
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "bi-bio-cannon-poison-ammo",
          starting_speed = 1,
          direction_deviation = 0.8,
          range_deviation = 0.8,
          max_range = 90
        }
      }
    }
  },
  subgroup = "ammo",
  order = "z[Bio_Cannon_Ammo]-c[Poison]",
  stack_size = 50,
}


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
-- Cellulose
BI.optional_items.BI_Bio_Fuel.cellulose = {
  type = "item",
  name = "bi-cellulose",
  icon = ICONPATH .. "cellulose.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "intermediate-product",
  order = "b[cellulose]",
  stack_size = 200
}

--- Bio Boiler
BI.optional_items.BI_Bio_Fuel.bio_boiler = {
  type = "item",
  name = "bi-bio-boiler",
  icon = ICONPATH .. "entity/bio_boiler.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy",
  order = "b[steam-power]-b[boiler]",
  place_result = "bi-bio-boiler",
  stack_size = 50
}


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
-- Large wooden chest 2 x 2
BI.optional_items.BI_Wood_Products.large_wooden_chest = {
  type = "item",
  name = "bi-wooden-chest-large",
  localised_name = {"entity-name.bi-wooden-chest-large"},
  localised_description = {"entity-description.bi-wooden-chest-large"},
  icon = ICONPATH .. "entity/wood_chest_large.png",
  icon_size = 64,
  BI_add_icon = true,
  --fuel_category = "chemical",
  --fuel_value = "32MJ",
  subgroup = "storage",
  order = "a[items]-d[bigchest]",
  place_result = "bi-wooden-chest-large",
  stack_size = 48,
}

-- Huge wooden chest 3 x 3
BI.optional_items.BI_Wood_Products.huge_wooden_chest = {
  type = "item",
  name = "bi-wooden-chest-huge",
  localised_name = {"entity-name.bi-wooden-chest-huge"},
  localised_description = {"entity-description.bi-wooden-chest-huge"},
  icon = ICONPATH .. "entity/wood_chest_huge.png",
  icon_size = 64,
  BI_add_icon = true,
  --fuel_category = "chemical",
  --fuel_value = "200MJ",
  subgroup = "storage",
  order = "a[items]-e[hugechest]",
  place_result = "bi-wooden-chest-huge",
  stack_size = 32,
}

-- Gigantic wooden chest 6 x 6
BI.optional_items.BI_Wood_Products.giga_wooden_chest = {
  type = "item",
  name = "bi-wooden-chest-giga",
  localised_name = {"entity-name.bi-wooden-chest-giga"},
  localised_description = {"entity-description.bi-wooden-chest-giga"},
  icon = ICONPATH .. "entity/wood_chest_giga.png",
  icon_size = 64,
  BI_add_icon = true,
  --fuel_category = "chemical",
  --fuel_value = "400MJ",
  subgroup = "storage",
  order = "a[items]-f[gigachest]",
  place_result = "bi-wooden-chest-giga",
  stack_size = 16
}

-- Big Wooden Electric Pole
BI.optional_items.BI_Wood_Products.big_pole = {
  type = "item",
  name = "bi-wooden-pole-big",
  localised_name = {"entity-name.bi-wooden-pole-big"},
  --localised_description = {"entity-description.bi-wooden-pole-big"},
  icon = ICONPATH .. "entity/wood_pole_big.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-b[small-electric-pole]",
  place_result = "bi-wooden-pole-big",
  --fuel_value = "14MJ",
  --fuel_category = "chemical",
  stack_size = 50
}

-- Huge Wooden Pole
BI.optional_items.BI_Wood_Products.huge_pole = {
  type = "item",
  name = "bi-wooden-pole-huge",
  localised_name = {"entity-name.bi-wooden-pole-huge"},
  --localised_description = {"entity-description.bi-wooden-pole-huge"},
  icon = ICONPATH .. "entity/wood_pole_huge.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-d[big-electric-pole]",
  place_result = "bi-wooden-pole-huge",
  --fuel_value = "90MJ",
  --fuel_category = "chemical",
  stack_size = 50
}

--- Wood Pipe
BI.optional_items.BI_Wood_Products.wood_pipe = {
  type = "item",
  name = "bi-wood-pipe",
  localised_name = {"entity-name.bi-wood-pipe"},
  localised_description = {"entity-description.bi-wood-pipe"},
  icon = ICONPATH .. "entity/wood_pipe.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[pipe]-1a[pipe]",
  place_result = "bi-wood-pipe",
  --fuel_value = "4MJ",
  --fuel_category = "chemical",
  stack_size = 100
}

--- Wood Pipe to Ground
BI.optional_items.BI_Wood_Products.wood_pipe_to_ground = {
  type = "item",
  name = "bi-wood-pipe-to-ground",
  localised_name = {"entity-name.bi-wood-pipe-to-ground"},
  localised_description = {"entity-description.bi-wood-pipe-to-ground"},
  icon = ICONPATH .. "entity/wood_pipe_to_ground.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[pipe]-1b[pipe-to-ground]",
  place_result = "bi-wood-pipe-to-ground",
  --fuel_value = "20MJ",
  --fuel_category = "chemical",
  stack_size = 50
}



------------------------------------------------------------------------------------
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
-- Solar Farm
BI.optional_items.BI_Solar_Additions.solar_farm = {
  type = "item",
  name = "bi-bio-solar-farm",
  localised_name = {"entity-name.bi-bio-solar-farm"},
  localised_description = {"entity-description.bi-bio-solar-farm"},
  icon = ICONPATH .. "entity/solar-panel-large.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy",
  order = "d[solar-panel]-a[solar-panel]-a[bi-bio-solar-farm]",
  place_result = "bi-bio-solar-farm",
  stack_size = 10,
}

-- Musk floor/Solar mat
BI.optional_items.BI_Solar_Additions.solar_mat = {
  type = "item",
  name = "bi-solar-mat",
  localised_name = {"entity-name.bi-solar-mat"},
  localised_description = {"entity-description.bi-solar-mat"},
  icon = ICONPATH .. "entity/solar-mat.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy",
  order = "d[solar-panel]-aa[solar-panel-1-a]",
  stack_size = 400,
  place_as_tile = {
    result = "bi-solar-mat",
    condition_size = 4,
    condition = { "water-tile" }
  }
}


-- Huge accumulator
BI.optional_items.BI_Solar_Additions.huge_accumulator = {
  type = "item",
  name = "bi-bio-accumulator",
  localised_name = {"entity-name.bi-bio-accumulator"},
  localised_description = {"entity-description.bi-bio-accumulator"},
  icon = ICONPATH .. "entity/accumulator_large.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy",
  order = "e[accumulator]-a[bi-accumulator]",
  place_result = "bi-bio-accumulator",
  stack_size = 5
}


-- Huge Substation
BI.optional_items.BI_Solar_Additions.huge_substation = {
  type = "item",
  name = "bi-huge-substation",
  localised_name = {"entity-name.bi-huge-substation"},
  localised_description = {"entity-description.bi-huge-substation"},
  icon = ICONPATH .. "entity/substation_large.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-d[substation]-b[large-substation]",
  place_result = "bi-huge-substation",
  stack_size = 10
}

-- Solar boiler and plant
BI.optional_items.BI_Solar_Additions.solar_boiler = {
  type = "item",
  name = "bi-solar-boiler",
  localised_name = {"entity-name.bi-solar-boiler"},
  localised_description = {"entity-description.bi-solar-boiler"},
  icon = ICONPATH .. "entity/solar-boiler.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "energy",
  order = "b[steam-power]-c[steam-engine]",
  place_result = "bi-solar-boiler",
  stack_size = 20,
}


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
-- Stone Crusher
BI.optional_items.BI_Stone_Crushing.stone_crusher = {
  type = "item",
  name = "bi-stone-crusher",
  localised_name = {"entity-name.bi-stone-crusher"},
  localised_description = {"entity-description.bi-stone-crusher"},
  icon = ICONPATH .. "entity/stone_crusher.png",
  icon_size = 64,
  BI_add_icon = true,
  subgroup = "production-machine",
  order = "x[bi]-c[bi-stone-crusher]",
  place_result = "bi-stone-crusher",
  stack_size = 10
}


-- Crushed Stone
BI.optional_items.BI_Stone_Crushing.crushed_stone = {
  type = "item",
  name = "stone-crushed",
  icon = ICONPATH .. "crushed-stone.png",
  icon_size = 64,
  BI_add_icon = true,
  --~ icon_mipmaps = 4,
  pictures = {
    { size = 64, filename = ICONPATHMIPS.."crush_1.png", scale = 0.2 },
    { size = 64, filename = ICONPATHMIPS.."crush_2.png", scale = 0.2 },
    { size = 64, filename = ICONPATHMIPS.."crush_3.png", scale = 0.2 },
    { size = 64, filename = ICONPATHMIPS.."crush_4.png", scale = 0.2 }
  },
  subgroup = "raw-material",
  order = "a[bi]-a-z[stone-crushed]",
  -- Changed for 0.18.34/1.1.4
  --~ stack_size = 800
  stack_size = 400
}
--~ item.pictures = add_pix("crush", 4)

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
