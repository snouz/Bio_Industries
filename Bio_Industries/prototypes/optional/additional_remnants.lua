------------------------------------------------------------------------------------
--             Data for remnants of entities that depend on a setting.            --
------------------------------------------------------------------------------------
BI.entered_file()

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath
local REMNANTPATH = BioInd.entitypath .. "remnants/"

BI.optional_remnants = BI.optional_remnants or {}

for s, setting in pairs({
  "BI_Darts",
  "Bio_Cannon",
  "BI_Bio_Fuel",
  --~ "BI_Bigger_Wooden_Chests",
  "BI_Wood_Products",
  "BI_Solar_Additions",
  "BI_Stone_Crushing",
}) do
  BI.optional_remnants[setting] = BI.optional_remnants[setting] or {}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
-- Dart turret
BI.optional_remnants.BI_Darts.dart_turret = {
  type = "corpse",
  name = "bi-dart-turret-remnant",
  localised_name = {"entity-name.bi-dart-turret-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-0.5, -0.5 }, {0.5, 0.5}},
  tile_width = 1,
  tile_height = 1,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "bio_turret_remnant.png",
    line_length = 1,
    width = 112,
    height = 80,
    frame_count = 1,
    direction_count = 1,
    shift = {0.25, -0.25},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_bio_turret_remnant.png",
      line_length = 1,
      width = 224,
      height = 160,
      frame_count = 1,
      direction_count = 1,
      shift = {0.25, -0.25},
      scale = 0.5,
    }
  }
}

-- Wooden fence
BI.optional_remnants.BI_Darts.wooden_fence = {
  type = "corpse",
  name = "bi-wooden-fence-remnant",
  localised_name = {"entity-name.bi-wooden-fence-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  tile_width = 1,
  tile_height = 1,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "wooden_fence_remnant.png",
    line_length = 1,
    width = 64,
    height = 64,
    frame_count = 1,
    direction_count = 1,
    shift = {0, 0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_wooden_fence_remnant.png",
      line_length = 1,
      width = 128,
      height = 128,
      frame_count = 1,
      direction_count = 1,
      shift = {0, 0},
      scale = 0.5
    }
  }
}


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
-- Bio cannon
BI.optional_remnants.Bio_Cannon.bio_cannon = {
  type = "corpse",
  name = "bi-bio-cannon-remnant",
  localised_name = {"entity-name.bi-bio-cannon-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  tile_width = 9,
  tile_height = 9,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "bio_cannon_remnant.png",
    line_length = 1,
    width = 346,
    height = 336,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -0.75},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_bio_cannon_remnant.png",
      line_length = 1,
      width = 692,
      height = 672,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.75},
      scale = 0.5,
    }
  }
}



--~ ------------------------------------------------------------------------------------
--~ --                           "Enable: Easy Bio Gardens"                           --
--~ --                  (BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens)                 --
--~ ------------------------------------------------------------------------------------


  --~ -- Stone crusher
  --~ {
    --~ type = "corpse",
    --~ name = "bi-stone-crusher-remnant",
    --~ localised_name = {"entity-name.bi-stone-crusher-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-1, -1}, {1, 1}},
    --~ tile_width = 2,
    --~ tile_height = 2,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "stone_crusher_remnant.png",
      --~ line_length = 1,
      --~ width = 65,
      --~ height = 78,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0, -0.2},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_stone_crusher_remnant.png",
        --~ line_length = 1,
        --~ width = 130,
        --~ height = 156,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0, -0.2},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
-- Medium wooden chest
BI.optional_remnants.BI_Wood_Products.big_chest = {
  type = "corpse",
  name = "bi-wooden-chest-large-remnant",
  localised_name = {"entity-name.bi-wooden-chest-large-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-1, -1}, {1, 1}},
  tile_width = 2,
  tile_height = 2,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "large_wooden_chest_remnant.png",
    line_length = 1,
    width = 128,
    height = 128,
    frame_count = 1,
    direction_count = 1,
    shift = {0,0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_large_wooden_chest_remnant.png",
      line_length = 1,
      width = 256,
      height = 256,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  }
}

-- Big wooden chest
BI.optional_remnants.BI_Wood_Products.huge_chest = {
  type = "corpse",
  name = "bi-wooden-chest-huge-remnant",
  localised_name = {"entity-name.bi-wooden-chest-huge-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  tile_width = 3,
  tile_height = 3,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "huge_wooden_chest_remnant.png",
    line_length = 1,
    width = 168,
    height = 168,
    frame_count = 1,
    direction_count = 1,
    shift = {0,0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_huge_wooden_chest_remnant.png",
      line_length = 1,
      width = 336,
      height = 336,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  }
}

-- Huge wooden chest
BI.optional_remnants.BI_Wood_Products.giga_chest = {
  type = "corpse",
  name = "bi-wooden-chest-giga-remnant",
  localised_name = {"entity-name.bi-wooden-chest-giga-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-3, -3}, {3, 3}},
  tile_width = 6,
  tile_height = 6,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "giga_wooden_chest_remnant.png",
    line_length = 1,
    width = 288,
    height = 288,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_giga_wooden_chest_remnant.png",
      line_length = 1,
      width = 576,
      height = 576,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0},
      scale = 0.5
    }
  }
}

