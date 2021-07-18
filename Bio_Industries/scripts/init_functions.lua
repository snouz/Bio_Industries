------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                 Handling of compound entities on loading a game                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.entered_file()

local init_functions = {}


------------------------------------------------------------------------------------
--                  Remove all parts of invalid compound entities                 --
------------------------------------------------------------------------------------
init_functions.clean_global_compounds_table = function(entity_name)
  BioInd.entered_function()
BioInd.writeDebug("Entries in BioInd.compound_entities[%s]: %s",
                  {entity_name, table_size(global.compound_entities[entity_name])})

  local entity_table = global.compound_entities[entity_name]
BioInd.show("entity_table", entity_table and entity_table.tab)
  entity_table = entity_table and entity_table.tab and global[entity_table.tab]
BioInd.writeDebug("entity_table: %s", {entity_table}, "line")
  local hidden_entities = global.compound_entities[entity_name].hidden
BioInd.show("hidden_entities", hidden_entities)
  local removed = 0
  -- Scan the whole table
  for c, compound in pairs(entity_table) do
BioInd.writeDebug ("c: %s\tcompound: %s", {c, compound})
    -- No or invalid base entity!
    if not (compound.base and compound.base.valid) then
BioInd.writeDebug("%s (%s) has no valid base entity -- removing entry!", {entity_name, c})

      for h_name, h_entity in pairs(hidden_entities) do
BioInd.writeDebug("Removing %s (%s)", {h_name, h_entity.name})
        BioInd.remove_entity(compound[h_name])
      end
      entity_table[c] = nil
      removed = removed + 1
BioInd.writeDebug("Removed %s %s", {entity_name, c})
    end
  end
BioInd.show("Removed entities", removed)
BioInd.show("Pruned list size", table_size(entity_table))
  BioInd.entered_function("leave")
  return removed
end


------------------------------------------------------------------------------------
--                 Restore the missing parts of compound entities                 --
------------------------------------------------------------------------------------
init_functions.restore_missing_entities = function(entity_name)
  BioInd.entered_function()
BioInd.writeDebug("global.compound_entities[%s]: %s entries",
                  {entity_name, table_size(global.compound_entities[entity_name])})

  local check = global.compound_entities[entity_name]
  local entity_table = check and global[check.tab] or {}
  local hidden_entities = check and check.hidden or {}

  local checked = 0
  local restored = 0
  -- Scan the whole table
  for c, compound in pairs(entity_table) do
    -- Base entity is valid!
    if (compound.base and compound.base.valid) then
BioInd.writeDebug("%s is valid -- checking hidden entities!", {BioInd.print_name_id(compound.base)})
      for h_name, h_entity in pairs(hidden_entities) do
        -- Hidden entity is missing
        if not (compound[h_name] and compound[h_name].valid) then
          BioInd.writeDebug("%s: MISSING!", {h_name})
          BioInd.create_entities(entity_table, compound.base, {[h_name] = h_entity.name})
          restored = restored + 1
          BioInd.writeDebug("Created %s (%s) for %s",
                            {h_name, h_entity.name, BioInd.print_name_id(compound.base)})
        else
          BioInd.writeDebug("%s: OK", {h_name})
        end
      end
      checked = checked + 1
    end
  end
BioInd.writeDebug("Checked %s compound entities", {checked})
BioInd.writeDebug("Restored %s entities", {restored})
  BioInd.entered_function("leave")
  return {checked = checked, restored = restored}
end


