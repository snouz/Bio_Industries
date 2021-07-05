------------------------------------------------------------------------------------
--           Game tweaks: Alternative recipe for Production Science Pack          --
--                 (BI.Settings.BI_Game_Tweaks_Production_Science)                --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Production_Science"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')
require("prototypes.optional.additional_recipes")

local ICONPATH = BioInd.iconpath
local recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Add alternative Production Science Pack using Wooden rails instead of regular rails.
--~ -- This will only be created if "Krastorio 2" IS NOT active (new recipe would break the
--~ -- balance then).
--~ if not mods["Krastorio2"] then
  data:extend({BI.optional_recipes[setting].production_science_pack})
  --~ recipe = data.raw.recipe[BI.optional_recipes[setting].production_science_pack.name]
  BioInd.created_msg(BI.optional_recipes[setting].production_science_pack)
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
