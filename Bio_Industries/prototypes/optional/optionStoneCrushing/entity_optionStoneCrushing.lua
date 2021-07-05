------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Stone_Crushing"
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

sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact

for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end

sounds.open_sound = { filename = SNDPATH .. "wooden-chest-open.ogg" }
sounds.close_sound = { filename = SNDPATH .. "wooden-chest-close.ogg" }

sounds.walking_sound = {}
for i = 1, 11 do
  sounds.walking_sound[i] = {
    filename = SNDPATH .. "walking/concrete-" .. (i < 10 and "0" or "")  .. i ..".ogg",
    volume = 1.2
  }
end


------------------------------------------------------------------------------------
--                                   Entity data                                  --
------------------------------------------------------------------------------------
-- Stone crusher
BI.additional_entities[setting].stone_crusher = {
  type = "furnace",
  name = "bi-stone-crusher",
  icon = ICONPATH .. "entity/stone_crusher.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  se_allow_in_space = true, -- Space Exploration - Buildable in orbit
  flags = {"placeable-neutral", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5, result = "bi-stone-crusher"},
  max_health = 100,
  corpse = "bi-stone-crusher-remnant",
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
