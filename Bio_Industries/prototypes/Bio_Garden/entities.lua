local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.modRoot .. "/graphics/icons/"

require ("util")


-- Bio Gardens need to have a hidden pole. This will only be connectable if
-- fluid fertilizer is used in the game.

--- Bio Garden
data:extend({
  {
    type = "assembling-machine",
    name = "bi-bio-garden",
    icon = ICONPATH .. "entity/bio_garden_icon.png",
    icon_size = 64,
    icons = {
        {
            icon = ICONPATH .. "entity/bio_garden_icon.png",
            icon_size = 64,
        }
    },
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "bi-bio-garden"},
    fast_replaceable_group = "bi-bio-garden",
    max_health = 150,
    corpse = "medium-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    fluid_boxes = {
      {
        production_type = "input",
        pipe_picture = {
          north =
          {
            filename = BioInd.modRoot .. "/graphics/icons/empty.png",
            priority = "extra-high",
            width = 32,
            height = 32,
          },
          east =
          {
            filename = BioInd.modRoot .. "/graphics/entities/biogarden/assembling-machine-3-pipe-E.png",
            priority = "extra-high",
            width = 20,
            height = 38,
            shift = util.by_pixel(-25, 1),
            hr_version =
            {
              filename = BioInd.modRoot .. "/graphics/entities/biogarden/hr-assembling-machine-3-pipe-E.png",
              priority = "extra-high",
              width = 42,
              height = 76,
              shift = util.by_pixel(-24.5, 1),
              scale = 0.5
            }
          },
          south =
          {
            filename = BioInd.modRoot .. "/graphics/entities/biogarden/assembling-machine-3-pipe-S.png",
            priority = "extra-high",
            width = 44,
            height = 31,
            shift = util.by_pixel(0, -31.5),
            hr_version =
            {
              filename = BioInd.modRoot .. "/graphics/entities/biogarden/hr-assembling-machine-3-pipe-S.png",
              priority = "extra-high",
              width = 88,
              height = 61,
              shift = util.by_pixel(0, -31.25),
              scale = 0.5
            }
          },
          west =
          {
            filename = BioInd.modRoot .. "/graphics/entities/biogarden/assembling-machine-3-pipe-W.png",
            priority = "extra-high",
            width = 19,
            height = 37,
            shift = util.by_pixel(25.5, 1.5),
            hr_version =
            {
              filename = BioInd.modRoot .. "/graphics/entities/biogarden/hr-assembling-machine-3-pipe-W.png",
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
      off_when_no_fluid_recipe = true
    },




    animation = {
      layers = {
        {
          filename = "__Bio_Industries__/graphics/entities/biogarden/bio_garden_anim_trees.png",
          width = 128,
          height = 160,
          scale = 1,
          frame_count = 20,
          line_length = 5,
          repeat_count = 1,
          animation_speed = 0.15,
          shift = {0, -0.75},
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/biogarden/hr_bio_garden_anim_trees.png",
            width = 256,
            height = 320,
            scale = 0.5,
            frame_count = 20,
            line_length = 5,
            repeat_count = 1,
            animation_speed = 0.15,
            shift = {0, -0.75},
          },
        },
        {
          filename = "__Bio_Industries__/graphics/entities/biogarden/bio_garden_anim_light.png",
          width = 128,
          height = 160,
          scale = 1,
          frame_count = 10,
          line_length = 5,
          repeat_count = 2,
          animation_speed = 0.431,
          shift = {0, -0.75},
          draw_as_glow = true,
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/biogarden/hr_bio_garden_anim_light.png",
            width = 256,
            height = 320,
            scale = 0.5,
            frame_count = 10,
            line_length = 5,
            repeat_count = 2,
            animation_speed = 0.431,
            shift = {0, -0.75},
            draw_as_glow = true,
          },
        },
        {
          filename = "__Bio_Industries__/graphics/entities/biogarden/bio_garden_shadow.png",
          width = 192,
          height = 160,
          scale = 1,
          frame_count = 1,
          line_length = 1,
          repeat_count = 20,
          animation_speed = 0.431,
          shift = {1, -0.75},
          draw_as_shadow = true,
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/biogarden/hr_bio_garden_shadow.png",
            width = 384,
            height = 320,
            scale = 0.5,
            frame_count = 1,
            line_length = 1,
            repeat_count = 20,
            animation_speed = 0.431,
            shift = {1, -0.75},
            draw_as_shadow = true,
          },
        },
      },
    },
    idle_animation = {
      layers = {
        {
          filename = "__Bio_Industries__/graphics/entities/biogarden/bio_garden_anim_trees.png",
          width = 128,
          height = 160,
          scale = 1,
          frame_count = 20,
          line_length = 5,
          repeat_count = 1,
          animation_speed = 0.15,
          shift = {0, -0.75},
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/biogarden/hr_bio_garden_anim_trees.png",
            width = 256,
            height = 320,
            scale = 0.5,
            frame_count = 20,
            line_length = 5,
            repeat_count = 1,
            animation_speed = 0.15,
            shift = {0, -0.75},
          },
        },
        {
          filename = "__Bio_Industries__/graphics/entities/biogarden/bio_garden_shadow.png",
          width = 192,
          height = 160,
          scale = 1,
          frame_count = 1,
          line_length = 1,
          repeat_count = 20,
          animation_speed = 0.431,
          shift = {1, -0.75},
          draw_as_shadow = true,
          hr_version = {
            filename = "__Bio_Industries__/graphics/entities/biogarden/hr_bio_garden_shadow.png",
            width = 384,
            height = 320,
            scale = 0.5,
            frame_count = 1,
            line_length = 1,
            repeat_count = 20,
            animation_speed = 0.431,
            shift = {1, -0.75},
            draw_as_shadow = true,
          },
        },
      },
    },






    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    --working_sound = {
    --  sound = { { filename = "__Bio_Industries__/sound/rainforest_ambience.ogg", volume = 0.8 } },
    --  idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
    --  apparent_volume = 1.5,
    --},
    crafting_categories = {"clean-air"},
    source_inventory_size = 1,
    result_inventory_size = 1,
    crafting_speed = 1.0,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = -45, -- the "-" means it Absorbs pollution.
    },
    energy_usage = "200kW",
    ingredient_count = 1,
    module_specification = {
      module_slots = 1
    },
    allowed_effects = {"consumption", "speed"},
  },
})

  ------- Bio Garden Hidden Electric Pole (has only wire reach if Fluid fertilizer is used)
