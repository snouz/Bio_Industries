local BioInd = require('common')('Bio_Industries')

--~ local ICONPATH = BioInd.modRoot .. "/graphics/entities/biofarm/"
local ICONPATH = BioInd.modRoot .. "/graphics/icons/"
local ENTITYPATH = BioInd.modRoot .. "/graphics/entities/biofarm/"

--~ local BIGICONS = BioInd.check_base_version()

require ("prototypes.Bio_Farm.pipeConnectors")
require ("util")

-- demo-sounds has been removed in Factorio 1.1, so we need to check the game version!
local sound_def = BioInd.check_version("base", "<", "1.1.0") and
                    require("__base__.prototypes.entity.demo-sounds") or
                    require("__base__.prototypes.entity.sounds")
local sounds = {}
sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact
  for _, sound in ipairs(sounds.generic_impact) do
    sound.volume = 0.65
  end


inv_extension2 = {
  filename = ENTITYPATH .. "Arboretum_Idle.png",
  priority = "high",
  width = 320,
  height = 320,
  frame_count = 1,
  direction_count = 1,
  shift = {0.75, 0},
}


data:extend({
  ------- Seedling
  {
    type = "simple-entity-with-force",
    name = "seedling",
    localised_name = {"entity-name.seedling"},
    localised_description = {"entity-description.seedling"},
    icon = ICONPATH .. "Seedling.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "Seedling.png",
        icon_size = 64,
      }
    },
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
    picture = {
      filename = ICONPATH .. "Seedling_b.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      --~ scale = 0.75
      scale = 0.3
    },
  },

  ------- Seedling - Dummy for Seed Bomb
  {
    type = "simple-entity-with-force",
    name = "seedling-2",
    localised_name = {"entity-name.seedling"},
    localised_description = {"entity-description.seedling"},
    icon = ICONPATH .. "Seedling.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "Seedling.png",
        icon_size = 64,
      }
    },
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
    picture = {
      filename = ICONPATH .. "Seedling_b.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      --~ scale = 0.75
      scale = 0.3
    },
  },

  {
    type = "simple-entity-with-force",
    name = "seedling-3",
    localised_name = {"entity-name.seedling"},
    localised_description = {"entity-description.seedling"},
    icon = ICONPATH .. "Seedling.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "Seedling.png",
        icon_size = 64,
      }
    },
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
    picture = {
      filename = ICONPATH .. "Seedling_b.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      --~ scale = 0.75
      scale = 0.3
    },
  },


  ------- Bio Farm
  {
    type = "assembling-machine",
    name = "bi-bio-farm",
    icon = ICONPATH .. "entity/Bio_Farm_Icon.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/Bio_Farm_Icon.png",
        icon_size = 64,
      }
    },
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-farm"},
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    resistances = {{type = "fire", percent = 70}},
    fluid_boxes = {
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type = "input", position = {-1, -5} }}
      },
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type = "input", position = {1, -5} }}
      },
      off_when_no_fluid_recipe = true
    },

    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},

    animation = {
      filename = ENTITYPATH .. "Bio_Farm_Idle.png",
      priority = "high",
      width = 348,
      height = 288,
      shift = {0.96, 0},
      frame_count = 1,
    },

    working_visualisations = {
      animation = {
        filename = ENTITYPATH .. "Bio_Farm_Working.png",
        priority = "high",
        width = 348,
        height = 288,
        shift = {0.96, 0},
        frame_count = 1,
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
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound = sounds.generic_impact,
    module_specification = {
      module_slots = 3
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  },

------- Bio Farm Lamp
  {
    type = "lamp",
    name = "bi-bio-farm-light",
    icon = ICONPATH .. "entity/Bio_Farm_Lamp.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/Bio_Farm_Lamp.png",
        icon_size = 64,
      }
    },
    flags = {"not-deconstructable", "not-on-map", "placeable-off-grid", "not-repairable", "not-blueprintable"},
    selectable_in_game = false,
    max_health = 1,
    collision_box = {{-0.0, -0.0}, {0.0, 0.0}},
    collision_mask = {},
    energy_source = {
      type = "void",
      render_no_network_icon = false,
      render_no_power_icon = false,
      usage_priority = "lamp"
    },
    energy_usage_per_tick = "100kW",
    light = {intensity = 1, size = 45},
    picture_off = {
      filename = ENTITYPATH .. "Bio_Farm_Idle.png",
      priority = "low",
      width = 1,
      height = 1,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 1,
      shift = {0.75, 0},
    },
    picture_on = {
      filename = ENTITYPATH .. "Bio_Farm_Working.png",
      priority = "low",
      width = 1,
      height = 1,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 1,
      shift = {0.75, 0},
    },
  },
})

  ------- Bio Farm Hidden Electric Pole
  --~ {
    --~ type = "electric-pole",
    --~ name = "bi-bio-farm-electric-pole",
    --~ icon = ICONPATH .. "Bio_Farm_Cabeling.png",
    --~ icon_size = 64,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Bio_Farm_Cabeling.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    --~ flags = {"not-deconstructable", "not-on-map", "placeable-off-grid", "not-repairable", "not-blueprintable"},
    --~ selectable_in_game = false,
    --~ max_health = 1,
    --~ resistances = {{type = "fire", percent = 100}},
    --~ collision_box = {{-0, -0}, {0, 0}},
    --~ collision_mask = {},
    --~ maximum_wire_distance = 10,
    --~ supply_area_distance = 5,
    --~ pictures = {
      --~ filename = ICONPATH .. "empty.png",
      --~ priority = "low",
      --~ width = 1,
      --~ height = 1,
      --~ frame_count = 1,
      --~ axially_symmetrical = false,
      --~ direction_count = 4,
      --~ direction_count = 1,
      --~ shift = {0.75, 0},
    --~ },
    --~ connection_points = {
      --~ {
        --~ shadow = {},
        --~ wire = {}
      --~ },
      --~ {
        --~ shadow = {},
        --~ wire = {}
      --~ },
      --~ {
        --~ shadow = {},
        --~ wire = {}
      --~ },
      --~ {
        --~ shadow = {},
        --~ wire = {}
      --~ }
    --~ },
    --~ radius_visualisation_picture = {
      --~ filename = ICONPATH .. "empty.png",
      --~ width = 1,
      --~ height = 1,
      --~ priority = "low"
    --~ },
  --~ },
