BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
-- Just adjust the name of a global table to the new name of a setting!
------------------------------------------------------------------------------------

global = global or {}
global.mod_settings = global.mod_settings or {}
global.mod_settings.BI_Game_Tweaks_Easy_Bio_Gardens =
                          table.deepcopy(global.mod_settings.BI_Easy_Bio_Gardens)
global.mod_settings.BI_Easy_Bio_Gardens = nil
BioInd.debugging.writeDebug("Migrated \"%s\" to \"%s\".", {
  "global.mod_settings.BI_Easy_Bio_Gardens",
  "global.mod_settings.BI_Game_Tweaks_Easy_Bio_Gardens"
})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
