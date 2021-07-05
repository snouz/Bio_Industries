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


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- We only want to create our wooden-floor tile if Dectorio isn't active or it's own
-- wooden floor has been disabled!
if not BioInd.get_startup_setting("dectorio-wood") then
  --~ data:extend({BI.additional_entities.wood_floor})
  --~ BioInd.created_msg(BI.additional_entities.wood_floor)
  BioInd.create_stuff(BI.additional_entities.wood_floor)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
