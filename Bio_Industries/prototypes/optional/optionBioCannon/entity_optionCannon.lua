------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
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
local PROJECTILEPATH = BioInd.entitypath .. "bio_cannon/projectiles/"

local sound_def = require("__base__.prototypes.entity.sounds")
local sounds = {}

sounds.explosion = {
  { filename = BioInd.soundpath .. "boom.ogg", volume = 4.0 },
}
sounds.launch = {
  { filename = BioInd.soundpath .. "launch.ogg", volume = 4.0 },
}
--~ sounds.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
--~ sounds.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
sounds.open_sound = sound_def.artillery_open
sounds.close_sound = sound_def.artillery_close

local NE_Damage = mods["Natural_Evolution_Enemies"] and 2 or 1


------------------------------------------------------------------------------------
--                              Bio cannon animations                             --
------------------------------------------------------------------------------------
function preparing_animation()
return {
  layers = {
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 12,
      line_length = 6,
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_anim.png",
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 12,
        line_length = 6,
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_anim.png",
      }
    },
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      repeat_count = 12,
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_shadow.png",
      draw_as_shadow = true,
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        repeat_count = 12,
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_shadow.png",
        draw_as_shadow = true,
      }
    },
    {
      width = 160,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      repeat_count = 12,
      scale = 1,
      shift = {6.5, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_open_shadow.png",
      draw_as_shadow = true,
      hr_version = {
        width = 320,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        repeat_count = 12,
        scale = 0.5,
        shift = {6.5, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_open_shadow.png",
        draw_as_shadow = true,
      }
    }
  }
}
end

function prepared_animation()
return {
  layers = {
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_open.png",
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_open.png",
      }
    },
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_shadow.png",
      draw_as_shadow = true,
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        repeat_count = 1,
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_shadow.png",
        draw_as_shadow = true,
      }
    },
    {
      width = 160,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      scale = 1,
      shift = {6.5, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_open_shadow.png",
      draw_as_shadow = true,
      hr_version = {
        width = 320,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        repeat_count = 1,
        scale = 0.5,
        shift = {6.5, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_open_shadow.png",
        draw_as_shadow = true,
      }
    }
  }
}
end


function folding_animation()
return {
  layers = {
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 12,
      line_length = 6,
      run_mode = "backward",
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_anim.png",
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 12,
        line_length = 6,
        run_mode = "backward",
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_anim.png",
      }
    },
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      repeat_count = 12,
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_shadow.png",
      draw_as_shadow = true,
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        repeat_count = 12,
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_shadow.png",
        draw_as_shadow = true,
      }
    }
  }
}
end

function folded_animation()
return {
  layers = {
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_anim.png",
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_anim.png",
      }
    },
    {
      width = 346,
      height = 336,
      direction_count = 1,
      frame_count = 1,
      line_length = 1,
      scale = 1,
      shift = {0, -0.75},
      filename = ENTITYPATH .. "bio_cannon/bio_cannon_shadow.png",
      draw_as_shadow = true,
      hr_version = {
        width = 692,
        height = 672,
        direction_count = 1,
        frame_count = 1,
        line_length = 1,
        repeat_count = 1,
        scale = 0.5,
        shift = {0, -0.75},
        filename = ENTITYPATH .. "bio_cannon/hr_bio_cannon_shadow.png",
        draw_as_shadow = true,
      }
    }
  }
}
end


------------------------------------------------------------------------------------
--                                   Bio cannon                                   --
------------------------------------------------------------------------------------
-- Bio Cannon Artillery Range Overlay
BI.additional_entities[setting].bio_cannon_area = {
  type = "ammo-turret",
  name = "bi-bio-cannon-area",
  localised_name = {"entity-name.bi-bio-cannon"},
  localised_description = {"entity-description.bi-bio-cannon"},
  icon = ICONPATH .. "entity/biocannon_icon.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  --~ open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
  --~ close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  max_health = 900,
  corpse = "bi-bio-cannon-remnant",
  dying_explosion = "massive-explosion",
  automated_ammo_count = 10,
  resistances = {},
  collision_box = {{-4.25, -4.25}, {4.25, 4.25}},
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  order = "i[items][Bio_Cannon]",
  inventory_size = 1,
  attack_parameters = {
    type = "projectile",
    ammo_category = "Bio_Cannon_Ammo",
    cooldown = 2,
    range = 90,
    min_range = 20,
    projectile_creation_distance = 1.8,
    action ={}
  },
  folding_speed = 0.05,
  preparing_animation = preparing_animation(),
  prepared_animation = prepared_animation(),
  --attacking_animation = attacking_animation(),
  folding_animation = folding_animation(),
  folded_animation = folded_animation(),
  call_for_help_radius = 40,
  alert_icon_shift = {0, -0.5},
}

