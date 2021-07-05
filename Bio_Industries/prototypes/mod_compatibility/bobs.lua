------------------------------------------------------------------------------------
--                                   Bob's mods                                   --
------------------------------------------------------------------------------------
--~ BI.writeDebug(BI.entered_msg, {debug.getinfo(1).source})

if not BI.check_mods({
  --~ "bobpower",
  "bobelectronics",
  --~ "bobplates",
}) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')
require('prototypes.mod_compatibility.additional_recipes')

local ICONPATH = BioInd.iconpath .. "mod_bobangels/"

local recipe
local items = data.raw.item

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--                      Alternative recipe for Wooden boards                      --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["wooden-board"] then
  --~ recipe = {
    --~ -- Wood - Press Wood
    --~ type = "recipe",
    --~ name = "bi-press-wood",
    --~ localised_name = {"recipe-name.bi-press-wood"},
    --~ icon = ICONPATH .. "mod_bobangels/bi_wooden_board.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ BI_add_to_tech = {"electronics"},
    --~ subgroup = "bob-boards",
    --~ order = "c-a1[wooden-board]",
    --~ category = "electronics",
    --~ energy_required = 1,
    --~ enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    --~ ingredients = {
      --~ {type = "item", name = "bi-woodpulp", amount = 3},
      --~ {type = "item", name = "resin", amount = 1},
    --~ },
    --~ results = {
      --~ {type = "item", name = "wooden-board", amount = 6}
    --~ },
    --~ -- This is a custom property for use by "Krastorio 2" (it will change
    --~ -- ingredients/results; used for wood/wood pulp)
    --~ mod = "Bio_Industries",
  --~ }

  --~ data:extend({recipe})
  --~ thxbob.lib.tech.add_recipe_unlock("electronics", "bi-press-wood")
  data:extend({BI.additional_recipes.press_wood})
  BioInd.created_msg(BI.additional_recipes.press_wood)

  -- Exchange recipe icon
  if mods["ShinyBobGFX"] then
    --~ recipe = data.raw.recipe[BI.additional_recipes.press_wood]
    --~ recipe.icon = ICONPATH .. "mod_bobangels/bi_wooden_board_shiny.png"
    --~ recipe.icon_size = 64
    BioInd.BI_change_icon(BI.additional_recipes.press_wood,
                          ICONPATH .. "bi_wooden_board_shiny.png")
  end
end

------------------------------------------------------------------------------------
--                 Create fertilizer recipe with Sodium hydroxide                 --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["solid-sodium-hydroxide"] and
    not data.raw.recipe[BI.additional_recipes.fertilizer.name] then
  data:extend({BI.additional_recipes.fertilizer})
  --~ BioInd.writeDebug("Created recipe %s", {BI.additional_recipes.fertilizer.name})
  BioInd.created_msg(BI.additional_recipes.fertilizer)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
