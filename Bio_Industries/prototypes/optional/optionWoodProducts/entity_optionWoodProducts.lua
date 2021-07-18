------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
local setting = "BI_Wood_Products"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end

BI.additional_entities = BI.additional_entities or {}
BI.additional_entities[setting] = BI.additional_entities[setting] or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local WOODPATH = BioInd.entitypath .. "wood_products/"

local ENTITYPATH = "__base__/graphics/entity/"
local PIPEPATH = ENTITYPATH .. "pipe/"

local SNDPATH = "__base__/sound/"

local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}

sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact

for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end

sounds.open_sound = { filename = "__base__/sound/wooden-chest-open.ogg" }
sounds.close_sound = { filename = SNDPATH .. "wooden-chest-close.ogg" }

sounds.walking_sound = {}
for i = 1, 11 do
  sounds.walking_sound[i] = {
    filename = SNDPATH .. "walking/concrete-" .. (i < 10 and "0" or "")  .. i ..".ogg",
    volume = 1.2
  }
end


------------------------------------------------------------------------------------
--                  Auxiliary function for pictures of Wood pipe                  --
------------------------------------------------------------------------------------
pipepictures_w = function()
  return {
    straight_vertical_single = {
      filename = PIPEPATH .. "pipe-straight-vertical-single.png",
      priority = "extra-high",
      width = 80,
      height = 80,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-straight-vertical-single.png",
        priority = "extra-high",
        width = 160,
        height = 160,
        scale = 0.5
      }
    },
    straight_vertical = {
      filename = PIPEPATH .. "pipe-straight-vertical.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-straight-vertical.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    straight_vertical_window = {
      filename = PIPEPATH .. "pipe-straight-vertical-window.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-straight-vertical-window.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    straight_horizontal_window = {
      filename = PIPEPATH .. "pipe-straight-horizontal-window.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-straight-horizontal-window.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    straight_horizontal = {
      filename = PIPEPATH .. "pipe-straight-horizontal.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-straight-horizontal.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    corner_up_right = {
      filename = PIPEPATH .. "pipe-corner-up-right.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-corner-up-right.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    corner_up_left = {
      filename = PIPEPATH .. "pipe-corner-up-left.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-corner-up-left.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    corner_down_right = {
      filename = PIPEPATH .. "pipe-corner-down-right.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-corner-down-right.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    corner_down_left = {
      filename = PIPEPATH .. "pipe-corner-down-left.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-corner-down-left.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    t_up = {
      filename = PIPEPATH .. "pipe-t-up.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-t-up.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    t_down = {
      filename = PIPEPATH .. "pipe-t-down.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-t-down.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    t_right = {
      filename = PIPEPATH .. "pipe-t-right.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-t-right.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    t_left = {
      filename = PIPEPATH .. "pipe-t-left.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-t-left.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    cross = {
      filename = PIPEPATH .. "pipe-cross.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-cross.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    ending_up = {
      filename = PIPEPATH .. "pipe-ending-up.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-ending-up.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    ending_down = {
      filename = PIPEPATH .. "pipe-ending-down.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-ending-down.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    ending_right = {
      filename = PIPEPATH .. "pipe-ending-right.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-ending-right.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    ending_left = {
      filename = PIPEPATH .. "pipe-ending-left.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-ending-left.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    horizontal_window_background = {
      filename = PIPEPATH .. "pipe-horizontal-window-background.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-horizontal-window-background.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    vertical_window_background = {
      filename = PIPEPATH .. "pipe-vertical-window-background.png",
      priority = "extra-high",
      size = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-vertical-window-background.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    fluid_background = {
      filename = PIPEPATH .. "fluid-background.png",
      priority = "extra-high",
      width = 32,
      height = 20,
      hr_version = {
        filename = PIPEPATH .. "hr-fluid-background.png",
        priority = "extra-high",
        width = 64,
        height = 40,
        scale = 0.5
      }
    },
    low_temperature_flow = {
      filename = PIPEPATH .. "fluid-flow-low-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 18
    },
    middle_temperature_flow = {
      filename = PIPEPATH .. "fluid-flow-medium-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 18
    },
    high_temperature_flow = {
      filename = PIPEPATH .. "fluid-flow-high-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 18
    },
    gas_flow = {
      filename = PIPEPATH .. "steam.png",
      priority = "extra-high",
      line_length = 10,
      width = 24,
      height = 15,
      frame_count = 60,
      axially_symmetrical = false,
      direction_count = 1,
      hr_version = {
        filename = PIPEPATH .. "hr-steam.png",
        priority = "extra-high",
        line_length = 10,
        width = 48,
        height = 30,
        frame_count = 60,
        axially_symmetrical = false,
        direction_count = 1
      }
    }
  }
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                   Entity data                                  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                              Bigger wooden chests!                             --
------------------------------------------------------------------------------------
-- Large wooden chest
BI.additional_entities[setting].large_wooden_chest = {
  type = "container",
  name = "bi-wooden-chest-large",
  icon = ICONPATH .. "entity/wood_chest_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 1, result = "bi-wooden-chest-large"},
  max_health = 200,
  corpse = "bi-wooden-chest-large-remnant",
  collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
  selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
  fast_replaceable_group = "container",
  inventory_size = 128, -- 64
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  vehicle_impact_sound = sounds.car_wood_impact,
  picture = {
    layers = {
      {
        filename = WOODPATH .. "chests/large_wooden_chest.png",
        priority = "extra-high",
        width = 64,
        height = 64,
        shift = {0, 0},
        scale = 1,
        hr_version = {
          filename = WOODPATH .. "chests/hr_large_wooden_chest.png",
          priority = "extra-high",
          width = 128,
          height = 128,
          shift = {0, 0},
          scale = 0.5,
        }
      },
      {
        filename = WOODPATH .. "chests/large_wooden_chest_shadow.png",
        priority = "extra-high",
        width = 64,
        height = 64,
        shift = {1, 0},
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = WOODPATH .. "chests/hr_large_wooden_chest_shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
          shift = {1, 0},
          scale = 0.5,
          draw_as_shadow = true,
        }
      },
    },
  },
  circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
  circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
  circuit_wire_max_distance = default_circuit_wire_max_distance
}


