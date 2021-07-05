-- Add functions that are also used in other files (debugging output etc.)
local BioInd = require('common')('Bio_Industries')
BioInd.writeDebug("Entered prototypes.hidden_panels.lua of \"%s\".", {BioInd.modName})

local ICONPATH = BioInd.modRoot .. "/graphics/icons/"

------------------------------------------------------------------------------------
--  Create the main prototype for hidden lamps. All others will be based on this! --
------------------------------------------------------------------------------------
-- The short name of the hidden entity (e.g. "lamp" or "pole")
local h_key = "panel"
-- The actual prototype type, identified by h_key
local h_type = BioInd.HE_map[h_key]
local h_entity = table.deepcopy(data.raw[h_type]["solar-panel"])

BI.set_common_properties(h_entity)


------------------------------------------------------------------------------------
-- Panel specific attributes!
h_entity.energy_source = {
    type = "electric",
    usage_priority = "solar"
}


------------------------------------------------------------------------------------
--      Make a copy of the hidden-entity prototype for each compound entity!      --
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Compile a list of the hidden entities we'll need
BI.make_hidden_entity_list(h_key)

-- Musk floor is not an entity, but a tile, so we don't have a compound-entity table
-- for it and must add it manually!
local Musk_name = "bi-musk-mat-hidden-panel"
BI.hidden_entities.types[h_key][Musk_name] = "bi-solar-mat"


------------------------------------------------------------------------------------
-- Make the copies!
local tmp, panel
local c_entities = BioInd.compound_entities

for panel_name, locale_name in pairs(BI.hidden_entities.types[h_key]) do
  panel = table.deepcopy(h_entity)
  panel.name = panel_name
  panel.localised_name = {"entity-name." .. locale_name}
  panel.localised_description = {"entity-description." .. locale_name}


  -- Adjust properties for hidden panel of Solar boiler
  if panel_name == "bi-solar-boiler" then
    panel.production = "1.8MW"
    BioInd.show("Adjusted properties of", panel_name)
  -- Adjust properties for hidden panel of bio farms
  elseif c_entities["bi-bio-farm"] and
      panel_name == c_entities["bi-bio-farm"].hidden[h_key].name then
    panel.production = "100kW"
    BioInd.show("Adjusted properties of", panel_name)
  -- Adjust properties for hidden panel of Musk floor
  elseif panel_name == Musk_name then
    panel.production = "10kW"
    BioInd.show("Adjusted properties of", panel_name)
  end

  data:extend({panel})

  BioInd.show("Created", panel_name)
end


------------------------------------------------------------------------------------
--~ -- Testing
--~ for k, v in pairs(data.raw[h_entity.type]) do
  --~ BioInd.writeDebug("%s: %s", {k, v})
--~ end
