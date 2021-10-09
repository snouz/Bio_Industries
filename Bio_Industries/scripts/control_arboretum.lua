------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 ARBORETUM STUFF                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

-- ManagedLuaBootstrap instance from ErLib
local arboretum_script = BioInd.erlib.Events.get_managed_script("arboretum")

-- Eradicator's Library uses the on_configuration_changed event for on_init as well.
-- If the mod is added to an existing game, the event will trigger two times, but
-- we only need to run the code once, so we check for this flag.
local initialized

local BI_arboretum = {}



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                             Local variables/tables                             --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- If a recipe with NORMAL FERTILIZER is used, don't fertilize tiles listed in this
-- table! Their fertility can't be improved with normal fertilizer anymore.
local Terrain_Check_1 = {
  ["grass-1"] = true,                   -- Fertility: 100%
  ["grass-3"] = true,                   -- Fertility: 85%
  ["vegetation-green-grass-1"] = true,  -- Fertility: 100%
  ["vegetation-green-grass-3"] = true,  -- Fertility: 85%
}

-- If a recipe with ADVANCED FERTILIZER is used, don't fertilize tiles listed here!
-- The fertility of this top-quality soil already has the highest possible value.
local Terrain_Check_2 = {
  ["grass-1"] = true,                   -- Fertility: 100%
  ["vegetation-green-grass-1"] = true,  -- Fertility: 100%
}

local plant_radius = 75



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Local functions                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--        Generate dictionary with the names of ingredients for arboretums        --
--                  (Other mods could have changed the recipes!)                  --
------------------------------------------------------------------------------------
local function get_arboretum_recipes(list)
    BioInd.debugging.entered_function({list})

  local recipes = game.recipe_prototypes
  local name

  for i = 1, 5 do
    name = "bi-arboretum-r" .. i
    list[name] = {}
    list[name].items = {}
    list[name].fluids = {}

    for i, ingredient in pairs(recipes[name] and recipes[name].ingredients or {}) do
      if ingredient.type == "item" then
        list[name].items[ingredient.name] = ingredient.amount
      else
        list[name].fluids[ingredient.name] = ingredient.amount
      end
    end
  end
  BioInd.debugging.show("Recipe list", list)

  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                               Get random position                              --
------------------------------------------------------------------------------------
local function get_new_position(pos)
  pos = BioInd.normalize_position(pos) or BioInd.debugging.arg_err("nil", position)
  local xxx = math.random(-plant_radius, plant_radius)
  local yyy = math.random(-plant_radius, plant_radius)

  return {x = pos.x + xxx, y = pos.y + yyy}
end



------------------------------------------------------------------------------------
--         Make sure all ingredients required by the recipe are available         --
------------------------------------------------------------------------------------
-- Check that all ingredients are available!
local function check_ingredients(arboretum)
  BioInd.debugging.entered_function({arboretum})

  BioInd.debugging.check_args(arboretum, "LuaEntity", "terraformer")

  --~ local x = BioInd.tree_stuff.arboretum_recipe_table
--~ BioInd.debugging.show("BioInd.tree_stuff.arboretum_recipe_table",
                      --~ BioInd.tree_stuff.arboretum_recipe_table)

  local recipe, need, inventory
  local recipe = arboretum.get_recipe()
  local need = recipe and BioInd.tree_stuff.arboretum_recipe_table[recipe.name]
  local inventory = arboretum.get_inventory(defines.inventory.assembling_machine_input)

BioInd.debugging.show("recipe", recipe and recipe.name)
BioInd.debugging.show("need", need)

  local function check(need, have)
    for name, amount in pairs(need or {}) do
      if not (have and have[name]) or (have[name] < amount) then
        BioInd.debugging.writeDebug("Missing ingredient %s (have %s of %s)", {name, have[name] or 0, amount})
        return false
      end
    end
    return true
  end

  BioInd.debugging.entered_function({arboretum}, "leave")
  return need and
          check(need.items, inventory and inventory.get_contents()) and
          check(need.fluids, arboretum.get_fluid_contents()) and
          {ingredients = need, name = recipe.name} or nil
