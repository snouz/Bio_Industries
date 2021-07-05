------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Fuel"
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
local NATIVEBOILERPATH = "__base__/graphics/entity/boiler/"
local MODBOILERPATH = BioInd.entitypath .. "bio_boiler/"

local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}

sounds.generic_impact = sound_def.generic_impact
for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end

local bio_boiler_tint = {r = 0.5, g = 0.5, b = 0.1, a = 0.7}


------------------------------------------------------------------------------------
--                               Entity definitions                               --
------------------------------------------------------------------------------------
-- Bio Boiler
BI.additional_entities[setting].bio_boiler = {
  type = "boiler",
  name = "bi-bio-boiler",
  localised_name = {"entity-name.bi-bio-boiler"},
  localised_description = {"entity-description.bi-bio-boiler"},
  icon = ICONPATH .. "entity/bio_boiler.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-boiler"},
  max_health = 300,
  corpse = "boiler-remnants",
  vehicle_impact_sound = sounds.generic_impact,
  mode = "output-to-separate-pipe",
  resistances = {
    {
      type = "fire",
      percent = 100
    },
    {
      type = "explosion",
      percent = 100
    },
    {
      type = "impact",
      percent = 35
    }
  },
  collision_box = {{-1.29, -0.79}, {1.29, 0.79}},
  selection_box = {{-1.5, -1}, {1.5, 1}},
  target_temperature = 165,
  fluid_box = {
    base_area = 1,
    height = 2,
    base_level = -1,
    pipe_covers = pipecoverspictures(),
    pipe_connections = {
      {type = "input-output", position = {-2, 0.5}},
      {type = "input-output", position = {2, 0.5}}
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
      {type = "output", position = {0, -1.5}}
    },
    production_type = "output",
    filter = "steam"
  },
  energy_consumption = "3.6MW",
  energy_source = {
    type = "burner",
    fuel_category = "chemical",
    effectivity = 1,
    fuel_inventory_size = 2,
    emissions_per_minute = 15,
    smoke = {
      {
        name = "smoke",
        north_position = util.by_pixel(-38, -47.5),
        south_position = util.by_pixel(38.5, -32),
        east_position = util.by_pixel(20, -70),
        west_position = util.by_pixel(-19, -8.5),
        frequency = 20,
        starting_vertical_speed = 0.0,
        starting_frame_deviation = 60
      }
    }
  },
  working_sound = {
    sound = {
      filename = "__base__/sound/boiler.ogg",
      volume = 0.8
    },
    max_sounds_per_type = 3
  },
  structure = {
    north = {
    layers = {
      {
        filename = MODBOILERPATH .. "boiler-N-idle.png",
        priority = "extra-high",
        width = 131,
        height = 108,
        shift = util.by_pixel(-0.5, 4),
        hr_version = {
          filename = MODBOILERPATH .. "hr-boiler-N-idle.png",
          priority = "extra-high",
          width = 269,
          height = 221,
          shift = util.by_pixel(-1.25, 5.25),
          scale = 0.5,
        }
      },
      {
        filename = NATIVEBOILERPATH .. "boiler-N-shadow.png",
        priority = "extra-high",
        width = 137,
        height = 82,
        shift = util.by_pixel(20.5, 9),
        draw_as_shadow = true,
        hr_version = {
          filename = NATIVEBOILERPATH .. "hr-boiler-N-shadow.png",
          priority = "extra-high",
          width = 274,
          height = 164,
          scale = 0.5,
          shift = util.by_pixel(20.5, 9),
          draw_as_shadow = true,
        }
      }
    }
  },
  east = {
    layers = {
      {
        filename = MODBOILERPATH .. "boiler-E-idle.png",
        priority = "extra-high",
        width = 105,
        height = 147,
        shift = util.by_pixel(-3.5, -0.5),
        hr_version = {
          filename = MODBOILERPATH .. "hr-boiler-E-idle.png",
          priority = "extra-high",
          width = 216,
          height = 301,
          shift = util.by_pixel(-3, 1.25),
          scale = 0.5,
        }
      },
      {
        filename = NATIVEBOILERPATH .. "boiler-E-shadow.png",
        priority = "extra-high",
        width = 92,
        height = 97,
        shift = util.by_pixel(30, 9.5),
        draw_as_shadow = true,
        hr_version = {
          filename = NATIVEBOILERPATH .. "hr-boiler-E-shadow.png",
          priority = "extra-high",
          width = 184,
          height = 194,
          scale = 0.5,
          shift = util.by_pixel(30, 9.5),
          draw_as_shadow = true,
        }
      }
    }
  },
  south = {
    layers = {
      {
        filename = MODBOILERPATH .. "boiler-S-idle.png",
        priority = "extra-high",
        width = 128,
        height = 95,
        shift = util.by_pixel(3, 12.5),
        hr_version = {
          filename = MODBOILERPATH .. "hr-boiler-S-idle.png",
          priority = "extra-high",
          width = 260,
          height = 192,
          shift = util.by_pixel(4, 13),
          scale = 0.5,
        }
      },
      {
        filename = NATIVEBOILERPATH .. "boiler-S-shadow.png",
        priority = "extra-high",
        width = 156,
        height = 66,
        shift = util.by_pixel(30, 16),
        draw_as_shadow = true,
        hr_version = {
          filename = NATIVEBOILERPATH .. "hr-boiler-S-shadow.png",
          priority = "extra-high",
          width = 311,
          height = 131,
          scale = 0.5,
          shift = util.by_pixel(29.75, 15.75),
          draw_as_shadow = true,
        }
      }
    }
  },
  west = {
    layers = {
      {
        filename = MODBOILERPATH .. "boiler-W-idle.png",
        priority = "extra-high",
        width = 96,
        height = 132,
        shift = util.by_pixel(1, 5),
        hr_version = {
          filename = MODBOILERPATH .. "hr-boiler-W-idle.png",
          priority = "extra-high",
          width = 196,
          height = 273,
          shift = util.by_pixel(1.5, 7.75),
          scale = 0.5,
        }
      },
      {
        filename = NATIVEBOILERPATH .. "boiler-W-shadow.png",
        priority = "extra-high",
        width = 103,
        height = 109,
        shift = util.by_pixel(19.5, 6.5),
        draw_as_shadow = true,
        hr_version = {
          filename = NATIVEBOILERPATH .. "hr-boiler-W-shadow.png",
          priority = "extra-high",
          width = 206,
          height = 218,
          scale = 0.5,
          shift = util.by_pixel(19.5, 6.5),
          draw_as_shadow = true,
        }
      }
    }
  }
},
patch = {
  east = {
    filename = NATIVEBOILERPATH .. "boiler-E-patch.png",
    priority = "extra-high",
    width = 3,
    height = 17,
    tint = bio_boiler_tint,
    shift = util.by_pixel(33.5, -13.5),
    hr_version = {
      filename = NATIVEBOILERPATH .. "hr-boiler-E-patch.png",
      width = 6,
      height = 36,
      shift = util.by_pixel(33.5, -13.5),
      scale = 0.5,
      tint = bio_boiler_tint,
    }
  },
},
fire_flicker_enabled = true,
  fire = {
    north = {
      filename = NATIVEBOILERPATH .. "boiler-N-fire.png",
      priority = "extra-high",
      frame_count = 64,
      line_length = 8,
      width = 12,
      height = 13,
      animation_speed = 0.5,
      shift = util.by_pixel(0, -8.5),
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-N-fire.png",
        priority = "extra-high",
        frame_count = 64,
        line_length = 8,
        width = 26,
        height = 26,
        animation_speed = 0.5,
        shift = util.by_pixel(0, -8.5),
        scale = 0.5
      }
    },
    east = {
      filename = NATIVEBOILERPATH .. "boiler-E-fire.png",
      priority = "extra-high",
      frame_count = 64,
      line_length = 8,
      width = 14,
      height = 14,
      animation_speed = 0.5,
      shift = util.by_pixel(-10, -22),
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-E-fire.png",
        priority = "extra-high",
        frame_count = 64,
        line_length = 8,
        width = 28,
        height = 28,
        animation_speed = 0.5,
        shift = util.by_pixel(-9.5, -22),
        scale = 0.5
      }
    },
    south = {
      filename = NATIVEBOILERPATH .. "boiler-S-fire.png",
      priority = "extra-high",
      frame_count = 64,
      line_length = 8,
      width = 12,
      height = 9,
      animation_speed = 0.5,
      shift = util.by_pixel(-1, -26.5),
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-S-fire.png",
        priority = "extra-high",
        frame_count = 64,
        line_length = 8,
        width = 26,
        height = 16,
        animation_speed = 0.5,
        shift = util.by_pixel(-1, -26.5),
        scale = 0.5
      }
    },
    west = {
      filename = NATIVEBOILERPATH .. "boiler-W-fire.png",
      priority = "extra-high",
      frame_count = 64,
      line_length = 8,
      width = 14,
      height = 14,
      animation_speed = 0.5,
      shift = util.by_pixel(13, -23),
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-W-fire.png",
        priority = "extra-high",
        frame_count = 64,
        line_length = 8,
        width = 30,
        height = 29,
        animation_speed = 0.5,
        shift = util.by_pixel(13, -23.25),
        scale = 0.5
      }
    }
  },
  fire_glow_flicker_enabled = true,
  fire_glow = {
    north = {
      filename = NATIVEBOILERPATH .. "boiler-N-light.png",
      priority = "extra-high",
      frame_count = 1,
      width = 100,
      height = 87,
      shift = util.by_pixel(-1, -6.5),
      blend_mode = "additive",
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-N-light.png",
        priority = "extra-high",
        frame_count = 1,
        width = 200,
        height = 173,
        shift = util.by_pixel(-1, -6.75),
        blend_mode = "additive",
        scale = 0.5
      }
    },
    east = {
      filename = NATIVEBOILERPATH .. "boiler-E-light.png",
      priority = "extra-high",
      frame_count = 1,
      width = 70,
      height = 122,
      shift = util.by_pixel(0, -13),
      blend_mode = "additive",
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-E-light.png",
        priority = "extra-high",
        frame_count = 1,
        width = 139,
        height = 244,
        shift = util.by_pixel(0.25, -13),
        blend_mode = "additive",
        scale = 0.5
      }
    },
    south = {
      filename = NATIVEBOILERPATH .. "boiler-S-light.png",
      priority = "extra-high",
      frame_count = 1,
      width = 100,
      height = 81,
      shift = util.by_pixel(1, 5.5),
      blend_mode = "additive",
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-S-light.png",
        priority = "extra-high",
        frame_count = 1,
        width = 200,
        height = 162,
        shift = util.by_pixel(1, 5.5),
        blend_mode = "additive",
        scale = 0.5
      }
    },
    west = {
      filename = NATIVEBOILERPATH .. "boiler-W-light.png",
      priority = "extra-high",
      frame_count = 1,
      width = 68,
      height = 109,
      shift = util.by_pixel(2, -6.5),
      blend_mode = "additive",
      hr_version = {
        filename = NATIVEBOILERPATH .. "hr-boiler-W-light.png",
        priority = "extra-high",
        frame_count = 1,
        width = 136,
        height = 217,
        shift = util.by_pixel(2, -6.25),
        blend_mode = "additive",
        scale = 0.5
      }
    }
  },
  burning_cooldown = 20
}


------------------------------------------------------------------------------------
--                          Create entities and remnants                          --
------------------------------------------------------------------------------------
for e, e_data in pairs(BI.additional_entities[setting] or {}) do
  -- Entity
  --~ data:extend({e_data})
  --~ BioInd.created_msg(e_data)
  BioInd.create_stuff(e_data)

  -- Remnants, if they exist
  BioInd.make_remnants_for_entity(BI.additional_remnants[setting], e_data)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
