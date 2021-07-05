------------------------------------------------------------------------------------
--                                  Alien biomes                                  --
------------------------------------------------------------------------------------
local mod_name = "alien-biomes"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local items = data.raw.item
local tiles = data.raw.tile


------------------------------------------------------------------------------------
--                       Fix properties of fertilizer items                       --
------------------------------------------------------------------------------------
local fertilizer = items["fertilizer"]
local fertilizer_adv = items["bi-adv-fertilizer"]

-- Even though the mod is active, we should make sure its tiles exist!
local AlienBiomes = tiles["vegetation-green-grass-3"] and tiles["vegetation-green-grass-1"] and true


------------------------------------------------------------------------------------
-- Common fertilizer
if fertilizer then
  -- Add "place_as_tile" property!
  fertilizer.place_as_tile = {
    result = AlienBiomes and "vegetation-green-grass-3" or "grass-3",
    condition_size = 1,
    condition = { "water-tile" }
  }
  --~ BioInd.writeDebug("Added \"place_as_tile\" to item %s!", {fertilizer.name})
  BioInd.modified_msg("result", fertilizer, "Added")

  -- Change icon
  BioInd.BI_change_icon(fertilizer, ICONPATH .. "fertilizer.png")

  -- Change localization
  fertilizer.localised_name = {"BI-item-name.fertilizer"}
  fertilizer.localised_description = {"BI-item-description.fertilizer"}
  BioInd.modified_msg("localization", fertilizer)
end


------------------------------------------------------------------------------------
-- Advanced fertilizer
if fertilizer_adv then
  -- Add "place_as_tile" property!
  fertilizer_adv.place_as_tile = {
    result = AlienBiomes and "vegetation-green-grass-1" or "grass-1",
    condition_size = 1,
    condition = { "water-tile" }
  }
  BioInd.modified_msg("place_as_tile", fertilizer_adv, "Added")
end


------------------------------------------------------------------------------------
--                          Remove tiles from blueprints                          --
------------------------------------------------------------------------------------

--- Vanilla "grass" tile
for t, tile_name in ipairs{"grass-1", "grass-2", "grass-3", "grass-4"} do
  BI_Functions.lib.remove_from_blueprint(tile)
  BioInd.writeDebug("Removed tile \"%s\" from blueprints.", {tile_name})
end

-- Tiles from "Alien Biomes"
local patterns = {
  "frozen%-snow%-%d",
  "mineral%-aubergine%-dirt%-%d",
  "mineral%-aubergine%-sand%-%d",
  "mineral%-beige%-dirt%-%d",
  "mineral%-beige%-sand%-%d",
  "mineral%-black%-dirt%-%d",
  "mineral%-black%-sand%-%d",
  "mineral%-brown%-dirt%-%d",
  "mineral%-brown%-sand%-%d",
  "mineral%-cream%-dirt%-%d",
  "mineral%-cream%-sand%-%d",
  "mineral%-dustyrose%-dirt%-%d",
  "mineral%-dustyrose%-sand%-%d",
  "mineral%-grey%-dirt%-%d",
  "mineral%-grey%-sand%-%d",
  "mineral%-purple%-dirt%-%d",
  "mineral%-purple%-sand%-%d",
  "mineral%-red%-dirt%-%d",
  "mineral%-red%-sand%-%d",
  "mineral%-tan%-dirt%-%d",
  "mineral%-tan%-sand%-%d",
  "mineral%-violet%-dirt%-%d",
  "mineral%-violet%-sand%-%d",
  "mineral%-white%-dirt%-%d",
  "mineral%-white%-sand%-%d",
  "vegetation%-blue%-grass%-%d",
  "vegetation%-green%-grass%-%d",
  "vegetation%-mauve%-grass%-%d",
  "vegetation%-olive%-grass%-%d",
  "vegetation%-orange%-grass%-%d",
  "vegetation%-purple%-grass%-%d",
  "vegetation%-red%-grass%-%d",
  "vegetation%-turquoise%-grass%-%d",
  "vegetation%-violet%-grass%-%d",
  "vegetation%-yellow%-grass%-%d",
  "volcanic%-blue%-heat%-%d",
  "volcanic%-green%-heat%-%d",
  "volcanic%-orange%-heat%-%d",
  "volcanic%-purple%-heat%-%d",
}
for tile_name, tile in pairs(tiles) do
  for p, pattern in ipairs(patterns) do
    if tile_name:match(pattern) then
      BI_Functions.lib.remove_from_blueprint(tile)
      BioInd.writeDebug("Removed tile \"%s\" from blueprints.", {tile_name})
      break
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