end



------------------------------------------------------------------------------------
--          Actually deduct the ingredients from inventories/fluid boxes          --
------------------------------------------------------------------------------------
local function consume_ingredients(arboretum, need)
  BioInd.debugging.entered_function({arboretum, need})

  -- We only need to proceed if there are any ingredients that must be used!
  if need then
    BioInd.debugging.check_args(arboretum, "LuaEntity", "terraformer")

    local inventory = arboretum.get_inventory(defines.inventory.assembling_machine_input)
    for item, i in pairs(need.items or {}) do
      inventory.remove({name = item, count = i})
      BioInd.debugging.writeDebug("Removed %s (%s)", {item, i})
    end
    BioInd.debugging.show("Inventory", inventory.get_contents() or "nil")

    for fluid, f in pairs(need.fluids or {}) do
      arboretum.remove_fluid({name = fluid, amount = f})
      BioInd.debugging.writeDebug("Removed %s (%s)", {fluid, f})
    end
    BioInd.debugging.show("Fluid contents", arboretum.get_fluid_contents() or "nil")
  end

  BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
--                    If fertilizer was used, change the ground                   --
------------------------------------------------------------------------------------
local function set_tile(current, target, surface, position)
  BioInd.debugging.entered_function({current, target, surface, position})
  if current ~= target then
    surface.set_tiles(
      {{name = target, position = position}},
      true,         -- correct_tiles
      true,         -- remove_colliding_entities
      true,         -- remove_colliding_decoratives
      true          -- raise_event
    )
  end
  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                            Turn arboretum on or off?                           --
------------------------------------------------------------------------------------
local function turn_on_or_off(ArboretumTable)
  BioInd.debugging.entered_function({ArboretumTable})

  BioInd.debugging.check_args(ArboretumTable, "table", "terraformer data")

  local arboretum = ArboretumTable.base

  local ret = check_ingredients(arboretum)
  local ingredients = ret and ret.ingredients

  -- No recipe or no/not enough ingredients
  if arboretum.active and not ingredients then
    -- Turn off the terraformer until it's usable again
    arboretum.active = false
    BioInd.debugging.writeDebug("Turning off %s! (not enough ingredients)", {BioInd.debugging.argprint(arboretum)})

    -- Mark the terraformer with a rendering so that players can see it's not working!
    BioInd.add_rendering({
      table_name        = BioInd.compound_entities["bi-arboretum"].tab,
      unit_number       = arboretum.unit_number,
      -- Presets are defined in BioInd.renderings (common-control.lua)
      rendering         = "missing_ingredients",
    })

  -- Terraformer can work, turn it on again!
  elseif ingredients and not arboretum.active then
    arboretum.active = true
    BioInd.debugging.writeDebug("Activating %s again!", {BioInd.debugging.argprint(arboretum)})

    -- Remove rendering
    if ArboretumTable.renderings and ArboretumTable.renderings.missing_ingredients then
      BioInd.remove_rendering(ArboretumTable.renderings.missing_ingredients)
    end
  end

  BioInd.debugging.entered_function("leave")

  -- Pass on the result from check_ingredients(), so we don't have to call it again!
  return ret
end


--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------
--~ --                       Functions visible from other files                       --
--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--              Check if the tile at this position can be fertilized.             --
--           Returns name of the tile, or nil if it can't be fertilized.          --
------------------------------------------------------------------------------------
local function can_fertilize_at_position(surface, position)
  BioInd.debugging.entered_function({surface, position})

  BioInd.debugging.check_args(position, "table")
  surface = BioInd.is_surface(surface) or BioInd.debugging.arg_err(surface, "surface")
  local tile_name = surface.get_tile(position.x, position.y).name

  BioInd.debugging.entered_function("leave")
  return BioInd.tree_stuff.tile_fertility[tile_name] and tile_name
