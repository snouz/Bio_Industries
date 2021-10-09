------------------------------------------------------------------------------------
--                       Trigger: Create "wooden floor" tile                      --
--                       (BI.Triggers.BI_Trigger_Woodfloor)                       --
------------------------------------------------------------------------------------
-- Mods: "Dectorio",
local trigger = "BI_Trigger_Woodfloor"
if not BI.Triggers[trigger] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ local techs = data.raw.technology
--~ local recipes = data.raw.recipe
local items = data.raw.item
local tiles = data.raw.tile
local item, tile


------------------------------------------------------------------------------------
--                               Create tiles                              --
------------------------------------------------------------------------------------
BioInd.debugging.show("BI.additional_entities[" .. trigger .."]", BI.additional_entities[trigger])

BioInd.create_stuff(BI.additional_entities[trigger])


------------------------------------------------------------------------------------
--                           Make tile placeable by wood                          --
------------------------------------------------------------------------------------
tile = tiles[BI.additional_entities[trigger].wood_floor.name]
items["wood"].place_as_tile = {
  result = tile.name,
  condition_size = 4,
  condition = { "water-tile" }
}
BioInd.debugging.writeDebug("Tile \"%s\" can be placed by wood!", {tile.name})




------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
