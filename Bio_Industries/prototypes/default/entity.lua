BioInd.entered_file()

-- Remnants must be loaded before the corresponding entities!
require("prototypes.default.entity_remnants")

require("prototypes.default.entity_trees")

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local ENTITYPATH = BioInd.entitypath
local REACTORPATH = BioInd.entitypath .. "bio_reactor/"
--~ local POLSENSORPATH = BioInd.entitypath .. "pollution_sensor/"
local PIPEPATH = "__base__/graphics/entity/pipe-covers/"
local SNDPATH = "__base__/sound/"


local sound_def = require("__base__.prototypes.entity.sounds")
--~ local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = {}

sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact

for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end

sounds.open_sound = { filename = SNDPATH .. "machine-open.ogg", volume = 0.85 }
sounds.close_sound = { filename = SNDPATH .. "machine-close.ogg", volume = 0.75 }

local seedling_pictures_diverse = {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                    Seedlings                                   --
------------------------------------------------------------------------------------
-- Add images
local function make_entry(img, shift)
  seedling_pictures_diverse[#seedling_pictures_diverse + 1] = {
    filename = ICONPATH .. "mips/seedling_" .. img .. ".png",
    priority = "extra-high",
    width = 64,
    height = 64,
    scale = 0.5,
    shift = shift or {0, -0.3},
  }
end

-- Construct the layers for seedlings
-- The first 9 layers all have the same shift value
for i = 1, 9 do
  make_entry(i)
end

-- The next 9 layers use different shift values
local image_shift = {
  { 0.4, -0.4}, -- 1
  {-0.4, -0.5}, -- 2
  { 0.3,  0.0}, -- 3
  {-0.3, -0.7}, -- 4
  { 0.2, -0.1}, -- 5
  { 0.2, -0.2}, -- 6
  {-0.2, -0.7}, -- 7
  {-0.2, -0.6}, -- 8
  { 0.3,  0.0}, -- 9
}
for i = 1, 9 do
  make_entry(i, image_shift[i])
end


------------------------------------------------------------------------------------
--                                    Bio farm                                    --
------------------------------------------------------------------------------------
-- Pipes
function biofarmpipepictures()
  return
  {
    north = {
      filename = "__core__/graphics/empty.png",
      priority = "low",
      width = 1,
      height = 1,
    },
    east =
    {
      filename = ENTITYPATH .. "biofarm/biofarm_pipes/bio_farm-pipe-E.png",
      priority = "extra-high",
      width = 20,
      height = 38,
      shift = util.by_pixel(-25, 1),
      hr_version =
      {
        filename = ENTITYPATH .. "biofarm/biofarm_pipes/hr_bio_farm-pipe-E.png",
        priority = "extra-high",
        width = 42,
        height = 76,
        shift = util.by_pixel(-24.5, 1),
        scale = 0.5
      }
    },
    south =
    {
      filename = ENTITYPATH .. "biofarm/biofarm_pipes/bio_farm-pipe-S.png",
      priority = "extra-high",
      width = 44,
      height = 31,
      shift = util.by_pixel(0, -31.5),
      hr_version =
      {
        filename = ENTITYPATH .. "biofarm/biofarm_pipes/hr_bio_farm-pipe-S.png",
        priority = "extra-high",
        width = 88,
        height = 61,
        shift = util.by_pixel(0, -31.25),
        scale = 0.5
      }
    },
    west =
    {
      filename = ENTITYPATH .. "biofarm/biofarm_pipes/bio_farm-pipe-W.png",
      priority = "extra-high",
      width = 19,
      height = 37,
      shift = util.by_pixel(25.5, 1.5),
      hr_version =
      {
        filename = ENTITYPATH .. "biofarm/biofarm_pipes/hr_bio_farm-pipe-W.png",
        priority = "extra-high",
        width = 39,
        height = 73,
        shift = util.by_pixel(25.75, 1.25),
        scale = 0.5
      }
    }
  }
end


------------------------------------------------------------------------------------
--                                   Bio reactor                                  --
------------------------------------------------------------------------------------
-- Pipes
function assembler2pipepicturesBioreactor()
  return {
    north = {
      filename = "__core__/graphics/empty.png",
      priority = "low",
      width = 1,
      height = 1,
      shift = util.by_pixel(2.5, 14),
    },
    east = {
      filename = REACTORPATH .. "pipes/bioreactor-pipe-e.png",
      priority = "low",
      width = 20,
      height = 38,
      shift = util.by_pixel(-25, 1),
      hr_version = {
        filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-e.png",
        priority = "low",
        width = 42,
        height = 76,
        shift = util.by_pixel(-24.5, 1),
        scale = 0.5,
      }
    },
    south = {
      filename = REACTORPATH .. "pipes/bioreactor-pipe-s.png",
      priority = "low",
      width = 44,
      height = 31,
      shift = util.by_pixel(0, -31.5),
      hr_version = {
        filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-s.png",
        priority = "low",
        width = 88,
        height = 61,
        shift = util.by_pixel(0, -31.25),
        scale = 0.5,
      }
    },
    west = {
      filename = REACTORPATH .. "pipes/bioreactor-pipe-w.png",
      priority = "low",
      width = 19,
      height = 37,
      shift = util.by_pixel(25.5, 1.5),
      hr_version = {
        filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-w.png",
        priority = "low",
        width = 39,
        height = 73,
        shift = util.by_pixel(25.75, 1.25),
        scale = 0.5,
      }
    }
  }
end


-- Pipe covers
--[[function pipecoverspicturesBioreactor()
  return {
    north = {
      filename = "__core__/graphics/empty.png",
      priority = "low",
      width = 1,
      height = 1,
    },
    east = {
      filename = PIPEPATH .. "pipe-cover-east.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-cover-east.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5
      }
    },
    south = {
      filename = PIPEPATH .. "pipe-cover-south.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-cover-south.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5
      }
    },
    west = {
      filename = PIPEPATH .. "pipe-cover-west.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      hr_version = {
        filename = PIPEPATH .. "hr-pipe-cover-west.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5
      }
    }
  }
