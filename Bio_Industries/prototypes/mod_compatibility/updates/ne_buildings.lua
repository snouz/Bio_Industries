------------------------------------------------------------------------------------
--                           Natural Evolution Buildings                          --
------------------------------------------------------------------------------------
local mod_name = "Natural_Evolution_Buildings"
-- Don't duplicate what NE does!
if BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath
local tech, recipe
local techs = data.raw.technology
local recipes = data.raw.recipe
local turrets = data.raw["ammo-turret"]


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                  Tech bonuses                                  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- The bonuses will only be applied if the turrets exist. They won't exist if the
-- settings "Enable: Early wooden defenses" (Dart turret) or "Enable: Prototype
-- artillery" (Bio cannon) have been disabled.

------------------------------------------------------------------------------------
--                                   Dart turret                                  --
------------------------------------------------------------------------------------
-- Turret attack modifier
if turrets["bi-dart-turret"] then
  for index, modifier in pairs({
    -- Keeping indices isn't really necessary here (and in the following), but should help
    -- to avoid mistakes if this file is edited in the future.
    [1] = 0.1,
    [2] = 0.1,
    [3] = 0.2,
    [4] = 0.2,
    [5] = 0.2,
    [6] = 0.4,
    [7] = 0.7,
  }) do
    tech = techs["physical-projectile-damage-" .. index]
    --~ table.insert(techs["physical-projectile-damage-" .. tostring(index)].effects, {
    table.insert(tech.effects, {
      type = "turret-attack",
      turret_id = "bi-dart-turret",
      modifier = modifier
    })
    BioInd.modified_msg("effects (dart turret)", tech)
  end
end

------------------------------------------------------------------------------------
-- Bio Cannon

-- Shooting speed modifier
if turrets["bi-bio-cannon-area"] then
  for index, modifier in pairs({
    [1] = 0.1,
    [2] = 0.2,
    [3] = 0.2,
    [4] = 0.2,
    [5] = 0.2,
    [6] = 0.4,
  }) do
    tech = techs["weapon-shooting-speed-" .. index]
    table.insert(tech.effects, {
      type = "gun-speed",
      ammo_category = "Bio_Turret_Ammo",
      modifier = modifier
    })
    BioInd.modified_msg("effects (Bio cannon)", tech)
  end

  -- Ammo damage modifier
  for index, modifier in pairs({
    [1] = 0.1,
    [2] = 0.1,
    [3] = 0.2,
    [4] = 0.2,
    [5] = 0.2,
    [6] = 0.4,
    [7] = 0.4,
  }) do
    tech = techs["physical-projectile-damage-" .. index]
    table.insert(techs["physical-projectile-damage-" .. index].effects, {
      type = "ammo-damage",
      ammo_category = "Bio_Turret_Ammo",
      modifier = modifier
    })
    BioInd.modified_msg("effects (Bio cannon)", tech)
  end
end

------------------------------------------------------------------------------------
--              Add prototype artillery to prerequisites of artillery             --
------------------------------------------------------------------------------------
tech = techs["artillery"]
if tech then
  thxbob.lib.tech.add_prerequisite(tech.name, "bi-tech-bio-cannon")
  --~ BioInd.writeDebug("Changed prerequisites of tech \"%s\".", {tech.name})
  BioInd.modified_msg("prerequisites", tech)
end

------- Adds a Mk3 recipe for wood if you're playing with Natural Evolution Buildings
recipe = recipes["bi-adv-fertilizer-1"]
if recipe then
  thxbob.lib.recipe.remove_ingredient(recipe.name, "bi-biomass")
  thxbob.lib.recipe.remove_ingredient(recipe.name, "alien-artifact")
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "fluid",
    name = "NE_enhanced-nutrient-solution",
    amount = 50
  })
  --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
