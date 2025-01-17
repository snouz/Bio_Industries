------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local items = data.raw.items
local recipe, item, rail


------------------------------------------------------------------------------------
--                            Update rail-related stuff                           --
------------------------------------------------------------------------------------
-- Rail collision masks and unlocks of vanilla rails
require("prototypes.optional._final_fixes.rails.fixes_rail")

-- Update rail images/icons
require("prototypes.optional._final_fixes.rails.fixes_tint_rails")

-- Wooden rail bridge
require("prototypes.optional._final_fixes.rails.fixes_wooden_rail_bridge")


------------------------------------------------------------------------------------
--           Adjust the vanilla rails -- they are "Concrete rails" now!           --
------------------------------------------------------------------------------------
BioInd.debugging.writeDebug("Adjusting vanilla rails")

-- Recipe
recipe = recipes["rail"]
if recipe then
  -- Add concrete to ingredients
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "concrete",
    amount = 2
  })
  BioInd.debugging.modified_msg("ingredient \"concrete\"", recipe, "Added")
BioInd.debugging.show("DEBUG RAIL RECIPE", data.raw.recipe.rail)

  -- Change localization
  --~ recipe.localised_name = {"entity-name.bi-rail-concrete"}
  recipe.localised_name = BI.additional_recipes.BI_Rails.rail_concrete.localised_name
  BioInd.debugging.modified_msg("localization", recipe)

  -- Change order
  --~ recipe.order = "a[train-system]-[Bio_Industries]-b[concrete]-a[rail]",
  recipe.order = BI.additional_recipes.BI_Rails.rail_concrete.order
  BioInd.debugging.modified_msg("order", recipe)
end


-- Item
item = data.raw["rail-planner"]["rail"]
if item then
  --~ item.localised_name = {"entity-name.bi-rail-concrete"}
  item.localised_name = BI.additional_items.BI_Rails.rail_concrete.localised_name
  BioInd.debugging.modified_msg("localization", item)

  -- Change order
  --~ recipe.order = "a[train-system]-[Bio_Industries]-b[concrete]-a[rail]",
  item.order = BI.additional_items.BI_Rails.rail_concrete.order
  BioInd.debugging.modified_msg("order", recipe)
end


-- Entities
for n, name in ipairs({"straight-rail", "curved-rail"}) do
  rail = data.raw[name][name]
  if rail then
    rail.localised_name = {"entity-name.bi-rail-concrete"}
    BioInd.debugging.modified_msg("localization", rail)
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
