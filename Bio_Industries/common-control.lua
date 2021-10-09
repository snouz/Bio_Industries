------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--             Common functions and definitions for the control stage             --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
log("Entered file " .. debug.getinfo(1).source)

local common = require("common")()


------------------------------------------------------------------------------------
--        Make look-up list for event names (used for debugging functions)        --
------------------------------------------------------------------------------------
common.event_names = {}
for name, id in pairs(defines.events) do
  common.event_names[id] = name
end
common.event_names["on_init"] = "on_init"
common.event_names["on_load"] = "on_load"
common.event_names["on_configuration_changed"] = "on_configuration_changed"



------------------------------------------------------------------------------------
--              Do we need to create a special force for Musk floor?              --
------------------------------------------------------------------------------------
common.musk_floor_stuff.UseMuskForce = not common.get_startup_setting("BI_Game_Tweaks_Show_musk_floor_in_mapview")
common.musk_floor_stuff.MuskForceName = "BI-Musk_floor_general_owner"
--~ common.musk_floor_tile_name = "bi-solar-mat"


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
  --~ if type(pos) == "table" and table_size(pos) == 2 then
    --~ local x = pos.x or pos[1]
    --~ local y = pos.y or pos[2]

    --~ return x and y and type(x) == "number" and type(y) == "number" and
            --~ {x = x, y = y} or common.debugging.arg_err(pos, "position")
  --~ end
  local ret
  if type(pos) == "table" and table_size(pos) == 2 then
    local x = pos.x or pos[1]
    local y = pos.y or pos[2]

    ret = x and y and type(x) == "number" and type(y) == "number" and {x = x, y = y}
  end

  return ret or common.debugging.arg_err(pos, "position")
end


------------------------------------------------------------------------------------
--  Calculate the offset position of a hidden entity relative to the base entity  --
------------------------------------------------------------------------------------
common.offset_position = function(base_pos, offset)
  common.debugging.check_args(base_pos, "table", "position")

  base_pos = common.normalize_position(base_pos)
  offset = offset and common.normalize_position(offset) or {x = 0, y = 0}

  return {x = base_pos.x + offset.x, y = base_pos.y + offset.y}
end


------------------------------------------------------------------------------------
--                      Check if argument is a valid surface                      --
------------------------------------------------------------------------------------
common.is_surface = function(surface)
  local t = type(surface)
  return (t == "table" and surface.object_name == "LuaSurface" and surface) or
          ((t == "number" or t == "string") and game.surfaces[surface])
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
common.add_optional_data = function(base)
  common.debugging.entered_function()

  if not (base and base.valid and
          common.compound_entities and common.compound_entities[base.name]) then
    common.debugging.arg_err(base, "base of a compound entity")
  end

  -- Add optional values to global table
  local data = common.compound_entities[base.name]
common.debugging.show("data", data)
  local tab = data.tab
common.debugging.show("tab", tab)
common.debugging.show("global[tab]", global[tab] or "nil")

  local entry = global[tab][base.unit_number]

  for k, v in pairs(data.optional or {}) do
    if entry[k] then
      common.debugging.writeDebug("%s already exists: %s", {k, entry[k]})
    else
      entry[k] = v
      common.debugging.writeDebug("Added data to %s: %s = %s", {common.debugging.print_name_id(base), k, v})
    end
  end
  common.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                       Create and register hidden entities                      --
