------------------------------------------------------------------------------------
--                            Trigger: Easy Bio gardens                           --
--                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
------------------------------------------------------------------------------------
-- Settings: BI.Settings.BI_Bio_Garden and BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens
local trigger = "BI_Trigger_Easy_Bio_Gardens"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local fluid, recipe
local fluids = data.raw.fluid
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
--                                  Make colors!                                  --
------------------------------------------------------------------------------------
local function hcolor(color)
  local ret = ""
  local d, da, db, h
  local hexes = { [10] = "a", [11] = "b", [12] = "c", [13] = "d", [14] = "e", [15] = "f" }
  for i = 0, 9 do hexes[i] = tostring(i) end

  for _, c in pairs({"r", "g", "b"}) do
    d = math.ceil(color[c] * 255)
    --~ da = math.floor(d/16)
    --~ db = d % 16
    ret = ret .. hexes[math.floor(d/16)]
    ret = ret .. hexes[(d % 16)]
  end

  return ret
end

local function make_colors(color)
  color = type(color) == "table" and color or util.color(color)
  local r, g, b = color.r, color.g, color.b
  local black = {r = 0, g = 0, b = 0, a = .25}

  local function mult(v, f)
    return (v * f) % 1
  end

  ret = {
    base = color,
    flow = {r = mult(r, 3), g = mult(g, 3), b = mult(b, 3), a = .25},
    --~ primary = {r = r, g = g, b = b, a = .5},
    --~ secondary = {r = mult(r, .5), g = mult(g, .5), b = mult(b, .5), a = .25},
    --~ tertiary = {r = mult(r, 2), g = mult(g, 2), b = mult(b, 2), a = .25},
    --~ quaternary = black,
  }
for c, color in pairs(ret) do
BioInd.show(c, hcolor(color))
end
  return ret
end

--~ local fertilizer_fluid_colors = make_colors({r = 0.098, g = 0.811, b = 0.269, a = .5})
--~ local adv_fertilizer_fluid_colors = make_colors({r = 0, g = 1, b = 0.071, a = .5})

local fertilizer_fluid_colors = make_colors(util.color("5e9347"))
local adv_fertilizer_fluid_colors = make_colors(util.color("d04677"))

--~ error("BREAK!")
------------------------------------------------------------------------------------
--                            Create fluid fertilizers                            --
------------------------------------------------------------------------------------
-- Fertilizer fluid
fluid = BioInd.create_stuff(BI.additional_fluids[trigger].fertilizer_fluid)[1]

if fluid then
  fluid.base_color = fertilizer_fluid_colors.base
  fluid.flow_color = fertilizer_fluid_colors.flow
  BioInd.modified_msg("colors", fluid)
end

-- Advanced fertilizer fluid
fluid = BioInd.create_stuff(BI.additional_fluids[trigger].adv_fertilizer_fluid)[1]

if fluid then
  fluid.base_color = adv_fertilizer_fluid_colors.base
  fluid.flow_color = adv_fertilizer_fluid_colors.flow
  BioInd.modified_msg("colors", fluid)
end

------------------------------------------------------------------------------------
--                      Create recipes for fluid fertilizers                      --
------------------------------------------------------------------------------------
-- Fertilizer fluid
recipe = BioInd.create_stuff(BI.additional_recipes[trigger].fertilizer_fluid)[1]

--~ if recipe then
  --~ recipe.crafting_machine_tint = {
    --~ -- Kettle
    --~ primary = fertilizer_fluid_colors.primary,
    --~ secondary = fertilizer_fluid_colors.secondary,
    --~ -- Chimney
    --~ tertiary = fertilizer_fluid_colors.tertiary,
    --~ quaternary = fertilizer_fluid_colors.quaternary,
  --~ }
  --~ BioInd.modified_msg("crafting_machine_tint", recipe)
--~ end

-- Advanced fertilizer fluid
recipe = BioInd.create_stuff(BI.additional_recipes[trigger].adv_fertilizer_fluid)[1]
--~ if recipe then
  --~ recipe.crafting_machine_tint = {
    --~ -- Kettle
    --~ primary = fertilizer_fluid_colors.primary,
    --~ secondary = fertilizer_fluid_colors.secondary,
    --~ -- Chimney
    --~ tertiary = fertilizer_fluid_colors.tertiary,
    --~ quaternary = fertilizer_fluid_colors.quaternary,
  --~ }
  --~ BioInd.modified_msg("crafting_machine_tint", recipe)
--~ end


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
BioInd.entered_file("leave")
