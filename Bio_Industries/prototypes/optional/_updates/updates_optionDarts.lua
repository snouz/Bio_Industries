------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
local setting = "BI_Darts"
-- Don't duplicate what NE does!
if (not BI.Settings[setting]) or mods["Natural_Evolution_Buildings"] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local techs = data.raw.technology
local tech, tech_effects, new_effects, map
local turret, turret_attack, ammo_damage, gun_speed, unit


------------------------------------------------------------------------------------
--                          Add bonuses for Dart turrets                          --
------------------------------------------------------------------------------------
turret = data.raw["ammo-turret"]["bi-dart-turret"]

if turret then
  map = {
    --Level     turret-attack   ammo-damage     gun-speed
      [1]          =      {0.1,           0.1,            0.1},
      [2]          =      {0.1,           0.1,            0.2},
      [3]          =      {0.2,           0.2,            0.2},
      [4]          =      {0.2,           0.2,            0.2},
      [5]          =      {0.2,           0.2,            0.2},
      [6]          =      {0.4,           0.4,            0.4},
      [7]          =      {0.7,           0.4,               },
  }

  for level, bonus in ipairs(map) do
    turret_attack, ammo_damage, gun_speed = table.unpack(bonus)
BioInd.debugging.writeDebug("turret_attack: %s\tammo_damage: %s\tgun_speed: %s", {
  turret_attack, ammo_damage, gun_speed or "nil"
})
    -- Turret attack bonus
    if turret_attack then
BioInd.debugging.show("tech", techs["physical-projectile-damage-" .. level])
      table.insert(techs["physical-projectile-damage-" .. level].effects, {
        type = "turret-attack", turret_id = turret.name, modifier = turret_attack
      })
      BioInd.debugging.modified_msg("turret-attack bonus", turret)
    end

    -- Ammo damage modifier
    if ammo_damage then
      table.insert(techs["physical-projectile-damage-" .. level].effects, {
        type = "ammo-damage", ammo_category = "Bio_Turret_Ammo", modifier = ammo_damage
      })
      BioInd.debugging.modified_msg("ammo-damage bonus", turret)
    end

    -- Shooting speed modifier
    if gun_speed then
      table.insert(techs["weapon-shooting-speed-" .. level].effects, {
        type = "gun-speed", ammo_category = "Bio_Turret_Ammo", modifier = gun_speed
      })
      BioInd.debugging.modified_msg("shooting-speed bonus", turret)
    end
  end
end


------------------------------------------------------------------------------------
--                         Remove bonuses for Gun turrets                         --
------------------------------------------------------------------------------------
for level = 1, 3 do
  tech = techs["physical-projectile-damage-" .. level]
--~ BioInd.debugging.show("tech", tech)
  tech_effects = tech and tech.effects
  new_effects = {}

  if tech_effects then
    -- Make list without gun-turret effects
    for e, effect in ipairs(tech_effects or {}) do
      if not (effect.type == "turret-attack" and effect.turret_id == "gun-turret") then
        new_effects[#new_effects + 1] = effect
      end
    end

    -- Only overwrite effects if size of new list differs from that of the old one!
    if #new_effects < #tech_effects then
      tech.effects = new_effects
      BioInd.debugging.modified_msg("turret-attack effect for gun-turret", tech, "Removed")
    end
  end
--~ BioInd.debugging.show("tech", tech)
end


------------------------------------------------------------------------------------
--                       Change prerequisites of some techs                       --
------------------------------------------------------------------------------------
local prerequisite_map = {
  ["military"] = "bi-tech-darts-1",
  ["stone-wall"] = "military-2",
  ["gun-turret"] = "military-2",

}
for tech, prerequisite in pairs(prerequisite_map) do
  thxbob.lib.tech.add_prerequisite(tech, prerequisite)
  BioInd.debugging.modified_msg("prerequisites", data.raw.technology[tech])

thxbob.lib.tech.remove_prerequisite(prerequisite, tech)
  BioInd.debugging.modified_msg("prerequisites", data.raw.technology[prerequisite])
end


------------------------------------------------------------------------------------
--                       Adjust research costs of some techs                      --
------------------------------------------------------------------------------------
map = {
  -- Military
  ["military"] = { count = 120, time = 30, ingredients = {
      {"automation-science-pack", 1},
    },
  },
  ["weapon-shooting-speed-1"] = { count = 150, time = 30, ingredients = {
      {"automation-science-pack", 1},
    },
  },
  ["physical-projectile-damage-1"] = { count = 150, time = 30, ingredients = {
      {"automation-science-pack", 1},
    },
  },
  ["heavy-armor"] = { count = 150, time = 30, ingredients = {
      {"automation-science-pack", 1},
    },
  },
  ["modular-armor"] = { count = 150, time = 30, ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
  },
  -- Military 2
  ["military-2"] = { count = 175, time = 30, ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
  },
  ["stronger-explosives-1"] = { count = 200, time = 30, ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
  },
  ["gun-turret"] = { count = 200, time = 30, ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
  },
  ["stone-wall"] = { count = 200, time = 30, ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
  },
  ["gate"] = { count = 225, time = 30, ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
  },
  -- Military science pack
  ["military-science-pack"] = { count = 236, time = 30, ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
  },
}

for t_name, t_unit in pairs(map) do
  tech = techs[t_name]
BioInd.debugging.show("Modifying tech", t_name)
  if tech then
    thxbob.lib.tech.replace_unit(t_name, t_unit)
BioInd.debugging.show("Final tech", tech)
  end
end
------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
