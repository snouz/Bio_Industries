BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath
local WOODPATH = BioInd.entitypath .. "wood_products/"

local ENTITYPATH = "__base__/graphics/entity/"
local PIPEPATH = ENTITYPATH .. "pipe/"
local SNDPATH = "__base__/sound/"

require("prototypes.default.entity.entity_remnants_rail")

local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}

sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact

for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end

sounds.walking_sound = {}
for i = 1, 11 do
  sounds.walking_sound[i] = {
    filename = SNDPATH .. "walking/concrete-" .. (i < 10 and "0" or "")  .. i ..".ogg",
    volume = 1.2
  }
end

------------------------------------------------------------------------------------
--                                 Item subgroups                                 --
------------------------------------------------------------------------------------
local RAIL_FLAGS = {
  "placeable-neutral",
  "player-creation",
  "building-direction-8-way",
  "fast-replaceable-no-cross-type-while-moving"
}

-- Used for Wooden Pipe Pictures
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
--                                 Define entities                                --
------------------------------------------------------------------------------------
---- Wood Floor (Moved to prototypes/mod_compatibility/additional_entities.lua!)
data:extend({
  --~ {
    --~ type = "tile",
    --~ name = "bi-wood-floor",
    --~ needs_correction = false,
    --~ -- minable = {hardness = 0.2, mining_time = 0.5, result = "wood"},
    --~ minable = {hardness = 0.2, mining_time = 0.25, result = "wood"},
    --~ mined_sound = { filename = SNDPATH .. "deconstruct-bricks.ogg" },
    --~ collision_mask = {"ground-tile"},
    --~ walking_speed_modifier = 1.2,
    --~ layer = 59,
    --~ decorative_removal_probability = 0.4,
    --~ variants = {
      --~ main =
      --~ {
        --~ {
          --~ picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
          --~ count = 1,
          --~ size = 1
        --~ },
        --~ {
          --~ picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
          --~ count = 1,
          --~ size = 2,
          --~ probability = 0.39
        --~ },
        --~ {
          --~ picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
          --~ count = 1,
          --~ size = 4,
          --~ probability = 1
        --~ }
      --~ },


      --~ inner_corner =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_inner-corner.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_inner-corner.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ inner_corner_mask =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_inner-corner-mask.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_inner-corner-mask.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ outer_corner =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_outer-corner.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_outer-corner.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ outer_corner_mask =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_outer-corner-mask.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_outer-corner-mask.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },

      --~ side =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_side.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_side.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ side_mask =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_side-mask.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_side-mask.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ u_transition =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_u.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_u.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ u_transition_mask =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_u-mask.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_u-mask.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },

      --~ o_transition =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_o.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_o.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ o_transition_mask =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor_o-mask.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor_o-mask.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
      --~ material_background =
      --~ {
        --~ picture = WOODPATH .. "wood_floor/woodfloor.png",
        --~ count = 1,
        --~ hr_version =
        --~ {
          --~ picture = WOODPATH .. "wood_floor/hr_woodfloor.png",
          --~ count = 1,
          --~ scale = 0.5,
        --~ }
      --~ },
    --~ },
    --~ walking_sound = sounds.walking_sound,
    --~ map_color = {r = 139, g = 115, b = 85},
    --~ pollution_absorption_per_second = 0,
    --~ vehicle_friction_modifier = dirt_vehicle_speed_modifer
  --~ },

  --~ -- Big wooden pole
  --~ {
    --~ type = "electric-pole",
    --~ name = "bi-wooden-pole-big",
    --~ icon = ICONPATH .. "entity/big-wooden-pole.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ se_allow_in_space = true, -- Space Exploration - Buildable in orbit
    --~ flags = {"placeable-neutral", "player-creation"},
    --~ minable = {hardness = 0.2, mining_time = 0.5, result = "bi-wooden-pole-big"},
    --~ max_health = 150,
    --~ corpse = "bi-wooden-pole-big-remnant",
    --~ resistances = {
      --~ {
        --~ type = "fire",
        --~ percent = 100
      --~ },
      --~ {
        --~ type = "physical",
        --~ percent = 10
      --~ }
    --~ },
    --~ collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ drawing_box = {{-1, -6}, {1, 0.5}},
    --~ maximum_wire_distance = 24,
    --~ -- supply_area_distance = 2,
    --~ supply_area_distance = 1.5, -- This is the radius, so the supply area is 3x3.
    --~ pictures = {
      --~ layers = {
        --~ {
          --~ filename = WOODPATH .. "big-wooden-pole-01.png",
          --~ priority = "high",
          --~ width = 54,
          --~ height = 180,
          --~ axially_symmetrical = false,
          --~ direction_count = 1,
          --~ shift = {0, -2.5},
          --~ hr_version = {
            --~ filename = WOODPATH .. "hr_big-wooden-pole-01.png",
            --~ priority = "high",
            --~ width = 108,
            --~ height = 360,
            --~ axially_symmetrical = false,
            --~ direction_count = 1,
            --~ scale = 0.5,
            --~ shift = {0, -2.5},
          --~ },
        --~ },
        --~ {
          --~ filename = WOODPATH .. "big-wooden-pole-01_shadow.png",
          --~ priority = "high",
          --~ width = 180,
          --~ height = 20,
          --~ axially_symmetrical = false,
          --~ direction_count = 1,
          --~ shift = {2.2, 0},
          --~ draw_as_shadow = true,
          --~ hr_version = {
            --~ filename = WOODPATH .. "hr_big-wooden-pole-01_shadow.png",
            --~ priority = "high",
            --~ width = 360,
            --~ height = 40,
            --~ axially_symmetrical = false,
            --~ direction_count = 1,
            --~ scale = 0.5,
            --~ shift = {2.2, 0},
            --~ draw_as_shadow = true,
          --~ },
        --~ },
      --~ },
    --~ },
    --~ connection_points = {
      --~ {
        --~ shadow = {
          --~ copper = {3.3, -0},
          --~ green = {3.3, -0},
          --~ red = {3.3, -0}
        --~ },
         --~ wire = {
          --~ copper = {0.7, -4.3},
          --~ green = {0.7, -4.3},
          --~ red = {0.7, -4.3}
        --~ }
      --~ }
    --~ },
    --~ copper_wire_picture = {
      --~ filename = ENTITYPATH .. "/small-electric-pole/copper-wire.png",
      --~ priority = "extra-high-no-scale",
      --~ width = 224,
      --~ height = 46,
    --~ },
    --~ green_wire_picture = {
      --~ filename = ENTITYPATH .. "/small-electric-pole/green-wire.png",
      --~ priority = "extra-high-no-scale",
      --~ width = 224,
      --~ height = 46
    --~ },
    --~ red_wire_picture = {
      --~ filename = ENTITYPATH .. "/small-electric-pole/red-wire.png",
      --~ priority = "extra-high-no-scale",
      --~ width = 224,
      --~ height = 46
    --~ },
    --~ wire_shadow_picture = {
      --~ filename = ENTITYPATH .. "/small-electric-pole/wire-shadow.png",
      --~ priority = "extra-high-no-scale",
      --~ width = 224,
      --~ height = 46
    --~ },
    --~ radius_visualisation_picture = {
      --~ filename = ENTITYPATH .. "/small-electric-pole/electric-pole-radius-visualization.png",
      --~ width = 12,
      --~ height = 12
    --~ },
  --~ },

  --~ -- Huge Wooden Pole
  --~ {
    --~ type = "electric-pole",
    --~ name = "bi-wooden-pole-huge",
    --~ icon = ICONPATH .. "entity/huge-wooden-pole.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ se_allow_in_space = true, -- Space Exploration - Buildable in orbit
    --~ flags = {"placeable-neutral", "player-creation"},
    --~ minable = {hardness = 0.2, mining_time = 0.5, result = "bi-wooden-pole-huge"},
    --~ max_health = 250,
    --~ corpse = "bi-wooden-pole-huge-remnant",
    --~ resistances = {
      --~ {
        --~ type = "fire",
        --~ percent = 100
      --~ },
      --~ {
        --~ type = "physical",
        --~ percent = 10
      --~ }
    --~ },
    --~ collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ drawing_box = {{-1, -7}, {1, 0.5}},
    --~ maximum_wire_distance = 64, -- Factorio Maximum
    --~ supply_area_distance = 1.5, -- This is the radius, so the supply area is 3x3.
    --~ pictures = {
      --~ layers = {
        --~ {
          --~ filename = WOODPATH .. "huge_wooden_pole.png",
          --~ priority = "high",
          --~ width = 64,
          --~ height = 201,
          --~ direction_count = 4,
          --~ shift = {0, -2.76},
          --~ scale = 1,
          --~ hr_version ={
            --~ filename = WOODPATH .. "hr_huge_wooden_pole.png",
            --~ priority = "high",
            --~ width = 128,
            --~ height = 402,
            --~ direction_count = 4,
            --~ shift = {0, -2.76},
            --~ scale = 0.5,
          --~ }
        --~ },
        --~ {
          --~ filename = WOODPATH .. "huge_wooden_pole_shadow.png",
          --~ priority = "high",
          --~ width = 219,
          --~ height = 49,
          --~ direction_count = 4,
          --~ shift = {2.6, 0},
          --~ scale = 1,
          --~ draw_as_shadow = true,
          --~ hr_version ={
            --~ filename = WOODPATH .. "hr_huge_wooden_pole_shadow.png",
            --~ priority = "high",
            --~ width = 438,
            --~ height = 97,
            --~ direction_count = 4,
            --~ shift = {2.6, 0},
            --~ scale = 0.5,
            --~ draw_as_shadow = true,
          --~ }
        --~ },
      --~ },

    --~ },
    --~ connection_points = {
      --~ {
        --~ shadow = {
          --~ copper = {4.56, 0},
          --~ green = {3.84, 0},
          --~ red = {5.28, 0}
        --~ },
        --~ wire = {
          --~ copper = {0, -4.9},
          --~ green = {-0.475, -4.9},
          --~ red = {0.5, -4.9}
        --~ }
      --~ },
      --~ {
        --~ shadow = {
          --~ copper = {4.88, 0.1},
          --~ green = {4.24, -0.15},
          --~ red = {5.44, 0.3}
        --~ },
        --~ wire = {
          --~ copper = {0, -4.9},
          --~ green = {-0.4, -5.15},
          --~ red = {0.275, -4.65}
        --~ }
      --~ },
      --~ {
        --~ shadow = {
          --~ copper = {4.72, 0.03},
          --~ green = {4.8, -0.3},
          --~ red = {4.8, 0.4}
        --~ },
        --~ wire = {
          --~ copper = {0, -4.875},
          --~ green = {0, -5.225},
          --~ red = {0, -4.525}
        --~ }
      --~ },
      --~ {
        --~ shadow = {
          --~ copper = {4.88, 0.1},
          --~ green = {5.44, -0.15},
          --~ red = {4.28, 0.3}
        --~ },
        --~ wire = {
          --~ copper = {0, -4.95},
          --~ green = {0.3, -5.2},
          --~ red = {-0.375, -4.725}
        --~ }
      --~ }
    --~ },
    --~ radius_visualisation_picture = {
      --~ filename = ENTITYPATH .. "/small-electric-pole/electric-pole-radius-visualization.png",
      --~ width = 12,
      --~ height = 12,
      --~ priority = "extra-high-no-scale"
    --~ },
  --~ },

  --~ -- Wood Fence
  --~ {
    --~ type = "wall",
    --~ name = "bi-wooden-fence",
    --~ icon = ICONPATH .. "entity/wooden-fence.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "player-creation"},
    --~ collision_box = {{-0.29, -0.09}, {0.29, 0.49}},
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ minable = {mining_time = 1, result = "bi-wooden-fence"},
    --~ fast_replaceable_group = "wall",
    --~ max_health = 150,
    --~ repair_speed_modifier = 2,
    --~ corpse = "bi-wooden-fence-remnant",
    --~ repair_sound = { filename = SNDPATH .. "manual-repair-simple.ogg" },
    --~ --vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
    --~ vehicle_impact_sound = sounds.car_wood_impact,
    --~ resistances = {
      --~ {
        --~ type = "physical",
        --~ decrease = 2,
        --~ percent = 15
      --~ },
      --~ {
        --~ type = "fire",
        --~ percent = -25
      --~ },
      --~ {
        --~ type = "impact",
        --~ decrease = 15,
        --~ percent = 20
      --~ }
    --~ },
    --~ pictures = {
      --~ single = {
        --~ layers = {
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-single-1.png",
            --~ priority = "extra-high",
            --~ width = 14,
            --~ height = 92,
            --~ scale = 0.5,
            --~ shift = {0, -0.15625}
          --~ },
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-single-shadow.png",
            --~ priority = "extra-high",
            --~ width = 76,
            --~ height = 50,
            --~ scale = 0.5,
            --~ shift = {0.459375, 0.75},
            --~ draw_as_shadow = true
          --~ }
        --~ }
      --~ },
      --~ straight_vertical = {
        --~ {
          --~ layers = {
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-vertical-1.png",
              --~ priority = "extra-high",
              --~ width = 14,
              --~ height = 106,
              --~ scale = 0.5,
              --~ shift = {0, -0.15625}
            --~ },
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-vertical-shadow.png",
              --~ priority = "extra-high",
              --~ width = 78,
              --~ height = 132,
              --~ scale = 0.5,
              --~ shift = {0.490625, 1.425},
              --~ draw_as_shadow = true
            --~ }
          --~ }
        --~ },
        --~ {
          --~ layers = {
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-vertical-1.png",
              --~ priority = "extra-high",
              --~ width = 14,
              --~ height = 106,
              --~ scale = 0.5,
              --~ shift = {0, -0.15625}
            --~ },
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-vertical-shadow.png",
              --~ priority = "extra-high",
              --~ width = 78,
              --~ height = 132,
              --~ scale = 0.5,
              --~ shift = {0.490625, 1.425},
              --~ draw_as_shadow = true
            --~ }
          --~ }
        --~ },
        --~ {
          --~ layers = {
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-vertical-1.png",
              --~ priority = "extra-high",
              --~ width = 14,
              --~ height = 106,
              --~ scale = 0.5,
              --~ shift = {0, -0.15625}
            --~ },
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-vertical-shadow.png",
              --~ priority = "extra-high",
              --~ width = 78,
              --~ height = 132,
              --~ scale = 0.5,
              --~ shift = {0.490625, 1.425},
              --~ draw_as_shadow = true
            --~ }
          --~ }
        --~ }
      --~ },
      --~ straight_horizontal = {
        --~ {
          --~ layers = {
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-horizontal-1.png",
              --~ priority = "extra-high",
              --~ width = 68,
              --~ height = 94,
              --~ scale = 0.5,
              --~ shift = {0, -0.15625}
            --~ },
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-horizontal-shadow.png",
              --~ priority = "extra-high",
              --~ width = 168,
              --~ height = 56,
              --~ scale = 0.5,
              --~ shift = {0.421875, 0.85},
              --~ draw_as_shadow = true
            --~ }
          --~ }
        --~ },
        --~ {
          --~ layers = {
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-horizontal-2.png",
              --~ priority = "extra-high",
              --~ width = 68,
              --~ height = 94,
              --~ scale = 0.5,
              --~ shift = {0, -0.15625}
            --~ },
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-horizontal-shadow.png",
              --~ priority = "extra-high",
              --~ width = 168,
              --~ height = 56,
              --~ scale = 0.5,
              --~ shift = {0.421875, 0.85},
              --~ draw_as_shadow = true
            --~ }
          --~ }
        --~ },
        --~ {
          --~ layers = {
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-horizontal-3.png",
              --~ priority = "extra-high",
              --~ width = 68,
              --~ height = 94,
              --~ scale = 0.5,
              --~ shift = {0, -0.15625}
            --~ },
            --~ {
              --~ filename = WOODPATH .. "wood_fence/fence-straight-horizontal-shadow.png",
              --~ priority = "extra-high",
              --~ width = 168,
              --~ height = 56,
              --~ scale = 0.5,
              --~ shift = {0.421875, 0.85},
              --~ draw_as_shadow = true
            --~ }
          --~ }
        --~ }
      --~ },
      --~ corner_right_down = {
        --~ layers = {
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-corner-right-down.png",
            --~ priority = "extra-high",
            --~ width = 46,
            --~ height = 106,
            --~ scale = 0.5,
            --~ shift = {0.248125, -0.07625}
          --~ },
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-corner-right-down-shadow.png",
            --~ priority = "extra-high",
            --~ width = 104,
            --~ height = 112,
            --~ scale = 0.5,
            --~ shift = {0.724375, 1.30625},
            --~ draw_as_shadow = true
          --~ }
        --~ }
      --~ },
      --~ corner_left_down = {
        --~ layers = {
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-corner-left-down.png",
            --~ priority = "extra-high",
            --~ width = 42,
            --~ height = 106,
            --~ scale = 0.5,
            --~ shift = {-0.248125, -0.07625}
          --~ },
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-corner-left-down-shadow.png",
            --~ priority = "extra-high",
            --~ width = 120,
            --~ height = 112,
            --~ scale = 0.5,
            --~ shift = {0.128125, 1.30625},
            --~ draw_as_shadow = true
          --~ }
        --~ }
      --~ },
      --~ t_up = {
        --~ layers = {
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-t-down.png",
            --~ priority = "extra-high",
            --~ width = 68,
            --~ height = 106,
            --~ scale = 0.5,
            --~ shift = {0, -0.07625}
          --~ },
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-t-down-shadow.png",
            --~ priority = "extra-high",
            --~ width = 142,
            --~ height = 110,
            --~ scale = 0.5,
            --~ shift = {0.286875, 1.280625},
            --~ draw_as_shadow = true
          --~ }
        --~ }
      --~ },
      --~ ending_right = {
        --~ layers = {
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-ending-right.png",
            --~ priority = "extra-high",
            --~ width = 46,
            --~ height = 94,
            --~ scale = 0.5,
            --~ shift = {0.248125, -0.15625}
          --~ },
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-ending-right-shadow.png",
            --~ priority = "extra-high",
            --~ width = 98,
            --~ height = 54,
            --~ scale = 0.5,
            --~ shift = {0.684375, 0.85},
            --~ draw_as_shadow = true
          --~ }
        --~ }
      --~ },
      --~ ending_left = {
        --~ layers = {
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-ending-left.png",
            --~ priority = "extra-high",
            --~ width = 42,
            --~ height = 94,
            --~ scale = 0.5,
            --~ shift = {-0.248125, -0.15625}
          --~ },
          --~ {
            --~ filename = WOODPATH .. "wood_fence/fence-ending-left-shadow.png",
            --~ priority = "extra-high",
            --~ width = 126,
            --~ height = 54,
            --~ scale = 0.5,
            --~ shift = {0.128125, 0.85},
            --~ draw_as_shadow = true
          --~ }
        --~ }
      --~ }
    --~ }
  --~ },


  -- Straight wooden rails
  {
    type = "straight-rail",
    name = "bi-straight-rail-wood",
    localised_name = {"entity-name.bi-rail-wood"},
    localised_description = {"entity-description.bi-rail-wood"},
    icon = ICONPATH .. "entity/rail-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ flags = {
      --~ "placeable-neutral",
      --~ "player-creation",
      --~ "building-direction-8-way",
      --~ "fast-replaceable-no-cross-type-while-moving",
    --~ },
    flags = RAIL_FLAGS,
    --~ collision_mask = {"object-layer"},
    --~ collision_mask = BioInd.RAIL_MASK,
    minable = {mining_time = 0.25, result = "bi-rail-wood"},
    max_health = 60,
    corpse = "straight-rail-remnants-wood",
    resistances = {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "acid",
        percent = 60
      }
    },
    collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
    selection_box = {{-0.7, -0.8}, {0.7, 0.8}},
    rail_category = "regular",
    --fast_replaceable_group = "rail",
    --next_upgrade = "straight-rail",
    pictures = rail_pictures(),
  },


  -- Curved wooden rails
  {
    type = "curved-rail",
    name = "bi-curved-rail-wood",
    localised_name = {"entity-name.bi-rail-wood"},
    localised_description = {"entity-description.bi-rail-wood"},
    icon = ICONPATH .. "entity/rail-wood-curved.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ flags = {
      --~ "placeable-neutral",
      --~ "player-creation",
      --~ "building-direction-8-way",
      --~ "fast-replaceable-no-cross-type-while-moving"
    --~ },
    flags = RAIL_FLAGS,
    --~ collision_mask = {"object-layer"},
    --~ collision_mask = BioInd.RAIL_MASK,
    minable = {mining_time = 0.25, result = "bi-rail-wood", count = 4},
    max_health = 120,
    corpse = "curved-rail-remnants-wood",
    resistances = {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "acid",
        percent = 60
      }
    },
    collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
    secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
    selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
    rail_category = "regular",
    pictures = rail_pictures(),
    placeable_by = { item = "bi-rail-wood", count = 4}
  },

  -- Straight wooden rail bridge
  {
    type = "straight-rail",
    name = "bi-straight-rail-wood-bridge",
    localised_name = {"entity-name.bi-rail-wood-bridge"},
    localised_description = {"entity-description.bi-rail-wood-bridge"},
    icon = ICONPATH .. "entity/rail-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"placeable-neutral", "player-creation", "building-direction-8-way"},
    --~ collision_mask = {"object-layer"},
--~ collision_mask = { "item-layer", "object-layer"},
    --~ collision_mask = {"ground-tile", "floor-layer", "object-layer", "consider-tile-transitions"},
    --~ collision_mask = BioInd.RAIL_BRIDGE_MASK,
    minable = {mining_time = 0.5, result = "bi-rail-wood-bridge"},
    max_health = 60,
    corpse = "straight-rail-remnants-wood-bridge",
    collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
    selection_box = {{-0.7, -0.8}, {0.7, 0.8}},
    rail_category = "regular",
    pictures = rail_pictures(),
  },

  -- Curved wooden rail bridge
  {
    type = "curved-rail",
    name = "bi-curved-rail-wood-bridge",
    localised_name = {"entity-name.bi-rail-wood-bridge"},
    localised_description = {"entity-description.bi-rail-wood-bridge"},
    icon = ICONPATH .. "entity/rail-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {
      "placeable-neutral",
      "player-creation",
      "building-direction-8-way"
    },
    --~ collision_mask = {"object-layer"},