--~ data:extend({
  --~ {
    --~ type = "electric-pole",
    --~ name = "bi-bio-garden-hidden-pole",
    --~ icon = "__base__/graphics/icons/small-electric-pole.png",
    --~ icon_size = 64,
    --~ icons = {
      --~ {
        --~ icon = "__base__/graphics/icons/small-electric-pole.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    --~ flags = {
      --~ "not-deconstructable",
      --~ "not-on-map",
      --~ "placeable-off-grid",
      --~ "not-repairable",
      --~ "not-blueprintable",
    --~ },
    --~ selectable_in_game = false,
    --~ draw_copper_wires = BioInd.is_debug,
    --~ max_health = 1,
    --~ minable = nil,
    --~ collision_mask = {},
    --~ collision_box = {{-0, -0}, {0, 0}},
    --~ selection_box = {{0, 0}, {0, 0}},
    --~ maximum_wire_distance = BI.Settings.BI_Easy_Bio_Gardens and 4 or 0,
    --~ supply_area_distance = 1,
    --~ pictures = {
      --~ filename = ICONPATH .. "empty.png",
      --~ priority = "low",
      --~ width = 1,
      --~ height = 1,
      --~ frame_count = 1,
      --~ axially_symmetrical = false,
      --~ direction_count = 32,
      --~ direction_count = 1,
    --~ },
    --~ connection_points = {
      --~ {
        --~ shadow = {},
        --~ wire = { copper_wire_tweak = {-0, -0} }
      --~ }
    --~ },
    --~ radius_visualisation_picture = {
      --~ filename = ICONPATH .. "empty.png",
      --~ width = 1,
      --~ height = 1,
      --~ priority = "low"
    --~ },
  --~ },
--~ })

local hidden_pole = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])
hidden_pole.name = "bi-bio-garden-hidden-pole"
hidden_pole.icon = "__base__/graphics/icons/small-electric-pole.png"
hidden_pole.icon_size = 64
hidden_pole.icons = {
      {
        icon = "__base__/graphics/icons/small-electric-pole.png",
        icon_size = 64,
      }
    }
hidden_pole.flags = {
      "not-deconstructable",
      "not-on-map",
      "placeable-off-grid",
      "not-repairable",
      "not-blueprintable",
    }
hidden_pole.selectable_in_game = false
hidden_pole.draw_copper_wires = BioInd.is_debug
hidden_pole.max_health = 1
hidden_pole.minable = nil
hidden_pole.collision_mask = {}
hidden_pole.collision_box = {{-0, -0}, {0, 0}}
hidden_pole.selection_box = {{0, 0}, {0, 0}}
hidden_pole.maximum_wire_distance = BI.Settings.BI_Easy_Bio_Gardens and 4 or 0
hidden_pole.supply_area_distance = 1
hidden_pole.pictures = BioInd.is_debug and hidden_pole.pictures or {
  filename = ICONPATH .. "empty.png",
  priority = "low",
  width = 1,
  height = 1,
  frame_count = 1,
  axially_symmetrical = false,
  direction_count = 1,
}
hidden_pole.connection_points = BioInd.is_debug and hidden_pole.connection_points or {
  {
    shadow = {},
    wire = { copper_wire_tweak = {-0, -0} }
  }
}
hidden_pole.radius_visualisation_picture = BioInd.is_debug and
                                            hidden_pole.radius_visualisation_picture or {
                                                filename = ICONPATH .. "empty.png",
                                                width = 1,
                                                height = 1,
                                                priority = "low"
                                              }

data:extend({hidden_pole})
