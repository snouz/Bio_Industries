------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--     Add fuel values to items made with wood  or other items that are made      --
--                with wood unless they already have a fuel value!                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local results, result, result_amount, fuel_value, ingredients, i_list
local check, black_check, cnt
local passes, new_pass, old

-- Used to calculate fuel value of all other items
local base_fuel = {name = "wood", type = "item", fuel_value = data.raw.item.wood.fuel_value or "2MJ"}
local fuel_category = data.raw[base_fuel.type][base_fuel.name].fuel_category

-- List of items that may get a fuel_value
local potential_fuel_items = {}

-- List of items that have a fuel_value
local fuel_items = {
  [base_fuel.name] = {type = base_fuel.type}
}

-- List of fuel_value for each item in fuel_items
local fuel_values = {
  [base_fuel.name] = {fuel_value = base_fuel.fuel_value, type = base_fuel.type}
}

check = require("prototypes.fuel_values.read_filters")
local blacklist_items = check.blacklist_items
local whitelist_items = check.whitelist_items
local blacklist_patterns = check.blacklist_patterns
local whitelist_patterns = check.whitelist_patterns
check = nil
BioInd.show("blacklist_items", blacklist_items)
BioInd.show("whitelist_items", whitelist_items)
BioInd.show("blacklist_patterns", blacklist_patterns)
BioInd.show("whitelist_patterns", whitelist_patterns)

------------------------------------------------------------------------------------
--                     Initialize list of potential fuel_items                    --
------------------------------------------------------------------------------------
BioInd.writeDebug("Make list of potential fuel items")

-- Add all items (different types) that are not blacklisted to potential_fuel_items
cnt = 0
for i, item_type in ipairs({
  "ammo",
  "armor",
  "capsule",
  --~ "fluid",
  "gun",
  "item",
  "item-with-entity-data",
  "mining-tool",
  --~ "module",
  "rail-planner",
  "tool",
}) do
  for item_name, item in pairs(data.raw[item_type]) do
    -- Reset so values from previous runs won't taint the result!
    check = nil
    black_check = nil

    -- Ignore base_fuel
    if item_name == base_fuel.name then
      check = false

    -- Always add items with a whitelisted name/type
    elseif whitelist_items[item_type] and whitelist_items[item_type][item_name] then
      check = true

    -- Never add items with a blacklisted name/type
    --~ elseif blacklist_items[item_name] == item_type then
    elseif blacklist_items[item_type] and blacklist_items[item_type][item_name] then
      check = false

    -- Must check patterns!
    else
      -- Add the item if it matches a whitelisted pattern
      -- (whitelist is probably shorter than the blacklist, so this should be faster)
      for p, pattern in pairs(whitelist_patterns) do
        if item_name:match(pattern) then
BioInd.writeDebug("Name of %s \"%s\" matches whitelisted pattern %s", {item_type, item_name, pattern})
          check = true
          break
        end
      end

      -- No match for whitelisted patterns
      if not check then
        -- Assume for now that we'll add this item
        black_check = false
        -- Does item_name match any blacklist_patterns?
        for p, pattern in pairs(blacklist_patterns) do
          -- Match found!
          if item_name:match(pattern) then
BioInd.writeDebug("Name of %s \"%s\" matches blacklisted pattern \"%s\"", {item_type, item_name, pattern})
            black_check = true
            -- No need to check more patterns!
            break
          end
        end
        check = not black_check
      end
    -- Finished checks for this item
    end

    -- Found an item that may get fuel_value
    if check then
BioInd.writeDebug("Adding %s \"%s\" to potential_fuel_items", {item_type, item_name})
      potential_fuel_items[item_name] = {
        -- We'll need the type later to assign data.raw[type][item_name].fuel_value!
        type = item_type,
        -- Dictionary: [recipe.name] = {{item, amount}, …}
        made_by = {},
      }
    -- Ignore this item!
    else
      cnt = cnt + 1
BioInd.writeDebug("Ignoring %s \"%s\" (%s)", {
  item_type,
  item_name,
  item_name == base_fuel.name and "base_fuel" or
                "blacklisted " .. (black_check and "pattern" or "name")
})
    end
  -- Finished checks for this type
  end
end
--~ BioInd.show("potential_fuel_items", potential_fuel_items)
--~ BioInd.show("fuel_items", fuel_items)

