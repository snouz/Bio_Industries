------------------------------------------------------------------------------------
--                  Enable: Bio power production and distribution                 --
--                        (BI.Settings.BI_Power_Production)                       --
------------------------------------------------------------------------------------
local setting = "BI_Power_Production"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local boilers = data.raw.boiler
local panels  = data.raw["solar-panel"]
local accus   = data.raw["accumulator"]

local recipe, ingredient, ingredients, amount, target_amount, energy
local boiler, panel, accu, solarboiler

local function calc_energy(energy, factor)
  return (util.parse_energy(energy) * factor) .. "J"
end

------------------------------------------------------------------------------------
--      Solar boilers consume as much energy as the solar panels can produce      --
------------------------------------------------------------------------------------
-- Get the number of panels used as ingredient
recipe = recipes[BI.additional_recipes[setting].solar_boiler.name]
boiler = boilers[BI.additional_entities[setting].solar_boiler.name]

if recipe and boiler then
  ingredients = BI_Functions.lib.get_recipe_ingredients(recipe)
  amount = nil

  -- Find solar panels among ingredients. Other mods may have exchanged it against
  -- another variety!
  for i, i_data in pairs(ingredients) do
    --~ if i:find("panel") and panels[i] then
    if panels[i] then
      panel = panels[i]
      amount = i_data.amount
      BioInd.debugging.writeDebug("Recipe requires %s panels (%s)", {amount, i})
      break
    end
  end

  -- Set energy_consumption (the boiler will consume as much as the panels can produce)
  if amount then
    --~ boiler.energy_consumption = (util.parse_energy(panel.production) * amount) .. "J"
    boiler.energy_consumption = calc_energy(panel.production, amount)
    BioInd.debugging.modified_msg("energy_consumption", boiler)
  end

end


------------------------------------------------------------------------------------
--      Solar farms must be the same as 60 solar panels (entity description!)     --
------------------------------------------------------------------------------------
-- Get the number of panels used as ingredient
recipe = recipes[BI.additional_recipes[setting].solar_farm.name]
panel = panels[BI.additional_entities[setting].solar_farm.name]

if recipe and panel then
  ingredients = BI_Functions.lib.get_recipe_ingredients(recipe)
  ingredient, amount = nil, nil

  -- Find solar panels among ingredients. Other mods may have exchanged it against
  -- another variety!
  for i, i_data in pairs(ingredients) do
    --~ if i:find("panel") and panels[i] then
    if panels[i] then
      ingredient = i
      amount = i_data.amount
BioInd.debugging.writeDebug("Recipe requires %s panels (%s)", {amount, i})
      break
    end
  end

  if ingredient then
    -- Localize Solar farm description
    panel.localised_description = {"entity-description.bi-bio-solar-farm", amount, {"entity-name."..ingredient}}
    BioInd.debugging.modified_msg("localization", panel)

    -- Set produced energy
    panel.production = calc_energy(panels[ingredient].production, amount)
    BioInd.debugging.modified_msg("production", panel)
  end
end


------------------------------------------------------------------------------------
--            Huge accumulators must the same amount as the used accus            --
------------------------------------------------------------------------------------
-- Get the number of panels used as ingredient
recipe = recipes[BI.additional_recipes[setting].huge_accumulator.name]
accu = accus[BI.additional_entities[setting].huge_accumulator.name]

if recipe and accu then
  ingredients = BI_Functions.lib.get_recipe_ingredients(recipe)
  ingredient, amount = nil, nil

  -- Find solar panels among ingredients. Other mods may have exchanged it against
  -- another variety!
  for i, i_data in pairs(ingredients) do
    if i:find("accumulator") and accus[i] then
      ingredient = i
      amount = i_data.amount
BioInd.debugging.writeDebug("Recipe requires %s accumulators (%s)", {amount, i})
      break
    end
  end

  if ingredient then
    -- Localize accu description
    accu.localised_description = {"entity-description.bi-bio-accumulator", amount, {"entity-name."..ingredient}}
    BioInd.debugging.modified_msg("localization", panel)

    -- Set buffer capacity and charge/discharge speed
    energy = accus[ingredient].energy_source

    accu.energy_source.buffer_capacity = calc_energy(energy.buffer_capacity, amount)
    BioInd.debugging.modified_msg("buffer_capacity", accu)

    accu.energy_source.input_flow_limit = calc_energy(energy.input_flow_limit, amount)
    BioInd.debugging.modified_msg("input_flow_limit", accu)

    accu.energy_source.output_flow_limit = calc_energy(energy.output_flow_limit, amount)
    BioInd.debugging.modified_msg("output_flow_limit", accu)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
