------------------------------------------------------------------------------------
-- BioGardens will now have a hidden pole. It can't be hooked up unless Fluid
-- fertilizer is active (maximum_wire_distance = 0), but it still needs to be there.
------------------------------------------------------------------------------------
local BioInd = require('__Bio_Industries__/common')('Bio_Industries')

-- Make sure the global table exists!
global.bi_bio_garden_table = {}

local bio_gardens = {}
local hidden_entities = {pole = "bi-bio-garden-hidden-pole"}

for s, surface in pairs(game.surfaces) do
  bio_gardens = surface.find_entities_filtered{
    name = "bi-bio-garden",
    type = "assembling-machine",
  }

  for g, garden in ipairs(bio_gardens or {}) do
    BioInd.create_entities(global.bi_bio_garden_table, garden, hidden_entities, garden.position)
    BioInd.writeDebug("Stored Bio garden %g in table: %s", {garden.unit_number,    global.bi_bio_garden_table[garden.unit_number]})
  end
end


-- Create a table where we can store the last state of certain mod settings.
global.mod_settings = global.mod_settings or {}
global.mod_settings.BI_Easy_Bio_Gardens = BioInd.get_startup_setting("BI_Easy_Bio_Gardens")