--~ BioInd.show("Number of potential_fuel_items", table_size(potential_fuel_items))
--~ BioInd.show("Number of fuel_items", table_size(fuel_items))
--~ BioInd.show("Number of ignored items", cnt)
--~ BioInd.show("potential_fuel_items", potential_fuel_items)
log("Number of potential_fuel_items: " .. table_size(potential_fuel_items))
for k, v in pairs(potential_fuel_items) do
  log(string.format("\"%s\" = \"%s\"" , k, v.type))
end
BioInd.show("Number of ignored items", cnt)

--~ local test = {}
--~ for k, v in pairs(potential_fuel_items) do
  --~ test[k] = v.type
--~ end
--~ BioInd.show("Potential fuel items", test)

--~ error("Test!")

------------------------------------------------------------------------------------
--       Check all recipes if they use the base_fuel or potential_fuel_items      --
--             to make items that are considered potential_fuel_items             --
------------------------------------------------------------------------------------
for r, recipe in pairs(data.raw.recipe) do
BioInd.show("Checking recipe", r)
  results = BI_Functions.lib.get_recipe_results(recipe)

  -- Ignore recipes that just get rid of their ingredients, like IR2's incineration recipes
BioInd.writeDebug("Recipe %s has results: %s", {recipe.name, results or "nil"}, "line")
  if results then
    -- Clean temporary list
    i_list = {}

    -- Check recipe results
    for r_name, result in pairs(results or {}) do
BioInd.writeDebug("Could result %s of recipe %s be a fuel item?", {r_name, recipe.name})

      -- Result is a potential fuel_item
      if potential_fuel_items[r_name] then
BioInd.writeDebug("Yes: %s", {results}, "line")
        ingredients = BI_Functions.lib.get_recipe_ingredients(recipe)
BioInd.writeDebug("Recipe %s has ingredients: %s", {recipe.name, ingredients or "nil"}, "line")
        -- Check recipe ingredients
        for i_name, ingredient in pairs(ingredients or {}) do
BioInd.show("Checking ingredient", i_name)
          -- Add item to temp list if it requires base_fuel or any potential_fuel_items
          if potential_fuel_items[i_name] or fuel_items[i_name] then
            i_list[i_name] = ingredient
BioInd.writeDebug("Added %s \"%s\" to list of ingredients: %s",
                  {ingredient.type, i_name, ingredient}, "line")
          end
          -- Add result to fuel_items if it requires any fuel_items
          if fuel_items[i_name] then
            fuel_items[r_name] = {}
BioInd.writeDebug("Added %s \"%s\" to fuel_items!", {base_fuel.type, r_name})
          end
        end
        -- Only add recipe data to the item if relevant ingredients are used
BioInd.show("final list", i_list)
        if table_size(i_list) > 0 then
          potential_fuel_items[r_name].made_by[recipe.name] = {
            result = result,
            ingredients = i_list
          }
BioInd.writeDebug("Added data for recipe %s to item %s: %s",
                  {r, r_name, potential_fuel_items[r_name].made_by})
        else
BioInd.writeDebug("Ignoring recipe %s", {r})
        end
      else
BioInd.writeDebug("No.")
      end
    end
  end
end


local function remove_no_fuel_items(tab, remove_item)
BioInd.entered_function()
BioInd.writeDebug("Removing item %s from recipes", {remove_item})
  for item_name, item_data in pairs(tab) do
    -- Check recipes that make this item
    for recipe_name, recipe_data in pairs(item_data.made_by or {}) do
      -- Remove ingredient from recipe data
      recipe_data.ingredients[remove_item] = nil
      -- If this was the last ingredient, remove the recipe the item's data
      if not next(recipe_data.ingredients) then
        item_data.made_by[recipe_name] = nil
        BioInd.writeDebug("Removed recipe %s from data of %s \"%s\"", {recipe_name, item_data.type, item_name})
      end
    end
  end
BioInd.entered_function("leave")
end

-- Remove items from tab if they're is no recipe to make them
local function remove_no_recipes(tab)
BioInd.entered_function()

BioInd.show("Number of potential_fuel_items", table_size(potential_fuel_items))
BioInd.show("Number of fuel_items", table_size(fuel_items))

  local run_again
  local passes = 0
  repeat
    run_again = false
    passes = passes + 1
