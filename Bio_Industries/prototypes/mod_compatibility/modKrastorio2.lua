------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
local mod_name = "Krastorio2"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end

local ICONPATH = BioInd.iconpath .. "mod_krastorio/"
local recipe

local recipes = data.raw.recipe

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
if BI.Settings.BI_Stone_Crushing and data.raw.item["sand"] then

  BioInd.writeDebug("Generating recipe for sand from crushed stone!")

  -- Make sure our sand recipe exists
  --~ if not recipes[BI.additional_recipes.sand.name] then
    --  data:extend({BI.additional_recipes.sand})
    --  BioInd.created_msg(recipes[BI.additional_recipes.sand.name])
    --~ BioInd.create_stuff(BI.additional_recipes.sand)
  --~ end
  --~ recipe = recipes[BI.additional_recipes.sand.name]
  recipe = BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sand)[1]

  -- Adjust icon
  if recipe then
    BioInd.BI_change_icon(recipe, ICONPATH .. "sand-Krastorio.png")
  end
end


------------------------------------------------------------------------------------
-- Our alternative recipe for Production science packs will break the balance if  --
-- Krastorio is active, so we remove it again!                                    --
------------------------------------------------------------------------------------
recipe = recipes[BI.additional_recipes.BI_Game_Tweaks_Production_Science.production_science_pack]

if recipe then
  recipe = nil
  BioInd.writeDebug("Removed %s \"%s\"!", {recipe.type, recipe.name})
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