-- Huge wooden chest
BI.additional_entities[setting].huge_wooden_chest = {
  type = "container",
  name = "bi-wooden-chest-huge",
  icon = ICONPATH .. "entity/wood_chest_huge.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  scale_info_icons = false,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 1.5, result = "bi-wooden-chest-huge"},
  max_health = 350,
  corpse = "bi-wooden-chest-huge-remnant",
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  fast_replaceable_group = "container",
  inventory_size = 432, --144
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  vehicle_impact_sound = sounds.car_wood_impact,
  picture = {
    layers = {
      {
        filename = WOODPATH .. "chests/huge_wooden_chest.png",
        priority = "extra-high",
        width = 112,
        height = 112,
        shift = {0, 0},
        scale = 1,
        hr_version = {
          filename = WOODPATH .. "chests/hr_huge_wooden_chest.png",
          priority = "extra-high",
          width = 224,
          height = 224,
          shift = {0, 0},
          scale = 0.5,
        }
      },
      {
        filename = WOODPATH .. "chests/huge_wooden_chest_shadow.png",
        priority = "extra-high",
        width = 112,
        height = 112,
        shift = {1, 0},
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = WOODPATH .. "chests/hr_huge_wooden_chest_shadow.png",
          priority = "extra-high",
          width = 224,
          height = 224,
          shift = {1, 0},
          scale = 0.5,
          draw_as_shadow = true,
        }
      },
    },
  },
  circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
  circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
  circuit_wire_max_distance = default_circuit_wire_max_distance
}