------------------------------------------------------------------------------------
--    Function to find all unregistered compound entities of a particular type    --
------------------------------------------------------------------------------------
local register_in_compound_entity_tab = function(compound_name)
  BioInd.entered_function()

  local cnt = 0
  local h_cnt = 0
  local data = global.compound_entities[compound_name]
  if not data then
    BioInd.arg_err(compound_name, "name of a compound entity")
  end

  local g_tab = global[data.tab]
  local found, h_found ,created

  -- Scan all surfaces
  for s, surface in pairs(game.surfaces) do
    -- Check the bases of all compound entities on the surface
    found = surface.find_entities_filtered({name = compound_name})
    for b, base in ipairs(found) do
      -- Base entity isn't registered yet!
      if not g_tab[base.unit_number] then
        BioInd.writeDebug("Found unregistered entity: %s!", {BioInd.print_name_id(base)})
        -- Create an entry in the global table
        g_tab[base.unit_number] = {base = base}
        -- Add optional data to the table, if there are any
        add_optional_data(base)


        -- Check if it already has any hidden entities
        for h_name, h_data in pairs(data.hidden) do
          h_found = surface.find_entities_filtered({
            name = h_data.name,
            type = h_data.type,
            position = BioInd.offset_position(base.position, h_data.base_offset),
          })

          -- Check for multiple hidden entities of the same type in the same position!
          if #h_found > 1 then
            local cnt = 0
            for duplicate = 2, #h_found do
              h_found[duplicate].destroy({raise_destroy = true})
              cnt = cnt + 1
            end
            BioInd.writeDebug("Removed %s duplicate entities (%s)!", {cnt, h_data.name})
          end

          -- There still is one hidden entity left. Add it to the table!
          if next(h_found) then
            BioInd.writeDebug("Found %s -- adding it to the table.", {BioInd.print_name_id(base)})
            g_tab[base.unit_number][h_name] = h_found[1]

          -- Create hidden entity! This will automatically add it to the table.
          else
            created = BioInd.create_entities(g_tab, base, {[h_name] = h_data})
            BioInd.writeDebug("Created hidden %s: %s",
                              {h_name, created and BioInd.print_name_id(created) or "nil"})
            h_cnt = h_cnt + 1
          end
        end
        cnt = cnt + 1
      end
    end
  end
  BioInd.writeDebug("Registered %s compound entities and created %s hidden entities", {cnt, h_cnt})

  BioInd.entered_function("leave")
  return cnt
end


------------------------------------------------------------------------------------
--                     Find all unregistered compound entities                    --
------------------------------------------------------------------------------------
init_functions.find_unregistered_entities = function()
  BioInd.entered_function()

  local cnt = 0
  for compound_entity, c in pairs(global.compound_entities) do
    cnt = cnt + register_in_compound_entity_tab(compound_entity)
  end

  BioInd.writeDebug("Registered %s compound entities.", {cnt})
  BioInd.entered_function("leave")
  return cnt
end


------------------------------------------------------------------------------------
--                     Find all unregistered compound entities                    --
------------------------------------------------------------------------------------
init_functions.check_compound_entity_tabs = function()
  BioInd.entered_function()
  -- Check what global tables we need for compound entities
  BioInd.writeDebug("Get list of tables for compound entities we need to check.")
  local compound_entity_tables = {}
  for compound, compound_data in pairs(global.compound_entities) do
    -- BioInd.compound_entities contains entries that point to the same table
    -- (e.g. straight/curved rails, or overlay entities), so we just overwrite
    -- them to remove duplicates
    compound_entity_tables[compound_data.tab] = compound
  end
  BioInd.show("Must check these tables in global", compound_entity_tables)

  -- Prepare global tables storing data of compound entities
  BioInd.writeDebug("Setting up tables for compound entities.")
  local result
  for compound_tab, compound_name in pairs(compound_entity_tables) do
    -- Init table
    global[compound_tab] = global[compound_tab] or {}
    BioInd.writeDebug("Initialized global[%s] (%s entities stored)",
                      {compound_name, table_size(global[compound_tab])})
    -- If this compound entity requires additional tables in global, initialize
    -- them now!
    local related_tables = global.compound_entities[compound_name].add_global_tables
    if related_tables then
      for t, tab in ipairs(related_tables or {}) do
        global[tab] = global[tab] or {}
        BioInd.writeDebug("Initialized global[%s] (%s values)", {tab, table_size(global[tab])})
      end
    end
    -- If this compound entity requires additional values in global, initialize
    -- them now!
    local related_vars = global.compound_entities[compound_name].add_global_values
    if related_vars then
      for var_name, value in pairs(related_vars or {}) do
        global[var_name] = global[var_name] or value
        BioInd.writeDebug("Set global[%s] to %s", {var_name, global[var_name]})
      end
    end

    -- Clean up global tables (We can skip this for empty tables!)
    if next(global[compound_tab]) then
      -- Remove invalid entities
      result = init_functions.clean_global_compounds_table(compound_name)
      BioInd.writeDebug("Removed %s invalid entries from global[%s]!",
                        {result, compound_tab})
      -- Restore missing hidden entities
      result = init_functions.restore_missing_entities(compound_name)
      BioInd.writeDebug("Checked %s compound entities and restored %s missing hidden entries for global[\"%s\"]!", {result.checked, result.restored, compound_tab})
    end
  end

  -- Search all surfaces for unregistered compound entities
  BioInd.writeDebug("Looking for unregistered entities.")
  result = init_functions.find_unregistered_entities()
  BioInd.writeDebug("Registered %s forgotten entities!", {result})

  BioInd.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")

return init_functions
