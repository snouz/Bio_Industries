------------------------------------------------------------------------------------
--                     Game tweaks: Fuel emission multipliers                     --
--                (BI.Settings.BI_Game_Tweaks_Emissions_Multiplier)               --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Emissions_Multiplier"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local item


for item_name, factor in pairs({
  ["ash"]                       = 1.30,
  ["bi-ash"]                    = 1.30,
  ["bi-seed"]                   = 1.30,
  ["bi-wood-pipe"]              = 1.30,
  ["bi-wood-pipe-to-ground"]    = 1.30,
  ["bi-wooden-chest-giga"]      = 1.30,
  ["bi-wooden-chest-huge"]      = 1.30,
  ["bi-wooden-chest-large"]     = 1.30,
  ["bi-wooden-fence"]           = 1.30,
  ["bi-wooden-pole-big"]        = 1.30,
  ["bi-wooden-pole-huge"]       = 1.30,
  ["bi-woodpulp"]               = 1.40,
  ["carbon"]                    = 1.05,
  ["cellulose-fiber"]           = 1.40,
  ["coal"]                      = 2.00,
  ["coal-crushed"]              = 1.50,
  ["enriched-fuel"]             = 0.90,
  ["pellet-coke"]               = 0.80,
  ["rocket-fuel"]               = 1.20,
  ["seedling"]                  = 1.30,
  ["solid-carbon"]              = 1.05,
  ["solid-coke"]                = 1.40,
  ["solid-fuel"]                = 1.00,
  ["wood"]                      = 1.60,
  ["wood-bricks"]               = 1.20,
  ["wood-charcoal"]             = 1.25,
  ["wood-pellets"]              = 1.40,
}) do
  item = items[item_name]
  if item then
    BI_Functions.lib.fuel_emissions_multiplier_update(item, factor)
    BioInd.debugging.modified_msg("fuel_emissions_multiplier", item)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
