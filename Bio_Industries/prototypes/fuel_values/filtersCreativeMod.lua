------------------------------------------------------------------------------------
--                                  Creative Mod                                  --
------------------------------------------------------------------------------------
local mod_name = "creative-mod"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  -- require("file") will return true unless the file returns a value ~= nil
  return {}
else
  BioInd.debugging.entered_file()
  BioInd.debugging.writeDebug("Reading patterns for %s", {mod_name})
end



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Dictionary of item.name and item.type
local blacklist_items = {
  --~ ["advanced-circuit"] = "item",
}

local blacklist_patterns = {
  "^creative%-mod_.+",
}

local whitelist_items = {}

local whitelist_patterns = {}

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return {
  blacklist_items = blacklist_items or {},
  whitelist_items = whitelist_items or {},
  blacklist_patterns = blacklist_patterns or {},
  whitelist_patterns = whitelist_patterns or {},
}
