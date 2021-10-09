------------------------------------------------------------------------------------
--                  Data for some fluids that depend on settings.                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

BI.additional_fluids = BI.additional_fluids or {}

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
  localised_name = {"fluid-name.bi-fertilizer-fluid", {"item-name.fertilizer"}},
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
  localised_name = {"fluid-name.bi-fertilizer-fluid", {"item-name.bi-adv-fertilizer"}},
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
  order = "a[fluid]-b[fertilizer]-[advanced]"
}


-- Status report
BioInd.debugging.readdata_msg(BI.additional_fluids, triggers, "optional fluids", "trigger")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
