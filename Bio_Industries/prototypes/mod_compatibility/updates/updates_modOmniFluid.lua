------------------------------------------------------------------------------------
--                                    Omnifluid                                   --
------------------------------------------------------------------------------------
local mod_name = "omnimatter_fluid"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Omnifluid will be confused by our bi-solar-boiler (the compound boiler + solar
-- plant entity). Let's blacklist it if the mod is active!
forbidden_boilers["bi-solar-boiler"] = true
BioInd.debugging.writeDebug("Blacklisted \"bi-solar-boiler\" with Omnifluid!")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
