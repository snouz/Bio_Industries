BioInd.entered_file()

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])
local ICONPATH = BioInd.iconpath


-- Check if we need to replace "bi-ash" with "ash" in recipe ingredients/results!
require("prototypes.default.final_fixes.ash")


-- If OwnlyMe's or Tral'a "Robot Tree Farm" mods are active, they will create variatons
-- of our variations of tree prototypes. Remove them!
local ignore_trees = BioInd.tree_stuff.get_tree_ignore_list()
local removed = 0

for name, _ in pairs(ignore_trees or {}) do
  if name:match("rtf%-bio%-tree%-.+%-%d-%d+") then
    data.raw.tree[name] = nil
    ignore_trees[name] = nil
    removed = removed + 1
    BioInd.show("Removed tree prototype", name)
  end
end
BioInd.writeDebug("Removed %g tree prototypes. Number of trees to ignore now: %g", {removed, table_size(ignore_trees)})

--~ ------------------------------------------------------------------------------------
--~ --                              Enable: Wooden rails                              --
--~ --                             (BI.Settings.BI_Rails)                             --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional._final_fixes.fixes_optionRails")

--~ ---- Game Tweaks ---- Tree
--~ require("prototypes.optional._final_fixes.fixes_tweaksTreeYield")


--~ ---- Game Tweaks ---- Player (Changed for 0.18.34/1.1.4!)
--~ require("prototypes.optional._final_fixes.fixes_tweaksPlayer")

--~ ---- Game Tweaks ---- Bots
--~ require("prototypes.optional._final_fixes.fixes_tweaksBots")

--~ ---- Game Tweaks ----
--~ require("prototypes.optional._final_fixes.fixes_tweaksStackSize")

--~ --- Update fuel_emissions_multiplier values
--~ require("prototypes.optional._final_fixes.fixes_tweaksEmissionsMultiplier")

--~ -- Assign fuel values to items
--~ require("prototypes.optional._final_fixes.fixes_tweaksFuelValue")


--~ -- Make vanilla and Bio boilers exchangeable
--~ require("prototypes.optional._final_fixes.fixes_optionBioFuel")


--~ ------------------------------------------------------------------------------------
--~ --                          Enable: Early wooden defenses                         --
--~ --                             (BI.Settings.BI_Darts)                             --
--~ ------------------------------------------------------------------------------------
--~ require("prototypes.optional._final_fixes.fixes_optionDarts")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                    OPTIONAL -- THINGS DEPENDENT ON A SETTING                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
require("prototypes.optional._final_fixes.fixes_optionBioFuel")
require("prototypes.optional._final_fixes.fixes_optionCannon")
require("prototypes.optional._final_fixes.fixes_optionDarts")
require("prototypes.optional._final_fixes.fixes_optionPowerProduction")
require("prototypes.optional._final_fixes.fixes_optionRails")
require("prototypes.optional._final_fixes.fixes_tweaksBots")
require("prototypes.optional._final_fixes.fixes_tweaksEmissionsMultiplier")
require("prototypes.optional._final_fixes.fixes_tweaksFuelValue")
require("prototypes.optional._final_fixes.fixes_tweaksPlayer")
require("prototypes.optional._final_fixes.fixes_tweaksStackSize")
require("prototypes.optional._final_fixes.fixes_tweaksTreeYield")


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                          Compatibility with other mods                         --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- 5dim Stack changes
require("prototypes.mod_compatibility.final_fixes.fixes_mod5dim")


-- Industrial Revolution
require("prototypes.mod_compatibility.final_fixes.fixes_modIndustrialRevolution")


------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.final_fixes.fixes_modPyanodon")


------------------------------------------------------------------------------------
--   Deadlock's Stacking Beltboxes & Compact Loaders/Deadlock's Crating Machine   --
------------------------------------------------------------------------------------
require("prototypes.mod_compatibility.final_fixes.fixes_modDeadlockStacking")

require("prototypes.mod_compatibility.final_fixes.fixes_modKrastorio2")

-- Make sure fertilizers have the "place_as_tile" property!
require("prototypes.mod_compatibility.final_fixes.fixes_modAlienBiomes")

