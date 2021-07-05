------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
if not BI.check_mods({
  "pycoalprocessing",

}) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath .. "mod_py/"

local recipe, item
local recipes = data.raw.recipe
local items = data.raw.item


------------------------------------------------------------------------------------
--              Replace our ash with generic ash in different recipes             --
------------------------------------------------------------------------------------
if items["ash"] and mods["pycoalprocessing"] then

  -- Replace ingredients
  local recipe_list = {
  "bi-seed-2", "bi-seedling-2", "bi-logs-2",
  "bi-stone-brick",
  "bi-fertilizer-1", "bi-fertilizer-2", "bi-ash", "ash",
  "bi-biomass-3",
  "bi-sulfur",
  }

  local old = "bi-ash"
  local new = "ash"

  if items[new] then
    for r, recipe in pairs(recipe_list) do
      --~ thxbob.lib.recipe.replace_ingredient ("bi-seed-2", "bi-ash", "ash")
      thxbob.lib.recipe.replace_ingredient(recipe, old, new)
      --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe})
      BioInd.modified_msg("ingredients", recipe)
    end
  end

  -- Replace result of recipes that produce ash
  for i = 1, 2 do
    recipe = recipes["bi-ash-" .. i]
    if recipe then
      thxbob.lib.recipe.remove_result(recipe.name, old)
      thxbob.lib.recipe.add_result(recipe.name, new)
      BioInd.modified_msg("results", recipe)
    end
  end

  -- Remove item
  if items[old] then
    items[old] = nil
    BioInd.writeDebug("Removed item \"%s\".", {old})
  end


  -- Use ash icon from pycoalprocessing in icons of recipes using ash
  local icon_map = {
    ["bi-ash-1"]        = "py_ash_woodpulp",
    ["bi-ash-2"]        = "py_ash_raw-wood",
    ["bi-logs-2"]       = "py_raw-wood-mk2",
    ["bi-seed-2"]       = "py_bio_seed2",
    ["bi-seedling-2"]   = "py_Seedling2",
    ["bi-stone-brick"]  = "py_bi_stone_brick",
    ["bi-sulfur"]       = "py_bio_sulfur"
  }
  for recipe, icon in pairs(icon_map) do
    BioInd.BI_change_icon(recipes[recipe], ICONPATH .. icon .. ".png")
  end
end


--~ ------------------------------------------------------------------------------------
--~ -- If the Py-Suite is installed, we move our coal-processing unlocks to their techs!
--~ local check, set
--~ if mods["pyrawores"] then
  --~ -- Are all techs there?
  --~ check = true
  --~ for i = 1, 3 do
    --~ if not data.raw.technology["coal-mk0" .. i] then
      --~ check = false
      --~ break
    --~ end
  --~ end

  --~ if check then
    --~ set = true
    --~ --local unlocks = require("prototypes.Bio_Farm.coal_processing")
    --~ for i = 1, 3 do
      --~ for u, unlock in ipairs(unlocks[i]) do
        --~ thxbob.lib.tech.add_recipe_unlock("coal-mk0" .. i, unlock.recipe)
--~ BioInd.writeDebug("Added recipe %s to unlocks of %s", {unlock.recipe, "coal-mk0" .. i})
      --~ end
    --~ end
  --~ end
--~ end
--~ -- PyRawOres has priority!
--~ if mods["pycoalprocessing"] and not set then
   --~ -- Are all techs there?
  --~ check = true
  --~ for i = 1, 3 do
    --~ if not data.raw.technology["coal-processing-" .. i] then
      --~ check = false
      --~ break
    --~ end
  --~ end

  --~ if check then
    --~ set = true
    --~ --local unlocks = require("prototypes.Bio_Farm.coal_processing")
    --~ for i = 1, 3 do
      --~ for u, unlock in ipairs(unlocks[i]) do
        --~ thxbob.lib.tech.add_recipe_unlock("coal-processing-" .. i, unlock.recipe)
--~ BioInd.writeDebug("Added recipe %s to unlocks of %s", {unlock.recipe, "coal-processing-" .. i})
      --~ end
    --~ end
  --~ end
--~ end
--~ if set then
  --~ for i = 1, 3 do
    --~ data.raw.technology["bi-tech-coal-processing-" .. i] = nil
--~ BioInd.writeDebug("Removed technology " .. "bi-tech-coal-processing-" .. i)
  --~ end
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
