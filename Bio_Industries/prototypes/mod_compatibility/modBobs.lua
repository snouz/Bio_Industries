------------------------------------------------------------------------------------
--                                   Bob's mods                                   --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  --~ "bobpower",
  "bobelectronics",
  --~ "bobplates",
}) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
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
  BioInd.create_stuff(BI.additional_recipes.mod_compatibility.press_wood)

  -- Exchange recipe icon
  if mods["ShinyBobGFX"] then
    BioInd.BI_change_icon(BI.additional_recipes.mod_compatibility.press_wood,
                          ICONPATH .. "bi_wooden_board_shiny.png")
  end
end

------------------------------------------------------------------------------------
--                 Create fertilizer recipe with Sodium hydroxide                 --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
recipe = BI.additional_recipes.mod_compatibility.fertilizer_2
if items["solid-sodium-hydroxide"] and not recipes[recipe.name] then
  BioInd.create_stuff(recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
