------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
local setting = "BI_Darts"
--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])

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
local WOODPATH = BioInd.entitypath .. "wood_products/"

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
--                               Auxiliary function                               --
------------------------------------------------------------------------------------
function turret_pic(inputs)
  return {
    layers = {
      {
        filename = ENTITYPATH .. "bio_turret/bio_turret.png",
        priority = "medium",
        scale = 1,
        width = 112,
        height = 80,
        direction_count = inputs.direction_count and inputs.direction_count or 64,
        frame_count = 1,
        line_length = inputs.line_length and inputs.line_length or 8,
        axially_symmetrical = false,
        run_mode = inputs.run_mode and inputs.run_mode or "forward",
        shift = { 0.25, -0.25 },
        hr_version = {
          filename = ENTITYPATH .. "bio_turret/hr_bio_turret.png",
          priority = "medium",
          scale = 0.5,
          width = 224,
          height = 160,
          direction_count = inputs.direction_count and inputs.direction_count or 64,
          frame_count = 1,
          line_length = inputs.line_length and inputs.line_length or 8,
          axially_symmetrical = false,
          run_mode = inputs.run_mode and inputs.run_mode or "forward",
          shift = { 0.25, -0.25 },
        },
      }
    }
  }
end



------------------------------------------------------------------------------------
--                                      Darts                                     --
------------------------------------------------------------------------------------
--- Basic Dart
BI.additional_entities[setting].dart_magazine_basic = {
  type = "ammo",
  name = "bi-dart-magazine-basic",
  icon = ICONPATH .. "weapon/dart_1_basic.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  ammo_type = {
    category = "Bio_Turret_Ammo",
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "create-explosion",
          entity_name = "explosion-gunshot",
        },
        target_effects = {
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          },
          {
            type = "damage",
            damage = { amount = 3 , type = "physical"}
          },
        }
      }
    }
  },
  magazine_size = 10,
  subgroup = "ammo",
  order = "[aaa]-a[basic-clips]-aa[firearm-magazine]",
  stack_size = 400
}

--- Standard Dart
BI.additional_entities[setting].dart_magazine_standard = {
  type = "ammo",
  name = "bi-dart-magazine-standard",
  icon = ICONPATH .. "weapon/dart_2_standard.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  ammo_type = {
    category = "Bio_Turret_Ammo",
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "create-explosion",
          entity_name = "explosion-gunshot",
        },
        target_effects = {
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          },
          {
            type = "damage",
            damage = { amount = 3 , type = "physical"}
          },
          {
            type = "damage",
            damage = { amount = 2 , type = "bob-pierce"}
          },
        }
      }
    }
  },
  magazine_size = 10,
  subgroup = "ammo",
  order = "[aab]-a[basic-clips]-ab[firearm-magazine]",
  stack_size = 400
}


--- Enhanced Dart
BI.additional_entities[setting].dart_magazine_enhanced = {
  type = "ammo",
  name = "bi-dart-magazine-enhanced",
  icon = ICONPATH .. "weapon/dart_3_enhanced.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  ammo_type = {
    category = "Bio_Turret_Ammo",
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "create-explosion",
          entity_name = "explosion-gunshot",
        },
        target_effects = {
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          },
          {
            type = "damage",
            damage = { amount = 3 , type = "physical"}
          },
          {
            type = "damage",
            damage = { amount = 2 , type = "bob-pierce"}
          },
          {
            type = "damage",
            damage = { amount = 2 , type = "acid"}
          },
        }
      }
    }
  },
  magazine_size = 10,
  subgroup = "ammo",
  order = "[aac]-a[basic-clips]-ac[firearm-magazine]",
  stack_size = 400
}


--- Poison Dart
BI.additional_entities[setting].dart_magazine_poison = {
  type = "ammo",
  name = "bi-dart-magazine-poison",
  icon = ICONPATH .. "weapon/dart_4_poison.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  ammo_type = {
    category = "Bio_Turret_Ammo",
    action = {
    type = "direct",
    action_delivery = {
        type = "instant",
        source_effects = {
          type = "create-explosion",
          entity_name = "explosion-gunshot",
        },
        target_effects = {
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          },
          {
            type = "damage",
            damage = { amount = 3 , type = "physical"}
          },
          {
            type = "damage",
            damage = { amount = 2 , type = "bob-pierce"}
          },
          {
            type = "damage",
            damage = { amount = 2 , type = "acid"}
          },
          {
            type = "damage",
            damage = { amount = 2 , type = "poison"}
          },
        }
      }
    }
  },
  magazine_size = 10,
  subgroup = "ammo",
  order = "[aad]-a[basic-clips]-ad[firearm-magazine]",
  stack_size = 400
}



