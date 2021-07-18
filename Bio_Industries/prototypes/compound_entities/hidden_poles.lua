BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
BioInd.show("Compound entities", BioInd.compound_entities)


------------------------------------------------------------------------------------
--  Create the main prototype for hidden poles. All others will be based on this! --
------------------------------------------------------------------------------------
-- The short name of the hidden entity (e.g. "lamp" or "pole")
local h_key = "pole"
-- The actual prototype type, identified by h_key
local h_type = BioInd.HE_map[h_key]
local h_entity = table.deepcopy(data.raw[h_type]["small-electric-pole"])

BI.set_common_properties(h_entity)


------------------------------------------------------------------------------------
-- Pole specific attributes!
h_entity.draw_copper_wires = BioInd.is_debug
h_entity.draw_circuit_wires = BioInd.is_debug

h_entity.maximum_wire_distance = 10
h_entity.supply_area_distance = 5

--~ hidden_pole.resistances = {}
--~ for damage, d in pairs(data.raw["damage-type"]) do
  --~ hidden_pole.resistances[#hidden_pole.resistances +1] = {
    --~ type = damage,
    --~ percent = 100
  --~ }
--~ end
--~ BioInd.show("hidden_pole.resistances", hidden_pole.resistances)

h_entity.connection_points = BioInd.is_debug and
                              h_entity.connection_points or {
                                {
                                  shadow = {},
                                  wire = { copper_wire_tweak = {0, 0} }
                                }
                              }
--~ h_entity.connection_points = h_entity.connection_points
h_entity.radius_visualisation_picture = BioInd.is_debug and
                                            h_entity.radius_visualisation_picture or BI.hidden_entities.picture


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
  local Musk_name = BioInd.musk_floor_pole_name
  BI.hidden_entities.types[h_key][Musk_name] = "bi-solar-mat"
end

-- We only have one "connector" at the moment. No need to add another file just for that,
-- so let's add this connector manually to the list!
BI.hidden_entities.types[h_key]["bi-bio-farm-hidden-connector_pole"] = "bi-bio-farm"

--~ BioInd.show("BI.hidden_entities.types", BI.hidden_entities.types[h_key])
local function shift_picture(pole, offset)
  if not BioInd.is_debug then
    pole.pictures.shift = offset or {0, 0}
  end
end

------------------------------------------------------------------------------------
-- Make the copies!
local tmp, pole
local c_entities = BioInd.compound_entities

BioInd.writeDebug("BI.hidden_entities.types[%s]: %s", {h_key, BI.hidden_entities.types[h_key]})
--~ for pole_name, locale_name in pairs(pole_list) do
for pole_name, locale_name in pairs(BI.hidden_entities.types[h_key] or {}) do
  --~ pole = table.deepcopy(data.raw["electric-pole"]["bi-hidden-power-pole"])
  pole = table.deepcopy(h_entity)
  pole.name = pole_name
  pole.localised_name = {"entity-name." .. locale_name}
  pole.localised_description = {"entity-description." .. locale_name}
  pole.icon_size = BioInd.is_debug and pole.icon_size or 64
