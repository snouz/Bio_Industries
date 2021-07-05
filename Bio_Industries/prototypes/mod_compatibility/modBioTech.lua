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


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe

------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
if data.raw.item["biotech-sand"] then

  -- Make sure our sand recipe exists
  if not data.raw.recipe[BI.additional_recipes.sand.name] then
    --~ data:extend({BI.additional_recipes.sand})
    --~ BioInd.created_msg(BI.additional_recipes.sand)
    BioInd.create_stuff(BI.additional_recipes.sand)
  end
  recipe = data.raw.recipe[BI.additional_recipes.sand.name]

  -- Adjust result
  recipe.result = "biotech-sand"
  BioInd.modified_msg("result", recipe)

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
