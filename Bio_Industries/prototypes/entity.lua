local BioInd = require('common')('Bio_Industries')

--~ local ICONPATH = BioInd.modRoot .. "/graphics/entities/biofarm/"
local ICONPATH = BioInd.iconpath
local ENTITYPATH = BioInd.entitypath
local REACTORPATH = BioInd.entitypath .. "bio_reactor/"
local PIPEPATH = "__base__/graphics/entity/pipe-covers/"

--~ local BIGICONS = BioInd.check_base_version()

require ("util")

--~ -- demo-sounds has been removed in Factorio 1.1, so we need to check the game version!
--~ local sound_def = BioInd.check_version("base", "<", "1.1.0") and
                    --~ require("__base__.prototypes.entity.demo-sounds") or
                    --~ require("__base__.prototypes.entity.sounds")
-- demo-sounds has been removed in Factorio 1.1, so we need to check the game version!
local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}
sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact
for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end
sounds.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
sounds.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

-- No need to make that a function! We always want the same data, so just store
-- it in a table once.

--~ function seedling_pictures_diverse()
local seedling_pictures_diverse = {}

local function make_entry(img, shift)
  seedling_pictures_diverse[#seedling_pictures_diverse + 1] = {
    filename = ICONPATH .. "mips/Seedling_" .. img .. ".png",
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
      filename = REACTORPATH .. "pipes/bioreactor-pipe-E.png",
      priority = "extra-high",
      width = 20,
      height = 38,
      shift = util.by_pixel(-25, 1),
      hr_version = {
        filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-E.png",
        priority = "extra-high",
        width = 42,
        height = 76,
        shift = util.by_pixel(-24.5, 1),
        scale = 0.5,
      }
    },
    south = {
      filename = REACTORPATH .. "pipes/bioreactor-pipe-S.png",
      priority = "extra-high",
      width = 44,
      height = 31,
      shift = util.by_pixel(0, -31.5),
      hr_version = {
        filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-S.png",
        priority = "extra-high",
        width = 88,
        height = 61,
        shift = util.by_pixel(0, -31.25),
        scale = 0.5,
      }
    },
    west = {
      filename = REACTORPATH .. "pipes/bioreactor-pipe-W.png",
      priority = "extra-high",
      width = 19,
      height = 37,
      shift = util.by_pixel(25.5, 1.5),
      hr_version = {
        filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-W.png",
        priority = "extra-high",
        width = 39,
        height = 73,
        shift = util.by_pixel(25.75, 1.25),
        scale = 0.5,
      }
    }
  }
end




function pipecoverspicturesBioreactor()
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
































data:extend({
  ------- Seedling
  {
    type = "simple-entity-with-force",
    name = "seedling",
    localised_name = {"entity-name.seedling"},
    localised_description = {"entity-description.seedling"},
    icon = ICONPATH .. "Seedling.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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

    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    subgroup = "trees",
    vehicle_impact_sound = sounds.car_wood_impact,
    pictures = seedling_pictures_diverse,
  },

  ------- Seedling - Dummy for Seed Bomb
  {
    type = "simple-entity-with-force",
    name = "seedling-2",
    localised_name = {"entity-name.seedling"},
    localised_description = {"entity-description.seedling"},
    icon = ICONPATH .. "Seedling.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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

    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    subgroup = "trees",
    vehicle_impact_sound = sounds.car_wood_impact,
    pictures = seedling_pictures_diverse,
  },

  {
    type = "simple-entity-with-force",
    name = "seedling-3",
    localised_name = {"entity-name.seedling"},
    localised_description = {"entity-description.seedling"},
    icon = ICONPATH .. "Seedling.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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

    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    subgroup = "trees",
    vehicle_impact_sound = sounds.car_wood_impact,
    pictures = seedling_pictures_diverse,
  },


  ------- Bio Farm
  {
    type = "assembling-machine",
    name = "bi-bio-farm",
    icon = ICONPATH .. "entity/Bio_Farm_Icon.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Bio_Farm_Icon.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-farm"},
    max_health = 250,
    corpse = "big-remnants",
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
    crafting_categories = {"biofarm-mod-farm"},
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
  },
})

