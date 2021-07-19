------------------------------------------------------------------------------------
--                  Enable: Bio power production and distribution                 --
--                        (BI.Settings.BI_Power_Production)                       --
------------------------------------------------------------------------------------
local setting = "BI_Power_Production"
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
local ENTITYPATH = BioInd.entitypath
local SNDPATH = "__base__/sound/"

local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}

sounds.car_wood_impact = sound_def.car_wood_impact(1)
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
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
function solarboilerstructurelayer()
  return
  {
    layers = {
      {
        filename = ENTITYPATH .. "bio_solar_boiler/Bio_Solar_Boiler.png",
        priority = "low",
        width = 288,
        height = 288,
        scale = 1,
        hr_version = {
          filename = ENTITYPATH .. "bio_solar_boiler/hr_Bio_Solar_Boiler.png",
          priority = "low",
          width = 576,
          height = 576,
          scale = 0.5,
        }
      },
      {
        filename = ENTITYPATH .. "bio_solar_boiler/Bio_Solar_Boiler_shadow.png",
        priority = "high",
        width = 288,
        height = 288,
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "bio_solar_boiler/hr_Bio_Solar_Boiler_shadow.png",
          priority = "high",
          width = 576,
          height = 576,
          scale = 0.5,
          draw_as_shadow = true,
        },
      },
    },
  }
end

function solarboilerfireglow()
  return
  {
    filename = ENTITYPATH .. "bio_solar_boiler/Bio_Solar_Boiler_light.png",
    priority = "extra-high",
    frame_count = 1,
    width = 288,
    height = 288,
    scale = 1,
    draw_as_glow = true,
    blend_mode = "additive",
    hr_version = {
      filename = ENTITYPATH .. "bio_solar_boiler/hr_Bio_Solar_Boiler_light.png",
      priority = "extra-high",
      frame_count = 1,
      width = 576,
      height = 576,
      scale = 0.5,
      draw_as_glow = true,
      blend_mode = "additive",
    }
  }
end


------------------------------------------------------------------------------------
--                                 Define entities                                --
------------------------------------------------------------------------------------
-- Solar farm
BI.additional_entities[setting].solar_farm = {
  type = "solar-panel",
  name = "bi-bio-solar-farm",
  localised_description = {"entity-description.bi-bio-solar-farm", 60},
  icon = ICONPATH .. "entity/solar-panel-large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.25, mining_time = 0.5, result = "bi-bio-solar-farm"},
  max_health = 600,
  corpse = "bi-bio-solar-farm-remnant",
  dying_explosion = "medium-explosion",
  resistances = {{type = "fire", percent = 80}},
  collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  energy_source = {
    type = "electric",
    usage_priority = "solar",
  },
  picture = {
    layers = {
      {
        filename = ENTITYPATH .. "bio_solar_farm/Bio_Solar_Farm.png",
        width = 290,
        height = 300,
        frame_count = 1,
        direction_count = 1,
        scale = 1,
        shift = util.by_pixel(0, -10),
          hr_version = {
          filename = ENTITYPATH .. "bio_solar_farm/hr_Bio_Solar_Farm.png",
          width = 580,
          height = 600,
          scale = 0.5,
          frame_count = 1,
          direction_count = 1,
          shift = util.by_pixel(0, -10),
        }
      },
      {
        filename = ENTITYPATH .. "bio_solar_farm/Bio_Solar_Farm_shadow.png",
        width = 312,
        height = 289,
        frame_count = 1,
        direction_count = 1,
        scale = 1,
        shift = {0.3, 0},
        draw_as_shadow = true,
          hr_version = {
          filename = ENTITYPATH .. "bio_solar_farm/hr_Bio_Solar_Farm_shadow.png",
          width = 624,
          height = 578,
          scale = 0.5,
          frame_count = 1,
          direction_count = 1,
          shift = {0.3, 0},
          draw_as_shadow = true,
        }
      }
    }

  },
  production = "3600kW"
}


