
function BI_Functions.lib.allow_productivity(recipe_name)
  if data.raw.recipe[recipe_name] then
    for i, module in pairs(data.raw.module) do
      if module.limitation and module.effect.productivity then
        table.insert(module.limitation, recipe_name)
      end
    end
  end
end

--~ -- Returns table with all results for a difficulty, or nil
--~ function BI_Functions.lib.get_difficulty_recipe_results(recipe_in, difficulty)
--~ BioInd.entered_function()
  --~ -- Sanitize arguments
  --~ if difficulty ~= "" and difficulty ~= "normal" and difficulty ~= "expensive" then
    --~ error(string.format("%s is not a valid difficulty!", difficulty))
  --~ end
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  --~ local ret = {}
--~ BioInd.show("recipe", recipe and recipe.name or "nil")
--~ BioInd.show("difficulty", difficulty == "" and "no difficulty" or difficulty)

  --~ if recipe then
    --~ local name, amount, results, crafting_time
    --~ if difficulty == "" then
      --~ thxbob.lib.result_check(recipe)
      --~ results = recipe.results
      --~ crafting_time = recipe.energy_required or 0.5
    --~ else
      --~ if not recipe[difficulty] then
        --~ thxbob.lib.recipe.difficulty_split(recipe)
      --~ end
      --~ thxbob.lib.result_check(recipe[difficulty])
      --~ results = recipe[difficulty].results
      --~ crafting_time = recipe[difficulty].energy_required or 0.5
    --~ end
--~ BioInd.writeDebug("results for %s: %s", {
  --~ difficulty == "" and "no difficulty" or "difficulty " .. difficulty, results
--~ })
    --~ for r, result in ipairs(results) do
      --~ name = result[1] or result.name
      --~ amount = result[2] or result.amount
      --~ if name and amount then
        --~ ret[name] = ret[name] or {
          --~ name = name,
          --~ type = result.type or "item",
          --~ amount = 0
        --~ }
        --~ ret[name].amount = ret[name].amount + amount
        --~ ret[name].amount_per_sec = ret[name].amount / crafting_time
      --~ end
    --~ end
  --~ end
--~ BioInd.show("ret", ret)
--~ BioInd.entered_function("leave")
  --~ return ret
--~ end

-- Returns table with all results for a difficulty, or nil
function BI_Functions.lib.get_difficulty_recipe_results(recipe_in, difficulty)
BioInd.entered_function()
  -- Sanitize arguments
  if difficulty ~= "" and difficulty ~= "normal" and difficulty ~= "expensive" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end
  local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  data.raw.recipe[recipe_in.name] or
                  data.raw.recipe[recipe_in]
  local ret = {}
BioInd.show("recipe", recipe and recipe.name or "nil")
BioInd.show("difficulty", difficulty == "" and "no difficulty" or difficulty)

  if recipe then
    local name, amount, amount_min, amount_max, catalyst_amount, probability
    local results, crafting_time

    -- Get results for difficulty
    if difficulty == "" then
      thxbob.lib.result_check(recipe)
      results = recipe.results
      crafting_time = recipe.energy_required or 0.5
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe)
      end
      thxbob.lib.result_check(recipe[difficulty])
      results = recipe[difficulty].results
      crafting_time = recipe[difficulty].energy_required or 0.5
    end
BioInd.writeDebug("results for %s: %s", {
  difficulty == "" and "no difficulty" or "difficulty " .. difficulty, results
})
    -- Cumulate results in case the same result is used several times
    for r, result in ipairs(results) do
      name = result[1] or result.name
      amount = result[2] or result.amount

      if name then
        ret[name] = ret[name] or {
          name                          = name,
          type                          = result.type or "item",
          amount                        = 0,
          amount_min                    = 0,
          amount_max                    = 0,
          catalyst_amount               = 0,
          probability                   = 0,

          -- We'll need this to calculate average values
          cnt                   = 0,
          min_max_cnt           = 0
        }
BioInd.writeDebug("ret[\"%s\"]: %s", {name, ret[name]})
        -- amount has precedence over amount_min/amount_max!
        if amount and amount > 0 then
          ret[name].amount                = ret[name].amount + amount
        -- amount_max must by >= amount_min!
        else
          amount_min = result.amount_min
          amount_max = result.amount_max

          if amount_min or amount_max then
            ret[name].min_max_cnt = ret[name].min_max_cnt + 1

            if (not amount_max or amount_max < amount_min) then
              amount_max =  amount_min
            elseif not amount_min then
              amount_min = amount_max
            end
