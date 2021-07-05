------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "angelspetrochem",
  --~ "angelsbioprocessing",
  "angelsrefining"
}) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe
local items = data.raw.item
local fluids = data.raw.fluid
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
--                       Sink for Charcoal and Crushed stone                      --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-purified"] and
    fluids["water-yellow-waste"] and
    fluids["water-mineralized"] and
    BI.additional_items.BI_Coal_Processing and
      items[BI.additional_items.BI_Coal_Processing.wood_charcoal.name] and
     BI.additional_items.BI_Stone_Crushing and
      items[BI.additional_items.BI_Stone_Crushing.crushed_stone.name] then

  BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sulfuric_waste)
end

------------------------------------------------------------------------------------
--                         Sink for Ash and Crushed stone                         --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-saline"] and fluids["slag-slurry"] then
  BioInd.create_stuff(BI.additional_recipes.mod_compatibility.slag_slurry)
end

------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if BI.Settings.BI_Stone_Crushing and items["solid-sand"] then
  -- Make sure our sand recipe exists
  if not recipes[BI.additional_recipes.mod_compatibility.sand.name] then
    recipe = BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sand)[1]
  end
  --~ recipe = data.raw.recipe[BI.additional_recipes.sand.name]

  -- Adjust result
  if recipe then
    recipe.result = "solid-sand"
    BioInd.modified_msg("result", BI.additional_recipes.mod_compatibility.sand)
  end
  -- MOVED TO DATA-UPDATES.LUA!
  --~ -- Use alternative descriptions for stone crusher!
  --~ BioInd.writeDebug("Using alternative descriptions for \"bi-stone-crusher\"!")
  --~ for _, t in ipairs({"furnace", "item", "recipe"}) do
    --~ data.raw[t]["bi-stone-crusher"].localised_description =
      --~ {"entity-description.bi-stone-crusher-sand"}
  --~ end
end


------------------------------------------------------------------------------------
--                 Create fertilizer recipe with Sodium hydroxide                 --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if items["solid-sodium-hydroxide"] and
    not recipes[BI.additional_recipes.mod_compatibility.fertilizer_2.name] then
  BioInd.create_stuff(BI.additional_recipes.mod_compatibility.fertilizer_2)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
