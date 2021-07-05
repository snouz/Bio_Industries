------------------------------------------------------------------------------------
--                           Natural Evolution Buildings                          --
------------------------------------------------------------------------------------
local mod_name = "Natural_Evolution_Buildings"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local tech, recipe, turret, bonus, map
local techs = data.raw.technology
local recipes = data.raw.recipe
local turrets = data.raw["ammo-turret"]


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                  Tech bonuses                                  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- The bonuses will only be applied if the turrets exist. They won't exist if the
-- settings "Enable: Early wooden defenses" (Dart turret) or "Enable: Prototype
-- artillery" (Bio cannon) have been disabled.

--~ ------------------------------------------------------------------------------------
--~ --                                   Dart turret                                  --
--~ ------------------------------------------------------------------------------------
--~ local turret_attack, ammo_damage, gun_speed
--~ turret = "bi-dart-turret"

--~ if turrets[turret] then
  --~ map = {
    --~ --Level     turret-attack   ammo-damage     gun-speed
      --~ [1]          =      {0.1,           0.1,            0.1},
      --~ [2]          =      {0.1,           0.1,            0.2},
      --~ [3]          =      {0.2,           0.2,            0.2},
      --~ [4]          =      {0.2,           0.2,            0.2},
      --~ [5]          =      {0.2,           0.2,            0.2},
      --~ [6]          =      {0.4,           0.4,            0.4},
      --~ [7]          =      {0.7,           0.4,               },
  --~ }

  --~ for level, bonus in ipairs(map) do
    --~ turret_attack, ammo_damage, gun_speed = table.unpack(bonus)
--~ BioInd.writeDebug("turret_attack: %s\tammo_damage: %s\tgun_speed: %s", {
  --~ turret_attack, ammo_damage, gun_speed or "nil"
--~ })
    --~ -- Turret attack bonus
    --~ if turret_attack then
--~ BioInd.show("tech", techs["physical-projectile-damage-" .. level])
      --~ table.insert(techs["physical-projectile-damage-" .. level].effects, {
        --~ type = "turret-attack", turret_id = turret, modifier = turret_attack
      --~ })
      --~ BioInd.modified_msg("turret-attack bonus", turrets[turret])
    --~ end

    --~ -- Ammo damage modifier
    --~ if ammo_damage then
      --~ table.insert(techs["physical-projectile-damage-" .. level].effects, {
        --~ type = "ammo-damage", ammo_category = "Bio_Turret_Ammo", modifier = ammo_damage
      --~ })
      --~ BioInd.modified_msg("ammo-damage bonus", turrets[turret])
    --~ end

    --~ -- Shooting speed modifier
    --~ if gun_speed then
      --~ table.insert(techs["weapon-shooting-speed-" .. level].effects, {
        --~ type = "gun-speed", ammo_category = "Bio_Turret_Ammo", modifier = gun_speed
      --~ })
      --~ BioInd.modified_msg("shooting-speed bonus", turrets[turret])
    --~ end
  --~ end
  --~ -- Turret attack modifier
  --~ bonus = "turret-attack"
  --~ for level, modifier in pairs({
    --~ -- Keeping indices isn't really necessary here (and in the following), but should help
    --~ -- to avoid mistakes if this file is edited in the future.
    --~ [1] = {0.1,}
    --~ [2] = 0.1,
    --~ [3] = 0.2,
    --~ [4] = 0.2,
    --~ [5] = 0.2,
    --~ [6] = 0.4,
    --~ [7] = 0.7,
  --~ }) do
    --~ tech = techs["physical-projectile-damage-" .. level]
    --~ table.insert(tech.effects, {
      --~ type = bonus, turret_id = turret, modifier = modifier
    --~ })
    --~ BioInd.modified_msg("effects of " tech.name .. " (" .. turret .. ")", tech)
  --~ end

  --~ -- Ammo damage modifier
  --~ for index, modifier in pairs({
    --~ [1] = 0.1,
    --~ [2] = 0.1,
    --~ [3] = 0.2,
    --~ [4] = 0.2,
    --~ [5] = 0.2,
    --~ [6] = 0.4,
    --~ [7] = 0.4,
  --~ }) do
    --~ tech = techs["physical-projectile-damage-" .. index]
    --~ table.insert(techs["physical-projectile-damage-" .. index].effects, {
      --~ type = "ammo-damage",
      --~ ammo_category = "Bio_Turret_Ammo",
      --~ modifier = modifier
    --~ })
    --~ BioInd.modified_msg("effects (Bio cannon)", tech)
  --~ end

  --~ -- Shooting speed modifier
  --~ bonus = "gun-speed"
  --~ for level, modifier in pairs({
    --~ [1] = 0.1,
    --~ [2] = 0.2,
    --~ [3] = 0.2,
    --~ [4] = 0.2,
    --~ [5] = 0.2,
    --~ [6] = 0.4,
  --~ }) do
    --~ tech = techs["weapon-shooting-speed-" .. level]
    --~ table.insert(tech.effects, {
      --~ type = bonus, ammo_category = "Bio_Turret_Ammo", modifier = modifier
    --~ })
    --~ BioInd.modified_msg("effects (Bio cannon)", tech)
  --~ end
