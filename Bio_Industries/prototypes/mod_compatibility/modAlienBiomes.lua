------------------------------------------------------------------------------------
--                                  Alien biomes                                  --
------------------------------------------------------------------------------------
local mod_name = "alien-biomes"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
-- Alien Biomes will degrade tiles to "landfill" if more than 255 tiles are defined
-- in the game. We can register the musk-floor tiles with Alien Biomes so it will
-- try to prioritize the tiles if they exist.
alien_biomes_priority_tiles = alien_biomes_priority_tiles or {}
table.insert(alien_biomes_priority_tiles, "bi-solar-mat")
BioInd.writeDebug("Registered Musk floor tiles with \"Alien Biomes\".")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
