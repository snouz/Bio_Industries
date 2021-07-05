-- Add functions that are also used in other files (debugging output etc.)
local BioInd = require("__" .. script.mod_name .. "__.common")(script.mod_name)
BioInd.entered_file()


------------------------------------------------------------------------------------
-- Just adjust the name of a global table to the new name of a setting!
------------------------------------------------------------------------------------

global = global or {}
global.mod_settings = global.mod_settings or {}
global.mod_settings.BI_Game_Tweaks_Easy_Bio_Gardens =
                          table.deepcopy(global.mod_settings.BI_Easy_Bio_Gardens)
global.mod_settings.BI_Easy_Bio_Gardens = nil
BioInd.writeDebug("Migrated \"%s\" to \"%s\".", {
  "global.mod_settings.BI_Easy_Bio_Gardens",
  "global.mod_settings.BI_Game_Tweaks_Easy_Bio_Gardens"
})