end
]]--


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                   Entity data                                  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



BI.default_entities = BI.default_entities or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                    Bio farm                                    --
------------------------------------------------------------------------------------
-- Bio farm
BI.default_entities.bio_farm = {
  type = "assembling-machine",
  name = "bi-bio-farm",
  icon = ICONPATH .. "entity/biofarm.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-farm"},
  max_health = 250,
  corpse = "bi-bio-farm-remnant",
  dying_explosion = "medium-explosion",
  resistances = {{type = "fire", percent = 70}},
  fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = biofarmpipepictures(),
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      base_level = -1,
      pipe_connections = {{ type = "input", position = {-1, -5} }}
    },
    {
      production_type = "input",
      pipe_picture = biofarmpipepictures(),
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      base_level = -1,
      pipe_connections = {{ type = "input", position = {1, -5} }}
    },
    off_when_no_fluid_recipe = true
  },

  collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  scale_entity_info_icon = true,
  animation = {
    layers = {
      {
        filename = ENTITYPATH .. "biofarm/bio_farm.png",
        priority = "high",
        width = 304,
        height = 400,
        shift = {0, -1.5},
        scale = 1,
        hr_version = {
          filename = ENTITYPATH .. "biofarm/hr_bio_farm.png",
          priority = "high",
          width = 608,
          height = 800,
          shift = {0, -1.5},
          scale = 0.5,
        }
      },
      {
        filename = ENTITYPATH .. "biofarm/bio_farm_shadow.png",
        priority = "high",
        width = 400,
        height = 400,
        shift = {1.5, -1.5},
        scale = 1,
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "biofarm/hr_bio_farm_shadow.png",
          priority = "high",
          width = 800,
          height = 800,
          shift = {1.5, -1.5},
          scale = 0.5,
          draw_as_shadow = true,
        }
      },
    }
  },
  working_visualisations = {
    {
      draw_as_light = true,
      effect = "flicker",
      apply_recipe_tint = "primary",
      animation = {
        layers = {
          {
            filename = ENTITYPATH .. "biofarm/bio_farm_light.png",
            width = 400,
            height = 400,
            scale = 1,
            shift = {0, -1.5},
            blend_mode = "additive",
            hr_version = {
              filename = ENTITYPATH .. "biofarm/hr_bio_farm_light.png",
              width = 800,
              height = 800,
              scale = 0.5,
              shift = {0, -1.5},
              blend_mode = "additive",
            }
          },
        },
      },
    },
  },
  crafting_categories = {BI.default_recipe_categories.farm.name},
  crafting_speed = 1,
  energy_source = {
    type = "electric",
    usage_priority = "primary-input",
    drain = "50kW",
    emissions_per_minute = -9, -- the "-" means it Absorbs pollution.
  },
  energy_usage = "100kW",
  ingredient_count = 3,
  --~ open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
  --~ close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  working_sound = {
    sound = { { filename = BioInd.soundpath .. "BI_sawmill.ogg", volume = 0.6 } },
    apparent_volume = 1,
  },
  vehicle_impact_sound = sounds.generic_impact,
  module_specification = {
    module_slots = 3
  },
  allowed_effects = {"consumption", "speed", "productivity", "pollution"},
}

