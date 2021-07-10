log("Entered file " .. debug.getinfo(1).source)

local common = require("common")()



--~ ------------------------------------------------------------------------------------
--~ -- List of compound entities
--~ -- Key:       name of the base entity
--~ -- tab:       name of the global table where data of these entity are stored
--~ -- hidden:    table containing the hidden entities needed by this entity
--~ --            (Key:   name under which the hidden entity will be stored in the table;
--~ --             Value: name of the entity that should be placed)
--~ common.compound_entities = compound_entities.get_HE_list("complete")
--~ log("compound entities: " .. serpent.block(common.compound_entities))
--~ -- Map the short handles of hidden entities (e.g. "pole") to real prototype types
--~ -- (e.g. "electric-pole")
--~ common.HE_map = compound_entities.HE_map
--~ -- Reverse lookup
--~ common.HE_map_reverse = compound_entities.HE_map_reverse

--~ -- We can't store Musk floor with the compound_entities because it has no unit_number
--~ -- but must be identified by its position. So let's store the names of its hidden
--~ -- entities for later use!
--~ common.musk_floor_pole_name = "bi-musk-mat-hidden-pole"
--~ common.musk_floor_panel_name = "bi-musk-mat-hidden-panel"


------------------------------------------------------------------------------------
--                 Remove an individual entity and raise an event!                --
------------------------------------------------------------------------------------
common.remove_entity = function(entity)
  if entity and entity.valid then
    entity.destroy{raise_destroy = true}
  end
end


------------------------------------------------------------------------------------
--                        Make sure positions have x and y!                       --
------------------------------------------------------------------------------------
common.normalize_position = function(pos)
  if pos and type(pos) == "table" and table_size(pos) == 2 then
    local x = pos.x or pos[1]
    local y = pos.y or pos[2]
    if x and y and type(x) == "number" and type(y) == "number" then
      return { x = x, y = y }
    end
  end
end


------------------------------------------------------------------------------------
--  Calculate the offset position of a hidden entity relative to the base entity  --
------------------------------------------------------------------------------------
common.offset_position = function(base_pos, offset)
  common.check_args(base_pos, "table", "position")
  offset = offset or {x = 0, y = 0}
  common.check_args(offset, "table", "position")

  base_pos = common.normalize_position(base_pos)
  offset = common.normalize_position(offset)

  return {x = base_pos.x + offset.x, y = base_pos.y + offset.y}
end


------------------------------------------------------------------------------------
--                      Check if argument is a valid surface                      --
------------------------------------------------------------------------------------
common.is_surface = function(surface)
  local t = type(surface)
  surface = (t == "number" or t == "string" and game.surfaces[surface]) or
            (t == "table" and surface.object_name and
                              surface.object_name == "LuaSurface" and surface)
  return surface
end


------------------------------------------------------------------------------------
--                Make hidden entities unminable and indestructible               --
------------------------------------------------------------------------------------
local function make_unminable(entities)
  for e, entity in ipairs(entities or {}) do
    if entity.valid then
      entity.minable = false
      entity.destructible = false
    end
  end
end


------------------------------------------------------------------------------------
--        Add all optional values for a compound entity to the table entry        --
------------------------------------------------------------------------------------
local add_optional_data = function(base)
  common.entered_function()

  if not (base and base.valid and global.compound_entities[base.name]) then
    common.arg_err(base, "base of a compound entity")
  end

  -- Add optional values to global table
  local data = global.compound_entities[base.name]
common.show("data", data)
  local tab = data.tab
common.show("tab", tab)
common.show("global[tab]", global[tab] or "nil")

  local entry = global[tab][base.unit_number]

  for k, v in pairs(data.optional or {}) do
    if entry[k] then
      common.writeDebug("%s already exists: %s", {k, entry[k]})
    else
      entry[k] = v
      common.writeDebug("Added data to %s: %s = %s", {common.print_name_id(base), k, v})
    end
  end
  common.entered_function("leave")
end


------------------------------------------------------------------------------------
--                       Create and register hidden entities                      --
------------------------------------------------------------------------------------
common.create_entities = function(g_table, base_entity, hidden_entities)
  common.entered_function()
  common.show("#g_table", g_table and table_size(g_table))

  common.check_args(g_table, "table")
  common.check_args(base_entity, "table")

  if not base_entity.valid then
    common.arg_err(base_entity, "base entity")
  -- A table is required, but it may be empty! (This is needed for the
  -- bio gardens, which only have a hidden pole if the "Easy Gardens"
  -- setting is enabled.)
  elseif not (hidden_entities and type(hidden_entities) == "table") then
    common.arg_err(hidden_entities, "array of hidden-entity names")
  end
  local base_pos = common.normalize_position(base_entity.position) or
                    common.arg_err(position or "nil", "position")

  local entity, offset, pos

  -- Initialize entry in global table
  g_table[base_entity.unit_number] = g_table[base_entity.unit_number] or {}
  g_table[base_entity.unit_number].base = base_entity

  -- Create hidden entities
  local data
  for key, tab in pairs(hidden_entities) do
common.writeDebug("key: %s\tname: %s", {key, tab})
    data = global.compound_entities[base_entity.name].hidden[key]
common.show("data", data)
    entity = base_entity.surface.create_entity({
      name = data.name,
      type = data.type,
      position = common.offset_position(base_pos, data.base_offset),
      force = base_entity.force,
    })
    -- Raise the event manually, so we can pass on extra data!
    script.raise_event(defines.events.script_raised_built, {
      entity = entity,
      base_entity = base_entity
    })

    -- Make hidden entity unminable/undestructible
    make_unminable({entity})

    -- Add hidden entity to global table
    g_table[base_entity.unit_number][key] = entity
  end

  -- Add optional values to global table
  add_optional_data(base_entity)
  common.writeDebug("g_table[%s]: %s", {base_entity.unit_number, g_table[base_entity.unit_number]})

  common.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
log("Leaving file " .. debug.getinfo(1).source)

return common