local hidden_pole = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])
BioInd.show("data.raw[\"electric-pole\"][\"small-electric-pole\"]", data.raw["electric-pole"]["small-electric-pole"])
hidden_pole.name = "bi-bio-farm-electric-pole"
hidden_pole.icon = BioInd.is_debug and hidden_pole.icon or ICONPATH .. "entity/Bio_Farm_Cabeling.png"
hidden_pole.icon_size = BioInd.is_debug and hidden_pole.icon_size or 64
hidden_pole.icons = BioInd.is_debug and hidden_pole.icons or {
  {
    icon = ICONPATH .. "entity/Bio_Farm_Cabeling.png",
    icon_size = 64,
  }
}
hidden_pole.flags = {"not-deconstructable", "not-on-map", "placeable-off-grid", "not-repairable", "not-blueprintable"}
hidden_pole.selectable_in_game = false
hidden_pole.draw_copper_wires = BioInd.is_debug
hidden_pole.max_health = 1
hidden_pole.resistances = {{type = "fire", percent = 100}}
hidden_pole.collision_box = {{-0, -0}, {0, 0}}
hidden_pole.collision_mask = {}
hidden_pole.maximum_wire_distance = 10
hidden_pole.supply_area_distance = 5
hidden_pole.pictures = BioInd.is_debug and hidden_pole.pictures or {
  filename = ICONPATH .. "empty.png",
  priority = "low",
  width = 1,
  height = 1,
  frame_count = 1,
  axially_symmetrical = false,
  direction_count = 1,
  shift = {0.75, 0},
}
hidden_pole.connection_points = BioInd.is_debug and hidden_pole.connection_points or {
  {
    shadow = {},
    wire = {}
  },
}
hidden_pole.radius_visualisation_picture = BioInd.is_debug and
                                            hidden_pole.radius_visualisation_picture or {
                                              filename = ICONPATH .. "empty.png",
                                              width = 1,
                                              height = 1,
                                              priority = "low"
                                            }
