------------------------------------------------------------------------------------
--             Data for rubberwood production (Industrial Revolution)             --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


BI.additional_recipes = BI.additional_recipes or {}
BI.additional_recipes.mod_compatibility = BI.additional_recipes.mod_compatibility or {}


-- Recipe names
local rubber                    = "rubberwood"
local seed, r_seed              = "bi-seed", "bi-" .. rubber .. "-seed"
local seedling, r_seedling      = "bi-seedling", "bi-" .. rubber .. "-seedling"
local logs, r_logs              = "bi-logs", "bi-" .. rubber .. "-logs"

-- Items
local wood, r_wood              = "wood", "rubber-wood"
local pulp, r_pulp              = "bi-woodpulp", "wood-chips"

local old_tab, new_tab
local old_key, new_key

local item, amount, loc_name, changed

local replace_map = {
  --~ [seed]    = r_seed,
  --~ [seedling]        = r_seedling,
  [logs]        = r_logs,

  [wood]        = r_wood,
  [pulp]        = r_pulp,
}

local create = {}

local function get_key_names(name, i)
  local old = string.format("%s_%s", name, i)
  local new = old:gsub("^", rubber .. "_")
BioInd.debugging.show("old", old)
BioInd.debugging.show("new", new)
  return old, new
end


local function replace_string(old, pattern, new)
  return old:gsub(pattern:gsub("%-", "%%-"), new)
end

------------------------------------------------------------------------------------
--                             Initialize new recipes                             --
------------------------------------------------------------------------------------

old_tab                         = BI.default_recipes
new_tab                         = BI.additional_recipes.mod_compatibility

for i = 1, 4 do

  -- BI.default_recipes.seed_x
  --~ old_key, new_key = get_key_names("seed", i)
  --~ new_tab[new_key] = table.deepcopy(old_tab[old_key])
  --~ new_tab[new_key].name = string.format("%s-%s", r_seed, i)
  --~ new_tab[new_key].localised_name[1] = replace_string(new_tab[new_key].localised_name[1], seed, r_seed)
  --~ if new_tab[new_key].localised_description then
    --~ new_tab[new_key].localised_description[1] =
      --~ replace_string(new_tab[new_key].localised_description[1], seed, r_seed)
  --~ end
  --~ create[new_key] = new_tab[new_key]
  --~ BioInd.debugging.modified_msg("", new_tab[new_key], "Initialized")

  -- BI.default_recipes.seedling_x
  --~ old_key, new_key = get_key_names("seedling", i)
  --~ new_tab[new_key] = table.deepcopy(old_tab[old_key])
  --~ new_tab[new_key].name = string.format("%s-%s", r_seedling, i)
  --~ new_tab[new_key].localised_name[1] = replace_string(new_tab[new_key].localised_name[1],
                                                      --~ seedling, r_seedling)
  --~ if new_tab[new_key].localised_description then
    --~ new_tab[new_key].localised_description[1] =
      --~ replace_string(new_tab[new_key].localised_description[1], seedling, r_seedling)
  --~ end
  --~ create[new_key] = new_tab[new_key]
  --~ BioInd.debugging.modified_msg("", new_tab[new_key], "Initialized")

  --~ BI.default_recipes.logs_x
  old_key, new_key = get_key_names("logs", i)
  new_tab[new_key] = table.deepcopy(old_tab[old_key])
BioInd.debugging.show("new_tab["..new_key.."]", new_tab[new_key])
  new_tab[new_key].name = string.format("%s-%s", r_logs, i)
  new_tab[new_key].localised_name[1] = replace_string(new_tab[new_key].localised_name[1], logs, r_logs)
  table.remove(new_tab[new_key].localised_name, 2)
BioInd.debugging.show("new_tab["..new_key.."] after changing name + locale", new_tab[new_key])
  if new_tab[new_key].localised_description then
    new_tab[new_key].localised_description[1] =
      replace_string(new_tab[new_key].localised_description[1], logs, r_logs)
  end
  -- Really! Somebody must have created Rubber trees by putting rubber into trees! :-D
  table.insert(new_tab[new_key].ingredients, {
    type = "item",
    name = "rubber",
    amount = 20
  })
  create[new_key] = new_tab[new_key]
  BioInd.debugging.modified_msg("", new_tab[new_key], "Initialized")
end
--~ error("Break!")


------------------------------------------------------------------------------------
--                               Adjust new recipes                               --
------------------------------------------------------------------------------------
for name, recipe in pairs(create) do

  -- Change order
  recipe.order = string.format("%s-[%s]", recipe.order, rubber)
  BioInd.debugging.modified_msg("order", recipe)

  -- Remove flag for "Krastorio"
  recipe.mod = nil
  BioInd.debugging.modified_msg("flag for \"Krastorio\"", recipe, "Removed")

  -- Replace items in ingredients
  changed = false
  for i, ingredient in pairs(recipe.ingredients) do
    item = ingredient.name or ingredient[1]
    amount = ingredient.amount or ingredient[2]

    if replace_map[item] then
      recipe.ingredients[i] = {type = "item", name = replace_map[item], amount = amount}
      changed = true
    end
  end
  if changed then
    BioInd.debugging.modified_msg("ingredients", recipe)
  end

  -- Replace items in results
  for r, result in pairs(recipe.results) do
    item = result.name or result[1]
    amount = result.amount or result[2]

    if replace_map[item] then
      recipe.results[r] = {type = "item", name = replace_map[item], amount = amount * 0.75}
      changed = true
    end
  end
  if changed then
    BioInd.debugging.modified_msg("results", recipe)
  end

end

BioInd.create_stuff(create)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
