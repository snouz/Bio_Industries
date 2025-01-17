------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--               Control connections of poles from compound entities              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

local BI_poles = {}



------------------------------------------------------------------------------------
--          Make a list of the pole types that Bio gardens may connect to         --
------------------------------------------------------------------------------------
BI_poles.get_garden_pole_connectors = function()
  BioInd.debugging.entered_function()

  local ret
  if BioInd.get_startup_setting("BI_Game_Tweaks_Easy_Bio_Gardens") then
BioInd.debugging.writeDebug("\"Easy gardens\": Compiling list of poles they can connect to!" )
    ret = {}
    local poles = game.get_filtered_entity_prototypes({
      {filter = "type", type = "electric-pole"},
      {filter = "name", name = {
          -- Poles named here will be ignored!
          "bi-bio-garden-hidden-pole",
          "bi-rail-power-hidden-pole",
          BioInd.musk_floor_stuff.musk_floor_pole_name,
        }, invert = "true", mode = "and"
      }
    })
    for p, pole in pairs(poles) do
      ret[#ret + 1] = pole.name
    end
  else
BioInd.debugging.writeDebug("\"Easy gardens\": Not active -- nothing to do!" )
  end

  BioInd.debugging.entered_function("leave")
  return ret
end


------------------------------------------------------------------------------------
--                     Connect the hidden poles of Bio gardens                    --
--  This function may be called for hidden poles that have not been added to the  --
--  table yet if the pole has just been built. In this case, we pass on the new   --
--  pole explicitly!                                                              --
------------------------------------------------------------------------------------
BI_poles.connect_garden_pole = function(base, new_pole)
  BioInd.debugging.entered_function({BioInd.debugging.argprint(base), BioInd.debugging.argprint(new_pole)})

  local compound_entity = BioInd.compound_entities and BioInd.compound_entities["bi-bio-garden"]
  local pole = compound_entity and global[compound_entity.tab] and
                global[compound_entity.tab][base.unit_number] and
                global[compound_entity.tab][base.unit_number].pole or
                new_pole

  if pole and pole.valid and compound_entity.hidden and
                              compound_entity.hidden.pole and
                              compound_entity.hidden.pole.name then
    local wire_reach = game.entity_prototypes[compound_entity.hidden.pole.name] and
                        game.entity_prototypes[compound_entity.hidden.pole.name].max_wire_distance
    if not wire_reach then
      error("Prototype for hidden pole of Bio gardens doesn't exist!")
    end

    pole.disconnect_neighbour()

    -- Each pole can only have 5 connections. Let's connect to other hidden
    -- poles first!
    local connected
    local neighbours = pole.surface.find_entities_filtered({
      position = pole.position,
      radius = wire_reach,
      type = "electric-pole",
      name = compound_entity.hidden.pole.name
    })
BioInd.debugging.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours - 1})

    for n, neighbour in pairs(neighbours or{}) do
      if pole ~= neighbour then
        connected = pole.connect_neighbour(neighbour)
BioInd.debugging.writeDebug("Connected pole %g to %s %g: %s",
                {pole.unit_number, neighbour.name, neighbour.unit_number, connected})
      end
    end

    -- Look for other poles around this one
    neighbours = pole.surface.find_entities_filtered({
      position = pole.position,
      radius = wire_reach,
      type = "electric-pole",
      name = global.mod_settings.garden_pole_connectors,
    })
BioInd.debugging.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours})
    for n, neighbour in pairs(neighbours or{}) do
      connected = pole.connect_neighbour(neighbour)
BioInd.debugging.writeDebug("Connected pole %g to neighbour %s (%g): %s",
                {pole.unit_number, neighbour.name, neighbour.unit_number, connected})
    end
  end
  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                      Connect hidden poles of powered rails                     --
