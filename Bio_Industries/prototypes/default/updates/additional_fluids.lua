BioInd.entered_file()

BI.additional_fluids = BI.additional_fluids or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local ICONPATH = BioInd.iconpath

local fluids = data.raw.fluid
local techs = data.raw.technology
local recipes = data.raw.recipe
local tech, fluid, recipe


------------------------------------------------------------------------------------
--                            Data of additional fluids                           --
------------------------------------------------------------------------------------
-- Liquid air
BI.additional_fluids.liquid_air = {
  type = "fluid",
  name = "liquid-air",
  icon = ICONPATH .. "fluid_liquid-air.png",
  icon_size = 64, icon_mipmaps = 3,
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
BI.additional_fluids.nitrogen = {
  type = "fluid",
  name = "nitrogen",
  icon = ICONPATH .. "fluid_nitrogen.png",
  icon_size = 64, icon_mipmaps = 3,
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
--~ --            Biofuel for boilers apparently abandoned at some point.             --
--~ ------------------------------------------------------------------------------------
--~ BI.additional_fluids.bio_fuel = {
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


-- Status report
BioInd.readdata_msg(BI.additional_fluids, nil, "additional_fluids")

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
