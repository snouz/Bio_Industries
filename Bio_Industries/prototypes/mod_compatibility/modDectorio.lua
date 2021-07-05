--~ ------------------------------------------------------------------------------------
--~ --                                    Dectorio                                    --
--~ ------------------------------------------------------------------------------------
--~ local mod_name = "Dectorio"
--~ if not BioInd.check_mods(mod_name) then
  --~ BioInd.nothing_to_do("*")
  --~ return
--~ else
  --~ BioInd.entered_file()
--~ end


--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------


--~ -- We only want to create our wooden-floor tile if Dectorio isn't active or if its
--~ -- own wooden floor has been disabled!
--~ BI.Triggers.BI_Trigger_Woodfloor = not BioInd.get_startup_setting("dectorio-wood")



--~ ------------------------------------------------------------------------------------
--~ --                                    END OF FILE                                 --
--~ ------------------------------------------------------------------------------------
--~ BioInd.entered_file("leave")
