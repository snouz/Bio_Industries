------------------------------------------------------------------------------------
--                             Industrial Revolution 2                            --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  -- require("file") will return true unless the file returns a value ~= nil
  return {}
else
  BioInd.entered_file()
  BioInd.writeDebug("Reading patterns for %s", {mod_name})
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Dictionary of item.name and item.type
local blacklist_items = {
  --~ ["item"] = {
    --~ -- ["rubber-wood"] = true,
  --~ }
  --~ ["rubber-wood"] = "item",
}

local blacklist_patterns = {
  -- IR2
  "^atomic.*",
  ".+%-beam$",

  --~ "^bronze.*",
  --~ "^carbon.*",
  --~ "^chromium.*",
  --~ "^cupronickel.*",
  --~ "^diamond.*",
  --~ "^glass.*",
  --~ "^gold.*",
  --~ "^graphite.*",
  --~ "^gunpowder.*",
  --~ "^invar.*",
  --~ "^nickel.*",
  --~ "^lead.*",
  --~ "^plastiglass.*",
  --~ "^ruby.*",
  --~ "^sapphire.*",
  --~ "^silica.*",
  --~ "^silicon.*",
  --~ "^stainless.*",
  --~ "^tellurium.*",
  --~ "^tin.*",
  "^bronze%-.+",
  ".+%-bronze%-.+",
  ".+%-bronze$",
  "^carbon%-.+",
  ".+%-carbon%-.+",
  ".+%-carbon$",
  "^chromium%-.+",
  ".+%-chromium%-.+",
  ".+%-chromium$",
  "^cupronickel%-.+",
  ".+%-cupronickel%-.+",
  ".+%-cupronickel$",
  "^diamond%-.+",
  ".+%-diamond%-.+",
  ".+%-diamond$",
  "^glass%-.+",
  ".+%-glass%-.+",
  ".+%-glass$",
  "^gold%-.+",
  ".+%-gold%-.+",
  ".+%-gold$",
  "^graphite%-.+",
  ".+%-graphite%-.+",
  ".+%-graphite$",
  "^gunpowder%-.+",
  ".+%-gunpowder%-.+",
  ".+%-gunpowder$",
  "^invar%-.+",
  ".+%-invar%-.+",
  ".+%-invar$",
  "^nickel%-.+",
  ".+%-nickel%-.+",
  ".+%-nickel$",
  "^lead%-.+",
  ".+%-lead%-.+",
  ".+%-lead$",
  "^plastiglass%-.+",
  ".+%-plastiglass%-.+",
  ".+%-plastiglass$",
  "^ruby%-.+",
  ".+%-ruby%-.+",
  ".+%-ruby$",
  "^sapphire%-.+",
  ".+%-sapphire%-.+",
  ".+%-sapphire$",
  "^silica%-.+",
  ".+%-silica%-.+",
  ".+%-silica$",
  "^silicon%-.+",
  ".+%-silicon%-.+",
  ".+%-silicon$",
  "^stainless%-.+",
  ".+%-stainless%-.+",
  ".+%-stainless$",
  "^tellurium%-.+",
  ".+%-tellurium%-.+",
  ".+%-tellurium$",
  "^tin%-.+",
  ".+%-tin%-.+",
  ".+%-tin$",
}

--~ local whitelist_items = {
  --~ ["copper-beam"]           = "item",
  --~ ["wood-beam"]                     = "item",
--~ }
local whitelist_items = {
  ["copper-beam"]               = "item",
  ["wood-beam"]                 = "item",

  --~ ["item"] = {
    --~ ["copper-beam"],
    --~ ["wood-beam"]  ,
  --~ }
}

local whitelist_patterns = {}

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")

return {
  blacklist_items = blacklist_items or {},
  whitelist_items = whitelist_items or {},
  blacklist_patterns = blacklist_patterns or {},
  whitelist_patterns = whitelist_patterns or {},
}
