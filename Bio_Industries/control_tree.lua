local BioInd = require('common')('Bio_Industries')

-- All tree Growing stuff
local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(true)

local terrains = require("libs/trees-and-terrains")

Bi_Industries = {}

Bi_Industries.fertility = {
    ["vegetation-green-grass-1"] = 100,
    ["grass-1"] =  100,
    ["grass-3"] =  85,
    ["grass-2"] =  70,
    ["grass-4"] =  60,
    ["red-desert-0"] =  50,
    ["dirt-3"] =  40,
    ["dirt-5"] =  37,
    ["dirt-6"] =  34,
    ["dirt-7"] =  31,
    ["dirt-4"] =  28,
    ["dry-dirt"] =  25,
    ["dirt-2"] =  22,
    ["dirt-1"] =  19,
    ["red-desert-2"] =  16,
    ["red-desert-3"] =  13,
    ["sand-3"] =  10,
    ["sand-2"] =  7,
    ["sand-1"] =  4,
    ["red-desert-1"] =  1,
    ["frozen-snow-0"] = 1,
    ["frozen-snow-1"] = 1,
    ["frozen-snow-2"] = 1,
    ["frozen-snow-3"] = 1,
    ["frozen-snow-4"] = 1,
    ["frozen-snow-5"] = 1,
    ["frozen-snow-6"] = 1,
    ["frozen-snow-7"] = 1,
    ["frozen-snow-8"] = 1,
    ["frozen-snow-9"] = 1,
    ["mineral-aubergine-dirt-1"] = 45,
    ["mineral-aubergine-dirt-2"] = 45,
    ["mineral-aubergine-dirt-3"] = 25,
    ["mineral-aubergine-dirt-4"] = 25,
    ["mineral-aubergine-dirt-5"] = 25,
    ["mineral-aubergine-dirt-6"] = 25,
    ["mineral-aubergine-dirt-7"] = 25,
    ["mineral-aubergine-dirt-8"] = 25,
    ["mineral-aubergine-dirt-9"] = 25,
    ["mineral-aubergine-sand-1"] = 15,
    ["mineral-aubergine-sand-2"] = 15,
    ["mineral-aubergine-sand-3"] = 10,
    ["mineral-beige-dirt-1"] = 45,
    ["mineral-beige-dirt-2"] = 45,
    ["mineral-beige-dirt-3"] = 25,
    ["mineral-beige-dirt-4"] = 25,
    ["mineral-beige-dirt-5"] = 25,
    ["mineral-beige-dirt-6"] = 25,
    ["mineral-beige-dirt-7"] = 25,
    ["mineral-beige-dirt-8"] = 25,
    ["mineral-beige-dirt-9"] = 25,
    ["mineral-beige-sand-1"] = 10,
    ["mineral-beige-sand-2"] = 10,
    ["mineral-beige-sand-3"] = 10,
    ["mineral-black-dirt-1"] = 45,
    ["mineral-black-dirt-2"] = 45,
    ["mineral-black-dirt-3"] = 25,
    ["mineral-black-dirt-4"] = 25,
    ["mineral-black-dirt-5"] = 25,
    ["mineral-black-dirt-6"] = 25,
    ["mineral-black-dirt-7"] = 25,
    ["mineral-black-dirt-8"] = 25,
    ["mineral-black-dirt-9"] = 25,
    ["mineral-black-sand-1"] = 10,
    ["mineral-black-sand-2"] = 10,
    ["mineral-black-sand-3"] = 10,
    ["mineral-brown-dirt-1"] = 25,
    ["mineral-brown-dirt-2"] = 25,
    ["mineral-brown-dirt-3"] = 25,
    ["mineral-brown-dirt-4"] = 25,
    ["mineral-brown-dirt-5"] = 25,
    ["mineral-brown-dirt-6"] = 25,
    ["mineral-brown-dirt-7"] = 25,
    ["mineral-brown-dirt-8"] = 25,
    ["mineral-brown-dirt-9"] = 25,
    ["mineral-brown-sand-1"] = 10,
    ["mineral-brown-sand-2"] = 10,
    ["mineral-brown-sand-3"] = 10,
    ["mineral-cream-dirt-1"] = 25,
    ["mineral-cream-dirt-2"] = 25,
    ["mineral-cream-dirt-3"] = 25,
    ["mineral-cream-dirt-4"] = 25,
    ["mineral-cream-dirt-5"] = 25,
    ["mineral-cream-dirt-6"] = 25,
    ["mineral-cream-dirt-7"] = 25,
    ["mineral-cream-dirt-8"] = 25,
    ["mineral-cream-dirt-9"] = 25,
    ["mineral-cream-sand-1"] = 10,
    ["mineral-cream-sand-2"] = 10,
    ["mineral-cream-sand-3"] = 10,
    ["mineral-dustyrose-dirt-1"] = 25,
    ["mineral-dustyrose-dirt-2"] = 25,
    ["mineral-dustyrose-dirt-3"] = 25,
    ["mineral-dustyrose-dirt-4"] = 25,
    ["mineral-dustyrose-dirt-5"] = 25,
    ["mineral-dustyrose-dirt-6"] = 25,
    ["mineral-dustyrose-dirt-7"] = 25,
    ["mineral-dustyrose-dirt-8"] = 25,
    ["mineral-dustyrose-dirt-9"] = 25,
    ["mineral-dustyrose-sand-1"] = 10,
    ["mineral-dustyrose-sand-2"] = 10,
    ["mineral-dustyrose-sand-3"] = 10,
    ["mineral-grey-dirt-1"] = 25,
    ["mineral-grey-dirt-2"] = 25,
    ["mineral-grey-dirt-3"] = 25,
    ["mineral-grey-dirt-4"] = 25,
    ["mineral-grey-dirt-5"] = 25,
    ["mineral-grey-dirt-6"] = 25,
    ["mineral-grey-dirt-7"] = 25,
    ["mineral-grey-dirt-8"] = 25,
    ["mineral-grey-dirt-9"] = 25,
    ["mineral-grey-sand-1"] = 10,
    ["mineral-grey-sand-2"] = 10,
    ["mineral-grey-sand-3"] = 10,
    ["mineral-purple-dirt-1"] = 25,
    ["mineral-purple-dirt-2"] = 25,
    ["mineral-purple-dirt-3"] = 25,
    ["mineral-purple-dirt-4"] = 25,
    ["mineral-purple-dirt-5"] = 25,
    ["mineral-purple-dirt-6"] = 25,
    ["mineral-purple-dirt-7"] = 25,
    ["mineral-purple-dirt-8"] = 25,
    ["mineral-purple-dirt-9"] = 25,
    ["mineral-purple-sand-1"] = 10,
    ["mineral-purple-sand-2"] = 10,
    ["mineral-purple-sand-3"] = 10,
    ["mineral-red-dirt-1"] = 25,
    ["mineral-red-dirt-2"] = 25,
    ["mineral-red-dirt-3"] = 25,
    ["mineral-red-dirt-4"] = 25,
    ["mineral-red-dirt-5"] = 25,
    ["mineral-red-dirt-6"] = 25,
    ["mineral-red-dirt-7"] = 25,
    ["mineral-red-dirt-8"] = 25,
    ["mineral-red-dirt-9"] = 25,
    ["mineral-red-sand-1"] = 10,
    ["mineral-red-sand-2"] = 10,
    ["mineral-red-sand-3"] = 10,
    ["mineral-tan-dirt-1"] = 25,
    ["mineral-tan-dirt-2"] = 25,
    ["mineral-tan-dirt-3"] = 25,
    ["mineral-tan-dirt-4"] = 25,
    ["mineral-tan-dirt-5"] = 25,
    ["mineral-tan-dirt-6"] = 25,
    ["mineral-tan-dirt-7"] = 25,
    ["mineral-tan-dirt-8"] = 25,
    ["mineral-tan-dirt-9"] = 25,
    ["mineral-tan-sand-1"] = 10,
    ["mineral-tan-sand-2"] = 10,
    ["mineral-tan-sand-3"] = 10,
    ["mineral-violet-dirt-1"] = 25,
    ["mineral-violet-dirt-2"] = 25,
    ["mineral-violet-dirt-3"] = 25,
    ["mineral-violet-dirt-4"] = 25,
    ["mineral-violet-dirt-5"] = 25,
    ["mineral-violet-dirt-6"] = 25,
    ["mineral-violet-dirt-7"] = 25,
    ["mineral-violet-dirt-8"] = 25,
    ["mineral-violet-dirt-9"] = 25,
    ["mineral-violet-sand-1"] = 10,
    ["mineral-violet-sand-2"] = 10,
    ["mineral-violet-sand-3"] = 10,
    ["mineral-white-dirt-1"] = 25,
    ["mineral-white-dirt-2"] = 25,
    ["mineral-white-dirt-3"] = 25,
    ["mineral-white-dirt-4"] = 25,
    ["mineral-white-dirt-5"] = 25,
    ["mineral-white-dirt-6"] = 25,
    ["mineral-white-dirt-7"] = 25,
    ["mineral-white-dirt-8"] = 25,
    ["mineral-white-dirt-9"] = 25,
    ["mineral-white-sand-1"] = 10,
    ["mineral-white-sand-2"] = 10,
    ["mineral-white-sand-3"] = 10,
    ["vegetation-blue-grass-1"] = 70,
    ["vegetation-blue-grass-2"] = 70,
    ["vegetation-green-grass-2"] = 75,
    ["vegetation-green-grass-3"] = 85,
    ["vegetation-green-grass-4"] = 70,
    ["vegetation-mauve-grass-1"] = 70,
    ["vegetation-mauve-grass-2"] = 70,
    ["vegetation-olive-grass-1"] = 70,
    ["vegetation-olive-grass-2"] = 70,
    ["vegetation-orange-grass-1"] = 70,
    ["vegetation-orange-grass-2"] = 70,
    ["vegetation-purple-grass-1"] = 70,
    ["vegetation-purple-grass-2"] = 70,
    ["vegetation-red-grass-1"] = 70,
    ["vegetation-red-grass-2"] = 70,
    ["vegetation-turquoise-grass-1"] = 70,
    ["vegetation-turquoise-grass-2"] = 70,
    ["vegetation-violet-grass-1"] = 70,
    ["vegetation-violet-grass-2"] = 70,
    ["vegetation-yellow-grass-1"] = 70,
    ["vegetation-yellow-grass-2"] = 70,
    ["volcanic-blue-heat-1"] = 1,
    ["volcanic-blue-heat-2"] = 1,
    ["volcanic-blue-heat-3"] = 1,
    ["volcanic-blue-heat-4"] = 1,
    ["volcanic-green-heat-1"] = 1,
    ["volcanic-green-heat-2"] = 1,
    ["volcanic-green-heat-3"] = 1,
    ["volcanic-green-heat-4"] = 1,
    ["volcanic-orange-heat-1"] = 1,
    ["volcanic-orange-heat-2"] = 1,
    ["volcanic-orange-heat-3"] = 1,
    ["volcanic-orange-heat-4"] = 1,
    ["volcanic-purple-heat-1"] = 1,
    ["volcanic-purple-heat-2"] = 1,
    ["volcanic-purple-heat-3"] = 1,
    ["volcanic-purple-heat-4"] = 1,
    ["landfill"] = 1,
}


