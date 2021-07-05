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

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath

local recipe, fluid
local recipes = data.raw.recipe
local fluids = data.raw.fluid


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ ------------------------------------------------------------------------------------
--~ --                      Create fluid fertilizers and recipes!                     --
--~ ------------------------------------------------------------------------------------
--~ local function make_colors(color)
  --~ local r, g, b = color.r, color.g, color.b
  --~ local black = {r = 0, g = 0, b = 0, a = .25}

  --~ local function mult(v, f)
    --~ return (v * f) % 1
  --~ end

  --~ ret = {
    --~ base = color,
    --~ flow = {r = mult(r, 3), g = mult(g, 3), b = mult(b, 3), a = .25},
    --~ primary = {r = r, g = g, b = b, a = .5},
    --~ secondary = {r = mult(r, .5), g = mult(g, .5), b = mult(b, .5), a = .25},
    --~ tertiary = {r = mult(r, 2), g = mult(g, 2), b = mult(b, 2), a = .25},
    --~ secondary = black,
  --~ }
  --~ return ret
--~ end

--~ local fertilizer_fluid_colors = make_colors({r = 0.098, g = 0.811, b = 0.269, a = .5})
--~ local adv_fertilizer_fluid_colors = make_colors({r = 0, g = 1, b = 0.071, a = .5})

--~ data:extend({
  --~ ------------------------------------------------------------------------------------
  --~ --                                     FLUIDS                                     --
  --~ ------------------------------------------------------------------------------------

  --~ -- Fertilizer fluid
  --~ {
    --~ type = "fluid",
    --~ name = "bi-fertilizer-fluid",
    --~ icon = ICONPATH .. "fluid_fertilizer_64.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ default_temperature = 25,
    --~ max_temperature = 100,
    --~ heat_capacity = "1KJ",
    -- base_color = {r = 0.478, g = 0.341, b = 0.118},
    --~ -- 19cf44
    -- base_color = {r = 0.098, g = 0.811, b = 0.269},
    --~ base_color = fertilizer_fluid_colors.base,
    -- flow_color = {r = 0, g = 0, b = 0},
    --~ flow_color = fertilizer_fluid_colors.flow,
    --~ pressure_to_speed_ratio = 0.4,
    --~ flow_to_energy_ratio = 0.59,
    --~ order = "a[fluid]-b[fertilizer]"
  --~ },

  --~ -- Advanced fertilizer fluid
  --~ {
    --~ type = "fluid",
    --~ name = "bi-adv-fertilizer-fluid",
    --~ icon = ICONPATH .. "fluid_advanced_fertilizer_64.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ default_temperature = 25,
    --~ max_temperature = 100,
    --~ heat_capacity = "1KJ",
    --~ --00ff12
    -- base_color = {r = 0.465, g = 0.306, b = 0.272},
    -- base_color = {r = 0, g = 1, b = 0.071},
    --~ base_color = adv_fertilizer_fluid_colors.base,
    -- flow_color = {r = 0, g = 0, b = 0},
    --~ flow_color = adv_fertilizer_fluid_colors.flow,
    --~ pressure_to_speed_ratio = 0.4,
    --~ flow_to_energy_ratio = 0.59,
    --~ order = "a[fluid]-b[fertilizer-advanced]"
  --~ },


  --~ ------------------------------------------------------------------------------------
  --~ --                                     RECIPES                                    --
  --~ ------------------------------------------------------------------------------------

  --~ -- Fertilizer fluid
  --~ {
    --~ type = "recipe",
    --~ name = "bi-fertilizer-fluid",
    --~ icon = ICONPATH .. "fluid_fertilizer_64.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ category = "chemistry",
    --~ energy_required = 5,
    --~ ingredients = {
      --~ {type = "item", name = "fertilizer", amount = 3},
      --~ {type = "fluid", name = "water", amount = 100},
    --~ },
    --~ results = {
      --~ {type = "fluid", name = "bi-fertilizer-fluid", amount = 100}
    --~ },
    --~ main_product = "",
    --~ enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    --~ subgroup = "bio-bio-farm-intermediate-product",
    --~ order = "b[bi-fertilizer]-b[bi-fertilizer-fluid-1]",
    --~ crafting_machine_tint = {
      --~ -- Kettle
      --~ primary = fertilizer_fluid_colors.primary,
      --~ secondary = fertilizer_fluid_colors.secondary,
      --~ -- Chimney
      --~ tertiary = fertilizer_fluid_colors.tertiary,
      --~ quaternary = fertilizer_fluid_colors.quaternary,
    --~ },
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-fertilizer"},
  --~ },

  --~ -- Advanced fertilizer fluid
  --~ {
    --~ type = "recipe",
    --~ name = "bi-adv-fertilizer-fluid",
    --~ icon = ICONPATH .. "fluid_advanced_fertilizer_64.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ category = "chemistry",
    --~ energy_required = 5,
    --~ ingredients = {
      --~ {type = "item", name = "bi-adv-fertilizer", amount = 3},
      --~ {type = "fluid", name = "water", amount = 100},
    --~ },
    --~ results = {
      --~ {type = "fluid", name = "bi-adv-fertilizer-fluid", amount = 100}
    --~ },
    --~ main_product = "",
    --~ enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    --~ subgroup = "bio-bio-farm-intermediate-product",
    --~ order = "b[bi-fertilizer]-b[bi-fertilizer-fluid-2]",
    --~ crafting_machine_tint = {
      --~ primary = adv_fertilizer_fluid_colors.primary,
      --~ secondary = adv_fertilizer_fluid_colors.secondary,
      --~ -- Chimney
      --~ tertiary = adv_fertilizer_fluid_colors.tertiary,
      --~ quaternary = adv_fertilizer_fluid_colors.quaternary,
    --~ },
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-advanced-fertilizers"},
  --~ },
--~ })

