BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
--                   Replace "bi-ash" with "ash" in all recipes!                  --
------------------------------------------------------------------------------------
--~ if items["ash"] and not items[BI.additional_items.ash.name] then
if items["ash"] then

  -- Ingredients
  thxbob.lib.recipe.replace_ingredient_in_all(BI.additional_items.ash, "ash")
  BioInd.writeDebug("Replaced ingredient \"%s\" with \"ash\" in all recipes",
                    {BI.additional_items.ash.name})

  -- Results
  thxbob.lib.recipe.replace_result_in_all(BI.additional_items.ash, "ash")
  BioInd.writeDebug("Replaced result \"%s\" with \"ash\" in all recipes",
                    {BI.additional_items.ash.name})

end

-- snouz -- replace all recipe icons with the final icon for ash
if data.raw.recipe["bi-seed-2"] then data.raw.recipe["bi-seed-2"].icons = BioInd.make_icons({it1 = "seed", it2 = "ash", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}) end
if data.raw.recipe["bi-seedling-2"] then data.raw.recipe["bi-seedling-2"].icons = BioInd.make_icons({it1 = "seedling", it2 = "ash", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}) end
if data.raw.recipe["bi-logs-2"] then 
  data.raw.recipe["bi-logs-2"].icons = BioInd.make_icons({it1 = "woodpulp", it2 = "ash", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0})
  data.raw.recipe["bi-logs-2"].icons[1].icon = BioInd.iconpath .. "wood_woodpulp.png"
end
if data.raw.recipe["bi-ash-1"] then data.raw.recipe["bi-ash-1"].icons = BioInd.make_icons({it1 = "ash", it2 = "woodpulp", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}) end
if data.raw.recipe["bi-ash-2"] then data.raw.recipe["bi-ash-2"].icons = BioInd.make_icons({it1 = "ash", it2 = "wood", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}) end
if data.raw.recipe["bi-stone-brick"] then data.raw.recipe["bi-stone-brick"].icons = BioInd.make_icons({it1 = "stone-brick", it2 = "ash", it3 = "crushed-stone", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}) end
if data.raw.recipe["bi-biomass-3"] then
  if data.raw.item.ash then data.raw.recipe["bi-biomass-3"].icons[3].icon = data.raw.item.ash.icon end
  if data.raw.item["bi-ash"] then data.raw.recipe["bi-biomass-3"].icons[3].icon = data.raw.item["bi-ash"].icon end
end
if data.raw.recipe["bi-sulfur"] then data.raw.recipe["bi-sulfur"].icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}) end


--~ BioInd.show("recipes[BI.default_recipes.ash_1.name]", recipes[BI.default_recipes.ash_1.name])

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