data:extend({
  
  ------ Greenhouse
  {
    type = "assembling-machine",
    name = "bi-bio-greenhouse",
    icon = ICONPATH .. "entity/bio_greenhouse.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.25, result = "bi-bio-greenhouse"},
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    max_health = 250,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    crafting_categories = {"biofarm-mod-greenhouse"},
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
  },

  -- COKERY
  {
    type = "assembling-machine",
    name = "bi-cokery",
    icon = ICONPATH .. "entity/cokery.png",
    icon_size = 64,
    BI_add_icon = true,
    se_allow_in_space = true, -- Space Exploration - Buildable in orbit
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    order = "a[cokery]",
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-cokery"},
    max_health = 200,
    corpse = "medium-remnants",
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
    crafting_categories = {"biofarm-mod-smelting"},
    energy_source = {
      type = "electric",
      input_priority = "secondary",
      usage_priority = "secondary-input",
      emissions_per_minute = 2.5,
    },
    energy_usage = "180kW",
    crafting_speed = 2,
    ingredient_count = 1
  },

  -- STONECRUSHER
  {
    type = "furnace",
    name = "bi-stone-crusher",
    icon = ICONPATH .. "entity/stone_crusher.png",
    icon_size = 64,
    BI_add_icon = true,
    se_allow_in_space = true, -- Space Exploration - Buildable in orbit
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-stone-crusher"},
    max_health = 100,
    corpse = "medium-remnants",
    module_slots = 1,
    resistances = {{type = "fire", percent = 70}},
    working_sound = {
      sound = {
        filename = BioInd.soundpath .. "BI_stonecrusher.ogg",
        volume = 0.8
      },
      apparent_volume = 1,
    },
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
    animation = {
      layers = {
        {
          filename = ENTITYPATH .. "stone-crusher/stone_crusher_anim.png",
          priority = "high",
          width = 65,
          height = 78,
          line_length = 10,
          frame_count = 20,
          animation_speed = 0.5,
          scale = 1,
          repeat_count = 1,
          shift = {0, -0.2},
          hr_version = {
            filename = ENTITYPATH .. "stone-crusher/hr_stone_crusher_anim.png",
            priority = "high",
            width = 130,
            height = 156,
            line_length = 10,
            frame_count = 20,
            animation_speed = 0.5,
            scale = 0.5,
            repeat_count = 1,
            shift = {0, -0.2},
          },
        },
        {
          filename = ENTITYPATH .. "stone-crusher/stone_crusher_shadow.png",
          priority = "high",
          width = 98,
          height = 78,
          line_length = 1,
          frame_count = 1,
          animation_speed = 0.5,
          scale = 1,
          repeat_count = 20,
          shift = {0.5, -0.2},
          draw_as_shadow = true,
          hr_version = {
            filename = ENTITYPATH .. "stone-crusher/hr_stone_crusher_shadow.png",
            priority = "high",
            width = 196,
            height = 156,
            line_length = 1,
            frame_count = 1,
            animation_speed = 0.5,
            scale = 0.5,
            repeat_count = 20,
            shift = {0.5, -0.2},
            draw_as_shadow = true,
          },
        },
      }
    },
    idle_animation = {
      layers = {
        {
          filename = ENTITYPATH .. "stone-crusher/stone_crusher_off.png",
          priority = "high",
          width = 65,
          height = 78,
          line_length = 1,
          frame_count = 1,
          repeat_count = 20,
          animation_speed = 0.5,
          scale = 1,
          shift = {0, -0.2},
          hr_version = {
            filename = ENTITYPATH .. "stone-crusher/hr_stone_crusher_off.png",
            priority = "high",
            width = 130,
            height = 156,
            line_length = 1,
            frame_count = 1,
            repeat_count = 20,
            animation_speed = 0.5,
            scale = 0.5,
            shift = {0, -0.2},
          },
        },
        {
          filename = ENTITYPATH .. "stone-crusher/stone_crusher_shadow.png",
          priority = "high",
          width = 98,
          height = 78,
          line_length = 1,
          frame_count = 1,
          animation_speed = 0.5,
          scale = 1,
          repeat_count = 20,
          shift = {0.5, -0.2},
          draw_as_shadow = true,
          hr_version = {
            filename = ENTITYPATH .. "stone-crusher/hr_stone_crusher_shadow.png",
            priority = "high",
            width = 196,
            height = 156,
            line_length = 1,
            frame_count = 1,
            animation_speed = 0.5,
            scale = 0.5,
            repeat_count = 20,
            shift = {0.5, -0.2},
            draw_as_shadow = true,
          },
        },
      }
    },
    crafting_categories = {"biofarm-mod-crushing"},
    result_inventory_size = 1,
    source_inventory_size = 1,
    crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 0.25,
    },
    energy_usage = "50kW",
    module_specification = {
      module_slots = 2
    },
    allowed_effects = {"consumption", "speed", "pollution"},
  },



-- Changed for 0.18.29: We always want to make advanced fertilizer, so we need to unlock the bio-reactor and the most basic recipe for algae biomass even if BI.Settings.BI_Bio_Fuel has been turned off
  -- BIOREACTOR
  {
    type = "assembling-machine",
    name = "bi-bio-reactor",
    icon = ICONPATH .. "entity/bioreactor.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bioreactor.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-reactor"},
    max_health = 100,
    corpse = "big-remnants",
    fluid_boxes = {
      {
        production_type = "input",
        pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspicturesBioreactor(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type = "input", position = {0, -2} }}
      },
      {
        production_type = "input",
        pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspicturesBioreactor(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type = "input", position = {2, 0} }}
      },
      {
        production_type = "input",
        pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspicturesBioreactor(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type = "input", position = {0, 2} }}
      },
      {
        production_type = "output",
        pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspicturesBioreactor(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type = "output", position = {-2, -1} }}
      },
      {
        production_type = "output",
        pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspicturesBioreactor(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type = "output", position = {-2, 1} }}
      },
      off_when_no_fluid_recipe = true,
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    animation = {
      layers = {
        {
          filename = REACTORPATH .. "bioreactor_anim.png",
          priority = "high",
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
            priority = "high",
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

    idle_animation = {
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
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input"
    },
    crafting_categories = {"biofarm-mod-bioreactor"},
    ingredient_count = 3,
    crafting_speed = 1,
    energy_usage = "10kW",
    module_specification = {
      module_slots = 3
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  },











  --- Seed Bomb Projectile - 1
  {
    type = "projectile",
    name = "seed-bomb-projectile-1",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "nested-result",
            action = {
              type = "area",
              target_entities = false,
              repeat_count = 600,
              radius = 24,
              action_delivery = {
                type = "projectile",
                projectile = "seed-bomb-wave-1",
                starting_speed = 0.5
              }
            }
          }
        }
      }
    },
    light = {intensity = 0.8, size = 15},
    animation = {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 8,
      line_length = 8,
      width = 9,
      height = 35,
      shift = {0, 0},
      priority = "high"
    },
    shadow = {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      width = 7,
      height = 24,
      priority = "high",
      shift = {0, 0}
    },
    smoke = {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, -1},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },

  --- Seed Bomb Projectile - 2
  {
    type = "projectile",
    name = "seed-bomb-projectile-2",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "nested-result",
            action = {
              type = "area",
              target_entities = false,
              repeat_count = 800,
              radius = 27,
              action_delivery = {
                type = "projectile",
                projectile = "seed-bomb-wave-2",
                starting_speed = 0.5
              }
            }
          }
        }
      }
    },
    light = {intensity = 0.8, size = 15},
    animation = {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 8,
      line_length = 8,
      width = 9,
      height = 35,
      shift = {0, 0},
      priority = "high"
    },
    shadow = {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      width = 7,
      height = 24,
      priority = "high",
      shift = {0, 0}
    },
    smoke = {
      {
         name = "smoke-fast",
         deviation = {0.15, 0.15},
         frequency = 1,
         position = {0, -1},
         slow_down_factor = 1,
         starting_frame = 3,
         starting_frame_deviation = 5,
         starting_frame_speed = 0,
         starting_frame_speed_deviation = 5
      }
    }
  },

  --- Seed Bomb Projectile - 3
  {
    type = "projectile",
    name = "seed-bomb-projectile-3",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "nested-result",
            action = {
              type = "area",
              target_entities = false,
              repeat_count = 1000,
              radius = 30,
              action_delivery = {
                type = "projectile",
                projectile = "seed-bomb-wave-3",
                starting_speed = 0.5
              }
            }
          }
        }
      }
    },
    light = {intensity = 0.8, size = 15},
    animation = {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 8,
      line_length = 8,
      width = 9,
      height = 35,
      shift = {0, 0},
      priority = "high"
    },
    shadow = {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      width = 7,
      height = 24,
      priority = "high",
      shift = {0, 0}
    },
    smoke = {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, -1},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },

  --- Seed Bomb Wave - 1
  {
    type = "projectile",
    name = "seed-bomb-wave-1",
    flags = {"not-on-map"},
    acceleration = 0,
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "create-entity",
              entity_name = "seedling",
              check_buildability = true,
              trigger_created_entity = true,
            }
          }
        }
      },
    },
    animation = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "high"
    },
    shadow = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "high"
    }
  },

  --- Seed Bomb Wave - 2
  {
    type = "projectile",
    name = "seed-bomb-wave-2",
    flags = {"not-on-map"},
    acceleration = 0,
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "create-entity",
              entity_name = "seedling-2",
              check_buildability = true,
              trigger_created_entity = true,
            }
          }
        }
      },
    },
    animation = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "high"
    },
    shadow = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "high"
    }
  },

  --- Seed Bomb Wave - 3
  {
    type = "projectile",
    name = "seed-bomb-wave-3",
    flags = {"not-on-map"},
    acceleration = 0,
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "create-entity",
              entity_name = "seedling-3",
              check_buildability = true,
              trigger_created_entity = true,
            },
          }
        }
      },
    },
    animation = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "high"
    },
    shadow = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "high"
    }
  },


  ---- Arboretum Area Overlay
  {
    type = "ammo-turret",
    name = "bi-arboretum-area",
    localised_name = {"entity-name.bi-arboretum"},
    localised_description = {"entity-description.bi-arboretum"},
    icon = ICONPATH .. "entity/Arboretum_Icon.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"not-deconstructable", "not-on-map", "not-repairable"},
    --~ open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    --~ close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    open_sound = sounds.open_sound,
    close_sound = sounds.close_sound,
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-4.5, -4.5}, {4.5, 4.5}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    order = "x[bi]-a[bi-arboretum]",
    automated_ammo_count = 1,
    resistances = {},
    inventory_size = 1,
    attack_parameters = {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 2,
      range = 75,
      projectile_creation_distance = 0.1,
      action ={}
    },
    folding_speed = 0.08,
    folding_animation = {
      filename = "__core__/graphics/empty.png",
      frame_count = 1,
      direction_count = 1,
      width = 1,
      height = 1,
      priority = "high"
    },
    folded_animation = {
      layers = {
        {
          filename = ENTITYPATH .. "bio_terraformer/arboretum.png",
          priority = "low",
          width = 320,
          height = 320,
          frame_count = 1,
          direction_count = 1,
          scale = 1,
          shift = {0, 0},
          hr_version ={
            filename = ENTITYPATH .. "bio_terraformer/hr_arboretum.png",
            priority = "low",
            width = 640,
            height = 640,
            frame_count = 1,
            direction_count = 1,
            scale = 0.5,
            shift = {0, 0},
          }
        },
        {
          filename = ENTITYPATH .. "bio_terraformer/arboretum_shadow.png",
          priority = "low",
          width = 280,
          height = 320,
          frame_count = 1,
          direction_count = 1,
          scale = 1,
          shift = {2, 0},
          draw_as_shadow = true,
          hr_version ={
            filename = ENTITYPATH .. "bio_terraformer/hr_arboretum_shadow.png",
            priority = "low",
            width = 560,
            height = 640,
            frame_count = 1,
            direction_count = 1,
            scale = 0.5,
            shift = {2, 0},
            draw_as_shadow = true,
          }
        },
      }
    },
    call_for_help_radius = 1
  },


  --- Assembling-Machine Arboretum
  {
    type = "assembling-machine",
    name = "bi-arboretum",
    icon = ICONPATH .. "entity/Arboretum_Icon.png",
    icon_size = 64,
    BI_add_icon = true,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    placeable_by = {item ="bi-arboretum-area", count = 1}, -- Fixes that entity couldn't be blueprinted
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-arboretum-area"},
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    resistances = {{type = "fire", percent = 70}},
    fluid_boxes = {
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {-1, -5} }}
      },
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {1, -5} }}
      },
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {-1, 5} }}
      },
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {1, 5} }}
      },
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {5, -1} }}
      },
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {5, 1} }}
      },
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {-5, -1} }}
      },
      {
        production_type = "input",
        --pipe_picture = assembler2pipepicturesBioreactor(),
        pipe_covers = pipecoverspictures(),
        base_area = 1,
        base_level = -1,
        pipe_connections = {{ type = "input-output", position = {-5, 1} }}
      },
      off_when_no_fluid_recipe = false
    },
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    order = "x[bi]-a[bi-arboretum]",
    animation = {
      layers = {
        {
          filename = ENTITYPATH .. "bio_terraformer/arboretum.png",
          priority = "low",
          width = 320,
          height = 320,
          frame_count = 1,
          repeat_count = 9,
          scale = 1,
          shift = {0, 0},
          hr_version ={
            filename = ENTITYPATH .. "bio_terraformer/hr_arboretum.png",
            priority = "low",
            width = 640,
            height = 640,
            frame_count = 1,
            repeat_count = 9,
            scale = 0.5,
            shift = {0, 0},
          }
        },
        {
          filename = ENTITYPATH .. "bio_terraformer/arboretum_shadow.png",
          priority = "low",
          width = 280,
          height = 320,
          frame_count = 1,
          repeat_count = 9,
          scale = 1,
          shift = {2, 0},
          draw_as_shadow = true,
          hr_version ={
            filename = ENTITYPATH .. "bio_terraformer/hr_arboretum_shadow.png",
            priority = "low",
            width = 560,
            height = 640,
            frame_count = 1,
            repeat_count = 9,
            scale = 0.5,
            shift = {2, 0},
            draw_as_shadow = true,
          }
        },
        --[[{
          filename = ENTITYPATH .. "bio_terraformer/arboretum_radar_anim.png",
          priority = "low",
          width = 80,
          height = 64,
          frame_count = 9,
          line_length = 9,
          repeat_count = 1,
          animation_speed = 1,
          scale = 1,
          shift = util.by_pixel(0, -127),
          --frame_sequence = { 2, 2, 2, 2, 2, 4, 3, 4, 3 }
          hr_version ={
            filename = ENTITYPATH .. "bio_terraformer/hr_arboretum_radar_anim.png",
            priority = "low",
            width = 160,
            height = 128,
            frame_count = 9,
            line_length = 9,
            repeat_count = 1,
            animation_speed = 1,
            scale = 0.5,
            shift = util.by_pixel(0, -127),
          }
        },]]--
      }
    },
    working_visualisations = {
      {
        draw_as_light = true,
        effect = "flicker",
        apply_recipe_tint = "primary",
        fadeout = true,
        constant_speed = true,
        animation = {
          layers = {
            {
              filename = ENTITYPATH .. "bio_terraformer/arboretum_light.png",
              width = 280,
              height = 320,
              scale = 1,
              shift = {0, 0},
              hr_version = {
                filename = ENTITYPATH .. "bio_terraformer/hr_arboretum_light.png",
                width = 560,
                height = 640,
                scale = 0.5,
                shift = {0, 0},
              }
            },
          },
        },
      },
      {
        constant_speed = true,
        always_draw = true,
        animation = {
          layers = {
            {
              filename = ENTITYPATH .. "bio_terraformer/arboretum_radar_anim.png",
              priority = "low",
              width = 80,
              height = 64,
              frame_count = 9,
              line_length = 9,
              frame_sequence = {1,1,1,1,1,1,1,2,2,2,2,3,3,3,4,4,5,6,6,7,7,7,8,8,8,8,9,9,9,9,9,8,8,8,8,7,7,7,6,6,5,4,4,3,3,3,2,2,2,2},
              repeat_count = 1,
              animation_speed = 0.3,
              scale = 1,
              shift = util.by_pixel(0, -126),
              --frame_sequence = { 2, 2, 2, 2, 2, 4, 3, 4, 3 }
              hr_version ={
                filename = ENTITYPATH .. "bio_terraformer/hr_arboretum_radar_anim.png",
                priority = "low",
                width = 160,
                height = 128,
                frame_count = 9,
                line_length = 9,
                frame_sequence = {1,1,1,1,1,1,1,2,2,2,2,3,3,3,4,4,5,6,6,7,7,7,8,8,8,8,9,9,9,9,9,8,8,8,8,7,7,7,6,6,5,4,4,3,3,3,2,2,2,2},
                repeat_count = 1,
                animation_speed = 0.3,
                scale = 0.5,
                shift = util.by_pixel(0, -126),
              }
            },
          },
        },
      },
    },
    crafting_categories = {"bi-arboretum"},
    crafting_speed = 0.000000000001,
    --crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "primary-input",
      emissions_per_minute = -4, -- the "-" means it Absorbs pollution.
    },
    energy_usage = "150kW",
    ingredient_count = 3,
    --~ open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    --~ close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    open_sound = sounds.open_sound,
    close_sound = sounds.close_sound,
    vehicle_impact_sound = sounds.generic_impact,
    module_specification = {},
  },
})

