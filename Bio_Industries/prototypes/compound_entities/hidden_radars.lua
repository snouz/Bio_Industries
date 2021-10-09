BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath

BioInd.debugging.show("Compound entities", BioInd.compound_entities)


------------------------------------------------------------------------------------
--  Create the main prototype for hidden radars. All others will be based on this! --
------------------------------------------------------------------------------------
--~ local h_type = "radar"
--~ local h_entity = table.deepcopy(data.raw[h_type]["radar"])
-- The short name of the hidden entity (e.g. "lamp" or "pole")
local h_key = "radar"
-- The actual prototype type, identified by h_key
local h_type = BioInd.HE_map[h_key]
local h_entity = table.deepcopy(data.raw[h_type]["radar"])

BI.set_common_properties(h_entity)

------------------------------------------------------------------------------------
-- Lamp specific attributes!
h_entity.energy_source.type = "electric"
h_entity.energy_source.usage_priority = "secondary-input"


------------------------------------------------------------------------------------
--      Make a copy of the hidden-entity prototype for each compound entity!      --
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Compile a list of the hidden entities we'll need
BI.make_hidden_entity_list(h_key)


------------------------------------------------------------------------------------
-- Make the copies!
local radar
local c_entities = BioInd.compound_entities

for radar_name, locale_name in pairs(BI.hidden_entities.types[h_key]or {}) do
  radar = table.deepcopy(h_entity)

BioInd.debugging.show("radar_name", radar_name)
BioInd.debugging.show("locale_name", locale_name)
  radar.name = radar_name
  radar.localised_name = {"entity-name." .. locale_name}
  radar.localised_description = {"entity-description." .. locale_name}

--~ BioInd.debugging.show("radar_name", radar_name)
--~ BioInd.debugging.show("radar.name", c_entities["bi-arboretum"].hidden[h_key].name)
  -- Adjust properties for hidden radar of Bio cannon
  if c_entities["bi-bio-cannon"] and
      radar_name == c_entities["bi-bio-cannon"].hidden[h_key].name then

    local base = c_entities["bi-bio-cannon"].base
    base = data.raw[base.type][base.name]

    if base then
      --radar.icon = ICONPATH .. "entity/biocannon_icon.png"
      --radar.icon_size = 64
      --radar.icon_mipmaps = 3
      --radar.BI_add_icon = true
      radar.icons = {
        { icon = ICONPATH .. "entity/biocannon_icon.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {0, 0} },
        { icon = "__base__/graphics/icons/radar.png", icon_size = 64, icon_mipmaps = 4, scale = 0.25, shift = {8, -8} },
      }

      --~ radar.energy_per_sector = "22MJ"
      radar.energy_per_sector = "2MJ"
      --~ radar.energy_per_nearby_scan = "400kW"
      radar.energy_per_nearby_scan = "600kW"
      -- 5 secs per nearby_scan
      --~ radar.energy_usage = "6kW"
      radar.energy_usage = "200kW"
      -- The cannon can only shoot if the radar has power, so we need to show
      -- if it is connected. Also, the collision_box of the radar should be big
      -- enough that it is within reach even of poles with a small supply_area.
      radar.collision_box = base.collision_box
      radar.energy_source.render_no_network_icon = true
      radar.energy_source.render_no_power_icon = true

      --~ radar.max_distance_of_nearby_sector_revealed = 5
      --~ radar.max_distance_of_sector_revealed = 5
      -- Updating nearby sectors is expensive!
      radar.max_distance_of_nearby_sector_revealed = 1
      -- Bio cannon has a range of 120 tiles, so 4 chunks should be enough
      radar.max_distance_of_sector_revealed = 4

      -- We want to be able to see the scanning progress of this radar!
      if BioInd.debugging.is_debug then
          for f, flag in pairs(radar.flags) do
            if flag == "not-selectable-in-game" then
              radar.flags[f] = nil
            end
          end
          radar.selectable_in_game = true
          radar.selection_box = {{-1, -1}, {1, 1}}
          radar.selection_priority = 254
      end
      -- We will turn off the base entity if the radar has no power.
      -- As ammo-turrets don't consume power, the radar must show
      -- these icons!
      radar.energy_source.render_no_network_icon = true
      radar.energy_source.render_no_power_icon = true

      BioInd.debugging.show("Adjusted properties of", radar_name)
    end

  -- Adjust properties for hidden radar of Terraformer
  elseif c_entities["bi-arboretum"] and
            radar_name == c_entities["bi-arboretum"].hidden[h_key].name then

    local base = c_entities["bi-arboretum"].base
    base = data.raw[base.type][base.name]

    radar.localised_name = {"entity-name." .. radar.name}

    --radar.icon = ICONPATH .. "entity/terraformer_radar.png"
    --radar.icon_size = 64
    --radar.icon_mipmaps = 3
    --radar.BI_add_icon = true
    radar.icons = {
      { icon = ICONPATH .. "entity/terraformer.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {0, 0} },
      { icon = "__base__/graphics/icons/radar.png", icon_size = 64, icon_mipmaps = 4, scale = 0.25, shift = {8, -8} },
    }

    -- We want to be able to see the scanning progress of this radar!
    for f, flag in pairs(radar.flags) do
      if flag == "not-selectable-in-game" then
        radar.flags[f] = nil
      end
    end
    radar.selectable_in_game = true
    -- For some reason, the default collision_mask (unset properties will be
    -- set to the default value automatically at the end of the data stage)
    -- must be set to make the radar selectable!
    radar.collision_mask = nil
    radar.collision_box = {{-4.2, -0.7}, {4.2, 7.7}}
    radar.selection_box = {{-1, -1}, {1, 1}}
    radar.selection_priority = 254

    radar.energy_per_sector = "2MJ"
    radar.energy_per_nearby_scan = "200kW"
    radar.energy_source.emissions_per_minute = 0
    radar.energy_usage = "150kW"
    radar.max_distance_of_nearby_sector_revealed = 2
    radar.max_distance_of_sector_revealed = 5

    radar.max_health = 250
    radar.pictures.priority = "high"

    -- We will turn off the base entity if it has no/not enough ingredients
    -- for crafting. However, no-power icons etc. won't be shown for inactive
    -- entities, so we will let the radar show these icons!
    radar.energy_source.render_no_network_icon = true
    radar.energy_source.render_no_power_icon = true

    base.energy_source.render_no_network_icon = false
    base.energy_source.render_no_power_icon = false

    BioInd.debugging.show("Adjusted properties of", radar_name)
  end

  BioInd.create_stuff({radar})
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
