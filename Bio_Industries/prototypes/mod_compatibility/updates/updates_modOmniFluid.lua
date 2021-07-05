------------------------------------------------------------------------------------
--                                    Omnifluid                                   --
------------------------------------------------------------------------------------
local mod_name = "omnimatter_fluid"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Omnifluid will be confused by our bi-solar-boiler (the compound boiler + solar
-- plant entity). Let's blacklist it if the mod is active!
forbidden_boilers["bi-solar-boiler"] = true
BioInd.writeDebug("Blacklisted \"bi-solar-boiler\" with Omnifluid!")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
