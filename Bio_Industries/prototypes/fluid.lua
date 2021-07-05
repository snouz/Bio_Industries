local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

data:extend({
-- Moved this over to compatible_recipes.lua. These are fluids that may also be created by other mods!
  --~ ----- liquid-air
  --~ {
    --~ type = "fluid",
    --~ name = "liquid-air",
    --~ icon = ICONPATH .. "liquid-air.png",
    --~ icon_size = 64,
    --~ default_temperature = 25,
    --~ gas_temperature = -100,
    --~ max_temperature = 100,
    --~ heat_capacity = "1KJ",
    --~ base_color = {r = 0, g = 0, b = 0},
    --~ flow_color = {r = 0.5, g = 1.0, b = 1.0},
    --~ pressure_to_speed_ratio = 0.4,
    --~ flow_to_energy_ratio = 0.59,
    --~ order = "a[fluid]-b[liquid-air]"
  --~ },

  --~ ----- Nitrogen
  --~ {
    --~ type = "fluid",
    --~ name = "nitrogen",
    --~ icon = ICONPATH .. "nitrogen.png",
    --~ icon_size = 64,
    --~ default_temperature = 25,
    --~ gas_temperature = -210,
    --~ max_temperature = 100,
    --~ heat_capacity = "1KJ",
    --~ base_color = {r = 0.0, g = 0.0, b = 1.0},
    --~ flow_color = {r = 0.0, g = 0.0, b = 1.0},
    --~ pressure_to_speed_ratio = 0.4,
    --~ flow_to_energy_ratio = 0.59,
    --~ order = "a[fluid]-b[nitrogen]"
  --~ },

  ----- Bio-Mass
  {
    type = "fluid",
    name = "bi-biomass",
    icon = ICONPATH .. "biomass.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "biomass.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    default_temperature = 25,
    max_temperature = 100,
    heat_capacity = "1KJ",
    base_color = {r = 0, g = 0, b = 0},
    flow_color = {r = 0.1, g = 1.0, b = 0.0},
    pressure_to_speed_ratio = 0.4,
    flow_to_energy_ratio = 0.59,
    order = "a[fluid]-b[biomass]"
  },






  -- biofuel for boilers apparently abandonned at one point.

  -- {
  --   type = "fluid",
  --   name = "bi-Bio_Fuel",
  --   icon = ICONPATH .. "entity/bio_boiler.png",
  --   icon_size = 64,
  --   BI_add_icon = true,
  --   --~ icons = {
  --     --~ {
  --       --~ icon = ICONPATH .. "bio_boiler.png",
  --       --~ icon_size = 64,
  --     --~ }
  --   --~ },
  --   default_temperature = 25,
  --   max_temperature = 100,
  --   heat_capacity = "1KJ",
  --   base_color = {r = 1.00, g = 0.35, b = 0.35},
  --   flow_color = {r = 1.00, g = 0.35, b = 0.35},
  --   pressure_to_speed_ratio = 0.4,
  --   flow_to_energy_ratio = 0.59,
  -- },


})
