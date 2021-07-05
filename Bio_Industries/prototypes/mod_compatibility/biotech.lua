------------------------------------------------------------------------------------
--                                     BioTech                                    --
------------------------------------------------------------------------------------
local mod_name = "BioTech"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath
local recipe

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
if data.raw.item["biotech-sand"] then

  -- Make sure our sand recipe exists
  if not data.raw.recipe[BI.additional_recipes.sand.name] then
    data:extend({BI.additional_recipes.sand})
    --~ BioInd.writeDebug("Created recipe %s.", {BI.additional_recipes.sand.name})
    BioInd.created_msg(BI.additional_recipes.sand)
  end
  recipe = data.raw.recipe[BI.additional_recipes.sand.name]

  -- Adjust result
  recipe.result = "biotech-sand"
  --~ BioInd.writeDebug("Changed result of recipe \"%s\".", {recipe.name})
  BioInd.modified_msg("result", recipe)

  --~ -- Add recipe to technology
  --~ recipe.BI_add_to_tech = {"bi-tech-stone-crushing-1"}
  --~ BioInd.writeDebug("Adding unlock for recipe %s", {recipe.name})
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
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
