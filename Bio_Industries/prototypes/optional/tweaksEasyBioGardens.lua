------------------------------------------------------------------------------------
--                          Game tweaks: Easy Bio gardens                         --
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


local fluid, recipe
local fluids = data.raw.fluid
local recipes = data.raw.recipe


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
-- Fertilizer fluid
fluid = BioInd.create_stuff(BI.additional_fluids[setting].fertilizer_fluid)[1]

if fluid then
  fluid.base_color = fertilizer_fluid_colors.base
  fluid.flow_color = fertilizer_fluid_colors.flow
  BioInd.modified_msg("colors", fluid)
end

-- Advanced fertilizer fluid
fluid = BioInd.create_stuff(BI.additional_fluids[setting].adv_fertilizer_fluid)[1]

if fluid then
  fluid.base_color = adv_fertilizer_fluid_colors.base
  fluid.flow_color = adv_fertilizer_fluid_colors.flow
  BioInd.modified_msg("colors", fluid)
end

------------------------------------------------------------------------------------
--                      Create recipes for fluid fertilizers                      --
------------------------------------------------------------------------------------
-- Fertilizer fluid
recipe = BioInd.create_stuff(BI.additional_recipes[setting].fertilizer_fluid)[1]

if recipe then
  recipe.crafting_machine_tint = {
    -- Kettle
    primary = fertilizer_fluid_colors.primary,
    secondary = fertilizer_fluid_colors.secondary,
    -- Chimney
    tertiary = fertilizer_fluid_colors.tertiary,
    quaternary = fertilizer_fluid_colors.quaternary,
  }
  BioInd.modified_msg("crafting_machine_tint", recipe)
end

-- Advanced fertilizer fluid
recipe = BioInd.create_stuff(BI.additional_recipes[setting].adv_fertilizer_fluid)[1]

if recipe then
  recipe.crafting_machine_tint = {
    -- Kettle
    primary = fertilizer_fluid_colors.primary,
    secondary = fertilizer_fluid_colors.secondary,
    -- Chimney
    tertiary = fertilizer_fluid_colors.tertiary,
    quaternary = fertilizer_fluid_colors.quaternary,
  }
  BioInd.modified_msg("crafting_machine_tint", recipe)
end


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


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
