BioInd.debugging.entered_file()

local ICONPATH = BioInd.iconpath
local REMNANTPATH = BioInd.entitypath .. "remnants/"


BI.additional_remnants = BI.additional_remnants or {}
BI.additional_remnants.mod_compatibility = BI.additional_remnants.mod_compatibility or {}

------------------------------------------------------------------------------------
--                                     Remnants                                   --
------------------------------------------------------------------------------------


-- Status report
BioInd.debugging.readdata_msg(BI.additional_remnants, mod_compatibility,
                    "additional remnants", "compatibility with other mods")

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
