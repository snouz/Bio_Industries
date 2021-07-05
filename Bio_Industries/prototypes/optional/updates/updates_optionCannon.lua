------------------------------------------------------------------------------------
--                           Enable: Prototype Artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
-- Don't duplicate what NE does!
if (not BI.Settings[setting]) or mods["Natural_Evolution_Buildings"] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


local BioInd = require('common')('Bio_Industries')


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ if BI.Settings.Bio_Cannon and not mods["Natural_Evolution_Buildings"] then
  --~ table.insert(data.raw.technology["physical-projectile-damage-5"].effects, {
    --~ type = "ammo-damage",
    --~ ammo_category = "Bio_Cannon_Ammo",
    --~ modifier = 0.9
  --~ })
  --~ table.insert(data.raw.technology["physical-projectile-damage-6"].effects, {
    --~ type = "ammo-damage",
    --~ ammo_category = "Bio_Cannon_Ammo",
    --~ modifier = 1.3
  --~ })
  --~ table.insert(data.raw.technology["physical-projectile-damage-7"].effects, {
    --~ type = "ammo-damage",
    --~ ammo_category = "Bio_Cannon_Ammo",
    --~ modifier = 1
  --~ })

  --~ table.insert(data.raw.technology["artillery-shell-speed-1"].effects, {
    --~ type = "gun-speed",
    --~ ammo_category = "Bio_Cannon_Ammo",
    --~ modifier = 1
  --~ })

  --~ table.insert(data.raw.technology["weapon-shooting-speed-5"].effects, {
    --~ type = "gun-speed",
    --~ ammo_category = "Bio_Cannon_Ammo",
    --~ modifier = 0.8
  --~ })
  --~ table.insert(data.raw.technology["weapon-shooting-speed-6"].effects, {
    --~ type = "gun-speed",
    --~ ammo_category = "Bio_Cannon_Ammo",
    --~ modifier = 1.5
  --~ })
--~ end

local map = {
  ["physical-projectile-damage"] = {
    [5] = 0.9,
    [6] = 1.3,
    [7] = 1
  },
  ["artillery-shell-speed"] = {
    [1] = 1,
  },
  ["weapon-shooting-speed"] = {
    [5] = 0.8,
    [6] = 1.5,
  },
}

local tech_effects, t
local techs = data.raw.technology

for tech_name, t_data in pairs(map) do
  for level, modifier in pairs(t_data) do
    t = tech_name .. "-" .. level
    tech_effects = techs[t] and techs[t].effects
    --~ table.insert(data.raw.technology[tech_name .. "-" .. level].effects, {
    table.insert(tech_effects, {
      type = (tech_name == "physical-projectile-damage" and "ammo-damage" or "gun-speed"),
      ammo_category = "Bio_Cannon_Ammo",
      modifier = modifier
    })
    BioInd.writeDebug("Biocannon ammo will be affected by %s-%s", {tech_name, level})
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