------------------------------------------------------------------------------------
common.create_entities = function(g_table, base_entity, hidden_entities)
  common.debugging.entered_function({g_table, base_entity, hidden_entities})
  --~ common.debugging.show("#g_table", g_table and table_size(g_table))

  common.debugging.check_args(g_table, "table")
  --~ common.debugging.check_args(base_entity, "table")
  common.debugging.check_args(base_entity, "LuaEntity")
  common.debugging.check_args(hidden_entities, "table", "array of hidden-entity names")

  --~ if not base_entity.valid then
    --~ common.debugging.arg_err(base_entity, "base entity")
  --~ -- A table is required, but it may be empty! (This is needed for the
  --~ -- bio gardens, which only have a hidden pole if the "Easy Gardens"
  --~ -- setting is enabled.)
  --~ elseif not (hidden_entities and type(hidden_entities) == "table") then
    --~ common.debugging.arg_err(hidden_entities, "array of hidden-entity names")
  --~ end
  --~ local base_pos = common.normalize_position(base_entity.position) or
                    --~ common.debugging.arg_err(position or "nil", "position")
  local base_pos = common.normalize_position(base_entity.position)

  local entity, offset, pos

  -- Initialize entry in global table
  g_table[base_entity.unit_number] = g_table[base_entity.unit_number] or {}
  g_table[base_entity.unit_number].base = base_entity

  -- Create hidden entities
  local data
  for key, tab in pairs(hidden_entities) do
common.debugging.writeDebug("key: %s\tname: %s", {key, tab.name})
    data = common.compound_entities[base_entity.name].hidden[key]
common.debugging.show("data", data)
    entity = base_entity.surface.create_entity({
      name = data.name,
      type = data.type,
      position = common.offset_position(base_pos, data.base_offset),
      force = base_entity.force,
    })
common.debugging.writeDebug("Created %s", common.debugging.argprint(entity))
--~ common.debugging.show("script", script)
    --~ -- Raise the event manually, so we can pass on extra data!
    --~ script.raise_event(defines.events.script_raised_built, {
      --~ entity = entity,
      --~ base_entity = base_entity
    --~ })

    -- Make hidden entity unminable/undestructible
    make_unminable({entity})

    -- Add hidden entity to global table
    g_table[base_entity.unit_number][key] = entity

    -- Raise the event manually, so we can pass on extra data!
    script.raise_event(defines.events.script_raised_built, {
      entity = entity,
      base_entity = base_entity
    })
  end

  -- Add optional values to global table
  common.add_optional_data(base_entity)
  common.debugging.writeDebug("g_table[%s]: %s", {base_entity.unit_number, g_table[base_entity.unit_number]})

  common.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--       Check if events must be enabled/disabled in one of the script files      --
------------------------------------------------------------------------------------
common.recheck_conditional_handlers = function(data)
  common.debugging.entered_function()

common.debugging.writeDebug("Checking \"data\"!")
  common.debugging.check_args(data, "table")

  local tables_to_check = data.tables or {}
  local bootstrap_instance = data.bootstrap_instance
  local event_name = data.event_name
  local event_handler = data.event_handler

common.debugging.writeDebug("Checking \"tables_to_check\"!")
  common.debugging.check_args(tables_to_check, "table", "tables to check")
common.debugging.writeDebug("Checking \"bootstrap_instance\"!")
  common.debugging.check_args(bootstrap_instance, "table", "ManagedLuaBootstrap instance")
common.debugging.writeDebug("Checking \"event_handler\"!")
  common.debugging.check_args(event_handler, "function", "event handler")
  --~ common.debugging.check_args(event_name, "string", "event name")

  local enable
  -- Check if any of the tables is not empty
  for t, tab in pairs(tables_to_check) do
    if tab and next(tab) then
      enable = true
      break
    end
  end

  -- Subscribe/unsubscribe to the event
  if enable then
    bootstrap_instance.on_event(event_name, event_handler)
  else
    bootstrap_instance.on_event(event_name, nil)
  end

  common.debugging.entered_function("leave")
  return enable
end


------------------------------------------------------------------------------------
--                      Add a rendering to a compound entity                      --
------------------------------------------------------------------------------------
common.add_rendering = function(data)
  common.debugging.entered_function({data})

  common.debugging.check_args(data, "table")
  common.debugging.check_args(data.table_name, "string", "table name")
  common.debugging.check_args(data.unit_number, "number", "unit number")
  common.debugging.check_args(data.rendering, "string", "rendering name")

  local tab = data.table_name
  local unit_number = data.unit_number
  local r_name = data.rendering

  -- Find entity
  local entity_tab = global[tab] and global[tab][unit_number]
  local entity = entity_tab and entity_tab.base

  -- Get prefefined rendering
  local render_this = common.renderings[r_name]

