BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


BioInd.show("Compound entities", BioInd.compound_entities)


local ICONPATH = BioInd.iconpath
local ENTITYPATH = BioInd.entitypath


------------------------------------------------------------------------------------
--  Create the main prototype for hidden lamps. All others will be based on this! --
------------------------------------------------------------------------------------
-- The short name of the hidden entity (e.g. "lamp" or "pole")
local h_key = "panel"

-- The actual prototype type, identified by h_key
local h_type = BioInd.HE_map[h_key]
local h_entity = table.deepcopy(data.raw[h_type]["solar-panel"])

BI.set_common_properties(h_entity)

--~ BioInd.show("Panel data after set_common_properties", h_entity)

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

-- Add entities for Musk floor?
if BI.Settings.BI_Power_Production then
  -- Musk floor is not an entity, but a tile, so we don't have a compound-entity table
  -- for it and must add it manually!
  local Musk_name = BioInd.musk_floor_panel_name
  BI.hidden_entities.types[h_key][Musk_name] = "bi-solar-mat"
end

------------------------------------------------------------------------------------
-- Make the copies!
local tmp, panel
local c_entities = BioInd.compound_entities

BioInd.show("Compound entities", BioInd.compound_entities)

for panel_name, locale_name in pairs(BI.hidden_entities.types[h_key] or {}) do
  panel = table.deepcopy(h_entity)
  panel.name = panel_name
  panel.localised_name = {"entity-name." .. locale_name}
  panel.localised_description = {"entity-description." .. locale_name}


  -- Adjust properties for hidden panel of Solar boiler
  if c_entities["bi-solar-boiler"] and
      panel_name == c_entities["bi-solar-boiler"].hidden[h_key].name then

    --panel.icon = ICONPATH .. "entity/solar-boiler.png"
    --panel.icon_size = 64
    --panel.icon_mipmaps = 3
    --panel.BI_add_icon = true
    panel.icons = {
      { icon = ICONPATH .. "entity/solar-boiler.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {0, 0} },
      { icon = "__base__/graphics/icons/solar-panel.png", icon_size = 64, icon_mipmaps = 4, scale = 0.25, shift = {8, -8} },
    }

    panel.picture = {}
    --[[panel.picture.layers = BI.add_layer(panel.picture.layers, {
      name = ENTITYPATH .. "bio_solar_boiler/Bio_Solar_Boiler.png",
      hr_name = ENTITYPATH .. "bio_solar_boiler/hr_Bio_Solar_Boiler.png",
      size = 288
    })
    panel.picture.layers = BI.add_layer(panel.picture.layers, {
      name = ENTITYPATH .. "bio_solar_boiler/Bio_Solar_Boiler_shadow.png",
      hr_name = ENTITYPATH .. "bio_solar_boiler/hr_Bio_Solar_Boiler_shadow.png",
      size = 288,
      priority = "high",
      draw_as_shadow = true,
    })]]--
    panel.picture.layers = BI.add_layer(panel.picture.layers, {
      name = "__core__/graphics/empty.png",
      size = 1
    })
    panel.overlay = {}
    panel.overlay.layers = table.deepcopy(panel.picture.layers)

    panel.max_health = 400
    panel.render_no_power_icon = true
    panel.collision_box = {{-4.2, -4.2}, {4.2, 4.2}}
    panel.production = "1.8MW"
    BioInd.show("Adjusted properties of", panel_name)

  -- Adjust properties for hidden panel of Bio farms
  elseif c_entities["bi-bio-farm"] and
          panel_name == c_entities["bi-bio-farm"].hidden[h_key].name then

    --panel.icon = ICONPATH .. "entity/biofarm_solarpanel.png"
    --panel.icon_size = 64
    --panel.icon_mipmaps = 3
    --panel.BI_add_icon = true
    panel.icons = { 
      { icon = ICONPATH .. "entity/biofarm.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {0, 0} },
      { icon = "__base__/graphics/icons/solar-panel.png", icon_size = 64, icon_mipmaps = 4, scale = 0.25, shift = {8, -8} },
    }
    panel.production = "100kW"
    BioInd.show("Adjusted properties of", panel_name)

  --~ -- Adjust properties for hidden panel of Solar farms
  --~ elseif c_entities["bi-bio-solar-farm"] and
          --~ panel_name == c_entities["bi-bio-solar-farm"].hidden[h_key].name then
    --~ panel.icon = ICONPATH .. "entity/Bio_Solar_Farm_Icon.png"
    --~ panel.icon_size = 64
    --~ panel.flags = {"placeable-neutral", "player-creation"}
    --~ panel.production = "3600kW"
    --~ BioInd.show("Adjusted properties of", panel_name)

  -- Adjust properties for hidden panel of Musk floor
  elseif panel_name == Musk_name then
    --panel.icon = ICONPATH .. "entity/solar-mat.png"
    --panel.icon_size = 64
    --panel.icon_mipmaps = 3
    --panel.BI_add_icon = true
    panel.icons = {
      { icon = ICONPATH .. "entity/solar-mat.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {0, 0} },
    }
    panel.production = "10kW"
    BioInd.show("Adjusted properties of", panel_name)
  end


  --~ data:extend({panel})
  --~ BioInd.created_msg(panel)
  BioInd.create_stuff({panel})

end


------------------------------------------------------------------------------------
--~ -- Testing
--~ for k, v in pairs(data.raw[h_entity.type]) do
  --~ BioInd.writeDebug("%s: %s", {k, v})
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
