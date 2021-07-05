------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipes
local items = data.raw.items
local recipe, item

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
-- We have a technology "Concrete rails", so normal rails must contain concrete!  --
------------------------------------------------------------------------------------
--~ recipe = recipes["rail"]
--~ thxbob.lib.recipe.add_new_ingredient(recipe, "concrete")
--~ BioInd.modified_msg("ingredient \"concrete\"", recipe, "Added")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
