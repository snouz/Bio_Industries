------------------------------------------------------------------------------------
--                  Data for some fluids that depend on settings.                 --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_fluids = BI.additional_fluids or {}

local settings = {
  "BI_Wood_Gasification",
}
for s, setting in pairs(settings) do
  BI.additional_fluids[setting] = BI.additional_fluids[setting] or {}
end


local triggers = {
  "BI_Trigger_Easy_Bio_Gardens",
}
for t, trigger in pairs(triggers) do
  BI.additional_fluids[trigger] = BI.additional_fluids[trigger] or {}
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
--                            Trigger: Easy Bio gardens                           --
--                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
------------------------------------------------------------------------------------
-- Fertilizer fluid
BI.additional_fluids.BI_Trigger_Easy_Bio_Gardens.fertilizer_fluid = {
  type = "fluid",
  name = "bi-fertilizer-fluid",
  icon = ICONPATH .. "fluid_fertilizer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  default_temperature = 25,
  max_temperature = 100,
  heat_capacity = "1KJ",
  -- This will be added in triggersEasyBioGardens.lua!
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
BI.additional_fluids.BI_Trigger_Easy_Bio_Gardens.adv_fertilizer_fluid = {
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


------------------------------------------------------------------------------------
--                            Enable: Wood gasification                           --
--                       (BI.Settings.BI_Wood_Gasification)                       --
------------------------------------------------------------------------------------
BI.additional_fluids.BI_Wood_Gasification.tar = {
  type = "fluid",
  name = "tar",
  default_temperature = 180,
  heat_capacity = "1470KJ",
  base_color = {r=0.05, g=0.05, b=0.05},
  flow_color = {r=0.1, g=0.1, b=0.1},
  max_temperature = 250,
  icon = ICONPATH .. "fluid_fertilizer_advanced.png",
  icon_size = 64, icon_mipmaps = 3,
  pressure_to_speed_ratio = 0.2,
  flow_to_energy_ratio = 0.80,
  order = "a[fluid]-t[tar]"
}


-- Status report
BioInd.readdata_msg(BI.additional_fluids, settings,
                    "optional fluids", "setting")

--~ for t, trigger in pairs(triggers) do
  --~ if next(BI.additional_fluids[trigger]) then
    --~ BioInd.writeDebug("Read data for optional fluids (trigger %s).", trigger)
  --~ end
--~ end
BioInd.readdata_msg(BI.additional_fluids, triggers,
                    "optional fluids", "trigger")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
