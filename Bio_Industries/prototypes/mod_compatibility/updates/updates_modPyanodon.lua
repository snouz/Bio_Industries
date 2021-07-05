------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
--~ if BioInd.check_mods({
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


local ICONPATH = BioInd.iconpath .. "mod_py/"

local recipe, item, tech, tech_level

local recipes = data.raw.recipe
local items = data.raw.item
local techs = data.raw.technology

local mod_name


------------------------------------------------------------------------------------
--             Can we move our recipe unlocks to an alternative tech?             --
------------------------------------------------------------------------------------
-- We may take care of more Py-mods in the future, but only these have relevant techs!
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
      -- Check recipes
      for r, recipe in pairs(BI_recipes) do
        if recipes[recipe.name] then
          -- Find the unlock tech
          for u, unlock in pairs(recipe.BI_add_to_tech or {}) do
            tech_level = unlock:match("^" .. src_tech:gsub("%-", "%%-") .. "(%d+)$")
            -- Found original tech
            if tech_level then
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
--                       Replace icons in different recipes                       --
------------------------------------------------------------------------------------
--~ if items["ash"] and mods["pycoalprocessing"] then
mod_name = "pycoalprocessing"
if mods[mod_name] then
  BioInd.writeDebug("Found mod \"%s\"", {mod_name})


  -- Use ash icon from pycoalprocessing in icons of recipes using ash
  local icon_map = {
    [BI.default_recipes.ash_1.name]                             = "py_ash_woodpulp",
    [BI.default_recipes.ash_2.name]                             = "py_ash_raw-wood",
    [BI.default_recipes.logs_2.name]                            = "py_raw-wood-mk2",
    [BI.default_recipes.seed_2.name]                            = "py_bio_seed2",
    [BI.default_recipes.seedling_2.name]                        = "py_seedling2",
    [BI.additional_recipes.BI_Stone_Crushing.stone_brick.name]  = "py_bi_stone_brick",
    [BI.additional_recipes.BI_Bio_Fuel.bio_sulfur.name]         = "py_bio_sulfur",
  }
  for recipe, icon in pairs(icon_map) do
    if recipes[recipe] then
      BioInd.BI_change_icon(recipes[recipe], ICONPATH .. icon .. ".png")
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