hidden_pole.dying_explosion = nil
hidden_pole.fast_replaceable_group = nil
hidden_pole.minable = nil
hidden_pole.open_sound = nil
hidden_pole.vehicle_impact_sound = nil
hidden_pole.water_reflection = nil

data:extend({hidden_pole})

data:extend({
  ------- Bio Farm Solar Panel
  {
    type = "solar-panel",
    name = "bi-bio-farm-solar-panel",
    icon = ICONPATH .. "entity/Bio_Farm_Solar.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/Bio_Farm_Solar.png",
        icon_size = 64,
      }
    },
    flags = {"not-deconstructable", "not-on-map", "placeable-off-grid", "not-repairable", "not-blueprintable"},
    selectable_in_game = false,
    max_health = 1,
    resistances = {{type = "fire", percent = 100}},
    collision_box = {{-0, -0}, {0, 0}},
    collision_mask = {},
    energy_source = {
      type = "electric",
      usage_priority = "solar"
    },
    picture = {
      filename = ICONPATH .. "empty.png",
      priority = "low",
      width = 1,
      height = 1,
    },
    production = "100kW"
  },

  ------ Greenhouse
  {
    type = "assembling-machine",
    name = "bi-bio-greenhouse",
    icon = ICONPATH .. "entity/bio_greenhouse.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/bio_greenhouse.png",
        icon_size = 64,
      }
    },
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
      emissions_per_minute = -6, -- the "-" means it Absorbs pollution.
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
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/assembling-machine-3-pipe-N.png",
            priority = "extra-high",
            width = 35,
            height = 18,
            shift = util.by_pixel(2.5, 14),
            hr_version =
            {
              filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr-assembling-machine-3-pipe-N-exp.png",
              priority = "extra-high",
              width = 171,
              height = 152,
              shift = util.by_pixel(2.25, 13.5),
              scale = 0.5
            }
          },
          east =
          {
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/assembling-machine-3-pipe-E.png",
            priority = "extra-high",
            width = 20,
            height = 38,
            shift = util.by_pixel(-25, 1),
            hr_version =
            {
              filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr-assembling-machine-3-pipe-E.png",
              priority = "extra-high",
              width = 42,
              height = 76,
              shift = util.by_pixel(-24.5, 1),
              scale = 0.5
            }
          },
          south =
          {
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/assembling-machine-3-pipe-S.png",
            priority = "extra-high",
            width = 44,
            height = 31,
            shift = util.by_pixel(0, -31.5),
            hr_version =
            {
              filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr-assembling-machine-3-pipe-S.png",
              priority = "extra-high",
              width = 88,
              height = 61,
              shift = util.by_pixel(0, -31.25),
              scale = 0.5
            }
          },
          west =
          {
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/assembling-machine-3-pipe-W.png",
            priority = "extra-high",
            width = 19,
            height = 37,
            shift = util.by_pixel(25.5, 1.5),
            hr_version =
            {
              filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr-assembling-machine-3-pipe-W.png",
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
          filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/bio_greenhouse.png",
          width = 96,
          height = 128,
          frame_count = 1,
          line_length = 1,
          repeat_count = 10,
          animation_speed = 0.05,
          scale = 1,
          shift = {0, -0.5},
          hr_version = {
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr_bio_greenhouse.png",
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
          filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/bio_greenhouse_light_anim.png",
          width = 96,
          height = 128,
          frame_count = 10,
          line_length = 10,
          repeat_count = 1,
          animation_speed = 0.08,
          scale = 1,
          shift = {0, -0.5},
          draw_as_glow = true,
          blend_mode = multiplicative,
          hr_version = {
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr_bio_greenhouse_light_anim.png",
            width = 192,
            height = 256,
            frame_count = 10,
            line_length = 10,
            repeat_count = 1,
            animation_speed = 0.08,
            scale = 0.5,
            shift = {0, -0.5},
            draw_as_glow = true,
            blend_mode = multiplicative,
          }
        },
        {
          filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/bio_greenhouse_shadow.png",
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
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr_bio_greenhouse_shadow.png",
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
    idle_animation = {
      layers = {
        {
          filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/bio_greenhouse.png",
          width = 96,
          height = 128,
          frame_count = 1,
          line_length = 1,
          repeat_count = 10,
          animation_speed = 0.05,
          scale = 1,
          shift = {0, -0.5},
          hr_version = {
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr_bio_greenhouse.png",
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
          filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/bio_greenhouse_shadow.png",
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
            filename = BioInd.modRoot .. "/graphics/entities/bio_greenhouse/hr_bio_greenhouse_shadow.png",
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
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound = sounds.generic_impact,
  },

  -- COKERY
  {
    type = "assembling-machine",
    name = "bi-cokery",
    icon = ICONPATH .. "entity/cokery.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/cokery.png",
        icon_size = 64,
      }
    },
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
          filename = "__Bio_Industries__/graphics/entities/cokery/cokery_anim.png",
          frame_count = 16,
          line_length = 8,
          width = 128,
          height = 128,
          scale = 1,
          shift = {0.5, -0.5},
          animation_speed = 0.1,
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/cokery/hr_cokery_anim.png",
            frame_count = 16,
            line_length = 8,
            width = 256,
            height = 256,
            scale = 0.5,
            shift = {0.5, -0.5},
            animation_speed = 0.1,
          }
        },
        {
          filename = "__Bio_Industries__/graphics/entities/cokery/cokery_shadow.png",
          priority = "extra-high",
          width = 167,
          height = 64,
          frame_count = 1,
          line_length = 1,
          repeat_count = 16,
          shift = {0.5, 0.5},
          scale = 1,
          animation_speed = 0.1,
          draw_as_shadow = true,
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/cokery/hr_cokery_shadow.png",
            priority = "extra-high",
            width = 334,
            height = 128,
            frame_count = 1,
            line_length = 1,
            repeat_count = 16,
            shift = {0.5, 0.5},
            scale = 0.5,
            animation_speed = 0.1,
            draw_as_shadow = true,
          }
        },
      },
    },

    idle_animation = {
      layers = {
        {
          filename = "__Bio_Industries__/graphics/entities/cokery/cokery_idle.png",
          frame_count = 1,
          line_length = 1,
          width = 128,
          height = 128,
          scale = 1,
          shift = {0.5, -0.5},
          animation_speed = 0.1,
          repeat_count = 16,
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/cokery/hr_cokery_idle.png",
            frame_count = 1,
            line_length = 1,
            width = 256,
            height = 256,
            scale = 0.5,
            shift = {0.5, -0.5},
            animation_speed = 0.1,
            repeat_count = 16,
          }
        },
        {
          filename = "__Bio_Industries__/graphics/entities/cokery/cokery_shadow.png",
          priority = "extra-high",
          width = 167,
          height = 64,
          frame_count = 1,
          line_length = 1,
          shift = {0.5, 0.5},
          scale = 1,
          animation_speed = 0.1,
          draw_as_shadow = true,
          repeat_count = 16,
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/cokery/hr_cokery_shadow.png",
            priority = "extra-high",
            width = 334,
            height = 128,
            frame_count = 1,
            line_length = 1,
            shift = {0.5, 0.5},
            scale = 0.5,
            animation_speed = 0.1,
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
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-stone-crusher"},
    max_health = 100,
    corpse = "medium-remnants",
    module_slots = 1,
    resistances = {{type = "fire", percent = 70}},
    working_sound = {
      sound = {
        filename = "__base__/sound/assembling-machine-t1-1.ogg",
        volume = 0.7
      },
      apparent_volume = 1.5
    },
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1.0, -1.0}, {1.0, 1.0}},

    animation = {
      layers = {
        {
          filename = "__Bio_Industries__/graphics/entities/stone-crusher/stone_crusher_anim.png",
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
            filename = "__Bio_Industries__/graphics/entities/stone-crusher/hr_stone_crusher_anim.png",
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
          filename = "__Bio_Industries__/graphics/entities/stone-crusher/stone_crusher_shadow.png",
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
            filename = "__Bio_Industries__/graphics/entities/stone-crusher/hr_stone_crusher_shadow.png",
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
          filename = "__Bio_Industries__/graphics/entities/stone-crusher/stone_crusher_off.png",
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
            filename = "__Bio_Industries__/graphics/entities/stone-crusher/hr_stone_crusher_off.png",
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
          filename = "__Bio_Industries__/graphics/entities/stone-crusher/stone_crusher_shadow.png",
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
            filename = "__Bio_Industries__/graphics/entities/stone-crusher/hr_stone_crusher_shadow.png",
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

  ---     Arboretum
  --- Radar Arboretum
  {
    type = "radar",
    name = "bi-arboretum-radar",
    localised_name = {"entity-name.bi-arboretum"},
    localised_description = {"entity-description.bi-arboretum"},
    icon = ICONPATH .. "entity/Arboretum_Icon.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/Arboretum_Icon.png",
        icon_size = 64,
      }
    },
    flags = {"placeable-player", "player-creation", "not-deconstructable"},
    order = "y[bi]-a[bi-arboretum]",
    minable = nil,
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    resistances = {
      {
        type = "fire",
        percent = 70
      }
    },

    energy_per_sector = "2MJ",
    max_distance_of_nearby_sector_revealed = 2,
    max_distance_of_sector_revealed = 5,
    energy_per_nearby_scan = "200kW",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 0, -- the "-" means it Absorbs pollution.
    },
    energy_usage = "150kW",
    pictures = {
      layers = {
        {
          filename = "__core__/graphics/empty.png",
          frame_count = 1,
          width = 1,
          height = 1,
          priority = "high",
          direction_count = 1,
        },
      }
    },
  },


  ---- Arboretum Area Overlay
  {
    type = "ammo-turret",
    name = "bi-arboretum-area",
    localised_name = {"entity-name.bi-arboretum"},
    localised_description = {"entity-description.bi-arboretum"},
    icon = ICONPATH .. "entity/Arboretum_Icon.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/Arboretum_Icon.png",
        icon_size = 64,
      }
    },
    flags = {"not-deconstructable", "not-on-map", "placeable-off-grid", "not-repairable"},
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
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
    folded_animation = (function()
        local res = util.table.deepcopy(inv_extension2)
        res.frame_count = 1
        res.line_length = 1
        return res
        end)(),

    folding_animation = (function()
        local res = util.table.deepcopy(inv_extension2)
        res.run_mode = "backward"
        return res
        end)(),

    call_for_help_radius = 1
  },


  --- Assembling-Machine Arboretum
  {
    type = "assembling-machine",
    name = "bi-arboretum",
    icon = ICONPATH .. "entity/Arboretum_Icon.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/Arboretum_Icon.png",
        icon_size = 64,
      }
    },
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
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type = "input", position = {-1, -5} }}
      },
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type = "input", position = {1, -5} }}
      },
      off_when_no_fluid_recipe = true
    },
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    order = "x[bi]-a[bi-arboretum]",
    animation = {
      filename = ENTITYPATH .. "Arboretum_Idle.png",
      priority = "low",
      width = 320,
      height = 320,
      frame_count = 1,
      shift = {0.75, 0},
    },

    working_visualisations = {
      animation = {
        filename = ENTITYPATH .. "Arboretum_Working.png",
        priority = "low",
        width = 320,
        height = 320,
        frame_count = 1,
        shift = {0.75, 0},
      },
    },
    crafting_categories = {"bi-arboretum"},
    crafting_speed = 0.000000000001,
    energy_source = {
      type = "electric",
      usage_priority = "primary-input",
      emissions_per_minute = -8, -- the "-" means it Absorbs pollution.
    },
    energy_usage = "150kW",
    ingredient_count = 3,
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound = sounds.generic_impact,
    module_specification = {},
  },
})

local my_pole_1 = util.table.deepcopy(data.raw["electric-pole"]["bi-bio-farm-electric-pole"])
my_pole_1.name = "bi-hidden-power-pole"
--~ my_pole_1.draw_copper_wires = false
--~ my_pole_1.draw_copper_wires = BioInd.is_debug
--~ my_pole_1.pictures = BioInd.is_debug and data.raw["electric-pole"]["small-electric-pole"].pictures  or my_pole_1.pictures
data:extend({my_pole_1})

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
