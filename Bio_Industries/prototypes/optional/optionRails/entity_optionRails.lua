------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
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
local SNDPATH = "__base__/sound/"
local CNCTRPATH = BioInd.entitypath .. "rail_power_connector/"

local sound_def = require("__base__.prototypes.entity.sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = {}

sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
sounds.generic_impact = sound_def.generic_impact

for _, sound in ipairs(sounds.generic_impact) do
  sound.volume = 0.65
end

sounds.walking_sound = {}
for i = 1, 11 do
  sounds.walking_sound[i] = {
    filename = SNDPATH .. "walking/concrete-" .. (i < 10 and "0" or "")  .. i ..".ogg",
    volume = 1.2
  }
end


------------------------------------------------------------------------------------
--                                      Flags                                     --
------------------------------------------------------------------------------------
local RAIL_FLAGS = {
  "placeable-neutral",
  "player-creation",
  "building-direction-8-way",
  "fast-replaceable-no-cross-type-while-moving"
}


------------------------------------------------------------------------------------
--                                 Define entities                                --
------------------------------------------------------------------------------------
-- Straight wooden rails
BI.additional_entities[setting].straight_rail_wood = {
  type = "straight-rail",
  name = "bi-straight-rail-wood",
  localised_name = {"entity-name.bi-rail-wood"},
  localised_description = {"entity-description.bi-rail-wood"},
  icon = ICONPATH .. "entity/rail-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = RAIL_FLAGS,
  --~ collision_mask = {"object-layer"},
  --~ collision_mask = BioInd.RAIL_MASK,
  minable = {mining_time = 0.25, result = "bi-rail-wood"},
  max_health = 60,
  corpse = "straight-rail-wood-remnants",
  resistances = {
    {
      type = "fire",
      percent = 80
    },
    {
      type = "acid",
      percent = 60
    }
  },
  collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
  selection_box = {{-0.7, -0.8}, {0.7, 0.8}},
  rail_category = "regular",
  --fast_replaceable_group = "rail",
  --next_upgrade = "straight-rail",
  pictures = BI_rail_pictures(),
}

-- Curved wooden rails
BI.additional_entities[setting].curved_rail_wood = {
  type = "curved-rail",
  name = "bi-curved-rail-wood",
  localised_name = {"entity-name.bi-rail-wood"},
  localised_description = {"entity-description.bi-rail-wood"},
  icon = ICONPATH .. "entity/rail-wood-curved.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = RAIL_FLAGS,
  --~ collision_mask = {"object-layer"},
  --~ collision_mask = BioInd.RAIL_MASK,
  minable = {mining_time = 0.25, result = "bi-rail-wood", count = 4},
  max_health = 120,
  corpse = "curved-rail-wood-remnants",
  resistances = {
    {
      type = "fire",
      percent = 80
    },
    {
      type = "acid",
      percent = 60
    }
  },
  collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
  secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
  selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
  rail_category = "regular",
  pictures = BI_rail_pictures(),
  placeable_by = { item = "bi-rail-wood", count = 4}
}

-- Straight wooden rail bridge
BI.additional_entities[setting].straight_rail_wood_bridge = {
  type = "straight-rail",
  name = "bi-straight-rail-wood-bridge",
  localised_name = {"entity-name.bi-rail-wood-bridge"},
  localised_description = {"entity-description.bi-rail-wood-bridge"},
  icon = ICONPATH .. "entity/rail-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {
    "placeable-neutral",
    "player-creation",
    "building-direction-8-way"
  },
  --~ collision_mask = {"object-layer"},
--~ collision_mask = { "item-layer", "object-layer"},
  --~ collision_mask = {"ground-tile", "floor-layer", "object-layer", "consider-tile-transitions"},
  --~ collision_mask = BioInd.RAIL_BRIDGE_MASK,
  minable = {mining_time = 0.5, result = "bi-rail-wood-bridge"},
  max_health = 60,
  corpse = "straight-rail-wood-bridge-remnants",
  collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
  selection_box = {{-0.7, -0.8}, {0.7, 0.8}},
  rail_category = "regular",
  pictures = BI_rail_pictures(),
}

