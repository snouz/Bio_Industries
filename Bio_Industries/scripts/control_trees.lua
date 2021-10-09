------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               TREE GROWING STUFF                               --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

-- ManagedLuaBootstrap instance from ErLib
local tree_growing_script = BioInd.erlib.Events.get_managed_script("trees")

-- Eradicator's Library uses the on_configuration_changed event for on_init as well.
-- If the mod is added to an existing game, the event will trigger two times, but
-- we only need to run the code once, so we check for this flag.
local initialized


local terrains = require("libs/trees-and-terrains")

local BI_trees = {}




------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 AutoCache stuff                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--       Generate a look-up table with the names of the trees we care about       --
------------------------------------------------------------------------------------
local get_bi_trees = function(list)
  BioInd.debugging.entered_function({list})

  --~ BioInd.tree_stuff.tree_types = {}
  --~ local list = BioInd.tree_stuff.tree_types

  local trees = game.get_filtered_entity_prototypes({{filter = "type", type = "tree"}})
  for tree_name, tree in pairs(trees) do
    if tree_name:match("^bio%-tree%-.+%-%d$") then
      BioInd.debugging.show("Found matching tree", tree_name)
      list[tree_name] = true
    end
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--      Generate dictionary with the names of tiles that can't be fertilized      --
------------------------------------------------------------------------------------
local get_barren_tiles = function(list)
  BioInd.debugging.entered_function({list})

  --~ BioInd.tree_stuff.barren_tiles = {}
  --~ local list = BioInd.tree_stuff.barren_tiles
  local barren_tile_patterns = {
    ".*concrete.*",
    ".*stone%-path.*",
    "^bi%-solar%-mat$",
    "^bi%-wood%-floor$",
  }

  for tile_name, tile in pairs(game.tile_prototypes) do
    for p, pattern in ipairs(barren_tile_patterns) do
      if tile_name:match(pattern) then
BioInd.debugging.show("Found matching tile", tile_name)
        -- If a tile is minable and fertilizer is used on it, we must deduct the mined
        -- tiles from the player/robot again!
        list[tile_name] = tile.mineable_properties.products or true
      end
    end
  end
  BioInd.debugging.show("Forbidden tiles", list)

  BioInd.debugging.entered_function("leave")
end


-- List of tree prototypes created by BI
BioInd.tree_stuff.tree_types = BioInd.erlib.Cache.AutoCache(get_bi_trees)

-- List of tile prototypes that can't be fertilized
BioInd.tree_stuff.barren_tiles = BioInd.erlib.Cache.AutoCache(get_barren_tiles)

-- List of tile prototypes that using common/advanced fertilizer will produce
BioInd.tree_stuff.fertilizer_tiles = BioInd.erlib.Cache.AutoCache(BioInd.tree_stuff.AB_tiles)



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               Local functions                                  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
-- This will be filled with the tables that must be filled if the on_tick event
-- should be active.
local check_tables_for_on_tick = {}

------------------------------------------------------------------------------------
--     Get tree growing tables we need to check for enabling/disabling on_tick    --
------------------------------------------------------------------------------------
local function get_on_tick_tables()
  if not next(check_tables_for_on_tick) then
    for tab_name, tab in pairs(global.checks.bi_trees or {}) do
      table.insert(check_tables_for_on_tick, tab)
    end
  end
end


------------------------------------------------------------------------------------
--      Check on initializing/loading a game whether on_tick must be enabled      --
------------------------------------------------------------------------------------
local function init_on_tick()
  BioInd.debugging.entered_function()
  local enabled

  -- If there already are trees stored, activate on_tick for growing checks!
  get_on_tick_tables()
BioInd.debugging.show("check_tables_for_on_tick", check_tables_for_on_tick)
  enabled = BioInd.recheck_conditional_handlers({
    tables = check_tables_for_on_tick,
    bootstrap_instance = tree_growing_script,
    event_name = defines.events.on_tick,
    event_handler = BI_trees.check_tree_growing
  })
  BioInd.debugging.writeDebug("Turned %s on_tick for tree growing script!",
                    {enabled and "on" or "off"})

  BioInd.debugging.entered_function("leave")
end



