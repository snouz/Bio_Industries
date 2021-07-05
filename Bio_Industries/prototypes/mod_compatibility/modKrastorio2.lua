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
  --~ if not recipes[BI.additional_recipes.sand.name] then
    --  data:extend({BI.additional_recipes.sand})
    --  BioInd.created_msg(recipes[BI.additional_recipes.sand.name])
    --~ BioInd.create_stuff(BI.additional_recipes.sand)
  --~ end
  --~ recipe = recipes[BI.additional_recipes.sand.name]
  recipe = BioInd.create_stuff(BI.additional_recipes.sand)[1]

  -- Adjust icon
  BioInd.BI_change_icon(recipe, ICONPATH .. "sand-Krastorio.png")


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
local psp = BI.additional_recipes.BI_Game_Tweaks_Production_Science.production_science_pack
recipe = recipes[psp]

if recipe then
  recipe = nil
  BioInd.writeDebug("Removed %s \"%s\"!", {psp.type, psp.name})
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