end


------------------------------------------------------------------------------------
--  Fertilize ground. May be used on its own, or called from fertilize_and_plant. --
------------------------------------------------------------------------------------
local function fertilize(arboretum, data)
  BioInd.debugging.entered_function({arboretum, data})

  BioInd.debugging.check_args(arboretum, "LuaEntity", "terraformer")
  BioInd.debugging.check_args(data, "table")
  BioInd.debugging.check_args(data.new_tile_name, "string", "tile name")

  -- Base position and surface are derived from the entity
  local pos, surface = BioInd.normalize_position(arboretum.position), arboretum.surface

  -- We only need to consume ingredients if this is used as stand-alone function, so
  -- this may be nil!
  local ingredients = data.ingredients

  -- If we get passed on a new position, this is called by the wrapper function and
  -- we only try once to fertilize the ground!
  local max_attempts = data.new_position and 1 or 10

  -- When called by the wrapper function, check if we'll use fertilizer on that terrain!
  local check_fertilizer = data.check_fertilizer

  -- This will determine what terrain check (if any) we'll use.
  local new_tile, fertilizer_tiles = data.new_tile_name, BioInd.tree_stuff.fertilizer_tiles
  if new_tile ~= fertilizer_tiles.common and new_tile ~= fertilizer_tiles.advanced then
    BioInd.debugging.arg_err(new_tile, "tile for fertilized ground")
  end

  -- If the tile we try to fertilize is of a type listed in this table, it can't
  -- be improved by the fertilizer we use.
  local fertilizer_wasted_here = (new_tile == fertilizer_tiles.common) and
                                  Terrain_Check_1 or Terrain_Check_2

  local new_position, current_tile

  -- Return values, for use by fertilize_and_plant()
  local ret = false

  ------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------

  -- When called by the wrapper function, we've already checked that something can
  -- grow at this position. If the fertility of the current tile can be improved by
  -- the fertilizer, we'll use the ingredients and change the tile (return true). If
  -- fertilizing the ground would have no effect (return false), we'll spend the
  -- ingredients (without fertilizer) while planting!
  for k = 1, max_attempts do
    new_position = data.new_position or get_new_position(pos)
    current_tile = data.current_tile_name or can_fertilize_at_position(surface, new_position)

    -- Current tile can be fertilized, and will be improved by this fertilizer
    if current_tile and not fertilizer_wasted_here[current_tile] then
      consume_ingredients(arboretum, ingredients)
      set_tile(current_tile, new_tile, surface, new_position)
      --- After sucessfully changing the terrain, break out of the loop.
      ret = true
      BioInd.debugging.writeDebug("Fertilized ground at position %s (attempt %s)", {new_position, k}, "line")
      break
    else
      BioInd.debugging.writeDebug("%s: Can't change terrain (tile: %s)", {k, current_tile or "unknown tile"})
    end
  end

  BioInd.debugging.entered_function("leave")
  return ret
end


------------------------------------------------------------------------------------
--              Check if a seedling can be planted at this position.              --
--       Returns data of the new plant, or nil if it can't be placed there.       --
------------------------------------------------------------------------------------
local function can_plant_at_position(surface, position)
  BioInd.debugging.entered_function({surface, position})

  BioInd.debugging.check_args(position, "table")
  surface = BioInd.is_surface(surface) or BioInd.debugging.arg_err(surface, "surface")
  local plant = {name= "seedling", force = "neutral", position = position}

  BioInd.debugging.entered_function("leave")
  return surface.can_place_entity(plant) and plant
end