--~ BioInd.show("pole.localised_name", pole.localised_name)
--~ BioInd.show("c_entities[\"bi-straight-rail-power\"].hidden[h_key].name",
              --~ c_entities["bi-straight-rail-power"].hidden[h_key].name)

  ------------------------------------------------------------------------------------
  -- Adjust properties for hidden biofarm poles
  ------------------------------------------------------------------------------------
  if c_entities["bi-bio-farm"] and
      (c_entities["bi-bio-farm"].hidden["connector"] and
        pole_name == c_entities["bi-bio-farm"].hidden["connector"].name) or
      (c_entities["bi-bio-farm"].hidden[h_key] and
        pole_name == c_entities["bi-bio-farm"].hidden[h_key].name) then

    -- We have connectors on the roof of Bio farms, so we want to display connections
    if pole_name == c_entities["bi-bio-farm"].hidden["connector"].name then

      --~ pole.localised_name = {"entity-name.bi-bio-farm"}
      --~ pole.localised_description = {"entity-description.bi-bio-farm"}
      --~ pole.icon = BioInd.is_debug and pole.icon or ICONPATH .. "entity/Bio_Farm_Cabeling.png"

      pole.draw_copper_wires = true
      --~ pole.selectable_in_game = true
      --~ pole.selection_box = {{-.25, -.25}, {.25, .25}}
      local vanilla = table.deepcopy(data.raw[h_type]["small-electric-pole"])
      local cp = vanilla.connection_points[1]
      --~ local offset_x = 1
      --~ local offset_y = 3.7
      --~ local offset_x = 1
      local offset_y = 2.7
      --~ local offset = {offset_x, offset_y}
      --~ local offset = c_entities["bi-bio-farm"].hidden["connector"]

      for img, img_data in ipairs({"shadow", "wire"}) do
        cp[img_data].green = nil
        cp[img_data].red = nil

        cp[img_data].copper[1] = cp[img_data].copper[1] + (offset_x or 0)
        cp[img_data].copper[2] = cp[img_data].copper[2] + (offset_y or 0)
      end
      pole.connection_points = BioInd.is_debug and vanilla.connection_points or {cp}
      pole.pictures = BioInd.is_debug and vanilla.pictures or pole.pictures
      pole.supply_area_distance = 1

      pole.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
      --~ pole.selection_box = {util.add_shift({-0.5, -0.5}, offset), util.add_shift({0.5, 0.5}, offset)}
      pole.selectable_in_game = true
      pole.selection_priority = 100

      shift_picture(pole)
      --~ shift_picture(pole, {offset_x, offset_y})
      BioInd.show("Adjusted properties of", pole_name)

    -- Hidden center pole for supplying the area around the building
    elseif pole_name == c_entities["bi-bio-farm"].hidden[h_key].name then
    --~ else
      --~ pole.draw_copper_wires = true
      pole.maximum_wire_distance = 2
      pole.supply_area_distance = 5
      --~ pole.selection_box = {{-.25, -.25}, {.25, .25}}
      --~ pole.selectable_in_game = true

      shift_picture(pole)
      BioInd.show("Adjusted properties of", pole_name)
    end

  ------------------------------------------------------------------------------------
  -- Adjust properties for hidden power-rail pole
  ------------------------------------------------------------------------------------
  elseif (c_entities["bi-straight-rail-power"] and
            c_entities["bi-straight-rail-power"].hidden[h_key] and
            pole_name == c_entities["bi-straight-rail-power"].hidden[h_key].name) or
          (c_entities["bi-curved-rail-power"] and
            c_entities["bi-curved-rail-power"].hidden[h_key] and
            pole_name == c_entities["bi-curved-rail-power"].hidden[h_key].name) then
  --~ elseif pole_name == c_entities["bi-straight-rail-power"].hidden[h_key].name then

    --~ pole.localised_name = {"entity-name.bi-rail-power"}
    --~ pole.localised_description = {"entity-description.bi-rail-power"}
    pole.maximum_wire_distance = 9
    pole.supply_area_distance = 2
    shift_picture(pole)
    BioInd.show("Adjusted properties of", pole_name)

  ------------------------------------------------------------------------------------
  -- Adjust properties for hidden pole of bio gardens
  ------------------------------------------------------------------------------------
  elseif c_entities["bi-bio-garden"] and
          -- This pole may have been removed because "Easy Gardens" is disabled!
          c_entities["bi-bio-garden"].hidden[h_key] and
          pole_name == c_entities["bi-bio-garden"].hidden[h_key].name then
    pole.maximum_wire_distance = 4
    pole.supply_area_distance = 1
    shift_picture(pole)
    BioInd.show("Adjusted properties of", pole_name)

  ------------------------------------------------------------------------------------
  -- Adjust properties for hidden pole of Solar boiler
  ------------------------------------------------------------------------------------
  elseif c_entities["bi-solar-boiler"] and
          -- This pole may have been removed because "Bio solar additions" is disabled!
          c_entities["bi-solar-boiler"].hidden[h_key] and
          pole_name == c_entities["bi-solar-boiler"].hidden[h_key].name then
    local vanilla = table.deepcopy(data.raw[h_type]["small-electric-pole"])
    pole.pictures = BioInd.is_debug and vanilla.pictures or pole.pictures
    pole.connection_points = BioInd.is_debug and vanilla.connection_points or {{
      shadow = { copper = util.by_pixel(55, 0), },
      wire = { copper = util.by_pixel(-19, -69), },
    }}
    pole.draw_copper_wires = true
    --~ pole.connection_points = {{
      --~ shadow = { copper = util.by_pixel(55, 0), },
      --~ wire = { copper = util.by_pixel(-19, -69), },
    --~ }}
    shift_picture(pole)
    BioInd.show("Adjusted properties of", pole_name)

  ------------------------------------------------------------------------------------
  -- Adjust properties for hidden pole of Solar farm
  ------------------------------------------------------------------------------------
  elseif c_entities["bi-bio-solar-farm"] and
          c_entities["bi-bio-solar-farm"].hidden[h_key] and
          pole_name == c_entities["bi-bio-solar-farm"].hidden[h_key].name then

    local base_entity = BI.additional_entities.BI_Power_Production.solar_farm
    local vanilla = table.deepcopy(data.raw[h_type]["small-electric-pole"])
    local cp = vanilla.connection_points[1]

    pole.supply_area_distance = 1
    pole.maximum_wire_distance = 19
    pole.draw_copper_wires = true
    pole.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
    --~ pole.connection_points = {{
      --~ shadow = { copper = util.by_pixel(60, 0), },
      --~ wire = { copper = util.by_pixel(0, -60), },
    --~ }}
    --~ for img, img_data in ipairs({"shadow", "wire"}) do
      --~ cp[img_data].green = nil
      --~ cp[img_data].red = nil

      --~ cp[img_data].copper[1] = cp[img_data].copper[1] + (offset_x or 0)
      --~ cp[img_data].copper[2] = cp[img_data].copper[2] + (offset_y or 0)
    --~ end
    --~ pole.connection_points = BioInd.is_debug and vanilla.connection_points or {cp}
    pole.connection_points = BioInd.is_debug and vanilla.connection_points or {{
      shadow = { copper = util.by_pixel(60, 0), },
      wire = { copper = util.by_pixel(0, -60), },
    }}
    pole.selectable_in_game = true
    pole.selection_priority = 100
    shift_picture(pole)
    pole.localised_description = {"entity-description." .. pole.name}
    BioInd.show("Adjusted properties of", pole_name)

  ------------------------------------------------------------------------------------
  -- Adjust properties for hidden pole of Musk floor
  ------------------------------------------------------------------------------------
  elseif pole_name == Musk_name then
    pole.icon = ICONPATH .. "entity/solar-mat.png"
    pole.icon_size = 64
    pole.icon_mipmaps = 3
    pole.maximum_wire_distance = 1
    --~ pole.supply_area_distance = 3
    pole.supply_area_distance = 1
    BioInd.show("Adjusted properties of", pole_name)
  end


  BioInd.create_stuff({pole})
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")




--snouz: I couldn't find the hidden pole for the solar boiler, but it should have this position:
--connection_points = {{
--      shadow = { copper = util.by_pixel(55, 0), },
--      wire = { copper = util.by_pixel(-19, -69), },
--    }}