------------------------------------------------------------------------------------
--                                   Dart turret                                  --
------------------------------------------------------------------------------------
BI.additional_entities[setting].dart_turret = {
  type = "ammo-turret",
  name = "bi-dart-turret",
  icon = ICONPATH .. "entity/dart_turret.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-player", "player-creation"},
  minable = {mining_time = 0.25, result = "bi-dart-turret"},
  max_health = 300,
  corpse = "bi-dart-turret-remnant",
  collision_box = {{-0.2, -0.2 }, {0.2, 0.2}},
  selection_box = {{-0.5, -0.5 }, {0.5, 0.5}},
  rotation_speed = 0.05,
  preparing_speed = 0.08,
  folding_speed = 0.08,
  dying_explosion = "medium-explosion",
  inventory_size = 1,
  automated_ammo_count = 14,
  attacking_speed = 1, -- makes nothing, it's animation's parameter
  folded_animation = turret_pic{direction_count = 8, line_length = 1},
  preparing_animation = turret_pic{direction_count = 8, line_length = 1},
  prepared_animation = turret_pic{},
  attacking_animation = turret_pic{},
  folding_animation = turret_pic{direction_count = 8, line_length = 1, run_mode = "backward"},

  -- darkfrei: wood impact sound for woods!
  vehicle_impact_sound = sounds.car_wood_impact,
  attack_parameters = {
    type = "projectile",
    ammo_category = "Bio_Turret_Ammo",
    cooldown = 3.6,  -- cooldown = 6 -- darkfrei: means cooldown 6/60 sec or 10 shoots at second; = 60 is one shoot/sec
    projectile_creation_distance = 1.41,
    projectile_center = {-0.0625, 0.55},
    -- darkfrei: darts haven't shells :)
--[[      shell_particle = {
name = "shell-particle",
direction_deviation = 0.1,
speed = 0.15,
speed_deviation = 0.03,
center = {-0.0625, 0},
creation_distance = -1.925,
starting_frame_speed = 0.2,
starting_frame_speed_deviation = 0.1
    }, ]]
    range = 20,
    sound = {
      filename = BioInd.soundpath .. "dart-turret.ogg",
      volume = 0.85
    },
  },
  call_for_help_radius = 40
}


------------------------------------------------------------------------------------
--                                   Dart rifle                                   --
------------------------------------------------------------------------------------
BI.additional_entities[setting].dart_rifle = {
  type = "gun",
  name = "bi-dart-rifle",
  icon = ICONPATH .. "weapon/dart_rifle.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "gun",
  order = "a[basic-clips]-ab[submachine-gun]",
  attack_parameters = {
    type = "projectile",
    ammo_category = "Bio_Turret_Ammo",
    cooldown = 5,
    movement_slow_down_factor = 0.5,
    --shell_particle = {},
    projectile_creation_distance = 1.125,
    range = 17,
    sound = {
      filename = BioInd.soundpath .. "dart-turret.ogg",
      volume = 0.65
    },
  },
  stack_size = 5
}