-- Huge accumulator
BI.additional_entities[setting].huge_accumulator = {
  type = "accumulator",
  name = "bi-bio-accumulator",
  localised_description = {"entity-description.bi-bio-accumulator", 60},
  icon = ICONPATH .. "entity/accumulator_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-accumulator"},
  max_health = 500,
  corpse = "bi-bio-accumulator-remnant",
  collision_box = {{-1.75, -1.75}, {1.75, 1.75}},
  selection_box = {{-2, -2}, {2, 2}},
  --collision_box = {{-2, -2}, {2, 2}},
  --selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
  energy_source = {
    type = "electric",
    buffer_capacity = "300MJ",
    usage_priority = "tertiary",
    input_flow_limit = "20MW",
    output_flow_limit = "20MW"
  },
  picture = {
    layers = {
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator.png",
        priority = "extra-high",
        width = 154,
        height = 181,
        scale = 1,
        shift = {0, -0.6},
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator.png",
          priority = "extra-high",
          width = 307,
          height = 362,
          scale = 0.5,
          shift = {0, -0.6},
        }
      },
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator_shadow.png",
        priority = "extra-high",
        width = 192,
        height = 136,
        frame_count = 1,
        line_length = 1,
        repeat_count = 24,
        shift = {1, 0},
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator_shadow.png",
          priority = "extra-high",
          width = 384,
          height = 272,
          frame_count = 1,
          line_length = 1,
          repeat_count = 24,
          shift = {1, 0},
          scale = 0.5,
          draw_as_shadow = true,
        }
      },
    },
  },
  charge_animation = {
    layers = {
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator.png",
        priority = "high",
        width = 154,
        height = 181,
        frame_count = 1,
        line_length = 1,
        repeat_count = 24,
        animation_speed = 0.4,
        shift = {0, -0.6},
        scale = 1,
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator.png",
          priority = "high",
          width = 307,
          height = 362,
          frame_count = 1,
          line_length = 1,
          repeat_count = 24,
          scale = 0.5,
          animation_speed = 0.4,
          shift = {0, -0.6},
        }
      },
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator_anim_charge.png",
        priority = "extra-high",
        width = 154,
        height = 181,
        line_length = 6,
        frame_count = 12,
        repeat_count = 2,
        draw_as_glow = true,
        shift = {0, -0.6},
        scale = 1,
        animation_speed = 0.3,
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator_anim_charge.png",
          priority = "extra-high",
          width = 307,
          height = 362,
          line_length = 6,
          frame_count = 12,
          repeat_count = 2,
          draw_as_glow = true,
          shift = {0, -0.6},
          scale = 0.5,
          animation_speed = 0.3,
        }
      },
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator_shadow.png",
        priority = "extra-high",
        width = 192,
        height = 136,
        frame_count = 1,
        line_length = 1,
        repeat_count = 24,
        shift = {1, 0},
        scale = 1,
        animation_speed = 0.3,
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator_shadow.png",
          priority = "extra-high",
          width = 384,
          height = 272,
          frame_count = 1,
          line_length = 1,
          repeat_count = 24,
          shift = {1, 0},
          scale = 0.5,
          animation_speed = 0.3,
          draw_as_shadow = true,
        }
      },
    },
  },
  charge_cooldown = 30,
  charge_light = {intensity = 0.3, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
  discharge_animation = {
    layers = {
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator.png",
        priority = "high",
        width = 154,
        height = 181,
        frame_count = 1,
        line_length = 1,
        repeat_count = 24,
        animation_speed = 0.4,
        scale = 1,
        shift = {0, -0.6},
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator.png",
          priority = "high",
          width = 307,
          height = 362,
          frame_count = 1,
          line_length = 1,
          repeat_count = 24,
          animation_speed = 0.4,
          scale = 0.5,
          shift = {0, -0.6},
        }
      },
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator_anim_discharge.png",
        priority = "extra-high",
        width = 154,
        height = 181,
        line_length = 6,
        frame_count = 24,
        draw_as_glow = true,
        shift = {0, -0.6},
        scale = 1,
        animation_speed = 0.4,
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator_anim_discharge.png",
          priority = "extra-high",
          width = 307,
          height = 362,
          line_length = 6,
          frame_count = 24,
          draw_as_glow = true,
          shift = {0, -0.6},
          scale = 0.5,
          animation_speed = 0.4,
        }
      },
      {
        filename = ENTITYPATH .. "large_accumulator/bi_large_accumulator_shadow.png",
        priority = "extra-high",
        width = 192,
        height = 136,
        frame_count = 1,
        line_length = 1,
        repeat_count = 24,
        animation_speed = 0.4,
        shift = {1, 0},
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "large_accumulator/hr_bi_large_accumulator_shadow.png",
          priority = "extra-high",
          width = 384,
          height = 272,
          frame_count = 1,
          line_length = 1,
          repeat_count = 24,
          animation_speed = 0.4,
          shift = {1, 0},
          scale = 0.5,
          draw_as_shadow = true,
        }
      },
    },
  },
  discharge_cooldown = 60,
  discharge_light = {intensity = 0.7, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
  vehicle_impact_sound = sounds.generic_impact,
  working_sound = {
    sound = {
      filename = SNDPATH .. "accumulator-working.ogg",
      volume = 1
    },
    idle_sound = {
      filename = SNDPATH .. "accumulator-idle.ogg",
      volume = 0.4
    },
    max_sounds_per_type = 5
  },
  circuit_wire_connection_point = {
    shadow = {
      red = {0.984375, 1.10938},
      green = {0.890625, 1.10938}
    },
    wire = {
      red = {0.6875, 0.59375},
      green = {0.6875, 0.71875}
    }
  },
  --circuit_connector_sprites = get_circuit_connector_sprites({0.46875, 0.5}, {0.46875, 0.8125}, 26),
  circuit_wire_max_distance = 9,
  default_output_signal = {type = "virtual", name = "signal-A"}
}


