--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])
BioInd.debugging.entered_file()
if not thxbob.lib.recipe then thxbob.lib.recipe = {} end

-- Added by Pi-C
-- Make sure we have a recipe
local function get_recipe(r_data)
  return (type(r_data) == "string" and data.raw.recipe[r_data]) or
          -- r_data may be a template, so we better get the real recipe from data.raw!
          (type(r_data) == "table" and
            r_data.type == "recipe" and r_data.name and data.raw.recipe[r_data.name])
end

-- Added by Pi-C
-- Make sure we have a recipe name
local function get_recipe_name(r_data)
  return (type(r_data) == "string" and r_data) or
          (type(r_data) == "table" and r_data.type == "recipe" and r_data.name)
end


-- Added by Pi-C
------------------------------------------------------------------------------------
--          Generate functions to change individual properties of recipes         --
------------------------------------------------------------------------------------
-- List of all recipe properties
-- (We must copy them when creating difficulties, we also need them to generate
--  the functions for setting individual properties!)
local recipe_properties = {
  -- Boolean values
  allow_as_intermediate = "boolean",
  allow_decomposition = "boolean",
  allow_inserter_overload = "boolean",
  allow_intermediates = "boolean",
  always_show_made_in = "boolean",
  always_show_products = "boolean",
  enabled = "boolean",
  hidden = "boolean",
  hide_from_player_crafting = "boolean",
  hide_from_stats = "boolean",
  show_amount_in_title = "boolean",
  unlock_results = "boolean",
  -- Numeric values
  emissions_multiplier = "double",
  energy_required = "double",
  overload_multiplier = "integer",
  requester_paste_multiplier = "integer",
  result_count = "integer",
  -- String values
  main_product = "string",
  result = "string",
  -- Table values!
  ingredients = "table",
  results = "table",
}

-- Added by Pi-C
------------------------------------------------------------------------------------
--                           Set properties of a recipe                           --
------------------------------------------------------------------------------------
--~ local function recipe_set_difficulty_bool_property(recipe, property, difficulty, enabled)
--~ BioInd.debugging.entered_function()
  --~ if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    --~ error(string.format("%s is not a valid difficulty!", difficulty))
  --~ end
  --~ if recipe_properties[property] ~= "bool" then
    --~ error(string.format("%s is not a boolean value!", property))
  --~ end
  --~ recipe = type(recipe) == "table" and recipe.type == "recipe" and recipe.name and
            --~ data.raw.recipe[recipe.name] or
            --~ data.raw.recipe[recipe]
--~ BioInd.debugging.show("Got recipe", recipe)

  --~ if recipe then
    --~ if difficulty ~= "" and not recipe[difficulty] then
      --~ thxbob.lib.recipe.difficulty_split(recipe.name)
    --~ end

    --~ if difficulty == "" then
      --~ recipe[property] = enabled
    --~ else
      --~ recipe[difficulty][property] = enabled
    --~ end
  --~ else
    --~ BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe})
  --~ end
--~ BioInd.debugging.entered_function("leave")
--~ end
local function recipe_set_difficulty_property_value(recipe_in, property, difficulty, value)
BioInd.debugging.entered_function({recipe_in, property, difficulty, value})

  -- Sanitize arguments
  --~ if not recipe_properties[property] then
  if not (property and recipe_properties[property]) then
    --~ error(string.format("%s is not a valid recipe property!", property or "nil"))
    BioInd.debugging.arg_err(property, "recipe property")
  end

  if
    (recipe_properties[property] == "boolean" and type(value) ~= "boolean") or
    (recipe_properties[property] == "double" and type(value) ~= "number") or
    (recipe_properties[property] == "integer" and
      type(value) ~= "number" or
      (type(value) == "number" and value ~= math.floor(value))
    ) or
    (recipe_properties[property] == "string" and type(value) ~= "string") or
    (recipe_properties[property] == "table" and type(value) ~= "table")
  then
    error(string.format("%s is not a %s value!", value, recipe_properties[property]))
  end

  BI_Functions.lib.check_difficulty(difficulty)
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in) or
                  BioInd.debugging.arg_err(recipe_in, "recipe name or recipe")

  -- Set value
  --~ if recipe then
    if difficulty == "" then
      recipe[property] = value
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe.name)
      end
      recipe[difficulty][property] = value
    end
  --~ end
BioInd.debugging.entered_function("leave")
end

-- Generate functions!
-- Set property for one difficulty ("" is the property in the recipe root):
-- thxbob.lib.recipe.recipe_set_difficulty_X(recipe, difficulty, item_in)
--
-- Set property for all difficulties, including no difficulty (directly in the recipe root):
-- thxbob.lib.recipe.set_X(recipe, value)
for property, p in pairs(recipe_properties) do
  if p == "boolean" then
    -- Usage: recipe -- name (string) or recipe data (table)
    thxbob.lib.recipe["set_difficulty_" .. property] = function(recipe, difficulty, value)
      recipe_set_difficulty_property_value(recipe, property, difficulty, value)
    end