common.debugging.show("entity_tab", entity_tab)
common.debugging.show("entity.name", entity and entity.name or "nil")
common.debugging.show("entity.valid", entity and entity.valid or "nil")


  if render_this and entity and entity.valid then
common.debugging.writeDebug("Found valid entity")
    -- Entity must not yet have such a rendering!
    if not (entity_tab.renderings and entity_tab.renderings[r_name]) then
common.debugging.writeDebug("Can render to entity")
      local id
      -- These data are required
      render_this.target = entity
      render_this.surface = entity.surface

      -- Add optional data that may have been passed on
      render_this.target_offset = data.target_offset
      render_this.only_in_alt_mode = data.only_in_alt_mode
      render_this.time_to_live = data.time_to_live
common.debugging.show("render_this after adding data", render_this)

      -- Render the thing
      if render_this.sprite then
        id = rendering.draw_sprite(render_this)
        common.debugging.writeDebug("Rendered sprite")
      elseif render_this.animation then
        id = rendering.draw_animation(render_this)
        common.debugging.writeDebug("Rendered animation")
      end
common.debugging.show("id", id)

      -- Register rendering with the entity
      entity_tab.renderings = entity_tab.renderings or {}
      entity_tab.renderings[r_name] = id
common.debugging.show("entity_tab", entity_tab)

      -- Register entity with the rendering
      global.renderings = global.renderings or {}
      global.renderings[id] = {
        table_name = tab,
        unit_number = unit_number,
        rendering = r_name
      }
common.debugging.show("global.renderings", global.renderings)
    end
  end
  common.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                      Remove rendering from compound entity                     --
------------------------------------------------------------------------------------
common.remove_rendering = function(id)
  common.debugging.entered_function({id})

  local rendered = id and global.renderings[id]

  if rendered then
    local tab, unit_number, r_name = rendered.table_name, rendered.unit_number, rendered.rendering

    -- Remove rendering
    if rendering.is_valid(id) then
      rendering.destroy(id)
    end

    -- Remove rendering from entity table
    local entity_tab = tab and unit_number and global[tab] and global[tab][unit_number]
    if entity_tab and entity_tab.renderings and r_name then
      entity_tab.renderings[r_name] = nil
      common.debugging.writeDebug("Removed rendering %s from global[%s][%s]", {r_name, tab, unit_number})

      -- Remove table of renderings if this was the last rendering for this entity
      if not next(entity_tab.renderings) then
        entity_tab.renderings = nil
        common.debugging.writeDebug("Removed empty renderings table from global[%s][%s]", {tab, unit_number})
      end
    end

    -- Remove entry from renderings table
    global.renderings[id] = nil
    common.debugging.writeDebug("Removed rendering %s from global,renderings", {id})

    -- Remove table of renderings if this was the last rendering for this entity
    if not next(global.renderings) then
        global.renderings = nil
        common.debugging.writeDebug("Removed empty renderings table from global")
    end
  end

  common.debugging.entered_function("leave")
end



