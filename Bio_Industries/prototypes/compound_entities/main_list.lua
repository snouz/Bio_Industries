------------------------------------------------------------------------------------
--  This file contains the data of all compound entities. It will be used in the  --
--  data stage to create the prototypes for the hidden enitities, and during the  --
--  control stage to combine the compound entities and pass on any optional data  --
--  that may be required by the scripts.
------------------------------------------------------------------------------------
log("Entered file " .. debug.getinfo(1).source)
--~ require("util")

-- During the data stage, we want to remove compound entities (or some of their
-- hidden entities) that have been disabled via startup setting, so that we don't
-- spam the game with unnecessary prototypes.
-- During the control stage, we build a separate list of all the compound entities
-- that are available and store it in a global table. We'll need a complete list in
-- this case, so that we can keep track of the removed prototypes and clean out the
-- obsolete tables. We can achieve this by checking for "script" or "data".
-- However, we may also need a complete list during the data stage (e.g. for finding
-- recipes, items etc. of removed compound entity parts). In this case, we'll need
-- to pass on a valid argument (anything not nil) to this function.

local ret = {}

-- Map short handles for hidden entities in the table to actual prototype types
ret.HE_map = {
  ammo_turret = "ammo-turret",
  assembler = "assembling-machine",
  boiler = "boiler",
  lamp = "lamp",
  panel = "solar-panel",
  connector = "electric-pole",
  pole = "electric-pole",
  radar = "radar"
}

ret.HE_map_reverse = {}
for k, v in pairs(ret.HE_map) do
  ret.HE_map_reverse[v] = k
end
--~ log("ret.HE_map_reverse: " .. serpent.block(ret.HE_map_reverse))
------------------------------------------------------------------------------------
-- List of compound entities
-- Key:                 Name of the base entity
-- tab:                 Name of the global table where data of these entity are stored
-- hidden:              Table containing the hidden entities needed by this entity
--                        Key:    handle of the hidden entity
--                        Value:  data needed when placing the hidden entity
-- localize_entity:     Pointer to an entity name -- e.g. {"entity-name.NAME"} -- that
--                      will be used to localize this entity. This is needed when the
--                      same string is used for differently named entity names, such
--                      as "straight-rail"/"curved-rail"/"rail-planner".
-- new_base_name:       If the placed entity is used as overlay, it will be replaced  --                      with this entity.
-- add_global_tables    Table of other tables that should be created in global
--                        Key:   string or number
--                        Value: name of the additional table
--                      If the key is the handle of a hidden entity, then the table
--                      is used to link from this hidden entity to the base entity,
--                      so global[table_name][hidden_entity.unit_number] =
--                              base_entity.unit_number
-- add_global_values    table of names and values of variables that should be added to
--                      the global table if this compound entity is used
-- optional:            Any optional data affecting the compound entity that must be  --                      stored in the global table.
------------------------------------------------------------------------------------
-- Data of hidden entities
-- name:                name of the entity prototype
-- type:                prototype type
-- base_offset:         Position of the hidden entity relative to the base entity
------------------------------------------------------------------------------------

-- We add full data for the base entities because their type can't be deduced from
-- their name. For the hidden entities, we just create the fields and fill in any
-- optional data that may be needed. Name and type of the prototypes will be added
-- later automatically.
ret.compound_entities = {
  ["bi-bio-farm"] = {
    tab = "bi_bio_farm_table",
    base = {
      name = "bi-bio-farm",
      type = ret.HE_map.assembler,
    },
    hidden = {
      -- We have two different hidden poles here, so it should be safer to set type
      -- and name explicitely!
      connector = {
        name = "bi-bio-farm-hidden-connector_pole",
        type = ret.HE_map.pole,
        --~ base_offset = {x = 1.0, y = 1.0},
        --~ base_offset = (script and script.active_mods["_debug"] or mods and mods["_debug"]) and
                      --~ {x = 1.0, y = 1.0} or {x = 0, y = 0},
        base_offset = (script and script.active_mods["_debug"] or mods and mods["_debug"]) and
                      --~ {x = 1.0, y = 1.0} or {x = 1, y = 3.7},
                      {x = 1.0, y = 1.0} or {x = 1, y = 1},
      },
      pole = {
        name = "bi-bio-farm-hidden-pole",
        type = ret.HE_map.pole,
        --~ base_offset = {x = 1.0, y = 1.0},
        base_offset = (script and script.active_mods["_debug"] or mods and mods["_debug"]) and
                      {x = 1.0, y = 1.0} or {x = 0, y = 0},
      },
      panel = {
        --~ name = "bi-bio-farm-hidden-panel",
        --~ type = ret.HE_map.panel,
      },
      lamp = {
        --~ name = "bi-bio-farm-hidden-lamp",
        --~ type = ret.HE_map.lamp
      },
    }
  },
  ["bi-bio-garden"] = {
    tab = "bi_bio_garden_table",
    base = {
      name = "bi-bio-garden",
      type = ret.HE_map.assembler,
    },
    hidden = {
      pole = {},
    }
  },
  ["bi-bio-solar-farm"] = {
    tab = "bi_solar_farm_table",
    base = {
      name = "bi-bio-solar-farm",
      type = ret.HE_map.panel,
    },
    hidden = {
      pole = {},
    }
  },
  ["bi-solar-boiler"] = {
    tab = "bi_solar_boiler_table",
    base = {
      name = "bi-solar-boiler",
      type = ret.HE_map.boiler,
    },
    hidden = {
      panel = {},
      pole = {},
    }
  },
  ["bi-straight-rail-power"] = {
    tab = "bi_power_rail_table",
    base = {
      name = "bi-straight-rail-power",
      type = "straight-rail",
    },
    hidden = {
      pole = {
        name = "bi-rail-power-hidden-pole",
        localize_entity = "bi-rail-power"
        --~ type = ret.HE_map.pole,
      },
    }
  },
  -- Built from blueprint
  ["bi-arboretum"] = {
    tab = "bi_arboretum_table",
    base = {
      name = "bi-arboretum",
      type = ret.HE_map.assembler,
    },
    hidden = {
      radar = {
        base_offset = {x = 0, y = -3.5},
      },
      pole = {},
      lamp = {},
    },
    add_global_tables = {
      -- Key: Hidden entity. Value: Name of the table
      radar = "bi_arboretum_radar_table"
    },
    new_base_name = "bi-arboretum",
  },
  -- Built from blueprint
  ["bi-bio-cannon"] = {
    tab = "bi_bio_cannon_table",
    base = {
      name = "bi-bio-cannon",
      type = "ammo-turret",
    },
    hidden = {
      radar = {},
    },
    add_global_tables = {
      -- Key: Hidden entity. Value: Name of the table
      radar = "bi_bio_cannon_radar_table"
    },
    --~ add_global_values = { Bio_Cannon_Fired = {
        --~ base_pollution = 100,
        --~ base_unit_count = 100,
        --~ base_unit_search_distance = 500,
        --~ modifiers = {
          --~ ["BI_cannon-ammo-proto_create_pollution"] = 0.5,
          --~ ["BI_cannon-ammo-basic_create_pollution"] = 0.75,
          --~ ["BI_cannon-ammo-poison_create_pollution"] = 1,
        --~ },
      --~ }
    --~ },
  },
}