--~ BioInd.debugging.show("Function set_difficulty_" .. property, thxbob.lib.recipe["set_difficulty_" .. property])

    -- Usage: recipe -- name (string) or recipe data (table)
    thxbob.lib.recipe["set_" .. property] = function(recipe, value)
      thxbob.lib.recipe["set_difficulty_" .. property](recipe, "", value)
      thxbob.lib.recipe["set_difficulty_" .. property](recipe, "normal", value)
      thxbob.lib.recipe["set_difficulty_" .. property](recipe, "expensive", value)
    end
--~ BioInd.debugging.show("Function set_" .. property, thxbob.lib.recipe["set_" .. property])
  end
end


-- Modified by Pi-C
------------------------------------------------------------------------------------
--                           Create recipe difficulties                           --
------------------------------------------------------------------------------------
-- Copy recipe properties from recipe root to recipe difficulties
local function split_line(recipe_in, tag)
--~ BioInd.debugging.entered_function({recipe_in, tag})
  -- Sanitize arguments
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in) or
                  BioInd.debugging.arg_err(recipe_in, "recipe name or recipe")
  if type(tag) ~= "string" then
    BioInd.debugging.arg_err(tag, "recipe name or recipe")
  end

  if recipe then
    -- Checking for nil explicitely because Boolean properties set to "false" will
    -- mess things up!
    if recipe[tag] ~= nil then
      recipe.normal[tag] = recipe.normal[tag] ~= nil and recipe.normal[tag] or
                              table.deepcopy(recipe[tag])
      recipe.expensive[tag] = recipe.expensive[tag] ~= nil and recipe.expensive[tag] or
                              table.deepcopy(recipe[tag])
    -- Only recipe.normal exists
    elseif recipe.normal[tag] ~= nil and recipe.expensive[tag] == nil then
      recipe.expensive[tag] = table.deepcopy(recipe.normal[tag])
    -- Only recipe.expensive exists
    elseif recipe.expensive[tag] ~= nil and recipe.normal[tag] == nil then
      recipe.normal[tag] = table.deepcopy(recipe.expensive[tag])
    end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
-- Make sure the difficulties exist
function thxbob.lib.recipe.difficulty_split(recipe_in)
BioInd.debugging.entered_function({recipe_in})
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in) or
                  BioInd.debugging.arg_err(recipe_in, "recipe name or recipe")

  local ret = true
  if recipe then
    recipe.normal = recipe.normal or {}
    recipe.expensive = recipe.expensive or {}

    for property, p in pairs(recipe_properties) do
      split_line(recipe, property)
    end
  else
    BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in and recipe_in.name or "nil"})
    ret = false
  end
BioInd.debugging.entered_function("leave")
  return ret
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                            Functions for ingredients                           --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                 Add ingredients                                --
------------------------------------------------------------------------------------
-- Modified by Pi-C
-- Add new item to ingredients. If it already is an ingredient, add to its amount.
function thxbob.lib.recipe.add_difficulty_ingredient(recipe_in, difficulty, item_in)
BioInd.debugging.entered_function({recipe_in, difficulty, item_in})

  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in)
  --~ item = thxbob.lib.item.basic_item(item_in)
  item = thxbob.lib.item.item(item_in)
  local recipe = get_recipe(recipe_in)


  if recipe and item and thxbob.lib.item.get_type(item.name) then
    if difficulty == "" then
      recipe.ingredients = recipe.ingredients or {}
      thxbob.lib.item.add(recipe.ingredients, item)
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe)
      end
      recipe[difficulty].ingredients = recipe[difficulty].ingredients or {}
      thxbob.lib.item.add(recipe[difficulty].ingredients, item)
    end

  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not thxbob.lib.item.get_basic_type(item.name) then
      BioInd.debugging.writeDebug("Ingredient %s does not exist.", {item_in})
    end
  end
BioInd.debugging.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.recipe.add_ingredient(recipe, item)
BioInd.debugging.entered_function({recipe, item})
  if recipe and item  then
    thxbob.lib.recipe.add_difficulty_ingredient(recipe, "", item)
    thxbob.lib.recipe.add_difficulty_ingredient(recipe, "normal", item)
    thxbob.lib.recipe.add_difficulty_ingredient(recipe, "expensive", item)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not item then
      BioInd.debugging.writeDebug("No ingredient!")
    end
  end
BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
-- Only add this item if it's not yet an ingredient in this recipe!
function thxbob.lib.recipe.add_new_difficulty_ingredient(recipe_in, difficulty, item_in)
BioInd.debugging.entered_function({recipe_in, difficulty, item_in})
  -- Sanitizing arguments
  BI_Functions.lib.check_difficulty(difficulty)

  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in)
  --~ item = thxbob.lib.item.basic_item(item_in)
  local item = thxbob.lib.item.item(item_in)


  if recipe and item and thxbob.lib.item.get_type(item.name) then
    if difficulty == "" then
      recipe.ingredients = recipe.ingredients or {}
      thxbob.lib.item.add_new(recipe.ingredients, item)
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe)
      end
      recipe[difficulty].ingredients = recipe[difficulty].ingredients or {}
      thxbob.lib.item.add_new(recipe[difficulty].ingredients, item)
    end

  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not item then
      BioInd.debugging.writeDebug("Ingredient %s does not exist.", {item_in})
    end
  end
BioInd.debugging.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.recipe.add_new_ingredient(recipe, item)
BioInd.debugging.entered_function({recipe, item})
  if recipe and item then
    thxbob.lib.recipe.add_new_difficulty_ingredient(recipe, "", item)
    thxbob.lib.recipe.add_new_difficulty_ingredient(recipe, "normal", item)
    thxbob.lib.recipe.add_new_difficulty_ingredient(recipe, "expensive", item)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not item then
      BioInd.debugging.writeDebug("No ingredient!")
    end
  end
BioInd.debugging.entered_function("leave")
end

------------------------------------------------------------------------------------
--                               Remove ingredients                               --
------------------------------------------------------------------------------------
-- Modified by Pi-C
function thxbob.lib.recipe.remove_difficulty_ingredient(recipe_in, difficulty, item_name)
BioInd.debugging.entered_function({recipe_in, difficulty, item_name})

  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)

  --~ item_name = type(item_name) == "string" and item_name or
              --~ type(item_name) == "table" and item_name.name or
              --~ BioInd.debugging.arg_err(item_name, "item name or item")
  item_name = type(item_name) == "string" and item_name or
              type(item_name) == "table" and item_name.name
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in] or
                  --~ BioInd.debugging.arg_err(recipe_in, "recipe")
  local recipe = get_recipe(recipe_in)

--~ BioInd.debugging.show("recipe", recipe)
  if recipe and item_name then
    if difficulty == "" then
      thxbob.lib.item.remove(recipe.ingredients, item_name)
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe)
      end
      thxbob.lib.item.remove(recipe[difficulty].ingredients, item_name)
    end
  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not item_name then
      BioInd.debugging.writeDebug("Item %s does not exist.", {item_name})
    end
  end
BioInd.debugging.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.recipe.remove_ingredient(recipe, item)
BioInd.debugging.entered_function({recipe, item})
  if recipe and item  then
    thxbob.lib.recipe.remove_difficulty_ingredient(recipe, "", item)
    thxbob.lib.recipe.remove_difficulty_ingredient(recipe, "normal", item)
    thxbob.lib.recipe.remove_difficulty_ingredient(recipe, "expensive", item)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not item then
      BioInd.debugging.writeDebug("No ingredient!")
    end
  end
BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                               Replace ingredients                              --
------------------------------------------------------------------------------------
-- Added by Pi-C
-- If the old item is an ingredient, remove it and add the new item instead.
--~ function thxbob.lib.recipe.replace_difficulty_ingredient(recipe_in, difficulty, old, new)
--~ BioInd.debugging.entered_function()
  --~ -- Sanitize arguments
  --~ if difficulty ~= "" and difficulty ~= "normal" and difficulty ~= "expensive" then
    --~ error(string.format("%s is not a valid difficulty!", difficulty))
  --~ end
  --~ if type(old) ~= "string" and type(old) ~= "table" or not (old.name and old.type) then
    --~ error(string.format("%s is not a valid item name or item!", old))
  --~ end
  --~ if type(new) ~= "string" and type(new) ~= "table" or not (new.name and new.type) then
    --~ error(string.format("%s is not a valid item name or item!", new))
  --~ end

  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
--~ BioInd.debugging.writeDebug("recipe %s: %s\tdifficulty: %s\told: %s\tnew: %s", {recipe_in, recipe, difficulty, old, new})


  --~ local old_name = type(old) == "string" and old or type(old) == "table" and old.name
  --~ local new_name = type(new) == "string" and new or type(new) == "table" and new.name
--~ BioInd.debugging.writeDebug("old_name: %s\tnew_name: %s", {old_name, new_name})
  --~ local old_type = old_name and thxbob.lib.item.get_basic_type(old_name)
  --~ local new_type = new_name and thxbob.lib.item.get_basic_type(new_name)