-- Curved wooden rail bridge
BI.additional_entities[setting].curved_rail_wood_bridge = {
  type = "curved-rail",
  name = "bi-curved-rail-wood-bridge",
  localised_name = {"entity-name.bi-rail-wood-bridge"},
  localised_description = {"entity-description.bi-rail-wood-bridge"},
  icon = ICONPATH .. "entity/rail-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {
    "placeable-neutral",
    "player-creation",
    "building-direction-8-way"
  },
  --~ collision_mask = {"object-layer"},
--~ collision_mask = { "floor-layer", "item-layer", "object-layer"},
  --~ collision_mask = {"ground-tile", "floor-layer", "object-layer", "consider-tile-transitions"},
  --~ collision_mask = BioInd.RAIL_BRIDGE_MASK,
  minable = {mining_time = 0.5, result = "bi-rail-wood-bridge", count = 4},
  max_health = 120,
  corpse = "curved-rail-wood-bridge-remnants",
  collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
  secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
  selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
  rail_category = "regular",
  pictures = BI_rail_pictures(),
  placeable_by = { item = "bi-rail-wood-bridge", count = 4}
}

-- Power straight Rail
BI.additional_entities[setting].straight_rail_power = {
  type = "straight-rail",
  name = "bi-straight-rail-power",
  localised_name = {"entity-name.bi-rail-power"},
  localised_description = {"entity-description.bi-rail-power"},
  icon = ICONPATH .. "entity/rail-concrete-power.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {
    "placeable-neutral",
    "player-creation",
    "building-direction-8-way"
  },
  --~ collision_mask = {"object-layer"},
  --~ collision_mask = BioInd.RAIL_MASK,
  minable = {mining_time = 0.5, result = "bi-rail-power"},
  max_health = 60,
  corpse = "straight-rail-remnants",
  collision_box = {{-0.7, -0.8}, {0.7, 0.8}},
  selection_box = {{-0.7, -0.8}, {0.7, 0.8}},
  rail_category = "regular",
  pictures = BI_rail_pictures(),
}

-- Power curved Rail
BI.additional_entities[setting].curved_rail_power = {
  type = "curved-rail",
  name = "bi-curved-rail-power",
  localised_name = {"entity-name.bi-rail-power"},
  localised_description = {"entity-description.bi-rail-power"},
  icon = ICONPATH .. "entity/rail-concrete-power.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {
    "placeable-neutral",
    "player-creation",
    "building-direction-8-way",
  },
  --~ collision_mask = {"object-layer"},
  --~ collision_mask = BioInd.RAIL_MASK,
  minable = {mining_time = 0.5, result = "bi-rail-power", count = 4},
  max_health = 120,
  corpse = "curved-rail-remnants",
  collision_box = {{-0.75, -0.55}, {0.75, 1.6}},
  secondary_collision_box = {{-0.65, -2.43}, {0.65, 2.43}},
  selection_box = {{-1.7, -0.8}, {1.7, 0.8}},
  rail_category = "regular",
  pictures = BI_rail_pictures(),
  placeable_by = { item = "bi-rail-power", count = 4}
}

