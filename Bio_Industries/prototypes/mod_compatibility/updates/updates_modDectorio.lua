------------------------------------------------------------------------------------
--                                    Dectorio                                    --
------------------------------------------------------------------------------------
local mod_name = "Dectorio"
--~ if not BioInd.check_mods(mod_name) then
  --~ BioInd.nothing_to_do("*")
  --~ return
--~ else
  --~ BioInd.entered_file()
--~ end

BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local SNDPATH = "__Dectorio__/sound/"

local items = data.raw.item
local tiles = data.raw.tile

local sounds = BioInd.check_mods(mod_name) and {} or nil

-- Dectorio exists, so sounds exist and we can modify it
if sounds then
  sounds.mined_sound = {filename = SNDPATH .. "deconstruct-wood.ogg"}
  sounds.walking_sound = {}
  for i = 1, 4 do
    sounds.walking_sound[i] = {
      filename = SNDPATH .. "walking/wood-0" .. i .. ".ogg",
      volume = 0.95
    }
  end
-- There are no sounds we could add, but we need at least an empty table later on!
else
  sounds = {}
end


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
    BioInd.modified_msg("sounds", tile)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
