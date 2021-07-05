------------------------------------------------------------------------------------
--                        Game tweaks: Disassemble recipes                        --
--                    (BI.Settings.BI_Game_Tweaks_Disassemble)                    --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Disassemble"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')
--~ require("prototypes.optional.additional_recipes")

local ICONPATH = BioInd.iconpath

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

--~ BioInd.writeDebug("Enabling disassemble recipes!")
------------------------------------------------------------------------------------
--                                  Item subgroup                                 --
------------------------------------------------------------------------------------
--~ data:extend({BI.optional_misc.BI_Game_Tweaks_Disassemble.item_subgroup
--~ {
  --~ type = "item-subgroup",
  --~ name = "bio-disassemble",
  --~ group = "bio-industries",
  --~ order = "zzzz",
--~ },
--~ })
for m, m_data in pairs(BI.optional_misc[setting] or {}) do
  data:extend({m_data})
  --~ misc = data.raw[m_data.type][m_data.name]
  BioInd.created_msg(m_data)
end


------------------------------------------------------------------------------------
--                                     Recipes                                    --
------------------------------------------------------------------------------------
--~ -- Burner mining drill
--~ {
  --~ type = "recipe",
  --~ name = "bi-burner-mining-drill-disassemble",
  --~ localised_description = {"recipe-description.bi-disassemble-recipes"},
  --~ icon = ICONPATH .. "disassemble_burner-mining-drill.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ category = "advanced-crafting",
  --~ subgroup = "bio-disassemble",
  --~ order = "a[Disassemble]-a[bi-burner-mining-drill-disassemble]",
  --~ enabled = false,
  --~ allow_as_intermediate = false,
  --~ always_show_made_in = false,
  --~ allow_decomposition = false,
  --~ energy_required = 2,
  --~ ingredients = {
    --~ {type = "item", name = "burner-mining-drill", amount = 1},
  --~ },
  --~ results = {
    --~ {"stone", 4},
    --~ {"iron-plate", 4}
  --~ },
  --~ main_product = "",
  --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"automation-2"},
--~ },

--~ -- Burner inserter
--~ {
  --~ type = "recipe",
  --~ name = "bi-burner-inserter-disassemble",
  --~ localised_description = {"recipe-description.bi-disassemble-recipes"},
  --~ icon = ICONPATH .. "disassemble_burner_inserter.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ category = "advanced-crafting",
  --~ subgroup = "bio-disassemble",
  --~ order = "a[Disassemble]-b[bi-burner-inserter-disassemble]",
  --~ enabled = false,
  --~ allow_as_intermediate = false,
  --~ always_show_made_in = false,
  --~ allow_decomposition = false,
  --~ energy_required = 2,
  --~ ingredients = {
    --~ {type = "item", name = "burner-inserter", amount = 1},
  --~ },
  --~ results = {
    --~ {"iron-plate", 2},
  --~ },
  --~ main_product = "",
  --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"automation-2"},
--~ },

--~ -- Long-handed inserter
--~ {
  --~ type = "recipe",
  --~ name = "bi-long-handed-inserter-disassemble",
  --~ localised_description = {"recipe-description.bi-disassemble-recipes"},
  --~ icon = ICONPATH .. "disassemble_long_handed_inserter.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ category = "advanced-crafting",
  --~ subgroup = "bio-disassemble",
  --~ order = "a[Disassemble]-c[bi-long-handed-inserter-disassemble]",
  --~ enabled = false,
  --~ allow_as_intermediate = false,
  --~ always_show_made_in = false,
  --~ allow_decomposition = false,
  --~ energy_required = 2,
  --~ ingredients = {
    --~ {type = "item", name = "long-handed-inserter", amount = 1},
  --~ },
  --~ results = {
    --~ {"iron-gear-wheel", 1},
    --~ {"iron-plate", 1},
    --~ {"electronic-circuit", 1},
  --~ },
  --~ main_product = "",
  --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"automation-2"},
--~ },

--~ -- Stone furnace
--~ {
  --~ type = "recipe",
  --~ name = "bi-stone-furnace-disassemble",
  --~ localised_description = {"recipe-description.bi-disassemble-recipes"},
  --~ icon = ICONPATH .. "disassemble_stone_furnace.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ category = "advanced-crafting",
  --~ subgroup = "bio-disassemble",
  --~ order = "a[Disassemble]-d[bi-stone-furnace-disassemble]",
  --~ enabled = false,
  --~ allow_as_intermediate = false,
  --~ always_show_made_in = false,
  --~ allow_decomposition = false,
  --~ energy_required = 2,
  --~ ingredients = {
    --~ {type = "item", name = "stone-furnace", amount = 1},
  --~ },
  --~ results = {
    --~ {"stone", 3},
  --~ },
  --~ main_product = "",
  --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"automation-2"},
--~ },

--~ -- Steel furnace
--~ {
  --~ type = "recipe",
  --~ name = "bi-steel-furnace-disassemble",
  --~ localised_description = {"recipe-description.bi-disassemble-recipes"},
  --~ icon = ICONPATH .. "disassemble_steel-furnace.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ category = "advanced-crafting",
  --~ subgroup = "bio-disassemble",
  --~ order = "a[Disassemble]-e[bi-steel-furnace-disassemble]",
  --~ enabled = false,
  --~ allow_as_intermediate = false,
  --~ always_show_made_in = false,
  --~ allow_decomposition = false,
  --~ energy_required = 2,
  --~ ingredients = {
    --~ {type = "item", name = "steel-furnace", amount = 1},
  --~ },
  --~ results = {
    --~ {"steel-plate", 4},
    --~ {"stone-brick", 4}
  --~ },
  --~ main_product = "",
  --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"advanced-material-processing"},
--~ },
for r, r_data in pairs(BI.optional_recipes[setting]) do
  data:extend({r_data})
  --~ recipe = data.raw.recipe[r_data.name]
  BioInd.created_msg(r_data)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
