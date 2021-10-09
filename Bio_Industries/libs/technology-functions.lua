if not thxbob.lib.tech then thxbob.lib.tech = {} end

-- Added by Pi-C
-- Make sure we have a technology
local function get_technology(tech)
  return (type(tech) == "string" and data.raw.technology[tech]) or
          -- tech may be a template, so we better get the real tech from data.raw!
          (type(tech) == "table" and
            tech.type == "technology" and
            tech.name and data.raw.technology[tech.name])
end

-- Added by Pi-C
-- Make sure we have a technology name
local function get_technology_name(tech)
  return (type(tech) == "string" and tech) or
          (type(tech) == "table" and tech.type == "technology" and tech.name)
end

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
BioInd.debugging.entered_function({technology, difficulty})
--~ BioInd.debugging.writeDebug("Technology: %s\tDifficulty: %s", {technology, difficulty})
  BI_Functions.lib.check_difficulty(difficulty)

  local effects, recipe
  local unlock_recipes = {}
  local unlock_other = {}
  local tech = get_technology(technology)

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
    table.sort(unlock_recipes, function(a,b) return a.order < b.order end)
    effects = table.deepcopy(unlock_recipes)
    for u, unlock in ipairs(unlock_other) do
      effects[#effects] = unlock
    end

  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty(technology, difficulty)
--~ BioInd.debugging.entered_function({technology, difficulty})
  BI_Functions.lib.check_difficulty(difficulty)

  local tech = get_technology(technology)
  if tech then
    if not tech[difficulty] then
      tech[difficulty] = {}
      for property, p in pairs(difficulty_properties) do
        tech[difficulty][property] = table.deepcopy(tech[property])
      end
    end
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.make_difficulties(technology)
--~ BioInd.debugging.entered_function({technology})

  local tech = get_technology(technology)

  if tech then
    thxbob.lib.tech.add_difficulty(tech, "normal")
    thxbob.lib.tech.add_difficulty(tech, "expensive")
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty(technology, difficulty)
--~ BioInd.debugging.entered_function({technology, difficulty})

  BI_Functions.lib.check_difficulty(difficulty)

  local tech = get_technology(technology)

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
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.replace_difficulty_unit(technology, difficulty, unit)
--~ BioInd.debugging.entered_function({technology, difficulty, unit})

  BI_Functions.lib.check_difficulty(difficulty)
  if type(unit) ~= "table" or
      not (unit.count or unit.count_formula or unit.time or unit.ingredients) then
    error(string.format("%s is not valid unit data!", unit))
  end

  local tech = get_technology(technology)
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
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.replace_unit(technology, unit)
--~ BioInd.debugging.entered_function({technology, unit})
  if technology and unit then
    thxbob.lib.tech.replace_difficulty_unit(technology, "", unit)
    thxbob.lib.tech.replace_difficulty_unit(technology, "normal", unit)
    thxbob.lib.tech.replace_difficulty_unit(technology, "expensive", unit)
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.replace_difficulty_science_pack(technology, difficulty, old, new)
--~ BioInd.debugging.entered_function({technology, difficulty, old, new})

  BI_Functions.lib.check_difficulty(difficulty)

  if not type(old) == "string" then
    error(string.format("%s is not a valid science pack name!", old))
  end

  new = (type(new) == "string" and {name = new}) or
        (type(new) == "table" and ((new[1] or new.name) and (new[2] or new.amount)) and
          {name = new[1] or new.name, amount = new[2] or new.amount}) or
        error(string.format("%s is not a valid ingredient!", new))

  local ingredients, doit, amount
  local tech = get_technology(technology)

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
          amount = (ingredient[2] or ingredient.amount) + amount
        end
      end
      if amount > 0 then
        thxbob.lib.tech.remove_science_pack(technology, new.name)
        thxbob.lib.tech.add_science_pack(technology, new.name, new.amount or amount)
      end
    end
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.replace_science_pack(technology, old, new)
--~ BioInd.debugging.entered_function({technology, old, new})
  local tech = get_technology(technology)

  if tech and type(old) == "string" and new and data.raw.tool[new] then
    thxbob.lib.tech.replace_difficulty_science_pack(tech, "", old, new)
    thxbob.lib.tech.replace_difficulty_science_pack(tech, "normal", old, new)
    thxbob.lib.tech.replace_difficulty_science_pack(tech, "expensive", old, new)
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if type(old) ~= "string" then
      BioInd.debugging.writeDebug("\"%s\" is not a valid name!", {old or "nil"})
    end
    if not (new and data.raw.tool[new]) then
      BioInd.debugging.writeDebug("Science pack \"%s\" does not exist.", {new or "nil"})
    end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_new_difficulty_science_pack(technology, difficulty, pack, amount)
--~ BioInd.debugging.entered_function({technology, difficulty, pack, amount})
  BI_Functions.lib.check_difficulty(difficulty)

  if not (type(pack) == "string" and data.raw.tool[pack]) then
    BioInd.debugging.arg_err(pack, "science pack name")
  end

  amount = (type(amount) == "number" and amount) or
            (amount == nil and 1) or
            BioInd.debugging.arg_err(amount, "amount")

  local ingredients, doit
  local tech = get_technology(technology)

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
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_new_science_pack(technology, pack, amount)
--~ BioInd.debugging.entered_function({technology, pack, amount})
  local tech = get_technology(technology)

  if tech and pack and data.raw.tool[pack] then
    thxbob.lib.tech.add_new_difficulty_science_pack(tech, "", pack, amount)
    thxbob.lib.tech.add_new_difficulty_science_pack(tech, "normal", pack, amount)
    thxbob.lib.tech.add_new_difficulty_science_pack(tech, "expensive", pack, amount)
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not (pack and data.raw.tool[pack]) then
      BioInd.debugging.writeDebug("Science pack %s does not exist.", {pack})
    end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty_science_pack(technology, difficulty, pack, amount)
--~ BioInd.debugging.entered_function({technology, difficulty, pack, amount})
  BI_Functions.lib.check_difficulty(difficulty)

  if not (pack and data.raw.tool[pack]) then
    BioInd.debugging.arg_err(pack, "science pack name")
  end

  amount = (type(amount) == "number" and amount) or
            (not amount and 1) or
            BioInd.debugging.arg_err(amount, "amount")

  local ingredients, cnt
  local tech = get_technology(technology)

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
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_science_pack(technology, pack, amount)
--~ BioInd.debugging.entered_function({technology, pack, amount})

  local tech = get_technology(technology)
  if tech and pack and data.raw.tool[pack] then
    thxbob.lib.tech.add_difficulty_science_pack(tech, "", pack, amount)
    thxbob.lib.tech.add_difficulty_science_pack(tech, "normal", pack, amount)
    thxbob.lib.tech.add_difficulty_science_pack(tech, "expensive", pack, amount)
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not (pack and data.raw.tool[pack]) then
      BioInd.debugging.writeDebug("Science pack \"%s\" does not exist.", {pack or "nil"})
    end
  end
--~ BioInd.debugging.entered_function("leave")
end



-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_science_pack(technology, difficulty, pack)
--~ BioInd.debugging.entered_function({technology, difficulty, pack})
  BI_Functions.lib.check_difficulty(difficulty)

  --~ if not (type(pack) == "string" and data.raw.tool[pack]) then
  if not (pack and data.raw.tool[pack]) then
    BioInd.debugging.arg_err(pack, "science pack name")
  end

  local tech = get_technology(technology)

  if tech then
    if difficulty == "" then
      --~ tech.unit = tech.unit or {}
      ingredients = tech.unit and tech.unit.ingredients
    else
      --~ tech[difficulty].unit = tech[difficulty].unit or {}
      ingredients = tech[difficulty] and tech[difficulty].unit and tech[difficulty].unit.ingredients
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
  else
    BioInd.debugging.writeDebug("\"%s\" is not a valid technology!", {technology})
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.remove_science_pack(technology, pack)
--~ BioInd.debugging.entered_function({technology, pack})
  local tech = get_technology(technology)

  if tech and pack and data.raw.tool[pack] then
    thxbob.lib.tech.remove_difficulty_science_pack(tech, "", pack)
    thxbob.lib.tech.remove_difficulty_science_pack(tech, "normal", pack)
    thxbob.lib.tech.remove_difficulty_science_pack(tech, "expensive", pack)
  else
    if not tech then
      --~ BioInd.debugging.writeDebug("Technology " .. get_technology_name(tech) .. " does not exist.")
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not (pack and data.raw.tool[pack]) then
      BioInd.debugging.writeDebug("Science pack %s does not exist.", {pack or "nil"})
    end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty_recipe_unlock(technology, difficulty, recipe)
--~ BioInd.debugging.entered_function({technology, difficulty, recipe})

  BI_Functions.lib.check_difficulty(difficulty)

  if type(recipe) ~= "string" then
    BioInd.debugging.arg_err(recipe, "recipe name")
  end

  local tech = get_technology(technology)
  local effects

  if tech then
    if difficulty == "" then
      tech.effects = tech.effects or {}
      effects = tech.effects
    else
      if not tech[difficulty] then
        thxbob.lib.tech.add_difficulty(technology, difficulty)
      end
      tech[difficulty].effects = tech[difficulty].effects or {}
      effects = tech[difficulty].effects
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
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    --~ if not data.raw.recipe[recipe] then
      --~ BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe})
    --~ end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_recipe_unlock(technology, recipe)
