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
    ammo_category = BI.additional_categories.Bio_Cannon.cannon_ammo.name,
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
    ammo_category = BI.additional_categories.Bio_Cannon.cannon_ammo.name,
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
BI.additional_entities[setting].bio_cannon_ammo_proto = {
  type = "projectile",
  name = "bi-bio-cannon-ammo-proto",
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
    filename = PROJECTILEPATH .. "bio_cannon_ammo_basic.png",
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
BI.additional_entities[setting].bio_cannon_ammo_basic = {
  type = "projectile",
  name = "bi-bio-cannon-ammo-basic",
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
    filename = PROJECTILEPATH .. "bio_cannon_ammo_basic.png",
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
BI.additional_entities[setting].bio_cannon_ammo_poison = {
  type = "projectile",
  name = "bi-bio-cannon-ammo-poison",
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
    {
      action_delivery = {
        target_effects = {
          {
            entity_name = "bi-poison-cloud",
            type = "create-entity"
          }
        },
        type = "instant"
      },
      type = "direct"
    },
  },
  light = {intensity = 0.8, size = 7},
  animation = {
    filename = PROJECTILEPATH .. "bio_cannon_ammo_poison.png",
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
  sound = sounds.explosion,
  slow_down_factor = 0,
  affected_by_wind = false,
  cyclic = false,
  duration = 60 * 5,
  spread_duration = 10,
}


-- Poison artillery shell
BI.additional_entities[setting].poison_artillery_shell = {
  name = "bi-poison-artillery-projectile",
  type = "artillery-projectile",
  picture = {
    draw_as_glow = true,
    filename = PROJECTILEPATH .. "hr-shell-poison.png",
    height = 64,
    scale = 0.5,
    width = 64
  },
  shadow = {
    filename = "__base__/graphics/entity/artillery-projectile/hr-shell-shadow.png",
    height = 64,
    scale = 0.5,
    width = 64
  },
  action = {
    {
      action_delivery = {
        target_effects = {
          {
            entity_name = "bi-poison-cloud",
            type = "create-entity"
          }
        },
        type = "instant"
      },
      type = "direct"
    },
    {
      action_delivery = {
        target_effects = {
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 500,
                      type = "physical"
                    },
                    type = "damage"
                  },
                  {
                    damage = {
                      amount = 500,
                      type = "explosion"
                    },
                    type = "damage"
                  },
                  {
                    damage = {
                      amount = 300,
                      type = "poison"
                    },
                    type = "damage"
                  }
                },
                type = "instant"
              },
              radius = 4,
              type = "area"
            },
            type = "nested-result"
          },
          {
            initial_height = 0,
            max_radius = 3.5,
            offset_deviation = { {-4, -4}, {4, 4} },
            repeat_count = 240,
            smoke_name = "artillery-smoke",
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.005,
            type = "create-trivial-smoke"
          },
          {
            entity_name = "big-artillery-explosion",
            type = "create-entity"
          },
          {
            scale = 0.25,
            type = "show-explosion-on-chart"
          }
        },
        type = "instant"
      },
      type = "direct"
    }
  },
  chart_picture = {
    filename = PROJECTILEPATH .. "poison-artillery-shoot-map-visualization.png",
    flags = {
      "icon"
    },
    frame_count = 1,
    height = 64,
    priority = "high",
    scale = 0.25,
    width = 64
  },
  final_action = {
    action_delivery = {
      target_effects = {
        {
          check_buildability = true,
          entity_name = "medium-scorchmark-tintable",
          type = "create-entity"
        },
        {
          repeat_count = 1,
          type = "invoke-tile-trigger"
        },
        {
          decoratives_with_trigger_only = false,
          from_render_layer = "decorative",
          include_decals = false,
          include_soft_decoratives = true,
          invoke_decorative_trigger = true,
          radius = 3.5,
          to_render_layer = "object",
          type = "destroy-decoratives"
        }
      },
      type = "instant"
    },
    type = "direct"
  },
  flags = {
    "not-on-map"
  },
  height_from_ground = 4.375,
  map_color = {b = 0, g = 1, r = 1},
  reveal_map = true,
}


