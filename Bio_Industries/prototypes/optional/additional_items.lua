------------------------------------------------------------------------------------
--                     Data for items that depend on settings.                    --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_items = BI.additional_items or {}

for s, setting in pairs({
  "BI_Bio_Fuel",
  "BI_Bio_Garden",
  "BI_Coal_Processing",
  "BI_Darts",
  "BI_Explosive_Planting",
  "BI_Rails",
  "BI_Rubber",
  "BI_Solar_Additions",
  "BI_Stone_Crushing",
  "BI_Terraforming",
  "BI_Wood_Products",
  "Bio_Cannon",
}) do
  BI.additional_items[setting] = BI.additional_items[setting] or {}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local ICONPATHMIPS = BioInd.iconpath .. "mips/"


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
-- Bio Cannon/Hive Buster Turret
BI.additional_items.Bio_Cannon.bio_cannon = {
  type = "item",
  name = "bi-bio-cannon-area",
  localised_name = {"entity-name.bi-bio-cannon"},
  localised_description = {"entity-description.bi-bio-cannon"},
  icon = ICONPATH .. "entity/biocannon_icon.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "x[turret]-x[gun-turret]",
  place_result = "bi-bio-cannon-area",
  stack_size = 1,
}


-- Prototype Ammo
BI.additional_items.Bio_Cannon.bio_cannon_proto_ammo = {
  type = "ammo",
  name = "bi-bio-cannon-proto-ammo",
  icon = ICONPATH .. "weapon/bio_cannon_proto_ammo_icon.png",
  icon_size = 64, icon_mipmaps = 3,
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
BI.additional_items.Bio_Cannon.bio_cannon_basic_ammo = {
  type = "ammo",
  name = "bi-bio-cannon-basic-ammo",
  icon = ICONPATH .. "weapon/bio_cannon_basic_ammo_icon.png",
  icon_size = 64, icon_mipmaps = 3,
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
BI.additional_items.Bio_Cannon.bio_cannon_poison_ammo = {
  type = "ammo",
  name = "bi-bio-cannon-poison-ammo",
  icon = ICONPATH .. "weapon/bio_cannon_poison_ammo_icon.png",
  icon_size = 64, icon_mipmaps = 3,
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


-- Poison artillery shell
BI.additional_items.Bio_Cannon.poison_artillery_shell = {
  type = "ammo",
  name = "bi-poison-artillery-shell",
  icon = ICONPATH .. "weapon/artillery-shell-poison.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  ammo_type = {
    category = "artillery-shell",
    target_type = "direction",
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "artillery",
          projectile = "bi-poison-artillery-projectile",
          starting_speed = 1,
          direction_deviation = 0.8,
          range_deviation = 0.8,
          max_range = 90
        }
      }
    }
  },
  subgroup = "ammo",
  order = "d[explosive-cannon-shell]-d[artillery]-[bi-poison]",
  stack_size = 1,
}


------------------------------------------------------------------------------------
--                             Enable: Coal processing                            --
--                        (BI.Settings.BI_Coal_Processing)                        --
------------------------------------------------------------------------------------
-- Charcoal
BI.additional_items.BI_Coal_Processing.wood_charcoal = {
  type = "item",
  name = "wood-charcoal",
  icon = ICONPATH .. "charcoal.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  fuel_value = "6MJ",
  fuel_category = "chemical",
  subgroup = "raw-material",
  order = "a[bi]-a-c[charcoal]",
  stack_size = 400
}
BI.additional_items.BI_Coal_Processing.wood_charcoal.pictures = BioInd.add_pix("charcoal", 4)

