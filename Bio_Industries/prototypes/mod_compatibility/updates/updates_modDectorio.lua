------------------------------------------------------------------------------------
--                                    Dectorio                                    --
------------------------------------------------------------------------------------
local mod_name = "Dectorio"
if not (BioInd.check_mods(mod_name) and BI.Triggers["BI_Trigger_Woodfloor"]) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end

BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local SNDPATH = "__Dectorio__/sound/"

local items = data.raw.item
local tiles = data.raw.tile

local sounds = {}


------------------------------------------------------------------------------------
--                Use Dectorio's sounds for our wooden floor tiles!               --
------------------------------------------------------------------------------------
sounds.mined_sound = {filename = SNDPATH .. "deconstruct-wood.ogg"}
sounds.walking_sound = {}
for i = 1, 4 do
  sounds.walking_sound[i] = {
    filename = SNDPATH .. "walking/wood-0" .. i .. ".ogg",
    volume = 0.95
  }
end


tile = tiles[BI.additional_entities["BI_Trigger_Woodfloor"].wood_floor.name]

-- If Dectorio is active but its wooden floor has been disabled, we can replace
-- the vanilla sounds with those from Dectorio.
if tile then
  tile.mined_sound = sounds.mined_sound
  tile.walking_sound = sounds.walking_sound
  BioInd.debugging.modified_msg("sounds", tile)
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
