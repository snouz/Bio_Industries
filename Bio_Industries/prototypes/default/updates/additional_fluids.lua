BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

local fluids = data.raw.fluid
local techs = data.raw.technology
local recipes = data.raw.recipe
local tech, fluid, recipe

local create_fluids = {}

------------------------------------------------------------------------------------
--                            Data of additional fluids                           --
------------------------------------------------------------------------------------
-- Liquid air
create_fluids.liquid_air = {
  type = "fluid",
  name = "liquid-air",
  icon = ICONPATH .. "fluid_liquid-air.png",
  icon_size = 64,
  default_temperature = 25,
  gas_temperature = -100,
  max_temperature = 100,
  heat_capacity = "1KJ",
  base_color = {r = 0, g = 0, b = 0},
  flow_color = {r = 0.5, g = 1.0, b = 1.0},
  pressure_to_speed_ratio = 0.4,
  flow_to_energy_ratio = 0.59,
  order = "a[fluid]-b[liquid-air]"
}

-- Nitrogen
create_fluids.nitrogen = {
  type = "fluid",
  name = "nitrogen",
  icon = ICONPATH .. "fluid_nitrogen.png",
  icon_size = 64,
  default_temperature = 25,
  gas_temperature = -210,
  max_temperature = 100,
  heat_capacity = "1KJ",
  base_color = {r = 0.0, g = 0.0, b = 1.0},
  flow_color = {r = 0.0, g = 0.0, b = 1.0},
  pressure_to_speed_ratio = 0.4,
  flow_to_energy_ratio = 0.59,
  order = "a[fluid]-b[nitrogen]"
}

--~ ------------------------------------------------------------------------------------
--~ --            Biofuel for boilers apparently abandonned at some point.            --
--~ ------------------------------------------------------------------------------------
--~ create_fluids.bio_fuel = {
  --~ type = "fluid",
  --~ name = "bi-Bio_Fuel",
  --~ icon = ICONPATH .. "entity/bio_boiler.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  -- icons = {
    -- {
      -- icon = ICONPATH .. "bio_boiler.png",
      -- icon_size = 64,
    -- }
  -- },
  --~ default_temperature = 25,
  --~ max_temperature = 100,
  --~ heat_capacity = "1KJ",
  --~ base_color = {r = 1.00, g = 0.35, b = 0.35},
  --~ flow_color = {r = 1.00, g = 0.35, b = 0.35},
  --~ pressure_to_speed_ratio = 0.4,
  --~ flow_to_energy_ratio = 0.59,
--~ }


------------------------------------------------------------------------------------
--                            Create additional fluids                            --
------------------------------------------------------------------------------------

--~ if not (fluids[create_fluids.nitrogen.name] and fluids[create_fluids.liquid_air.name]) then

------------------------------------------------------------------------------------
-- Liquid air

-- Do we really need liquid air? Check if there are substitutes
if not fluids[create_fluids.liquid_air.name] then
  local substitutes = {
    "oxygen",
    "nitrogen",
  }
  local success

  for s, substitute in ipairs(substitutes) do
    if fluids[substitute] then
      for r, recipe in ipairs({"bi-biomass-2", "bi-biomass-2"}) do
        thxbob.lib.recipe.replace_ingredient(recipe, "liquid-air", substitute)
        --~ BioInd.writeDebug("Replaced \"liquid-air\" with \"oxygen\" in recipes \"bi-biomass-2\" and \"bi-biomass-3\"")
        BioInd.modified_msg("ingredients", recipes[recipe])
        success = true
        break
      end
    end
  end

  -- No substitute found: Create liquid air!
  if not success then
    data:extend({create_fluids.liquid_air})
    BioInd.created_msg(create_fluids.liquid_air)
  end
end

------------------------------------------------------------------------------------
-- Nitrogen

-- We will always need nitrogen. If no other mod provides it, we create it.
if not fluids[create_fluids.nitrogen.name] then
  data:extend({create_fluids.nitrogen})
  BioInd.created_msg(create_fluids.nitrogen)

-- Fluid already exists. Remove unlocks for our recipe!
else
  fluid = fluids[create_fluids.nitrogen.name]
  recipe = recipes["bi-" .. fluid.name]
  --~ thxbob.lib.tech.remove_recipe_unlock("bi-tech-fertilizer", "bi-" .. fluid.name)
  thxbob.lib.tech.remove_recipe_unlock(tech.name, recipe.name)
  --~ BioInd.writeDebug("Removed recipe unlocks for recipe \"%s\"!", {recipe.name})
  BioInd.modified_msg("unlock", recipe, "Removed")
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