-- Gigantic wooden chest
BI.additional_entities[setting].giga_wooden_chest = {
  type = "container",
  name = "bi-wooden-chest-giga",
  icon = ICONPATH .. "entity/wood_chest_giga.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  scale_info_icons = false,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 3.5, result = "bi-wooden-chest-giga"},
  max_health = 350,
  corpse = "bi-wooden-chest-giga-remnant",
  collision_box = {{-2.8, -2.8}, {2.8, 2.8}},
  selection_box = {{-3, -3}, {3, 3}},
  fast_replaceable_group = "container",
  inventory_size = 1728, --576
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  vehicle_impact_sound = sounds.car_wood_impact,
  picture = {
    layers = {
      {
        filename = WOODPATH .. "chests/giga_wooden_chest.png",
        priority = "extra-high",
        width = 192,
        height = 224,
        shift = {0, -0.5},
        scale = 1,
        hr_version = {
          filename = WOODPATH .. "chests/hr_giga_wooden_chest.png",
          priority = "extra-high",
          width = 384,
          height = 448,
          shift = {0, -0.5},
          scale = 0.5,
        }
      },
      {
        filename = WOODPATH .. "chests/giga_wooden_chest_shadow.png",
        priority = "extra-high",
        width = 96,
        height = 192,
        shift = {3.5, 0},
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = WOODPATH .. "chests/hr_giga_wooden_chest_shadow.png",
          priority = "extra-high",
          width = 192,
          height = 384,
          shift = {3.5, 0},
          scale = 0.5,
          draw_as_shadow = true,
        }
      }
    },
  },
  circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
  circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
  circuit_wire_max_distance = default_circuit_wire_max_distance
}


------------------------------------------------------------------------------------
--                               Bigger wooden poles                              --
------------------------------------------------------------------------------------
-- Big wooden pole
BI.additional_entities[setting].big_pole = {
  type = "electric-pole",
  name = "bi-wooden-pole-big",
  icon = ICONPATH .. "entity/wood_pole_big.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-wooden-pole-big"},
  max_health = 150,
  corpse = "bi-wooden-pole-big-remnant",
  resistances = {
    {
      type = "fire",
      percent = 100
    },
    {
      type = "physical",
      percent = 10
    }
  },
  collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  drawing_box = {{-1, -6}, {1, 0.5}},
  maximum_wire_distance = 24,
  --~ supply_area_distance = 2,
  supply_area_distance = 1.5, -- This is the radius, so the supply area is 3x3.
  pictures = {
    layers = {
      {
        filename = WOODPATH .. "poles/big-wooden-pole-01.png",
        priority = "high",
        width = 54,
        height = 180,
        axially_symmetrical = false,
        direction_count = 1,
        shift = util.by_pixel(0, -80),
        hr_version = {
          filename = WOODPATH .. "poles/hr_big-wooden-pole-01.png",
          priority = "high",
          width = 108,
          height = 360,
          axially_symmetrical = false,
          direction_count = 1,
          scale = 0.5,
          shift = util.by_pixel(0, -80),
        },
      },
      {
        filename = WOODPATH .. "poles/big-wooden-pole-01_shadow.png",
        priority = "high",
        width = 180,
        height = 20,
        axially_symmetrical = false,
        direction_count = 1,
        shift = util.by_pixel(70, 0),
        draw_as_shadow = true,
        hr_version = {
          filename = WOODPATH .. "poles/hr_big-wooden-pole-01_shadow.png",
          priority = "high",
          width = 360,
          height = 40,
          axially_symmetrical = false,
          direction_count = 1,
          scale = 0.5,
          shift = util.by_pixel(70, 0),
          draw_as_shadow = true,
        },
      },
    },
  },
  connection_points = {
    {
      shadow = {
        copper = {3.3, -0},
        green = {3.2, -0},
        red = {3.1, -0}
      },
       wire = {
        copper = util.by_pixel(24, -134),
        green = util.by_pixel(18, -133),
        red = util.by_pixel(11, -131),
      }
    }
  },
  copper_wire_picture = {
    filename = ENTITYPATH .. "/small-electric-pole/copper-wire.png",
    priority = "extra-high-no-scale",
    width = 224,
    height = 46,
  },
  green_wire_picture = {
    filename = ENTITYPATH .. "/small-electric-pole/green-wire.png",
    priority = "extra-high-no-scale",
    width = 224,
    height = 46
  },
  red_wire_picture = {
    filename = ENTITYPATH .. "/small-electric-pole/red-wire.png",
    priority = "extra-high-no-scale",
    width = 224,
    height = 46
  },
  wire_shadow_picture = {
    filename = ENTITYPATH .. "/small-electric-pole/wire-shadow.png",
    priority = "extra-high-no-scale",
    width = 224,
    height = 46
  },
  radius_visualisation_picture = {
    filename = ENTITYPATH .. "/small-electric-pole/electric-pole-radius-visualization.png",
    width = 12,
    height = 12
  },
}

