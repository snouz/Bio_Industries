BI.entered_file()

local BioInd = require('common')('Bio_Industries')

--~ local ICONPATH = BioInd.modRoot .. "/graphics/entities/biofarm/"
local ICONPATH = BioInd.iconpath
local REMNANTPATH = BioInd.entitypath .. "remnants/"

--~ local BIGICONS = BioInd.check_base_version()

require ("util")


------------------------------------------------------------------------------------
--                                     Remnants                                   --
------------------------------------------------------------------------------------
data:extend({
  -- Bio farm
  {
    type = "corpse",
    name = "bi-bio-farm-remnant",
    localised_name = {"entity-name.bi-bio-farm-remnant"},
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
      filename = REMNANTPATH .. "bio_farm_remnant.png",
      line_length = 1,
      width = 364,
      height = 400,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -1.5},
      hr_version =
      {
        filename = REMNANTPATH .. "hr_bio_farm_remnant.png",
        line_length = 1,
        width = 728,
        height = 800,
        frame_count = 1,
        direction_count = 1,
        shift = {0, -1.5},
        scale = 0.5
      }
    }
  },

  -- Bio nursery
  {
    type = "corpse",
    name = "bi-bio-greenhouse-remnant",
    localised_name = {"entity-name.bi-bio-greenhouse-remnant"},
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
      filename = REMNANTPATH .. "bio_greenhouse_remnant.png",
      line_length = 1,
      width = 192,
      height = 192,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.5},
      hr_version =
      {
        filename = REMNANTPATH .. "hr_bio_greenhouse_remnant.png",
        line_length = 1,
        width = 384,
        height = 384,
        frame_count = 1,
        direction_count = 1,
        shift = {0, -0.5},
        scale = 0.5
      }
    }
  },

  -- Cokery
  {
    type = "corpse",
    name = "bi-cokery-remnant",
    localised_name = {"entity-name.bi-cokery-remnant"},
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
      filename = REMNANTPATH .. "cokery_remnant.png",
      line_length = 1,
      width = 128,
      height = 128,
      frame_count = 1,
      direction_count = 1,
      shift = {0.5, -0.5},
      hr_version =
      {
        filename = REMNANTPATH .. "hr_cokery_remnant.png",
        line_length = 1,
        width = 256,
        height = 256,
        frame_count = 1,
        direction_count = 1,
        shift = {0.5, -0.5},
        scale = 0.5
      }
    }
  },

  -- Stone crusher
  {
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
  },

  -- Bio reactor
  {
    type = "corpse",
    name = "bi-bio-reactor-remnant",
    localised_name = {"entity-name.bi-bio-reactor-remnant"},
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
      filename = REMNANTPATH .. "bioreactor_remnant.png",
      line_length = 1,
      width = 91,
      height = 128,
      frame_count = 1,
      direction_count = 1,
      shift = {0, -0.5},
      hr_version =
      {
        filename = REMNANTPATH .. "hr_bioreactor_remnant.png",
        line_length = 1,
        width = 182,
        height = 256,
        frame_count = 1,
        direction_count = 1,
        shift = {0, -0.5},
        scale = 0.5
      }
    }
  },

  -- Terraformer
  {
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
  },

  -- Bio garden
  {
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
  },

  -- Large Bio garden
  {
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
  },

  -- Huge Bio garden
  {
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
  },


  --~ -- Large wooden pole
  --~ {
    --~ type = "corpse",
    --~ name = "bi-wooden-pole-big-remnant",
    --~ localised_name = {"entity-name.bi-wooden-pole-big-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ tile_width = 1,
    --~ tile_height = 1,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "big-wooden-pole-01_remnant.png",
      --~ line_length = 1,
      --~ width = 54,
      --~ height = 180,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0, -2.5},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_big-wooden-pole-01_remnant.png",
        --~ line_length = 1,
        --~ width = 108,
        --~ height = 360,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0, -2.5},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Huge wooden pole
  --~ {
    --~ type = "corpse",
    --~ name = "bi-wooden-pole-huge-remnant",
    --~ localised_name = {"entity-name.bi-wooden-pole-huge-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ tile_width = 1,
    --~ tile_height = 1,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "huge_wooden_pole_remnant.png",
      --~ line_length = 1,
      --~ width = 64,
      --~ height = 201,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0, -2.76},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_huge_wooden_pole_remnant.png",
        --~ line_length = 1,
        --~ width = 128,
        --~ height = 402,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0, -2.76},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Wooden fence
  --~ {
    --~ type = "corpse",
    --~ name = "bi-wooden-fence-remnant",
    --~ localised_name = {"entity-name.bi-wooden-fence-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ tile_width = 1,
    --~ tile_height = 1,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "wooden_fence_remnant.png",
      --~ line_length = 1,
      --~ width = 64,
      --~ height = 64,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0, 0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_wooden_fence_remnant.png",
        --~ line_length = 1,
        --~ width = 128,
        --~ height = 128,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0, 0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Wooden pipe
  --~ {
    --~ type = "corpse",
    --~ name = "bi-wood-pipe-remnant",
    --~ localised_name = {"entity-name.bi-wood-pipe-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ tile_width = 1,
    --~ tile_height = 1,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "woodpipe_remnant.png",
      --~ line_length = 1,
      --~ width = 64,
      --~ height = 64,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0,0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_woodpipe_remnant.png",
        --~ line_length = 1,
        --~ width = 128,
        --~ height = 128,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0,0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Dart turret
  --~ {
    --~ type = "corpse",
    --~ name = "bi-dart-turret-remnant",
    --~ localised_name = {"entity-name.bi-dart-turret-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-0.5, -0.5 }, {0.5, 0.5}},
    --~ tile_width = 1,
    --~ tile_height = 1,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "bio_turret_remnant.png",
      --~ line_length = 1,
      --~ width = 112,
      --~ height = 80,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0.25, -0.25},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_bio_turret_remnant.png",
        --~ line_length = 1,
        --~ width = 224,
        --~ height = 160,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0.25, -0.25},
        --~ scale = 0.5,
      --~ }
    --~ }
  --~ },

  --~ -- Medium wooden chest
  --~ {
    --~ type = "corpse",
    --~ name = "bi-wooden-chest-large-remnant",
    --~ localised_name = {"entity-name.bi-wooden-chest-large-remnant"},
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
      --~ filename = REMNANTPATH .. "large_wooden_chest_remnant.png",
      --~ line_length = 1,
      --~ width = 128,
      --~ height = 128,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0,0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_large_wooden_chest_remnant.png",
        --~ line_length = 1,
        --~ width = 256,
        --~ height = 256,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0,0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Big wooden chest
  --~ {
    --~ type = "corpse",
    --~ name = "bi-wooden-chest-huge-remnant",
    --~ localised_name = {"entity-name.bi-wooden-chest-huge-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    --~ tile_width = 3,
    --~ tile_height = 3,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "huge_wooden_chest_remnant.png",
      --~ line_length = 1,
      --~ width = 168,
      --~ height = 168,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0,0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_huge_wooden_chest_remnant.png",
        --~ line_length = 1,
        --~ width = 336,
        --~ height = 336,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0,0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Huge wooden chest
  --~ {
    --~ type = "corpse",
    --~ name = "bi-wooden-chest-giga-remnant",
    --~ localised_name = {"entity-name.bi-wooden-chest-giga-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-3, -3}, {3, 3}},
    --~ tile_width = 6,
    --~ tile_height = 6,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "giga_wooden_chest_remnant.png",
      --~ line_length = 1,
      --~ width = 288,
      --~ height = 288,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0, -0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_giga_wooden_chest_remnant.png",
        --~ line_length = 1,
        --~ width = 576,
        --~ height = 576,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0, -0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Solar farm
  --~ {
    --~ type = "corpse",
    --~ name = "bi-bio-solar-farm-remnant",
    --~ localised_name = {"entity-name.bi-bio-solar-farm-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    --~ tile_width = 9,
    --~ tile_height = 9,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "bio_solar_farm_remnant.png",
      --~ line_length = 1,
      --~ width = 312,
      --~ height = 289,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0.3, 0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_bio_solar_farm_remnant.png",
        --~ line_length = 1,
        --~ width = 624,
        --~ height = 578,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0.3, 0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Huge accumulator
  --~ {
    --~ type = "corpse",
    --~ name = "bi-bio-accumulator-remnant",
    --~ localised_name = {"entity-name.bi-bio-accumulator-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-2, -2}, {2, 2}},
    --~ tile_width = 4,
    --~ tile_height = 4,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "bi_large_accumulator_remnant.png",
      --~ line_length = 1,
      --~ width = 154,
      --~ height = 181,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0, -0.6},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_bi_large_accumulator_remnant.png",
        --~ line_length = 1,
        --~ width = 307,
        --~ height = 362,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0, -0.6},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Huge substation
  --~ {
    --~ type = "corpse",
    --~ name = "bi-huge-substation-remnant",
    --~ localised_name = {"entity-name.bi-huge-substation-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    --~ tile_width = 5,
    --~ tile_height = 5,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "huge_substation_remnant.png",
      --~ line_length = 1,
      --~ width = 192,
      --~ height = 192,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0,0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_huge_substation_remnant.png",
        --~ line_length = 1,
        --~ width = 384,
        --~ height = 384,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0,0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },

  --~ -- Solar plant and boiler
  --~ {
    --~ type = "corpse",
    --~ name = "bi-solar-boiler-remnant",
    --~ localised_name = {"entity-name.bi-solar-boiler-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    --~ tile_width = 9,
    --~ tile_height = 9,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "bio_solar_boiler_remnant.png",
      --~ line_length = 1,
      --~ width = 288,
      --~ height = 288,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0,0},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_bio_solar_boiler_remnant.png",
        --~ line_length = 1,
        --~ width = 576,
        --~ height = 576,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0,0},
        --~ scale = 0.5
      --~ }
    --~ }
  --~ },


  --~ -- Bio cannon
  --~ {
    --~ type = "corpse",
    --~ name = "bi-bio-cannon-remnant",
    --~ localised_name = {"entity-name.bi-bio-cannon-remnant"},
    --~ icon = "__base__/graphics/icons/remnants.png",
    --~ icon_size = 64,
    --~ icon_mipmaps = 4,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --~ subgroup = "remnants",
    --~ order = "z-z-z",
    --~ selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    --~ tile_width = 9,
    --~ tile_height = 9,
    --~ selectable_in_game = false,
    --~ time_before_removed = 60 * 60 * 15, -- 15 minutes
    --~ final_render_layer = "remnants",
    --~ remove_on_tile_placement = false,
    --~ animation =
    --~ {
      --~ filename = REMNANTPATH .. "bio_cannon_remnant.png",
      --~ line_length = 1,
      --~ width = 346,
      --~ height = 336,
      --~ frame_count = 1,
      --~ direction_count = 1,
      --~ shift = {0, -0.75},
      --~ hr_version =
      --~ {
        --~ filename = REMNANTPATH .. "hr_bio_cannon_remnant.png",
        --~ line_length = 1,
        --~ width = 692,
        --~ height = 672,
        --~ frame_count = 1,
        --~ direction_count = 1,
        --~ shift = {0, -0.75},
        --~ scale = 0.5,
      --~ }
    --~ }
  --~ },
})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
