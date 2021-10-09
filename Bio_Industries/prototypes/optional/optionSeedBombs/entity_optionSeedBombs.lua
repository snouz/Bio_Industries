------------------------------------------------------------------------------------
--                               Enable: Seed bombs                               --
--                       (BI.Settings.BI_Explosive_Planting)                      --
------------------------------------------------------------------------------------
local setting = "BI_Explosive_Planting"
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
-- Basic seed bomb
BI.additional_entities[setting].seed_bomb_projectile_1 = {
  type = "projectile",
  name = "seed-bomb-projectile-1",
  flags = {"not-on-map"},
  acceleration = 0.005,
  action = {
    type = "direct",
    action_delivery = {
      type = "instant",
      target_effects = {
        --~ {
          --~ type = "nested-result",
          --~ action = {
            --~ type = "area",
            --~ target_entities = false,
            --~ repeat_count = 600,
            --~ radius = 24,
            --~ action_delivery = {
              --~ type = "projectile",
              --~ projectile = "seed-bomb-wave-1",
              --~ starting_speed = 0.5
            --~ }
          --~ }
        --~ }
        --~ source_effects = {
          type = "script",
          effect_id = "BI_seedbomb_seedling",
        --~ },
      }
    }
  },
  light = {intensity = 0.8, size = 15},
  animation = {
    filename = "__base__/graphics/entity/rocket/rocket.png",
    frame_count = 8,
    line_length = 8,
    width = 9,
    height = 35,
    shift = {0, 0},
    priority = "high"
  },
  shadow = {
    filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
    frame_count = 1,
    width = 7,
    height = 24,
    priority = "high",
    shift = {0, 0}
  },
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, -1},
      slow_down_factor = 1,
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed = 0,
      starting_frame_speed_deviation = 5
    }
  }
}

-- Standard seed bomb
BI.additional_entities[setting].seed_bomb_projectile_2 = {
  type = "projectile",
  name = "seed-bomb-projectile-2",
  flags = {"not-on-map"},
  acceleration = 0.005,
  action = {
    type = "direct",
    action_delivery = {
      type = "instant",
      target_effects = {
        {
          --~ type = "nested-result",
          --~ action = {
            --~ type = "area",
            --~ target_entities = false,
            --~ repeat_count = 800,
            --~ radius = 27,
            --~ action_delivery = {
              --~ type = "projectile",
              --~ projectile = "seed-bomb-wave-2",
              --~ starting_speed = 0.5
            --~ }
          --~ }
          type = "script",
          effect_id = "BI_seedbomb_seedling-2",
        }
      }
    }
  },
  light = {intensity = 0.8, size = 15},
  animation = {
    filename = "__base__/graphics/entity/rocket/rocket.png",
    frame_count = 8,
    line_length = 8,
    width = 9,
    height = 35,
    shift = {0, 0},
    priority = "high"
  },
  shadow = {
    filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
    frame_count = 1,
    width = 7,
    height = 24,
    priority = "high",
    shift = {0, 0}
  },
  smoke = {
    {
       name = "smoke-fast",
       deviation = {0.15, 0.15},
       frequency = 1,
       position = {0, -1},
       slow_down_factor = 1,
       starting_frame = 3,
       starting_frame_deviation = 5,
       starting_frame_speed = 0,
       starting_frame_speed_deviation = 5
    }
  }
}

