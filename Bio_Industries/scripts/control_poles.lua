BioInd.entered_file()

---Connect poles

local BI_poles = {}



------------------------------------------------------------------------------------
--          Make a list of the pole types that Bio gardens may connect to         --
------------------------------------------------------------------------------------
BI_poles.get_garden_pole_connectors = function()
  BioInd.entered_function()

  local ret
  if BioInd.get_startup_setting("BI_Game_Tweaks_Easy_Bio_Gardens") then
BioInd.writeDebug("\"Easy gardens\": Compiling list of poles they can connect to!" )
    ret = {}
    local poles = game.get_filtered_entity_prototypes({
      {filter = "type", type = "electric-pole"},
      {filter = "name", name = {
          -- Poles named here will be ignored!
          "bi-bio-garden-hidden-pole",
          "bi-rail-power-hidden-pole",
          BioInd.musk_floor_pole_name,
        }, invert = "true", mode = "and"
      }
    })
    for p, pole in pairs(poles) do
      ret[#ret + 1] = pole.name
    end
  else
BioInd.writeDebug("\"Easy gardens\": Not active -- nothing to do!" )
  end

  BioInd.entered_function("leave")
  return ret
end


------------------------------------------------------------------------------------
--                     Connect the hidden poles of Bio gardens                    --
--  This function may be called for hidden poles that have not been added to the  --
--  table yet if the pole has just been built. In this case, we pass on the new   --
--  pole explicitly!                                                              --
------------------------------------------------------------------------------------
BI_poles.connect_garden_pole = function(base, new_pole)
  BioInd.entered_function({BioInd.argprint(base), BioInd.argprint(new_pole)})

  local compound_entity = global.compound_entities["bi-bio-garden"]
  local pole = global[compound_entity.tab][base.unit_number] and
                global[compound_entity.tab][base.unit_number].pole or
                new_pole

  if pole and pole.valid and  compound_entity.hidden and
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
BioInd.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours - 1})

    for n, neighbour in pairs(neighbours or{}) do
      if pole ~= neighbour then
        connected = pole.connect_neighbour(neighbour)
BioInd.writeDebug("Connected pole %g to %s %g: %s",
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
BioInd.writeDebug("Pole %g has %s neighbours", {pole.unit_number, #neighbours})
    for n, neighbour in pairs(neighbours or{}) do
      connected = pole.connect_neighbour(neighbour)
BioInd.writeDebug("Connected pole %g to neighbour %s (%g): %s",
                {pole.unit_number, neighbour.name, neighbour.unit_number, connected})
    end
  end
  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--                      Connect hidden poles of powered rails                     --
--  This function may be called for hidden poles that have not been added to the  --
--  table yet if the pole has just been built. In this case, we pass on the new   --
--  pole explicitly!                                                              --
------------------------------------------------------------------------------------
BI_poles.connect_power_rail = function(base, new_pole)
  BioInd.entered_function({BioInd.argprint(base), BioInd.argprint(new_pole)})
  --~ local pole_type = "electric-pole"

  local pole = global.bi_power_rail_table[base.unit_number].pole or new_pole
  if pole and pole.valid then
    -- Remove all copper wires from new pole
    pole.disconnect_neighbour()
BioInd.writeDebug("Removed all wires from %s %g", {pole.name, pole.unit_number})

    -- Look for connecting rails at front and back of the new rail
    for s, side in ipairs( {"front", "back"} ) do
BioInd.writeDebug("Looking for rails at %s", {side})
      local neighbour
      -- Look in all three directions
      for d, direction in ipairs( {"left", "straight", "right"} ) do
BioInd.writeDebug("Looking for rails in %s direction", {direction})
        neighbour = base.get_connected_rail{
          rail_direction = defines.rail_direction[side],
          rail_connection_direction = defines.rail_connection_direction[direction]
        }
BioInd.writeDebug("Rail %s of %s (%s): %s (%s)", {direction, base.name, base.unit_number, (neighbour and neighbour.name or "nil"), (neighbour and neighbour.unit_number or "nil")})

        -- Only make a connection if found rail is a powered rail
        -- (We'll know it's the right type if we find it in our table!)
        neighbour = neighbour and neighbour.valid and global.bi_power_rail_table[neighbour.unit_number]
        if neighbour and neighbour.pole and neighbour.pole.valid then
          pole.connect_neighbour(neighbour.pole)
          BioInd.writeDebug("Connected poles!")
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
      BioInd.writeDebug("Connected " .. pole.name .. " (" .. pole.unit_number ..
                        ") to " .. connector[1].name .. " (" .. connector[1].unit_number .. ")")
      BioInd.writeDebug("Connected %s (%g) to %s (%g)", {pole.name, pole.unit_number, connector[1].name, connector[1].unit_number})
    end
    BioInd.writeDebug("Stored %s (%g) in global table", {base.name, base.unit_number})
  end

  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")

return BI_poles
