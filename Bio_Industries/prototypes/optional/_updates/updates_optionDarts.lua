------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
local setting = "BI_Darts"
-- Don't duplicate what NE does!
if (not BI.Settings[setting]) or mods["Natural_Evolution_Buildings"] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local new_effects
local techs = data.raw.technology
local tech_effects


--~ ------------------------------------------------------------------------------------
--~ --                          Add bonuses for Dart turrets                          --
--~ ------------------------------------------------------------------------------------
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
local new_effects

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
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
