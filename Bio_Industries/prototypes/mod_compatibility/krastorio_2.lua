------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
local mod_name = "Krastorio2"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath .. "mod_krastorio/"
local recipe

local recipes = data.raw.recipe

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
if data.raw.item["sand"] then

BioInd.writeDebug("Generating recipe for sand from crushed stone!")

  -- Make sure our sand recipe exists
  if not recipes[BI.additional_recipes.sand.name] then
    data:extend({BI.additional_recipes.sand})
    BioInd.created_msg(recipes[BI.additional_recipes.sand.name])
  end
  recipe = recipes[BI.additional_recipes.sand.name]

  -- Adjust icon
  --~ BioInd.writeDebug("Using Krastorio icon …")
  --~ recipe.icon = ICONPATH .. "sand-Krastorio.png"
  --~ recipe.icon_size = 64
  --~ recipe.BI_add_icon = true
  BioInd.BI_change_icon(recipe, ICONPATH .. "sand-Krastorio.png")

  --~ -- Add recipe to technology
  --~ BioInd.writeDebug("Adding unlock for recipe %s", {recipe.name})
  --~ recipe.BI_add_to_tech = {"bi-tech-stone-crushing-1"}
  --~ thxbob.lib.tech.add_recipe_unlock("bi-tech-stone-crushing-1", "bi-sand")

  -- MOVED TO DATA-UPDATES.LUA!
  --~ -- Use alternative descriptions for stone crusher!
--~ BioInd.writeDebug("Using alternative descriptions for \"bi-stone-crusher\"!")
  --~ for _, t in ipairs({"furnace", "item", "recipe"}) do
    --~ data.raw[t]["bi-stone-crusher"].localised_description =
      --~ {"entity-description.bi-stone-crusher-sand"}
  --~ end
end


------------------------------------------------------------------------------------
-- Our alternative recipe for Production science packs will break the balance if  --
-- Krastorio is active, so we remove it again!                                    --
------------------------------------------------------------------------------------
local psp = BI.optional_recipes.BI_Game_Tweaks_Production_Science.production_science_pack
recipe = recipes[psp]

if recipe then
  recipe = nil
  --~ recipe = data.raw.recipe[BI.optional_recipes[setting].production_science_pack.name]
  BioInd.writeDebug("Removed %s \"%s\"!", {psp.type, psp.name})
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
