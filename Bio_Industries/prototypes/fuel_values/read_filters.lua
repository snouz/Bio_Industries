------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--          Read patterns for blacklisted/whitelists items from each mod          --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Longer lists, but faster look-up (dictionaries!) of specific items
local blacklist_items = {}
local whitelist_items = {}

-- Patterns catch more cases than names, but are slower to use as we've to loop over
-- the patterns when searching for a match
local blacklist_patterns = {}
local whitelist_patterns = {}


-- Temporary table so we only need to require each file once
local filters = {}


------------------------------------------------------------------------------------
--                               Read preset filters                              --
------------------------------------------------------------------------------------
filters["Default"]              = require("prototypes.fuel_values.filtersDefault")

filters["5dim"]                 = require("prototypes.fuel_values.filters5dim")
filters["Angels"]               = require("prototypes.fuel_values.filtersAngels")
filters["BioTech"]              = require("prototypes.fuel_values.filtersBioTech")
filters["Bobs"]                 = require("prototypes.fuel_values.filtersBobs")
filters["FoodIndustry"]         = require("prototypes.fuel_values.filtersFoodIndustry")
filters["IndustrialRevolution"] = require("prototypes.fuel_values.filtersIndustrialRevolution")
filters["Krastorio2"]           = require("prototypes.fuel_values.filtersKrastorio2")
filters["creative-mod"]         = require("prototypes.fuel_values.filtersCreativeMod")
filters["Pyanodons"]            = require("prototypes.fuel_values.filtersPyanodon")


BioInd.show("filters", filters)

------------------------------------------------------------------------------------
-- Preset patterns are stored as array for simplicity. Convert these lists to     --
-- dictionaries, so mods can easily overwrite them.                               --
------------------------------------------------------------------------------------
for mod_name, mod_lists in pairs(filters) do
BioInd.show("mod_name", mod_name)
BioInd.show("mod_lists", mod_lists)
  mod_lists.blacklist_patterns = mod_lists.blacklist_patterns and
                                    util.list_to_map(mod_lists.blacklist_patterns)
  mod_lists.whitelist_patterns = mod_lists.whitelist_patterns  and
                                    util.list_to_map(mod_lists.whitelist_patterns)
end

------------------------------------------------------------------------------------
-- There are preset filters for multiple mods in some files, stored in an alias   --
-- list. Make a look-up list so changes to a mod from a suite end up in the       --
-- correct list!                                                                  --
------------------------------------------------------------------------------------
local mod_suites = {
  ["Angels"]    = { "angelspetrochem", "angelsbioprocessing", "angelsrefining", },
  ["Bobs"]      = { "bobelectronics", "bobgreenhouse", "bobores", "bobplates", "bobpower", "bobrevamp", },
  ["Pyanodons"] = { "pyalienlife", "pycoalprocessing", "pyfusionenergy", "pyhightech", "pyindustry",                    "pypetroleumhandling", "pyrawores", },
}

-- Make reverse look-up list (mod_name --> mod_alias used in filters)
local suite_mods = {}
for suite, mod_list in pairs(mod_suites) do
  for m, mod_name in ipairs(mod_list) do
    suite_mods[mod_name] = suite
  end
end

local mod_name
--~ ------------------------------------------------------------------------------------
--~ -- If there are presets for any modsuits, create filters for the indiviudal mods  --
--~ ------------------------------------------------------------------------------------
--~ for suite_name, suite_mods in pairs(mod_suites) do
  --~ for m, mod_name in pairs(suite_mods or {}) do
    --~ if mods[mod_name] then
      --~ filters[mod_name] = table.deepcopy(filters[suite_name])
    --~ end
  --~ end
  --~ filters[suite_name] = nil
--~ end

--~ BioInd.show("filters", filters)


------------------------------------------------------------------------------------
-- TEST
------------------------------------------------------------------------------------
--~ BI_FuelItem_Filters["Default"] = {
  --~ blacklist_items = {
    --~ ["rubber-wood"]                 = "item",
    --~ ["remove-item"]                 = "item",
    --~ ["pistol"]                      = false,
  --~ },

  --~ whitelist_patterns = {
    --~ [".*wood.*"]                    = false,
  --~ },
--~ }
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                Read custom filters set via  BI_FuelItem_Filters                --
------------------------------------------------------------------------------------
for m_name, lists in pairs(BI_FuelItem_Filters) do
BioInd.writeDebug("Custom filters for mod \"%s\": %s", {mod_name, lists})
  mod_name = suite_mods[m_name] or m_name
