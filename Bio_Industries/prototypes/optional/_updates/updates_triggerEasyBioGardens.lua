------------------------------------------------------------------------------------
--                            Trigger: Easy Bio gardens                           --
--                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
------------------------------------------------------------------------------------
--~ local setting = "BI_Game_Tweaks_Easy_Bio_Gardens"
--~ if not BI.Settings[setting] then
  --~ BioInd.nothing_to_do("*")
  --~ return
--~ else
  --~ BioInd.entered_file()
--~ end
local trigger = "BI_Trigger_Easy_Bio_Gardens"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local fluids = data.raw.fluid
local techs = data.raw.technology
local recipe, fluid, tech, name


------------------------------------------------------------------------------------
--    Replace fertilizers + water with fertilizer fluids in Bio garden recipes    --
------------------------------------------------------------------------------------
for i, ingredient in pairs({"fertilizer", "bi-adv-fertilizer"}) do
  --~ recipe = recipes["bi-purified-air-" .. i]
  recipe = recipes[BI.additional_recipes.BI_Bio_Garden["purified_air_" .. i].name]
  --~ local f_item = tostring(r == 1 and "" or "bi-adv-") .. "fertilizer"
  --~ fluid = fluids[f_item .. "-fluid"]
  fluid = fluids[(i == 1 and "bi-" or "") .. ingredient .. "-fluid"]

  if recipe and fluid then
    -- Change recipe ingredients
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, f_item)
    thxbob.lib.recipe.remove_ingredient(recipe.name, ingredient)
    thxbob.lib.recipe.remove_ingredient(recipe.name, "water")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "fluid",
      name = fluid.name,
      amount = 50
    })
    BioInd.modified_msg("ingredients", recipe)

    -- Change recipe localization
    recipe.localised_description = {
      "recipe-description." .. recipe.name .. "-fluid",
      {"fluid-name." .. fluid.name},
    }
BioInd.show("Fluid recipe description", recipe.localised_description)
    BioInd.modified_msg("localization", recipe)
  end
end


--~ ------------------------------------------------------------------------------------
--~ --                          Change localization of techs                          --
--~ ------------------------------------------------------------------------------------
--~ for n, name in ipairs({"fertilizer", "advanced_fertilizer"}) do
  --~ tech = techs[BI.default_techs[name].name]

  --~ if tech then
    --~ tech.localised_name = {"technology-name." .. tech.name .. "-easy"}
    --~ BioInd.modified_msg("localization", tech)
  --~ end
--~ end

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