-- Advanced seed bomb
BI.additional_entities[setting].seed_bomb_projectile_3 = {
  type = "projectile",
  name = "seed-bomb-projectile-3",
  flags = {"not-on-map"},
  acceleration = 0.005,
  action = {
    type = "direct",
    action_delivery = {
      type = "instant",
      target_effects = {
        {
          --~ type = "nested-result",
          --~ action = {
            --~ type = "area",
            --~ target_entities = false,
            --~ repeat_count = 1000,
            --~ radius = 30,
            --~ action_delivery = {
              --~ type = "projectile",
              --~ projectile = "seed-bomb-wave-3",
              --~ starting_speed = 0.5
            --~ }
          --~ }
          type = "script",
          effect_id = "BI_seedbomb_seedling-3",
        }
      }
    }
  },
  light = {intensity = 0.8, size = 15},
  animation = {
    filename = "__base__/graphics/entity/rocket/rocket.png",
    frame_count = 8,
    line_length = 8,
    width = 9,
    height = 35,
    shift = {0, 0},
    priority = "high"
  },
  shadow = {
    filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
    frame_count = 1,
    width = 7,
    height = 24,
    priority = "high",
    shift = {0, 0}
  },
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, -1},
      slow_down_factor = 1,
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed = 0,
      starting_frame_speed_deviation = 5
    }
  }
}

--~ -- Basic seed bomb (wave)
--~ BI.additional_entities[setting].seed_bomb_wave_1 = {
  --~ type = "projectile",
  --~ name = "seed-bomb-wave-1",
  --~ flags = {"not-on-map"},
  --~ acceleration = 0,
  --~ action = {
    --~ {
      --~ type = "direct",
      --~ action_delivery = {
        --~ type = "instant",
        --~ target_effects = {
          --~ {
            --~ type = "create-entity",
            --~ entity_name = "seedling",
            --~ check_buildability = true,
            --~ trigger_created_entity = true,
          --~ }
        --~ }
      --~ }
    --~ },
  --~ },
  --~ animation = {
    --~ filename = "__core__/graphics/empty.png",
    --~ frame_count = 1,
    --~ width = 1,
    --~ height = 1,
    --~ priority = "high"
  --~ },
  --~ shadow = {
    --~ filename = "__core__/graphics/empty.png",
    --~ frame_count = 1,
    --~ width = 1,
    --~ height = 1,
    --~ priority = "high"
  --~ }
--~ }

--~ -- Standard seed bomb (wave)
--~ BI.additional_entities[setting].seed_bomb_wave_2 = {
  --~ type = "projectile",
  --~ name = "seed-bomb-wave-2",
  --~ flags = {"not-on-map"},
  --~ acceleration = 0,
  --~ action = {
    --~ {
      --~ type = "direct",
      --~ action_delivery = {
        --~ type = "instant",
        --~ target_effects = {
          --~ {
            --~ type = "create-entity",
            --~ entity_name = "seedling-2",
            --~ check_buildability = true,
            --~ trigger_created_entity = true,
          --~ }
        --~ }
      --~ }
    --~ },
  --~ },
  --~ animation = {
    --~ filename = "__core__/graphics/empty.png",
    --~ frame_count = 1,
    --~ width = 1,
    --~ height = 1,
    --~ priority = "high"
  --~ },
  --~ shadow = {
    --~ filename = "__core__/graphics/empty.png",
    --~ frame_count = 1,
    --~ width = 1,
    --~ height = 1,
    --~ priority = "high"
  --~ }
--~ }

--~ -- Advanced seed bomb (wave)
--~ BI.additional_entities[setting].seed_bomb_wave_3 = {
  --~ type = "projectile",
  --~ name = "seed-bomb-wave-3",
  --~ flags = {"not-on-map"},
  --~ acceleration = 0,
  --~ action = {
    --~ {
      --~ type = "direct",
      --~ action_delivery = {
        --~ type = "instant",
        --~ target_effects = {
          --~ {
            --~ type = "create-entity",
            --~ entity_name = "seedling-3",
            --~ check_buildability = true,
            --~ trigger_created_entity = true,
          --~ },
        --~ }
      --~ }
    --~ },
  --~ },
  --~ animation = {
    --~ filename = "__core__/graphics/empty.png",
    --~ frame_count = 1,
    --~ width = 1,
    --~ height = 1,
    --~ priority = "high"
  --~ },
  --~ shadow = {
    --~ filename = "__core__/graphics/empty.png",
    --~ frame_count = 1,
    --~ width = 1,
    --~ height = 1,
    --~ priority = "high"
  --~ }
--~ }


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