--~ end
--~ end

--~ ------------------------------------------------------------------------------------
--~ --                                   Bio Cannon                                   --
--~ ------------------------------------------------------------------------------------
--~ turret = "bi-bio-cannon"
--~ if turrets[turret] then
  --~ map = {
    --~ --Level             ammo-damage     gun-speed
      --~ [5]          =      {0.9,           0.8},
      --~ [6]          =      {1.3,           1.5},
      --~ [7]          =      {1.0,              },
  --~ }
  --~ for level, bonus in ipairs(map) do
    --~ ammo_damage, gun_speed = table.unpack(bonus)

    --~ -- Ammo damage modifier
    --~ if ammo_damage then
      --~ table.insert(techs["physical-projectile-damage-" .. level].effects, {
        --~ type = "ammo-damage", ammo_category = "Bio_Cannon_Ammo", modifier = ammo_damage
      --~ })
      --~ BioInd.modified_msg("ammo-damage bonus", turrets[turret])
    --~ end

    --~ -- Shooting speed modifier
    --~ if gun_speed then
      --~ table.insert(techs["weapon-shooting-speed-" .. level].effects, {
        --~ type = "gun-speed", ammo_category = "Bio_Cannon_Ammo", modifier = gun_speed
      --~ })
      --~ BioInd.modified_msg("shooting-speed bonus", turrets[turret])
    --~ end
  --~ end

  --~ -- Artillery shell speed
  --~ table.insert(data.raw.technology["artillery-shell-speed-1"].effects, {
    --~ type = "gun-speed",
    --~ ammo_category = "Bio_Cannon_Ammo",
    --~ modifier = 1
  --~ })
--~ end

--~ if turrets["bi-bio-cannon"] then

  --~ -- Shooting speed modifier
  --~ for index, modifier in pairs({
    --~ [1] = 0.1,
    --~ [2] = 0.2,
    --~ [3] = 0.2,
    --~ [4] = 0.2,
    --~ [5] = 0.2,
    --~ [6] = 0.4,
  --~ }) do
    --~ tech = techs["weapon-shooting-speed-" .. index]
    --~ table.insert(tech.effects, {
      --~ type = "gun-speed",
      --~ ammo_category = "Bio_Turret_Ammo",
      --~ modifier = modifier
    --~ })
    --~ BioInd.modified_msg("effects (Bio cannon)", tech)
  --~ end

  --~ -- Ammo damage modifier
  --~ for index, modifier in pairs({
    --~ [1] = 0.1,
    --~ [2] = 0.1,
    --~ [3] = 0.2,
    --~ [4] = 0.2,
    --~ [5] = 0.2,
    --~ [6] = 0.4,
    --~ [7] = 0.4,
  --~ }) do
    --~ tech = techs["physical-projectile-damage-" .. index]
    --~ table.insert(techs["physical-projectile-damage-" .. index].effects, {
      --~ type = "ammo-damage",
      --~ ammo_category = "Bio_Turret_Ammo",
      --~ modifier = modifier
    --~ })
    --~ BioInd.modified_msg("effects (Bio cannon)", tech)
  --~ end
--~ end

--~ ------------------------------------------------------------------------------------
--~ --              Add prototype artillery to prerequisites of artillery             --
--~ ------------------------------------------------------------------------------------
--~ tech = techs["artillery"]
--~ if tech and techs["bi-tech-bio-cannon-3"] then
  --~ thxbob.lib.tech.add_prerequisite(tech.name, "bi-tech-bio-cannon-3")
  --~ BioInd.modified_msg("prerequisites", tech)
--~ end

------------------------------------------------------------------------------------
--          Add Mk3 recipe for wood, using NE' Enhanced nutrient solution         --
------------------------------------------------------------------------------------
--~ recipe = recipes["bi-adv-fertilizer-1"]
recipe = recipes[BI.additional_recipes.adv_fertilizer_1.name]
if recipe then
  --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "bi-biomass")
  thxbob.lib.recipe.remove_ingredient(recipe.name, BI.default_fluids.biomass)
  thxbob.lib.recipe.remove_ingredient(recipe.name, "alien-artifact")
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "fluid",
    name = "NE_enhanced-nutrient-solution",
    amount = 50
  })
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