--~ ------------------------------------------------------------------------------------
--~ --                                     UNLOCKS                                    --
--~ ------------------------------------------------------------------------------------
--~ BioInd.writeDebug("Unlocking fluid fertilizers!")
--~ thxbob.lib.tech.add_recipe_unlock ("bi-tech-fertilizer", "bi-fertilizer-fluid")
-- thxbob.lib.tech.add_recipe_unlock ("bi-tech-advanced-biotechnology", "bi-adv-fertilizer-fluid")
--~ thxbob.lib.tech.add_recipe_unlock ("bi-tech-advanced-fertilizers", "bi-adv-fertilizer-fluid")



------------------------------------------------------------------------------------
--     Replace fertilizers with fluid fertilizers in air-purification recipes     --
------------------------------------------------------------------------------------
--~ -- Purified air (fertilizer)
--~ recipe = recipes["bi-purified-air-1"]
--~ fluid = fluids["bi-fertilizer-fluid"]

--~ if recipe and fluid then
  --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "fertilizer")
  --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "water")
  --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    --~ type = "fluid",
    --~ -- name = "bi-fertilizer-fluid",
    --~ name = fluid.name,
    --~ amount = 50
  --~ })
  --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})

  --~ recipe.localised_description = {"recipe-description.bi-purified-air-1-fluid"}
  --~ BioInd.writeDebug("Changed localization of recipe \"%s\"", {recipe.name})
--~ end


--~ -- Purified air (advanced fertilizer)
--~ recipe = recipes["bi-purified-air-2"]
--~ fluid = fluids["bi-adv-fertilizer-fluid"]

--~ if recipe and fluid then
  --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "bi-adv-fertilizer")
  --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "water")
  --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    --~ type = "fluid",
    --~ -- name = "bi-adv-fertilizer-fluid",
    --~ name = fluid.name,
    --~ amount = 50
  --~ })
  --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})

  --~ recipe.localised_description = {"recipe-description.bi-purified-air-2-fluid"}
  --~ BioInd.writeDebug("Changed localization of recipe \"%s\"", {recipe.name})
--~ end


for r, ingredient in pairs({"fertilizer", "bi-adv-fertilizer"}) do
  recipe = recipes["bi-purified-air-" .. r]
  local f_item = "bi-" .. tostring(r == 1 and "" or "adv-") .. "fertilizer"

  --~ fluid = fluids["bi-" .. tostring(r == 1 and "" or "adv-") .. "fertilizer-fluid"]
  fluid = fluids[f_item .. "-fluid"]

  if recipe and fluid then
    thxbob.lib.recipe.remove_ingredient(recipe.name, f_item)
    thxbob.lib.recipe.remove_ingredient(recipe.name, "water")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "fluid",
      --~ name = "bi-fertilizer-fluid",
      name = fluid.name,
      amount = 50
    })
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\".", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)

    recipe.localised_description = {"recipe-description." .. recipe.name .. "-fluid"}
    --~ BioInd.writeDebug("Changed localization of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("localization", recipe)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