-- Coke coal (Pellet coke for Angel's mods)
BI.additional_items.BI_Coal_Processing.pellet_coke = {
  type = "item",
  name = "pellet-coke",
  icon = ICONPATH .. "pellet_coke.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  fuel_value = "28MJ",
  fuel_category = "chemical",
  fuel_acceleration_multiplier = 1.2,
  fuel_top_speed_multiplier = 1.1,
  subgroup = "raw-material",
  order = "a[bi]-a-g[bi-coke-coal]",
  stack_size = 400
}


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
--- Dart turret
BI.additional_items.BI_Darts.dart_turret = {
  type = "item",
  name = "bi-dart-turret",
  icon = ICONPATH .. "entity/dart_turret.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "aa[turret]-a[gun-turret]",
  place_result = "bi-dart-turret",
  stack_size = 50
}


-- Wooden Fence
BI.additional_items.BI_Darts.wooden_fence = {
  type = "item",
  name = "bi-wooden-fence",
  localised_name = {"entity-name.bi-wooden-fence"},
  localised_description = {"entity-description.bi-wooden-fence"},
  icon = ICONPATH .. "entity/wooden-fence.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "a-a[stone-wall]-a[wooden-fence]",
  place_result = "bi-wooden-fence",
  --fuel_value = "4MJ",
  --fuel_category = "chemical",
  stack_size = 50
}

------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
--- Bio Boiler
BI.additional_items.BI_Bio_Fuel.bio_boiler = {
  type = "item",
  name = "bi-bio-boiler",
  icon = ICONPATH .. "entity/bio_boiler.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy",
  order = "b[steam-power]-b[boiler]",
  place_result = "bi-bio-boiler",
  stack_size = 50
}

-- Cellulose
BI.additional_items.BI_Bio_Fuel.cellulose = {
  type = "item",
  name = "bi-cellulose",
  icon = ICONPATH .. "cellulose.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "intermediate-product",
  order = "b[cellulose]",
  stack_size = 200
}


------------------------------------------------------------------------------------
--                               Enable: Bio gardens                              --
--                           (BI.Settings.BI_Bio_Garden)                          --
------------------------------------------------------------------------------------
-- Bio garden
BI.additional_items.BI_Bio_Garden.bio_garden = {
  type = "item",
  name = "bi-bio-garden",
  icon = ICONPATH .. "entity/garden_3x3.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-b[bi-bio-garden1]",
  place_result = "bi-bio-garden",
  stack_size = 10
}

-- Large bio garden
BI.additional_items.BI_Bio_Garden.bio_garden_large = {
  type = "item",
  name = "bi-bio-garden-large",
  icon = ICONPATH .. "entity/garden_9x9.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-b[bi-bio-garden2]",
  place_result = "bi-bio-garden-large",
  stack_size = 10
}

-- Huge bio garden
BI.additional_items.BI_Bio_Garden.bio_garden_huge = {
  type = "item",
  name = "bi-bio-garden-huge",
  icon = ICONPATH .. "entity/garden_27x27.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-b[bi-bio-garden3]",
  place_result = "bi-bio-garden-huge",
  stack_size = 10
}

-- Purified air (This will never be created -- we just need it for the crafting icon!)
BI.additional_items.BI_Bio_Garden.purified_air = {
  type = "item",
  name = "bi-purified-air",
  icon = ICONPATH .. "clean-air.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"hidden"},
  subgroup = "bio-bio-gardens-fluid",
  order = "bi-purified-air",
  stack_size = 1
}


------------------------------------------------------------------------------------
--                               Enable: Seed bombs                               --
--                       (BI.Settings.BI_Explosive_Planting)                      --
------------------------------------------------------------------------------------
-- Basic seeb bomb
BI.additional_items.BI_Explosive_Planting.seed_bomb_basic = {
  type = "ammo",
  name = "bi-seed-bomb-basic",
  icon = ICONPATH .. "weapon/seed-bomb-1.png",
  icon_size = 64, icon_mipmaps = 3,
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
}

-- Standard seed bomb
BI.additional_items.BI_Explosive_Planting.seed_bomb_standard = {
  type = "ammo",
  name = "bi-seed-bomb-standard",
  icon = ICONPATH .. "weapon/seed-bomb-2.png",
  icon_size = 64, icon_mipmaps = 3,
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
}

-- Advanced seeb bomb
BI.additional_items.BI_Explosive_Planting.seed_bomb_advanced = {
  type = "ammo",
  name = "bi-seed-bomb-advanced",
  icon = ICONPATH .. "weapon/seed-bomb-3.png",
  icon_size = 64, icon_mipmaps = 3,
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
}


------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
-- Resin
BI.additional_items.BI_Rubber.resin = {
  type = "item",
  name = "resin",
  localised_name = {"item-name.bi-resin"},
  localised_description = {"item-description.bi-resin"},
  icon = ICONPATH .. "resin.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "raw-material",
  --~ order = "a[bi]-a-b[bi-resin]",
  order = "a[bi]-a-bb[bi-resin]",
  stack_size = 200
}

-- Rubber
BI.additional_items.BI_Rubber.rubber = {
  type = "item",
  name = "rubber",
  localised_name = {"item-name.bi-rubber"},
  localised_description = {"item-description.bi-rubber"},
  icon = ICONPATH .. "rubber.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "raw-material",
  --~ order = "a[bi]-a-b[bi-resin]",
  order = "a[bi]-a-bb[bi-rubber]",
  stack_size = 100
}

-- Rubber mat
BI.additional_items.BI_Rubber.rubber_mat = {
  type = "item",
  name = "bi-rubber-mat",
  localised_name = {"entity-name.bi-rubber-mat"},
  localised_description = {"entity-description.bi-rubber-mat"},
  icon = ICONPATH .. "entity/rubber-mat.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "a-a[stone-wall]-a[bi-rubber-mat]",
  stack_size = 400,
  place_as_tile = {
    result = "bi-rubber-mat",
    condition_size = 4,
    condition = { "water-tile" }
  }
}


------------------------------------------------------------------------------------
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
-- Solar Farm
BI.additional_items.BI_Solar_Additions.solar_farm = {
  type = "item",
  name = "bi-bio-solar-farm",
  localised_name = {"entity-name.bi-bio-solar-farm"},
  localised_description = {"entity-description.bi-bio-solar-farm"},
  icon = ICONPATH .. "entity/solar-panel-large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy",
  order = "d[solar-panel]-a[solar-panel]-a[bi-bio-solar-farm]",
  place_result = "bi-bio-solar-farm",
  stack_size = 10,
}

-- Musk floor/Solar mat
BI.additional_items.BI_Solar_Additions.solar_mat = {
  type = "item",
  name = "bi-solar-mat",
  localised_name = {"entity-name.bi-solar-mat"},
  localised_description = {"entity-description.bi-solar-mat"},
  icon = ICONPATH .. "entity/solar-mat.png",
  icon_size = 64, icon_mipmaps = 3,
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
BI.additional_items.BI_Solar_Additions.huge_accumulator = {
  type = "item",
  name = "bi-bio-accumulator",
  localised_name = {"entity-name.bi-bio-accumulator"},
  localised_description = {"entity-description.bi-bio-accumulator"},
  icon = ICONPATH .. "entity/accumulator_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy",
  order = "e[accumulator]-a[bi-accumulator]",
  place_result = "bi-bio-accumulator",
  stack_size = 5
}

-- Huge Substation
BI.additional_items.BI_Solar_Additions.huge_substation = {
  type = "item",
  name = "bi-huge-substation",
  localised_name = {"entity-name.bi-huge-substation"},
  localised_description = {"entity-description.bi-huge-substation"},
  icon = ICONPATH .. "entity/substation_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-d[substation]-b[large-substation]",
  place_result = "bi-huge-substation",
  stack_size = 10
}

-- Solar boiler and plant
BI.additional_items.BI_Solar_Additions.solar_boiler = {
  type = "item",
  name = "bi-solar-boiler",
  localised_name = {"entity-name.bi-solar-boiler"},
  localised_description = {"entity-description.bi-solar-boiler"},
  icon = ICONPATH .. "entity/solar-boiler.png",
  icon_size = 64, icon_mipmaps = 3,
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
BI.additional_items.BI_Stone_Crushing.stone_crusher = {
  type = "item",
  name = "bi-stone-crusher",
  localised_name = {"entity-name.bi-stone-crusher"},
  localised_description = {"entity-description.bi-stone-crusher"},
  icon = ICONPATH .. "entity/stone_crusher.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-c[bi-stone-crusher]",
  place_result = "bi-stone-crusher",
  stack_size = 10
}

-- Crushed Stone
BI.additional_items.BI_Stone_Crushing.crushed_stone = {
  type = "item",
  name = "stone-crushed",
  icon = ICONPATH .. "crushed-stone.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ icon_mipmaps = 4,
  --~ pictures = {
    --~ { size = 64, filename = ICONPATHMIPS.."crush_1.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."crush_2.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."crush_3.png", scale = 0.2 },
    --~ { size = 64, filename = ICONPATHMIPS.."crush_4.png", scale = 0.2 }
  --~ },
  subgroup = "raw-material",
  order = "a[bi]-a-z[stone-crushed]",
  -- Changed for 0.18.34/1.1.4
  --~ stack_size = 800
  stack_size = 400
}
BI.additional_items.BI_Stone_Crushing.crushed_stone.pictures = BioInd.add_pix("crush", 4)


------------------------------------------------------------------------------------
--                              Enable: Terraforming                              --
--                          (BI.Settings.BI_Terraforming)                         --
------------------------------------------------------------------------------------
-- Terraformer (Arboretum)
BI.additional_items.BI_Terraforming.arboretum_area = {
  type= "item",
  name= "bi-arboretum-area",
  icon = ICONPATH .. "entity/terraformer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-production-machine",
  order = "x[bi]-a[bi-arboretum]",
  place_result = "bi-arboretum-area",
  stack_size= 10,
}

-- Terraformer (Arboretum): Dummy items for recipes                --
-- Plant Trees
BI.additional_items.BI_Terraforming.arboretum_r1 = {
  type = "item",
  name = "bi-arboretum-r1",
  icon = ICONPATH .. "change_plant.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"hidden"},
  subgroup = "terrain",
  order = "bi-arboretum-r1",
  stack_size = 1,
}

-- Change terrain (basic)
BI.additional_items.BI_Terraforming.arboretum_r2 = {
  type = "item",
  name = "bi-arboretum-r2",
  icon = ICONPATH .. "change_fert_1.png",
  icon_size = 64,
  BI_add_icon = true,
  flags = {"hidden"},
  subgroup = "terrain",
  order = "bi-arboretum-r2",
  stack_size = 1,
}

-- Change terrain (advanced)
BI.additional_items.BI_Terraforming.arboretum_r3 = {
  type = "item",
  name = "bi-arboretum-r3",
  icon = ICONPATH .. "change_fert_2.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"hidden"},
  subgroup = "terrain",
  order = "bi-arboretum-r3",
  stack_size = 1,
}

-- Change terrain & plant trees (basic)
BI.additional_items.BI_Terraforming.arboretum_r4 = {
  type = "item",
  name = "bi-arboretum-r4",
  icon = ICONPATH .. "change_fert_plant_1.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"hidden"},
  subgroup = "terrain",
  order = "bi-arboretum-r4",
  stack_size = 1,
}

-- Change terrain & plant trees (advanced)
BI.additional_items.BI_Terraforming.arboretum_r5 = {
  type = "item",
  name = "bi-arboretum-r5",
  icon = ICONPATH .. "change_fert_plant_2.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
   flags = {"hidden"},
  subgroup = "terrain",
  order = "bi-arboretum-r5",
  stack_size = 1
}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
-- Large wooden chest 2 x 2
BI.additional_items.BI_Wood_Products.large_wooden_chest = {
  type = "item",
  name = "bi-wooden-chest-large",
  localised_name = {"entity-name.bi-wooden-chest-large"},
  localised_description = {"entity-description.bi-wooden-chest-large"},
  icon = ICONPATH .. "entity/wood_chest_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --fuel_category = "chemical",
  --fuel_value = "32MJ",
  subgroup = "storage",
  order = "a[items]-d[bigchest]",
  place_result = "bi-wooden-chest-large",
  stack_size = 48,
}

-- Huge wooden chest 3 x 3
BI.additional_items.BI_Wood_Products.huge_wooden_chest = {
  type = "item",
  name = "bi-wooden-chest-huge",
  localised_name = {"entity-name.bi-wooden-chest-huge"},
  localised_description = {"entity-description.bi-wooden-chest-huge"},
  icon = ICONPATH .. "entity/wood_chest_huge.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --fuel_category = "chemical",
  --fuel_value = "200MJ",
  subgroup = "storage",
  order = "a[items]-e[hugechest]",
  place_result = "bi-wooden-chest-huge",
  stack_size = 32,
}

-- Gigantic wooden chest 6 x 6
BI.additional_items.BI_Wood_Products.giga_wooden_chest = {
  type = "item",
  name = "bi-wooden-chest-giga",
  localised_name = {"entity-name.bi-wooden-chest-giga"},
  localised_description = {"entity-description.bi-wooden-chest-giga"},
  icon = ICONPATH .. "entity/wood_chest_giga.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --fuel_category = "chemical",
  --fuel_value = "400MJ",
  subgroup = "storage",
  order = "a[items]-f[gigachest]",
  place_result = "bi-wooden-chest-giga",
  stack_size = 16
}

-- Big Wooden Electric Pole
BI.additional_items.BI_Wood_Products.big_pole = {
  type = "item",
  name = "bi-wooden-pole-big",
  localised_name = {"entity-name.bi-wooden-pole-big"},
  --localised_description = {"entity-description.bi-wooden-pole-big"},
  icon = ICONPATH .. "entity/wood_pole_big.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-b[small-electric-pole]",
  place_result = "bi-wooden-pole-big",
  --fuel_value = "14MJ",
  --fuel_category = "chemical",
  stack_size = 50
}

-- Huge Wooden Pole
BI.additional_items.BI_Wood_Products.huge_pole = {
  type = "item",
  name = "bi-wooden-pole-huge",
  localised_name = {"entity-name.bi-wooden-pole-huge"},
  --localised_description = {"entity-description.bi-wooden-pole-huge"},
  icon = ICONPATH .. "entity/wood_pole_huge.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-d[big-electric-pole]",
  place_result = "bi-wooden-pole-huge",
  --fuel_value = "90MJ",
  --fuel_category = "chemical",
  stack_size = 50
}

--- Wood Pipe
BI.additional_items.BI_Wood_Products.wood_pipe = {
  type = "item",
  name = "bi-wood-pipe",
  localised_name = {"entity-name.bi-wood-pipe"},
  localised_description = {"entity-description.bi-wood-pipe"},
  icon = ICONPATH .. "entity/wood_pipe.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[pipe]-1a[pipe]",
  place_result = "bi-wood-pipe",
  --fuel_value = "4MJ",
  --fuel_category = "chemical",
  stack_size = 100
}

--- Wood Pipe to Ground
BI.additional_items.BI_Wood_Products.wood_pipe_to_ground = {
  type = "item",
  name = "bi-wood-pipe-to-ground",
  localised_name = {"entity-name.bi-wood-pipe-to-ground"},
  localised_description = {"entity-description.bi-wood-pipe-to-ground"},
  icon = ICONPATH .. "entity/wood_pipe_to_ground.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "energy-pipe-distribution",
  order = "a[pipe]-1b[pipe-to-ground]",
  place_result = "bi-wood-pipe-to-ground",
  --fuel_value = "20MJ",
  --fuel_category = "chemical",
  stack_size = 50
}


------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
-- Wooden-rail planner
BI.additional_items.BI_Rails.rail_wood = {
  type = "rail-planner",
  name = "bi-rail-wood",
  localised_name = {"entity-name.bi-rail-wood"},
  localised_description = {"entity-description.bi-rail-wood"},
  icon = ICONPATH .. "entity/rail-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "transport",
  order = "a[train-system]-a[rail]",
  place_result = "bi-straight-rail-wood",
  stack_size = 100,
  straight_rail = "bi-straight-rail-wood",
  curved_rail = "bi-curved-rail-wood"
}

-- Wooden-rail-bridge planner
BI.additional_items.BI_Rails.rail_wood_bridge = {
  type = "rail-planner",
  name = "bi-rail-wood-bridge",
  localised_name = {"entity-name.bi-rail-wood-bridge"},
  localised_description = {"entity-description.bi-rail-wood-bridge"},
  icon = ICONPATH .. "entity/rail-bridge-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "transport",
  order = "a[train-system]-aa[rail]",
  place_result = "bi-straight-rail-wood-bridge",
  stack_size = 100,
  straight_rail = "bi-straight-rail-wood-bridge",
  curved_rail = "bi-curved-rail-wood-bridge"
}

-- Powered-rail planner
BI.additional_items.BI_Rails.rail_power = {
  type = "rail-planner",
  name = "bi-rail-power",
  localised_name = {"entity-name.bi-rail-power"},
  localised_description = {"entity-description.bi-rail-power"},
  icon = ICONPATH .. "entity/rail-concrete-power.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "transport",
  order = "a[train-system]-ab[rail]",
  place_result = "bi-straight-rail-power",
  stack_size = 100,
  straight_rail = "bi-straight-rail-power",
  curved_rail = "bi-curved-rail-power"
}

--- Power pole to connect Rail to power grid
BI.additional_items.BI_Rails.power_to_rail_pole = {
  type = "item",
  name = "bi-power-to-rail-pole",
  localised_name = {"entity-name.bi-power-to-rail-pole"},
  localised_description = {"entity-description.bi-power-to-rail-pole"},
  icon = ICONPATH .. "entity/rail-concrete-power-pole.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "transport",
  order = "a[train-system]-ac[rail]",
  place_result = "bi-power-to-rail-pole",
  stack_size = 50
}


BioInd.writeDebug("Read data for optional items.")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