BioInd.writeDebug("Result: %s\nname: %s\tamount: %s\tamount_min: %s\tamount_max: %s",
                  {result, name, amount or "nil", amount_min or "nil", amount_max or "nil"})

            ret[name].amount_min      = amount_min and (ret[name].amount_min + amount_min) or
                                                        ret[name].amount_min
            ret[name].amount_max      = amount_max and ret[name].amount_max + amount_max or
                                                        ret[name].amount_max
          end
        end
        ret[name].catalyst_amount   = ret[name].catalyst_amount + (tonumber(result.catalyst_amount) or 0)
        ret[name].probability       = ret[name].probability + (tonumber(result.probability) or 1)

        -- We only need this if it differs from the default value
        if result.show_details_in_recipe_tooltip == false then
          ret[name].show_details_in_recipe_tooltip = false
        end

        ret[name].cnt               = ret[name].cnt + 1
      end
    end

    -- Prepare the final list
    for r, result in pairs(ret) do
BioInd.writeDebug("Result %s: %s", {r, result}, "line")
      -- Multiplication is faster than division!
BioInd.show("result.cnt", result.cnt)
BioInd.show("result.min_max_cnt", result.min_max_cnt)
      result.cnt = result.cnt > 0 and 1/result.cnt or 1
      result.min_max_cnt = result.min_max_cnt > 0 and 1/result.min_max_cnt
BioInd.show("result.cnt", result.cnt)
BioInd.show("result.min_max_cnt", result.min_max_cnt)

      result.amount             = tonumber(result.amount) and (result.amount > 0) and
                                    result.amount or nil
--~ BioInd.show("result.amount", result.amount)
--~ BioInd.show("result.amount_min", result.amount_min)
--~ BioInd.show("result.amount_max", result.amount_max)

      -- Round up to next full number for values with x > y.5
      -- (Either both or none of amount_min and amount_max exist!)
      result.amount_min         = result.min_max_cnt and
                                    math.floor(0.5 + (result.amount_min * result.min_max_cnt)) or
                                    nil
      result.amount_max         = result.min_max_cnt and
                                    math.floor(0.5 + (result.amount_max * result.min_max_cnt)) or
                                    nil

      result.catalyst_amount    = result.catalyst_amount > 0 and
                                    math.floor(0.5 + (result.catalyst_amount * result.cnt)) or nil
      result.probability        = result.probability > 0 and result.probability ~= 1 and
                                    math.floor(0.5 + (result.probability * result.cnt)) or nil


      --~ result.amount_min, result.amount_max, result.min_max_cnt, result.cnt = nil
      result.min_max_cnt, result.cnt = nil

      result.amount_per_sec = result.amount and (result.amount / crafting_time) or
                              ((result.amount_min or 0) + (result.amount_max or 0)) * 0.5 / crafting_time
    end
  end
BioInd.show("ret", ret)
BioInd.entered_function("leave")
  return ret
end


-- Returns table with all results for "normal", "expensive", or no difficulty
-- (in that order) or nil
function BI_Functions.lib.get_recipe_results(recipe_in)
BioInd.entered_function()
  local recipe = type(recipe_in) == "string" and data.raw.recipe[recipe_in] or
            type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
            data.raw.recipe[recipe_in.name]

  local ret
BioInd.writeDebug("Get results for recipe %s", {recipe and recipe.name or "nil"})
  if recipe then
    -- If difficulty doesn't exist, it will be created from the raw recipe, so we don't
    -- need to check recipe.results!
    ret = BI_Functions.lib.get_difficulty_recipe_results(recipe, "normal") or
          BI_Functions.lib.get_difficulty_recipe_results(recipe, "expensive")
  end
BioInd.entered_function("leave")
  return ret
end


-- Returns table with accumulated amount data for requested result or nil
function BI_Functions.lib.recipe_has_result(recipe_in, result_name)
BioInd.entered_function()
  if type(result_name) ~= "string" then
    error(string.format("%s is not a valid result name!", result_name))
  end

  local recipe = type(recipe_in) == "string" and data.raw.recipe[recipe_in] or
            type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
            data.raw.recipe[recipe_in.name]

  local ret
BioInd.writeDebug("Checking recipe %s for result %s", {recipe.name, result_name})
  if recipe then
    ret = BI_Functions.lib.get_recipe_results(recipe)
BioInd.writeDebug("get difficulty results: %s", {ret})
  end
BioInd.entered_function("leave")
  return ret and ret[result_name]
end


