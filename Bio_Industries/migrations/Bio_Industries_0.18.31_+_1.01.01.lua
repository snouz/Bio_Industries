------------------------------------------------------------------------------------
-- Just remove some obsolete global tables!
------------------------------------------------------------------------------------

if global and global.bi then
  global.bi.terrains = nil
  global.bi.seed_bomb = nil
end

table.sort(global, function(a, b) return a < b end)
