
function BI_Functions.lib.allow_productivity(recipe_name)
  if data.raw.recipe[recipe_name] then
    for i, module in pairs(data.raw.module) do
      if module.limitation and module.effect.productivity then
        table.insert(module.limitation, recipe_name)
      end
    end
  end
end


function BI_Functions.lib.get_recipe_ingredients(ingredients)
  ingredients = type(ingredients) == "table" and ingredients or {}

  local name, amount
  local ret = {}
  for i, ingredient in ipairs(ingredients) do
    name = ingredient.name or ingredient[1]
    amount = ingredient.amount or ingredient[2]
    if not (name and amount) then
      error(string.format("%s is not a valid recipe ingredient specification!"),
                            serpent.line(ingredient))
    end
    ret[name] = {type = ingredient.type or "item", name = name, amount = amount}
  end
  return ret
end



function BI_Functions.lib.remove_from_blueprint(check_tile)
  if data.raw.tile[check_tile] then
    data.raw.tile[check_tile].can_be_part_of_blueprint = false
  end
end


function BI_Functions.lib.fuel_emissions_multiplier_update(item2update, value)
  local target = data.raw.item[item2update]
  if target and target.fuel_value then
    target.fuel_emissions_multiplier = value
  end
end
