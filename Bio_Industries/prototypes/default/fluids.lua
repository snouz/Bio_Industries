BI.entered_file()

BI.default_fluids = BI.default_fluids or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
--                                 Default fluids                                 --
------------------------------------------------------------------------------------
-- Biomass
BI.default_fluids.biomass = {
  type = "fluid",
  name = "bi-biomass",
  icon = ICONPATH .. "fluid_biomass.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  default_temperature = 25,
  max_temperature = 100,
  heat_capacity = "1KJ",
  base_color = {r = 0, g = 0, b = 0},
  flow_color = {r = 0.1, g = 1.0, b = 0.0},
  pressure_to_speed_ratio = 0.4,
  flow_to_energy_ratio = 0.59,
  order = "a[fluid]-b[biomass]"
}

-- Bio fuel (This has either been removed or it was never implemented!)
--~ BI.default_fluids.bio_fuel = {
   --~ type = "fluid",
   --~ name = "bi-Bio_Fuel",
   --~ icon = ICONPATH .. "entity/bio_boiler.png",
   --~ icon_size = 64,
   --~ BI_add_icon = true,
   --~ default_temperature = 25,
   --~ max_temperature = 100,
   --~ heat_capacity = "1KJ",
   --~ base_color = {r = 1.00, g = 0.35, b = 0.35},
   --~ flow_color = {r = 1.00, g = 0.35, b = 0.35},
   --~ pressure_to_speed_ratio = 0.4,
   --~ flow_to_energy_ratio = 0.59,
--~ }


------------------------------------------------------------------------------------
--                                  Create fluids                                 --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_fluids)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