------------------------------------------------------------------------------------
--                                   Wood fence                                   --
------------------------------------------------------------------------------------
-- Wood fence
BI.additional_entities[setting].wooden_fence = {
  type = "wall",
  name = "bi-wooden-fence",
  icon = ICONPATH .. "entity/wooden-fence.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  flags = {"placeable-neutral", "player-creation"},
  collision_box = {{-0.29, -0.09}, {0.29, 0.49}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  minable = {mining_time = 1, result = "bi-wooden-fence"},
  fast_replaceable_group = "wall",
  max_health = 150,
  repair_speed_modifier = 2,
  corpse = "bi-wooden-fence-remnant",
  repair_sound = { filename = SNDPATH .. "manual-repair-simple.ogg" },
  --~ vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
  vehicle_impact_sound = sounds.car_wood_impact,
  resistances = {
    {
      type = "physical",
      decrease = 2,
      percent = 15
    },
    {
      type = "fire",
      percent = -25
    },
    {
      type = "impact",
      decrease = 15,
      percent = 20
    }
  },
  pictures = {
    single = {
      layers = {
        {
          filename = WOODPATH .. "wood_fence/fence-single-1.png",
          priority = "extra-high",
          width = 14,
          height = 92,
          scale = 0.5,
          shift = {0, -0.15625}
        },
        {
          filename = WOODPATH .. "wood_fence/fence-single-shadow.png",
          priority = "extra-high",
          width = 76,
          height = 50,
          scale = 0.5,
          shift = {0.459375, 0.75},
          draw_as_shadow = true
        }
      }
    },
    straight_vertical = {
      {
        layers = {
          {
            filename = WOODPATH .. "wood_fence/fence-straight-vertical-1.png",
            priority = "extra-high",
            width = 14,
            height = 106,
            scale = 0.5,
            shift = {0, -0.15625}
          },
          {
            filename = WOODPATH .. "wood_fence/fence-straight-vertical-shadow.png",
            priority = "extra-high",
            width = 78,
            height = 132,
            scale = 0.5,
            shift = {0.490625, 1.425},
            draw_as_shadow = true
          }
        }
      },
      {
        layers = {
          {
            filename = WOODPATH .. "wood_fence/fence-straight-vertical-1.png",
            priority = "extra-high",
            width = 14,
            height = 106,
            scale = 0.5,
            shift = {0, -0.15625}
          },
          {
            filename = WOODPATH .. "wood_fence/fence-straight-vertical-shadow.png",
            priority = "extra-high",
            width = 78,
            height = 132,
            scale = 0.5,
            shift = {0.490625, 1.425},
            draw_as_shadow = true
          }
        }
      },
      {
        layers = {
          {
            filename = WOODPATH .. "wood_fence/fence-straight-vertical-1.png",
            priority = "extra-high",
            width = 14,
            height = 106,
            scale = 0.5,
            shift = {0, -0.15625}
          },
          {
            filename = WOODPATH .. "wood_fence/fence-straight-vertical-shadow.png",
            priority = "extra-high",
            width = 78,
            height = 132,
            scale = 0.5,
            shift = {0.490625, 1.425},
            draw_as_shadow = true
          }
        }
      }
    },
    straight_horizontal = {
      {
        layers = {
          {
            filename = WOODPATH .. "wood_fence/fence-straight-horizontal-1.png",
            priority = "extra-high",
            width = 68,
            height = 94,
            scale = 0.5,
            shift = {0, -0.15625}
          },
          {
            filename = WOODPATH .. "wood_fence/fence-straight-horizontal-shadow.png",
            priority = "extra-high",
            width = 168,
            height = 56,
            scale = 0.5,
            shift = {0.421875, 0.85},
            draw_as_shadow = true
          }
        }
      },
      {
        layers = {
          {
            filename = WOODPATH .. "wood_fence/fence-straight-horizontal-2.png",
            priority = "extra-high",
            width = 68,
            height = 94,
            scale = 0.5,
            shift = {0, -0.15625}
          },
          {
            filename = WOODPATH .. "wood_fence/fence-straight-horizontal-shadow.png",
            priority = "extra-high",
            width = 168,
            height = 56,
            scale = 0.5,
            shift = {0.421875, 0.85},
            draw_as_shadow = true
          }
        }
      },
      {
        layers = {
          {
            filename = WOODPATH .. "wood_fence/fence-straight-horizontal-3.png",
            priority = "extra-high",
            width = 68,
            height = 94,
            scale = 0.5,
            shift = {0, -0.15625}
          },
          {
            filename = WOODPATH .. "wood_fence/fence-straight-horizontal-shadow.png",
            priority = "extra-high",
            width = 168,
            height = 56,
            scale = 0.5,
            shift = {0.421875, 0.85},
            draw_as_shadow = true
          }
        }
      }
    },
    corner_right_down = {
      layers = {
        {
          filename = WOODPATH .. "wood_fence/fence-corner-right-down.png",
          priority = "extra-high",
          width = 46,
          height = 106,
          scale = 0.5,
          shift = {0.248125, -0.07625}
        },
        {
          filename = WOODPATH .. "wood_fence/fence-corner-right-down-shadow.png",
          priority = "extra-high",
          width = 104,
          height = 112,
          scale = 0.5,
          shift = {0.724375, 1.30625},
          draw_as_shadow = true
        }
      }
    },
    corner_left_down = {
      layers = {
        {
          filename = WOODPATH .. "wood_fence/fence-corner-left-down.png",
          priority = "extra-high",
          width = 42,
          height = 106,
          scale = 0.5,
          shift = {-0.248125, -0.07625}
        },
        {
          filename = WOODPATH .. "wood_fence/fence-corner-left-down-shadow.png",
          priority = "extra-high",
          width = 120,
          height = 112,
          scale = 0.5,
          shift = {0.128125, 1.30625},
          draw_as_shadow = true
        }
      }
    },
    t_up = {
      layers = {
        {
          filename = WOODPATH .. "wood_fence/fence-t-down.png",
          priority = "extra-high",
          width = 68,
          height = 106,
          scale = 0.5,
          shift = {0, -0.07625}
        },
        {
          filename = WOODPATH .. "wood_fence/fence-t-down-shadow.png",
          priority = "extra-high",
          width = 142,
          height = 110,
          scale = 0.5,
          shift = {0.286875, 1.280625},
          draw_as_shadow = true
        }
      }
    },
    ending_right = {
      layers = {
        {
          filename = WOODPATH .. "wood_fence/fence-ending-right.png",
          priority = "extra-high",
          width = 46,
          height = 94,
          scale = 0.5,
          shift = {0.248125, -0.15625}
        },
        {
          filename = WOODPATH .. "wood_fence/fence-ending-right-shadow.png",
          priority = "extra-high",
          width = 98,
          height = 54,
          scale = 0.5,
          shift = {0.684375, 0.85},
          draw_as_shadow = true
        }
      }
    },
    ending_left = {
      layers = {
        {
          filename = WOODPATH .. "wood_fence/fence-ending-left.png",
          priority = "extra-high",
          width = 42,
          height = 94,
          scale = 0.5,
          shift = {-0.248125, -0.15625}
        },
        {
          filename = WOODPATH .. "wood_fence/fence-ending-left-shadow.png",
          priority = "extra-high",
          width = 126,
          height = 54,
          scale = 0.5,
          shift = {0.128125, 0.85},
          draw_as_shadow = true
        }
      }
    }
  }
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
