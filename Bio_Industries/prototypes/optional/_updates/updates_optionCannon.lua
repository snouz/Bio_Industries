------------------------------------------------------------------------------------
--                           Enable: Prototype Artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
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
local tech_effects, tech
local ammos = data.raw.ammo
local addit


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
        type = "ammo-damage",
        ammo_category = BI.additional_categories.Bio_Cannon.cannon_ammo.name,
        modifier = ammo_damage
      })
      BioInd.debugging.modified_msg("ammo-damage bonus", turret)
    end

    -- Shooting speed modifier
    if gun_speed then
      table.insert(techs["weapon-shooting-speed-" .. level].effects, {
        type = "gun-speed",
        ammo_category = BI.additional_categories.Bio_Cannon.cannon_ammo.name,
        modifier = gun_speed
      })
      BioInd.debugging.modified_msg("shooting-speed bonus", turret)
    end
  end

  -- Artillery shell speed
  tech = techs["artillery-shell-speed-1"]
  --~ table.insert(data.raw.technology["artillery-shell-speed-1"].effects, {
  table.insert(tech.effects, {
    type = "gun-speed",
    ammo_category = BI.additional_categories.Bio_Cannon.cannon_ammo.name,
    modifier = 1
  })
  --~ BioInd.debugging.modified_msg("shooting-speed bonus", turret)
  BioInd.debugging.modified_msg(turret.name, tech, "Added")
end


------------------------------------------------------------------------------------
--              Add prototype artillery to prerequisites of artillery             --
------------------------------------------------------------------------------------
tech = techs["artillery"]
if tech then
  thxbob.lib.tech.add_prerequisite(tech.name, "bi-tech-bio-cannon-3")
  BioInd.debugging.modified_msg("prerequisites", tech)
end



------------------------------------------------------------------------------------
--                       Create the Poison artillery shell?                       --
------------------------------------------------------------------------------------
addit = true
for a, ammo in pairs(ammos) do
BioInd.debugging.show("Checking ammo", a)
  if a:match(".*poison%-artillery%-shell.*") then
    addit = false
BioInd.debugging.writeDebug("Found poison artillery shell: %s -- nothing to do!", {a})
    break
  end
end

if addit then
  -- Already created (also required by Prototype poison ammo)
  --~ BioInd.create_stuff(BI.additional_entities[setting].poison_cloud)
  BioInd.create_stuff(BI.additional_entities[setting].poison_artillery_shell)
  BioInd.create_stuff(BI.additional_items[setting].poison_artillery_shell)
  BioInd.create_stuff(BI.additional_recipes[setting].poison_artillery_shell)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
