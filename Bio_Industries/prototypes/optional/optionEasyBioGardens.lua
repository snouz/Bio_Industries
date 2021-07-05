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

--~ require("prototypes.optional.additional_fluids")
--~ require("prototypes.optional.additional_recipes")

local fluid, recipe
local fluids = data.raw.fluid
local recipes = data.raw.recipe

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                  Make colors!                                  --
------------------------------------------------------------------------------------
local function make_colors(color)
  local r, g, b = color.r, color.g, color.b
  local black = {r = 0, g = 0, b = 0, a = .25}

  local function mult(v, f)
    return (v * f) % 1
  end

  ret = {
    base = color,
    flow = {r = mult(r, 3), g = mult(g, 3), b = mult(b, 3), a = .25},
    primary = {r = r, g = g, b = b, a = .5},
    secondary = {r = mult(r, .5), g = mult(g, .5), b = mult(b, .5), a = .25},
    tertiary = {r = mult(r, 2), g = mult(g, 2), b = mult(b, 2), a = .25},
    secondary = black,
  }
  return ret
end

local fertilizer_fluid_colors = make_colors({r = 0.098, g = 0.811, b = 0.269, a = .5})
local adv_fertilizer_fluid_colors = make_colors({r = 0, g = 1, b = 0.071, a = .5})

------------------------------------------------------------------------------------
--                            Create fluid fertilizers                            --
------------------------------------------------------------------------------------

--~ data:extend({
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

-- Fertilizer fluid
--~ data:extend({BI.additional_fluids.fertilizer_fluid})
--~ fluid = fluids[BI.additional_fluids.fertilizer_fluid.name]
data:extend({BI.optional_fluids[setting].fertilizer_fluid})
fluid = fluids[BI.optional_fluids[setting].fertilizer_fluid.name]
--~ BioInd.writeDebug("Created fluid \"%s\"!", {fluid.name})
BioInd.created_msg(fluid)

fluid.base_color = fertilizer_fluid_colors.base
fluid.flow_color = fertilizer_fluid_colors.flow
--~ BioInd.writeDebug("Changed colors of fluid \"%s\".", {fluid.name})
BioInd.modified_msg("colors", fluid)

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

-- Advanced fertilizer fluid
--~ data:extend({BI.additional_fluids.adv_fertilizer_fluid})
--~ fluid = fluids[BI.additional_fluids.adv_fertilizer_fluid.name]
data:extend({BI.optional_fluids[setting].adv_fertilizer_fluid})
fluid = fluids[BI.optional_fluids[setting].adv_fertilizer_fluid.name]
--~ BioInd.writeDebug("Created fluid \"%s\"!", {fluid.name})
BioInd.created_msg(fluid)

fluid.base_color = adv_fertilizer_fluid_colors.base
fluid.flow_color = adv_fertilizer_fluid_colors.flow
--~ BioInd.writeDebug("Changed colors of fluid \"%s\".", {fluid.name})
BioInd.modified_msg("colors", fluid)




------------------------------------------------------------------------------------
--                      Create recipes for fluid fertilizers                      --
------------------------------------------------------------------------------------

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


-- Fertilizer fluid
data:extend({BI.optional_recipes[setting].fertilizer_fluid})
--~ recipe = recipes[BI.additional_recipes.optional.fertilizer_fluid.name]
recipe = recipes[BI.optional_recipes[setting].fertilizer_fluid.name]
--~ BioInd.writeDebug("Created recipe for \"%s\"!", {recipe.name})
BioInd.created_msg(recipe)

recipe.crafting_machine_tint = {
  -- Kettle
  primary = fertilizer_fluid_colors.primary,
  secondary = fertilizer_fluid_colors.secondary,
  -- Chimney
  tertiary = fertilizer_fluid_colors.tertiary,
  quaternary = fertilizer_fluid_colors.quaternary,
}
--~ BioInd.writeDebug("Changed crafting_machine_tint of recipe \"%s\".", {recipe.name})
BioInd.modified_msg("crafting_machine_tint", recipe)

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


-- Fertilizer fluid
data:extend({BI.optional_recipes[setting].adv_fertilizer_fluid})
recipe = recipes[BI.optional_recipes[setting].adv_fertilizer_fluid.name]
--~ BioInd.writeDebug("Created recipe for \"%s\"!", {recipe.name})
BioInd.created_msg(recipe)

recipe.crafting_machine_tint = {
  -- Kettle
  primary = fertilizer_fluid_colors.primary,
  secondary = fertilizer_fluid_colors.secondary,
  -- Chimney
  tertiary = fertilizer_fluid_colors.tertiary,
  quaternary = fertilizer_fluid_colors.quaternary,
}
--~ BioInd.writeDebug("Changed crafting_machine_tint of recipe \"%s\".", {recipe.name})
BioInd.modified_msg("crafting_machine_tint", recipe)


-- OBSOLETE -- UNLOCKS ARE DEFINED IN THE RECIPES!vg
--~ ------------------------------------------------------------------------------------
--~ --                                     UNLOCKS                                    --
--~ ------------------------------------------------------------------------------------
--~ BioInd.writeDebug("Unlocking fluid fertilizers!")
--~ thxbob.lib.tech.add_recipe_unlock ("bi-tech-fertilizer", "bi-fertilizer-fluid")
-- thxbob.lib.tech.add_recipe_unlock ("bi-tech-advanced-biotechnology", "bi-adv-fertilizer-fluid")
--~ thxbob.lib.tech.add_recipe_unlock ("bi-tech-advanced-fertilizers", "bi-adv-fertilizer-fluid")


-- MOVED TO UPDATES!
--~ ------------------------------------------------------------------------------------
--~ --                                 CHANGE RECIPES                                 --
--~ ------------------------------------------------------------------------------------
--~ -- Purified air (fertilizer)
--~ thxbob.lib.recipe.remove_ingredient("bi-purified-air-1", "fertilizer")
--~ thxbob.lib.recipe.remove_ingredient("bi-purified-air-1", "water")
--~ thxbob.lib.recipe.add_new_ingredient("bi-purified-air-1", {
  --~ type = "fluid",
  --~ name = "bi-fertilizer-fluid",
  --~ amount = 50
--~ })
--~ data.raw.recipe["bi-purified-air-1"].localised_description = {"recipe-description.bi-purified-air-1-fluid"}

--~ -- Purified air (advanced fertilizer)
--~ thxbob.lib.recipe.remove_ingredient("bi-purified-air-2", "bi-adv-fertilizer")
--~ thxbob.lib.recipe.remove_ingredient("bi-purified-air-2", "water")
--~ thxbob.lib.recipe.add_new_ingredient("bi-purified-air-2", {
  --~ type = "fluid",
  --~ name = "bi-adv-fertilizer-fluid",
  --~ amount = 50
--~ })
--~ data.raw.recipe["bi-purified-air-2"].localised_description = {"recipe-description.bi-purified-air-2-fluid"}

--~ ------------------------------------------------------------------------------------
--~ --                                      Create fluids                                 --
--~ ------------------------------------------------------------------------------------
--~ for f, f_data in pairs(BI.optional_fluids[setting]) do
  --~ data:extend({fluid})
  --~ fluid = data.raw.fluid[f_data.name]
  --~ BioInd.created_msg(fluid)
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