--~ BioInd.debugging.writeDebug("old_type: %s\tnew_type: %s", {old_type, new_type})
  --~ local ingredients
  --~ local retval = false

  --~ -- old_type may be nil if item "old" has not been created!
  --~ if recipe and new_type then
    --~ if difficulty == "" then
      --~ ingredients = recipe.ingredients and table.deepcopy(recipe.ingredients)
    --~ else
      --~ if not recipe[difficulty] then
        --~ thxbob.lib.recipe.difficulty_split(recipe.name)
      --~ end
      --~ ingredients = recipe[difficulty].ingredients and table.deepcopy(recipe[difficulty].ingredients)
    --~ end
--~ BioInd.debugging.writeDebug("ingredients: %s", {ingredients})
    --~ if ingredients then
      --~ local item, new_item
      --~ -- Items and fluids
      --~ local amount = 0
      --~ local catalyst_amount = 0
      --~ -- Fluids
      --~ local fluidbox_index
      --~ local temperature = 0
      --~ local minimum_temperature = 0
      --~ local maximum_temperature = 0
      --~ local cnt = 0
      --~ local min_max_cnt = 0

      --~ -- Get the total amount in case the same ingredient is listed several times!
      --~ for i, ingredient in pairs(ingredients) do
--~ BioInd.debugging.writeDebug("i: %s\tingredient: %s", {i, ingredient})
        --~ item = thxbob.lib.item.item(ingredient)
--~ BioInd.debugging.writeDebug("item: %s", {item})

        --~ if item.name == old_name then
          --~ amount = amount + (item.amount or 0)
          --~ catalyst_amount = catalyst_amount + (item.catalyst_amount or 0)
--~ BioInd.debugging.show("amount", amount)
--~ BioInd.debugging.show("catalyst_amount", catalyst_amount)

          --~ -- Only for fluids!
          --~ if item.type == "fluid" then
            --~ -- temperature will overwrite minimum_temperature/maximum_temperature
            --~ if item.temperature then
              --~ temperature = temperature + item.temperature
              --~ cnt = cnt + 1
            --~ -- No minimum temperature without maximum temperature (and vice versa)!
            --~ elseif item.minimum_temperature then
              --~ minimum_temperature = minimum_temperature + item.minimum_temperature
              --~ minimum_temperature = maximum_temperature + item.maximum_temperature
              --~ min_max_cnt = min_max_cnt + 1
            --~ end
            --~ -- Use the first fluidbox_index we find!
            --~ fluidbox_index = fluidbox_index or item.fluidbox_index
          --~ end
        --~ end
      --~ end

      --~ -- All amounts are now definitely numbers >=0
      --~ if amount > 0 then
--~ BioInd.debugging.show("amount", amount)

        --~ -- "new" was just a name, use data from old item!
        --~ if type(new) == "string" then
--~ BioInd.write("Use data of old item!")
          --~ new_item = {
            --~ name = new_name,
            --~ type = new_type,
            --~ amount = amount,
            --~ catalyst_amount = (catalyst_amount > 0 and catalyst_amount) or nil,
            --~ temperature = (temperature > 0 and temperature) or nil,
            --~ minimum_temperature = (minimum_temperature > 0 and minimum_temperature) or nil,
            --~ minimum_temperature = (minimum_temperature > 0 and minimum_temperature) or nil,
          --~ }

        --~ -- "new" was an item specification, use that!
        --~ else
--~ BioInd.debugging.show(new_item)
         --~ if difficulty
        --~ -- Switch from fluid to item
        --~ if old_type == "fluid" and new_type == "item" then
--~ BioInd.debugging.writeDebug("Switching from fluid to item")
          --~ amount = math.ceil(amount * 0.1)
          --~ catalyst_amount = math.ceil(catalyst_amount * 0.1)
          --~ minimum_temperature, maximum_temperature = nil

        --~ -- Switch from item to fluid
        --~ elseif old_type == "item" and new_type == "fluid" then
--~ BioInd.debugging.writeDebug("Switching from item to fluid")
          --~ amount = amount * 10
          --~ catalyst_amount = catalyst_amount * 10

        --~ --

        --~ end
        --~ thxbob.lib.recipe.remove_difficulty_ingredient(recipe, difficulty, old)
        --~ thxbob.lib.recipe.add_difficulty_ingredient(recipe, difficulty, {
          --~ name = new,
          --~ type = new_type,
          --~ amount = amount,
          --~ catalyst_amount = catalyst_amount,
          --~ -- The following are only for fluid ingredients!
          --~ temperature = item.temperature,
          --~ minimum_temperature = item.minimum_temperature,
          --~ maximum_temperature = item.maximum_temperature,
          --~ fluidbox_index = item.fluidbox_index,
        --~ })
        --~ retval = true
      --~ end
    --~ end
  --~ else
    --~ if not recipe then
      --~ BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    --~ end
    --~ if not new_type then
      --~ BioInd.debugging.writeDebug("Ingredient %s does not exist.", {new})
    --~ end
  --~ end