--~ local ticked_actions = {
  --~ check_on_tick = function()
    --~ BioInd.debugging.entered_function()

    --~ local disable_event = true
    --~ for t, tab in pairs(check_tables_for_on_tick) do
      --~ if tab and next(tab) then
        --~ disable_event = false
        --~ BioInd.debugging.writeDebug("Found table that still contains data (%s tables checked)!", t)
        --~ break
      --~ end
    --~ end

    --~ if disable_event then
      --~ tree_growing_script.on_event(defines.events.on_tick, nil)
      --~ BioInd.debugging.writeDebug("Turned off handler for on_tick!")
    --~ else
      --~ BioInd.debugging.writeDebug("Keeping on_tick enabled!")
    --~ end

    --~ BioInd.debugging.entered_function("leave")
  --~ end
--~ }

BI_trees.check_trees_on_tick = function()
  BioInd.debugging.entered_function()

  local disable_event = true
  for t, tab in pairs(check_tables_for_on_tick) do
    if tab and next(tab) then
      disable_event = false
      BioInd.debugging.writeDebug("Found table that still contains data (%s tables checked)!", t)
      break
    end
  end

  if disable_event then
    tree_growing_script.on_event(defines.events.on_tick, nil)
    BioInd.debugging.writeDebug("Turned off handler for on_tick!")
  else
    BioInd.debugging.writeDebug("Keeping on_tick enabled!")
  end

  BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
--         Schedule a check whether the on_tick event should be turned off        --
------------------------------------------------------------------------------------
local function enqueue_disable_on_tick()
  BioInd.debugging.entered_function()

  BioInd.erlib.TickedAction.enqueue('trees', 'check_trees_on_tick', 1)
  BioInd.debugging.writeDebug("Enqueued check for disabling on_tick event!")

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--  Debugging mode: When a function is entered, just show the number of elements  --
--      in a table passed on as an argument unless the table is really short!     --
------------------------------------------------------------------------------------
local function show_short_tables(tab)
  return #tab <= 3 and tab or "array with "..#tab.." elements"
end


------------------------------------------------------------------------------------
--                               Get tile fertility                               --
------------------------------------------------------------------------------------
local function get_tile_fertility(surface, position)
  surface = BioInd.is_surface(surface) or BioInd.debugging.arg_err(surface or "nil", "surface")
  position = BioInd.normalize_position(position) or BioInd.debugging.arg_err(position or "nil", "position")

  --~ local fertility = BI_trees.fertility[surface.get_tile(position.x, position.y).name]
  local tile_name = surface.get_tile(position.x, position.y).name

  local fertility = BioInd.tree_stuff.tile_fertility[tile_name]
  local barren    = (not fertility) and BioInd.tree_stuff.barren_tiles[tile_name]

BioInd.debugging.show("fertility", fertility)
BioInd.debugging.show("barren", barren)


  return (fertility and {fertility = fertility, key = "fertilizer"}) or
          (not barren and {fertility = 1, key = "default"}) or
          {fertility = 0, key = "barren"}
end


------------------------------------------------------------------------------------
--                                 Growing chance                                 --
------------------------------------------------------------------------------------
local function sum_weight(tabl)
  BioInd.debugging.entered_function()

  local sum = 0
  for i, tree_weights in pairs(tabl or {}) do
    if (type(tree_weights) == "table") and tree_weights.weight then
      sum = sum + tree_weights.weight
    end
  end

  BioInd.debugging.entered_function("leave")
  return sum
end


------------------------------------------------------------------------------------
--                     Decide what tree will grow from a seed                     --
------------------------------------------------------------------------------------
local function tree_from_max_index_tabl(max_index, tabl)
  BioInd.debugging.entered_function({max_index})

  BioInd.debugging.check_args(max_index, "number")

  local ret
  local rnd_index = math.random(max_index)

  for tree_name, tree_weights in pairs(tabl or {}) do
    if (type(tree_weights) == "table") and tree_weights.weight then
      rnd_index = rnd_index - tree_weights.weight
      if rnd_index <= 0 then
        ret = tree_name
        break
      end
    end
  end

  BioInd.debugging.entered_function("leave")
  return ret
end

local function random_tree(surface, position)
  BioInd.debugging.entered_function({surface, position})

  surface = BioInd.is_surface(surface) or BioInd.debugging.arg_err(surface or "nil", "surface")
  position = position and BioInd.normalize_position(position) or
                    BioInd.debugging.arg_err(position or "nil", "position")
  local tile_name = surface.get_tile(position.x, position.y).name
  local ret

