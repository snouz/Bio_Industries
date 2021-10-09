------------------------------------------------------------------------------------
--                                     BioTech                                    --
------------------------------------------------------------------------------------
local mod_name = "BioTech"
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
  ["biotech-big-wooden-pole"]                   = "item",
  ["biotech-chlorophyll"]                       = "item",
  ["biotech-diamond-substrate"]                 = "item",
  ["biotech-fuel-cell"]                         = "item",
  ["biotech-glass"]                             = "item",
  ["biotech-sand"]                              = "item",
  ["biotech-silica"]                            = "item",
  ["biotech-synthetic-wood"]                    = "item",
  ["biotech-tempered-glass"]                    = "item",
}

local blacklist_patterns = {
  "^biotech%-neural%-.+$",
  "^biotech%-silica%-.+$",
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
