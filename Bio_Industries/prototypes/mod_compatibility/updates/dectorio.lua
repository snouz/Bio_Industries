------------------------------------------------------------------------------------
--                                    Dectorio                                    --
------------------------------------------------------------------------------------
local mod_name = "Dectorio"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath
local SNDPATH = "__Dectorio__/sound/"

local items = data.raw.item
local tiles = data.raw.tile

local sounds = {}
if BI.check_mods(mod_name) then
  sounds.mined_sound = {filename = SNDPATH .. "deconstruct-wood.ogg"}
  sounds.walking_sound = {}
  for i in 1, 4 do
    sounds.walking_sound[i] = {
      filename = SNDPATH .. "walking/wood-0" .. i ".ogg",
      volume = 0.95
    }
  end
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                     Let wood place our wooden floor tiles!                     --
------------------------------------------------------------------------------------
tile = tiles["bi-wood-floor"]

-- Our tile will only exist if Dectorio is NOT active or if its own wooden floor
-- tiles have been disabled!
if tile then
  items["wood"].place_as_tile = {
    result = tile.name,
    condition_size = 4,
    condition = { "water-tile" }
  }
  BioInd.writeDebug("Tile \"%s\" can be placed by wood!", {tile.name})

  -- If Dectorio is active but its wooden floor has been disabled, we can replace
  -- the vanilla sounds with those from Dectorio.
  if next(sounds) then
    tile.mined_sound = sounds.mined_sound
    tile.walking_sound = sounds.walking_sound
    --~ BioInd.writeDebug("Using Dectorio's sounds for tile \"%s\".", {tile.name})
    BioInd.modified_msg("sounds", tile)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
