------------------------------------------------------------------------------------
--           Data for categories, groups etc. that depend on a setting.           --
------------------------------------------------------------------------------------
BI.entered_file()

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath

BI.optional_misc = BI.optional_misc or {}

for s, setting in pairs({
  --~ "BI_Game_Tweaks_Easy_Bio_Gardens",
  --~ "BI_Game_Tweaks_Production_Science",
  "BI_Game_Tweaks_Disassemble",
}) do
  BI.optional_misc[setting] = BI.optional_misc[setting] or {}
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--                        Game tweaks: Disassemble recipes                        --
--                    (BI.Settings.BI_Game_Tweaks_Disassemble)                    --
------------------------------------------------------------------------------------
-- Item subgroup
BI.optional_misc.BI_Game_Tweaks_Disassemble.item_subgroup = {
  type = "item-subgroup",
  name = "bio-disassemble",
  group = "bio-industries",
  order = "zzzz",
}


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