-- Updates to darts etc. if NE Buildings is NOT active
require("prototypes.mod_compatibility.final_fixes.fixes_modNEBuildings")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                    TRIGGERS                                    --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--               Sort recipes/items into other mods' item-subgroups               --
------------------------------------------------------------------------------------
require("prototypes.triggers._final_fixes.fixes_triggerSubgroups")



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Different things we need to change                       --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------- SNOUZ ICON UPDATES
require("prototypes.mod_compatibility.final_fixes.icon_updates")
--~ require("prototypes.mod_compatibility.final_fixes.group_updates")

------------------------------------------------------------------------------------
--                           Add icons to our prototypes                          --
------------------------------------------------------------------------------------
BioInd.BI_add_icons()


------------------------------------------------------------------------------------
--                           Add unlocks to technologies                          --
------------------------------------------------------------------------------------
BioInd.BI_add_unlocks()


------------------------------------------------------------------------------------
--              Update stacksize of BI-items to that of generic items             --
------------------------------------------------------------------------------------
local function update_stacksize(items)
  local BI_item, generic_item
  for l, list in pairs(items or {}) do
    if list.type and list.name then
      list = {list}
    end
    for i, item in pairs(list) do
      if item.BI_stack_size_from then
        BI_item = data.raw[item.type] and data.raw[item.type][item.name]
        generic_item = data.raw[item.type] and data.raw[item.type][item.BI_stack_size_from]

        if BI_item and generic_item then
          BI_item.stack_size = generic_item.stack_size
          BioInd.modified_msg("stack_size", BI_item)
        end
      end
    end
  end
end
update_stacksize(BI.additional_items)

------------------------------------------------------------------------------------
--                 Remove obsolete prerequisites from technologies                --
------------------------------------------------------------------------------------
local techs = data.raw.technology

local function sort_difficulty_unlocks(technology, difficulty)
BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local effects, recipe
  local unlock_recipes = {}
  local unlock_other = {}
  local tech = data.raw.technology[technology]

  if tech then
    if difficulty == "" then
      effects = tech.effects
    else
      if not tech[difficulty] then
        thxbob.lib.tech.add_difficulty(technology, difficulty)
      end
      effects = tech[difficulty].effects
    end

    for e, effect in ipairs(effects or {}) do
      if effect.type == "unlock-recipe" then
        recipe = data.raw.recipe[effect.recipe]
        if recipe then
          unlock_recipes[#unlock_recipes + 1] = {
            type = effect.type,
            recipe = recipe.name,
            order = recipe.order or ""
          }
        end
      else
        unlock_other[#unlock_other + 1] = effect
      end
    end
BioInd.show("Unsorted recipe unlocks", unlock_recipes)
    table.sort(unlock_recipes, function(a,b) return a.order < b.order end)
BioInd.show("Sorted recipe unlocks", unlock_recipes)
    if next(unlock_other) then
      table.move(unlock_other, 1, #unlock_other, #unlock_recipe, unlock_recipe)
    end
    for u, unlock in ipairs(unlock_recipes) do
      effects[u] = unlock
    end
BioInd.show("Final unlocks of " .. tech.name, effects)
  end
end

-- Check default techs
BioInd.writeDebug("Looking for missing prerequisites of default technologies:")
for t, tech in pairs(BI.default_techs) do
  thxbob.lib.tech.remove_obsolete_prerequisites(tech.name)

  --~ for d, diff in ipairs({"", "normal", "expensive"}) do
  for d, diff in ipairs(BioInd.difficulties) do
    sort_difficulty_unlocks(tech.name, diff)
  end
end

-- Check optional techs
for s, setting in pairs(BI.additional_techs) do
BioInd.writeDebug("Looking for missing prerequisites of technologies depending on setting %s:", {s})
  for t, tech in pairs(setting) do
    thxbob.lib.tech.remove_obsolete_prerequisites(tech)
    --~ for d, diff in ipairs({"", "normal", "expensive"}) do
    for d, diff in ipairs(BioInd.difficulties) do
      sort_difficulty_unlocks(tech.name, diff)
    end
  end
end



------------- SNOUZ ICON UPDATES
-- Moved to prototypes/mod_compatibility/final_fixes/icon_updates.lua


------------------------------------------------------------------------------------
--                                  TESTING AREA                                  --
------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
