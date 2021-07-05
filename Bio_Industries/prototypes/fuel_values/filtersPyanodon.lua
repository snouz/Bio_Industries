------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "pycoalprocessing",
  "pyrawores",

}) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




-- Dictionary of item.name and item.type
local blacklist_items = {
  ["alumina"] = "item",
  ["ammonium-chloride"] = "item",
  ["brass-alloy"] = "item",
  ["brass-gear-wheel"] = "item",
  ["bronze-alloy"] = "item",
  ["calcium-chloride"] = "item",
  ["cobalt-oxide"] = "item",
  ["electrolyser"] = "item",
  ["empty-canister"] = "item",
  ["empty-nuclear-fuel-cell"] = "item",
  ["enriched-fuel"] = "item",
  ["fusion-catalyst"] = "item",
  ["gas-canister"] = "item",
  ["glass"] = "item",
  ["gunmetal-alloy"] = "item",
  ["hydrazine-generator"] = "item",
  ["invar-alloy"] = "item",
  ["lead-oxide"] = "item",
  ["limestone"] = "item",
  ["lithium"] = "item",
  ["plutonium-239"] = "item",
  ["powdered-tungsten"] = "item",
  ["quartz"] = "item",
  ["rtg"] = "item",
  ["salt"] = "item",
  ["silicon"] = "item",
  ["solder"] = "item",
  ["solder-alloy"] = "item",
  ["thorium-232"] = "item",
  ["void"] = "item",
}

local blacklist_patterns = {
  -- Resources
  "amethyst%-.+",
  "deuterium%-.+",
  "diamond%-.+",
  "emerald%-.+",
  "lithium%-.+",
  "nitinol%-.+",
  "ruby%-.+",
  "sapphire%-.+",
  "silicon%-.+",
  "silver%-.+",
  "sodium%-.+",
  "thorium%-.+",
  "titanium%-.+",
  "topaz%-.+",
  "tungsten%-.+",

  -- Items
  ".+%-fuel%-cell.*",
  ".*nuclear%-.+",
  "solar%-panel%-.+",
  "used%-up%-.+",


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
