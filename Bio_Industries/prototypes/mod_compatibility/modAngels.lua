------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "angelsbioprocessing",
  "angelspetrochem",
  "angelsrefining",
  "angelssmelting",
}) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
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
    (
      --~ (BI.additional_items.BI_Trigger_Wood_Charcoal_Create and
      --~ BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal and
      --~ items[BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal.name]) or
      --~ items["charcoal"]
      (BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal and
      BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal and
      items[BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal.name])
    ) and
    (
      --~ (BI.additional_items.BI_Trigger_Crushed_Stone_Create and
        --~ BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone and
        --~ items[BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone.name]) or
        --~ items["gravel"]
      (BI.additional_items.BI_Trigger_Crushed_Stone_Create and
        BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone and
        items[BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone.name])
    ) then

  -- "angelsbioprocessing" will move the unlock of "water-mineralized" from
  -- the "water-treatment" tech to "bio-processing-green", so we must move our recipe
  -- to the next tier of "water-treatment" to prevent dependency circles!
  if mods["angelsbioprocessing"] then
    BI.additional_recipes.mod_compatibility.sulfuric_waste.BI_add_to_tech = {"water-treatment-2"}
  end
  BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sulfuric_waste)

end

------------------------------------------------------------------------------------
--                         Sink for Ash and Crushed stone                         --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-saline"] and fluids["slag-slurry"] then
  BioInd.create_stuff(BI.additional_recipes.mod_compatibility.slag_slurry)
end

--~ ------------------------------------------------------------------------------------
--~ --             Add recipe for sand from crushed stone if there is sand            --
--~ ------------------------------------------------------------------------------------
--~ -- Angel's Smelting ("angelssmelting")
--~ if BI.Settings.BI_Stone_Crushing and items["solid-sand"] then
  --~ -- Make sure our sand recipe exists

  --~ recipe = recipes[BI.additional_recipes.mod_compatibility.sand.name] or
            --~ BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sand)[1]

  --~ if recipe then
    --~ -- Adjust result
    --~ recipe.result = "solid-sand"
    --~ recipe.result_count = 5
    --~ BioInd.debugging.modified_msg("result", recipe)

    --~ -- Adjust localization
    --~ recipe.localised_name = {"recipe-name.bi-sand", {"item-name.solid-sand"}}
    --~ BioInd.debugging.modified_msg("localization", recipe)
  --~ end
--~ end


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
BioInd.debugging.entered_file("leave")