-- Returns dictionary indexed by ingredient name
--~ function BI_Functions.lib.get_difficulty_recipe_ingredients(recipe_in, difficulty)
--~ BioInd.entered_function()
  --~ -- Sanitize arguments
  --~ if difficulty ~= "" and difficulty ~= "normal" and difficulty ~= "expensive" then
    --~ error(string.format("%s is not a valid difficulty!", difficulty))
  --~ end
  --~ local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  --~ data.raw.recipe[recipe_in.name] or
                  --~ data.raw.recipe[recipe_in]
  --~ local ret = {}
  --~ local ingredients

  --~ if recipe then
    --~ if difficulty == "" then
      --~ ingredients = recipe.ingredients
    --~ else
      --~ if not recipe[difficulty] then
        --~ thxbob.lib.recipe.difficulty_split(recipe)
      --~ end
      --~ ingredients = recipe[difficulty].ingredients
    --~ end

    --~ local name, amount
    --~ for i, ingredient in ipairs(ingredients or {}) do
--~ BioInd.writeDebug("Ingredient %s: %s", {i, ingredient}, "line")
      --~ name = ingredient.name or ingredient[1]
      --~ amount = ingredient.amount or ingredient[2]
      --~ if not (name and amount) then
        --~ error(string.format("%s is not a valid recipe ingredient specification!"),
                              --~ serpent.line(ingredient))
      --~ end
      --~ ret[name] = ret[name] or {
        --~ name = name,
        --~ type = ingredient.type or "item",
        --~ amount = 0
      --~ }
      --~ ret[name].amount = ret[name].amount + amount
    --~ end
  --~ end
--~ BioInd.show("ret", ret)
--~ BioInd.entered_function("leave")
  --~ return next(ret) and ret
--~ end
function BI_Functions.lib.get_difficulty_recipe_ingredients(recipe_in, difficulty)
BioInd.entered_function()
  -- Sanitize arguments
  if difficulty ~= "" and difficulty ~= "normal" and difficulty ~= "expensive" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end
  local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  data.raw.recipe[recipe_in.name] or
                  data.raw.recipe[recipe_in]
  local ret = {}
  local ingredients

  if recipe then
    if difficulty == "" then
      ingredients = recipe.ingredients
    else
      if not recipe[difficulty] then
        thxbob.lib.recipe.difficulty_split(recipe)
      end
      ingredients = recipe[difficulty].ingredients
    end

    local name, amount, t_min, t_max
    for i, ingredient in ipairs(ingredients or {}) do
BioInd.writeDebug("Ingredient %s: %s", {i, ingredient}, "line")
      name = ingredient.name or ingredient[1]
      amount = ingredient.amount or ingredient[2]
      if not (name and amount) then
        error(string.format("%s is not a valid recipe ingredient specification!",
                              serpent.line(ingredient)))
      end

      ret[name] = ret[name] or {
        name = name,
        type = ingredient.type or "item",
        amount = 0,
        catalyst_amount = 0,
        temperature = (ingredient.type == "fluid") and 0 or nil,
        minimum_temperature = (ingredient.type == "fluid") and 0 or nil,
        maximum_temperature = (ingredient.type == "fluid") and 0 or nil,
        cnt = 0,
        min_max_cnt = 0,
      }
      ret[name].amount = ret[name].amount + amount
      ret[name].catalyst_amount = ret[name].catalyst_amount + (ingredient.catalyst_amount or 0)
BioInd.show("amount", amount)
BioInd.show("catalyst_amount", catalyst_amount)

      ret[name].cnt = ret[name].cnt + 1

      -- Only for fluids!
      if ingredient.type == "fluid" then
        -- temperature will overwrite minimum_temperature/maximum_temperature
        if ingredient.temperature then
          ret[name].temperature = ret[name].temperature + ingredient.temperature

        -- No minimum temperature without maximum temperature (and vice versa)!
        elseif ingredient.minimum_temperature or ingredient.maximum_temperature then
          t_min = ingredient.minimum_temperature or ingredient.maximum_temperature
          t_max = ingredient.maximum_temperature or ingredient.minimum_temperature

          if t_min then
           if (t_max <= t_min) then
            ret[name].temperature = ret[name].temperature + t_min
            else
              ret[name].minimum_temperature = ret[name].minimum_temperature + t_min
              ret[name].maximum_temperature = ret[name].maximum_temperature + t_max
              ret[name].min_max_cnt = ret[name].min_max_cnt + 1
            end
          end
        end
        -- Use the first fluidbox_index we find!
        ret[name].fluidbox_index = ret[name].fluidbox_index or ingredient.fluidbox_index
      end
    end

    -- Prepare the final list
    for i_name, i_data in pairs(ret) do
      -- We only need to do this if there are any temperatures!
      if i_data.temperature or i_data.minimum_temperature then

        if (i_data.cnt > 0) then
          -- Average temperature
          i_data.temperature = i_data.temperature and i_data.temperature / i_data.cnt

          -- Only necessary if there are minimum/maximum temperatures
          if i_data.min_max_cnt > 0 then

            -- Average minimum/maximum temperatures
            i_data.min_max_cnt = (i_data.min_max_cnt > 0) and (1/i_data.min_max_cnt) or 1

            i_data.minimum_temperature = i_data.minimum_temperature * i_data.min_max_count
            i_data.maximum_temperature = i_data.maximum_temperature * i_data.min_max_count

            -- No temperature yet, keep minumum/maximum temperature?
            if not i_data.temperature then
              if i_data.maximum_temperature <= i_data.minimum_temperature then

                i_data.temperature = i_data.minimum_temperature
                i_data.minimum_temperature, i_data.maximum_temperature = nil
              end
            -- Temperature already exists, add average of minimum/maximum temperature!
            elseif i_data.minimum_temperature then
              -- Account for unreasonable values
              if i_data.minimum_temperature and i_data.maximum_temperature and
                  i_data.maximum_temperature <= i_data.minimum_temperature then
                i_data.temperature = i_data.temperature + i_data.minimum_temperature
              -- Add average
              else
                i_data.temperature = (i_data.minimum_temperature + i_data.maximum_temperature) * 0.5
              end
              i_data.minimum_temperature, i_data.maximum_temperature = nil
            end
          end
        end
      end

      -- Remove counters
      i_data.cnt, i_data.min_max_cnt = nil
    end
  end