-- Bio nursery (Greenhouse)
BI.default_entities.bio_greenhouse = {
  type = "assembling-machine",
  name = "bi-bio-greenhouse",
  icon = ICONPATH .. "entity/greenhouse.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.25, result = "bi-bio-greenhouse"},
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  max_health = 250,
  corpse = "bi-bio-greenhouse-remnant",
  dying_explosion = "medium-explosion",
  crafting_categories = {BI.default_recipe_categories.greenhouse.name},
  crafting_speed = 1,
  energy_source = {
    type = "electric",
    usage_priority = "primary-input",
    drain = "15kW",
    emissions_per_minute = -6, -- Negative value means it absorbs pollution!
  },
  energy_usage = "50kW",
  ingredient_count = 3,
  resistances = {
    {
      type = "fire",
      percent = 70
    }
  },
  fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = {
        north =
        {
          filename = ENTITYPATH .. "bio_greenhouse/pipe/assembling-machine-3-pipe-N.png",
          priority = "extra-high",
          width = 35,
          height = 18,
          shift = util.by_pixel(2.5, 14),
          hr_version =
          {
            filename = ENTITYPATH .. "bio_greenhouse/pipe/hr-assembling-machine-3-pipe-N-exp.png",
            priority = "extra-high",
            width = 171,
            height = 152,
            shift = util.by_pixel(2.25, 13.5),
            scale = 0.5
          }
        },
        east =
        {
          filename = ENTITYPATH .. "bio_greenhouse/pipe/assembling-machine-3-pipe-E.png",
          priority = "extra-high",
          width = 20,
          height = 38,
          shift = util.by_pixel(-25, 1),
          hr_version =
          {
            filename = ENTITYPATH .. "bio_greenhouse/pipe/hr-assembling-machine-3-pipe-E.png",
            priority = "extra-high",
            width = 42,
            height = 76,
            shift = util.by_pixel(-24.5, 1),
            scale = 0.5
          }
        },
        south =
        {
          filename = ENTITYPATH .. "bio_greenhouse/pipe/assembling-machine-3-pipe-S.png",
          priority = "extra-high",
          width = 44,
          height = 31,
          shift = util.by_pixel(0, -31.5),
          hr_version =
          {
            filename = ENTITYPATH .. "bio_greenhouse/pipe/hr-assembling-machine-3-pipe-S.png",
            priority = "extra-high",
            width = 88,
            height = 61,
            shift = util.by_pixel(0, -31.25),
            scale = 0.5
          }
        },
        west =
        {
          filename = ENTITYPATH .. "bio_greenhouse/pipe/assembling-machine-3-pipe-W.png",
          priority = "extra-high",
          width = 19,
          height = 37,
          shift = util.by_pixel(25.5, 1.5),
          hr_version =
          {
            filename = ENTITYPATH .. "bio_greenhouse/pipe/hr-assembling-machine-3-pipe-W.png",
            priority = "extra-high",
            width = 39,
            height = 73,
            shift = util.by_pixel(25.75, 1.25),
            scale = 0.5
          }
        },
      },
      pipe_covers = pipecoverspictures(),
      base_area = 10,
      base_level = -1,
      pipe_connections = {{ type = "input", position = {0, -2} }}
    },
  },
  module_specification = {
    module_slots = 2
  },
  allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  animation = {
    layers = {
      {
        filename = ENTITYPATH .. "bio_greenhouse/bio_greenhouse.png",
        width = 96,
        height = 128,
        frame_count = 1,
        line_length = 1,
        repeat_count = 10,
        animation_speed = 0.05,
        scale = 1,
        shift = {0, -0.5},
        hr_version = {
          filename = ENTITYPATH .. "bio_greenhouse/hr_bio_greenhouse.png",
          width = 192,
          height = 256,
          frame_count = 1,
          line_length = 1,
          repeat_count = 10,
          animation_speed = 0.05,
          scale = 0.5,
          shift = {0, -0.5},
        }
      },

      {
        filename = ENTITYPATH .. "bio_greenhouse/bio_greenhouse_shadow.png",
        width = 128,
        height = 64,
        frame_count = 1,
        line_length = 1,
        repeat_count = 10,
        animation_speed = 0.05,
        scale = 1,
        shift = {0.5, 0.5},
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "bio_greenhouse/hr_bio_greenhouse_shadow.png",
          width = 256,
          height = 128,
          frame_count = 1,
          line_length = 1,
          repeat_count = 10,
          animation_speed = 0.05,
          scale = 0.5,
          shift = {0.5, 0.5},
          draw_as_shadow = true,
        }
      },
    },
  },
  working_visualisations = {
    {
      draw_as_light = true,
      effect = "flicker",
      apply_recipe_tint = "primary",
      animation = {
        layers = {
          {
            filename = ENTITYPATH .. "bio_greenhouse/bio_greenhouse_light_anim.png",
            width = 96,
            height = 128,
            frame_count = 10,
            line_length = 10,
            repeat_count = 1,
            animation_speed = 0.08,
            scale = 1,
            shift = {0, -0.5},
            hr_version = {
              filename = ENTITYPATH .. "bio_greenhouse/hr_bio_greenhouse_light_anim.png",
              width = 192,
              height = 256,
              frame_count = 10,
              line_length = 10,
              repeat_count = 1,
              animation_speed = 0.08,
              scale = 0.5,
              shift = {0, -0.5},
            }
          },
        },
      },
    },
  },
  --~ open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
  --~ close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  vehicle_impact_sound = sounds.generic_impact,
}


