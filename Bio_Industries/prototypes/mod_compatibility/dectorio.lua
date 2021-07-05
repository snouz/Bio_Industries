------------------------------------------------------------------------------------
--                                    Dectorio                                    --
------------------------------------------------------------------------------------
local mod_name = "Dectorio"
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

-- We only want to create our wooden-floor tile if Dectorio isn't active or it's own
-- wooden floor has been disabled!
--~ if not (BI.check_mods(mod_name) and BI.get_settings("dectorio-wood")) then
if not BI.get_settings("dectorio-wood") then
  --~ require('prototypes.mod_compatibility.additional_entities')

  data:extend({BI.additional_entities.wood_floor})
  --~ BioInd.writeDebug("Created tile \"%s\"!", {BI.additional_entities.wood_floor.name})
  BioInd.created_msg(BI.additional_entities.wood_floor)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