------------------------------------------------------------------------------------
--     Fill in the missing names and types of the hidden entities' prototypes!    --
------------------------------------------------------------------------------------
for c_name, c_data in pairs(ret.compound_entities) do
--~ log("c_name: " .. serpent.block(c_name))
  for h_key, h_data in pairs(c_data.hidden) do
--~ log(string.format("h_key: %s\th_data: %s", h_key, serpent.block(h_data)))
    h_data.name = h_data.name or c_name .. "-hidden-" .. h_key
    h_data.type = h_data.type or ret.HE_map[h_key]
  end
end
--~ log("ret.compound_entities: " .. serpent.block(ret.compound_entities))


------------------------------------------------------------------------------------
--  Remove entries for disabled compound entities. Do this before making copies!  --
------------------------------------------------------------------------------------
--~ ret.get_HE_list = function(get_complete_list)
ret.get_HE_list = function()

  --~ -- Return complete list
  --~ -- Control stage: We need the complete list to remove obsolete tables from global.
  --~ -- Data stage (first pass): Read hidden-entity data for all compound entities.
  --~ if get_complete_list or script then
    --~ log("Preserving complete list!")

  --~ -- Clean up list before returning it
  --~ -- Data stage (second pass): Only keep hidden-entity data for compound entities
  --~ --                           where we have created the main entity!
  --~ else
    --~ log("Removing obsolete entities from the list!")

    --~ -- We still have the complete table to work with. Let's adjust hidden
    --~ -- entities based on individual settings now!
    --~ local settings = settings.startup
    --~ local function get_settings(name)
      --~ return settings[name] and settings[name].value
    --~ end

    --~ -- Easy Bio gardens: We only need the hidden pole if the setting is enabled. (But we
    --~ -- want to keep the rest of the table even if the setting is disabled.)
    --~ if not get_settings("BI_Game_Tweaks_Easy_Bio_Gardens") then
      --~ ret.compound_entities["bi-bio-garden"].hidden.pole = nil
      --~ log("Setting \"Easy Bio gardens\" is disabled. Removed hidden pole from list of hidden entities!")
    --~ end

    --~ -- All base entities required by a setting have been created. We can safely remove
    --~ -- all entries from the list where the base entity doesn't exist!
    --~ local base
    --~ for e_name, e_data in pairs(ret.compound_entities) do
      --~ base = e_data.base
--~ log(string.format("Checking base entity for \"%s\".\nType: %s\tName: %s",
                    --~ e_name, base.type, base.name))
      --~ if not data.raw[base.type][base.name] then
        --~ ret.compound_entities[e_name] =nil
--~ log(string.format("Removed \"%s\" from list of compound entities!", e_name))
      --~ end
    --~ end
  --~ end


  -- Some entities share almost the same data, so we can copy them
  local make_copies = {
    -- Rails
    ["bi-straight-rail-power"] = { name = "bi-curved-rail-power", type = "curved-rail" },
    -- Overlay entities
    ["bi-arboretum"] = { name = "bi-arboretum-area", type = ret.HE_map.ammo_turret },
    --~ ["bi-bio-cannon"] = { name = "bi-bio-cannon-area", type = ret.HE_map.ammo_turret },
  }
  for old, new in pairs(make_copies) do
    if ret.compound_entities[old] then
      ret.compound_entities[new.name] = util.table.deepcopy(ret.compound_entities[old])
      ret.compound_entities[new.name].base.type = new.type
      ret.compound_entities[new.name].base.name = new.name
      --~ log("Added " .. new.name .. " to list of compound entities!")
    end
  end

log("Final list of compound entities:")
for k, v in pairs(ret.compound_entities) do
  log(k)
end
  return ret.compound_entities
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
log("Leaving file " .. debug.getinfo(1).source)

return ret