--~ BioInd.debugging.show("random_tree: tile_name", tile_name)
--~ BioInd.debugging.show("terrains[tile_name]", terrains[tile_name])
  if terrains[tile_name] then
    local trees_table = terrains[tile_name]
    local max_index = sum_weight(trees_table)
BioInd.debugging.writeDebug("Found %s in table terrains. trees_table: %s\tmax_index: %s", {tile_name,trees_table, max_index})
    ret = tree_from_max_index_tabl(max_index, trees_table)
  end

  BioInd.debugging.entered_function({surface, position}, "leave")
  return ret
end


------------------------------------------------------------------------------------
--                                  Plant a tree                                  --
------------------------------------------------------------------------------------
local function plant_tree(tabl, tree, create_entity)
  --~ BioInd.debugging.entered_function({#tabl < 3 and tabl or "array with "..#tabl.." elements", tree, create_entity})
  BioInd.debugging.entered_function({show_short_tables(tabl), tree, create_entity})

  BioInd.debugging.check_args(tabl, "table")
  BioInd.debugging.check_args(tree, "table")
  BioInd.debugging.check_args(tree.time, "number", "time")

  -- When this has been called by plant_seed(), we only add tree data to the table,
  -- without creating a tree. At this point, we don't know yet what kind of tree the
  -- seedling will grow into, so tree.tree_name is nil and check_args() would fail!
  if create_entity then
    BioInd.debugging.check_args(tree.tree_name, "string", "tree_name")
  end

  if not (tree.position and BioInd.normalize_position(tree.position)) then
    BioInd.debugging.arg_err(tree.position or "nil", "position")
  elseif not (tree.surface and BioInd.is_surface(tree.surface)) then
    BioInd.debugging.arg_err(tree.surface or "nil", "surface")
  end

  -- Update table
  table.insert(tabl, tree)
  table.sort(tabl, function(a, b) return a.time < b.time end)

  -- Plant the new tree
  if create_entity then
    tree.surface.create_entity({
      name = tree.tree_name,
      position = tree.position,
      force = "neutral"
    })
  end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                Plant a tree seed                               --
------------------------------------------------------------------------------------
-- t_base, t_penalty: numbers; seedbomb: Boolean
local function plant_seed(event, t_base, t_penalty, seedbomb)
  BioInd.debugging.entered_function({event, t_base, t_penalty, seedbomb})

  BioInd.debugging.check_args(event, "table")
  BioInd.debugging.check_args(t_base, "number")
  BioInd.debugging.check_args(t_penalty, "number")

  -- Seed planted (Put the seedling in the table)
  local entity = event.entity or event.created_entity or
                  BioInd.debugging.arg_err("nil", "entity")
  local surface = BioInd.is_surface(entity.surface) or
                  BioInd.debugging.arg_err(entity.surface or "nil", "surface")
  local pos = BioInd.normalize_position(entity.position) or
                  BioInd.debugging.arg_err(entity.position or "nil", "position")
BioInd.debugging.show("entity", BioInd.debugging.argprint(entity))
BioInd.debugging.show("entity.position", entity.position)
  -- Minimum will always be 1
  local fertility = get_tile_fertility(surface, pos).fertility

  -- Things will grow faster on more fertile tiles
  -- (No penalty for tiles with maximum fertility)
  local grow_time = math.max(1, math.random(t_base) + t_penalty - (40 * fertility))

  local tree_data = {
    position = pos,
    time = event.tick + grow_time,
    surface = surface,
    seed_bomb = seedbomb
  }

  -- We still keep the seedling at this point. After growing time, we'll check if
  -- it will die or make the transition to the first tree stage.
  local create_entity = false

  plant_tree(global.checks.bi_trees.growing, tree_data, create_entity)

  -- Register on_tick event
  tree_growing_script.on_event(defines.events.on_tick, BI_trees.check_tree_growing)
  BioInd.debugging.writeDebug("Registered on_tick event for tree growing!")

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                               Tree growing stages                              --
------------------------------------------------------------------------------------
-- Settings used for the different grow stages
local stage_settings = {
  [1] = {
    fertilizer = {max = 1500, penalty = 3000, factor = 30},
    default = {max = 1500, penalty = 6000, factor = 30},
  },
  [2] = {
    fertilizer = {max = 1000, penalty = 2000, factor = 20},
    default = {max = 1500, penalty = 6000, factor = 30},
  },
  [3] = {
    fertilizer = {max = 1000, penalty = 2000, factor = 20},
    default = {max = 1500, penalty = 6000, factor = 30},
  },
}

-- Decide if a seedling will survive and grow into a tree. Decide what tree it
-- will become!
local function Grow_tree_from_seedling(first_stage_table, event)
  BioInd.debugging.entered_function({show_short_tables(first_stage_table), event})

  BioInd.debugging.check_args(first_stage_table, "table")
  BioInd.debugging.check_args(event, "table")

  local surface = BioInd.is_surface(first_stage_table.surface) or
                    BioInd.debugging.arg_err(first_stage_table.surface or "nil", "surface")
  local position = BioInd.normalize_position(first_stage_table.position) or
                    BioInd.debugging.arg_err(first_stage_table.position or "nil", "position")
  local seed_bomb = first_stage_table.seed_bomb
  local tree = surface.find_entities_filtered({
    name = {"seedling", "seedling-2", "seedling-3"},
    position = position
  })[1]

  local f = get_tile_fertility(surface, position)
  local fertility, key = f.fertility, f.key
BioInd.debugging.show("fertility", fertility)
BioInd.debugging.show("key", key)

  -- Random value. Tree will grow if this value is smaller than the 'Fertility' value
  local whither_chance = math.random(100)

  local tree_name, can_be_placed

  -- Choose a tree type, depending on the terrain
  if tree then
BioInd.debugging.show("tree", tree)
    tree_name = random_tree(surface, position)
BioInd.debugging.writeDebug("Found a seedling! It should grow into a %s.", tree_name)

    -- Only proceed if we've got a tree name!
    if tree_name then

      -- Seedling was planted by seedbomb. There will be lots of seedlings planted all
      -- at once, so this will place a heavy load on the game. We'd better get it over
      -- with as soon as possible and turn all seedlings into trees at the end of this
      -- stage!
      if seed_bomb then
        BioInd.debugging.writeDebug("Seed bomb was used!")
        -- Remove the seedling
        tree.destroy()

        -- Try to convert seedling into a tree if it has been planted on a tile that's
        -- listed in BioInd.tree_stuff.tile_fertility.
        if key == "fertilizer" then
          BioInd.debugging.writeDebug("Tree can grow on this ground.")
          if whither_chance <= fertility then
            tree = surface.create_entity{
              name = tree_name,
              position = position,
              force = "neutral"
            }
            if not tree then
              BioInd.debugging.writeDebug("Seedling died (couldn't place tree).")
            end
          else
            BioInd.debugging.writeDebug("Seedling died (fertility of ground was too low).")
          end
        else
          BioInd.debugging.writeDebug("Seedling died (forbidden ground).")
        end
        enqueue_disable_on_tick()

      -- Seedling has been planted manually or by a terraformer
      else
        BioInd.debugging.writeDebug("Seedling was planted manually or by a terraformer.")
        -- Remove seedling
        tree.destroy()

        -- Convert seedling into a tree. This will never succeed on barren tiles, and
        -- always succeed if the tile is listed in BioInd.tree_stuff.tile_fertility. It
        -- may succeed on other tiles.
        --~ if key == "fertilizer" then
        if key ~= "barren" then
          BioInd.debugging.writeDebug("Tree can grow on this ground.")
          -- Grow the new tree
          can_be_placed = surface.can_place_entity({
            name = tree_name,
            position = position,
            force = "neutral"
          })

          if can_be_placed and key == "fertilizer" or whither_chance <= (fertility + 5) then
            BioInd.debugging.writeDebug("A tree can grow here!")
            -- Trees will grow faster on more Fertile tiles
            local grow_time = math.max(1, math.random(2000) + 4000 - (40 * fertility))
  BioInd.debugging.show("grow_time", grow_time)

            local stage_1_tree_name = "bio-tree-" .. tree_name .. "-1"
            if not BioInd.tree_stuff.tree_types[stage_1_tree_name] then
              stage_1_tree_name = tree_name
            end
    BioInd.debugging.writeDebug("stage_1_tree_name: %s", {stage_1_tree_name})

            local tree_data = {
              tree_name = stage_1_tree_name,
              final_tree = tree_name,
              position = position,
              time = event.tick + grow_time,
              surface = surface
            }
            local create_entity = true
            plant_tree(global.checks.bi_trees.stage_1, tree_data, create_entity)

          end
        else
          enqueue_disable_on_tick()
        end
      end
    else
      enqueue_disable_on_tick()
    end
  else
    enqueue_disable_on_tick()
  end

  BioInd.debugging.entered_function("leave")
end



-- Tree stages
local function Grow_tree_stage(stage_table, stage)
  --~ BioInd.debugging.entered_function({stage_table, stage})
  BioInd.debugging.entered_function({show_short_tables(stage_table), stage})
  BioInd.debugging.check_args(stage_table, "table")
  BioInd.debugging.check_args(stage, "number")


  BioInd.debugging.check_args(stage_table.tree_name, "string", "tree_name")
  BioInd.debugging.check_args(stage_table.final_tree, "string", "final_tree")
  BioInd.debugging.check_args(stage_table.time, "number", "time")

  local tree_name = stage_table.tree_name
  local final_tree = stage_table.final_tree
  local time_planted = stage_table.time

  local surface = BioInd.is_surface(stage_table.surface) or
                    BioInd.debugging.arg_err(stage_table.surface or "nil", "surface")
  local position = BioInd.normalize_position(stage_table.position) or
                    BioInd.debugging.arg_err(stage_table.position or "nil", "position")


  local tree = tree_name and surface.find_entity(tree_name, position)
  if tree then
    tree.destroy()

    local next_stage = stage + 1

    -- Ground may have been fertilized since we last checked it, better get the
    -- current fertility value of the tile!
    local f = get_tile_fertility(surface, position)
    local fertility, key = f.fertility, f.key

    local next_stage_tree_name = "bio-tree-" .. final_tree .. "-" .. next_stage
    if BioInd.tree_stuff.tree_types[next_stage_tree_name] then
      BioInd.debugging.writeDebug("Next stage %g: %s", {next_stage, next_stage_tree_name})
    else
      BioInd.debugging.writeDebug("Next stage %g: Prototype does not exist", {next_stage})
      next_stage_tree_name = final_tree
    end

    local can_be_placed = surface.can_place_entity{
      name = next_stage_tree_name,
      position = position,
      force = "neutral"
    }

    if can_be_placed then
        -- Tree is fully grown and disappears from the tables!
      if next_stage_tree_name == final_tree then
        BioInd.debugging.writeDebug("Tree has reached final stage. Try to place final tree!")
        surface.create_entity({
          name = final_tree,
          position = position,
          force = "neutral"
        })

          -- Do we still need on_tick?
        enqueue_disable_on_tick()

        -- Move tree to next stage
      else
        -- Trees will grow faster on more fertile tiles!
        local s = stage_settings[stage][key]
        local grow_time = math.max(1, math.random(s.max) + s.penalty - (s.factor * fertility))

        local tree_data = {
          tree_name = next_stage_tree_name,
          final_tree = final_tree,
          position = position,
          time = time_planted + grow_time,
          surface = surface
        }
        plant_tree(global.checks.bi_trees["stage_" .. next_stage], tree_data, true)
      end
    -- Do we still need on_tick?
    else
        enqueue_disable_on_tick()
    end
  -- Do we still need on_tick?
  else
    enqueue_disable_on_tick()
  end
  BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Functions visible from other files                       --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
--                             Manually planted seeds                             --
------------------------------------------------------------------------------------
BI_trees.seed_planted = function(event)
  BioInd.debugging.entered_function({event})

  local base_time, penalty = 1000, 4000
  plant_seed(event, base_time, penalty)

  BioInd.debugging.entered_function({event}, "leave")
end


------------------------------------------------------------------------------------
--                              Planted by arboretum                              --
------------------------------------------------------------------------------------
BI_trees.seed_planted_arboretum = function(event, entity)
  BioInd.debugging.entered_function({event, entity})

  event.entity = entity
  local base_time, penalty = 2000, 6000
  plant_seed(event, base_time, penalty)

  BioInd.debugging.entered_function({event}, "leave")
end


------------------------------------------------------------------------------------
--                             Planted with seedbombs                             --
------------------------------------------------------------------------------------
BI_trees.seed_planted_trigger = function(event)
  BioInd.debugging.entered_function({event})

  -- Seedbombs with fertilizer/advanced fertilizer will create different entities,
  -- but the seedlings planted by basic seedbombs are the same as those planted
  -- manually or by terraformers, so we need this flag to tell them apart.
  local seedbomb = true
  local base_time, penalty = 2000, 6000
  plant_seed(event, base_time, penalty, seedbomb)

  BioInd.debugging.entered_function({event}, "leave")
end



------------------------------------------------------------------------------------
--                            Remove trees from tables                            --
------------------------------------------------------------------------------------
BI_trees.remove_plants = function(tabl, entity_position)
  --~ BioInd.debugging.entered_function({entity_position, tabl})
  BioInd.debugging.entered_function({show_short_tables(tabl), entity_position})

    local entity = BioInd.normalize_position(entity_position)
    if not entity then
      BioInd.debugging.arg_err(entity_position or "nil", "position")
    end
    BioInd.debugging.check_args(tabl, "table")

    local pos

    -- Find and remove the entity
    for k, v in pairs(tabl or {}) do
      pos = BioInd.normalize_position(v.position)
      if pos and pos.x == entity.x and pos.y == entity.y then
BioInd.debugging.writeDebug("Removing entry %s from table: %s", {k, v})
        table.remove(tabl, k)
        break
      end
    end

    -- Disable on_tick event? (If this table still has elements we don't need to
    -- waste time on checking other tables first!)
    if not next(tabl) then
      enqueue_disable_on_tick()
    end

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--      Check if any seedlings/trees will transition to next stage this tick      --
------------------------------------------------------------------------------------
---- Growing Tree
BI_trees.check_tree_growing = function(event)
  BioInd.debugging.entered_event(event)

  -- Seedlings making transition to first tree stage
  while next(global.checks.bi_trees.growing) do
    -- Stop if the first tree's "time" is in the future! (Table sorted by tree.time)
    --~ if event.tick < global.checks.bi_trees.growing[1].time then
    if event.tick and
        global.checks.bi_trees.growing[1].time and
        event.tick < global.checks.bi_trees.growing[1].time then
      -- BioInd.debugging.writeDebug("Still growing")
      break
    end
if global.checks.bi_trees.growing[1] then
-- BioInd.debugging.writeDebug("Check if seedling will die or become a tree!")
    Grow_tree_from_seedling(global.checks.bi_trees.growing[1], event)
    table.remove(global.checks.bi_trees.growing, 1)
-- BioInd.debugging.writeDebug("global.checks.bi_trees.growing: %s", {global.checks.bi_trees.growing}, "line")
end
  end

  -- Trees growing through the different stages
  for stage = 1, 4 do
    local stage_table = global.checks.bi_trees["stage_" .. stage]
    while next(stage_table) do
      -- Stop if the first tree's "time" is in the future! (Table sorted by tree.time)
      if event.tick < stage_table[1].time then
        break
      end
      -- Transition to next growing stage or final tree
      Grow_tree_stage(stage_table[1], stage)
      table.remove(stage_table, 1)
    end
  end
  BioInd.debugging.entered_event(event, "leave")
end



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                        Register events on loading a game                       --
------------------------------------------------------------------------------------
tree_growing_script.on_load(function()
  local event = {name = "on_load"}
  BioInd.debugging.entered_event(event)

  -- If there already are trees stored, activate on_tick for growing checks!
  if global.checks.bi_trees then
    init_on_tick()
  end

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                         Initialize a new or loaded game                        --
------------------------------------------------------------------------------------
tree_growing_script.on_configuration_changed(function(event)
  event = event or {}; event.name = "on_configuration_changed"
  BioInd.debugging.entered_event(event)

  -- If the mod was added to an existing game, this event has already been triggered
  -- for on_init, so we can skip it for on_configuration_changed!
  if initialized then
    BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    return
  end

  -- Initialize tables
  BioInd.debugging.writeDebug("Creating/restoring tables for tree growing.")
  global.checks.bi_trees = global.checks.bi_trees or {}
  global.checks.bi_trees.growing = global.checks.bi_trees.growing or {}
  for i = 1, 4 do
    global.checks.bi_trees["stage_" .. i] = global.checks.bi_trees["stage_" .. i] or {}
  end

  -- Make sure that the lists of growing trees don't contain removed tree prototypes!
  -- (Necessary when a mod providing trees, e.g. "Alien Biomes", has been removed.)
  local trees = BioInd.tree_stuff.tree_types
  local tab
  -- Growing stages
  for i = 1, 4 do
    tab = global.checks.bi_trees["stage_" .. i]
  BioInd.debugging.writeDebug("Number of trees in growing stage %s: %s", {i, table_size(tab)})

    for t = #tab, 1, -1 do
      if not trees[tab[t].tree_name] then
        BioInd.debugging.writeDebug("Removing invalid tree %s (%s)", {t, tab[t].tree_name})
        table.remove(tab, t)
      end
    end
    --~ -- Removing trees will create gaps in the table, but we need it as a continuous
    --~ -- list. (Trees need to be sorted by growing time, and we always look at the
    --~ -- tree with index 1 when checking if a tree has completed the growing stage, so
    --~ -- lets sort the table after all invalid trees have been removed!)
    --~ table.sort(tab, function(a, b) return a.time < b.time end)
  BioInd.debugging.show("Number of trees in final list", #tab)
  end

  -- If there already are trees stored, activate on_tick for growing checks!
  init_on_tick()

  -- Mark game as initialized
  initialized = true

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                    on_player_built_tile, on_robot_built_tile                   --
------------------------------------------------------------------------------------
local tile_build_events = {
  defines.events.on_player_built_tile,
  defines.events.on_robot_built_tile,
}
tree_growing_script.on_event(tile_build_events, function(event)
  BioInd.debugging.entered_event(event)
  local tile = event.tile


  -- Fertilizer/Advanced fertilizer has been used. Check if the tile was valid
  -- (no Musk floor, no wooden floor, no concrete etc.)
  --~ elseif item and (item.name == "fertilizer" or item.name == "bi-adv-fertilizer") then
  if tile.name == BioInd.tree_stuff.fertilizer_tiles.common or
      tile.name == BioInd.tree_stuff.fertilizer_tiles.advanced then

    -- Called from player, bot and script-raised events, so event may
    -- contain "robot" or "player_index"
    local surface = game.surfaces[event.surface_index]
    local player = event.player_index and game.players[event.player_index]
    local robot = event.robot
    local force = (BioInd.musk_floor_stuff.UseMuskForce and BioInd.musk_floor_stuff.MuskForceName) or
                  (event.player_index and game.players[event.player_index].force.name) or
                  (event.robot and event.robot.force.name) or
                  event.force.name
  BioInd.debugging.show("Force.name", force)

    -- Item that was used to place the tile
    local item = event.item
    local old_tiles = event.tiles


    local position --, x, y

    local restore_tiles = {}
    local products

    for index, t in pairs(old_tiles or {tile}) do
BioInd.debugging.show("index", index)
BioInd.debugging.show("t.old_tile.name", t.old_tile.name)

      -- We want to restore removed tiles if nothing is supposed to grow on them!
      if BioInd.tree_stuff.barren_tiles[t.old_tile.name] then
BioInd.debugging.writeDebug("%s was used on forbidden ground (%s)!", {item.name, t.old_tile.name})
        restore_tiles[#restore_tiles + 1] = {name = t.old_tile.name, position = t.position}

        -- Is that tile minable?
        products = BioInd.tree_stuff.barren_tiles[t.old_tile.name]
        if type(products) == "table" then
          for p, product in ipairs(products) do
            if player then
BioInd.debugging.writeDebug("Removing %s (%s) from player %s", {product.name, product.amount, player.name})
              player.remove_item({name = product.name, count = product.amount})
            elseif robot then
BioInd.debugging.writeDebug("Removing %s (%s) from robot %s", {product.name, product.amount, robot.unit_number})
              robot.remove_item({name = product.name, count = product.amount})
            end
          end
        end
      end
    end
BioInd.debugging.show("restore_tiles", restore_tiles)
    if restore_tiles then
      surface.set_tiles(
        restore_tiles,
        true,         -- correct_tiles
        true,         -- remove_colliding_entities
        true,         -- remove_colliding_decoratives
        true          -- raise_event
      )
    end

  end

  BioInd.debugging.entered_event(event, "leave")
end)


--~ ------------------------------------------------------------------------------------
--~ --                      Can we unregister the on_tick event?                      --
--~ ------------------------------------------------------------------------------------
--~ tree_growing_script.on_event(BioInd.erlib.Events.events.on_ticked_action, function(event)
  --~ BioInd.debugging.entered_event(event)

  --~ if event.module_name == 'trees' then
    --~ if event.method_name == 'check_on_tick' then
      --~ ticked_actions.check_on_tick()
    --~ end
  --~ end

  --~ BioInd.debugging.entered_event(event, "leave")
--~ end)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_trees
