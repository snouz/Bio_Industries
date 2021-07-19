------------------------------------------------------------------------------------
--                                Base mod/vanilla                                --
------------------------------------------------------------------------------------
BioInd.entered_file()
BioInd.writeDebug("Reading default patterns")


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Dictionary of item.name and item.type
local blacklist_items = {
  -- fuel_value doesn't make sense for ash!
  ["ash"]                               = "item",
  ["bi-ash"]                            = "item",


  -- BI items
  ["bi-arboretum-area"]                 = "item",
  ["bi-bio-cannon-area"]                = "item",
  ["bi-bio-garden"]                     = "item",
  ["bi-bio-garden-huge"]                = "item",
  ["bi-bio-garden-large"]               = "item",
  ["bi-bio-greenhouse"]                 = "item",
  ["bi-bio-reactor"]                    = "item",
  ["bi-bio-solar-farm"]                 = "item",
  ["bi-cokery"]                         = "item",
  ["bi-huge-substation"]                = "item",
  ["bi-poison-artillery-shell"]         = "ammo",
  ["bi-power-to-rail-pole"]             = "item",
  ["bi-purified-air"]                   = "item",
  ["bi-rail-power"]                     = "rail-planner",
  ["bi-rubber-mat"]                     = "item",
  --~ ["bi-seed"]                           = "item",
  ["bi-solar-mat"]                      = "item",
  ["bi-stone-crusher"]                  = "item",
  ["seedling"]                          = "item",

  -- Resources
  --~ ["coal"]                          = "item",
  ["coke"]                              = "item",
  ["copper-ore"]                        = "item",
  ["copper-plate"]                      = "item",
  ["iron-ore"]                          = "item",
  ["iron-plate"]                        = "item",
  ["resin"]                             = "item",
  ["rubber"]                            = "item",
  ["sand"]                              = "item",
  ["steel-plate"]                       = "item",
  ["stone"]                             = "item",
  ["stone-crushed"]                     = "item",
  ["sulfur"]                            = "item",

  -- Vanilla items
  ["atomic-bomb"]                       = "ammo",
  ["battery"]                           = "item",
  ["battery-equipment"]                 = "item",
  ["battery-mk2-equipment"]             = "item",
  ["beacon"]                            = "item",
  ["belt-immunity-equipment"]           = "item",
  ["cannon-shell"]                      = "ammo",
  ["car"]                               = "item-with-entity-data",
  ["cargo-wagon"]                       = "item-with-entity-data",
  ["centrifuge"]                        = "item",
  ["chemical-plant"]                    = "item",
  ["cliff-explosives"]                  = "capsule",
  ["cluster-grenade"]                   = "capsule",
  ["coin"]                              = "item",
  ["concrete"]                          = "item",
  ["construction-robot"]                = "item",
  ["defender-capsule"]                  = "capsule",
  ["destroyer-capsule"]                 = "capsule",
  ["distractor-capsule"]                = "capsule",
  ["electric-energy-interface"]         = "item",
  ["empty-barrel"]                      = "item",
  ["energy-shield-equipment"]           = "item",
  ["energy-shield-mk2-equipment"]       = "item",
  ["exoskeleton-equipment"]             = "item",
  ["explosives"]                        = "item",
  ["flamethrower-ammo"]                 = "ammo",
  ["flamethrower-turret"]               = "item",
  ["fluid-wagon"]                       = "item-with-entity-data",
  ["flying-robot-frame"]                = "item",
  ["fusion-reactor-equipment"]          = "item",
  ["grenade"]                           = "capsule",
  ["hazard-concrete"]                   = "item",
  ["item-unknown"]                      = "item",
  ["lab"]                               = "item",
  ["land-mine"]                         = "item",
  ["landfill"]                          = "item",
  ["linked-belt"]                       = "item",
  ["linked-chest"]                      = "item",
  ["locomotive"]                        = "item-with-entity-data",
  ["logistic-robot"]                    = "item",
  ["low-density-structure"]             = "item",
  ["night-vision-equipment"]            = "item",
  ["nuclear-fuel"]                      = "item",
  ["nuclear-reactor"]                   = "item",
  ["oil-refinery"]                      = "item",
  ["pipe"]                              = "item",
  ["pipe-to-ground"]                    = "item",
  ["pistol"]                            = "gun",
  ["plastic-bar"]                       = "item",
  ["player-port"]                       = "item",
  ["poison-capsule"]                    = "capsule",
  ["power-armor"]                       = "armor",
  ["power-armor-mk2 "]                  = "armor",
  ["processing-unit"]                   = "item",
  ["rail"]                              = "rail-planner",
  ["raw-fish"]                          = "capsule",
  ["refined-concrete"]                  = "item",
  ["refined-hazard-concrete"]           = "item",
  ["roboport"]                          = "item",
  ["rocket"]                            = "ammo",
  ["rocket-fuel"]                       = "item",
  ["satellite"]                         = "item",
  ["shotgun-shell"]                     = "ammo",
  ["simple-entity-with-force"]          = "item",
  ["simple-entity-with-owner"]          = "item",
  ["slowdown-capsule"]                  = "capsule",
  ["small-lamp"]                        = "item",
  ["solar-panel"]                       = "item",
  ["solar-panel-equipment"]             = "item",
  ["solid-fuel"]                        = "item",
  ["spidertron"]                        = "item-with-entity-data",
  ["stack-filter-inserter"]             = "item",
  ["stack-inserter"]                    = "item",
  ["steam-engine"]                      = "item",
  ["steam-turbine"]                     = "item",
  ["stone-brick"]                       = "item",
  ["storage-tank"]                      = "item",
  ["submachine-gun"]                    = "gun",
  ["tank"]                              = "item-with-entity-data",
  ["train-stop"]                        = "item",
  ["used-up-uranium-fuel-cell"]         = "item",
  ["vehicle-machine-gun"]               = "gun",
}

local blacklist_patterns = {
  -- BI items
  ".*fertilizer$",
  "^bi%-arboretum%-r%d",
  "^bi%-seed%-bomb%-.+",

  -- Default items
  ".*battery.*",
  "^.+%-science%-pack$",
  ".*artillery%-.+",
  "^discharge%-defense%-.+",
  "^explosive%-.+",
  "^heat%-.+",
  "^infinity%-.+",
  "^logistic%-chest%-.+",
  "^personal%-.+",
  ".*pipe.*",
  ".*pipe%-to%-ground.*",
  ".*rocket%-.+",
  "^spidertron%-.+",
  "^tank%-.+",

  -- Common items
  ".*power%-armor.*",

  -- Intermediate products/resources
  ".+%-barrel$",
  "^concrete%-.+",
  ".+%-concrete%-.+",
  ".+%-concrete$",
  "^ore%-.+",
  ".+%-ore%-.+",
  ".+%-ore$",
  ".+%-plate$",
  "^copper%-.+",
  ".+%-copper%-.+",
  ".+%-copper$",
  "^iron%-.+",
  ".+%-iron%-.+",
  ".+%-iron$",
  "^steel%-.+",
  ".+%-steel%-.+",
  ".+%-steel$",
  "^uranium%-.+",
  ".+%-uranium%-.+",
  ".+%-uranium$",
}

local whitelist_items = {}

local whitelist_patterns = {
  --~ "^bi%-seed%-bomb%-.+",
  ".*wood.*",
}

local whitelist_items = {}
------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")

return {
  blacklist_items = blacklist_items or {},
  whitelist_items = whitelist_items or {},
  blacklist_patterns = blacklist_patterns or {},
  whitelist_patterns = whitelist_patterns or {},
}
