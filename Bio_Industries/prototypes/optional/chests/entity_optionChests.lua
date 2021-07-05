------------------------------------------------------------------------------------
--                          Enable: Bigger wooden chests                          --
--                      (BI.Settings.BI_Bigger_Wooden_Chests)                     --
------------------------------------------------------------------------------------
local setting = "BI_Bigger_Wooden_Chests"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

BI.optional_entities = BI.optional_entities or {}
BI.optional_entities[setting] = BI.optional_entities[setting] or {}

local BioInd = require('common')('Bio_Industries')


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
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                        Rename the vanilla wooden chest!                        --
------------------------------------------------------------------------------------
data.raw.container["wooden-chest"].localised_name = {"entity-name.bi-wooden-chest"}


------------------------------------------------------------------------------------
--                        Create the bigger wooden chests!                        --
------------------------------------------------------------------------------------
-- Large wooden chest
BI.optional_entities[setting].large_wooden_chest = {
  type = "container",
  name = "bi-wooden-chest-large",
  icon = ICONPATH .. "entity/wood_chest_large.png",
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
BI.optional_entities[setting].huge_wooden_chest = {
  type = "container",
  name = "bi-wooden-chest-huge",
  icon = ICONPATH .. "entity/wood_chest_huge.png",
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
BI.optional_entities[setting].giga_wooden_chest = {
  type = "container",
  name = "bi-wooden-chest-giga",
  icon = ICONPATH .. "entity/wood_chest_giga.png",
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
--                                 Create entities                                --
------------------------------------------------------------------------------------
for e, e_data in pairs(BI.optional_entities[setting] or {}) do
  data:extend({e_data})
  BioInd.created_msg(e_data)
end


------------------------------------------------------------------------------------
--                                 Create remnants                                --
------------------------------------------------------------------------------------
for r, r_data in pairs(BI.optional_remnants[setting] or {}) do
  data:extend({r_data})
  BioInd.created_msg(r_data)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