BioInd.writeDebug("Pruning list (pass %s)", {passes})

    for item_name, item_data in pairs(tab) do
      -- No recipes are listed for that item
      if not (item_data.made_by and next(item_data.made_by)) then
        BioInd.writeDebug("Removing %s \"%s\" from list", {item_data.type, item_name})
        -- Remove item from potential_fuel_items
        tab[item_name] = nil
        BioInd.writeDebug("Removing %s \"%s\" from ingredients of potential fuel items",
                          {item_data.type, item_name})
        -- Remove this item from ingredients of all recipes making potential_fuel_items
        remove_no_fuel_items(tab, item_name)
        -- Stop and start over again!
        run_again = true
        break
      end
    end
BioInd.show("Number of remaining items", table_size(tab))
  until not run_again
BioInd.writeDebug("Finished pruning list of potential_fuel_items (needed %s passes)", {passes})

BioInd.entered_function("leave")
  return true
end


------------------------------------------------------------------------------------
--                       Prune list of potential_fuel_items                       --
------------------------------------------------------------------------------------
BioInd.writeDebug("Pruning list of potential_fuel_items (pass %s)", {passes})
remove_no_recipes(potential_fuel_items)

BioInd.show("potential_fuel_items", potential_fuel_items)
BioInd.show("Number of potential_fuel_items", table_size(potential_fuel_items))
BioInd.show("fuel_items", fuel_items)
BioInd.show("Number of fuel_items", table_size(fuel_items))


------------------------------------------------------------------------------------
--          Move items using fuel from potential_fuel_items to fuel_items         --
------------------------------------------------------------------------------------
passes = 0
repeat
  passes = passes + 1
  item_name, item_data = next(potential_fuel_items)

  if item_name and item_data then
    fuel_items[item_name] = table.deepcopy(item_data)
    potential_fuel_items[item_name] = nil
  end
until not next(potential_fuel_items)

BioInd.writeDebug("Moved %s items to fuel_items", {passes})
BioInd.show("potential_fuel_items", potential_fuel_items)
BioInd.show("Number of potential_fuel_items", table_size(potential_fuel_items))
BioInd.show("fuel_items", fuel_items)
BioInd.show("Number of fuel_items", table_size(fuel_items))
BioInd.writeDebug("Moved %s items", {passes})


------------------------------------------------------------------------------------
--   To determine the fuel_value of fuel_items, we want the recipe producing the  --
--                      least amount_per_second of that item.                     --
------------------------------------------------------------------------------------
BioInd.writeDebug("Removing obsolete recipes from list!")
passes = 0
repeat
  new_pass = false
  passes = passes + 1
  --~ local item_name, item_data = next(fuel_items)

  for item_name, item_data in pairs(fuel_items) do

    -- We don't need any recipe if the item already has a fuel_value!
    fuel_value = data.raw[item_data.type][item_name].fuel_value
    if fuel_value then
BioInd.writeDebug("%s \"%s\" already has a fuel_value. Moving it from fuel_items to fuel_values!",
                  {item_data.type, item_name})
      fuel_values[item_name] = {fuel_value = fuel_value, type = item_data.type}
      fuel_items[item_name] = nil
      new_pass = true
BioInd.writeDebug("Need another pass!")
      break

    -- Order recipes by result.amount_per_second
    elseif not item_data.recipe_order then

      item_data.recipe_order = {}

      -- If there's one recipe, there' no need to jump through hoops!
      local n_ingredients = table_size(item_data.made_by)

      if n_ingredients == 1 then
BioInd.writeDebug("Only one recipe for %s \"%s\"!", {item_data.type, item_name})
        item_data.recipe_order[1] = next(item_data.made_by)
--~ BioInd.show("item_data.recipe_order", item_data.recipe_order)

      -- If there are more, we sort them (least to most amount_per_sec)
      elseif n_ingredients > 1 then
