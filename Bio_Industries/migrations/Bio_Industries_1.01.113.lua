BioInd.debugging.entered_file()

------------------------------------------------------------------------------------
--                  Remove AutoCached tables from global.bi_trees                 --
------------------------------------------------------------------------------------
global.bi_trees.trees = nil
global.bi_trees.barren_tiles = nil
BioInd.debugging.writeDebug("Removed tables that will be AutoCached.")

------------------------------------------------------------------------------------
--                  Remove obsolete Bio cannon values from global                 --
------------------------------------------------------------------------------------
global.Bio_Cannon_Counter = nil
global.Bio_Cannon_Fired = nil
BioInd.debugging.writeDebug("Removed obsolete values for Bio cannons from global.")

------------------------------------------------------------------------------------
--             Keep  tables for checks of different entities together             --
------------------------------------------------------------------------------------
global.checks = {}
global.checks.bi_pollution_sensor = table.deepcopy(global.bi_pollution_tables)
global.bi_pollution_tables = nil
BioInd.debugging.writeDebug("Moved pollution sensor tables to global.checks.")

global.checks.bi_trees = table.deepcopy(global.bi_trees)
global.bi_trees = nil
BioInd.debugging.writeDebug("Moved tree growth tables to global.checks.")


------------------------------------------------------------------------------------
--                  Cross-reference Bio cannons with their radars                 --
------------------------------------------------------------------------------------
if global.bi_bio_cannon_table then
  global.bi_bio_cannon_radar_table = global.bi_bio_cannon_radar_table or {}

  local cnt = 0
  for c, cannon in pairs(global.bi_bio_cannon_table) do
    if cannon.radar and cannon.radar.valid then
      global.bi_bio_cannon_radar_table[cannon.radar.unit_number] = c
      cnt = cnt + 1
    end
  end
  BioInd.debugging.writeDebug("Added %s cross references from Bio cannon radars to Bio cannons.", cnt)
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
