--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])

thxbob.lib.item = thxbob.lib.item or {}


--~ function thxbob.lib.item.get_type(name)
  --~ local item_types = {
    --~ "ammo",
    --~ "armor",
    --~ "capsule",
    --~ "fluid",
    --~ "gun",
    --~ "item",
    --~ "mining-tool",
    --~ "module",
    --~ "tool",
    --~ "item-with-entity-data"
  --~ }

  --~ local item_type

  --~ if name then
    --~ for i, type_name in pairs(item_types) do
      --~ if data.raw[type_name][name] then
        --~ item_type = type_name
        --~ break
      --~ end
    --~ end
  --~ end

  --~ return item_type
--~ end
function thxbob.lib.item.get_type(name)

  name = type(name) == "string" and name or
          type(name) == "table" and name.name or
          error(string.format("\"%s\" is not a valid item or item name!", name))

  local item_types = {
    "ammo",
    "armor",
    "capsule",
    "fluid",
    "gun",
    "item",
    "mining-tool",
    "module",
    "tool",
    "item-with-entity-data"
  }

  local item_type

  if name then
    for i, type_name in pairs(item_types) do
      if data.raw[type_name][name] then
        item_type = type_name
        break
      end
    end
  end

  return item_type
end


function thxbob.lib.item.get_basic_type(name)
  name = type(name) == "string" and name or
          type(name) == "table" and name.name or
          error(string.format("\"%s\" is not a valid item or item name!", name))

  return data.raw.fluid[name] and "fluid" or "item"
end


function thxbob.lib.item.basic_item(inputs)
BioInd.entered_function()
BioInd.show("Inputs", inputs)
  --~ local item = {}

  --~ if inputs.name then
    --~ item.name = inputs.name
  --~ else
    --~ item.name = inputs[1]
  --~ end
--~ BioInd.show("item.name", item.name)

  --~ if inputs.amount then
    --~ item.amount = inputs.amount
  --~ else
    --~ if inputs[2] then
      --~ item.amount = inputs[2]
    --~ end
  --~ end
  --~ if not item.amount then
    --~ item.amount = 1
  --~ end
--~ BioInd.show("item.amount", item.amount)

  --~ if inputs.type then
    --~ item.type = inputs.type
  --~ else
    --~ item.type = thxbob.lib.item.get_basic_type(item.name)
  --~ end
--~ BioInd.show("item.type", item.type)


  --~ if item.type == "item" then
    --~ if item.amount > 0 and item.amount < 1 then
      --~ item.amount = 1
    --~ else
      --~ item.amount = math.floor(item.amount)
    --~ end
  --~ end
  local item = {}

  item.name = inputs.name or inputs[1]
BioInd.show("item.name", item.name)

  item.amount = inputs.amount or inputs[2]
  if not item.amount then
    -- Only for results!
    if inputs.amount_min or inputs.amount_max then
      if inputs.amount_min and inputs.amount_max then
        item.amount = math.floor(0.5 + (inputs.amount_min + inputs.amount_max) * 0.5)
      else
        item.amount = inputs.amount_min or inputs.amount_max
      end
    -- Ingredients don't have amount_min/amount_max!
    else
      item.amount = 1
    end
  end
BioInd.show("item.amount", item.amount)

  item.type = inputs.type or thxbob.lib.item.get_basic_type(item.name)
BioInd.show("item.type", item.type)

  -- Amount of "item" must be an integer because there can be no fractional
  -- items in the player's inventory!
  if item.type == "item" then
    if item.amount > 0 and item.amount < 1 then
      item.amount = 1
    else
      item.amount = math.floor(item.amount)
    end
  end
BioInd.show("item", item)
BioInd.entered_function("leave")
  return item
end