------------------------------------------------------------------------------------
--                                     Cokery                                     --
------------------------------------------------------------------------------------
-- Cokery
BI.default_entities.cokery = {
  type = "assembling-machine",
  name = "bi-cokery",
  icon = ICONPATH .. "entity/cokery.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  order = "a[cokery]",
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-cokery"},
  max_health = 200,
  corpse = "bi-cokery-remnant",
  resistances = {{type = "fire", percent = 95}},
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  module_specification = {
    module_slots = 2
  },
  allowed_effects = {"consumption", "speed", "pollution"},
  animation = {
    layers = {
      {
        filename = ENTITYPATH .. "cokery/cokery_anim.png",
        frame_count = 16,
        line_length = 8,
        width = 128,
        height = 128,
        scale = 1,
        shift = {0.5, -0.5},
        animation_speed = 0.2,
        hr_version = {
          filename = ENTITYPATH .. "cokery/hr_cokery_anim.png",
          frame_count = 16,
          line_length = 8,
          width = 256,
          height = 256,
          scale = 0.5,
          shift = {0.5, -0.5},
          animation_speed = 0.2,
        }
      },
      {
        filename = ENTITYPATH .. "cokery/cokery_shadow.png",
        priority = "extra-high",
        width = 167,
        height = 64,
        frame_count = 1,
        line_length = 1,
        repeat_count = 16,
        shift = {0.5, 0.5},
        scale = 1,
        animation_speed = 0.2,
        draw_as_shadow = true,
        hr_version = {
          filename = ENTITYPATH .. "cokery/hr_cokery_shadow.png",
          priority = "extra-high",
          width = 334,
          height = 128,
          frame_count = 1,
          line_length = 1,
          repeat_count = 16,
          shift = {0.5, 0.5},
          scale = 0.5,
          animation_speed = 0.2,
          draw_as_shadow = true,
        }
      },
    },
  },
  idle_animation = {
    layers = {
      {
        filename = ENTITYPATH .. "cokery/cokery_idle.png",
        frame_count = 1,
        line_length = 1,
        width = 128,
        height = 128,
        scale = 1,
        shift = {0.5, -0.5},
        animation_speed = 0.2,
        repeat_count = 16,
        hr_version = {
          filename = ENTITYPATH .. "cokery/hr_cokery_idle.png",
          frame_count = 1,
          line_length = 1,
          width = 256,
          height = 256,
          scale = 0.5,
          shift = {0.5, -0.5},
          animation_speed = 0.2,
          repeat_count = 16,
        }
      },
      {
        filename = ENTITYPATH .. "cokery/cokery_shadow.png",
        priority = "extra-high",
        width = 167,
        height = 64,
        frame_count = 1,
        line_length = 1,
        shift = {0.5, 0.5},
        scale = 1,
        animation_speed = 0.2,
        draw_as_shadow = true,
        repeat_count = 16,
        hr_version = {
          filename = ENTITYPATH .. "cokery/hr_cokery_shadow.png",
          priority = "extra-high",
          width = 334,
          height = 128,
          frame_count = 1,
          line_length = 1,
          shift = {0.5, 0.5},
          scale = 0.5,
          animation_speed = 0.2,
          draw_as_shadow = true,
          repeat_count = 16,
        }
      },
    },
  },
  crafting_categories = {BI.default_recipe_categories.smelting.name},
  energy_source = {
    type = "electric",
    input_priority = "secondary",
    usage_priority = "secondary-input",
    emissions_per_minute = 2.5,
  },
  energy_usage = "180kW",
  crafting_speed = 2,
  ingredient_count = 1
}