--~ BioInd.debugging.entered_function("leave")
  --~ return retval
--~ end
function thxbob.lib.recipe.replace_difficulty_ingredient(recipe_in, difficulty, old, new)
BioInd.debugging.entered_function({recipe_in, difficulty, old, new})

  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)
  if type(old) ~= "string" and (type(old) ~= "table" or not (old.name and old.type)) then
    error(string.format("\"%s\" is not a valid item name or item!", old))
  end
  if type(new) ~= "string" and (type(new) ~= "table" or not (new.name and new.type)) then
    error(string.format("\"%s\" is not a valid item name or item!", new))
  end

  local recipe = get_recipe(recipe_in)
--~ BioInd.debugging.writeDebug("recipe \"%s\": %s\tdifficulty: \"%s\"\told: \"%s\"\tnew: \"%s\"", {recipe_in, recipe, difficulty, old, new})

  local retval = false

  -- Recipe must exist
  if recipe then
    local ingredient, ingredients
    local new_item, new_name, new_type, old_name, old_type

    local old_name = (type(old) == "string" and old) or
                      (type(old) == "table" and old.name)
--~ BioInd.debugging.show("old_name", old_name)

    ingredients = BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, difficulty)
--~ BioInd.debugging.show("ingredients", ingredients or "nil")

    -- We only need to do this if the old item is among the recipe ingredients
    if ingredients and ingredients[old_name] then

      ingredient = ingredients[old_name]
      new_name = (type(new) == "string" and new) or (type(new) == "table" and new.name)
      new_type = thxbob.lib.item.get_basic_type(new)
      old_type = ingredient.type
--~ BioInd.debugging.show("new_name", new_name)
--~ BioInd.debugging.show("new_type", new_type)
--~ BioInd.debugging.show("old_type", old_type)

      -- "new" was just a name, use data from old item!
      if type(new) == "string" then
--~ BioInd.debugging.writeDebug("Use data of old item!")
        new_item = {
          name = new_name,
          type = new_type,
          amount = ingredient.amount,
          catalyst_amount = ingredient.catalyst_amount
        }
        -- Add data for fluid ingredients, if necessary
        if new_type == "fluid" then
--~ BioInd.debugging.writeDebug("Must add data for fluid ingredients, if they exist!")
          new_item.temperature = ingredient.temperature
          new_item.minimum_temperature = ingredient.minimum_temperature
          new_item.maximum_temperature = ingredient.maximum_temperature
          new_item.fluidbox_index = ingredient.fluidbox_index
        --~ else
--~ BioInd.debugging.writeDebug("Item \"%s\" is not a fluid!", {new_name})
        end
--~ BioInd.debugging.show("new_item", new_item)

        -- Switch from fluid to item?
        if old_type == "fluid" and new_type == "item" then
--~ BioInd.debugging.writeDebug("Switching from fluid to item?")
          new_item.amount = math.ceil(new_item.amount * 0.1)
          new_item.catalyst_amount = math.ceil(new_item.catalyst_amount * 0.1)
          new_item.minimum_temperature, new_item.maximum_temperature = nil
        -- Switch from item to fluid
        elseif old_type == "item" and new_type == "fluid" then
--~ BioInd.debugging.writeDebug("Switching from item to fluid?")
          new_item.amount = new_item.amount * 10
          new_item.catalyst_amount = new_item.catalyst_amount * 10
        end

        new_item.catalyst_amount = new_item.catalyst_amount > 0 and new_item.catalyst_amount or nil

      -- "new" was an item specification, use that!
      else
--~ BioInd.debugging.writeDebug("Use data of new item!")
        new_item = thxbob.lib.item.item(new)
      end
--~ BioInd.debugging.show("new_item", new_item)

      -- Remove old ingredient
--~ BioInd.debugging.writeDebug("Removing ingredient \"%s\" from recipe \"%s\"", {old_name, recipe.name})
      thxbob.lib.recipe.remove_difficulty_ingredient(recipe, difficulty, old)
      -- Add new ingredient
--~ BioInd.debugging.writeDebug("Adding ingredient \"%s\" to recipe \"%s\"", {new_name, recipe.name})
      thxbob.lib.recipe.add_difficulty_ingredient(recipe, difficulty, new_item)

      retval = true
    end
  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not new_type then
      BioInd.debugging.writeDebug("Ingredient %s does not exist.", {new})
    end
  end

BioInd.debugging.entered_function("leave")
  return retval
end


-- Modified by Pi-C
function thxbob.lib.recipe.replace_ingredient(recipe, old, new)
BioInd.debugging.entered_function({recipe, old, new})
  if recipe and old and new then
    thxbob.lib.recipe.replace_difficulty_ingredient(recipe, "", old, new)
    thxbob.lib.recipe.replace_difficulty_ingredient(recipe, "normal", old, new)
    thxbob.lib.recipe.replace_difficulty_ingredient(recipe, "expensive", old, new)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not old then
      BioInd.debugging.writeDebug("No old ingredient to replace!")
    end
    if not new then
      BioInd.debugging.writeDebug("No new ingredient!")
    end
  end
BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.recipe.replace_ingredient_in_all(old, new)
BioInd.debugging.entered_function({old, new})

  if not (old and thxbob.lib.item.get_basic_type(old)) then
    BioInd.debugging.arg_err(old, "result")
  end
  if not (new and thxbob.lib.item.get_basic_type(new)) then
    BioInd.debugging.arg_err(new, "result")
  end

  --~ if old and new and thxbob.lib.item.get_basic_type(old) and thxbob.lib.item.get_basic_type(new) then
    for recipe_name, recipe in pairs(data.raw.recipe) do
      BioInd.debugging.writeDebug("Recipe \"%s\": Trying to replace ingredient \"%s\" with \"%s\"", {
        recipe_name,
        --~ type(old) == "table" and old.name or old or "nil",
        --~ type(new) == "table" and new.name or new or "nil"
        type(old) == "table" and old.name or old,
        type(new) == "table" and new.name or new
      })
      thxbob.lib.recipe.replace_ingredient(recipe_name, old, new)
    end
  --~ else
    --~ BioInd.debugging.writeDebug("%s is not a valid ingredient!", {new})
  --~ end
BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                 Set ingredients                                --
------------------------------------------------------------------------------------
-- If the item is used in the recipe, it will be overwritten (new amount)
-- Added by Pi-C
function thxbob.lib.recipe.set_difficulty_ingredient(recipe_in, difficulty, item_in)
BioInd.debugging.entered_function({recipe_in, difficulty, item_in})
  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in)
  --~ item = thxbob.lib.item.basic_item(item_in)
  local item = thxbob.lib.item.item(item_in)

  if recipe and item and thxbob.lib.item.get_type(item.name) then
    if difficulty == "" then
      thxbob.lib.item.set(recipe.ingredients, item)
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe.name)
      end
      thxbob.lib.item.set(recipe[difficulty].ingredients, item)
    end

  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not thxbob.lib.item.get_basic_type(item.name) then
      BioInd.debugging.writeDebug("%s is not a valid ingredient.", {item_in})
    end
  end
BioInd.debugging.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.recipe.set_ingredient(recipe, item)
  BioInd.debugging.entered_function({recipe, item})

  if recipe and item then
    thxbob.lib.recipe.set_difficulty_ingredient(recipe, "", item)
    thxbob.lib.recipe.set_difficulty_ingredient(recipe, "normal", item)
    thxbob.lib.recipe.set_difficulty_ingredient(recipe, "expensive", item)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not item then
      BioInd.debugging.writeDebug("No ingredient!")
    end
  end

  BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                              Functions for results                             --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                                   Add result                                   --
------------------------------------------------------------------------------------
-- Modified by Pi-C
-- TODO: Check if main_product must be set (#results > 1 and no subgroup)
function thxbob.lib.recipe.add_difficulty_result(recipe_in, difficulty, item_in)
BioInd.debugging.entered_function({recipe_in, difficulty, item_in})
  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in)

  --~ item = thxbob.lib.item.basic_item(item_in)
  local item = thxbob.lib.item.item(item_in)

  if recipe and item and thxbob.lib.item.get_type(item.name) then
    if difficulty == "" then
      thxbob.lib.result_check(recipe)
      thxbob.lib.item.add(recipe.results, item)
--~ BioInd.debugging.show("Added result to raw recipe", recipe.results)
    else
      if not recipe[difficulty] then
--~ BioInd.debugging.writeDebug("Need to create difficulty %s!", {difficulty})
        thxbob.lib.recipe.difficulty_split(recipe)
      end
      thxbob.lib.result_check(recipe[difficulty])
      thxbob.lib.item.add(recipe[difficulty].results, item)
--~ BioInd.debugging.show("Added result to difficulty " .. difficulty, recipe[difficulty].results)
    end
  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not thxbob.lib.item.get_basic_type(item.name) then
      BioInd.debugging.writeDebug("Item %s does not exist.", {item_in})
    end
  end
BioInd.debugging.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.recipe.add_result(recipe, item)
BioInd.debugging.entered_function({recipe, item})
  if recipe and item then
    thxbob.lib.recipe.add_difficulty_result(recipe, "", item)
    thxbob.lib.recipe.add_difficulty_result(recipe, "normal", item)
    thxbob.lib.recipe.add_difficulty_result(recipe, "expensive", item)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not item then
      BioInd.debugging.writeDebug("No ingredient!")
    end
  end
BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                 Replace results                                --
------------------------------------------------------------------------------------
-- Added by Pi-C
-- If the old item is a result, remove it and add the new item instead.
function thxbob.lib.recipe.replace_difficulty_result(recipe_in, difficulty, old, new)
BioInd.debugging.entered_function({recipe_in, difficulty, old, new})
  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)
  --~ local recipe  = type(recipe_in) == "table" and
                    --~ recipe_in.type == "recipe" and recipe_in.name and recipe_in or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in)

  -- We can't know the type of old/new could have, so just check for property "name"!
  local old_name = (type(old) == "string") and old or
                    (type(old) == "table") and old.name or
                    error(string.format("\"%s\" is not a valid value for old result!", old))
  local new_name = (type(new) == "string") and new or
                    (type(new) == "table") and new.name or
                    error(string.format("\"%s\" is not a valid value for new result!", old))

  -- Will be "item" or "fluid"
  local new_type = thxbob.lib.item.get_basic_type(new_name)
  local old_type
--~ BioInd.debugging.show("old_name", old_name)
--~ BioInd.debugging.show("new_name", new_name)
--~ BioInd.debugging.show("new_type", new_type)

  local result, results, main_product, diff_results
  local retval = false

--~ BioInd.debugging.writeDebug("Trying to replace result \"%s\" with \"%s\" in recipe \"%s\"", {old_name, new_name, recipe and recipe.name or "nil"})

  if recipe and old_name and new_name then
    results = BI_Functions.lib.get_difficulty_recipe_results(recipe_in, difficulty)
--~ BioInd.debugging.writeDebug("Recipe results for difficulty \"%s\": %s", {difficulty, results or "nil"})

    -- Check if recipe has old result
    if results and results[old_name] then
--~ BioInd.debugging.writeDebug("Must replace result \"%s\" with \"%s\": %s", {old_name, new_name, results[old_name]})

      old_type = results[old_name].type

      -- Set main_product, if necessary
      if difficulty == "" and recipe.main_product == old_name then
        recipe.main_product = new_name
      elseif difficulty ~= "" and recipe[difficulty].main_product == old_name then
        recipe[difficulty].main_product = new_name
      end

      -- Remove old result
--~ BioInd.debugging.writeDebug("Removing old result")
      thxbob.lib.recipe.remove_difficulty_result(recipe, difficulty, old_name)

      -- Add new result
--~ BioInd.debugging.writeDebug("Preparing data for new result")
      result = table.deepcopy(results[old_name])
      result.name = new_name
      result.type = new_type

      -- Result "new" is just a string, use data from old result!
      if (type(new) == "string") then
--~ BioInd.debugging.writeDebug("Result \"new\" is a string: Using data from old result!")
        -- Switch from "fluid" to "item"
        if old_type == "fluid" and new_type == "item" then
          result.amount = result.amount and math.ceil(result.amount * 0.1)
          result.amount_min = result.amount_min and math.ceil(result.amount_min * 0.1)
          result.amount_max = result.amount_max and math.ceil(result.amount_max * 0.1)
          result.catalyst_amount = result.catalyst_amount and math.ceil(result.catalyst_amount * 0.1)

          result.temperature = nil
          result.fluidbox_index = nil
--~ BioInd.debugging.writeDebug("Switched from fluid to item!")
        -- Switch from "item" to "fluid"
        elseif old_type == "item" and new_type == "fluid" then
          result.amount = result.amount and math.ceil(result.amount * 10)
          result.amount_min = result.amount_min and math.ceil(result.amount_min * 10)
          result.amount_max = result.amount_max and math.ceil(result.amount_max * 10)
          result.catalyst_amount = result.catalyst_amount and math.ceil(result.catalyst_amount * 10)
--~ BioInd.debugging.writeDebug("Switched from item to fluid!")
        end

      -- Result "new" is an item
      else
--~ BioInd.debugging.writeDebug("Result \"new\" is a table: Copying data from new result!")
        result.type = new_type
        result.amount = new.amount
        result.amount_min = new.amount_min
        result.amount_max = new.amount_max
        result.catalyst_amount = new.catalyst_amount
        result.probability = new.probability
        result.temperature = new.temperature
        result.fluidbox_index = new.fluidbox_index
      end
--~ BioInd.debugging.show("New result", result)

      -- Add new result!
      thxbob.lib.recipe.add_difficulty_result(recipe, difficulty, result)
      retval = true
    end
  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not new_type then
      BioInd.debugging.writeDebug("Result %s does not exist.", {new})
    end
  end
--~ BioInd.debugging.show("Return", retval)
BioInd.debugging.entered_function("leave")
  return retval
end


