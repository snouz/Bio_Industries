------------------------------------------------------------------------------------
--                           Assembler Pipe Passthrough                           --
------------------------------------------------------------------------------------
local mod_name = "assembler-pipe-passthrough"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Initialize table for registering entities
appmod = appmod or {}
appmod.blacklist = appmod.blacklist or {}

-- We need to blacklist these entities
local blacklist = {
  "bi-bio-reactor",
  "bi-bio-garden-large",
  "bi-bio-garden-huge",
}

-- Add entities to blacklist
for e, entity in ipairs(blacklist or {}) do
  appmod.blacklist[entity] = true
  BioInd.writeDebug("Added %s to blacklist!", {entity})
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