local function __err(arg, arg_type)
  error(string.format("Wrong argument! %s is not a valid %s!", arg or "nil", arg_type))
end

-- t_base, t_penalty: numbers; seedbomb: Boolean
local function plant_seed(event, t_base, t_penalty, seedbomb)

  if not (event and type(event) == "table") then
    _err(event, "table")
  elseif not (t_base and type(t_base) == "number") then
    __err(t_base, "number")
  elseif not (t_penalty and type(t_penalty) == "number") then
    __err(t_penalty, "number")
  -- seedbomb must be a boolean value!
  --~ elseif not (seedbomb and (seedbomb == "yes" or seedbomb == "no")) then
    --~ _err(seedbomb, "string")
  end
BioInd.show("event", event)
BioInd.show("t_base", t_base)
BioInd.show("t_penalty", t_penalty)
BioInd.show("seedbomb", seedbomb)
  -- Seed Planted (Put the seedling in the table)
  local entity = event.entity or event.created_entity or __err("nil", "entity")
  local surface = entity.surface
  local pos = BioInd.normalize_position(entity.position)
  local currentTilename = surface.get_tile(pos.x, pos.y).name
  -- Minimum will always be 1
  local fertility = Bi_Industries.fertility[currentTilename] or 1

  -- Things will grow faster on fertile than on barren tiles
  -- (No penalty for tiles with maximum fertility)
  local grow_time = math.random(t_base) + t_penalty - (40 * fertility)
  table.insert(global.bi.tree_growing, {
    position = pos,
    time = event.tick + grow_time,
    surface = surface,
    seed_bomb = seedbomb
  })
  table.sort(global.bi.tree_growing, function(a, b) return a.time < b.time end)