------------------------------------------------------------------------------------
--    Plant trees. May be used on its own, or called from fertilize_and_plant.    --
------------------------------------------------------------------------------------
local function plant(arboretum, data, event)
  BioInd.debugging.entered_function({arboretum, data, event})

  BioInd.debugging.check_args(arboretum, "LuaEntity", "terraformer")
  BioInd.debugging.check_args(data, "table")
  BioInd.debugging.check_args(event, "table")

  -- Base position and surface are derived from the entity
  local pos, surface = BioInd.normalize_position(arboretum.position), arboretum.surface

  -- We only need to consume ingredients if this is used as stand-alone function, so
  -- this may be nil!
  local ingredients = data.ingredients

  -- If we get passed on a new position, we only try once to plant a tree!
  local max_attempts = data.new_position and 1 or 10

  -- We'll get the data from the wrapper function or from can_plant_at_position()
  local new_plant

  -- This will be passed on to the growing function!
  local create_seedling

  -- Return value, if this function is called from fertilize_and_plant()
  local ret = false

  ------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------

  -- Find a random spot to plant a tree!
  for k = 1, max_attempts do
    new_plant = data.new_plant or can_plant_at_position(surface, get_new_position(pos))

    if new_plant then
      if ingredients then
        consume_ingredients(arboretum, ingredients)
      end
      create_seedling = surface.create_entity(new_plant)
      BI_scripts.trees.seed_planted_arboretum(event, create_seedling)
      --- After sucessfully planting a tree, break out of the loop.
      ret = true
      BioInd.debugging.writeDebug("Planted seedling at position %s (attempt %s)",
                        {new_plant.position, k}, "line")
      break
    else
      BioInd.debugging.writeDebug("Can't plant here (attempt %s)", k)
    end
  end

  BioInd.debugging.entered_function("leave")
  return ret
end


------------------------------------------------------------------------------------
--  Fertilize ground and plant trees. Will use functions fertilize() and plant()! --
------------------------------------------------------------------------------------
local function fertilize_and_plant(arboretum, data, event)
  BioInd.debugging.entered_function({arboretum, data, event})

  BioInd.debugging.check_args(arboretum, "LuaEntity", "terraformer")
  BioInd.debugging.check_args(data, "table")
  BioInd.debugging.check_args(event, "table")

  -- Base position and surface are derived from the entity
  local pos, surface = BioInd.normalize_position(arboretum.position), arboretum.surface

  -- We will pass this on to fertilize()!
  local ingredients = data.ingredients

  -- Always try 10 times to find a spot for fertilizing/planting!
  local max_attempts = 10

  -- This will determine what new tile we'll set. We'll also pass this on to the
  -- fertilizing function in case we'll need to refund fertilizer.
  local fertilizer = (data.fertilizer == "fertilizer" or data.fertilizer == "bi-adv-fertilizer") and
                      data.fertilizer or
                      BioInd.debugging.arg_err(data.fertilizer, "string", "fertilizer name")

  local tiles = BioInd.tree_stuff.fertilizer_tiles
  local new_tile = (fertilizer == "fertilizer") and tiles.common or tiles.advanced

  local new_position, current_tile, new_plant

  ------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------
  for k = 1, max_attempts do
    new_position = get_new_position(pos)
    current_tile = can_fertilize_at_position(surface, new_position)
    new_plant = can_plant_at_position(surface, new_position)

    -- We can fertilize the ground and plant at this position!
    if current_tile and new_plant then

      -- We will pass on the ingredients to fertilize(), but they may not be used if
      -- fertilizing the ground won't improve it.
      local used_ingredients = fertilize(arboretum, {
        ingredients       = ingredients,
        new_position      = new_position,
        new_tile_name     = new_tile,
        -- No need to call the function again if we can just pass on the tile name!
        current_tile_name = current_tile,
      })

      -- We've alredy used the ingredients while fertilizing the ground, so we won't have
      -- to do it again while planting.
      if used_ingredients then
        ingredients = nil
      -- If we didn't use any ingredients yet, we must use them while planting, but we
      -- won't need the fertilizer!
      else
        ingredients.items[fertilizer] = nil
      end

      plant(arboretum, {
        ingredients = ingredients,
        new_position = new_position,
        new_plant = new_plant,
      }, event)

      --- After sucessfully planting a tree or changing the terrain, break out of the loop.
      break
    else
      BioInd.debugging.writeDebug("%s: Can't change terrain and plant a tree (tile: %s)",
                        {k, current_tile or "unknown tile"})
    end
  end

  BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
