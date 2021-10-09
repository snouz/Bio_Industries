BioInd.debugging.entered_file()

------------------------------------------------------------------------------------
-- Just remove some obsolete global tables!
------------------------------------------------------------------------------------
if global and global.bi then
  global.bi.terrains = nil
  global.bi.seed_bomb = nil
  BioInd.debugging.writeDebug("Removed obsolete tables from global!")
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
