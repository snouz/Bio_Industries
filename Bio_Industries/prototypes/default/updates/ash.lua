BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
--             If there is no item "ash", create our own ash instead!             --
------------------------------------------------------------------------------------
--~ if not items["ash"] then
  --~ BioInd.create_stuff(BI.additional_items.ash)
--~ end
if items["ash"] then
  BioInd.nothing_to_do()
else
  BioInd.create_stuff(BI.additional_items.ash)
end


--~ ------------------------------------------------------------------------------------
--~ --                   Replace "bi-ash" with "ash" in all recipes!                  --
--~ ------------------------------------------------------------------------------------
--~ if not items[bi_ash] then

  --~ thxbob.lib.recipe.replace_ingredient_in_all(BI.additional_items.ash, "ash")
--~ BioInd.writeDebug("Replaced ingredient \"%s\" with \"ash\" in all recipes", {BI.additional_items.ash.name})
  --~ thxbob.lib.recipe.replace_result_in_all(BI.additional_items.ash, "ash")
--~ BioInd.writeDebug("Replaced result \"%s\" with \"ash\" in all recipes", {BI.additional_items.ash.name})

--~ end

--~ BioInd.show("recipes[BI.default_recipes.ash_1.name]", recipes[BI.default_recipes.ash_1.name])
--~ error("Test!")
------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
