------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Fuel"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ local new_battery_icon = BioInd.check_base_version("0.18.47")
local forbidden

------------------------------------------------------------------------------------
--                                 Create recipes                                 --
------------------------------------------------------------------------------------
forbidden = BI.additional_recipes.BI_Bio_Fuel.basic_gas_processing

for r, r_data in pairs(BI.additional_recipes[setting] or {}) do
  -- Don't create the recipe for Basic gas processing yet! We'll need to check if
  -- resin is available.
  if r_data.name ~= forbidden.name then
    BioInd.create_stuff(r_data)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
