------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
local setting = "BI_Stone_Crushing"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end
local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.techiconpath

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
for t_name, tech in pairs(BI.optional_techs[setting] or {}) do
  data:extend({tech})
  BioInd.created_msg(tech)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
