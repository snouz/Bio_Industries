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

local BioInd = require('common')('Bio_Industries')

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
-- Krastorio² needs much more wood than usually provided by Bio Industries. If Krastorio² is
-- active, BI should produce much more wood/wood pulp. For better baĺancing, our recipes should
-- also be changed to require more wood/wood pulp as ingredients.
-- Recipes for making wood should also use/produce more seeds, seedlings, and water. It shouldn't
-- be necessary to increase the input of ash and fertilizer in these recipes as they already
-- require more wood/wood pulp.
------------------------------------------------------------------------------------
local update = {
  "wood", "bi-woodpulp",
  "bi-seed", "seedling", "water",
}

for _, recipe in pairs(data.raw.recipe) do
  BioInd.writeDebug("Recipe has \"mod\" property: %s", {recipe.mod and true or false})
  if recipe.mod == "Bio_Industries" then
    -- Adjust ingredients
    krastorio.recipes.multiplyIngredients(recipe.name, update, 4)
    --~ BioInd.writeDebug("Changed ingredients for %s: %s",
                      --~ {recipe and recipe.name or "nil", recipe and recipe.ingredients or "nil"})
    BioInd.modified_msg("ingredients", recipe)

    -- Adjust results
    krastorio.recipes.multiplyProducts(recipe.name, update, 4)
    --~ BioInd.writeDebug("Changed results for %s: %s",
                      --~ {recipe and recipe.name or "nil", recipe and recipe.results or "nil"})
    BioInd.modified_msg("results", recipe)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
