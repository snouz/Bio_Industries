------------------------------------------------------------------------------------
--                                   5Dim's mods                                  --
--  (The core mod is required by all others, so we just need to check for that!)  --
------------------------------------------------------------------------------------
local mod_name = "5dim_core"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return {}
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Dictionary of item.name and item.type
local blacklist_items = {}

local blacklist_patterns = {
  "^5d%-.*pumpjack%-%d+",
  "^5d%-.+%-electric%-pole%-%d+",
  "^5d%-.+%-wagon%-%d+",
  "^5d%-.+equipment%-%d+",
  "^5d%-accumulator%-%d+",
  "^5d%-assembling%-machine%-%d+",
  "^5d%-beacon%-%d+",
  "^5d%-boiler%-%d+",
  "^5d%-centrifuge%-%d+",
  "^5d%-chemical%-plant%-%d+",
  "^5d%-construction%-robot%-%d+",
  "^5d%-electric%-.+",
  "^5d%-exoskeleton%-equipment%-%d+",
  "^5d%-flamethrower%-turret%-%d+",
  "^5d%-gate%-%d+",
  "^5d%-gun%-turret%-.+",
  "^5d%-heat%-exchanger%-%d+",
  "^5d%-industrial%-furnace",
  "^5d%-lab%-%d+",
  "^5d%-lamp%-%d+",
  "^5d%-laser%-turret%-.d+",
  "^5d%-locomotive%-%d+",
  "^5d%-logistic%-.+",
  "^5d%-masher%-%d+",
  "^5d%-nuclear%-reactor%-%d+",
  "^5d%-offshore%-pump%-%d+",
  "^5d%-oil%-refinery%-%d+",
  "^5d%-pump.+",
  "^5d%-radar%-%d+",
  "^5d%-roboport%-%d+",
  "^5d%-solar%-.+",
  "^5d%-steam%-.+",
  "^5d%-stone%-wall%-%d+",
  "^5d%-storage%-.+",
  "^5d%-substation%-%d+",
  "^5d%-tesla%-turret%-%d+",
}

local whitelist_items = {}

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