-- Bio Cannon Artillery
BI.additional_entities[setting].bio_cannon = {
  type = "ammo-turret",
  name = "bi-bio-cannon",
  icon = ICONPATH .. "entity/biocannon_icon.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  placeable_by = {item = "bi-bio-cannon-area", count = 1},-- makes cannon blueprintable
  --~ open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
  --~ close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  open_sound = sounds.open_sound,
  close_sound = sounds.close_sound,
  minable = {mining_time = 10, result = "bi-bio-cannon-area"},
  max_health = 900,
  corpse = "bi-bio-cannon-remnant",
  dying_explosion = "massive-explosion",
  automated_ammo_count = 10,
  resistances = {
    {
    type = "fire",
    percent = 90
    },
    {
    type = "explosion",
    percent = 30
    },
    {
    type = "impact",
    percent = 30
    }
  },
  collision_box = {{-4.20, -4.20}, {4.20, 4.20}},
  selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
  order = "i[items][Bio_Cannon]",
  inventory_size = 1,
  prepare_range = 90,
  preparing_speed = 0.012,
  attack_parameters = {
    type = "projectile",
    --~ ammo_category = "artillery-shell",
    ammo_category = "Bio_Cannon_Ammo",
    cooldown = 2,
    range = 0,
    projectile_creation_distance = 1.8,
    action ={}
  },
  folding_speed = 0.01,

  preparing_animation = preparing_animation(),
  prepared_animation = prepared_animation(),
  --attacking_animation = attacking_animation(),
  folding_animation = folding_animation(),
  folded_animation = folded_animation(),
  call_for_help_radius = 90,
  alert_icon_shift = {0, -0.5},
}


------------------------------------------------------------------------------------
--                                   Projectiles                                  --
------------------------------------------------------------------------------------
-- Prototype ammo
BI.additional_entities[setting].bio_cannon_proto_ammo = {
  type = "projectile",
  name = "bi-bio-cannon-proto-ammo",
  flags = {"not-on-map"},
  acceleration = 0.0004,
  action = {
    {
      type = "area",
      radius = 2,
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "damage",
            damage = {amount = 80 * NE_Damage, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          },
        }
      }
    },
  },
  light = {intensity = 0.7, size = 3},
  animation = {
    filename = PROJECTILEPATH .. "bio_cannon_basic_ammo.png",
    priority = "extra-high",
    width = 18,
    height = 47,
    scale = 0.85,
    frame_count = 1
  },
  shadow = {
    filename = PROJECTILEPATH .. "bio_cannon_ammo-shadow.png",
    priority = "extra-high",
    width = 18,
    height = 47,
    scale = 0.85,
    frame_count = 1
  },
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, 1},
      slow_down_factor = 1,
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed = 0,
      starting_frame_speed_deviation = 5
    }
  }
}


-- Basic ammo
BI.additional_entities[setting].bio_cannon_basic_ammo = {
  type = "projectile",
  name = "bi-bio-cannon-basic-ammo",
  flags = {"not-on-map"},
  acceleration = 0.0005,
  action = {
    {
      type = "area",
      radius = 8,
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "damage",
            damage = {amount = 120 * NE_Damage, type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 180 * NE_Damage, type = "explosion"}
          },
        }
      }
    },
    {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "nested-result",
            action = {
              type = "area",
              target_entities = false,
              repeat_count = 10,
              radius = 2,
              action_delivery = {
              type = "projectile",
              projectile = "NE-Napalm-Small",
              starting_speed = 0.5
              }
            }
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          },
          {
            type = "create-entity",
            entity_name = "bio-cannon-explosion",
          },
        }
      }
    },
  },
  light = {intensity = 0.7, size = 6},
  animation = {
    filename = PROJECTILEPATH .. "bio_cannon_basic_ammo.png",
    priority = "extra-high",
    width = 18,
    height = 47,
    frame_count = 1
  },
  shadow = {
    filename = PROJECTILEPATH .. "bio_cannon_ammo-shadow.png",
    priority = "extra-high",
    width = 18,
    height = 47,
    frame_count = 1
  },
  --[[
  sound = {
    {
      filename = "__Natural_Evolution_Buildings__/sound/launch.ogg",
      volume = 4.0
    },
  },
  ]]
  sound = sounds.launch,
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, 1},
      slow_down_factor = 1,
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed = 0,
      starting_frame_speed_deviation = 5
    }
  }
}


