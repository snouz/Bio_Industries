------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
local setting = "BI_Rubber"
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


-- Solar mat/Musk floor
BI.additional_entities[setting].rubber_mat = {
  type = "tile",
  name = "bi-rubber-mat",
  localised_name = {"entity-name.bi-rubber-mat"},
  localised_description = {"entity-description.bi-rubber-mat"},
  icon = ICONPATH .. "entity/rubber-mat.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  needs_correction = false,
  minable = {hardness = 0.1, mining_time = 0.25, result = "bi-rubber-mat"},
  mined_sound = { filename = SNDPATH .. "deconstruct-bricks.ogg" },
  --collision_mask = {"ground-tile", "not-colliding-with-itself"},
  collision_mask = {"ground-tile"},
  collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
  layer = 67,
  decorative_removal_probability = 1,
  variants = {
    main = {
      {
        picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
        count = 1,
        size = 1
      },
      {
        picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
        count = 1,
        size = 2,
        probability = 0.39
      },
      {
        picture = "__base__/graphics/terrain/concrete/concrete-dummy.png",
        count = 1,
        size = 4,
        probability = 1
      }
    },


    inner_corner = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_inner-corner.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_inner-corner.png",
        count = 1,
        scale = 0.5,
      }
    },
    inner_corner_mask = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_inner-corner-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_inner-corner-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    outer_corner = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_outer-corner.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_outer-corner.png",
        count = 1,
        scale = 0.5,
      }
    },
    outer_corner_mask = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_outer-corner-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_outer-corner-mask.png",
        count = 1,
        scale = 0.5,
      }
    },

    side = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_side.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_side.png",
        count = 1,
        scale = 0.5,
      }
    },
    side_mask = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_side-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_side-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    u_transition = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_u.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_u.png",
        count = 1,
        scale = 0.5,
      }
    },
    u_transition_mask = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_u-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_u-mask.png",
        count = 1,
        scale = 0.5,
      }
    },

    o_transition = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_o.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_o.png",
        count = 1,
        scale = 0.5,
      }
    },
    o_transition_mask = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat_o-mask.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat_o-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    material_background = {
      picture = ENTITYPATH .. "/rubber-mat/rubber-mat.png",
      count = 1,
      hr_version = {
        picture = ENTITYPATH .. "/rubber-mat/hr_rubber-mat.png",
        count = 1,
        scale = 0.5,
      }
    },
  },
  walking_sound = sounds.walking_sound,
  map_color = {r = 109, g = 110, b = 149},
  pollution_absorption_per_second = 0,
  vehicle_friction_modifier = 2.5,
  walking_speed_modifier = 0.6,
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