-- Huge wooden pole
BI.additional_entities[setting].huge_pole = {
  type = "electric-pole",
  name = "bi-wooden-pole-huge",
  icon = ICONPATH .. "entity/wood_pole_huge.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-wooden-pole-huge"},
  max_health = 250,
  corpse = "bi-wooden-pole-huge-remnant",
  resistances = {
    {
      type = "fire",
      percent = 100
    },
    {
      type = "physical",
      percent = 10
    }
  },
  collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  drawing_box = {{-1, -7}, {1, 0.5}},
  maximum_wire_distance = 64, -- Factorio Maximum
  supply_area_distance = 1.5, -- This is the radius, so the supply area is 3x3.
  pictures = {
    layers = {
      {
        filename = WOODPATH .. "poles/huge_wooden_pole.png",
        priority = "high",
        width = 64,
        height = 201,
        direction_count = 4,
        shift = util.by_pixel(0, -88),
        scale = 1,
        hr_version ={
          filename = WOODPATH .. "poles/hr_huge_wooden_pole.png",
          priority = "high",
          width = 128,
          height = 402,
          direction_count = 4,
          shift = util.by_pixel(0, -88),
          scale = 0.5,
        }
      },
      {
        filename = WOODPATH .. "poles/huge_wooden_pole_shadow.png",
        priority = "high",
        width = 219,
        height = 49,
        direction_count = 4,
        shift = util.by_pixel(83, 0),
        scale = 1,
        draw_as_shadow = true,
        hr_version ={
          filename = WOODPATH .. "poles/hr_huge_wooden_pole_shadow.png",
          priority = "high",
          width = 438,
          height = 97,
          direction_count = 4,
          shift = util.by_pixel(83, 0),
          scale = 0.5,
          draw_as_shadow = true,
        }
      },
    },

  },
  connection_points = {
    {
      shadow = {
        copper = util.by_pixel(169, 5),
        green = util.by_pixel(154, 5),
        red = util.by_pixel(186, 5),
      },
      wire = {
        copper = util.by_pixel(0, -162),
        green = util.by_pixel(-24, -162),
        red = util.by_pixel(24, -162),
      }
    },
    {
      shadow = {
        copper = util.by_pixel(159, 2),
        green = util.by_pixel(156, -10),
        red = util.by_pixel(175, 15),
      },
      wire = {
        copper = util.by_pixel(-4, -163),
        green = util.by_pixel(-22, -171),
        red = util.by_pixel(15, -155),
      }
    },
    {
      shadow = {
        copper = util.by_pixel(173, 0),
        green = util.by_pixel(174, 17),
        red = util.by_pixel(171, -17),
      },
      wire = {
        copper = util.by_pixel(8, -166),
        green = util.by_pixel(8, -151),
        red = util.by_pixel(8, -182),
      }
    },
    {
      shadow = {
        copper = util.by_pixel(173, 2.5),
        green = util.by_pixel(166, 16),
        red = util.by_pixel(180, -11),
      },
      wire = {
        copper = util.by_pixel(5, -163),
        green = util.by_pixel(-13, -155),
        red = util.by_pixel(23, -171),
      }
    }
  },
  radius_visualisation_picture = {
    filename = ENTITYPATH .. "/small-electric-pole/electric-pole-radius-visualization.png",
    width = 12,
    height = 12,
    priority = "extra-high-no-scale"
  },
}