------------------------------------------------------------------------------------
--                                   Bio reactor                                  --
------------------------------------------------------------------------------------
-- Bio reactor
BI.default_entities.bio_reactor = {
  type = "assembling-machine",
  name = "bi-bio-reactor",
  localised_description = {
    "entity-description.bi-bio-reactor",
    {"fluid-name.bi-biomass"},
  },
  icon = ICONPATH .. "entity/bioreactor.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-reactor"},
  max_health = 100,
  corpse = "bi-bio-reactor-remnant",
  fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = assembler2pipepicturesBioreactor(),
      --pipe_covers = pipecoverspicturesBioreactor(),
      pipe_covers = pipecoverspictures(),
      base_area = 10,
      base_level = -1,
      pipe_connections = {{ type = "input", position = {0, -2} }},
      render_layer = "higher-object-under",
    },
    {
      production_type = "input",
      pipe_picture = assembler2pipepicturesBioreactor(),
      --pipe_covers = pipecoverspicturesBioreactor(),
      pipe_covers = pipecoverspictures(),
      base_area = 10,
      base_level = -1,
      pipe_connections = {{ type = "input", position = {2, 0} }},
      render_layer = "higher-object-under",
    },
    {
      production_type = "input",
      pipe_picture = assembler2pipepicturesBioreactor(),
      --pipe_covers = pipecoverspicturesBioreactor(),
      pipe_covers = pipecoverspictures(),
      base_area = 10,
      base_level = -1,
      pipe_connections = {{ type = "input", position = {0, 2} }},
      render_layer = "higher-object-under",
    },
    {
      production_type = "output",
      pipe_picture = assembler2pipepicturesBioreactor(),
      --pipe_covers = pipecoverspicturesBioreactor(),
      pipe_covers = pipecoverspictures(),
      base_area = 10,
      base_level = 1,
      pipe_connections = {{ type = "output", position = {-2, -1} }},
      render_layer = "higher-object-under",
    },
    {
      production_type = "output",
      pipe_picture = assembler2pipepicturesBioreactor(),
      --pipe_covers = pipecoverspicturesBioreactor(),
      pipe_covers = pipecoverspictures(),
      base_area = 10,
      base_level = 1,
      pipe_connections = {{ type = "output", position = {-2, 1} }},
      render_layer = "higher-object-under",
    },
    off_when_no_fluid_recipe = true,
  },
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  animation = {
    layers = {
      {
        filename = REACTORPATH .. "bioreactor_idle.png",
        priority = "high",
        width = 91,
        height = 128,
        frame_count = 1,
        line_length = 1,
        repeat_count = 18,
        animation_speed = 0.2,
        scale = 1,
        shift = {0, -0.5},
        hr_version = {
          filename = REACTORPATH .. "hr_bioreactor_idle.png",
          priority = "high",
          width = 182,
          height = 256,
          frame_count = 1,
          line_length = 1,
          repeat_count = 18,
          animation_speed = 0.2,
          scale = 0.5,
          shift = {0, -0.5},
        }

      },
      {
        filename = REACTORPATH .. "bioreactor_shadow.png",
        priority = "high",
        width = 135,
        height = 128,
        frame_count = 1,
        line_length = 1,
        repeat_count = 18,
        animation_speed = 0.2,
        scale = 1,
        shift = {0.5, -0.5},
        draw_as_shadow = true,
        hr_version = {
          filename = REACTORPATH .. "hr_bioreactor_shadow.png",
          priority = "high",
          width = 270,
          height = 256,
          frame_count = 1,
          line_length = 1,
          repeat_count = 18,
          animation_speed = 0.2,
          scale = 0.5,
          shift = {0.5, -0.5},
          draw_as_shadow = true,
        }
      }
    },
  },
  working_visualisations = {
    {
      effect = "none",
      render_layer = "object",
      animation = {
        layers = {
          {
            filename = REACTORPATH .. "bioreactor_anim.png",
            priority = "low",
            width = 91,
            height = 128,
            frame_count = 18,
            line_length = 6,
            repeat_count = 1,
            animation_speed = 0.2,
            scale = 1,
            shift = {0, -0.5},
            hr_version = {
              filename = REACTORPATH .. "hr_bioreactor_anim.png",
              priority = "low",
              width = 182,
              height = 256,
              frame_count = 18,
              line_length = 6,
              repeat_count = 1,
              animation_speed = 0.2,
              scale = 0.5,
              shift = {0, -0.5},
            }
          },
        },
      },
    },
    {
      effect = "none",
      apply_recipe_tint = "primary",
      fadeout = true,
      render_layer = "object",
      animation = {
        layers = {
          {
            filename = REACTORPATH .. "bioreactor_anim_mask.png",
            priority = "low",
            width = 91,
            height = 128,
            frame_count = 18,
            line_length = 6,
            repeat_count = 1,
            animation_speed = 0.2,
            scale = 1,
            shift = {0, -0.5},
            hr_version = {
              filename = REACTORPATH .. "hr_bioreactor_anim_mask.png",
              priority = "low",
              width = 182,
              height = 256,
              frame_count = 18,
              line_length = 6,
              repeat_count = 1,
              animation_speed = 0.2,
              scale = 0.5,
              shift = {0, -0.5},
            }
          },
        },
      },
    },
  },
  energy_source = {
    type = "electric",
    usage_priority = "secondary-input"
  },
  crafting_categories = {BI.default_recipe_categories.bioreactor.name},
  ingredient_count = 3,
  crafting_speed = 1,
  energy_usage = "10kW",
  module_specification = {
    module_slots = 3
  },
  allowed_effects = {"consumption", "speed", "productivity", "pollution"},
}


