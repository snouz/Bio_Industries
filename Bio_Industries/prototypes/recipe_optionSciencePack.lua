local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

-- Add alternative Production Science Pack using Wooden rails instead of regular rails.
-- This will only be created if "Krastorio 2" IS NOT active (new recipe would break the
-- balance then) and if the setting for the recipe IS enabled.
local KRAS = (mods["Krastorio2"] or mods["Krastorio"]) and true or false
local SET = settings.startup["BI_Game_Tweaks_Production_Science"].value
if SET and not KRAS then
  data:extend({
    {
      type = "recipe",
      name = "bi-production-science-pack",
      enabled = false,
      energy_required = 21,
      ingredients = {
        {"electric-furnace", 1},
        {"productivity-module", 1},
        {"bi-rail-wood", 40}
      },
      result_count = 3,
      result = "production-science-pack"
    },
  })
  --~ BI_Functions.lib.allow_productivity("bi-production-science-pack")
  --~ thxbob.lib.tech.add_recipe_unlock("production-science-pack", "bi-production-science-pack")
  BioInd.writeDebug("Added alternative recipe for Production science packs.")
else
  BioInd.writeDebug("Didn't add alternative recipe for Production science packs! (\"Krastorio\": %s\tSetting: %s", {(KRAS and "active" or "not active"), (SET and "enabled" or "disabled")})
end