end

function seed_planted(event)
  plant_seed(event, 1000, 4000, false)
end

function seed_planted_trigger (event)
  plant_seed(event, 2000, 6000, true)
end

function seed_planted_arboretum(event, entity)
BioInd.show("event", event)
BioInd.show("entity", entity)

  event.created_entity = entity
  plant_seed(event, 2000, 6000, false)
end


function summ_weight (tabl)
  local summ = 0
  for i, tree_weights in pairs (tabl) do
    if (type (tree_weights) == "table") and tree_weights.weight then
      summ = summ + tree_weights.weight
    end
  end
  return summ
end

function tree_from_max_index_tabl (max_index, tabl)
  local rnd_index = math.random (max_index)
  for tree_name, tree_weights in pairs(tabl) do
    if (type (tree_weights) == "table") and tree_weights.weight then
      rnd_index = rnd_index - tree_weights.weight
      if rnd_index <= 0 then
        return tree_name
      end
    end
  end
  return nil
end

function random_tree (surface, position)
  local tile = surface.get_tile(position.x, position.y)
  local tile_name = tile.name
BioInd.show("random_tree: tile_name", tile_name)
  if terrains[tile_name] then
    local trees_table = terrains[tile_name]
    local max_index = summ_weight(trees_table)
BioInd.writeDebug("Found %s in table terrains. trees_table: %s\tmax_index: %s", {tile_name,trees_table, max_index})
    return tree_from_max_index_tabl(max_index, trees_table)
  end
