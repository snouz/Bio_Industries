------------------------------------------------------------------------------------
--                                  Food Industry                                 --
------------------------------------------------------------------------------------
local mod_name = "FoodIndustry"
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
  -- Food stuff


  ["apple"]                             = "capsule",
  ["baked-potato"]                      = "capsule",
  ["best-salad"]                        = "capsule",
  ["biter-meat"]                        = "capsule",
  ["biter-steak"]                       = "capsule",
  ["bone"]                              = "item",
  ["bread"]                             = "capsule",
  ["burger"]                            = "capsule",
  ["cattle"]                            = "item",
  ["corn"]                              = "capsule",
  ["corn-bread"]                        = "capsule",
  ["corn-dough"]                        = "item",
  ["corn-flour"]                        = "item",
  ["cucumber"]                          = "capsule",
  ["fish-and-chips"]                    = "capsule",
  ["fish-bone"]                         = "item",
  ["fish-caviar-red"]                   = "capsule",
  ["fish-meat-red"]                     = "capsule",
  ["fish-steak"]                        = "capsule",
  ["food-1-capsule"]                    = "capsule",
  ["food-12-capsule"]                   = "capsule",
  ["food-16-capsule"]                   = "capsule",
  ["fries"]                             = "capsule",
  ["lettuce"]                           = "capsule",
  ["orange"]                            = "capsule",
  ["pickles"]                           = "capsule",
  ["pizza"]                             = "capsule",
  ["popcorn"]                           = "capsule",
  ["potato"]                            = "item",
  ["rapeseed"]                          = "item",
  ["raw-fries"]                         = "item",
  ["raw-mince"]                         = "item",
  ["schnitzel"]                         = "capsule",
  ["soy"]                               = "item",
  ["tofu"]                              = "capsule",
  ["tomato"]                            = "capsule",
  ["wheat"]                             = "item",
  ["whole-wheat-cookie"]                = "capsule",

  -- Other

  ["compost"]                           = "item",
  ["crystal"]                           = "capsule",
  ["eat-drink-equipment"]               = "item",
  ["fi-deepwatertile"]                  = "item",
  ["fi-watertile"]                      = "item",
  ["flask"]                             = "item",
  ["gelatine-granules"]                 = "capsule",
  ["invulnerability-capsule"]           = "capsule",
  ["simple-capsule-pure-water"]         = "capsule",
  ["simple-neutralizing-capsule"]       = "capsule",
  ["substances-dust"]                   = "capsule",
}



local blacklist_patterns = {
  -- Food stuff
  "^.+%-burger$",
  "^.+%-food%-.+%-capsule$",
  "^.+%-peeled$",
  "^.+%-pizza$",
  "^.+%-plant$",
  "^.+%-salad$",
  "^.+%-sapling$",
  "^.+%-seedling$",
  "^.+%-seeds$",
  "^cooked%-.+",
  "^substance%-.+$",
  "^tofu%-.+",
  "^wheat%-.+$",

  -- Other
  "^flask%-.+",
  --~ "fish-farm",
  "^.+%-crafting%-capsule$",
  "^.+%-digestive%-capsule$",
  "^.+%-health%-buffer%-capsule$",
  "^.+%-long%-reach%-capsule$",
  "^.+%-mining%-capsule$",
  "^.+%-regen%-capsule$",
  "^.+%-shell%-capsule$",
  "^.+%-sleep%-capsule$",
  "^.+%-speed%-capsule$",
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