--  This function may be called for hidden poles that have not been added to the  --
--  table yet if the pole has just been built. In this case, we pass on the new   --
--  pole explicitly!                                                              --
------------------------------------------------------------------------------------
BI_poles.connect_power_rail = function(base, new_pole)
  BioInd.debugging.entered_function({BioInd.debugging.argprint(base), BioInd.debugging.argprint(new_pole)})
  --~ local pole_type = "electric-pole"

  local pole = global.bi_power_rail_table[base.unit_number].pole or new_pole
  if pole and pole.valid then
    -- Remove all copper wires from new pole
    pole.disconnect_neighbour()
BioInd.debugging.writeDebug("Removed all wires from %s %g", {pole.name, pole.unit_number})

    -- Look for connecting rails at front and back of the new rail
    for s, side in ipairs( {"front", "back"} ) do
BioInd.debugging.writeDebug("Looking for rails at %s", {side})
      local neighbour
      -- Look in all three directions
      for d, direction in ipairs( {"left", "straight", "right"} ) do
BioInd.debugging.writeDebug("Looking for rails in %s direction", {direction})
        neighbour = base.get_connected_rail{
          rail_direction = defines.rail_direction[side],
          rail_connection_direction = defines.rail_connection_direction[direction]
        }
BioInd.debugging.writeDebug("Rail %s of %s (%s): %s (%s)", {direction, base.name, base.unit_number, (neighbour and neighbour.name or "nil"), (neighbour and neighbour.unit_number or "nil")})

        -- Only make a connection if found rail is a powered rail
        -- (We'll know it's the right type if we find it in our table!)
        neighbour = neighbour and neighbour.valid and global.bi_power_rail_table[neighbour.unit_number]
        if neighbour and neighbour.pole and neighbour.pole.valid then
          pole.connect_neighbour(neighbour.pole)
          BioInd.debugging.writeDebug("Connected poles!")
        end
      end
    end

    -- Look for Power-rail connectors
    local connector = base.surface.find_entities_filtered{
      position = base.position,
      -- maximum_wire_distance of Power-to-rail-connectors
      radius = BioInd.POWER_TO_RAIL_WIRE_DISTANCE,
      name = "bi-power-to-rail-pole"
    }
    -- Connect to first Power-rail connector we've found
    if connector and next(connector) then
      pole.connect_neighbour(connector[1])
      BioInd.debugging.writeDebug("Connected " .. pole.name .. " (" .. pole.unit_number ..
                        ") to " .. connector[1].name .. " (" .. connector[1].unit_number .. ")")
      BioInd.debugging.writeDebug("Connected %s (%g) to %s (%g)", {pole.name, pole.unit_number, connector[1].name, connector[1].unit_number})
    end
    BioInd.debugging.writeDebug("Stored %s (%g) in global table", {base.name, base.unit_number})
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                Make sure hidden poles of are wired up correctly!               --
------------------------------------------------------------------------------------
BI_poles.connect_poles = function(pole, base)
  BioInd.debugging.entered_function({BioInd.debugging.argprint(pole), BioInd.debugging.argprint(base)})

  local entities = BioInd.compound_entities

  if pole then
    -- The hidden entities are listed with a common handle ("pole", "panel" etc.). We
    -- can get it from the reverse-lookup list via the entity type!
    local h_key = BioInd.HE_map_reverse[pole.type]
    BioInd.debugging.show("h_key", h_key or "nil")

    -- Make sure hidden poles of the Bio gardens are connected correctly!
    if pole.name == (entities["bi-bio-garden"] and
                      entities["bi-bio-garden"].hidden and
                      entities["bi-bio-garden"].hidden[h_key] and
                      entities["bi-bio-garden"].hidden[h_key].name) and base then
  BioInd.debugging.writeDebug("Bio garden!")
      BI_poles.connect_garden_pole(base, pole)
      BioInd.debugging.writeDebug("Connected %s (%s)", {pole.name, pole.unit_number or "nil"})

    -- Make sure hidden poles for powered rails are connected correctly!
    elseif pole.name == (entities["bi-straight-rail-power"] and
                          entities["bi-straight-rail-power"].hidden and
                          entities["bi-straight-rail-power"].hidden[h_key] and
                          entities["bi-straight-rail-power"].hidden[h_key].name) and base then
  BioInd.debugging.writeDebug("Powered rail!")
      BI_poles.connect_power_rail(base, pole)
      BioInd.debugging.writeDebug("Connected %s", {BioInd.debugging.print_name_id(pole)})

    -- Do nothing for rail-to-power connectors
    elseif pole.name == "bi-power-to-rail-pole" then
      BioInd.debugging.writeDebug("Nothing to do for %s", {BioInd.debugging.print_name_id(pole)})

    -- Some other pole has been placed -- check if we need to break connections!
    else
  BioInd.debugging.writeDebug("Must disconnect?")
      local musk_floor_neighbours = {}
      for n, neighbour in ipairs(pole.neighbours["copper"] or {}) do
        -- Disconnect other poles from hidden poles on powered rails
        if neighbour.name == (entities["bi-straight-rail-power"] and
                              entities["bi-straight-rail-power"].hidden and
                              entities["bi-straight-rail-power"].hidden[h_key] and
                              entities["bi-straight-rail-power"].hidden[h_key].name) then
          pole.disconnect_neighbour(neighbour)
          BioInd.debugging.writeDebug("Disconnected %s from %s",
                            {BioInd.debugging.print_name_id(pole), BioInd.debugging.print_name_id(neighbour)})
        -- Find neighbours that are hidden poles from Musk floor
        elseif neighbour.name == BioInd.musk_floor_pole_name then
          musk_floor_neighbours[#musk_floor_neighbours + 1] = neighbour
        end
      end
      -- If there is more than one Musk-floor neighbour, cut excess connections
  BioInd.debugging.show("Musk floor neighbours", musk_floor_neighbours)
      if #musk_floor_neighbours > 1 then
        for n = 2, #musk_floor_neighbours do
          pole.disconnect_neighbour(musk_floor_neighbours[n])
  BioInd.debugging.writeDebug("Broke connection with %s", {BioInd.debugging.argprint(musk_floor_neighbours[n])})
        end
      end
    end
  end
BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--  If a compound entity is moved (Picker Dollies!), cut connections that exceed  --
--  the poles' wire reach!                                                        --
------------------------------------------------------------------------------------
BI_poles.disconnect_faraway = function(compound)
  BioInd.debugging.entered_function({data})

  if compound and compound.base and compound.base.valid then
    local data = BioInd.compound_entities and BioInd.compound_entities[compound.base.name]
    local pole, max_distance, wire_reach, circuit_wire_reach

    for h_key, h_data in pairs(data and data.hidden or {}) do
      if h_data.type == "electric-pole" then
        wire_reach = h_data.max_wire_distance or 0
        circuit_wire_reach = h_data.max_circuit_wire_distance or 0

        if compound[h_key] and compound[h_key].valid then
          pole = compound[h_key]
BioInd.debugging.show("pole neighbours", pole.neighbours)

          for wire, w_neighbours in pairs(pole.neighbours) do
            max_distance = (wire == "copper") and wire_reach or circuit_wire_reach
            BioInd.debugging.writeDebug("Checking neighbours for %s wire (max_distance: %s)",
                              {wire, max_distance})
            for n, neighbour in pairs(w_neighbours) do
              if util.distance(pole.position, neighbour.position) > max_distance then
                if wire == "copper" then
                  pole.disconnect_neighbour(neighbour)
                else
                  pole.disconnect_neighbour({
                    wire = defines.wire_type[wire],
                    target_entity = neighbour
                  })
                end
                BioInd.debugging.writeDebug("Disconnected  %s wire from %s (%s tiles away)", {
                  wire, BioInd.debugging.argprint(neighbour), util.distance(pole.position, neighbour.position)
                })
              end
            end
          end
        end
      end
    end
  end
  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_poles