-- Huge substation
BI.additional_entities[setting].huge_substation = {
  type = "electric-pole",
  name = "bi-huge-substation",
  localised_name = {"entity-name.bi-huge-substation"},
  localised_description = {"entity-description.bi-huge-substation"},
  icon = ICONPATH .. "entity/substation_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-huge-substation"},
  max_health = 600,
  corpse = "bi-huge-substation-remnant",
  dying_explosion = "big-explosion",
  track_coverage_during_build_by_moving = true,
  resistances = {
    {
      type = "fire",
      percent = 90
    }
  },
  collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
  selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
  drawing_box = {{-2.5, -5}, {2.5, 2.5}},
  maximum_wire_distance = 25,
  -- Changed for 0.18.34/1.1.4
  --~ supply_area_distance = 50,
  supply_area_distance = 50.5,
  pictures = {
    layers = {
      {
        filename = ENTITYPATH .. "huge_substation/huge_substation.png",
        priority = "high",
        width = 192,
        height = 192,
        direction_count = 1,
        scale = 1,
        hr_version = {
          filename = ENTITYPATH .. "huge_substation/hr_huge_substation.png",
          priority = "high",
          width = 384,
          height = 384,
          direction_count = 1,
          scale = 0.5,
        }
      },
      {
        filename = ENTITYPATH .. "huge_substation/huge_substation_shadow.png",
        priority = "high",
        width = 192,
        height = 192,
        direction_count = 1,
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "huge_substation/hr_huge_substation_shadow.png",
          priority = "high",
          width = 384,
          height = 384,
          direction_count = 1,
          scale = 0.5,
          draw_as_shadow = true,
        }
      },
    }
  },
  vehicle_impact_sound = sounds.generic_impact,
  working_sound = {
    sound = { filename = SNDPATH .. "substation.ogg" },
    apparent_volume = 1.8,
    audible_distance_modifier = 0.5,
    probability = 1 / (3 * 60) -- average pause between the sound is 3 seconds
  },
  connection_points = {
    {
      shadow = {
        copper = {0, 0},
        green = {0, 0},
        red = {0, 0}
      },
      wire = {
        copper = {-0.08, -1.5},
        green = {-0.2, -1.4},
        red = {0, -1.6}
      }
    },
  },
  radius_visualisation_picture = {
    filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
    width = 12,
    height = 12,
    --scale = 3,
    --shift = {0.6, -0.6},
    priority = "extra-high-no-scale"
  },
}