--         Check the arboretum recipe and plant trees/fertilize the ground        --
------------------------------------------------------------------------------------
--~ BI_arboretum.check_arboretum = function(ArboretumTable, event)
local check_arboretum = function(ArboretumTable, event)
  BioInd.debugging.entered_function({ArboretumTable, event})

  BioInd.debugging.check_args(ArboretumTable, "table", "terraformer data")

  -- If the terraformer has a recipe and sufficient ingredients, this will
  -- return the list of ingredients required this cycle + the recipe name.
  -- If the terraformer was turned off, it will also activate it again and
  -- remove the rendering.
  local check = turn_on_or_off(ArboretumTable)
  if check then
    local ingredients, recipe_name = check.ingredients, check.name

    local arboretum = ArboretumTable.base

    -- Just plant a tree and hope the ground is fertile!
    if recipe_name == "bi-arboretum-r1" then
      BioInd.debugging.writeDebug("%s: Just plant a tree", {recipe_name})

      plant(arboretum, {ingredients = ingredients}, event)

    -- Fertilize the ground with normal fertilizer. Ignore tiles listed in Terrain_Check_1!
    elseif recipe_name == "bi-arboretum-r2" then
      BioInd.debugging.writeDebug("%s: Just change terrain to %s (basic)",
                        {recipe_name, BioInd.tree_stuff.fertilizer_tiles.common or "nil"})

      fertilize(arboretum, {
        ingredients = ingredients,
        new_tile_name = BioInd.tree_stuff.fertilizer_tiles.common
      })

    -- Fertilize the ground with advanced fertilizer. Ignore tiles listed in Terrain_Check_2!
    elseif recipe_name == "bi-arboretum-r3" then
      BioInd.debugging.writeDebug("%s: Just change terrain to %s (advanced)",
                        {recipe_name, BioInd.tree_stuff.fertilizer_tiles.advanced or "nil"})

      fertilize(arboretum, {
        ingredients = ingredients,
        new_tile_name = BioInd.tree_stuff.fertilizer_tiles.advanced
      })

    -- Fertilize the ground with normal fertilizer. Ignore tiles listed in Terrain_Check_1!
    -- Also plant a tree.
    elseif recipe_name == "bi-arboretum-r4" then
      BioInd.debugging.writeDebug("%s: Plant Tree AND change the terrain to %s (basic)", {recipe_name, BioInd.tree_stuff.fertilizer_tiles.common or "nil"})

      fertilize_and_plant(arboretum, {
        ingredients = ingredients,
        fertilizer = "fertilizer",
      }, event)

    -- Fertilize the ground with advanced fertilizer. Ignore tiles listed in Terrain_Check_2!
    -- Also plant a tree.
    elseif recipe_name == "bi-arboretum-r5" then
      BioInd.debugging.writeDebug("%s: Plant Tree and change the terrain to %s (advanced)",
                        {recipe_name, BioInd.tree_stuff.fertilizer_tiles.advanced or "nil"})

      fertilize_and_plant(arboretum, {
        ingredients = ingredients,
        fertilizer = "bi-adv-fertilizer",
      }, event)

    else
      BioInd.debugging.writeDebug("Terraformer has no recipe!")
    end
  end
  BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 AutoCache stuff                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Get list of ingredients for all arboretum recipes
BioInd.tree_stuff.arboretum_recipe_table = BioInd.erlib.Cache.AutoCache(get_arboretum_recipes)