-- Power to Rail Pole
BI.additional_entities[setting].power_to_rail_pole = {
  type = "electric-pole",
  name = "bi-power-to-rail-pole",
  icon = ICONPATH .. "entity/rail_power_connector.png",
  icon_size = 64,
  BI_add_icon = true,
  icon_mipmaps = 4,
  flags = {"placeable-neutral", "player-creation", "fast-replaceable-no-build-while-moving"},
  minable = {mining_time = 1, result = "bi-power-to-rail-pole"},
  max_health = 100,
  corpse = "medium-electric-pole-remnants",
  dying_explosion = "medium-electric-pole-explosion",
  track_coverage_during_build_by_moving = true,
  fast_replaceable_group = "electric-pole",
  resistances = {
    {
      type = "fire",
      percent = 100
    }
  },
  collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  damaged_trigger_effect = hit_effects.entity({{-0.2, -2.2},{0.2, 0.2}}),
  drawing_box = {{-0.5, -2.8}, {0.5, 0.5}},
  maximum_wire_distance = BioInd.POWER_TO_RAIL_WIRE_DISTANCE,
  supply_area_distance = 3.5,
  vehicle_impact_sound = sound_def.generic_impact,
  open_sound = sound_def.electric_network_open,
  close_sound = sound_def.electric_network_close,
  pictures = {
    layers = {
      {
        filename = CNCTRPATH .. "rail_power_connector.png",
        priority = "extra-high",
        width = 42,
        height = 45,
        direction_count = 1,
        shift = util.by_pixel(0, -5),
        hr_version =
        {
          filename = CNCTRPATH .. "hr_rail_power_connector.png",
          priority = "extra-high",
          width = 84,
          height = 90,
          direction_count = 1,
          shift = util.by_pixel(0, -5),
          scale = 0.5
        }
      },
      {
        filename = CNCTRPATH .. "rail_power_connector_shadow.png",
        priority = "extra-high",
        width = 42,
        height = 45,
        direction_count = 1,
        shift = util.by_pixel(8, -5),
        draw_as_shadow = true,
        hr_version =
        {
          filename = CNCTRPATH .. "hr_rail_power_connector_shadow.png",
          priority = "extra-high",
          width = 84,
          height = 90,
          direction_count = 1,
          shift = util.by_pixel(8, -5),
          draw_as_shadow = true,
          scale = 0.5
        }
      }
    }
  },
  connection_points = {
    {
      shadow = {
        copper = util.by_pixel_hr(40, 7),
        red = util.by_pixel_hr(10.5, 27),
        green = util.by_pixel_hr(10.5, 27),
      },
      wire = {
        copper = util.by_pixel_hr(8, -39),
        red = util.by_pixel_hr(0, 7),
        green = util.by_pixel_hr(0, 7),
      }
    },
  },
  radius_visualisation_picture = {
    filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
    width = 12,
    height = 12,
    priority = "extra-high-no-scale"
  },
  water_reflection = {
    pictures = {
      filename = "__base__/graphics/entity/medium-electric-pole/medium-electric-pole-reflection.png",
      priority = "extra-high",
      width = 12,
      height = 28,
      shift = util.by_pixel(0, 55),
      variation_count = 1,
      scale = 5
    },
    rotate = false,
    orientation_to_variation = false
  }
}






--[[

table.deepcopy(
                                    data.raw["electric-pole"]["medium-electric-pole"])

local pole = BI.additional_entities[setting].power_to_rail_pole
pole.name = "bi-power-to-rail-pole"
pole.icon = ICONPATH .. "entity/rail_power_connector.png"
pole.icon_size = 64
pole.BI_add_icon = true
pole.icon_mipmaps = 3
pole.minable = {mining_time = 1, result = "bi-power-to-rail-pole"}
pole.maximum_wire_distance = BioInd.POWER_TO_RAIL_WIRE_DISTANCE
--~ pole.pictures.tint = {r = 183/255, g = 125/255, b = 62/255, a = 1}
pole.pictures.layers[1].hr_version.tint = {r = 0.9, g = 0.87, b = 0.23, a = 1}
pole.pictures.layers[1].tint = {r = 0.9, g = 0.87, b = 0.23, a = 0.5}

]]--

------------------------------------------------------------------------------------
--                          Create entities and remnants                          --
------------------------------------------------------------------------------------
--~ for e, e_data in pairs(BI.additional_entities[setting] or {}) do
  -- Entity
  --~ data:extend({e_data})
  --~ BioInd.created_msg(e_data)
  --~ BioInd.create_stuff(e_data)

  -- Remnants, if they exist
  --~ BioInd.make_remnants_for_entity(BI.additional_remnants[setting], e_data)
--~ end

  -- The name patterns of the rail remnants don't match the pattern expected in
  -- make_remnants_for_entity, so we create the remnants this way:
BioInd.create_stuff(BI.additional_entities[setting])
BioInd.create_stuff(BI.additional_remnants[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