BioInd.show("mod_name", mod_name)

  filters[mod_name] = filters[mod_name] or {}

  for list_name, list in pairs(lists or {}) do
    -- Ignore lists that don't have a proper name!
    if list_name == "blacklist_items" or list_name == "blacklist_patterns" or
        list_name == "whitelist_items" or list_name == "whitelist_patterns" then

      filters[mod_name][list_name] = filters[mod_name][list_name] or {}
BioInd.writeDebug("Filter list \"%s\": %s", {list_name, list})

      for filter_name, set_filter in pairs(list) do
BioInd.writeDebug("Filter: \"%s\"\tValue: \"%s\"", {filter_name, set_filter})
        filters[mod_name][list_name][filter_name] = set_filter or nil
BioInd.writeDebug("Set filters \"%s\": %s", {filter_name, filters[mod_name][list_name][filter_name] or "nil"})
      end
    end
  end
end

BioInd.writeDebug("filters after merging lists: %s", {filters})


------------------------------------------------------------------------------------
-- Add filters from each mod to the final lists. If the same filter is used by    --
-- different mods, the data from the last mod read from the list will be used.    --
------------------------------------------------------------------------------------
for mod_name, lists in pairs(filters) do
BioInd.show("mod_name", mod_name)
BioInd.show("lists", lists)
  -- Add blacklist item names/types (dictionary)
  cnt = 0
  if next(lists) then
    if lists.blacklist_items and next(lists.blacklist_items) then
      for item_name, item_type in pairs(lists.blacklist_items or {}) do
        blacklist_items[item_type] = blacklist_items[item_type] or {}
        blacklist_items[item_type][item_name] = true
        cnt = cnt + 1
      end
      BioInd.writeDebug("Read data for %s types of items with a blacklisted name (Mod: \"%s\")",
                        {cnt, mod_name})
    end

    -- Add whitelist item names/types (dictionary)
    cnt = 0
    if lists.whitelist_items and next(lists.whitelist_items) then
      for item_name, item_type in pairs(lists.whitelist_items) do
        whitelist_items[item_type] = whitelist_items[item_type] or {}
        whitelist_items[item_type][item_name] = true
        cnt = cnt + 1
      end
      BioInd.writeDebug("Read data for %s types of items with a whitelisted name (Mod: \"%s\")",
                        {cnt, mod_name})
    end

    -- Add blacklist patterns (array)
    cnt = 0
    if lists.blacklist_patterns and next(lists.blacklist_patterns) then
      for pattern, p in pairs(lists.blacklist_patterns or {}) do
        blacklist_patterns[#blacklist_patterns + 1] = pattern
        cnt = cnt + 1
      end
      BioInd.writeDebug("Read %s blacklist patterns for mod \"%s\"",
                        {cnt, mod_name})
    end

    -- Add whitelist patterns (array)
    cnt = 0
    if lists.whitelist_patterns and next(lists.whitelist_patterns) then
      for pattern, p in pairs(lists.whitelist_patterns or {}) do
        whitelist_patterns[#whitelist_patterns + 1] = pattern
        cnt = cnt + 1
      end
      BioInd.writeDebug("Read %s whitelist patterns for mod \"%s\"",
                        {cnt, mod_name})
    end
  else
    BioInd.writeDebug("No data for mod \"%s\"!", {mod_name})
  end

end

BioInd.show("blacklist_items", blacklist_items)
BioInd.show("blacklist_patterns", blacklist_patterns)
BioInd.show("whitelist_items", whitelist_items)
BioInd.show("whitelist_patterns", whitelist_patterns)

--~ error("Test!")


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")

return {
  blacklist_items       = blacklist_items,
  whitelist_items       = whitelist_items,
  blacklist_patterns    = blacklist_patterns,
  whitelist_patterns    = whitelist_patterns
}