BioInd.show("ret", ret)
BioInd.entered_function("leave")
  return next(ret) and ret
end


function BI_Functions.lib.get_recipe_ingredients(recipe_in)
BioInd.entered_function()
  local recipe = type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
                  data.raw.recipe[recipe_in.name] or
                  data.raw.recipe[recipe_in]

  local ret
  if recipe then
    --~ ret = BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, "normal") or
          --~ BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, "expensive") or
          --~ BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, "")
    -- If difficulty doesn't exist, it will be created from the raw recipe, so we don't
    -- need to check recipe.ingredients!
    ret = BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, "normal") or
          BI_Functions.lib.get_difficulty_recipe_ingredients(recipe, "expensive")
  end
BioInd.show("ret", ret)
BioInd.entered_function("leave")
  return ret
end
--~ function BI_Functions.lib.get_recipe_ingredients(ingredients)
--~ BioInd.entered_function()
--~ BioInd.writeDebug("List of ingredients to check: %s", {ingredients}, "line")
  --~ local name, amount
  --~ local ret = {}
  --~ for i, ingredient in ipairs(ingredients or {}) do
--~ BioInd.writeDebug("Ingredient %s: %s", {i, ingredient}, "line")
    --~ name = ingredient.name or ingredient[1]
    --~ amount = ingredient.amount or ingredient[2]
    --~ if not (name and amount) then
      --~ error(string.format("%s is not a valid recipe ingredient specification!"),
                            --~ serpent.line(ingredient))
    --~ end
    --~ ret[name] = {type = ingredient.type or "item", name = name, amount = amount}
  --~ end
--~ BioInd.show("ret", ret)
--~ BioInd.entered_function("leave")
  --~ return next(ret) and ret
--~ end


function BI_Functions.lib.recipe_has_ingredient(recipe_in, ingredient)
BioInd.entered_function()
  if type(ingredient) ~= "string" then
    error(string.format("%s is not a valid ingredient name!", ingredient))
  end

  local recipe = type(recipe_in) == "string" and data.raw.recipe[recipe_in] or
            type(recipe_in) == "table" and recipe_in.type == "recipe" and recipe_in.name and
            data.raw.recipe[recipe_in.name]
BioInd.writeDebug("Checking recipe %s for %s", {recipe and recipe.name or "nil", ingredient})
  local ret, ingredients

  if recipe then
--~ BioInd.writeDebug("Recipe %s exists.", {recipe.name})
--~ if recipe.name == "bi-wood-pipe" then
--~ BioInd.show("recipe", recipe)
--~ end
    ingredients = BI_Functions.lib.get_recipe_ingredients(recipe.ingredients)
BioInd.show("Found ingredients", ingredients)
    ret = ingredients and ingredients[ingredient]
  end
BioInd.show("Return", ret)
BioInd.entered_function("leave")
  return ret
end

function BI_Functions.lib.remove_from_blueprint(check_tile)
  if data.raw.tile[check_tile] then
    data.raw.tile[check_tile].can_be_part_of_blueprint = false
  end
end


function BI_Functions.lib.fuel_emissions_multiplier_update(item, value)
BioInd.entered_function()
BioInd.show("item", item)
BioInd.show("factor", value)

  local target = type(item) == "string" and data.raw.item[item] or
                  type(item) == "table" and item.type == "item" and item

  if target and target.fuel_value then
BioInd.show("fuel_emissions_multiplier", target.fuel_emissions_multiplier)

    target.fuel_emissions_multiplier = value
BioInd.show("fuel_emissions_multiplier", target.fuel_emissions_multiplier)
  end
end
