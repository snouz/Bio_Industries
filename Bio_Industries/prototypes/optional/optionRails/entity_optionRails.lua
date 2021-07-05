------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

BI.additional_entities = BI.additional_entities or {}
BI.additional_entities[setting] = BI.additional_entities[setting] or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local SNDPATH = "__base__/sound/"

local sound_def = require("__base__.prototypes.entity.sounds")
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
  pictures = rail_pictures(),
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
  pictures = rail_pictures(),
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
  pictures = rail_pictures(),
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
  pictures = rail_pictures(),
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
  pictures = rail_pictures(),
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
  pictures = rail_pictures(),
  placeable_by = { item = "bi-rail-power", count = 4}
}

-- Power to Rail Pole
BI.additional_entities[setting].power_to_rail_pole = table.deepcopy(
                                    data.raw["electric-pole"]["medium-electric-pole"])

local pole = BI.additional_entities[setting].power_to_rail_pole
pole.name = "bi-power-to-rail-pole"
pole.icon = ICONPATH .. "entity/rail-concrete-power-pole.png"
pole.icon_size = 64
pole.BI_add_icon = true
pole.icon_mipmaps = 3
pole.minable = {mining_time = 1, result = "bi-power-to-rail-pole"}
pole.maximum_wire_distance = BioInd.POWER_TO_RAIL_WIRE_DISTANCE
--~ pole.pictures.tint = {r = 183/255, g = 125/255, b = 62/255, a = 1}
pole.pictures.layers[1].hr_version.tint = {r = 0.9, g = 0.87, b = 0.23, a = 1}
pole.pictures.layers[1].tint = {r = 0.9, g = 0.87, b = 0.23, a = 0.5}



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
BI.entered_file("leave")