function thxbob.lib.item.item(inputs)
  local item = {}

  --~ if inputs.name then
    --~ item.name = inputs.name
  --~ else
    --~ item.name = inputs[1]
  --~ end

  --~ if inputs.amount then
    --~ item.amount = inputs.amount
  --~ else
    --~ if inputs[2] then
      --~ item.amount = inputs[2]
    --~ end
  --~ end
  --~ if not item.amount then
    --~ if inputs.amount_min and inputs.amount_max then
      --~ item.amount_min = inputs.amount_min
      --~ item.amount_max = inputs.amount_max
    --~ else
      --~ item.amount = 1
    --~ end
  --~ end
  --~ if inputs.probability then item.probability = inputs.probability end

  --~ if inputs.type then
    --~ item.type = inputs.type
  --~ else
    --~ item.type = thxbob.lib.item.get_basic_type(item.name)
  --~ end

  item.name = inputs.name or inputs[1]
  item.type = inputs.type or thxbob.lib.item.get_basic_type(item.name)

  item.amount = inputs.amount or inputs[2]
  -- Only for results, and only if named keys are used!
  if (not item.amount) and inputs.name then
    item.amount_min = inputs.amount_min or inputs.amount_max
    item.amount_max = inputs.amount_max or inputs.amount_min

    -- Only keep amount_min/amount_max if they have reasonable values!
    if item.amount_min and (item.amount_max <= item.amount_min) then
      item.amount = item.amount_min
      item.amount_min, item.amount_max = nil
    end
  end

  -- Results and ingredients:
  item.catalyst_amount = inputs.catalyst_amount

  -- Results:
  item.probability = inputs.probability
  item.show_details_in_recipe_tooltip = inputs.show_details_in_recipe_tooltip

  -- Fluids only!
  if item.type == "fluid" then
    -- Results and ingredients:
    item.temperature = inputs.temperature
    item.fluidbox_index = inputs.fluidbox_index

    -- Ingredients:
    if not item.temperature and (inputs.minimum_temperature or inputs.maximum_temperature) then
      -- These will always be nil for results!
      item.minimum_temperature = inputs.minimum_temperature or inputs.maximum_temperature
      item.maximum_temperature = inputs.maximum_temperature or inputs.minimum_temperature

      -- Use temperature if minimum/maximum temperature set no reasonable range!
      if item.minimum_temperature and item.maximum_temperature and
          item.maximum_temperature <= item.minimum_temperature then

        item.temperature = item.minimum_temperature
        item.minimum_temperature, item.maximum_temperature = nil
      end
    end
  end

  -- Custom BI-property needed for calculating fuel_values
  item.amount_per_sec = inputs.amount_per_sec

  return item
end


function thxbob.lib.item.combine(item1_in, item2_in)
  local item = {}
  local item1 = thxbob.lib.item.item(item1_in)
  local item2 = thxbob.lib.item.item(item2_in)

  item.name = item1.name
  item.type = item1.type

  if item1.amount and item2.amount then
    item.amount = item1.amount + item2.amount
  elseif item1.amount_min and item1.amount_max and item2.amount_min and item2.amount_max then
    item.amount_min = item1.amount_min + item2.amount_min
    item.amount_max = item1.amount_max + item2.amount_max
  else
    if item1.amount_min and item1.amount_max and item2.amount then
      item.amount_min = item1.amount_min + item2.amount
      item.amount_max = item1.amount_max + item2.amount
    elseif item1.amount and item2.amount_min and item2.amount_max then
      item.amount_min = item1.amount + item2.amount_min
      item.amount_max = item1.amount + item2.amount_max
    end
  end

  if item1.probability and item2.probability then
    item.probability = (item1.probability + item2.probability) * 0.5
  elseif item1.probability then
    item.probability = (item1.probability + 1) * 0.5
  elseif item2.probability then
    item.probability = (item2.probability + 1) * 0.5
  end

  return item
end


-- Modified by Pi-C
function thxbob.lib.item.add(list, item_in) --increments amount if exists
BioInd.entered_function()
  local item = thxbob.lib.item.item(item_in)
BioInd.writeDebug("Need to add %s to %s", {item, list}, "line")
  local addit = true
  for i, object in pairs(list or {}) do
BioInd.writeDebug("object: %s\titem.name: %s", {object, item.name}, "line")
    if object[1] == item.name or object.name == item.name then
BioInd.writeDebug("Item already exists!")
      addit = false
      list[i] = thxbob.lib.item.combine(object, item)
    end
  end
  if addit then
    table.insert(list, item)
  end
BioInd.show("list", list)
BioInd.entered_function("leave")
end

-- Modified by Pi-C
function thxbob.lib.item.add_new(list, item_in) --ignores if exists
  local item = thxbob.lib.item.item(item_in)
  local addit = true
  for i, object in pairs(list or {}) do
    if item.name == thxbob.lib.item.basic_item(object).name then
      addit = false
      break
    end
  end
  if addit then
    table.insert(list, item)
  end
end

-- Modified by Pi-C
function thxbob.lib.item.remove(list, item)
  local name = type(item) == "string" and item or
                type(item) == "table" and item.name or
                error(string.format("\"%s\" is not a valid item or item name!", item))
  local run_again
  -- Removing an element from a list in a for-loop may lead to wrong results!
  repeat
    run_again = false
    for i, object in ipairs(list or {}) do
      if object[1] == name or object.name == name then
        table.remove(list, i)
        run_again = true
        break
      end
    end
  until not run_again
end

-- Modified by Pi-C
function thxbob.lib.item.set(list, item_in)
BioInd.entered_function()
  local item = thxbob.lib.item.item(item_in)
BioInd.show("list", list)
BioInd.show("item", item)
  for i, object in pairs(list or {}) do
BioInd.show("object", object)
    if object[1] == item.name or object.name == item.name then
      list[i] = item
BioInd.writeDebug("Set item!")
    end
  end
end
