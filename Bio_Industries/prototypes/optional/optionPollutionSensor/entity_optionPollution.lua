------------------------------------------------------------------------------------
--                          Enable: BI_Pollution_Detector                         --
--                       (BI.Settings.BI_Pollution_Detector)                      --
------------------------------------------------------------------------------------
local setting = "BI_Pollution_Detector"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end

BI.additional_entities = BI.additional_entities or {}
BI.additional_entities[setting] = BI.additional_entities[setting] or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local ENTITYPATH = BioInd.entitypath
local POLSENSORPATH = BioInd.entitypath .. "pollution_sensor/"
local SNDPATH = "__base__/sound/"

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}

sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact


for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end

--~ sounds.open_sound = { filename = SNDPATH .. "wooden-chest-open.ogg" }
--~ sounds.close_sound = { filename = SNDPATH .. "wooden-chest-close.ogg" }

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


------------------------------------------------------------------------------------
--                                Pollution sensor                                --
------------------------------------------------------------------------------------
BI.additional_entities[setting].pollution_sensor = {
  type = "constant-combinator",
  name = BioInd.pollution_sensor_name,
  icon = ICONPATH .. "entity/pollution_sensor.png",
  icon_size = 64, icon_mipmaps = 4,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 0.1, result = "bi-pollution-sensor"},
  max_health = 120,
  corpse = "constant-combinator-remnants",
  dying_explosion = "constant-combinator-explosion",
  collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  damaged_trigger_effect = hit_effects.entity(),
  fast_replaceable_group = "constant-combinator",

  item_slot_count = 1,

  vehicle_impact_sound = sounds.generic_impact,
  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close,

  activity_led_sprites =
  {
    filename = "__core__/graphics/empty.png",
    width = 1,
    height = 1,
    frame_count = 1,
    shift = util.by_pixel(0, 0),
  },

  activity_led_light =
  {
    intensity = 0,
    size = 1,
    color = {r = 0, g = 0, b = 0}
  },

  activity_led_light_offsets =
  {
    {0, 0},
    {0, 0},
    {0, 0},
    {0, 0},
  },

  circuit_wire_connection_points =
  {
    {
      shadow =
      {
        red = util.by_pixel(-9, 10),
        green = util.by_pixel(-9, -2)
      },
      wire =
      {
        red = util.by_pixel(-19.5, -2.5),
        green = util.by_pixel(-19.5, -14.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(-9, 10),
        green = util.by_pixel(-9, -2)
      },
      wire =
      {
        red = util.by_pixel(-19.5, -2.5),
        green = util.by_pixel(-19.5, -14.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(-9, 10),
        green = util.by_pixel(-9, -2)
      },
      wire =
      {
        red = util.by_pixel(-19.5, -2.5),
        green = util.by_pixel(-19.5, -14.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(-9, 10),
        green = util.by_pixel(-9, -2)
      },
      wire =
      {
        red = util.by_pixel(-19.5, -2.5),
        green = util.by_pixel(-19.5, -14.5)
      }
    },
  },

  circuit_wire_max_distance = 9,
  sprites = {
    layers =
    {
      {
        filename = POLSENSORPATH .. "pollution-sensor.png",
        width = 48,
        height = 40,
        shift = util.by_pixel(0, -1),
        hr_version =
        {
          filename = POLSENSORPATH .. "hr-pollution-sensor.png",
          width = 96,
          height = 80,
          shift = util.by_pixel(0, -1),
          scale = 0.5,
        },
      },
      {
        filename = POLSENSORPATH .. "pollution-sensor-shadow.png",
        priority = "extra-high",
        width = 56,
        height = 23,
        shift = util.by_pixel(12, 5.5),
        draw_as_shadow = true,
        hr_version =
        {
          filename = POLSENSORPATH .. "hr-pollution-sensor-shadow.png",
          priority = "extra-high",
          width = 112,
          height = 46,
          shift = util.by_pixel(12, 5.5),
          draw_as_shadow = true,
          scale = 0.5
        }
      }
    },
  },
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
BioInd.debugging.entered_file("leave")
