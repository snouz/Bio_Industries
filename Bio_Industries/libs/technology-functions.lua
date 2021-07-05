--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])

if not thxbob.lib.tech then thxbob.lib.tech = {} end

-- Added by Pi-C
local difficulty_properties = {
  effects = true,
  enabled = true,
  hidden = true,
  max_level = true,
  prerequisites = true,
  unit = true,
  upgrade = true,
  visible_when_disabled = true,
}


-- Added by Pi-C
function thxbob.lib.tech.sort_difficulty_unlocks(technology, difficulty)
BioInd.entered_function()
--~ BioInd.writeDebug("Technology: %s\tDifficulty: %s", {technology, difficulty})
  if difficulty ~= "normal" and difficulty ~= "expensive" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local effects, recipe
  local unlock_recipes = {}
  local unlock_other = {}
  local tech = data.raw.technology[technology]

  if tech then
    if difficulty == "" then
      effects = tech.effects
    else
      if not tech[difficulty] then
        thxbob.lib.tech.add_difficulty(technology, difficulty)
      end
      effects = tech[difficulty].effects
    end

    for e, effect in ipairs(effects or {}) do
      if effect.type == "unlock-recipe" then
        recipe = data.raw.recipe[effect.recipe]
        if recipe then
          unlock_recipes[#unlock_recipes + 1] = {
            type = effect.type,
            recipe = recipe.name,
            order = recipe.order or ""
          }
        end
      else
        unlock_other[#unlock_other + 1] = effect
      end
    end
BioInd.show("Unsorted recipe unlocks", unlock_recipes)
    table.sort(unlock_recipes, function(a,b) return a.order < b.order end)
BioInd.show("Sorted recipe unlocks", unlock_recipes)
    effects = table.deepcopy(unlock_recipes)
    for u, unlock in ipairs(unlock_other) do
      effects[#effects] = unlock
    end
BioInd.show("Final unlocks of " .. tech.name, tech)

  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty(technology, difficulty)
--~ BioInd.entered_function()
--~ BioInd.writeDebug("Technology: %s\tDifficulty: %s", {technology, difficulty})
  if difficulty ~= "normal" and difficulty ~= "expensive" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local tech = data.raw.technology[technology]
  if tech then
    if not tech[difficulty] then
--~ BioInd.writeDebug("Must create difficulty: %s", {difficulty})
      tech[difficulty] = {}
      for property, p in pairs(difficulty_properties) do
--~ BioInd.show("Property", property)
--~ BioInd.show("tech["..difficulty.."]["..property.."]", tech[difficulty][property])

--~ BioInd.show("tech["..property.."]", tech[property])
--~ BioInd.show("tech[normal]["..property.."]", tech.normal[property])
--~ BioInd.show("tech[expensive]["..property.."]", tech.expensive and tech.expensive[property] or "nil")

        --~ tech[difficulty][property] =
                  --~ table.deepcopy(tech[property]) or
                  --~ difficulty == "normal" and table.deepcopy(tech["expensive"][property]) or
                  --~ difficulty == "expensive" and table.deepcopy(tech["normal"][property])
        tech[difficulty][property] = table.deepcopy(tech[property])
--~ BioInd.writeDebug("data.raw.technology[%s][%s][%s] after change: %s", {technology, difficulty, property, data.raw.technology[technology][difficulty][property] or "nil"})

      end
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.make_difficulties(technology)
--~ BioInd.entered_function()
  local tech = data.raw.technology[technology]
  if tech then
    thxbob.lib.tech.add_difficulty(technology, "normal")
    thxbob.lib.tech.add_difficulty(technology, "expensive")
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty(technology, difficulty)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local tech = data.raw.technology[technology]
  if tech then
    -- If both technology.normal and technology.expensive exist, we can
    -- safely remove one difficulty.
    if tech.normal and tech.expensive then
      tech[difficulty] = nil

    -- If only one of technology.normal and technology.expensive exist, we
    -- must copy all of its properties to technology before removing the
    -- difficulty.
    elseif (tech.normal and difficulty == "normal") or
            (tech.expensive and difficulty == "expensive") then
      for property, p in pairs(difficulty_properties) do
        tech[property] = tech[property] or table.deepcopy(tech[difficulty][property])
      end
      tech[difficulty] = nil
    end
  end
--~ BioInd.entered_function("leave")
end

-- Added by Pi-C
function thxbob.lib.tech.replace_difficulty_unit(technology, difficulty, unit)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end
  if not type(unit) == "table" then
    error(string.format("%s is not a valid unit table!", unit))
  end

  local tech = data.raw.technology[technology]
  if tech then
    if difficulty == "" then
      tech.unit = table.deepcopy(unit)
    else
      -- Make sure the difficulty exists!
      if not tech[difficulty] then
        thxbob.lib.tech.add_difficulty(technology, difficulty)
      end
      tech[difficulty].unit = table.deepcopy(unit)
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.replace_unit(technology, unit)
--~ BioInd.entered_function()
  if type(unit) ~= "table" or
      not (unit.count or unit.count_formula or unit.time or unit.ingredients) then
    error(string.format("%s is not valid unit data!", unit))
  end
--~ BioInd.show("technology", technology)
--~ BioInd.show("unit", unit)
local tech = type(technology) == "string" and technology or
              type(technology) == "table" and technology.type == "technology" and technology.name
--~ BioInd.show("tech", tech)

  if data.raw.technology[technology] then
    thxbob.lib.tech.replace_difficulty_unit(technology, "", unit)
    thxbob.lib.tech.replace_difficulty_unit(technology, "normal", unit)
    thxbob.lib.tech.replace_difficulty_unit(technology, "expensive", unit)
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.replace_difficulty_science_pack(technology, difficulty, old, new)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  if not type(old) == "string" then
    error(string.format("%s is not a valid science pack name!", old))
  end

  new = type(new) == "string" and {name = new} or
        type(new) == "table" and {name = new[1] or new.name, amount = new[2] or new.amount} or
        error(string.format("%s is not a valid ingredient!", new))

  local ingredients, doit, amount
  local tech = data.raw.technology[technology]

  if tech then
    if difficulty ~= "" and not tech[difficulty] then
      thxbob.lib.tech.add_difficulty(technology, difficulty)
    end

    if difficulty == "" then
      ingredients = tech.unit and tech.unit.ingredients
    else
      ingredients = tech[difficulty].unit and tech[difficulty].unit.ingredients
    end

    if ingredients then
      amount = 0
      for i, ingredient in ipairs(ingredients) do
        if ingredient[1] == old or ingredient.name == old then
          --~ doit = true
          amount = (ingredient[2] or ingredient.amount) + amount
        end
      end
      if amount > 0 then
        thxbob.lib.tech.remove_science_pack(technology, new.name)
        thxbob.lib.tech.add_science_pack(technology, new.name, new.amount or amount)
      end
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.replace_science_pack(technology, old, new)
  if data.raw.technology[technology] and data.raw.tool[new] then
    thxbob.lib.tech.replace_difficulty_science_pack(technology, "", old, new)
    thxbob.lib.tech.replace_difficulty_science_pack(technology, "normal", old, new)
    thxbob.lib.tech.replace_difficulty_science_pack(technology, "expensive", old, new)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.tool[new] then
      BioInd.writeDebug("Science pack %s does not exist.", {new})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_new_difficulty_science_pack(technology, difficulty, pack, amount)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  if not (type(pack) == "string" and data.raw.tool[pack]) then
    error(string.format("%s is not a valid science pack name!", pack))
  end

  amount = (type(amount) == "number") and amount or
            not amount and 1 or
            error(string.format("%s is not a valid amount!", amount))

  local ingredients, doit
  local tech = data.raw.technology[technology]

  if tech then
    if difficulty ~= "" and not tech[difficulty] then
      thxbob.lib.tech.add_difficulty(technology, difficulty)
    end

    if difficulty == "" then
      tech.unit = tech.unit or {}
      ingredients = tech.unit.ingredients or {}
    else
      tech[difficulty].unit = tech[difficulty].unit or {}
      ingredients = tech[difficulty].unit.ingredients or {}
    end

    doit = true
    for i, ingredient in ipairs(ingredients) do
      if ingredient[1] == pack or ingredient.name == pack then
        doit = false
        break
      end
    end

    if doit then
      if difficulty == "" then
        table.insert(tech.unit.ingredients, {pack, amount})
      else
        table.insert(tech[difficulty].unit.ingredients, {pack, amount})
      end
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_new_science_pack(technology, pack, amount)
--~ BioInd.entered_function()
  if data.raw.technology[technology] and data.raw.tool[pack] then
    thxbob.lib.tech.add_new_difficulty_science_pack(technology, "", pack, amount)
    thxbob.lib.tech.add_new_difficulty_science_pack(technology, "normal", pack, amount)
    thxbob.lib.tech.add_new_difficulty_science_pack(technology, "expensive", pack, amount)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.tool[new] then
      BioInd.writeDebug("Science pack %s does not exist.", {new})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty_science_pack(technology, difficulty, pack, amount)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  if not (type(pack) == "string" and data.raw.tool[pack]) then
    error(string.format("%s is not a valid science pack name!", pack))
  end

  amount = (type(amount) == "number") and amount or
            not amount and 1 or
            error(string.format("%s is not a valid amount!", amount))

  local ingredients, cnt
  local tech = data.raw.technology[technology]

  if tech then
    if difficulty ~= "" and not tech[difficulty] then
      thxbob.lib.tech.add_difficulty(technology, difficulty)
    end

    if difficulty == "" then
      tech.unit = tech.unit or {}
      ingredients = tech.unit.ingredients or {}
    else
      tech[difficulty].unit = tech[difficulty].unit or {}
      ingredients = tech[difficulty].unit.ingredients or {}
    end

    cnt = 0
    for i, ingredient in ipairs(ingredients) do
      -- Accumulate amount in case the same pack is in use multiple times,
      if ingredient[1] == pack or ingredient.name == pack then
        cnt = (ingredient[2] or ingredient.amount) + cnt
      end
    end
    -- In case we've found the same pack one or more times remove it
    if cnt > 0 then
      thxbob.lib.tech.remove_difficulty_science_pack(technology, difficulty, pack)
    end

    amount = amount + cnt
    if difficulty == "" then
      table.insert(tech.unit.ingredients, {pack, amount})
    else
      table.insert(tech[difficulty].unit.ingredients, {pack, amount})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_science_pack(technology, pack, amount)
--~ BioInd.entered_function()
  if data.raw.technology[technology] and data.raw.tool[pack] then
    --~ local addit = true
    --~ for i, ingredient in pairs(data.raw.technology[technology].unit.ingredients) do
      --~ if ingredient[1] == pack then
        --~ addit = false
        --~ ingredient[2] = ingredient[2] + amount
      --~ end
      --~ if ingredient.name == pack then
        --~ addit = false
        --~ ingredient.amount = ingredient.amount + amount
      --~ end
    --~ end
    --~ if addit then
      --~ table.insert(data.raw.technology[technology].unit.ingredients, {pack, amount})
    --~ end
    thxbob.lib.tech.add_difficulty_science_pack(technology, "", pack, amount)
    thxbob.lib.tech.add_difficulty_science_pack(technology, "normal", pack, amount)
    thxbob.lib.tech.add_difficulty_science_pack(technology, "expensive", pack, amount)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology " .. tostring(technology) .. " does not exist.")
    end
    if not data.raw.tool[pack] then
      BioInd.writeDebug("Science pack %s does not exist.", {pack})
    end
  end
--~ BioInd.entered_function("leave")
end



-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_science_pack(technology, difficulty, pack)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  if not (type(pack) == "string" and data.raw.tool[pack]) then
    error(string.format("%s is not a valid science pack name!", pack))
  end

  local tech = data.raw.technology[technology]

  if tech then
    if difficulty == "" then
      --~ tech.unit = tech.unit or {}
      ingredients = tech.unit and tech.unit.ingredients
    else
      --~ tech[difficulty].unit = tech[difficulty].unit or {}
      ingredients = tech[difficulty] and tech[difficulty].unit and tech[difficulty].ingredients
    end

    if ingredients then
      local ingredient
      for i = #ingredients, 1, -1 do
        ingredient = ingredients[i]
        if ingredient[1] == pack or ingredient.name == pack then
          table.remove(ingredients, i)
        end
      end
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.remove_science_pack(technology, pack)
--~ BioInd.entered_function()
  if data.raw.technology[technology] and data.raw.tool[pack] then
    thxbob.lib.tech.remove_difficulty_science_pack(technology, "", pack)
    thxbob.lib.tech.remove_difficulty_science_pack(technology, "normal", pack)
    thxbob.lib.tech.remove_difficulty_science_pack(technology, "expensive", pack)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology " .. tostring(technology) .. " does not exist.")
    end
    if not data.raw.tool[pack] then
      BioInd.writeDebug("Science pack %s does not exist.", {pack})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty_recipe_unlock(technology, difficulty, recipe)
--~ BioInd.entered_function()
--~ BioInd.writeDebug("Technology: %s\tDifficulty: %s\tRecipe: %s", {technology, difficulty, recipe})
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  if recipe and type(recipe) ~= "string" then
    error(string.format("%s is not a valid recipe name!", recipe))
  end
--~ BioInd.writeDebug("Passed argument check")

  local tech = data.raw.technology[technology]
  local effects

  if tech and recipe then
--~ BioInd.writeDebug("Tech and recipe exist")
    if difficulty == "" then
      tech.effects = tech.effects or {}
      effects = tech.effects
--~ BioInd.writeDebug("Effects (no difficulty): %s", {effects or "nil"}, "line")
    else
      if not tech[difficulty] then
        thxbob.lib.tech.add_difficulty(technology, difficulty)
BioInd.writeDebug("Created difficulty): %s", {difficulty})
      end
      tech[difficulty].effects = tech[difficulty].effects or {}
      effects = tech[difficulty].effects
--~ BioInd.writeDebug("Effects (%s): %s", {difficulty, effects or "nil"}, "line")
    end

    local addit = true
    for e, effect in pairs(effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe then
        addit = false
      end
    end
    if addit then
      table.insert(effects, {type = "unlock-recipe", recipe = recipe})
      table.sort(effects, function(a, b) return a.order and b.order and a.order < b.order end)
    end
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.recipe[recipe] then
      BioInd.writeDebug("Recipe %s does not exist.", {recipe})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_recipe_unlock(technology, recipe)
  if data.raw.technology[technology] and data.raw.recipe[recipe] then
    thxbob.lib.tech.add_difficulty_recipe_unlock(technology, "", recipe)
    thxbob.lib.tech.add_difficulty_recipe_unlock(technology, "normal", recipe)
    thxbob.lib.tech.add_difficulty_recipe_unlock(technology, "expensive", recipe)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.recipe[recipe] then
      BioInd.writeDebug("Recipe %s does not exist.", {recipe})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_recipe_unlock(technology, difficulty, recipe)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  if recipe and type(recipe) ~= "string" then
    error(string.format("%s is not a valid recipe name!", recipe))
  end

  local tech = data.raw.technology[technology]
  local effects, effect

  if tech and data.raw.recipe[recipe] then
    if difficulty == "" then
      effects = tech.effects
    else
      effects = tech[difficulty] and tech[difficulty].effects
    end

    if effects then
      for e = #effects, 1, -1 do
        effect = effects[e]
        if effect.type == "unlock-recipe" and effect.recipe == recipe then
          table.remove(effects, e)
        end
      end
    end
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.recipe[recipe] then
      BioInd.writeDebug("Recipe %s does not exist.", {recipe})
    end
  end
--~ BioInd.entered_function("leave")
end



-- Modified by Pi-C
function thxbob.lib.tech.remove_recipe_unlock(technology, recipe)
--~ BioInd.entered_function()
  if data.raw.technology[technology] and data.raw.recipe[recipe] then
    thxbob.lib.tech.remove_difficulty_recipe_unlock(technology, "", recipe)
    thxbob.lib.tech.remove_difficulty_recipe_unlock(technology, "normal", recipe)
    thxbob.lib.tech.remove_difficulty_recipe_unlock(technology, "expensive", recipe)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.recipe[recipe] then
      BioInd.writeDebug("Recipe %s does not exist.", {recipe})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.replace_difficulty_prerequisite(technology, difficulty, old, new)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  if type(old) ~= "string" then
    error(string.format("%s is not a valid recipe name!", old))
  end

  if type(new) ~= "string" then
    error(string.format("%s is not a valid recipe name!", new))
  end

  local tech = data.raw.technology[technology]
  local prerequisites, doit

  if tech and data.raw.technology[new] then
    if difficulty == "" then
      tech.prerequisites = tech.prerequisites or {}
      prerequisites = tech.prerequisites
    else
      if not tech[difficulty] then
        thxbob.lib.tech.add_difficulty(technology, difficulty)
      end
      tech[difficulty].prerequisites = tech[difficulty].prerequisites or {}
      prerequisites = tech[difficulty].prerequisites
    end

    if prerequisites then
      for p, prerequisite in ipairs(prerequisites) do
        if prerequisite == old then
          doit = true
          break
        end
      end
      if doit then
        thxbob.lib.tech.remove_difficulty_prerequisite(technology, difficulty, old)
        thxbob.lib.tech.add_difficulty_prerequisite(technology, difficulty, new)
      end
    end
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.technology[new] then
      BioInd.writeDebug("Prerequisite technology %s does not exist.", {new})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.replace_prerequisite(technology, old, new)
--~ BioInd.entered_function()
  if data.raw.technology[technology] and data.raw.technology[new] then
    thxbob.lib.tech.replace_difficulty_prerequisite(technology, "", old, new)
    thxbob.lib.tech.replace_difficulty_prerequisite(technology, "normal", old, new)
    thxbob.lib.tech.replace_difficulty_prerequisite(technology, "expensive", old, new)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.technology[new] then
      BioInd.writeDebug("Prerequisite technology %s does not exist.", {new})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty_prerequisite(technology, difficulty, prerequisite)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local tech = data.raw.technology[technology]
  local prerequisites, addit

  if tech and data.raw.technology[prerequisite] then
    if difficulty == "" then
      tech.prerequisites = tech.prerequisites or {}
      prerequisites = tech.prerequisites
    else
      if not tech[difficulty] then
        thxbob.lib.tech.add_difficulty(technology, difficulty)
      end
      tech[difficulty].prerequisites = tech[difficulty].prerequisites or {}
      prerequisites = tech[difficulty].prerequisites
    end

    addit = true
    if prerequisites then
      for o, old in ipairs(prerequisites) do
        if prerequisite == old then
          addit = false
          break
        end
      end
    end

    if addit then
      table.insert(prerequisites, prerequisite)
    end
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.technology[prerequisite] then
      BioInd.writeDebug("Prerequisite technology %s does not exist.", {prerequisite})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_prerequisite(technology, prerequisite)
--~ BioInd.entered_function()
  if data.raw.technology[technology] and data.raw.technology[prerequisite] then
    thxbob.lib.tech.add_difficulty_prerequisite(technology, "", prerequisite)
    thxbob.lib.tech.add_difficulty_prerequisite(technology, "normal", prerequisite)
    thxbob.lib.tech.add_difficulty_prerequisite(technology, "expensive", prerequisite)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.technology[prerequisite] then
      BioInd.writeDebug("Prerequisite technology %s does not exist.", {prerequisite})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_prerequisite(technology, difficulty, prerequisite)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local tech = data.raw.technology[technology]
  local prerequisites, doit

  if tech and data.raw.technology[prerequisite] then
    if difficulty == "" then
      prerequisites = tech.prerequisites
    else
      prerequisites = tech[difficulty] and tech[difficulty].prerequisites
    end

    if prerequisites then
      for o = #prerequisites, 1, -1 do
        if prerequisites[o] == prerequisite then
          table.remove(prerequisites, o)
        end
      end
    end

  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.technology[prerequisite] then
      BioInd.writeDebug("Prerequisite technology %s does not exist.", {prerequisite})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.remove_prerequisite(technology, prerequisite)
--~ BioInd.entered_function()
  if data.raw.technology[technology] and data.raw.technology[prerequisite] then
    thxbob.lib.tech.remove_difficulty_prerequisite(technology, "", prerequisite)
    thxbob.lib.tech.remove_difficulty_prerequisite(technology, "normal", prerequisite)
    thxbob.lib.tech.remove_difficulty_prerequisite(technology, "expensive", prerequisite)
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
    if not data.raw.technology[prerequisite] then
      BioInd.writeDebug("Prerequisite technology %s does not exist.", {prerequisite})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(technology, difficulty)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local tech = data.raw.technology[technology]
  local prerequisites, prerequisite

  if tech then
    if difficulty == "" then
      prerequisites = tech.prerequisites
    else
      prerequisites = tech[difficulty] and tech[difficulty].prerequisites
    end

    if prerequisites then
      for p = #prerequisites, 1, -1 do
        prerequisite = prerequisites[p]
        if not data.raw.technology[prerequisite] then
          table.remove(prerequisites, p)
          BioInd.writeDebug("Removed prerequisite tech %s from prerequisites of %s (%s).", {
            prerequisite, tech.name, difficulty ~= "" and difficulty or "no difficulty"})
        end
      end
    end
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
-- This will remove NON-EXISTING techs from the prerequisites of other mods. Not to
-- be confused with redundant prerequisites that exist but are already required via
-- other techs!
function thxbob.lib.tech.remove_obsolete_prerequisites(technology)
--~ BioInd.entered_function()
  local tech
  if type(technology) == "string" and data.raw.technology[technology] then
    tech = technology
  elseif type(technology) == "table" and technology.type == "technology" then
    tech = technology.name
  end

  if tech then
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "")
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "normal")
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "expensive")
  else
    BioInd.writeDebug("Technology %s does not exist.", {technology})
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(technology, difficulty)
--~ BioInd.entered_function()
  if difficulty ~= "normal" and difficulty ~= "expensive" and difficulty ~= "" then
    error(string.format("%s is not a valid difficulty!", difficulty))
  end

  local tech = data.raw.technology[technology]
  local prerequisites, prerequisite

  if tech then
    if difficulty == "" then
      prerequisites = tech.prerequisites
    else
      prerequisites = tech[difficulty] and tech[difficulty].prerequisites
    end

    if prerequisites then
      for p = #prerequisites, 1, -1 do
        prerequisite = prerequisites[p]
        if not data.raw.technology[prerequisite] then
          table.remove(prerequisites, p)
          BioInd.writeDebug("Removed prerequisite tech %s from prerequisites of %s (%s).", {
            prerequisite, tech.name, difficulty ~= "" and difficulty or "no difficulty"})
        end
      end
    end
  else
    if not data.raw.technology[technology] then
      BioInd.writeDebug("Technology %s does not exist.", {technology})
    end
  end
--~ BioInd.entered_function("leave")
end


-- Added by Pi-C
-- This will remove NON-EXISTING techs from the prerequisites of other mods. Not to
-- be confused with redundant prerequisites that exist but are already required via
-- other techs!
function thxbob.lib.tech.remove_obsolete_prerequisites(technology)
--~ BioInd.entered_function()
  local tech
  if type(technology) == "string" and data.raw.technology[technology] then
    tech = technology
  elseif type(technology) == "table" and technology.type == "technology" then
    tech = technology.name
  end

  if tech then
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "")
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "normal")
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "expensive")
  else
    BioInd.writeDebug("Technology %s does not exist.", {technology})
  end
--~ BioInd.entered_function("leave")
end
