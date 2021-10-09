------------------------------------------------------------------------------------
--                           Assembler Pipe Passthrough                           --
------------------------------------------------------------------------------------
local mod_name = "assembler-pipe-passthrough"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Initialize table for registering entities
appmod = appmod or {}
appmod.blacklist = appmod.blacklist or {}

-- We need to blacklist these entities
local blacklist = {
  "bi-arboretum",
  "bi-bio-reactor",
  "bi-bio-garden-large",
  "bi-bio-garden-huge",
}

-- Add entities to blacklist
for e, entity in ipairs(blacklist or {}) do
  appmod.blacklist[entity] = true
  BioInd.debugging.writeDebug("Added %s to blacklist!", {entity})
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
