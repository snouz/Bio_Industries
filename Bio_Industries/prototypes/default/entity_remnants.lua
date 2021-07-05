BioInd.entered_file()

--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])

local ICONPATH = BioInd.iconpath
local REMNANTPATH = BioInd.entitypath .. "remnants/"

BI.default_remnants = BI.default_remnants or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                     Remnants                                   --
------------------------------------------------------------------------------------
-- Bio farm
BI.default_remnants.bio_farm = {
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
}

-- Bio nursery (Greenhouse)
BI.default_remnants.bio_greenhouse = {
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
}

-- Cokery
BI.default_remnants.cokery = {
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
}

-- Bio reactor
BI.default_remnants.bio_reactor = {
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
}


BioInd.writeDebug("Read data for default remnants.")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