-- Poison cloud
--~ local ingredients = BI.additional_recipes.Bio_Cannon.poison_artillery_shell.ingredients
--~ local multiplier = BI_Functions.lib.get_recipe_ingredients(ingredients)["poison-capsule"].amount

BI.additional_entities[setting].poison_cloud = {
  name = "bi-poison-cloud",
  type = "smoke-with-trigger",
  action = {
    action_delivery = {
      target_effects = {
        action = {
          action_delivery = {
            target_effects = {
              damage = {
                --~ amount = 8 * multiplier,
                amount = 8,
                type = "poison"
              },
              type = "damage"
            },
            type = "instant"
          },
          entity_flags = {
            "breaths-air"
          },
          radius = 11,
          type = "area"
        },
        type = "nested-result"
      },
      type = "instant"
    },
    type = "direct"
  },
  action_cooldown = 30,
  affected_by_wind = false,
  animation = {
    animation_speed = 0.25,
    filename = "__base__/graphics/entity/smoke/smoke.png",
    flags = {
      "smoke"
    },
    frame_count = 60,
    height = 120,
    line_length = 5,
    priority = "high",
    shift = {
      -0.53125,
      -0.4375
    },
    width = 152
  },
  color = {
    a = 0.68999999999999995,
    b = 0.99199999999999999,
    g = 0.875,
    r = 0.23899999999999997
  },
  created_effect = {
    {
      action_delivery = {
        target_effects = {
          {
            entity_name = "poison-cloud-visual-dummy",
            initial_height = 0,
            show_in_tooltip = false,
            type = "create-smoke"
          },
          {
            sound = {
              aggregation = {
                max_count = 1,
                remove = true
              },
              variations = {
                {
                  filename = "__base__/sound/fight/poison-capsule-explosion-1.ogg",
                  volume = 0.3
                }
              }
            },
            type = "play-sound"
          }
        },
        type = "instant"
      },
      cluster_count = 10,
      distance = 4,
      distance_deviation = 5,
      type = "cluster"
    },
    {
      action_delivery = {
        target_effects = {
          {
            entity_name = "poison-cloud-visual-dummy",
            initial_height = 0,
            show_in_tooltip = false,
            type = "create-smoke"
          }
        },
        type = "instant"
      },
      cluster_count = 11,
      distance = 8.8000000000000007,
      distance_deviation = 2,
      type = "cluster"
    }
  },
  cyclic = true,
  duration = 1200,
  fade_away_duration = 120,
  flags = {
    "not-on-map"
  },
  particle_count = 16,
  particle_distance_scale_factor = 0.5,
  particle_duration_variation = 180,
  particle_scale_factor = {
    1,
    0.70699999999999994
  },
  particle_spread = {
    3.7800000000000002,
    2.2680000000000002
  },
  render_layer = "object",
  show_when_smoke_off = true,
  spread_duration = 20,
  spread_duration_variation = 20,
  wave_distance = {
    0.3,
    0.2
  },
  wave_speed = {
    0.0125,
    0.016666666666666665
  }
}


------------------------------------------------------------------------------------
--                          Create entities and remnants                          --
------------------------------------------------------------------------------------
for e, e_data in pairs(BI.additional_entities[setting] or {}) do
  -- Don't create the Poison artillery shell yet -- other mods may have created one!
  if e_data.name ~= BI.additional_entities[setting].poison_artillery_shell.name and
      e_data.name ~= BI.additional_entities[setting].poison_cloud and
  -- Don't create the Napalm projectile -- this will be done by NE!
      e_data.name ~= BI.additional_entities[setting].ne_napalm_small then
  --~ if e_data.name ~= BI.additional_entities[setting].poison_artillery_shell.name then
    BioInd.create_stuff(e_data)

    -- Remnants, if they exist
    BioInd.make_remnants_for_entity(BI.additional_remnants[setting], e_data)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
