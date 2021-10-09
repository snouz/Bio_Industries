BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


BioInd.debugging.show("Compound entities", BioInd.compound_entities)
local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
--  Create the main prototype for hidden lamps. All others will be based on this! --
------------------------------------------------------------------------------------
-- The short name of the hidden entity (e.g. "lamp" or "pole")
local h_key = "lamp"
-- The actual prototype type, identified by h_key
local h_type = BioInd.HE_map[h_key]
local h_entity = table.deepcopy(data.raw[h_type]["small-lamp"])

BI.set_common_properties(h_entity)

------------------------------------------------------------------------------------
-- Lamp specific attributes!
h_entity.energy_source.type = "void"
h_entity.energy_source.usage_priority = "lamp"

h_entity.energy_usage_per_tick = "100kW"
h_entity.light = {intensity = 1, size = 45}
h_entity.light_when_colored= {intensity = 0, size = 0}
h_entity.signal_to_color_mapping = {}

h_entity.circuit_connector_sprites = {}
for l, led in ipairs({"red", "green", "blue", "light"}) do
  h_entity.circuit_connector_sprites["led_" .. led] = BI.hidden_entities.picture
  h_entity.circuit_connector_sprites["led_" .. led].intensity = 0
end

h_entity.picture_off = BI.hidden_entities.picture
--~ h_entity.picture_off.shift = {0.75, 0}

h_entity.picture_on = BI.hidden_entities.picture
--~ h_entity.picture_on.shift = {0.75, 0}


------------------------------------------------------------------------------------
--      Make a copy of the hidden-entity prototype for each compound entity!      --
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Compile a list of the hidden entities we'll need
BI.make_hidden_entity_list(h_key)

------------------------------------------------------------------------------------
-- Make the copies!
local lamp
local c_entities = BioInd.compound_entities

for lamp_name, locale_name in pairs(BI.hidden_entities.types[h_key] or {}) do
  lamp = table.deepcopy(h_entity)
  lamp.name = lamp_name
  lamp.localised_name = {"entity-name." .. locale_name}
  lamp.localised_description = {"entity-description." .. locale_name}

  -- Adjust properties for hidden lamp of Bio farm
  if c_entities["bi-bio-farm"] and
      lamp_name == c_entities["bi-bio-farm"].hidden[h_type].name then

    --lamp.icon = ICONPATH .. "entity/biofarm_lamp.png"
    --lamp.icon_size = 64
    --lamp.icon_mipmaps = 3
    --lamp.BI_add_icon = true
    lamp.icons = {
      { icon = ICONPATH .. "entity/biofarm.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
      { icon = "__base__/graphics/icons/small-lamp.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, 16} },
    }
    BioInd.debugging.show("Adjusted properties of", lamp_name)
  end

  --~ data:extend({lamp})
  --~ BioInd.debugging.created_msg(lamp)
  BioInd.create_stuff({lamp})
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
