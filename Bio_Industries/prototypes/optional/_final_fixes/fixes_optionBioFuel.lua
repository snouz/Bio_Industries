------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Fuel"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local boilers = data.raw.boiler
local recipes = data.raw.recipe
local boiler_group = boilers["boiler"].fast_replaceable_group or "boiler"
local boiler, recipe, ingredient, ingredients, amount


------------------------------------------------------------------------------------
--                    Make vanilla and Bio boilers exchangeable                   --
------------------------------------------------------------------------------------
local boilers = data.raw.boiler
local boiler_group = boilers["boiler"].fast_replaceable_group or "boiler"
local boiler

for b, b_name in ipairs({"boiler", "bi-bio-boiler"}) do
  boiler = boilers[b_name]
  boiler.fast_replaceable_group = boiler_group
  BioInd.modified_msg("fast_replaceable_group", boiler)
end


------------------------------------------------------------------------------------
--        Make Bio boilers more efficient than the boilers they are made of       --
------------------------------------------------------------------------------------
-- Get the number of boilers used as ingredient
recipe = recipes[BI.additional_recipes.BI_Bio_Fuel.bio_boiler.name]
boiler = boilers[BI.additional_entities.BI_Bio_Fuel.bio_boiler.name]

if recipe and boiler then
  ingredients = BI_Functions.lib.get_recipe_ingredients(recipe)

  -- Find boiler among ingredients. Other mods may have exchanged it against another
  -- variety!
  for i, i_data in pairs(ingredients) do
    if i:find("boiler") and boilers[i] then
      ingredient = boilers[i]
      amount = i_data.amount
BioInd.writeDebug("Found boiler %s (using %s)", {i, amount})
      break
    end
  end

  -- Set energy_consumption, emissions_per_minute, effectivity, health, and localization
  if amount then
    boiler.localised_description = {"entity-description.bi-bio-boiler", amount, amount * 0.5}
    BioInd.modified_msg("localization", boiler)

    boiler.energy_consumption = (util.parse_energy(ingredient.energy_consumption) * amount) .. "J"
    BioInd.modified_msg("energy_consumption", boiler)

    boiler.energy_source.emissions_per_minute =
      ingredient.energy_source.emissions_per_minute * amount * 0.5
    BioInd.modified_msg("emissions_per_minute", boiler)

    boiler.energy_source.effectivity =
      ingredient.energy_source.effectivity * amount * 0.5
    BioInd.modified_msg("effectivity", boiler)

    boiler.max_health = ingredient.max_health * amount * 0.75
    BioInd.modified_msg("max_health", boiler)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