--~ collision_mask = { "floor-layer", "item-layer", "object-layer"},
    --~ collision_mask = {"ground-tile", "floor-layer", "object-layer", "consider-tile-transitions"},
    --~ collision_mask = BioInd.RAIL_BRIDGE_MASK,
    minable = {mining_time = 0.5, result = "bi-rail-wood-bridge", count = 4},
    max_health = 120,
    corpse = "curved-rail-remnants-wood-bridge",
    collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
    secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
    selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
    rail_category = "regular",
    pictures = rail_pictures(),
    placeable_by = { item = "bi-rail-wood-bridge", count = 4}
  },
})

--- Power straight Rail
data:extend({
  {
    type = "straight-rail",
    name = "bi-straight-rail-power",
    localised_name = {"entity-name.bi-rail-power"},
    localised_description = {"entity-description.bi-rail-power"},
    icon = ICONPATH .. "entity/rail-concrete-power.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {
      "placeable-neutral",
      "player-creation",
      "building-direction-8-way"
    },
    --~ collision_mask = {"object-layer"},
    --~ collision_mask = BioInd.RAIL_MASK,
    minable = {mining_time = 0.5, result = "bi-rail-power"},
    max_health = 60,
    corpse = "straight-rail-remnants",
    collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
    selection_box = {{-0.7, -0.8}, {0.7, 0.8}},
    rail_category = "regular",
    pictures = rail_pictures(),
  },
})