-- Solar mat/Musk floor
BI.additional_entities[setting].solar_mat = {
  type = "tile",
  name = "bi-solar-mat",
  localised_name = {"entity-name.bi-solar-mat"},
  localised_description = {"entity-description.bi-solar-mat"},
  icon = ICONPATH .. "entity/solar-mat.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  needs_correction = false,
  minable = {hardness = 0.1, mining_time = 0.25, result = "bi-solar-mat"},
  mined_sound = { filename = SNDPATH .. "deconstruct-bricks.ogg" },
  --collision_mask = {"ground-tile", "not-colliding-with-itself"},
  collision_mask = {"ground-tile"},
  collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
  walking_speed_modifier = 1.45,
  layer = 67,
  decorative_removal_probability = 1,
  variants = {
    main = {
      {
        picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
        count = 1,
        size = 1
      },
      {
        picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
        count = 1,
        size = 2,
        probability = 0.39
      },
      {
        picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
        count = 1,
        size = 4,
        probability = 1
      }
    },


    inner_corner = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_inner-corner.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_inner-corner.png",
        count = 1,
        scale = 0.5,
      }
    },
    inner_corner_mask = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_inner-corner-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_inner-corner-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    outer_corner = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_outer-corner.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_outer-corner.png",
        count = 1,
        scale = 0.5,
      }
    },
    outer_corner_mask = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_outer-corner-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_outer-corner-mask.png",
        count = 1,
        scale = 0.5,
      }
    },

    side = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_side.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_side.png",
        count = 1,
        scale = 0.5,
      }
    },
    side_mask = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_side-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_side-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    u_transition = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_u.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_u.png",
        count = 1,
        scale = 0.5,
      }
    },
    u_transition_mask = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_u-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_u-mask.png",
        count = 1,
        scale = 0.5,
      }
    },

    o_transition = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_o.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_o.png",
        count = 1,
        scale = 0.5,
      }
    },
    o_transition_mask = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor_o-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor_o-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    material_background = {
      picture = ENTITYPATH .. "/solarfloor/solarfloor.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/solarfloor/hr_solarfloor.png",
        count = 1,
        scale = 0.5,
      }
    },
  },
  walking_sound = sounds.walking_sound,
  map_color = {r = 109, g = 110, b = 149},
  pollution_absorption_per_second = 0,
  vehicle_friction_modifier = 0.8
}


-- Solar plant + boiler
BI.additional_entities[setting].solar_boiler = {
  type = "boiler",
  name = "bi-solar-boiler",
  icon = ICONPATH .. "entity/solar-boiler.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 1, result = "bi-solar-boiler"},
  max_health = 400,
  corpse = "bi-solar-boiler-remnant",
  vehicle_impact_sound = sounds.generic_impact,
  mode = "output-to-separate-pipe",
  resistances = {
    {
      type = "fire",
      percent = 100
    },
    {
      type = "explosion",
      percent = 30
    },
    {
      type = "impact",
      percent = 30
    }
  },
  collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  target_temperature = 235,
  fluid_box = {
    base_area = 1,
    height = 2,
    base_level = -1,
    pipe_covers = pipecoverspictures(),
    pipe_connections = {
      {type = "input-output", position = {5, 0}},
      {type = "input-output", position = {-5, 0}},
    },
    production_type = "input-output",
    filter = "water"
  },
  output_fluid_box = {
    base_area = 1,
    height = 2,
    base_level = 1,
    pipe_covers = pipecoverspictures(),
    pipe_connections = {
      {type = "input-output", position = {0, 5}},
      {type = "input-output", position = {0, -5}},
    },
    production_type = "output",
    filter = "steam"
  },
  energy_consumption = "1.799MW",
  energy_source = {
    type = "electric",
    input_priority = "primary",
    usage_priority = "primary-input",
    --emissions_per_minute = 0 -- NO Emmisions
  },
  working_sound = {
    sound = {
      filename = SNDPATH .. "boiler.ogg",
      volume = 0.9
    },
    max_sounds_per_type = 3
  },
  structure = {
    north = solarboilerstructurelayer(),
    east = solarboilerstructurelayer(),
    south = solarboilerstructurelayer(),
    west = solarboilerstructurelayer(),
  },
  fire_flicker_enabled = false,
  fire = {},
  fire_glow_flicker_enabled = false,
  fire_glow = {
    north = solarboilerfireglow(),
    east = solarboilerfireglow(),
    south = solarboilerfireglow(),
    west = solarboilerfireglow(),
  },
  burning_cooldown = 20
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