--~ local my_pole_1 = util.table.deepcopy(data.raw["electric-pole"]["bi-bio-farm-hidden-pole"])
--~ my_pole_1.name = "bi-hidden-power-pole"
--~ my_pole_1.pictures = BioInd.is_debug and data.raw["electric-pole"]["small-electric-pole"].pictures  or my_pole_1.pictures
--~ data:extend({my_pole_1})

--[[
local my_seedling = util.table.deepcopy(data.raw.tree["tree-01"])
my_seedling.name = "seedling"
--~ my_seedling.vehicle_impact_sound = { filename = "__base__/sound/car-wood-impact.ogg", volume = 0.8 }
my_seedling.vehicle_impact_sound = vehicle_impact_sound = sounds.car_wood_impact
my_seedling.flags = {"placeable-neutral", "placeable-player", "playeminabler-creation", "breaths-air"}
my_seedling.minable = {mining_particle = "wooden-particle", mining_time = 0.25, result = "seedling", count = 1}
my_seedling.corpse = nil
my_seedling.remains_when_mined = nil
my_seedling.max_health = 5
my_seedling.collision_box = {{-0.1, -0.1}, {0.1, 0.1}}
my_seedling.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
my_seedling.emissions_per_second = -0.0006

data:extend({my_seedling})
]]
