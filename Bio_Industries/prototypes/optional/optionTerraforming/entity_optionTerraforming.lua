------------------------------------------------------------------------------------
--                              Enable: Terraforming                              --
--                          (BI.Settings.BI_Terraforming)                         --
------------------------------------------------------------------------------------
local setting = "BI_Terraforming"
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

local sounds = {
  open_sound = { filename = SNDPATH .. "machine-open.ogg", volume = 0.85 },
  close_sound = { filename = SNDPATH .. "machine-close.ogg", volume = 0.75 },
  gardenfan_sound = {
    filename = BioInd.soundpath .. "BI_garden_fan.ogg",
    volume = 0.9,
    max_sounds_per_typem = 3
  },
}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ ------------------------------------------------------------------------------------
--~ --                                   Bio reactor                                  --
--~ ------------------------------------------------------------------------------------
--~ -- Pipes
--~ function assembler2pipepicturesBioreactor()
  --~ return {
    --~ north = {
      --~ filename = "__core__/graphics/empty.png",
      --~ priority = "low",
      --~ width = 1,
      --~ height = 1,
      --~ shift = util.by_pixel(2.5, 14),
    --~ },
    --~ east = {
      --~ filename = REACTORPATH .. "pipes/bioreactor-pipe-e.png",
      --~ priority = "extra-high",
      --~ width = 20,
      --~ height = 38,
      --~ shift = util.by_pixel(-25, 1),
      --~ hr_version = {
        --~ filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-e.png",
        --~ priority = "extra-high",
        --~ width = 42,
        --~ height = 76,
        --~ shift = util.by_pixel(-24.5, 1),
        --~ scale = 0.5,
      --~ }
    --~ },
    --~ south = {
      --~ filename = REACTORPATH .. "pipes/bioreactor-pipe-s.png",
      --~ priority = "extra-high",
      --~ width = 44,
      --~ height = 31,
      --~ shift = util.by_pixel(0, -31.5),
      --~ hr_version = {
        --~ filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-s.png",
        --~ priority = "extra-high",
        --~ width = 88,
        --~ height = 61,
        --~ shift = util.by_pixel(0, -31.25),
        --~ scale = 0.5,
      --~ }
    --~ },
    --~ west = {
      --~ filename = REACTORPATH .. "pipes/bioreactor-pipe-W.png",
      --~ priority = "extra-high",
      --~ width = 19,
      --~ height = 37,
      --~ shift = util.by_pixel(25.5, 1.5),
      --~ hr_version = {
        --~ filename = REACTORPATH .. "pipes/hr_bioreactor-pipe-w.png",
        --~ priority = "extra-high",
        --~ width = 39,
        --~ height = 73,
        --~ shift = util.by_pixel(25.75, 1.25),
        --~ scale = 0.5,
      --~ }
    --~ }
  --~ }
--~ end


--~ -- Pipe covers
--~ function pipecoverspicturesBioreactor()
  --~ return {
    --~ north = {
      --~ filename = "__core__/graphics/empty.png",
      --~ priority = "low",
      --~ width = 1,
      --~ height = 1,
    --~ },
    --~ east = {
      --~ filename = PIPEPATH .. "pipe-cover-east.png",
      --~ priority = "extra-high",
      --~ width = 64,
      --~ height = 64,
      --~ hr_version = {
        --~ filename = PIPEPATH .. "hr-pipe-cover-east.png",
        --~ priority = "extra-high",
        --~ width = 128,
        --~ height = 128,
        --~ scale = 0.5
      --~ }
    --~ },
    --~ south = {
      --~ filename = PIPEPATH .. "pipe-cover-south.png",
      --~ priority = "extra-high",
      --~ width = 64,
      --~ height = 64,
      --~ hr_version = {
        --~ filename = PIPEPATH .. "hr-pipe-cover-south.png",
        --~ priority = "extra-high",
        --~ width = 128,
        --~ height = 128,
        --~ scale = 0.5
      --~ }
    --~ },
    --~ west = {
      --~ filename = PIPEPATH .. "pipe-cover-west.png",
      --~ priority = "extra-high",
      --~ width = 64,
      --~ height = 64,
      --~ hr_version = {
        --~ filename = PIPEPATH .. "hr-pipe-cover-west.png",
        --~ priority = "extra-high",
        --~ width = 128,
        --~ height = 128,
        --~ scale = 0.5
      --~ }
    --~ }
  --~ }
