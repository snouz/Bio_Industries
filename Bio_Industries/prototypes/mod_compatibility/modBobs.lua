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


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath .. "mod_bobangels/"

local recipe
local items = data.raw.item
local recipes = data.raw.recipe

------------------------------------------------------------------------------------
--                      Alternative recipe for Wooden boards                      --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["wooden-board"] then
  --~ data:extend({BI.additional_recipes.press_wood})
  --~ BioInd.created_msg(BI.additional_recipes.press_wood)
  BioInd.create_stuff(BI.additional_recipes.press_wood)

  -- Exchange recipe icon
  if mods["ShinyBobGFX"] then
    BioInd.BI_change_icon(BI.additional_recipes.press_wood,
                          ICONPATH .. "bi_wooden_board_shiny.png")
  end
end

------------------------------------------------------------------------------------
--                 Create fertilizer recipe with Sodium hydroxide                 --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
recipe = BI.additional_recipes.fertilizer
if items["solid-sodium-hydroxide"] and
    not recipes[recipe.name] then
  --~ data:extend({recipe})
  --~ BioInd.created_msg(recipe)
  BioInd.create_stuff(recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
