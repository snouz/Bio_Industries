------------------------------------------------------------------------------------
--             Data for remnants of entities that depend on a setting.            --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_remnants = BI.additional_remnants or {}

local settings = {
  --~ "BI_Bio_Fuel",
  "BI_Bio_Garden",
  "BI_Darts",
  "BI_Rails",
  "BI_Power_Production",
  "BI_Stone_Crushing",
  "BI_Terraforming",
  "BI_Wood_Products",
  "Bio_Cannon",
}
for s, setting in pairs(settings) do
  BI.additional_remnants[setting] = BI.additional_remnants[setting] or {}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local REMNANTPATH = BioInd.entitypath .. "remnants/"
local BASEPATH = "__base__/graphics/icons/"


------------------------------------------------------------------------------------
--                               Enable: Bio gardens                              --
--                           (BI.Settings.BI_Bio_Garden)                          --
------------------------------------------------------------------------------------
-- Bio garden
BI.additional_remnants.BI_Bio_Garden.bio_garden = {
  type = "corpse",
  name = "bi-bio-garden-remnant",
  localised_name = {"entity-name.bi-bio-garden-remnant"},
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
    filename = REMNANTPATH .. "bio_garden_remnant.png",
    line_length = 1,
    width = 128,
    height = 160,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -0.75},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_bio_garden_remnant.png",
      line_length = 1,
      width = 256,
      height = 320,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.75},
      scale = 0.5
    }
  }
}

-- Large Bio garden
BI.additional_remnants.BI_Bio_Garden.bio_garden_large = {
  type = "corpse",
  name = "bi-bio-garden-large-remnant",
  localised_name = {"entity-name.bi-bio-garden-large-remnant"},
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
    filename = REMNANTPATH .. "bio_garden_large_remnant.png",
    line_length = 1,
    width = 320,
    height = 352,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -0.5},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_bio_garden_large_remnant.png",
      line_length = 1,
      width = 640,
      height = 704,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.5},
      scale = 0.5
    }
  }
}

