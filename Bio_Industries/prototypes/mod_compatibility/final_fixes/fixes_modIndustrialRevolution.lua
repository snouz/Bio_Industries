------------------------------------------------------------------------------------
--                             Industrial Revolution 2                            --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ local recipe, item, entity

--~ local items = data.raw.item
--~ local recipes = data.raw.recipe
local techs = data.raw.technology
local tech


------------------------------------------------------------------------------------
--                         Remove redundant prerequisites                         --
------------------------------------------------------------------------------------
-- These prerequisites have become redundant because after shuffling techs around,
-- they are already required by techs that are prerequisites of the moved techs.
local map = {
  -- Technology prerequisite 'tank' on 'artillery' is redundant as 'military-4' already contains it in its prerequisite tree.
  ["artillery"] = {"tank"},

  -- Technology prerequisite 'electric-energy-distribution-2' on 'bi-tech-electric-energy-super-accumulators' is redundant as 'electric-energy-accumulators' already contains it in its prerequisite tree.
  ["bi-tech-electric-energy-super-accumulators"] = {"electric-energy-distribution-2"},

  -- Technology prerequisite 'logistics' on 'bi-tech-wooden-storage-1' is redundant as 'bi-tech-timber' already contains it in its prerequisite tree.
  ["bi-tech-wooden-storage-1"] = {"logistics"},

  -- Technology prerequisite 'ir2-electronics-1' on 'gate' is redundant as 'stone-wall' already contains it in its prerequisite tree.
  -- Technology prerequisite 'ir2-iron-motor' on 'gate' is redundant as 'stone-wall' already contains it in its prerequisite tree.
  ["gate"] = {"ir2-electronics-1", "ir2-iron-motor"},

  -- Technology prerequisite 'ir2-iron-motor' on 'gun-turret' is redundant as 'military-2' already contains it in its prerequisite tree.
  -- Technology prerequisite 'military' on 'gun-turret' is redundant as 'military-2' already contains it in its prerequisite tree.
  ["gun-turret"] = {"ir2-iron-motor", "military"},

  -- Technology prerequisite 'ir2-steel-milestone' on 'ir2-steel-wall' is redundant as 'stone-wall' already contains it in its prerequisite tree.
  ["ir2-steel-wall"] = {"ir2-steel-milestone"},

  -- Technology prerequisite 'logistics-2' on 'logistics-3' is redundant as 'production-science-pack' already contains it in its prerequisite tree.
  ["logistics-3"] = {"logistics-2"},
}
for tech_name, prerequisites in pairs(map) do
  tech = techs[tech_name]
  if tech then
    for p, prerequisite in ipairs(prerequisites) do
      thxbob.lib.tech.remove_prerequisite(tech.name, prerequisite)
      BioInd.modified_msg("prerequisite " .. prerequisite, tech, "Removed")
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
