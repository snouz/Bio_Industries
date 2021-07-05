------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
--~ if not BioInd.check_mods({
  --~ "pycoalprocessing",
  --~ "pyrawores",
--~ }) then
  --~ BioInd.nothing_to_do("*")
  --~ return
--~ else
  BioInd.entered_file()
--~ end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath .. "mod_py/"

local recipe, item, tech, tech_level

local recipes = data.raw.recipe
local items = data.raw.item
local techs = data.raw.technology


------------------------------------------------------------------------------------
--             Can we move our recipe unlocks to an alternative tech?             --
------------------------------------------------------------------------------------
if BioInd.check_mods({
  "pycoalprocessing",
  "pyrawores",
}) then

  local BI_recipes = BI.additional_recipes.BI_Coal_Processing

  local max_level = 3
  local src_tech = "bi-tech-coal-processing-"
  local mod_techs = {
    ["pyrawores"] = "coal-mk0",
    ["pycoalprocessing"] = "coal-processing-"
  }

  local mod_order = {"pyrawores", "pycoalprocessing"}

  ------------------------------------------------------------------------------------
  -- Make sure all techs exist!
  BioInd.show("mod_techs", mod_techs)

  for mod_name, tech in pairs(mod_techs) do
  BioInd.writeDebug("Checking tech %s for mod %s", {tech, mod_name})
    for i = 1, max_level do
      -- Missing techs, remove mod from list!
  BioInd.show(tech .. i, tostring(techs[tech .. i]))
      if not techs[tech .. i] then
        mod_techs[mod_name] = nil
  BioInd.writeDebug("Removed %s from list!", {mod_name})
        break
      end
    end
  BioInd.show("mod_techs", mod_techs)
  end

  ------------------------------------------------------------------------------------
  --                   Move our unlocks to techs from other mods!                   --
  ------------------------------------------------------------------------------------
  for m, mod_name in pairs(mod_order) do
  BioInd.writeDebug("Priority: %s\tMod: %s", {m, mod_name})
    -- All techs from that mod exist
    if mod_techs[mod_name] then
  --~ BioInd.writeDebug("mod_techs[%s]: %s", {mod_name, mod_techs[mod_name]})
      -- Check recipes
      for r, recipe in pairs(BI_recipes) do
  --~ BioInd.show("Checking recipe", recipe.name)
        if recipes[recipe.name] then
          -- Find the unlock tech
          for u, unlock in pairs(recipe.BI_add_to_tech or {}) do
            tech_level = unlock:match("^" .. src_tech:gsub("%-", "%%-") .. "(%d+)$")
            -- Found original tech
            if tech_level then
  --~ BioInd.show("Changing unlock to", mod_techs[mod_name] .. tech_level)
              recipes[recipe.name].BI_add_to_tech = recipes[recipe.name].BI_add_to_tech or {}
              table.insert(recipes[recipe.name].BI_add_to_tech, mod_techs[mod_name] .. tech_level)
              BioInd.modified_msg("unlock", recipes[recipe.name])
            end
          end
        end
      end
      -- We've used the techs from the mod with the highest priority. Skip the rest!
      BioInd.writeDebug("Techs from mod \"%s\" are used now. Breaking out of the loop!", {mod_name} )
      break
    else
      BioInd.writeDebug("Target techs don't exist, trying next mod!")
    end
  end

-- Create our own techs
elseif BI.Settings["BI_Coal_Processing"] then
  BioInd.create_stuff(BI.additional_techs.BI_Coal_Processing)
end


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
  "bi-basic-gas-processing",
  }

  local old = "bi-ash"
  local new = "ash"

  if items[new] then
    for r, r_name in pairs(recipe_list) do
      recipe = recipes[r_name]
      if recipe then
        --~ thxbob.lib.recipe.replace_ingredient ("bi-seed-2", "bi-ash", "ash")
        thxbob.lib.recipe.replace_ingredient(recipe.name, old, new)
        --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe})
        BioInd.modified_msg("ingredients", recipe)
      end
    end
  end

  -- Replace result of recipes that produce ash
  for i = 1, 2 do
    recipe = recipes["bi-ash-" .. i]

    if recipe then
      thxbob.lib.recipe.remove_result(recipe.name, old)
      thxbob.lib.recipe.add_result(recipe.name, new)
      BioInd.modified_msg("results", recipe)
  BioInd.show("results", recipe.results)
    end
  end

  -- Remove item
  if items[old] then
    items[old] = nil
    BioInd.writeDebug("Removed item \"%s\".", {old})
  end

--~ if mods["pycoalprocessing"] and BI.Settings.BI_Bio_Fuel then
    --~ -- Bio_Fuel/recipe.lua:30:      {type = "item", name = "bi-ash", amount = 15}
    --~ thxbob.lib.recipe.remove_result ("bi-basic-gas-processing", "bi-ash")
    --~ thxbob.lib.recipe.add_result("bi-basic-gas-processing", {
      --~ type = "item",
      --~ name = "ash",
      --~ amount = 15
    --~ })
--~ end



  -- Use ash icon from pycoalprocessing in icons of recipes using ash
  local icon_map = {
    ["bi-ash-1"]        = "py_ash_woodpulp",
    ["bi-ash-2"]        = "py_ash_raw-wood",
    ["bi-logs-2"]       = "py_raw-wood-mk2",
    ["bi-seed-2"]       = "py_bio_seed2",
    ["bi-seedling-2"]   = "py_seedling2",
    ["bi-stone-brick"]  = "py_bi_stone_brick",
    ["bi-sulfur"]       = "py_bio_sulfur"
  }
  for recipe, icon in pairs(icon_map) do
    if recipes[recipe] then
      BioInd.BI_change_icon(recipes[recipe], ICONPATH .. icon .. ".png")
    end
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
BioInd.entered_file("leave")
