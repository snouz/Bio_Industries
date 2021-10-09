------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
local mod_name = "Krastorio2"
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
  --~ ["capsule"] = {
    --~ ["poop"]                      = true,

  --~ },

  --~ ["item"] = {
    --~ ["advanced-circuit"]          = true,
    --~ ["advanced-fuel"]             = true,
    --~ ["coke"]                      = true,
    --~ ["fuel"]                      = true,
    --~ ["glass"]                     = true,
    --~ ["inserter-parts"]            = true,
    --~ ["kr-quantum-computer"]       = true,
    --~ ["kr-research-server"]        = true,
    --~ ["pollution-filter"]          = true,
    --~ ["quartz"]                    = true,
    --~ ["silicon"]                   = true,
  --~ }
  ["poop"]                      = "capsule",
  ["advanced-circuit"]          = "item",
  ["advanced-fuel"]             = "item",
  ["coke"]                      = "item",
  ["fuel"]                      = "item",
  ["glass"]                     = "item",
  ["inserter-parts"]            = "item",
  ["kr-quantum-computer"]       = "item",
  ["kr-research-server"]        = "item",
  ["pollution-filter"]          = "item",
  ["quartz"]                    = "item",
  ["silicon"]                   = "item",
}



local blacklist_patterns = {
  ".*%-core$",
  ".*anti%-material.*",
  ".*dt%-fuel.*",
  ".*matter%-.+",
  ".*nuclear%-.+",
  ".*potato$",
  ".*rare%-metals$",
  ".*research%-data$",
  ".*tritium.*",
  ".+%-tech%-card$",
  "^advanced%-tank%-.+",
  "^big%-battery%-.+",
  "^energy%-.+",
  "^enriched%-.+",
  "^kr%-crash%-site%-.+",
  "^kr%-fluid%-.+",
  "^kr%-singularity%-.+",
  "^kr%-tesla.*",
  "^kr%-void.*",
  "^rock%-.+",
  "^tree%-%d+$",

  "^imersium%-.+",
  ".+%-imersium%-.+",
  ".+%-imersium$",
  "^imersite%-.+",
  ".+%-imersite%-.+",
  ".+%-imersite$",
  "^lithium%-.+",
  ".+%-lithium%-.+",
  ".+%-lithium$",
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
