------------------------------------------------------------------------------------
--                     Game tweaks: Fuel emission multipliers                     --
--                (BI.Settings.BI_Game_Tweaks_Emissions_Multiplier)               --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Emissions_Multiplier"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


for item, factor in pairs({
  ["pellet-coke"] = 0.80,
  ["enriched-fuel"] = 0.90,
  ["solid-fuel"] = 1.00,
  ["solid-carbon"] = 1.05,
  ["carbon"] = 1.05,
  ["wood-bricks"] = 1.20,
  ["rocket-fuel"] = 1.20,
  ["bi-seed"] = 1.30,
  ["seedling"] = 1.30,
  ["bi-wooden-pole-big"] = 1.30,
  ["bi-wooden-pole-huge"] = 1.30,
  ["bi-wooden-fence"] = 1.30,
  ["bi-wood-pipe"] = 1.30,
  ["bi-wood-pipe-to-ground"] = 1.30,
  ["bi-wooden-chest-large"] = 1.30,
  ["bi-wooden-chest-huge"] = 1.30,
  ["bi-wooden-chest-giga"] = 1.30,
  ["bi-ash"] = 1.30,
  ["ash"] = 1.30,
  ["wood-charcoal"] = 1.25,
  ["cellulose-fiber"] = 1.40,
  ["bi-woodpulp"] = 1.40,
  ["solid-coke"] = 1.40,
  ["wood-pellets"] = 1.40,
  ["coal-crushed"] = 1.50,
  ["wood"] = 1.60,
  ["coal"] = 2.00,
}) do
  BI_Functions.lib.fuel_emissions_multiplier_update(item, factor)
  BioInd.modified_msg("fuel_emissions_multiplier", item)
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
