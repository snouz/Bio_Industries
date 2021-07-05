------------------------------------------------------------------------------------
--                                 Simple Silicon                                 --
------------------------------------------------------------------------------------
local mod_name = "SimpleSilicon"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- If Simple Silicon is active, add solar cell to Musk floor (solar mat) recipe
recipe = data.raw.recipe["bi-solar-mat"]
if recipe then
  thxbob.lib.recipe.add_new_ingredient(recipe, {
    type = "item",
    name = "SiSi-solar-cell",
    amount = 1
  })
  --~ BioInd.writeDebug("Added \"SiSi-solar-cell\" to ingredients of Musk floor!")
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