------------------------------------------------------------------------------------
--                                  Wooden pipes                                  --
------------------------------------------------------------------------------------
-- Wood Pipe
BI.additional_entities[setting].wood_pipe = {
  type = "pipe",
  name = "bi-wood-pipe",
  icon = ICONPATH .. "entity/wood_pipe.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 0.075, result = "bi-wood-pipe"},
  max_health = 100,
  corpse = "bi-wood-pipe-remnant",
  resistances = {
    {
      type = "fire",
      percent = 20
    },
    {
      type = "impact",
      percent = 30
    }
  },
  fast_replaceable_group = "pipe",
  collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  fluid_box = {
    base_area = 1,
    pipe_connections = {
      { position = {0, -1} },
      { position = {1, 0} },
      { position = {0, 1} },
      { position = {-1, 0} }
    },
  },
  vehicle_impact_sound = sounds.generic_impact,
  pictures = pipepictures_w(),
  working_sound = {
    sound = {
      {
        filename = SNDPATH .. "pipe.ogg",
        volume = 0.85
      },
    },
    match_volume_to_activity = true,
    max_sounds_per_type = 3
  },
  horizontal_window_bounding_box = {{-0.25, -0.28125}, {0.25, 0.15625}},
  vertical_window_bounding_box = {{-0.28125, -0.5}, {0.03125, 0.125}}
}

-- Wood Pipe to Ground
BI.additional_entities[setting].wood_pipe_to_ground = {
  type = "pipe-to-ground",
  name = "bi-wood-pipe-to-ground",
  icon = ICONPATH .. "entity/wood_pipe_to_ground.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 0.075, result = "bi-wood-pipe-to-ground"},
  max_health = 150,
  corpse = "bi-wood-pipe-remnant",
  resistances = {
    {
      type = "fire",
      percent = 20
    },
    {
      type = "impact",
      percent = 40
    }
  },
  fast_replaceable_group = "pipe",
  collision_box = {{-0.29, -0.29}, {0.29, 0.2}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  fluid_box = {
    base_area = 1,
    pipe_covers = pipecoverspictures(),
    pipe_connections = {
      { position = {0, -1} },
      {
        position = {0, 1},
        max_underground_distance = 10
      }
    },
  },
  underground_sprite = {
    filename = "__core__/graphics/arrows/underground-lines.png",
    priority = "extra-high-no-scale",
    size = 64,
    scale = 0.5
  },
  --~ vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  vehicle_impact_sound = sounds.generic_impact,
  pictures = {
    up = {
      filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-up.png",
      priority = "high",
      size = 64, --, shift = {0.10, -0.04}
      hr_version = {
        filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-up.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    down = {
      filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-down.png",
      priority = "high",
      size = 64, --, shift = {0.05, 0}
      hr_version = {
        filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-down.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    left = {
      filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-left.png",
      priority = "high",
      size = 64, --, shift = {-0.12, 0.1}
      hr_version = {
        filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-left.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
    right = {
      filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-right.png",
      priority = "high",
      size = 64, --, shift = {0.1, 0.1}
      hr_version = {
        filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-right.png",
        priority = "extra-high",
        size = 128,
        scale = 0.5
      }
    },
  },
}


------------------------------------------------------------------------------------
--                          Create entities and remnants                          --
------------------------------------------------------------------------------------
for e, e_data in pairs(BI.additional_entities[setting] or {}) do
  -- Entity
  BioInd.create_stuff(e_data)

  -- Remnants, if they exist
  BioInd.make_remnants_for_entity(BI.additional_remnants[setting], e_data)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
