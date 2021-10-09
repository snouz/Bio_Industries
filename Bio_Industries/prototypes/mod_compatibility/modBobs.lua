------------------------------------------------------------------------------------
--                                   Bob's mods                                   --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "bobelectronics",
  "bobplates",
}) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
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
-- Bob's Electronics mod ("bobelectronics")
if items["wooden-board"] then
  recipe = BI.additional_recipes.mod_compatibility.press_wood
  BioInd.create_stuff(recipe)

  -- Exchange recipe icon
  if mods["ShinyBobGFX"] or mods["ShinyBobGFX_Continued"] then
    BioInd.BI_change_icon(data.raw.recipe[recipe.name],
                          ICONPATH .. "bi_wooden_board_shiny.png")
  end
end

------------------------------------------------------------------------------------
--                 Create fertilizer recipe with Sodium hydroxide                 --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
recipe = BI.additional_recipes.mod_compatibility.fertilizer_2
if items["sodium-hydroxide"] and not recipes[recipe.name] then
  BioInd.create_stuff(recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
