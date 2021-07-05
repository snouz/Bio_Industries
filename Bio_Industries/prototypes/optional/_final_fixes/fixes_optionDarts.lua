------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
local setting = "BI_Darts"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local techs = data.raw.technology
local tech, unlock


------------------------------------------------------------------------------------
--  There should be an incentive to use wooden fences and dart turrets, so let's  --
--  move stone walls and gun turrets behind "Military 2"!                         --
------------------------------------------------------------------------------------
unlock = techs["military-2"]
if unlock then
  for tech_name, count in pairs({
    ["stone-wall"] = 25,
    ["gun-turret"] = 50,
  }) do

    tech = techs[tech_name]
    if tech then

      -- Lock techs behind "Military 2"
      tech.prerequisites = tech.prerequisites or {}
BioInd.show("tech", tech)
      table.insert(tech.prerequisites, unlock.name)
      BioInd.modified_msg("unlock", tech, "Added")

      -- Change research unit ingredients of technologies
      tech.unit = {
        count = count,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
        },
        time = 15
      }
      BioInd.modified_msg("research unit ingredients", tech)

    end
  end
end


------------------------------------------------------------------------------------
--                          Remove obsolete prerequisites                         --
------------------------------------------------------------------------------------
local map = {
  -- "Technology prerequisite 'military-2' on 'gate' is redundant as 'stone-wall'
  -- already contains it in its prerequisite tree."
  ["gate"]                      = "military-2",
  -- "Technology prerequisite 'military-2' on 'military-science-pack' is redundant as 'stone-wall' already contains it in its prerequisite tree."
  ["military-science-pack"]     = "military-2",
}
for tech_name, prerequisite in pairs(map) do
  tech = techs[tech_name]
  if tech then
    thxbob.lib.tech.remove_prerequisite(tech_name, prerequisite)
    BioInd.modified_msg("prerequisite", tech, "Removed")
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