--~ BioInd.debugging.entered_function({technology, recipe})

  local tech = get_technology(technology)

  if tech and recipe and data.raw.recipe[recipe] then
    thxbob.lib.tech.add_difficulty_recipe_unlock(tech, "", recipe)
    thxbob.lib.tech.add_difficulty_recipe_unlock(tech, "normal", recipe)
    thxbob.lib.tech.add_difficulty_recipe_unlock(tech, "expensive", recipe)
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not (recipe and data.raw.recipe[recipe]) then
      BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe or "nil"})
    end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_recipe_unlock(technology, difficulty, recipe)
--~ BioInd.debugging.entered_function({technology, difficulty, recipe})
  BI_Functions.lib.check_difficulty(difficulty)

  if type(recipe) ~= "string" then
    BioInd.debugging.arg_err(recipe, "recipe name")
  end

  local tech = get_technology(technology)
  local effects, effect

  --~ if tech and data.raw.recipe[recipe] then
  if tech then
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
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    --~ if not data.raw.recipe[recipe] then
      --~ BioInd.debugging.writeDebug("Recipe %s does not exist.", {recipe})
    --~ end
  end
--~ BioInd.debugging.entered_function("leave")
end



-- Modified by Pi-C
function thxbob.lib.tech.remove_recipe_unlock(technology, recipe)
--~ BioInd.debugging.entered_function({technology, recipe})

  local tech = get_technology(technology)

  --~ if tech and recipe and data.raw.recipe[recipe] then
  if tech and recipe then
    thxbob.lib.tech.remove_difficulty_recipe_unlock(tech, "", recipe)
    thxbob.lib.tech.remove_difficulty_recipe_unlock(tech, "normal", recipe)
    thxbob.lib.tech.remove_difficulty_recipe_unlock(tech, "expensive", recipe)
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    --~ if not (recipe and data.raw.recipe[recipe]) then
    if not recipe then
      BioInd.debugging.writeDebug("Missing recipe!")
    end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.replace_difficulty_prerequisite(technology, difficulty, old, new)
