------------------------------------------------------------------------------------
--                            Enable: Easy Bio gardens                            --
--                  (BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens)                 --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Easy_Bio_Gardens"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--    Replace fertilizers + water with fertilizer fluids in Bio garden recipes    --
------------------------------------------------------------------------------------
local recipe, fluid
local recipes = data.raw.recipe
local fluids = data.raw.fluid


for r, ingredient in pairs({"fertilizer", "bi-adv-fertilizer"}) do
  recipe = recipes["bi-purified-air-" .. r]
  local f_item = "bi-" .. tostring(r == 1 and "" or "adv-") .. "fertilizer"

  fluid = fluids[f_item .. "-fluid"]

  if recipe and fluid then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, f_item)
    thxbob.lib.recipe.remove_ingredient(recipe.name, "water")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "fluid",
      name = fluid.name,
      amount = 50
    })
    BioInd.modified_msg("ingredients", recipe)

    -- Change localization
    recipe.localised_description = {"recipe-description." .. recipe.name .. "-fluid"}
    BioInd.modified_msg("localization", recipe)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