-- Added by Pi-C
function thxbob.lib.recipe.replace_result(recipe, old, new)
BioInd.debugging.entered_function({recipe, old, new})

  --~ recipe = type(recipe) == "string" and data.raw.recipe[recipe] or
            --~ type(recipe) == "table" and recipe.type == "recipe" and data.raw.recipe[recipe.name]

  if recipe and old and new then
    thxbob.lib.recipe.replace_difficulty_result(recipe, "", old, new)
    thxbob.lib.recipe.replace_difficulty_result(recipe, "normal", old, new)
    thxbob.lib.recipe.replace_difficulty_result(recipe, "expensive", old, new)
--~ BioInd.debugging.show("Changed recipe", recipe)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not old then
      BioInd.debugging.writeDebug("No old result to replace!")
    end
    if not new then
      BioInd.debugging.writeDebug("No new result!")
    end
  end

BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.recipe.replace_result_in_all(old, new)
BioInd.debugging.entered_function({old, new})

  if not (old and thxbob.lib.item.get_basic_type(old)) then
    BioInd.debugging.arg_err(old, "result")
  end
  if not (new and thxbob.lib.item.get_basic_type(new)) then
    BioInd.debugging.arg_err(new, "result")
  end

  --~ if old and new and thxbob.lib.item.get_basic_type(old) and thxbob.lib.item.get_basic_type(new) then
    for r_name, recipe in pairs(data.raw.recipe) do
      thxbob.lib.recipe.replace_result(r_name, old, new)
    end
  --~ else
    --~ BioInd.debugging.writeDebug("%s is not a valid result!", {new})
  --~ end

BioInd.debugging.entered_function("leave")
end



------------------------------------------------------------------------------------
--                                  Remove result                                 --
------------------------------------------------------------------------------------
-- Modified by Pi-C
-- TODO: Check if a new main_product is needed!
function thxbob.lib.recipe.remove_difficulty_result(recipe_in, difficulty, item_name)
BioInd.debugging.entered_function({recipe_in, difficulty, item_name})

--~ BioInd.debugging.writeDebug("recipe_in: %s\tdifficulty: %s\titem_name: %s", {recipe_in, difficulty, item_name})
  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in)

  if recipe and type(item_name) == "string" then
    if difficulty == "" then
      thxbob.lib.result_check(recipe)
      thxbob.lib.item.remove(recipe.results, item_name)
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe)
      end
      thxbob.lib.result_check(recipe[difficulty])
      thxbob.lib.item.remove(recipe[difficulty].results, item_name)
    end
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if type(item_name) ~= "string" then
      BioInd.debugging.writeDebug("No item name!")
    end
  end
BioInd.debugging.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.recipe.remove_result(recipe, item)
BioInd.debugging.entered_function({recipe, item})
  if recipe and item then
    thxbob.lib.recipe.remove_difficulty_result(recipe, "", item)
    thxbob.lib.recipe.remove_difficulty_result(recipe, "normal", item)
    thxbob.lib.recipe.remove_difficulty_result(recipe, "expensive", item)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not item then
      BioInd.debugging.writeDebug("No item!")
    end
  end
BioInd.debugging.entered_function("leave")
end


------------------------------------------------------------------------------------
--                                   Set result                                   --
------------------------------------------------------------------------------------
-- If the item is used in the recipe, it will be overwritten (new amount)
-- Added by Pi-C
function thxbob.lib.recipe.set_difficulty_result(recipe_in, difficulty, item_in)
BioInd.debugging.entered_function({recipe_in, difficulty, item_in})
--~ BioInd.debugging.writeDebug("Recipe: %s\tItem: %s", {recipe_in, item_in})
  -- Sanitize arguments
  BI_Functions.lib.check_difficulty(difficulty)
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  local recipe = get_recipe(recipe_in)
  --~ item = thxbob.lib.item.basic_item(item_in)
  local item = thxbob.lib.item.item(item_in)

  if recipe and item and thxbob.lib.item.get_type(item.name) then
    if difficulty == "" then
      thxbob.lib.result_check(recipe)
      thxbob.lib.item.set(recipe.results, item)
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe.name)
      end
      thxbob.lib.result_check(recipe[difficulty])
      thxbob.lib.item.set(recipe[difficulty].results, item)
    end

  else
    if not recipe then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe_in})
    end
    if not thxbob.lib.item.get_basic_type(item.name) then
      BioInd.debugging.writeDebug("%s is not a valid result.", {item_in})
    end
  end
BioInd.debugging.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.recipe.set_result(recipe, item)
BioInd.debugging.entered_function({recipe, item})
  if recipe and item then
    thxbob.lib.recipe.set_difficulty_result(recipe, "", item)
    thxbob.lib.recipe.set_difficulty_result(recipe, "normal", item)
    thxbob.lib.recipe.set_difficulty_result(recipe, "expensive", item)
  else
    if not recipe then
      BioInd.debugging.writeDebug("No recipe!")
    end
    if not item then
      BioInd.debugging.writeDebug("No item!")
    end
  end
BioInd.debugging.entered_function("leave")
end