BioInd.debugging.entered_function({technology, difficulty, old, new})
 BI_Functions.lib.check_difficulty(difficulty)

  old_name = get_technology_name(old)
  new_name = get_technology_name(new)

  local tech = get_technology(technology)
  local prerequisites, doit

  if tech and old_name and new_name then
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
        if prerequisite == old_name then
          doit = true
          break
        end
      end
      if doit then
        thxbob.lib.tech.remove_difficulty_prerequisite(technology, difficulty, old_name)
        thxbob.lib.tech.add_difficulty_prerequisite(technology, difficulty, new_name)
      end
    end
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not old_name then
      BioInd.debugging.writeDebug("Prerequisite technology %s does not exist.",
                                  {get_technology_name(old_name) or tostring(old_name)})
    end
    if not new_name then
      BioInd.debugging.writeDebug("Prerequisite technology %s does not exist.",
                                  {get_technology_name(new_name) or tostring(new_name)})
    end
  end
BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.replace_prerequisite(technology, old, new)
BioInd.debugging.entered_function({technology, old, new})
  if technology and old and new then
    thxbob.lib.tech.replace_difficulty_prerequisite(technology, "", old, new)
    thxbob.lib.tech.replace_difficulty_prerequisite(technology, "normal", old, new)
    thxbob.lib.tech.replace_difficulty_prerequisite(technology, "expensive", old, new)
  else
    if not tech then
      BioInd.debugging.writeDebug("Missing technology name!")
    end
    if not old then
      BioInd.debugging.writeDebug("Missing old prerequisite!")
    end
    if not new then
      BioInd.debugging.writeDebug("Missing new prerequisite!")
    end
  end
BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.add_difficulty_prerequisite(technology, difficulty, prerequisite)
BioInd.debugging.entered_function({technology, difficulty, prerequisite})
  BI_Functions.lib.check_difficulty(difficulty)

  prereq = get_technology_name(prerequisite)

  local tech = get_technology(technology)
  local prerequisites, addit

  if tech and prereq then
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
        if prereq == old then
          addit = false
          break
        end
      end
    end

    if addit then
      table.insert(prerequisites, prereq)
    end
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not prereq then
      BioInd.debugging.writeDebug("Prerequisite technology %s does not exist.", {serpent.line(prerequisite)})
    end
  end
BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.add_prerequisite(technology, prerequisite)
--~ BioInd.debugging.entered_function({technology, prerequisite})

  local tech = get_technology(technology)
  local prereq = get_technology_name(prerequisite)

  if tech and prereq then
    thxbob.lib.tech.add_difficulty_prerequisite(tech, "", prereq)
    thxbob.lib.tech.add_difficulty_prerequisite(tech, "normal", prereq)
    thxbob.lib.tech.add_difficulty_prerequisite(tech, "expensive", prereq)
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not prereq then
      BioInd.debugging.writeDebug("Prerequisite technology %s does not exist.", {serpent.line(prerequisite)})
    end
  end
--~ BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_prerequisite(technology, difficulty, prerequisite)
BioInd.debugging.entered_function({technology, difficulty, prerequisite})
  BI_Functions.lib.check_difficulty(difficulty)

  local prereq = get_technology_name(prerequisite)
  local tech = get_technology(technology)

  local prerequisites, doit

  if tech and prereq then
    if difficulty == "" then
      prerequisites = tech.prerequisites
    else
      prerequisites = tech[difficulty] and tech[difficulty].prerequisites
    end

    if prerequisites then
      for p = #prerequisites, 1, -1 do
        if prerequisites[p] == prereq then
          table.remove(prerequisites, p)
        end
      end
    end

  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not prereq then
      BioInd.debugging.writeDebug("Prerequisite technology %s does not exist.", {serpent.line(prerequisite)})
    end
  end
BioInd.debugging.entered_function("leave")
end


-- Modified by Pi-C
function thxbob.lib.tech.remove_prerequisite(technology, prerequisite)
BioInd.debugging.entered_function({technology, prerequisite})


  local prereq = get_technology_name(prerequisite)
  local tech = get_technology(technology)

  if tech and prereq then
    thxbob.lib.tech.remove_difficulty_prerequisite(tech, "", prereq)
    thxbob.lib.tech.remove_difficulty_prerequisite(tech, "normal", prereq)
    thxbob.lib.tech.remove_difficulty_prerequisite(tech, "expensive", prereq)
  else
    if not tech then
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
    end
    if not prereq then
      BioInd.debugging.writeDebug("Prerequisite technology %s does not exist.", {serpent.line(prerequisite)})
    end
  end
BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
function thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(technology, difficulty)
BioInd.debugging.entered_function({technology, difficulty})

  BI_Functions.lib.check_difficulty(difficulty)

  local tech = get_technology(technology)
  local prerequisites, prerequisite

  if tech then
    if difficulty == "" then
      prerequisites = tech.prerequisites
    else
      prerequisites = tech[difficulty] and tech[difficulty].prerequisites
    end

BioInd.debugging.show("prerequisites", prerequisites)
    if prerequisites then
      for p = #prerequisites, 1, -1 do
        prerequisite = prerequisites[p]
BioInd.debugging.show("p", p)
BioInd.debugging.show("prerequisite", prerequisite)
BioInd.debugging.show("data.raw.technology["..prerequisite.."]", data.raw.technology[prerequisite])
        if not data.raw.technology[prerequisite] then
          table.remove(prerequisites, p)
          BioInd.debugging.writeDebug("Removed prerequisite tech %s from prerequisites of %s (%s): %s", {
            serpent.line(prerequisite), tech.name, difficulty ~= "" and difficulty or "no difficulty", serpent.line(prerequisites)})
        end
      end
    end
BioInd.debugging.show("tech", tech)
  else
    BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                {get_technology_name(technology) or tostring(technology)})
  end
BioInd.debugging.entered_function("leave")
end


-- Added by Pi-C
-- This will remove NON-EXISTING techs from the prerequisites of other mods. Not to
-- be confused with redundant prerequisites that exist but are already required via
-- other techs!
function thxbob.lib.tech.remove_obsolete_prerequisites(technology)
BioInd.debugging.entered_function({technology})

  local tech = get_technology(technology)

  if tech then
BioInd.debugging.show("tech before removing obsolete prerequisites", tech)
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "")
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "normal")
    thxbob.lib.tech.remove_difficulty_obsolete_prerequisites(tech, "expensive")
BioInd.debugging.show("tech after removing obsolete prerequisites", tech)
  else
      BioInd.debugging.writeDebug("Technology \"%s\" does not exist.",
                                  {get_technology_name(technology) or tostring(technology)})
  end
BioInd.debugging.entered_function("leave")
end