-- Large wooden pole
BI.optional_remnants.BI_Wood_Products.big_pole = {
  type = "corpse",
  name = "bi-wooden-pole-big-remnant",
  localised_name = {"entity-name.bi-wooden-pole-big-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  tile_width = 1,
  tile_height = 1,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "big-wooden-pole-01_remnant.png",
    line_length = 1,
    width = 54,
    height = 180,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -2.5},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_big-wooden-pole-01_remnant.png",
      line_length = 1,
      width = 108,
      height = 360,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -2.5},
      scale = 0.5
    }
  }
}

-- Huge wooden pole
BI.optional_remnants.BI_Wood_Products.huge_pole = {
  type = "corpse",
  name = "bi-wooden-pole-huge-remnant",
  localised_name = {"entity-name.bi-wooden-pole-huge-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  tile_width = 1,
  tile_height = 1,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "huge_wooden_pole_remnant.png",
    line_length = 1,
    width = 64,
    height = 201,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -2.76},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_huge_wooden_pole_remnant.png",
      line_length = 1,
      width = 128,
      height = 402,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -2.76},
      scale = 0.5
    }
  }
}

-- Wooden pipe
BI.optional_remnants.BI_Wood_Products.wood_pipe = {
  type = "corpse",
  name = "bi-wood-pipe-remnant",
  localised_name = {"entity-name.bi-wood-pipe-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  tile_width = 1,
  tile_height = 1,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "woodpipe_remnant.png",
    line_length = 1,
    width = 64,
    height = 64,
    frame_count = 1,
    direction_count = 1,
    shift = {0,0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_woodpipe_remnant.png",
      line_length = 1,
      width = 128,
      height = 128,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  }
}

------------------------------------------------------------------------------------
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
-- Solar farm
BI.optional_remnants.BI_Solar_Additions.solar_farm = {
  type = "corpse",
  name = "bi-bio-solar-farm-remnant",
  localised_name = {"entity-name.bi-bio-solar-farm-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  tile_width = 9,
  tile_height = 9,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "bio_solar_farm_remnant.png",
    line_length = 1,
    width = 312,
    height = 289,
    frame_count = 1,
    direction_count = 1,
    shift = {0.3, 0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_bio_solar_farm_remnant.png",
      line_length = 1,
      width = 624,
      height = 578,
      frame_count = 1,
      direction_count = 1,
      shift = {0.3, 0},
      scale = 0.5
    }
  }
}

-- Huge accumulator
BI.optional_remnants.BI_Solar_Additions.huge_accumulator = {
  type = "corpse",
  name = "bi-bio-accumulator-remnant",
  localised_name = {"entity-name.bi-bio-accumulator-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-2, -2}, {2, 2}},
  tile_width = 4,
  tile_height = 4,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "bi_large_accumulator_remnant.png",
    line_length = 1,
    width = 154,
    height = 181,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -0.6},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_bi_large_accumulator_remnant.png",
      line_length = 1,
      width = 307,
      height = 362,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.6},
      scale = 0.5
    }
  }
}

-- Huge substation
BI.optional_remnants.BI_Solar_Additions.huge_substation = {
  type = "corpse",
  name = "bi-huge-substation-remnant",
  localised_name = {"entity-name.bi-huge-substation-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
  tile_width = 5,
  tile_height = 5,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "huge_substation_remnant.png",
    line_length = 1,
    width = 192,
    height = 192,
    frame_count = 1,
    direction_count = 1,
    shift = {0,0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_huge_substation_remnant.png",
      line_length = 1,
      width = 384,
      height = 384,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  }
}

-- Solar plant and boiler
BI.optional_remnants.BI_Solar_Additions.solar_boiler = {
  type = "corpse",
  name = "bi-solar-boiler-remnant",
  localised_name = {"entity-name.bi-solar-boiler-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  tile_width = 9,
  tile_height = 9,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "bio_solar_boiler_remnant.png",
    line_length = 1,
    width = 288,
    height = 288,
    frame_count = 1,
    direction_count = 1,
    shift = {0,0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_bio_solar_boiler_remnant.png",
      line_length = 1,
      width = 576,
      height = 576,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  }
}


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
-- Stone crusher
BI.optional_remnants.BI_Stone_Crushing.stone_crusher = {
  type = "corpse",
  name = "bi-stone-crusher-remnant",
  localised_name = {"entity-name.bi-stone-crusher-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-1, -1}, {1, 1}},
  tile_width = 2,
  tile_height = 2,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "stone_crusher_remnant.png",
    line_length = 1,
    width = 65,
    height = 78,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -0.2},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_stone_crusher_remnant.png",
      line_length = 1,
      width = 130,
      height = 156,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.2},
      scale = 0.5
    }
  }
}



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
