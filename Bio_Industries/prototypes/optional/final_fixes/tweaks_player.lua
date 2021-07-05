------------------------------------------------------------------------------------
--                               Game tweaks: Player                              --
--                       (BI.Settings.BI_Game_Tweaks_Player)                      --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Player"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local BioInd = require('common')('Bio_Industries')

-- There may be more than one character in the game! Here's a list of
-- the character prototype names or patterns matching character prototype
-- names we want to ignore.
local blacklist = {
  ------------------------------------------------------------------------------------
  --                                  Known dummies                                 --
  ------------------------------------------------------------------------------------
  -- Autodrive
  "autodrive-passenger",
  -- AAI Programmable Vehicles
  "^.+%-_%-driver$",
  -- Minime
  "minime_character_dummy",
  -- Water Turret (currently the dummies are not characters -- but things may change!)
  "^WT%-.+%-dummy$",
  ------------------------------------------------------------------------------------
  --                                Other characters                                --
  ------------------------------------------------------------------------------------
  -- Bob's Classes and Multiple characters mod
  "^.*bob%-character%-.+$",
}

local whitelist = {
  -- Default character
  "^character$",
  -- Characters compatible with Minime
  "^.*skin.*$",
}

local tweaks = {
  loot_pickup_distance        = 5,    -- default 2
  build_distance              = 20,   -- Vanilla 6
  drop_item_distance          = 20,   -- Vanilla 6
  reach_distance              = 20,   -- Vanilla 6
  item_pickup_distance        = 6,    -- Vanilla 1
  reach_resource_distance     = 6,    -- Vanilla 2.7
}

local found, ignore
for char_name, character in pairs(data.raw.character) do
BioInd.show("Checking character", char_name)
  found = false

  for w, w_pattern in ipairs(whitelist) do
    if char_name == w_pattern or char_name:match(w_pattern) then
      ignore = false
        BioInd.show("Found whitelisted character name", char_name)
      for b, b_pattern in ipairs(blacklist) do
        if char_name == b_pattern or char_name:match(b_pattern) then
            BioInd.writeDebug("%s is on the ignore list!", char_name)
          -- Mark character as found
          ignore = true
          break
        end
      end
      if not ignore then
        found = true
        break
      end
    end

    if found then
      break
    end
  end

  -- Apply tweaks
  if found then
    for tweak_name, tweak in pairs(tweaks) do
      if character[tweak_name] < tweak then
        character[tweak_name] = tweak
        --~ BioInd.writeDebug("Changing %s from %s to %s", {tweak_name, character[tweak_name], tweak})
        BioInd.modified_msg(tweak_name, character)
      end
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
