------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
local setting = "BI_Darts"
-- Don't duplicate what NE does!
if (not BI.Settings[setting]) or mods["Natural_Evolution_Buildings"] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
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
BioInd.writeDebug("turret_attack: %s\tammo_damage: %s\tgun_speed: %s", {
  turret_attack, ammo_damage, gun_speed or "nil"
})
    -- Turret attack bonus
    if turret_attack then
BioInd.show("tech", techs["physical-projectile-damage-" .. level])
      table.insert(techs["physical-projectile-damage-" .. level].effects, {
        type = "turret-attack", turret_id = turret.name, modifier = turret_attack
      })
      BioInd.modified_msg("turret-attack bonus", turret)
    end

    -- Ammo damage modifier
    if ammo_damage then
      table.insert(techs["physical-projectile-damage-" .. level].effects, {
        type = "ammo-damage", ammo_category = "Bio_Turret_Ammo", modifier = ammo_damage
      })
      BioInd.modified_msg("ammo-damage bonus", turret)
    end

    -- Shooting speed modifier
    if gun_speed then
      table.insert(techs["weapon-shooting-speed-" .. level].effects, {
        type = "gun-speed", ammo_category = "Bio_Turret_Ammo", modifier = gun_speed
      })
      BioInd.modified_msg("shooting-speed bonus", turret)
    end
  end
end

------------------------------------------------------------------------------------
--                          Add bonuses for Dart turrets                          --
------------------------------------------------------------------------------------
--~ local map = {
  --~ ["physical-projectile-damage"] = {
    --~ [1] = 0.1,
    --~ [2] = 0.1,
    --~ [3] = 0.2,
    --~ [4] = 0.2,
  --~ },
  --~ ["weapon-shooting-speed"] = {
    --~ [1] = 0.1,
    --~ [2] = 0.2,
    --~ [3] = 0.2,
    --~ [4] = 0.3,
  --~ },
--~ }

--~ local tech_effects, t
--~ local techs = data.raw.technology

--~ for tech_name, t_data in pairs(map) do
  --~ for level, modifier in pairs(t_data) do
    --~ t = tech_name .. "-" .. level
    --~ tech_effects = techs[t] and techs[t].effects
    --~ if tech_effects then
      --  table.insert(data.raw.technology[tech_name .. "-" .. level].effects, {
      --~ table.insert(tech_effects, {
        --~ type = (tech_name == "weapon-shooting-speed") and "gun-speed" or "ammo-damage",
        --~ ammo_category = "Bio_Turret_Ammo",
        --~ modifier = modifier
      --~ })
      --  BioInd.writeDebug("Biocannon ammo will be affected by %s-%s", {tech_name, level})
      --~ BioInd.modified_msg(t, techs[t])
    --~ end
  --~ end
--~ end


------------------------------------------------------------------------------------
--                         Remove bonuses for Gun turrets                         --
------------------------------------------------------------------------------------
for level = 1, 3 do
  tech = techs["physical-projectile-damage-" .. level]
--~ BioInd.show("tech", tech)
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
      BioInd.modified_msg("turret-attack effect for gun-turret", tech, "Removed")
    end
  end
--~ BioInd.show("tech", tech)
end


------------------------------------------------------------------------------------
--                       Change prerequisites of some techs                       --
------------------------------------------------------------------------------------
--~ tech = techs["military"]
--~ if tech then
  --~ thxbob.lib.tech.add_prerequisite(tech.name, "bi-tech-darts-1")
  --~ BioInd.modified_msg("prerequisites", tech)
--~ end

--~ unlock = techs["military-2"]
--~ if unlock then
  --~ for tech_name, count in pairs({
    --~ ["stone-wall"] = 25,
    --~ ["gun-turret"] = 50,
local prerequisite_map = {
  ["military"] = "bi-tech-darts-1",
  ["stone-wall"] = "military-2",
  ["gun-turret"] = "military-2",

}
for tech, prerequisite in pairs(prerequisite_map) do
  thxbob.lib.tech.add_prerequisite(tech, prerequisite)
  BioInd.modified_msg("prerequisites", data.raw.technology[tech])
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

--~ local function new_unit(old, new)
  --~ BioInd.check_args(new, "table")
--~ BioInd.show("old", old)
--~ BioInd.show("new", new)

  --~ local ret = {}
  --~ local addit, old_pack, new_pack, old_amount, new_amount

  --~ if old then
    --~ ret.count = (not old.count or old.count < new.count) and new.count or old.count
    --~ ret.time = (not old.time or old.time < new.time) and new.time or old.time
    --~ ret.ingredients = {}

    --~ for n, new_i in ipairs(new.ingredients or {}) do
      --~ new_pack = new_i[1] or new_i.name
      --~ if not (new_pack and data.raw.tool[new_pack]) then
        --~ BioInd.arg_err(new_pack, "science pack")
      --~ end
      --~ new_amount = new_i[2] or new_i.amount or 1

      --~ addit = true
      --~ for o, old_i in ipairs(old.ingredients or {}) do
        --~ old_pack = old_i[1] or old_i.name
        --~ old_amount = old_i[2] or old_i.amount or 1

        --~ if old_pack == new_pack then
          --~ table.insert(ret.ingredients, {
            --~ name = old_pack,
            --~ amount = (old_amount < new_amount) and new_amount or old_amount
          --~ })
          --~ addit = false
          --~ BioInd.writeDebug("Keep existing ingredient: %s (new amount: %s)",
                            --~ {old_pack, ret.ingredients[#ret.ingredients].amount})
          --~ break
        --~ end
      --~ end

      --~ if addit then
        --~ table.insert(ret.ingredients, {
          --~ name = new_pack,
          --~ amount = new_amount
        --~ })
        --~ BioInd.writeDebug("Added new ingredient: %s (amount: %s)", {new_pack, new_amount})
      --~ end
    --~ end
  --~ else
    --~ ret = new
  --~ end

  --~ return ret
--~ end

--~ local test
for t_name, t_unit in pairs(map) do
  tech = techs[t_name]
BioInd.show("Modifying tech", t_name)
  if tech then
BioInd.show("tech", tech)
    --~ -- tech.unit = new_unit(tech.unit, t_unit)
    --~ test = new_unit(tech.unit, t_unit)
--~ BioInd.show("Returned unit", test)
    --~ tech.unit = test
    --~ BioInd.modified_msg("unit", tech)
    --~ tech.normal = tech.normal or {}
    -- tech.normal.unit = new_unit(tech.normal.unit, t_unit)
    --~ test = new_unit(tech.normal.unit, t_unit)
--~ BioInd.show("Returned unit", test)
    --~ tech.normal.unit = test
    --~ BioInd.modified_msg("normal.unit", tech)

    --~ tech.expensive = tech.expensive or {}
    -- tech.expensive.unit = new_unit(tech.expensive.unit, t_unit)
    --~ test = new_unit(tech.expensive.unit, t_unit)
--~ BioInd.show("Returned unit", test)
    --~ tech.expensive.unit = test
    --~ BioInd.modified_msg("expensive.unit", tech)

    thxbob.lib.tech.replace_unit(t_name, t_unit)
BioInd.show("Final tech", tech)
  end
end
------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
