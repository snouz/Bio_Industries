------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Fuel"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                      Add ingredients to fertilizer recipes                     --
------------------------------------------------------------------------------------
if not BI.Settings.BI_Bio_Fuel then

  -- Common fertilizer
  recipe = recipes["bi-adv-fertilizer-1"]
  if recipe then
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "fertilizer",
      amount = 50
    })
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end

  -- Advanced fertilizer
  recipe = recipes["bi-adv-fertilizer-2"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient("bi-adv-fertilizer-2", "fertilizer")
    thxbob.lib.recipe.add_new_ingredient("bi-adv-fertilizer-2", {
      type = "item",
      name = "fertilizer",
      amount = 30
    })
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end

end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