--- Power curved Rail
data:extend({
  {
    type = "curved-rail",
    name = "bi-curved-rail-power",
    localised_name = {"entity-name.bi-rail-power"},
    localised_description = {"entity-description.bi-rail-power"},
    icon = ICONPATH .. "entity/rail-concrete-power.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {
      "placeable-neutral",
      "player-creation",
      "building-direction-8-way",
    },
    --~ collision_mask = {"object-layer"},
    --~ collision_mask = BioInd.RAIL_MASK,
    minable = {mining_time = 0.5, result = "bi-rail-power", count = 4},
    max_health = 120,
    corpse = "curved-rail-remnants",
    collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
    secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
    selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
    rail_category = "regular",
    pictures = rail_pictures(),
    placeable_by = { item = "bi-rail-power", count = 4}
  }

--~ ---- Wood Pipe
 --~ {
    --~ type = "pipe",
    --~ name = "bi-wood-pipe",
    --~ icon = ICONPATH .. "entity/wood_pipe.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "player-creation"},
    --~ minable = {mining_time = 0.075, result = "bi-wood-pipe"},
    --~ max_health = 100,
    --~ corpse = "bi-wood-pipe-remnant",
    --~ resistances = {
      --~ {
        --~ type = "fire",
        --~ percent = 20
      --~ },
      --~ {
        --~ type = "impact",
        --~ percent = 30
      --~ }
    --~ },
    --~ fast_replaceable_group = "pipe",
    --~ collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ fluid_box = {
      --~ base_area = 1,
      --~ pipe_connections = {
        --~ { position = {0, -1} },
        --~ { position = {1, 0} },
        --~ { position = {0, 1} },
        --~ { position = {-1, 0} }
      --~ },
    --~ },
    --~ -- vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    --~ vehicle_impact_sound = sounds.generic_impact,
    --~ pictures = pipepictures_w(),
        --~ --pictures = pipe_pictures,
    --~ working_sound = {
      --~ sound = {
        --~ {
          --~ filename = SNDPATH .. "pipe.ogg",
          --~ volume = 0.85
        --~ },
      --~ },
      --~ match_volume_to_activity = true,
      --~ max_sounds_per_type = 3
    --~ },
    --~ horizontal_window_bounding_box = {{-0.25, -0.28125}, {0.25, 0.15625}},
    --~ vertical_window_bounding_box = {{-0.28125, -0.5}, {0.03125, 0.125}}
  --~ },

--~ ---- Wood Pipe to Ground
  --~ {
    --~ type = "pipe-to-ground",
    --~ name = "bi-wood-pipe-to-ground",
    --~ icon = ICONPATH .. "entity/pipe-to-ground-wood.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ flags = {"placeable-neutral", "player-creation"},
    --~ minable = {mining_time = 0.075, result = "bi-wood-pipe-to-ground"},
    --~ max_health = 150,
    --~ corpse = "bi-wood-pipe-remnant",
    --~ resistances = {
      --~ {
        --~ type = "fire",
        --~ percent = 20
      --~ },
      --~ {
        --~ type = "impact",
        --~ percent = 40
      --~ }
    --~ },
    --~ fast_replaceable_group = "pipe",
    --~ collision_box = {{-0.29, -0.29}, {0.29, 0.2}},
    --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    --~ fluid_box = {
      --~ base_area = 1,
      --~ pipe_covers = pipecoverspictures(),
      --~ pipe_connections = {
        --~ { position = {0, -1} },
        --~ {
          --~ position = {0, 1},
          --~ max_underground_distance = 10
        --~ }
      --~ },
    --~ },
    --~ underground_sprite = {
      --~ filename = "__core__/graphics/arrows/underground-lines.png",
      --~ priority = "extra-high-no-scale",
      --~ size = 64,
      --~ scale = 0.5
    --~ },
    --~ -- vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    --~ vehicle_impact_sound = sounds.generic_impact,
    --~ pictures = {
      --~ up = {
        --~ filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-up.png",
        --~ priority = "high",
        --~ size = 64, --, shift = {0.10, -0.04}
        --~ hr_version = {
          --~ filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-up.png",
          --~ priority = "extra-high",
          --~ size = 128,
          --~ scale = 0.5
        --~ }
      --~ },
      --~ down = {
        --~ filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-down.png",
        --~ priority = "high",
        --~ size = 64, --, shift = {0.05, 0}
        --~ hr_version = {
          --~ filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-down.png",
          --~ priority = "extra-high",
          --~ size = 128,
          --~ scale = 0.5
        --~ }
      --~ },
      --~ left = {
        --~ filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-left.png",
        --~ priority = "high",
        --~ size = 64, --, shift = {-0.12, 0.1}
        --~ hr_version = {
          --~ filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-left.png",
          --~ priority = "extra-high",
          --~ size = 128,
          --~ scale = 0.5
        --~ }
      --~ },
      --~ right = {
        --~ filename = ENTITYPATH .. "/pipe-to-ground/pipe-to-ground-right.png",
        --~ priority = "high",
        --~ size = 64, --, shift = {0.1, 0.1}
        --~ hr_version = {
          --~ filename = ENTITYPATH .. "/pipe-to-ground/hr-pipe-to-ground-right.png",
          --~ priority = "extra-high",
          --~ size = 128,
          --~ scale = 0.5
        --~ }
      --~ },
    --~ },
  --~ },
})


------ Power to Rail Pole

local my_pole = util.table.deepcopy(data.raw["electric-pole"]["medium-electric-pole"])
my_pole.name = "bi-power-to-rail-pole"
my_pole.icon = ICONPATH .. "entity/rail-concrete-power-pole.png"
my_pole.icon_size = 64
my_pole.BI_add_icon = true
my_pole.icon_mipmaps = 0
my_pole.minable = {mining_time = 1, result = "bi-power-to-rail-pole"}
--~ my_pole.maximum_wire_distance = 4
my_pole.maximum_wire_distance = BioInd.POWER_TO_RAIL_WIRE_DISTANCE
--my_pole.supply_area_distance = 3.5 -- 3 doesn't look right, 2.5 is too small -- already the default for medium-electric-pole
--~ my_pole.pictures.tint = {r = 183/255, g = 125/255, b = 62/255, a = 1}
my_pole.pictures.layers[1].hr_version.tint = {r = 0.9, g = 0.87, b = 0.23, a = 1}
my_pole.pictures.layers[1].tint = {r = 0.9, g = 0.87, b = 0.23, a = 0.5}
data:extend({my_pole})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
