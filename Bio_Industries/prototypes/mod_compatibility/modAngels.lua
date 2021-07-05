------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
--~ BI.writeDebug(BI.entered_msg, {debug.getinfo(1).source})

if not BI.check_mods({
  "angelspetrochem",
  --~ "angelsbioprocessing",
  "angelsrefining"
}) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
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
    fluids["water-mineralized"] then

  BioInd.create_stuff(BI.additional_recipes.sulfuric_waste)
end

------------------------------------------------------------------------------------
--                         Sink for Ash and Crushed stone                         --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-saline"] and fluids["slag-slurry"] then
  BioInd.create_stuff(BI.additional_recipes.slag_slurry)
end

------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if items["solid-sand"] then
  -- Make sure our sand recipe exists
  if not recipes[BI.additional_recipes.sand.name] then
    recipe = BioInd.create_stuff(BI.additional_recipes.sand)[1]
  end
  --~ recipe = data.raw.recipe[BI.additional_recipes.sand.name]

  -- Adjust result
  if recipe then
    recipe.result = "solid-sand"
    BioInd.modified_msg("result", BI.additional_recipes.sand)
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
    not recipes[BI.additional_recipes.fertilizer.name] then
  BioInd.create_stuff(BI.additional_recipes.fertilizer)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