--~ ------------------------------------------------------------------------------------
--~ --                                Pollution sensor                                --
--~ ------------------------------------------------------------------------------------
--~ BI.default_entities.pollution_sensor = {
  --~ type = "constant-combinator",
  --~ name = BioInd.pollution_sensor_name,
  --~ icon = ICONPATH .. "entity/pollution_sensor.png",
  --~ icon_size = 64, icon_mipmaps = 4,
  --~ flags = {"placeable-neutral", "player-creation"},
  --~ minable = {mining_time = 0.1, result = "bi-pollution-sensor"},
  --~ max_health = 120,
  --~ corpse = "constant-combinator-remnants",
  --~ dying_explosion = "constant-combinator-explosion",
  --~ collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
  --~ selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  --~ damaged_trigger_effect = hit_effects.entity(),
  --~ fast_replaceable_group = "constant-combinator",

  --~ item_slot_count = 1,

  --~ vehicle_impact_sound = sounds.generic_impact,
  --~ open_sound = sounds.machine_open,
  --~ close_sound = sounds.machine_close,

  --~ activity_led_sprites =
  --~ {
    --~ filename = "__core__/graphics/empty.png",
    --~ width = 1,
    --~ height = 1,
    --~ frame_count = 1,
    --~ shift = util.by_pixel(0, 0),
  --~ },

  --~ activity_led_light =
  --~ {
    --~ intensity = 0,
    --~ size = 1,
    --~ color = {r = 0, g = 0, b = 0}
  --~ },

  --~ activity_led_light_offsets =
  --~ {
    --~ {0, 0},
    --~ {0, 0},
    --~ {0, 0},
    --~ {0, 0},
  --~ },

  --~ circuit_wire_connection_points =
  --~ {
    --~ {
      --~ shadow =
      --~ {
        --~ red = util.by_pixel(-9, 10),
        --~ green = util.by_pixel(-9, -2)
      --~ },
      --~ wire =
      --~ {
        --~ red = util.by_pixel(-19.5, -2.5),
        --~ green = util.by_pixel(-19.5, -14.5)
      --~ }
    --~ },
    --~ {
      --~ shadow =
      --~ {
        --~ red = util.by_pixel(-9, 10),
        --~ green = util.by_pixel(-9, -2)
      --~ },
      --~ wire =
      --~ {
        --~ red = util.by_pixel(-19.5, -2.5),
        --~ green = util.by_pixel(-19.5, -14.5)
      --~ }
    --~ },
    --~ {
      --~ shadow =
      --~ {
        --~ red = util.by_pixel(-9, 10),
        --~ green = util.by_pixel(-9, -2)
      --~ },
      --~ wire =
      --~ {
        --~ red = util.by_pixel(-19.5, -2.5),
        --~ green = util.by_pixel(-19.5, -14.5)
      --~ }
    --~ },
    --~ {
      --~ shadow =
      --~ {
        --~ red = util.by_pixel(-9, 10),
        --~ green = util.by_pixel(-9, -2)
      --~ },
      --~ wire =
      --~ {
        --~ red = util.by_pixel(-19.5, -2.5),
        --~ green = util.by_pixel(-19.5, -14.5)
      --~ }
    --~ },
  --~ },

  --~ circuit_wire_max_distance = 9,
  --~ sprites = {
    --~ layers =
    --~ {
      --~ {
        --~ filename = POLSENSORPATH .. "pollution-sensor.png",
        --~ width = 48,
        --~ height = 40,
        --~ shift = util.by_pixel(0, -1),
        --~ hr_version =
        --~ {
          --~ filename = POLSENSORPATH .. "hr-pollution-sensor.png",
          --~ width = 96,
          --~ height = 80,
          --~ shift = util.by_pixel(0, -1),
          --~ scale = 0.5,
        --~ },
      --~ },
      --~ {
        --~ filename = POLSENSORPATH .. "pollution-sensor-shadow.png",
        --~ priority = "extra-high",
        --~ width = 56,
        --~ height = 23,
        --~ shift = util.by_pixel(12, 5.5),
        --~ draw_as_shadow = true,
        --~ hr_version =
        --~ {
          --~ filename = POLSENSORPATH .. "hr-pollution-sensor-shadow.png",
          --~ priority = "extra-high",
          --~ width = 112,
          --~ height = 46,
          --~ shift = util.by_pixel(12, 5.5),
          --~ draw_as_shadow = true,
          --~ scale = 0.5
        --~ }
      --~ }
    --~ },
  --~ },
--~ }