BioInd.writeDebug("Ordering %s recipes for %s \"%s\"!", {n_ingredients, item_data.type, item_name})
        check = {}

        -- Make an array of recipe names and amount_per_sec
        for recipe_name, recipe_data in pairs(item_data.made_by) do
          check[#check + 1] = {name = recipe_name, amount_per_sec = recipe_data.result.amount_per_sec}
        end
--~ BioInd.show("check", check)

        -- Sort the array
        table.sort(check, function(a, b) return a and b and a.amount_per_sec < b.amount_per_sec end)
--~ BioInd.show("check after table.sort", check)

        -- Add sort order to item data
        for index, recipe in pairs(check) do
--~ BioInd.writeDebug("index: %s\trecipe: %s", {index, recipe}, "line")
          item_data.recipe_order[index] = recipe.name
        end
BioInd.show("item_data.recipe_order", item_data.recipe_order)
      -- This should never be reached!
      else
BioInd.writeDebug("Empty recipe list!")
        error("Empty recipe list!")
      end

    end
  end
BioInd.show("End of pass", passes)
until not new_pass
BioInd.show("fuel_items", fuel_items)
BioInd.show("fuel_values", fuel_values)


-- Mostly stolen from utils.lua …
local function format_fuel_value(amount)
--~ BioInd.entered_function()

  local suffix = ""
  local suffix_list = {
    Y = 24,
    Z = 21,
    E = 18,
    P = 15,
    T = 12,
    G = 9,
    M = 6,
    K = 3,
    k = 3,
  }
  for letter, limit in pairs(suffix_list) do
    limit = 10^limit
    if math.abs(amount) >= limit then
      amount = math.floor(amount/(limit/10))/10
      suffix = letter
      break
    end
  end
--~ BioInd.entered_function("leave")
  return amount..suffix
end


local function calculate_fuel_value(recipe_data)
BioInd.entered_function()
  local fuel_value = 0
  local check = true
  for ingredient_name, ingredient_data in pairs(recipe_data.ingredients) do
BioInd.writeDebug("Checking ingredient \"%s\"", {ingredient_name})
    -- Can't calculate fuel_value if we don't know that of all ingredients!
    if fuel_values[ingredient_name] then
BioInd.show("ingredient_data", ingredient_data)
BioInd.show("recipe_data.result", recipe_data.result)
      amount = ingredient_data.amount / (recipe_data.result.amount or 1)
BioInd.show("amount", amount)
BioInd.writeDebug("fuel_values[%s]: %s", {ingredient_name, fuel_values[ingredient_name].fuel_value or "nil"})
      fuel_value = fuel_value + amount * util.parse_energy(fuel_values[ingredient_name].fuel_value)
BioInd.show("fuel_value", format_fuel_value(fuel_value) .. "J")
    else
BioInd.show("Ingredient has no fuel_value yet", ingredient_name)
      check = false
      break
    end
  end
  -- If everything went alright, return the fuel_value in the expected format (e.g. "1MJ") otherwise nil
BioInd.entered_function("leave")
  return check and format_fuel_value(fuel_value) .. "J"
end


local function get_fuel_values()
BioInd.entered_function()
BioInd.writeDebug("Trying to get fuel_value for fuel_items")

  -- Will be true if we need to call the function again
  local run_again = false

  for item_name, item_data in pairs(fuel_items) do
    -- We can skip this if a fuel_value is already stored for that item
    if fuel_values[item_name] then
    fuel_items[item_name] = nil
BioInd.writeDebug("Removed %s \"%s\" from fuel_items (already stored in fuel_values)",
                  {item_data.type, item_name})
    -- We need to calculate the fuel_value
    else
BioInd.writeDebug("Checking %s \"%s\"", {item_data.type, item_name})
      fuel_value = data.raw[item_data.type][item_name].fuel_value
      -- We've already got a predefined fuel_value -- let's keep it!
      if fuel_value then
        fuel_values[item_name] = {fuel_value = fuel_value, type = item_data.type}
        fuel_items[item_name] = nil
BioInd.writeDebug("%s \"%s\" already has a fuel_value. Moved it from fuel_items to fuel_values!",
                    {item_data.type, item_name})
      -- Check if all ingredients already have a known fuel_value
      else
BioInd.writeDebug("fuel_items[%s]: %s", {item_name, fuel_items[item_name]})
        -- Use the recipe producing the least amount_per_second (first element
        -- of item_data.recipe_order)!
        recipe_name = item_data.recipe_order[1]
BioInd.writeDebug("Checking recipe \"%s\"", {recipe_name})
        recipe_data = recipe_name and fuel_items[item_name].made_by[recipe_name]
BioInd.writeDebug("Recipe data: %s", {recipe_data or "nil"})

        -- Recipe exists
        if recipe_data then
          -- Try to calculate the fuel value
          fuel_value = calculate_fuel_value(recipe_data)
--~ BioInd.show("fuel_value", fuel_value)
          -- Missing ingredients, proceed with other items but schedule re-run!
          if fuel_value then
            fuel_values[item_name] = {fuel_value = fuel_value, type = item_data.type}
--~ BioInd.writeDebug("Added fuel_value for %s \"%s\" to list (%s)!",
                    --~ {item_data.type, item_name, fuel_values[item_name]})
            fuel_items[item_name] = nil
BioInd.writeDebug("'Moved recipe data from fuel_items to fuel_values", {item_name})
          else
BioInd.writeDebug("No fuel_value for %s \"%s\" yet", {item_data.type, item_name})
            run_again = true
          end
        -- Something has gone wrong: Remove recipe from item_data.recipe_order and
        -- schedule re-run to try the next recipe!
        else
BioInd.writeDebug("Removing \"%s\" from recipe_order.", {recipe_name})
          table.remove(item_data.recipe_order, 1)
          run_again = true
BioInd.writeDebug("Next entry: \"%s\"", {item_data.recipe_order[1]})
        end
      end
    end
  end
BioInd.show("Need to run again", run_again and "yes" or "no" )
BioInd.entered_function("leave")
  return run_again
end


local function find_circle(conflict_item, try_next)
BioInd.entered_function()
BioInd.writeDebug("conflict_item: %s\ttry_next: %s", {conflict_item, try_next or "nil"})

  try_next = try_next or conflict_item
  local result
BioInd.show("check", check)
  -- Did we already check this item? Then we're stuck in a loop!
  if check[try_next] then
BioInd.writeDebug("Loop detected: Already checked item %s!", {try_next})
BioInd.entered_function("leave")
    return try_next
  -- Mark item as checked
  else
    check[try_next] = true
  end

  for recipe_name, recipe_data in pairs(fuel_items[try_next] and fuel_items[try_next].made_by or {}) do
BioInd.writeDebug("Checking recipe \"%s\": %s", {recipe_name, recipe_data})
    if recipe_data.ingredients then
--~ BioInd.writeDebug("Recipe has ingredients")
      -- Return immediately if the recipe requires conflict_item
      if recipe_data.ingredients[conflict_item] then
BioInd.writeDebug("Conflicting item \"%s\" is used in recipe \"%s\" to make %s \"%s\"",
                  {conflict_item, recipe_name, fuel_items[try_next] and fuel_items[try_next].type, try_next})
        return try_next
      end

--~ BioInd.writeDebug("Need to check ingredients of recipe")
      -- Otherwise check all ingredients if *they* require conflict_item
      for ingredient_name, ingredient_data in pairs(recipe_data.ingredients) do
--~ BioInd.show("Checking ingredient", ingredient_name)
        result = find_circle(conflict_item, ingredient_name)
BioInd.writeDebug("Checked ingredients of \"%s\" for conflict_item \"%s\". Result: \"%s\"",
                  {ingredient_name, conflict_item, result or "nil"})
        if result then
--~ BioInd.show("result", result)
          return result
        else
BioInd.writeDebug("Checking next ingredient")
        end
      end
    end
  end
BioInd.entered_function("leave")
end


-- Run this until all fuel_items have been moved to fuel_values (not new_pass) or
-- until there is an eternal loop (new pass == true and fuel_items hasn't changed)
passes = 0
local conflict_item, index, recipe_removed
repeat
  old = table_size(fuel_items)
  conflict_item = nil
  recipe_removed = nil
  passes = passes + 1

BioInd.writeDebug("Need to get fuel_value for %s fuel_items (pass %s)", {table_size(fuel_items), passes})
  new_pass = get_fuel_values()
--~ BioInd.show("Another pass has been requested", new_pass)
--~ BioInd.writeDebug("fuel_items from previous run: %s\tfuel_items now: %s", {old, table_size(fuel_items)})

  -- Try to remove deadlocks
  if new_pass and old == table_size(fuel_items) then
BioInd.writeDebug("Impossible situation: Deadlock detected!")
    -- Deadlock is caused by an ingredient in a recipe making fuel_items
    for item_name, item_data in pairs(fuel_items) do
BioInd.show("Checking item", item_name)
      if item_data.made_by and next(item_data.made_by) then

        -- There may by several recipes making that item. Use the one with the lowest
        -- amount_per_sec (first recipe in recipe_order).
        repeat
          recipe_name = item_data.recipe_order[1]
          recipe_data = recipe_name and item_data.made_by[recipe_name]

BioInd.show("Checking recipe", recipe_name)

          check = {}
          --~ cnt = 0
          i_name = nil

          repeat
            recipe_removed = false

            -- Make sure that we still have a recipe and that it still has ingredients.
            if recipe_data and recipe_data.ingredients and next(recipe_data.ingredients) then
              -- Get recipe ingredients! Return values for next(list, index):
              -- index == nil                                   --> list[1]
              -- index == 0 or index > table_size(list)         --> Error
              -- index > 0 and index < table_size(list)         --> list[index+1]
              -- index == table_size(list)                      --> nil
              index = i_name

              -- We already checked that recipe_data.ingredients is not empty!
              i_name, i_data = next(recipe_data.ingredients, index)
BioInd.show("i_name", i_name)

              -- Obvious conflict: item is used as ingredient for itself!
              if i_name == item_name then
  BioInd.writeDebug("Removing ingredient %s from recipe \"%s\" -- makes %s \"%s\"!",
                    {i_name, recipe_name, item_data.type, item_name})
                conflict_item = i_name
              -- Check if the item is used recursively (skip items stored in fuel_values!)
              elseif not fuel_values[i_name] then
  BioInd.writeDebug("Checking if ingredient \"%s\" is used recursively", i_name)
                conflict_item = find_circle(item_name, i_name)
  BioInd.show("conflict_item", conflict_item)
              --~ else
--~ BioInd.writeDebug("Skipping ingredient \"%s\" (already has a fuel_value)", {i_name})
              end

            -- No ingredients left. Break out of the loop!
            else
BioInd.writeDebug("Recipe \"%s\" has no ingredients left -- removing recipe!", {recipe_name})
              item_data.made_by[recipe_name] = nil
BioInd.show("item_data.made_by", item_data.made_by)
              -- Removing elements from a table while iterating over it in a for-loop
              -- my cause unexpected results, so let's schedule a re-run of the outer repeat…until!
              recipe_removed = true
              table.remove(item_data.recipe_order, 1)
              break
            end
BioInd.writeDebug("conflict_item: %s\ti_name: %s\trecipe_removed: %s",
                  { conflict_item or "nil", i_name or "nil", recipe_removed or "nil" })


          -- Stop when there either is a conflicting item or a recipe has been removed!
          until conflict_item or recipe_removed

        -- Stop if there's a conflicting item or if no recipe makes this item
        until conflict_item or not recipe_name
        -- Removed recursively used item. Start over again!
        if conflict_item then
BioInd.show("fuel_items[" .. conflict_item .. "]", fuel_items[conflict_item])
BioInd.writeDebug("Removing conflicting item %s from fuel_items and recipes", {conflict_item})
          fuel_items[conflict_item] = nil
          remove_no_fuel_items(fuel_items, conflict_item)
          remove_no_recipes(fuel_items)
          break
        end
        -- A single recipe has been removed. Remove the item if this was the last recipe making it!
        if recipe_removed then
BioInd.writeDebug("Check if last recipe was removed from fuel_items[%s]", {item_name})
          remove_no_recipes(fuel_items)
          break
        end
      end
    end
  end

BioInd.show("new_pass", new_pass)
BioInd.show("old == table_size(fuel_items)", old == table_size(fuel_items))

until
      -- No request for a new pass
      not new_pass or
      -- Another pass has been requested, but the number of fuel_items didn't change and
      -- no recipe was removed
      (old == table_size(fuel_items) and not recipe_removed)

BioInd.writeDebug("Calculated fuel_value for all fuel_items (needed %s passes)", {passes})
BioInd.show("fuel_items", fuel_items)
BioInd.show("Number of fuel_items", table_size(fuel_items))
BioInd.show("fuel_values", fuel_values)
BioInd.show("Number of entries in fuel_values", table_size(fuel_values))
BioInd.writeDebug("Needed %s passes", {passes})


------------------------------------------------------------------------------------
--                Set fuel_values of items that don't have one yet                --
------------------------------------------------------------------------------------
for item_name, item_data in pairs(fuel_values) do
  item = data.raw[item_data.type][item_name]

  if not item.fuel_value then
    item.fuel_value = item_data.fuel_value
    item.fuel_category = fuel_category
--~ BioInd.writeDebug("Set fuel_value of %s \"%s\" to %s", {item_data.type, item_name, item.fuel_value})
log(string.format("Set fuel_value of %s \"%s\" to %s", item_data.type, item_name, item.fuel_value))
  end
end
log("Number of entries in fuel_values " .. table_size(fuel_values))


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