end


-- Settings used for the different grow stages
local stage_settings = {
  [1] = {
    fertiliser = {max = 1500, penalty = 3000, factor = 30},
    default = {max = 1500, penalty = 6000, factor = 30},
  },
  [2] = {
    fertiliser = {max = 1000, penalty = 2000, factor = 20},
    default = {max = 1500, penalty = 6000, factor = 30},
  },
  [3] = {
    fertiliser = {max = 1000, penalty = 2000, factor = 20},
    default = {max = 1500, penalty = 6000, factor = 30},
  },
}

local function Grow_tree_first_stage(first_stage_table, event)
  local surface = first_stage_table and first_stage_table.surface or __err("nil", "surface")
  local position = first_stage_table and BioInd.normalize_position(first_stage_table.position) or
                    __err("nil", "position")
  local seed_bomb = first_stage_table and first_stage_table.seed_bomb
BioInd.writeDebug("seed_bomb: %s", {seed_bomb})
  local tree = surface.find_entity("seedling", position)
  local tree2 = surface.find_entity("seedling-2", position)
  local tree3 = surface.find_entity("seedling-3", position)
BioInd.writeDebug("tree: %s\ttree2: %s\ttree3: %s", {tree or "nil", tree2 or "nil", tree3 or "nil"})

  -- fertility will be 1 if terrain type is not listed above, so very small chance to grow.
  local currentTilename = surface.get_tile(position.x, position.y).name
  local fertility = 1
  -- Random value. Tree will grow if this value is smaller than the 'Fertility' value
  local growth_chance = math.random(100)

  if tree and not seed_bomb then
    tree.destroy()
BioInd.writeDebug("Destroyed tree!")
    --- Depending on Terrain, choose tree type & Convert seedling into a tree
    if Bi_Industries.fertility[currentTilename] then
      fertility = Bi_Industries.fertility[currentTilename]