------------------------------------------------------------------------------------
--                                    Seedlings                                   --
------------------------------------------------------------------------------------
-- Seedling
BI.default_entities.seedling = {
  type = "simple-entity-with-force",
  name = "seedling",
  localised_name = {"entity-name.seedling"},
  localised_description = {"entity-description.seedling"},
  icon = ICONPATH .. "seedling.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  order = "x[bi]-a[bi-seedling]",
  flags = {"placeable-neutral", "placeable-player", "player-creation", "breaths-air"},
  create_ghost_on_death = false,
  minable = {
    mining_particle = "wooden-particle",
    mining_time = 0.25,
    result = "seedling",
    count = 1
  },
  corpse = nil,
  remains_when_mined = nil,
  emissions_per_second = -0.0006,
  max_health = 5,
  collision_box = {{-0.03, -0.03}, {0.1, 0.03}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  subgroup = "trees",
  vehicle_impact_sound = sounds.car_wood_impact,
  pictures = seedling_pictures_diverse,
  map_color = util.color("70b94c55"),
}

-- Seedling 2 (dummy for seed bomb)
BI.default_entities.seedling_2 = {
  type = "simple-entity-with-force",
  name = "seedling-2",
  localised_name = {"entity-name.seedling"},
  localised_description = {"entity-description.seedling"},
  icon = ICONPATH .. "seedling.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  order = "x[bi]-a[bi-seedling]",
  flags = {"placeable-neutral", "placeable-player", "player-creation", "breaths-air"},
  create_ghost_on_death = false,
  minable = {
    mining_particle = "wooden-particle",
    mining_time = 0.25,
    result = "seedling",
    count = 1
  },
  corpse = nil,
  remains_when_mined = nil,
  emissions_per_second = -0.0006,
  max_health = 5,
  collision_box = {{-0.03, -0.03}, {0.03, 0.03}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  subgroup = "trees",
  vehicle_impact_sound = sounds.car_wood_impact,
  pictures = seedling_pictures_diverse,
  map_color = util.color("70b94c55"),
}

-- Seedling 3 (dummy for seed bomb)
BI.default_entities.seedling_3 = {
  type = "simple-entity-with-force",
  name = "seedling-3",
  localised_name = {"entity-name.seedling"},
  localised_description = {"entity-description.seedling"},
  icon = ICONPATH .. "seedling.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  order = "x[bi]-a[bi-seedling]",
  flags = {"placeable-neutral", "placeable-player", "player-creation", "breaths-air"},
  create_ghost_on_death = false,
  minable = {
    mining_particle = "wooden-particle",
    mining_time = 0.25,
    result = "seedling",
    count = 1
  },
  corpse = nil,
  remains_when_mined = nil,
  emissions_per_second = -0.0006,
  max_health = 5,
  collision_box = {{-0.03, -0.03}, {0.03, 0.03}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  subgroup = "trees",
  vehicle_impact_sound = sounds.car_wood_impact,
  pictures = seedling_pictures_diverse,
  map_color = util.color("70b94c55"),
}




------------------------------------------------------------------------------------
--                          Create entities and remnants                          --
------------------------------------------------------------------------------------
for e, e_data in pairs(BI.default_entities or {}) do
  -- Entity
  BioInd.create_stuff({e_data})

  -- Remnants, if they exist
  BioInd.make_remnants_for_entity(BI.default_remnants, e_data)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