------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--         Radar completed a sector scan. Fertilize land and plant trees!         --
------------------------------------------------------------------------------------
--~ event_handlers.On_Sector_Scanned = function(event)
arboretum_script.on_event(defines.events.on_sector_scanned, function(event)
  BioInd.debugging.entered_event(event)

  -- Only act if radar belongs to a terraformer!
  local arboretum = global.bi_arboretum_radar_table[event.radar.unit_number]
  if arboretum then
    --~ BI_scripts.arboretum.check_arboretum(global.bi_arboretum_table[arboretum], event)
    --~ check_arboretum(global.bi_arboretum_table[arboretum], event)
    check_arboretum(global.bi_arboretum_table[arboretum], {tick = event.tick})
  end

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--              Player fast-transferred something to/from an entity.              --
--                          Turn terraformers on or off?                          --
------------------------------------------------------------------------------------
arboretum_script.on_event(defines.events.on_player_fast_transferred, function(event)
  BioInd.debugging.entered_event(event)

  -- Only act if entity was a terraformer!
  local tab = BioInd.compound_entities["bi-arboretum"].tab
  local arboretum = global[tab] and global[tab][event.entity.unit_number]

  if arboretum then
    turn_on_or_off(arboretum)
  else
    BioInd.debugging.writeDebug("Nothing to do for %s!", {event.entity.name})
  end

  BioInd.debugging.entered_event(event, "leave")
end)



------------------------------------------------------------------------------------
--                 Keep health of radar and terraformers in sync!                 --
------------------------------------------------------------------------------------
arboretum_script.on_event(defines.events.on_entity_damaged, function(event)
  BioInd.debugging.entered_event(event)

  local entity = event.entity
  local final_health = event.final_health
  local base_name = "bi-arboretum"

  if not (
    event.final_damage_amount > 0 and
    (entity.name == base_name and entity.type == BioInd.compound_entities[base_name].base.type) or
    (entity.name == BioInd.compound_entities[base_name].hidden.radar.name and
      entity.type == BioInd.compound_entities[base_name].hidden.radar.type)
  ) then
    BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    return
  end


  local associated

  -- Base was damaged: Find the radar associated with it!
  if entity.name == base_name then
    associated = global.bi_arboretum_table[entity.unit_number].radar
  -- Radar was damaged: Find the base entity!
  elseif entity.name == BioInd.compound_entities[base_name].hidden.radar.name then
    local base_id = global.bi_arboretum_radar_table[entity.unit_number]
    associated = global.bi_arboretum_table[base_id].base
  end

  if associated and associated.valid then
    associated.health = final_health
    BioInd.debugging.writeDebug("%s was damaged (%s). Reduced health of %s to %s!", {
                      BioInd.debugging.print_name_id(entity),
                      event.final_damage_amount,
                      entity.name == base_name and "associated radar" or "base",
                      associated.health
                    })
  end

  BioInd.debugging.entered_event(event, "leave")
end)


--~ ------------------------------------------------------------------------------------
--~ --                        Register events on loading a game                       --
--~ ------------------------------------------------------------------------------------
--~ arboretum_script.on_load(function()
  --~ local event = {name = "on_load"}
  --~ BioInd.debugging.entered_event(event)

  --~ BioInd.debugging.entered_event(event, "leave")
--~ end)


------------------------------------------------------------------------------------
--                         Initialize a new or loaded game                        --
------------------------------------------------------------------------------------
--~ arboretum_script.on_configuration_changed(function(event)
  --~   event = event or {}; event.name = "on_configuration_changed"
  --~ -- If the mod was added to an existing game, this event has already been triggered
  --~ -- for on_init, so we can skip it for on_configuration_changed!
  --~ if initialized then
    --~ BioInd.debugging.entered_event(event, "leave", "Nothing to do!")
    --~ return
  --~ else
    --~ BioInd.debugging.entered_event(event)
  --~ end

  --~ BioInd.debugging.writeDebug("Setting up tables for terraformers/arboretums.")

  --~ -- Global table for arboretum radars
  --~ global.bi_arboretum_radar_table = global.bi_arboretum_radar_table or {}

  --~ -- Mark game as initialized
  --~ initialized = true

  --~ BioInd.debugging.entered_event(event, "leave")
--~ end)



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_arboretum