-- Huge Bio garden
BI.additional_remnants.BI_Bio_Garden.bio_garden_huge = {
  type = "corpse",
  name = "bi-bio-garden-huge-remnant",
  localised_name = {"entity-name.bi-bio-garden-huge-remnant"},
  icon = "__base__/graphics/icons/remnants.png",
  icon_size = 64,
  icon_mipmaps = 4,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "z-z-z",
  selection_box = {{-13.5, -13.5}, {13.5, 13.5}},
  tile_width = 27,
  tile_height = 27,
  selectable_in_game = false,
  time_before_removed = 60 * 60 * 15, -- 15 minutes
  final_render_layer = "remnants",
  remove_on_tile_placement = false,
  animation =
  {
    filename = REMNANTPATH .. "bio_garden_huge_remnant.png",
    line_length = 1,
    width = 896,
        height = 928,
    frame_count = 1,
    direction_count = 1,
    shift = {0, -0.5},
    hr_version =
    {
      filename = REMNANTPATH .. "bio_garden_huge_remnant.png",
      line_length = 1,
      width = 896,
      height = 928,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.5},
    }
  }
}


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
-- Dart turret
BI.additional_remnants.BI_Darts.dart_turret = {
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
BI.additional_remnants.BI_Darts.wooden_fence = {
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
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
-- Straight wooden rails
BI.additional_remnants.BI_Rails.straight_rail_wood = {
  type = "rail-remnants",
  --~ name = "straight-rail-remnants-wood",
  name = "straight-rail-wood-remnants",
  localised_name = {"entity-name.rail-remnants-wood"},
  localised_description = {"entity_description.rail-remnants-wood"},
  icon = BASEPATH .. "straight-rail-remnants.png",
  icon_size = 64,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "d[remnants]-b[rail]-a[straight]",
  collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
  selection_box = {{-0.6, -0.8}, {0.6, 0.8}},
  selectable_in_game = false,
  tile_width = 2,
  tile_height = 2,
  bending_type = "straight",
  --pictures = destroyed_rail_pictures_w(),
  pictures = destroyed_rail_pictures(),
  time_before_removed = 60 * 60 * 45,
  time_before_shading_off = 60 * 60 * 1
}

-- Curved wooden rails
BI.additional_remnants.BI_Rails.curved_rail_wood = {
  type = "rail-remnants",
  name = "curved-rail-wood-remnants",
  localised_name = {"entity-name.rail-remnants-wood"},
  localised_description = {"entity_description.rail-remnants-wood"},
  icon = BASEPATH .. "curved-rail-remnants.png",
  icon_size = 64,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "d[remnants]-b[rail]-b[curved]",
  collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
  secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
  selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
  selectable_in_game = false,
  tile_width = 4,
  tile_height = 8,
  bending_type = "turn",
  --pictures = destroyed_rail_pictures_w(),
  pictures = destroyed_rail_pictures(),
  time_before_removed = 60 * 60 * 45,
  time_before_shading_off = 60 * 60 * 1
}

-- Straight wooden rail bridge
BI.additional_remnants.BI_Rails.straight_rail_wood_bridge = {
  type = "rail-remnants",
  name = "straight-rail-wood-bridge-remnants",
  localised_name = {"entity-name.rail-wood-bridge-remnants"},
  localised_description = {"entity_description.rail-wood-bridge-remnants"},
  icon = BASEPATH .. "straight-rail-remnants.png",
  icon_size = 64,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "d[remnants]-b[rail]-a[straight]",
  collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
  selection_box = {{-0.6, -0.8}, {0.6, 0.8}},
  selectable_in_game = false,
  tile_width = 2,
  tile_height = 2,
  bending_type = "straight",
  --pictures = destroyed_rail_pictures_w(),
  pictures = destroyed_rail_pictures(),
  time_before_removed = 60 * 60 * 45,
  time_before_shading_off = 60 * 60 * 1
}

-- Curved wooden rail bridge
BI.additional_remnants.BI_Rails.curved_rail_wood_bridge = {
  type = "rail-remnants",
  name = "curved-rail-wood-bridge-remnants",
  localised_name = {"entity-name.rail-wood-bridge-remnants"},
  localised_description = {"entity_description.rail-wood-bridge-remnants"},
  icon = BASEPATH .. "curved-rail-remnants.png",
  icon_size = 64,
  BI_add_icon = true,
  flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
  subgroup = "remnants",
  order = "d[remnants]-b[rail]-b[curved]",
  collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
  secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
  selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
  selectable_in_game = false,
  tile_width = 4,
  tile_height = 8,
  bending_type = "turn",
  --pictures = destroyed_rail_pictures_w(),
  pictures = destroyed_rail_pictures(),
  time_before_removed = 60 * 60 * 45,
  time_before_shading_off = 60 * 60 * 1
}


------------------------------------------------------------------------------------
--                  Enable: Bio power production and distribution                 --
--                        (BI.Settings.BI_Power_Production)                       --
------------------------------------------------------------------------------------
-- Solar farm
BI.additional_remnants.BI_Power_Production.solar_farm = {
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
BI.additional_remnants.BI_Power_Production.huge_accumulator = {
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
BI.additional_remnants.BI_Power_Production.huge_substation = {
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
BI.additional_remnants.BI_Power_Production.solar_boiler = {
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
BI.additional_remnants.BI_Stone_Crushing.stone_crusher = {
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
--                              Enable: Terraforming                              --
--                          (BI.Settings.BI_Terraforming)                         --
------------------------------------------------------------------------------------
-- Terraformer (Arboretum)
BI.additional_remnants.BI_Terraforming.arboretum_area = {
  type = "corpse",
  name = "bi-arboretum-area-remnant",
  localised_name = {"entity-name.bi-arboretum-area-remnant"},
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
    filename = REMNANTPATH .. "arboretum_remnant.png",
    line_length = 1,
    width = 320,
    height = 320,
    frame_count = 1,
    direction_count = 1,
    shift = {0,0},
    hr_version =
    {
      filename = REMNANTPATH .. "hr_arboretum_remnant.png",
      line_length = 1,
      width = 640,
      height = 640,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  }
}


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
-- Medium wooden chest
BI.additional_remnants.BI_Wood_Products.big_chest = {
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
BI.additional_remnants.BI_Wood_Products.huge_chest = {
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
BI.additional_remnants.BI_Wood_Products.giga_chest = {
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
BI.additional_remnants.BI_Wood_Products.big_pole = {
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
BI.additional_remnants.BI_Wood_Products.huge_pole = {
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

-- Wood pipe
BI.additional_remnants.BI_Wood_Products.wood_pipe = {
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
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
-- Bio cannon
BI.additional_remnants.Bio_Cannon.bio_cannon = {
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


-- Status report
BioInd.readdata_msg(BI.additional_remnants, settings,
                    "optional remnants", "setting")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
