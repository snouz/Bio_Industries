BioInd.debugging.entered_file()



-- Migrating global tables to new names
for new, old in pairs({
  bi_arboretum_table =          "Arboretum_Table",
  bi_arboretum_radar_table =    "Arboretum_Radar_Table",
  bi_arboretum_recipe_table =   "Arboretum_Recipes",
  bi_bio_cannon_table =         "Bio_Cannon_Table",
}) do

  global[new] = util.table.deepcopy(global[old])
  global[old] = nil
  BioInd.debugging.writeDebug("Migrated global[\"%s\"] to global[\"%s\"].", {old, new})
end

-- Migrate renamed hidden entities!
local boilers = global["bi_solar_boiler_table"]

-- Check the entries of all solar boilers
for b, boiler in pairs(boilers or {}) do
  if boiler.boiler then
    -- Only "boiler" exists (default)
    if not boiler.panel then
      boiler.panel = boiler.boiler
      boiler.boiler = nil
      BioInd.debugging.writeDebug("Moved \"boiler\" to \"panel\" in global[\"bi_solar_boiler_table\"][%s]: %s",
                        {b, boilers[b]})
    -- This should never be needed!
    else
      boiler.boiler = nil
      BioInd.debugging.writeDebug("\"Panel\" already exists! Removed \"boiler\" from global[\"bi_solar_boiler_table\"][%s]: %s", {b, boilers[b]})
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
