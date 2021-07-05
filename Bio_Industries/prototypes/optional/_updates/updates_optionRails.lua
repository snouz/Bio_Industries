------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
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
require("prototypes.optional._updates.rails.updates_rail")

-- Update rail images/icons
require("prototypes.optional._updates.rails.updates_tint_rails")

-- Wooden rail bridge
require("prototypes.optional._updates.rails.updates_wooden_rail_bridge")


------------------------------------------------------------------------------------
--           Adjust the vanilla rails -- they are "Concrete rails" now!           --
------------------------------------------------------------------------------------
BioInd.writeDebug("Adjusting vanilla rails")
-- Recipe
recipe = recipes["rail"]
if recipe then
  -- Add concrete to ingredients
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "concrete",
    amount = 2
  })
  BioInd.modified_msg("ingredient \"concrete\"", recipe, "Added")

  -- Change localization
  recipe.localised_name = {"entity-name.bi-rail-concrete"}
  BioInd.modified_msg("localization", recipe)
end


-- Item
item = data.raw["rail-planner"]["rail"]
if item then
  item.localised_name = {"entity-name.bi-rail-concrete"}
  BioInd.modified_msg("localization", item)
end


-- Entities
for n, name in ipairs({"straight-rail", "curved-rail"}) do
  rail = data.raw[name][name]
  if rail then
    rail.localised_name = {"entity-name.bi-rail-concrete"}
    BioInd.modified_msg("localization", rail)
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
