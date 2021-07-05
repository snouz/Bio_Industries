------------------------------------------------------------------------------------
--                           Enable: Prototype Artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
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
local tech_effects, tech


------------------------------------------------------------------------------------
--                     Add research bonuses to the Bio cannon                     --
------------------------------------------------------------------------------------
turret = data.raw["ammo-turret"]["bi-bio-cannon"]
--~ if turrets[turret] then
if turret then
  map = {
    --Level             ammo-damage     gun-speed
      [5]          =      {0.9,           0.8},
      [6]          =      {1.3,           1.5},
      [7]          =      {1.0,              },
  }
  for level, bonus in ipairs(map) do
    ammo_damage, gun_speed = table.unpack(bonus)

    -- Ammo damage modifier
    if ammo_damage then
      table.insert(techs["physical-projectile-damage-" .. level].effects, {
        type = "ammo-damage", ammo_category = "Bio_Cannon_Ammo", modifier = ammo_damage
      })
      BioInd.modified_msg("ammo-damage bonus", turret)
    end

    -- Shooting speed modifier
    if gun_speed then
      table.insert(techs["weapon-shooting-speed-" .. level].effects, {
        type = "gun-speed", ammo_category = "Bio_Cannon_Ammo", modifier = gun_speed
      })
      BioInd.modified_msg("shooting-speed bonus", turret)
    end
  end

  -- Artillery shell speed
  tech = techs["artillery-shell-speed-1"]
  --~ table.insert(data.raw.technology["artillery-shell-speed-1"].effects, {
  table.insert(tech.effects, {
    type = "gun-speed",
    ammo_category = "Bio_Cannon_Ammo",
    modifier = 1
  })
  --~ BioInd.modified_msg("shooting-speed bonus", turret)
  BioInd.modified_msg(turret.name, tech, "Added")
end

--~ ------------------------------------------------------------------------------------
--~ --                     Add research bonuses to the Bio cannon                     --
--~ ------------------------------------------------------------------------------------
--~ local map = {
  --~ ["physical-projectile-damage"] = {
    --~ [5] = 0.9,
    --~ [6] = 1.3,
    --~ [7] = 1
  --~ },
  --~ ["artillery-shell-speed"] = {
    --~ [1] = 1,
  --~ },
  --~ ["weapon-shooting-speed"] = {
    --~ [5] = 0.8,
    --~ [6] = 1.5,
  --~ },
--~ }

--~ for tech_name, t_data in pairs(map) do
  --~ for level, modifier in pairs(t_data) do
    --~ tech = techs[tech_name .. "-" .. level]
    --~ if tech then
      --~ tech_effects = tech.effects

      --~ if tech_effects then
        --~ table.insert(tech_effects, {
          --~ type = (tech_name == "physical-projectile-damage" and "ammo-damage" or "gun-speed"),
          --~ ammo_category = "Bio_Cannon_Ammo",
          --~ modifier = modifier
        --~ })
        --~ BioInd.writeDebug("Biocannon ammo will be affected by %s", {tech.name})
      --~ else
        --~ tech_effects = {
          --~ type = (tech_name == "physical-projectile-damage" and "ammo-damage" or "gun-speed"),
          --~ ammo_category = "Bio_Cannon_Ammo",
          --~ modifier = modifier
        --~ }
        --~ BioInd.modified_msg("effects", tech, "Added")
      --~ end
    --~ end
  --~ end
--~ end


------------------------------------------------------------------------------------
--              Add prototype artillery to prerequisites of artillery             --
------------------------------------------------------------------------------------
tech = techs["artillery"]
--~ if tech and techs["bi-tech-bio-cannon-3"] then
if tech then
  thxbob.lib.tech.add_prerequisite(tech.name, "bi-tech-bio-cannon-3")
  BioInd.modified_msg("prerequisites", tech)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
