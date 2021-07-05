------------------------------------------------------------------------------------
--                                    Omnifluid                                   --
------------------------------------------------------------------------------------
local mod_name = "omnimatter_fluid"
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


-- Omnifluid will be confused by our bi-solar-boiler (the compound boiler + solar
-- plant entity). Let's blacklist it if the mod is active!
forbidden_boilers["bi-solar-boiler"] = true
BioInd.writeDebug("Blacklisted \"bi-solar-boiler\" with Omnifluid!")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