BioInd.writeDebug("New tree can grow!")
    -- Grow the new tree
      local tree_name = random_tree(surface, position)
      if tree_name and
          surface.can_place_entity{name = tree_name, position = position, force = "neutral"} and
          growth_chance <= (fertility + 5) then
BioInd.writeDebug("Can be placed etc!")
          -- Fertile tiles will grow faster than barren tiles
        local grow_time = math.random(2000) + 4000 - (40 * fertility)
        if grow_time < 1 then
          grow_time = 1
        end
BioInd.writeDebug("grow_time: %s", {grow_time})

        local stage_1_tree_name = "bio-tree-" .. tree_name .. "-1"
        if not (game.item_prototypes[stage_1_tree_name] or
                game.entity_prototypes[stage_1_tree_name]) then
          stage_1_tree_name = tree_name
        end
BioInd.writeDebug("stage_1_tree_name: %s", {stage_1_tree_name})

        table.insert(global.bi.tree_growing_stage_1, {
          tree_name = stage_1_tree_name,
          final_tree = tree_name,
          position = position,
          time = event.tick + grow_time,
          surface = surface
        })
        table.sort(global.bi.tree_growing_stage_1, function(a, b) return a.time < b.time end)
        -- Plant the new tree
        surface.create_entity({name = stage_1_tree_name, position = position, force = "neutral"})
      end
    end
  end

  --- Seed Bomb Code
  if tree2 or tree3 then

    if tree2 then tree2.destroy() end
    if tree3 then tree3.destroy() end

    --- Depending on terrain, choose tree type & convert seedling into a tree
    if Bi_Industries.fertility[currentTilename] then
      fertility = Bi_Industries.fertility[currentTilename]

      local tree_name = random_tree(surface, position)
      if tree_name then
        local can_be_placed = surface.can_place_entity{
          name = tree_name,
          position = position,
          force = "neutral"
        }
        --~ if can_be_placed and growth_chance <= fertility and foundtree then
        if can_be_placed and growth_chance <= fertility then
          local new_tree = surface.create_entity{
            name = tree_name,
            position = position,
            force = "neutral"
          }
        end
      end
    end
  end

  if seed_bomb then
    BioInd.writeDebug("Seed bomb was used!")
    if tree then
      tree.destroy()
    end

    --- Depending on Terrain, choose tree type & Convert seedling into a tree
    if Bi_Industries.fertility[currentTilename] then
      fertility = Bi_Industries.fertility[currentTilename]

      BioInd.writeDebug("Got Tile")
      local tree_name = random_tree (surface, position)
      if tree_name then
      BioInd.writeDebug("Found Tree")
        if surface.can_place_entity{
              name = tree_name,
              position = position,
              force = "neutral"
        } and growth_chance <= fertility then
          surface.create_entity{name = tree_name, position = position, force = "neutral"}
        end
      else
        BioInd.writeDebug("Tree not Found")
      end
    else
      BioInd.writeDebug("Tile not Found")
    end
  end
end

local function Grow_tree_last_stage(last_stage_table)
  local tree_name = last_stage_table and last_stage_table.tree_name or __err("nil", "string")
  local final_tree = last_stage_table and last_stage_table.final_tree
  local surface = last_stage_table and last_stage_table.surface
  local position = last_stage_table and last_stage_table.position
  local time_planted = last_stage_table and last_stage_table.time

  local tree = tree_name and surface.find_entity(tree_name, position)
  local currentTilename = surface.get_tile(position.x, position.y).name


  if tree then
    tree.destroy()

    -- fertility will be 1 if terrain type not listed above, so very small change to grow.
    local fertility = Bi_Industries.fertility[currentTilename] or 1

    --- Depending on Terrain, choose tree type & Convert seedling into a tree
    local final_tree_name = final_tree

    local can_be_placed = surface.can_place_entity{
      name = final_tree_name,
      position = position,
      force = "neutral"
    }

    if can_be_placed and
        (Bi_Industries.fertility[currentTilename] or (growth_chance <= fertility)) then

      -- Grow the new tree
      BioInd.writeDebug("Final Tree Name: %s", {final_tree_name})
      surface.create_entity({
          name = final_tree_name,
          position = position,
          force = "neutral"
        })
    end
  end
end


