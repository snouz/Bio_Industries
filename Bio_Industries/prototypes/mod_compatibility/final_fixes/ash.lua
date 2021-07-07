BioInd.entered_file()

--- @SNOUZ: This file is not about icon updates, but about replacing the ash
-- item in recipe ingredients/results!

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


--~ BioInd.show("recipes[BI.default_recipes.ash_1.name]", recipes[BI.default_recipes.ash_1.name])

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