--~ end


------------------------------------------------------------------------------------
--                                 Define entities                                --
------------------------------------------------------------------------------------
-- Terraformer (Overlay)
BI.additional_entities[setting].arboretum_area = {
  type = "ammo-turret",
  name = "bi-arboretum-area",
  localised_name = {"entity-name.bi-arboretum"},
  localised_description = {"entity-description.bi-arboretum"},
  icon = ICONPATH .. "entity/terraformer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ flags = {"not-deconstructable", "not-on-map", "not-repairable"},
  flags = {"not-deconstructable", "not-on-map", "not-repairable", "player-creation"},
  --~ --  open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
  --~ --  close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  max_health = 250,
  corpse = "bi-arboretum-area-remnant",
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
        filename = ENTITYPATH .. "bio_terraformer/terraformer.png",
        priority = "low",
        width = 320,
        height = 320,
        frame_count = 1,
        direction_count = 1,
        scale = 1,
        shift = {0, 0},
        hr_version ={
          filename = ENTITYPATH .. "bio_terraformer/hr_terraformer.png",
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
        filename = ENTITYPATH .. "bio_terraformer/terraformer_shadow.png",
        priority = "low",
        width = 280,
        height = 320,
        frame_count = 1,
        direction_count = 1,
        scale = 1,
        shift = {2, 0},
        draw_as_shadow = true,
        hr_version ={
          filename = ENTITYPATH .. "bio_terraformer/hr_terraformer_shadow.png",
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
}

-- Terraformer
BI.additional_entities[setting].arboretum = {
  type = "assembling-machine",
  name = "bi-arboretum",
  icon = ICONPATH .. "entity/terraformer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  placeable_by = {item ="bi-arboretum-area", count = 1}, -- Fixes that entity couldn't be blueprinted
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-arboretum-area"},
  max_health = 250,
  corpse = "bi-arboretum-area-remnant",
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
        filename = ENTITYPATH .. "bio_terraformer/terraformer.png",
        priority = "low",
        width = 320,
        height = 320,
        frame_count = 1,
        repeat_count = 9,
        scale = 1,
        shift = {0, 0},
        hr_version ={
          filename = ENTITYPATH .. "bio_terraformer/hr_terraformer.png",
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
        filename = ENTITYPATH .. "bio_terraformer/terraformer_shadow.png",
        priority = "low",
        width = 280,
        height = 320,
        frame_count = 1,
        repeat_count = 9,
        scale = 1,
        shift = {2, 0},
        draw_as_shadow = true,
        hr_version ={
          filename = ENTITYPATH .. "bio_terraformer/hr_terraformer_shadow.png",
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
            filename = ENTITYPATH .. "bio_terraformer/terraformer_light.png",
            width = 280,
            height = 320,
            scale = 1,
            shift = {0, 0},
            hr_version = {
              filename = ENTITYPATH .. "bio_terraformer/hr_terraformer_light.png",
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
            filename = ENTITYPATH .. "bio_terraformer/terraformer_radar_anim.png",
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
              filename = ENTITYPATH .. "bio_terraformer/hr_terraformer_radar_anim.png",
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
  crafting_categories = {BI.additional_categories.BI_Terraforming.arboretum.name},
  crafting_speed = 0.000000000001,
  --crafting_speed = 1,
  energy_source = {
    type = "electric",
    usage_priority = "primary-input",
    emissions_per_minute = -4, -- the "-" means it Absorbs pollution.
  },
  energy_usage = "150kW",
  ingredient_count = 3,
  --~ --  open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
  --~ --  close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  vehicle_impact_sound = sounds.generic_impact,
  module_specification = {},
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