local function Grow_tree_stage(stage_table, stage)
BioInd.writeDebug("Entered function Grow_tree_stage(%s, %s)", {stage_table, stage})

  if not (stage_table and type(stage_table) == "table") then
    __err(stage_table or "nil", "table")
  elseif not (stage and type(stage) == "number") then
    __err(stage or "nil", "number")
  end

  if stage == 4 then
    Grow_tree_last_stage(stage_table)
  else

    local tree_name = stage_table.tree_name
    local final_tree = stage_table.final_tree
    local surface = stage_table.surface
    local position = BioInd.normalize_position(stage_table.position)
    local time_planted = stage_table.time


    local tree = tree_name and surface.find_entity(tree_name, position)
    local currentTilename = surface.get_tile(position.x, position.y).name

    if tree then
      tree.destroy()

      local next_stage = stage and type(stage) == "number" and stage + 1 or
                          error(string.format("%s is not a valid tree growth stage!", stage))
      -- This will be "fertiliser" or "default" in table stage_settings
      local key

      --- Depending on Terrain, choose tree type & Convert seedling into a tree
      local fertility
      if Bi_Industries.fertility[currentTilename] then
        fertility = Bi_Industries.fertility[currentTilename]
        key = "fertiliser"
      else
        fertility = 1
        key = "default"
      end

      local next_stage_tree_name = "bio-tree-" .. final_tree .. "-" .. next_stage
      if not (game.item_prototypes[next_stage_tree_name] or
                game.entity_prototypes[next_stage_tree_name]) then
        next_stage_tree_name = final_tree
        BioInd.writeDebug("Next stage %g: Prototype did not exist", {next_stage})
      else
        BioInd.writeDebug("Next stage %g: %s", {next_stage, next_stage_tree_name})
      end

      local can_be_placed = surface.can_place_entity{
        name = next_stage_tree_name,
        position = position,
        force = "neutral"
      }

      if can_be_placed then

        if next_stage_tree_name == final_tree then
          BioInd.writeDebug("Tree reached final stage, don't insert")
          surface.create_entity({
                name = final_tree,
                position = position,
                force = "neutral"
          })
        else
          -- Trees will grow faster on fertile than on barren tiles!
          local s = stage_settings[stage][key]
          local grow_time = math.random(s.max) + s.penalty - (s.factor * fertility)
          if grow_time < 1 then
            grow_time = 1
          end

          table.insert(global.bi["tree_growing_stage_" .. next_stage], {
            tree_name = next_stage_tree_name,
            final_tree = final_tree,
            position = position,
            time = time_planted + grow_time,
            surface = surface
          })
          table.sort(global.bi.tree_growing_stage_2, function(a, b) return a.time < b.time end)
          surface.create_entity({
            name = next_stage_tree_name,
            position = position,
            force = "neutral"
          })
        end
      end

    else
      BioInd.writeDebug("Did not find that tree I was looking for...")
    end
  end
end


---- Growing Tree
--Event.register(-12, function(event)
Event.register(defines.events.on_tick, function(event)
--~ BioInd.writeDebug("Entered script for on_tick in control_tree.lua!")
  if global.bi.tree_growing_stage_1 == nil then
    for i = 1, 4 do
      global.bi["tree_growing_stage_" .. i] = {}
    end
  end

  while next(global.bi.tree_growing) do
    -- Table entries are sorted by "time", so we can stop if the first entry's
    -- "time" refers to a tick in the future!
    if event.tick < global.bi.tree_growing[1].time then
      --~ BioInd.writeDebug("Still growing")
      break
    end
--~ BioInd.writeDebug("Not growing! Calling Grow_tree_stage_0")
    Grow_tree_first_stage(global.bi.tree_growing[1], event)
    table.remove(global.bi.tree_growing, 1)
--~ BioInd.writeDebug("global.bi.tree_growing: %s", {global.bi.tree_growing}, "line")
  end

  for stage = 1, 4 do
    local stage_table = global.bi["tree_growing_stage_" .. stage]
    while next(stage_table) do
      if event.tick < stage_table[1].time then
        break
      end
      Grow_tree_stage(stage_table[1], stage)
      table.remove(stage_table, 1)
    end
  end
end)
