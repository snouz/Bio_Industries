------------------------------------------------------------------------------------
--                                    Dectorio                                    --
------------------------------------------------------------------------------------
local mod_name = "Dectorio"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- We only want to create our wooden-floor tile if Dectorio isn't active or it's own
-- wooden floor has been disabled!
if not BioInd.get_startup_setting("dectorio-wood") then
  BioInd.create_stuff(BI.additional_entities.mod_compatibility.wood_floor)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