-- Tiles with a fertility value
common.tree_stuff.tile_fertility = {
  ["vegetation-green-grass-1"]          = 100,
  ["grass-1"]                           = 100,
  ["vegetation-green-grass-3"]          =  85,
  ["grass-3"]                           =  85,
  ["vegetation-green-grass-2"]          =  75,
  ["vegetation-yellow-grass-2"]         =  70,
  ["vegetation-yellow-grass-1"]         =  70,
  ["vegetation-violet-grass-2"]         =  70,
  ["vegetation-violet-grass-1"]         =  70,
  ["vegetation-turquoise-grass-2"]      =  70,
  ["vegetation-turquoise-grass-1"]      =  70,
  ["vegetation-red-grass-2"]            =  70,
  ["vegetation-red-grass-1"]            =  70,
  ["vegetation-purple-grass-2"]         =  70,
  ["vegetation-purple-grass-1"]         =  70,
  ["vegetation-orange-grass-2"]         =  70,
  ["vegetation-orange-grass-1"]         =  70,
  ["vegetation-olive-grass-2"]          =  70,
  ["vegetation-olive-grass-1"]          =  70,
  ["vegetation-mauve-grass-2"]          =  70,
  ["vegetation-mauve-grass-1"]          =  70,
  ["vegetation-green-grass-4"]          =  70,
  ["vegetation-blue-grass-2"]           =  70,
  ["vegetation-blue-grass-1"]           =  70,
  ["grass-2"]                           =  70,
  ["grass-4"]                           =  60,
  ["red-desert-0"]                      =  50,
  ["mineral-black-dirt-2"]              =  45,
  ["mineral-black-dirt-1"]              =  45,
  ["mineral-beige-dirt-2"]              =  45,
  ["mineral-beige-dirt-1"]              =  45,
  ["mineral-aubergine-dirt-2"]          =  45,
  ["mineral-aubergine-dirt-1"]          =  45,
  ["dirt-3"]                            =  40,
  ["dirt-5"]                            =  37,
  ["dirt-6"]                            =  34,
  ["dirt-7"]                            =  31,
  ["dirt-4"]                            =  28,
  ["mineral-white-dirt-9"]              =  25,
  ["mineral-white-dirt-8"]              =  25,
  ["mineral-white-dirt-7"]              =  25,
  ["mineral-white-dirt-6"]              =  25,
  ["mineral-white-dirt-5"]              =  25,
  ["mineral-white-dirt-4"]              =  25,
  ["mineral-white-dirt-3"]              =  25,
  ["mineral-white-dirt-2"]              =  25,
  ["mineral-white-dirt-1"]              =  25,
  ["mineral-violet-dirt-9"]             =  25,
  ["mineral-violet-dirt-8"]             =  25,
  ["mineral-violet-dirt-7"]             =  25,
  ["mineral-violet-dirt-6"]             =  25,
  ["mineral-violet-dirt-5"]             =  25,
  ["mineral-violet-dirt-4"]             =  25,
  ["mineral-violet-dirt-3"]             =  25,
  ["mineral-violet-dirt-2"]             =  25,
  ["mineral-violet-dirt-1"]             =  25,
  ["mineral-tan-dirt-9"]                =  25,
  ["mineral-tan-dirt-8"]                =  25,
  ["mineral-tan-dirt-7"]                =  25,
  ["mineral-tan-dirt-6"]                =  25,
  ["mineral-tan-dirt-5"]                =  25,
  ["mineral-tan-dirt-4"]                =  25,
  ["mineral-tan-dirt-3"]                =  25,
  ["mineral-tan-dirt-2"]                =  25,
  ["mineral-tan-dirt-1"]                =  25,
  ["mineral-red-dirt-9"]                =  25,
  ["mineral-red-dirt-8"]                =  25,
  ["mineral-red-dirt-7"]                =  25,
  ["mineral-red-dirt-6"]                =  25,
  ["mineral-red-dirt-5"]                =  25,
  ["mineral-red-dirt-4"]                =  25,
  ["mineral-red-dirt-3"]                =  25,
  ["mineral-red-dirt-2"]                =  25,
  ["mineral-red-dirt-1"]                =  25,
  ["mineral-purple-dirt-9"]             =  25,
  ["mineral-purple-dirt-8"]             =  25,
  ["mineral-purple-dirt-7"]             =  25,
  ["mineral-purple-dirt-6"]             =  25,
  ["mineral-purple-dirt-5"]             =  25,
  ["mineral-purple-dirt-4"]             =  25,
  ["mineral-purple-dirt-3"]             =  25,
  ["mineral-purple-dirt-2"]             =  25,
  ["mineral-purple-dirt-1"]             =  25,
  ["mineral-grey-dirt-9"]               =  25,
  ["mineral-grey-dirt-8"]               =  25,
  ["mineral-grey-dirt-7"]               =  25,
  ["mineral-grey-dirt-6"]               =  25,
  ["mineral-grey-dirt-5"]               =  25,
  ["mineral-grey-dirt-4"]               =  25,
  ["mineral-grey-dirt-3"]               =  25,
  ["mineral-grey-dirt-2"]               =  25,
  ["mineral-grey-dirt-1"]               =  25,
  ["mineral-dustyrose-dirt-9"]          =  25,
  ["mineral-dustyrose-dirt-8"]          =  25,
  ["mineral-dustyrose-dirt-7"]          =  25,
  ["mineral-dustyrose-dirt-6"]          =  25,
  ["mineral-dustyrose-dirt-5"]          =  25,
  ["mineral-dustyrose-dirt-4"]          =  25,
  ["mineral-dustyrose-dirt-3"]          =  25,
  ["mineral-dustyrose-dirt-2"]          =  25,
  ["mineral-dustyrose-dirt-1"]          =  25,
  ["mineral-cream-dirt-9"]              =  25,
  ["mineral-cream-dirt-8"]              =  25,
  ["mineral-cream-dirt-7"]              =  25,
  ["mineral-cream-dirt-6"]              =  25,
  ["mineral-cream-dirt-5"]              =  25,
  ["mineral-cream-dirt-4"]              =  25,
  ["mineral-cream-dirt-3"]              =  25,
  ["mineral-cream-dirt-2"]              =  25,
  ["mineral-cream-dirt-1"]              =  25,
  ["mineral-brown-dirt-9"]              =  25,
  ["mineral-brown-dirt-8"]              =  25,
  ["mineral-brown-dirt-7"]              =  25,
  ["mineral-brown-dirt-6"]              =  25,
  ["mineral-brown-dirt-5"]              =  25,
  ["mineral-brown-dirt-4"]              =  25,
  ["mineral-brown-dirt-3"]              =  25,
  ["mineral-brown-dirt-2"]              =  25,
  ["mineral-brown-dirt-1"]              =  25,
  ["mineral-black-dirt-9"]              =  25,
  ["mineral-black-dirt-8"]              =  25,
  ["mineral-black-dirt-7"]              =  25,
  ["mineral-black-dirt-6"]              =  25,
  ["mineral-black-dirt-5"]              =  25,
  ["mineral-black-dirt-4"]              =  25,
  ["mineral-black-dirt-3"]              =  25,
  ["mineral-beige-dirt-9"]              =  25,
  ["mineral-beige-dirt-8"]              =  25,
  ["mineral-beige-dirt-7"]              =  25,
  ["mineral-beige-dirt-6"]              =  25,
  ["mineral-beige-dirt-5"]              =  25,
  ["mineral-beige-dirt-4"]              =  25,
  ["mineral-beige-dirt-3"]              =  25,
  ["mineral-aubergine-dirt-9"]          =  25,
  ["mineral-aubergine-dirt-8"]          =  25,
  ["mineral-aubergine-dirt-7"]          =  25,
  ["mineral-aubergine-dirt-6"]          =  25,
  ["mineral-aubergine-dirt-5"]          =  25,
  ["mineral-aubergine-dirt-4"]          =  25,
  ["mineral-aubergine-dirt-3"]          =  25,
  ["dry-dirt"]                          =  25,
  ["dirt-2"]                            =  22,
  ["dirt-1"]                            =  19,
  ["red-desert-2"]                      =  16,
  ["mineral-aubergine-sand-2"]          =  15,
  ["mineral-aubergine-sand-1"]          =  15,
  ["red-desert-3"]                      =  13,
  ["sand-3"]                            =  10,
  ["mineral-white-sand-3"]              =  10,
  ["mineral-white-sand-2"]              =  10,
  ["mineral-white-sand-1"]              =  10,
  ["mineral-violet-sand-3"]             =  10,
  ["mineral-violet-sand-2"]             =  10,
  ["mineral-violet-sand-1"]             =  10,
  ["mineral-tan-sand-3"]                =  10,
  ["mineral-tan-sand-2"]                =  10,
  ["mineral-tan-sand-1"]                =  10,
  ["mineral-red-sand-3"]                =  10,
  ["mineral-red-sand-2"]                =  10,
  ["mineral-red-sand-1"]                =  10,
  ["mineral-purple-sand-3"]             =  10,
  ["mineral-purple-sand-2"]             =  10,
  ["mineral-purple-sand-1"]             =  10,
  ["mineral-grey-sand-3"]               =  10,
  ["mineral-grey-sand-2"]               =  10,
  ["mineral-grey-sand-1"]               =  10,
  ["mineral-dustyrose-sand-3"]          =  10,
  ["mineral-dustyrose-sand-2"]          =  10,
  ["mineral-dustyrose-sand-1"]          =  10,
  ["mineral-cream-sand-3"]              =  10,
  ["mineral-cream-sand-2"]              =  10,
  ["mineral-cream-sand-1"]              =  10,
  ["mineral-brown-sand-3"]              =  10,
  ["mineral-brown-sand-2"]              =  10,
  ["mineral-brown-sand-1"]              =  10,
  ["mineral-black-sand-3"]              =  10,
  ["mineral-black-sand-2"]              =  10,
  ["mineral-black-sand-1"]              =  10,
  ["mineral-beige-sand-3"]              =  10,
  ["mineral-beige-sand-2"]              =  10,
  ["mineral-beige-sand-1"]              =  10,
  ["mineral-aubergine-sand-3"]          =  10,
  ["sand-2"]                            =   7,
  ["sand-1"]                            =   4,
  ["volcanic-purple-heat-4"]            =   1,
  ["volcanic-purple-heat-3"]            =   1,
  ["volcanic-purple-heat-2"]            =   1,
  ["volcanic-purple-heat-1"]            =   1,
  ["volcanic-orange-heat-4"]            =   1,
  ["volcanic-orange-heat-3"]            =   1,
  ["volcanic-orange-heat-2"]            =   1,
  ["volcanic-orange-heat-1"]            =   1,
  ["volcanic-green-heat-4"]             =   1,
  ["volcanic-green-heat-3"]             =   1,
  ["volcanic-green-heat-2"]             =   1,
  ["volcanic-green-heat-1"]             =   1,
  ["volcanic-blue-heat-4"]              =   1,
  ["volcanic-blue-heat-3"]              =   1,
  ["volcanic-blue-heat-2"]              =   1,
  ["volcanic-blue-heat-1"]              =   1,
  ["red-desert-1"]                      =   1,
  ["frozen-snow-9"]                     =   1,
  ["frozen-snow-8"]                     =   1,
  ["frozen-snow-7"]                     =   1,
  ["frozen-snow-6"]                     =   1,
  ["frozen-snow-5"]                     =   1,
  ["frozen-snow-4"]                     =   1,
  ["frozen-snow-3"]                     =   1,
  ["frozen-snow-2"]                     =   1,
  ["frozen-snow-1"]                     =   1,
  ["frozen-snow-0"]                     =   1,
  ["landfill"]                          =   1,
}



------------------------------------------------------------------------------------
--                    Things we may want to render on entities                    --
------------------------------------------------------------------------------------
common.renderings = {
  missing_ingredients = {
    sprite = "missing_ingredients",
    render_layer = "entity-info-icon-above",
    only_in_alt_mode = false,
  },
}

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
--~ common.debugging.entered_file("leave")
  log("Leaving file " .. debug.getinfo(1).source)
return common