-- Poison ammo
BI.additional_entities[setting].bio_cannon_poison_ammo = {
  type = "projectile",
  name = "bi-bio-cannon-poison-ammo",
  flags = {"not-on-map"},
  acceleration = 0.0006,
  action = {
    {
      type = "area",
      radius = 12,
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "damage",
            damage = {amount = 120 * NE_Damage, type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 180 * NE_Damage, type = "explosion"}
          },
          {
            type = "damage",
            damage = {amount = 250 * NE_Damage, type = "poison"}
          },
        }
      }
    },
    {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "nested-result",
            action = {
              type = "area",
              target_entities = false,
              repeat_count = 20,
              radius = 3,
              action_delivery = {
              type = "projectile",
              projectile = "NE-Napalm-Small",
              starting_speed = 0.5
              }
            }
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          },
          {
            type = "create-entity",
            entity_name = "bio-cannon-explosion",
          },
        }
      }
    },
  },
  light = {intensity = 0.8, size = 7},
  animation = {
    filename = PROJECTILEPATH .. "bio_cannon_poison_ammo.png",
    priority = "extra-high",
    width = 18,
    height = 47,
    frame_count = 1
  },
  shadow = {
    filename = PROJECTILEPATH .. "bio_cannon_ammo-shadow.png",
    priority = "extra-high",
    width = 18,
    height = 47,
    frame_count = 1
  },
  --[[
  sound = {
    {
      filename = "__Natural_Evolution_Buildings__/sound/launch.ogg",
      volume = 4.0
    },
  },
  ]]
  sound = sounds.launch,
  smoke = {
    {
      name = "smoke-fast",
      deviation = {0.15, 0.15},
      frequency = 1,
      position = {0, 1},
      slow_down_factor = 1,
      starting_frame = 3,
      starting_frame_deviation = 5,
      starting_frame_speed = 0,
      starting_frame_speed_deviation = 5
    }
  }
}


-- Napalm Small
BI.additional_entities[setting].ne_napalm_small = {
  type = "projectile",
  name = "NE-Napalm-Small",
  flags = {"not-on-map"},
  acceleration = 0,
  action = {
    {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "create-entity",
            entity_name = "fire-flame"
          },
        }
      }
    },
  },
  animation = {
    filename = "__core__/graphics/empty.png",
    frame_count = 1,
    width = 1,
    height = 1,
    priority = "high"
  },
  shadow = {
    filename = "__core__/graphics/empty.png",
    frame_count = 1,
    width = 1,
    height = 1,
    priority = "high"
  }
}


--- Bio Cannon Explosion
BI.additional_entities[setting].bio_cannon_explosion = {
  type = "smoke-with-trigger",
  name = "bio-cannon-explosion",
  flags = {"not-on-map"},
  show_when_smoke_off = true,
  animation = {
    filename = PROJECTILEPATH .. "explosion.png",
    priority = "low",
    width = 256,
    height = 128,
    frame_count = 12,
    animation_speed = 0.2,
    line_length = 3,
    scale = 2,
  },
  --~ sound = {
    --~ {
      --~ filename = BioInd.soundpath .. "boom.ogg",
      --~ volume = 4.0
    --~ },
  --~ },
  sound = sounds.explosion,
  slow_down_factor = 0,
  affected_by_wind = false,
  cyclic = false,
  duration = 60 * 5,
  spread_duration = 10,
}


-- Poison artillery shell
BI.additional_entities[setting].poison_artillery_shell = table.deepcopy(
                              data.raw["artillery-projectile"]["artillery-projectile"])
local poison_shell = BI.additional_entities[setting].poison_artillery_shell
if poison_shell then
  poison_shell.name = "bi-poison-artillery-projectile"
  poison_shell.picture.filename = PROJECTILEPATH .. "hr-shell-poison.png"
  poison_shell.chart_picture.filename = PROJECTILEPATH .. "poison-artillery-shoot-map-visualization.png"

  if poison_shell.action and
      poison_shell.action.action_delivery and
      poison_shell.action.action_delivery.target_effects then

    local check, effect_index
    local poison_damage_amount = 300

check = true
    -- Really! This is a nested property.
    for e, effect in pairs(poison_shell.action.action_delivery.target_effects) do
      if effect.action and
          effect.action.action_delivery and
          effect.action.action_delivery.target_effects then
BioInd.writeDebug("Found target effects!")
        for t, target_effect in pairs(effect.action.action_delivery.target_effects) do
BioInd.writeDebug("t: %s\teffect: %s", {t, target_effect})
          if target_effect.damage and
              target_effect.damage.type == "poison" and
              target_effect.damage.amount < poison_damage_amount then
            target_effect.damage.amount = poison_damage_amount
            BioInd.modified_msg("damage.amount (poison)", poison_shell)
            check = false
            break
          end
        end
        if check then
          table.insert(effect.action.action_delivery.target_effects, {
            type = "damage",
            damage = {
              amount = poison_damage_amount,
              type = "poison"
            },
          })
          BioInd.modified_msg("poison damage", poison_shell, "Added")
        end

      end
    end

    --~ if check then
      --~ table.insert(poison_shell.action.action_delivery.target_effects[check].action.action_delivery.target_effects, {
        --~ type = "damage",
        --~ damage = {
          --~ amount = poison_damage_amount,
          --~ type = "poison"
        --~ },
      --~ })
      --~ BioInd.modified_msg("poison damage", poison_shell, "Added")
    --~ end
  end
end


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
