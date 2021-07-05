------------------------------------------------------------------------------------
--                  Data for some fluids that depend on settings.                 --
------------------------------------------------------------------------------------
BI.entered_file()

BI.additional_fluids = BI.additional_fluids or {}

for s, setting in pairs({
  "BI_Game_Tweaks_Easy_Bio_Gardens",
}) do
  BI.additional_fluids[setting] = BI.additional_fluids[setting] or {}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
--                         "Game tweaks: Easy Bio gardens"                        --
--                  (BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens)                 --
------------------------------------------------------------------------------------
-- Fertilizer fluid
BI.additional_fluids.BI_Game_Tweaks_Easy_Bio_Gardens.fertilizer_fluid = {
  type = "fluid",
  name = "bi-fertilizer-fluid",
  icon = ICONPATH .. "fluid_fertilizer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  default_temperature = 25,
  max_temperature = 100,
  heat_capacity = "1KJ",
  -- This will be added in optionsEasyBioGardens.lua!
  -- base_color = {r = 0.478, g = 0.341, b = 0.118},
  --~ -- 19cf44
  -- base_color = {r = 0.098, g = 0.811, b = 0.269},
  --~ base_color = fertilizer_fluid_colors.base,
  -- flow_color = {r = 0, g = 0, b = 0},
  --~ flow_color = fertilizer_fluid_colors.flow,
  pressure_to_speed_ratio = 0.4,
  flow_to_energy_ratio = 0.59,
  order = "a[fluid]-b[fertilizer]"
}

-- Advanced fertilizer fluid
BI.additional_fluids.BI_Game_Tweaks_Easy_Bio_Gardens.adv_fertilizer_fluid = {
  type = "fluid",
  name = "bi-adv-fertilizer-fluid",
  icon = ICONPATH .. "fluid_fertilizer_advanced.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  default_temperature = 25,
  max_temperature = 100,
  heat_capacity = "1KJ",
  -- This will be added in optionsEasyBioGardens.lua!
  --~ --00ff12
  -- base_color = {r = 0.465, g = 0.306, b = 0.272},
  -- base_color = {r = 0, g = 1, b = 0.071},
  --~ base_color = adv_fertilizer_fluid_colors.base,
  -- flow_color = {r = 0, g = 0, b = 0},
  --~ flow_color = adv_fertilizer_fluid_colors.flow,
  pressure_to_speed_ratio = 0.4,
  flow_to_energy_ratio = 0.59,
  order = "a[fluid]-b[fertilizer-advanced]"
}


BioInd.writeDebug("Read data for optional fluids.")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
