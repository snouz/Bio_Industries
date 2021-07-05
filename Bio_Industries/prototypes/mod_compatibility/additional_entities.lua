------------------------------------------------------------------------------------
--    Data for some recipes that will be needed if one of several mods is used.   --
------------------------------------------------------------------------------------
BioInd.entered_file()


BI.additional_entities = BI.additional_entities or {}
BI.additional_entities.mod_compatibility = BI.additional_entities.mod_compatibility or {}

local triggers = {
  "BI_Trigger_Woodfloor",
}
for t, trigger in pairs(triggers) do
  BI.additional_entities[trigger] = BI.additional_entities[trigger] or {}
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local SNDPATH = "__base__/sound/"
local WOODPATH = BioInd.entitypath .. "wood_products/"

local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}

sounds.walking_sound = {}
for i = 1, 11 do
  sounds.walking_sound[i] = {
    filename = SNDPATH .. "walking/concrete-" .. (i < 10 and "0" or "")  .. i ..".ogg",
    volume = 1.2
  }
end
sounds.mined_sound = {
  filename = SNDPATH .. "deconstruct-bricks.ogg",
  volume = 1
}


------------------------------------------------------------------------------------
--                                  Wooden floor                                  --
------------------------------------------------------------------------------------
-- Dectorio ("Dectorio")
BI.additional_entities.BI_Trigger_Woodfloor.wood_floor = {
  type = "tile",
  name = "bi-wood-floor",
  needs_correction = false,
  --~ -- minable = {hardness = 0.2, mining_time = 0.5, result = "wood"},
  minable = {hardness = 0.2, mining_time = 0.25, result = "wood"},
  mined_sound = sounds.mined_sound,
  collision_mask = {"ground-tile"},
  walking_speed_modifier = 1.2,
  layer = 59,
  decorative_removal_probability = 0.6,
  variants = {
    main =
    {
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


    inner_corner =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_inner-corner.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_inner-corner.png",
        count = 1,
        scale = 0.5,
      }
    },
    inner_corner_mask =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_inner-corner-mask.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_inner-corner-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    outer_corner =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_outer-corner.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_outer-corner.png",
        count = 1,
        scale = 0.5,
      }
    },
    outer_corner_mask =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_outer-corner-mask.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_outer-corner-mask.png",
        count = 1,
        scale = 0.5,
      }
    },

    side =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_side.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_side.png",
        count = 1,
        scale = 0.5,
      }
    },
    side_mask =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_side-mask.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_side-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    u_transition =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_u.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_u.png",
        count = 1,
        scale = 0.5,
      }
    },
    u_transition_mask =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_u-mask.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_u-mask.png",
        count = 1,
        scale = 0.5,
      }
    },

    o_transition =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_o.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_o.png",
        count = 1,
        scale = 0.5,
      }
    },
    o_transition_mask =
    {
      picture = WOODPATH .. "wood_floor/woodfloor_o-mask.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor_o-mask.png",
        count = 1,
        scale = 0.5,
      }
    },
    material_background =
    {
      picture = WOODPATH .. "wood_floor/woodfloor.png",
      count = 1,
      hr_version =
      {
        picture = WOODPATH .. "wood_floor/hr_woodfloor.png",
        count = 1,
        scale = 0.5,
      }
    },
  },
  walking_sound = sounds.walking_sound,
  map_color = {r = 139, g = 115, b = 85},
  pollution_absorption_per_second = 0,
  vehicle_friction_modifier = 0.9,
}


-- Status report
BioInd.readdata_msg(BI.additional_entities, mod_compatibility,
                    "additional entities", "compatibility with other mods")

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
