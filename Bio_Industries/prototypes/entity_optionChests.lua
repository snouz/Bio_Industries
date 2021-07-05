if not BI.Settings.BI_Bigger_Wooden_Chests then
  return
end

local BioInd = require('common')('Bio_Industries')


BioInd.writeDebug("Creating bigger wooden chests!")


local ICONPATH = BioInd.iconpath
local WOODPATH = BioInd.entitypath .. "wood_products/"

local ENTITYPATH = "__base__/graphics/entity/"
local PIPEPATH = ENTITYPATH .. "pipe/"

local SNDPATH = "__base__/sound/"
--~ local BIGICONS = BioInd.check_base_version("0.18.0")


--require("prototypes.Wood_Products_demo-remnants-wood")  --- its only for rails

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
--                         Rename the vanill wooden chest!                        --
------------------------------------------------------------------------------------
data.raw.container["wooden-chest"].localised_name = {"entity-name.bi-wooden-chest"}


------------------------------------------------------------------------------------
--                        Create the bigger wooden chests!                        --
------------------------------------------------------------------------------------

-- Large wooden chest
data:extend({
  {
    type = "container",
    name = "bi-wooden-chest-large",
    icon = ICONPATH .. "entity/large_wooden_chest_icon.png",
    icon_size = 64,
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
          filename = WOODPATH .. "large_wooden_chest.png",
          priority = "extra-high",
          width = 64,
          height = 64,
          shift = {0, 0},
          scale = 1,
          hr_version = {
            filename = WOODPATH .. "hr_large_wooden_chest.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            shift = {0, 0},
            scale = 0.5,
          }
        },
        {
          filename = WOODPATH .. "large_wooden_chest_shadow.png",
          priority = "extra-high",
          width = 64,
          height = 64,
          shift = {1, 0},
          scale = 1,
          draw_as_shadow = true,
          hr_version = {
            filename = WOODPATH .. "hr_large_wooden_chest_shadow.png",
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
  },
})

-- Huge wooden chest
data:extend({
  {
    type = "container",
    name = "bi-wooden-chest-huge",
    icon = ICONPATH .. "entity/huge_wooden_chest_icon.png",
    icon_size = 64,
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
          filename = WOODPATH .. "huge_wooden_chest.png",
          priority = "extra-high",
          width = 112,
          height = 112,
          shift = {0, 0},
          scale = 1,
          hr_version = {
            filename = WOODPATH .. "hr_huge_wooden_chest.png",
            priority = "extra-high",
            width = 224,
            height = 224,
            shift = {0, 0},
            scale = 0.5,
          }
        },
        {
          filename = WOODPATH .. "huge_wooden_chest_shadow.png",
          priority = "extra-high",
          width = 112,
          height = 112,
          shift = {1, 0},
          scale = 1,
          draw_as_shadow = true,
          hr_version = {
            filename = WOODPATH .. "hr_huge_wooden_chest_shadow.png",
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
  },
})

-- Gigantic wooden chest
data:extend({
  {
    type = "container",
    name = "bi-wooden-chest-giga",
    icon = ICONPATH .. "entity/giga_wooden_chest_icon.png",
    icon_size = 64,
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
          filename = WOODPATH .. "giga_wooden_chest.png",
          priority = "extra-high",
          width = 192,
          height = 224,
          shift = {0, -0.5},
          scale = 1,
          hr_version = {
            filename = WOODPATH .. "hr_giga_wooden_chest.png",
            priority = "extra-high",
            width = 384,
            height = 448,
            shift = {0, -0.5},
            scale = 0.5,
          }
        },
        {
          filename = WOODPATH .. "giga_wooden_chest_shadow.png",
          priority = "extra-high",
          width = 96,
          height = 192,
          shift = {3.5, 0},
          scale = 1,
          draw_as_shadow = true,
          hr_version = {
            filename = WOODPATH .. "hr_giga_wooden_chest_shadow.png",
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
  },
})
