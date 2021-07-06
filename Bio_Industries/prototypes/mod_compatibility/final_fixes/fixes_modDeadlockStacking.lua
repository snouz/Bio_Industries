------------------------------------------------------------------------------------
--   Deadlock's Stacking Beltboxes & Compact Loaders/Deadlock's Crating Machine   --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "deadlock-beltboxes-loaders",
  "DeadlockCrating",
}) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath .. "mod_stacked/"

local items = data.raw.item
local recipes = data.raw.recipe

local new_item, new_recipe, cnt
local recipe_list = {}
local skip_recipes = {}

local sep = string.rep("*", 100)

local stack_name, crate_name, loc_name, stack_size, items_per_crate, src_recipe
local run_again, cnt


------------------------------------------------------------------------------------
--                             List of stackable items                            --
------------------------------------------------------------------------------------
-- Complete list of things that could be stacked
local stacked_items={
-- Key: tech level. Value: item data
 [2] = {
    BI.default_items.adv_fertilizer,
    --~ BI.default_items.ash,
    BI.default_items.fertilizer,
    BI.default_items.seed,
    BI.default_items.seedling,
    BI.default_items.wood_bricks,
    BI.default_items.woodpulp,

    BI.additional_items.ash,

    BI.additional_items.BI_Bio_Fuel.cellulose,

    BI.additional_items.BI_Coal_Processing.pellet_coke,
    BI.additional_items.BI_Coal_Processing.wood_charcoal,

    BI.additional_items.BI_Darts.wooden_fence,

    BI.additional_items.BI_Rails.rail_power,
    BI.additional_items.BI_Rails.rail_wood,
    BI.additional_items.BI_Rails.rail_wood_bridge,

    BI.additional_items.BI_Rubber.resin,
    BI.additional_items.BI_Rubber.rubber,
    BI.additional_items.BI_Rubber.rubber_mat,

    BI.additional_items.BI_Power_Production.solar_mat,

    BI.additional_items.BI_Stone_Crushing.crushed_stone,

    BI.additional_items.BI_Wood_Products.big_pole,
    BI.additional_items.BI_Wood_Products.huge_pole,
    BI.additional_items.BI_Wood_Products.wood_pipe,
    BI.additional_items.BI_Wood_Products.wood_pipe_to_ground,
  }
}

-- Remove non-existing items from list
cnt = 0
for level, i_data in pairs(stacked_items) do
  run_again = false
  -- Removing
  repeat
    for i, item in ipairs(i_data) do
      -- Some things (rail-planner, ammo etc.) are considered items although they are
      -- of another prototype type!
      if not data.raw[item.type][item.name] then
        BioInd.show("Removing non-existent item", item.name)
        stacked_items[level][i] = nil
        cnt = cnt + 1
        run_again = true
        break

        if not next(stacked_items[level]) then
          stacked_items[level] = nil
        end
      end
    end
  until not run_again
end
BioInd.writeDebug("Removed %s items from list of stackable items. Need to check these items:", {cnt})
for level, i_data in pairs(stacked_items) do
  for i, item in pairs(i_data) do
    BioInd.writeDebug(item.name)
  end
end


------------------------------------------------------------------------------------
-- Find recipes that make ONLY this item. We want to order the new recipes right  --
-- after the last recipe that makes this item.                                    --
------------------------------------------------------------------------------------
local function check_difficulty(r_data, name, difficulty)
BioInd.entered_function()
  BioInd.check_args(name, "string", "item name")

  local results, ret
--~ BioInd.writeDebug("Difficulty: %s\nLooking for %s in recipe %s", {difficulty or "none", name, r_data and r_data.name or r_data or "nil"}, "line")

--~ BioInd.show("r_data", r_data or "nil")
--~ BioInd.show("r_data.result", r_data and r_data.result or "nil")
--~ BioInd.show("r_data.results", r_data and r_data.results or "nil")

  if r_data then
    results = r_data.results
    --~ if results and table_size(results) == 1 and
    if (results and table_size(results) == 1 and
        (results[1].type == "item" and results[1].name == name or
        results[1][1]  == name)) then
      BioInd.writeDebug("Match in results: %s", {results[1]})
      ret = true
    elseif r_data.result == name then
      BioInd.show("Matching result" , r_data.result)
      ret = true
    else
      BioInd.writeDebug("No match for %s%s!", {
                        name, difficulty and " in difficulty " .. difficulty or ""})
    end
  end
  return ret
end

local function check_recipe(recipe, item_name)
BioInd.entered_function()
  -- Skip recipes that have already been checked for this item
  if skip_recipes[recipe.name] then
    BioInd.writeDebug("Already checked recipe %s -- nothing to do!", {recipe.name, item_name})

  -- Skip recipes that exist in the list but have not been created
  elseif recipe and recipe.name and not recipes[recipe.name] then
    BioInd.writeDebug("Recipe %s does not exist -- returning immediately!",
                      {recipe and recipe.name or "nil"})

  -- Check recipe
  else
  BioInd.show("Checking recipe", recipe.name)
    -- At least one difficulty must have the item as recipe.result or as the only
    -- result in recipe.results.
    if check_difficulty(recipe, item_name) or
        check_difficulty(recipe.normal, item_name, "normal") or
        check_difficulty(recipe.expensive, item_name, "expensive") then

      -- Store all recipes that make this item!
      --~ table.insert(recipe_list[item_name], {name = recipe.name, order = recipe.order})
      table.insert(recipe_list[item_name], recipe)
      BioInd.writeDebug("Found %s in recipe: %s\t", {item_name , recipe.name})
      skip_recipes[recipe.name] = true
    end
  end
end


for level, data in pairs(stacked_items) do
  for i, item in pairs(data) do
BioInd.writeDebug("Checking recipes for item %s!", item.name)
    recipe_list[item.name] = recipe_list[item.name] or {}

    -- Check default recipes
BioInd.writeDebug("\nCHECKING DEFAULT RECIPES!")
    for r, recipe in pairs(BI.default_recipes) do
      check_recipe(recipe, item.name)
    end

    -- Check additional recipes
BioInd.writeDebug("\nCHECKING ADDITIONAL RECIPES!")
    for t, tab in pairs(BI.additional_recipes) do

      -- Mod compatibility: BI.additional_recipes.RECIPE
      if tab.type == "recipe" then
BioInd.writeDebug("\nChecking a recipe added for mod compatibility")
        check_recipe(tab, item.name)

      -- Settings: BI.additional_recipes.SETTING.RECIPE
      else
BioInd.writeDebug("\nChecking a recipe added for a setting")
        for r, recipe in pairs(tab) do
          check_recipe(recipe, item.name)
        end
      end
    end

BioInd.writeDebug("\n\n%s\nRecipes producing %s: %s\n", {sep, item.name, recipe_list[item.name] or "nil", sep})
    -- Sort recipes by order string
    table.sort(recipe_list[item.name], function(a, b)
      return a and b and a.order and b.order and a.order > b.order
    end)

BioInd.writeDebug("Sorted list: %s\n\n%s", {recipe_list[item.name], sep})
  end
end
BioInd.writeDebug("\n%s\nComplete recipe list: %s\n%s", {sep, recipe_list, sep})


------------------------------------------------------------------------------------
--                 Deadlock's Stacking Beltboxes & Compact Loaders                --
------------------------------------------------------------------------------------
if deadlock_stacking then

    -- hit the subgroups again to cover any added since data.lua load
  for _, group in pairs(data.raw["item-group"]) do
    if not data.raw["item-subgroup"][string.format("stacks-%s", group.name)] then
      data:extend({
        {
          type = "item-subgroup",
          name = string.format("stacks-%s", group.name),
          group = group.name,
          order = "zzzzz",
        },
      })
    end
  end
  
  for level, i_data in pairs(stacked_items) do
    for i, item in ipairs(i_data) do
      -- Some things (rail-planner, ammo etc.) are considered items although they are
      -- of another prototype type (but the stack items are of type "item")!
      stack_name = "deadlock-stack-" .. item.name
      if data.raw[item.type][item.name] then
        new_item = items[stack_name]

        -- Create new item if necessary
        if not new_item then
        -- deadlock.add_stack(item_name, graphic_path, target_tech, icon_size, item_type, mipmap_levels)
          deadlock.add_stack(
            item.name,
            ICONPATH .. item.name .. "-stacked.png",
            "deadlock-stacking-" .. level,
            64,
            item.type,
            4
          )
          new_item = items[stack_name]
          items[stack_name].item_subgroup = {string.format("stacks-%s", data.raw[item.type][item.name].item_subgroup)}
          BioInd.created_msg(new_item)
        end


        -- Localize new item
        stack_size = deadlock.get_item_stack_density(item.name, item.type)
        loc_name = item.localised_name or {"item-name." .. item.name}
        -- Reversed list: Last recipe will be first!
        src_recipe = recipe_list[item.name][1]

        new_item.localised_name = {"item-name.deadlock-stacking-stack", loc_name, stack_size}
        BioInd.modified_msg("localization", new_item)

        -- Modify new recipes
        for r, r_type in ipairs({"stack", "unstack"}) do
          new_recipe = recipes["deadlock-stacks-" .. r_type .. "-" .. item.name]

          -- Localization
          new_recipe.localised_name = {"recipe-name.deadlock-stacking-" .. r_type, loc_name}
          BioInd.modified_msg("localization", new_recipe)

          -- Subgroup
          --new_recipe.subgroup = src_recipe.subgroup
          --new_recipe.subgroup = {"stacks-" .. src_recipe.subgroup}
          --if not data.raw["item-subgroup"][string.format("stacks-%s", group.name)] then
          new_recipe.category = "unstacking"
          BioInd.modified_msg("subgroup", new_recipe)

          -- Order
          new_recipe.order = src_recipe.order .. "-[deadlock-stacking-" .. r_type .. "]"
          BioInd.modified_msg("order", new_recipe)
        end
      end
    end
  end
end
--~ for i, item in pairs(items) do
  --~ if i:match("deadlock") then
    --~ BioInd.writeDebug("Item %s: %s", {i, item.localised_name}, "line")
  --~ end
--~ end
--~ for r, recipe in pairs(recipes) do
  --~ if r:match("deadlock") then
    --~ BioInd.writeDebug("Recipe %s: %s", {r, recipe.localised_name}, "line")
  --~ end
--~ end


------------------------------------------------------------------------------------
--                           Deadlock's Crating Machine                           --
------------------------------------------------------------------------------------
if deadlock_crating then
  for level, i_data in pairs(stacked_items) do
    for i, item in ipairs(i_data) do
      --~ -- Some things (rail-planner, ammo etc.) are considered items although they are
      --~ -- of another prototype type (but the stack items are of type "item")!
      --~ if data.raw[item.type][item.name] then
        -- The function above only accepts prototypes from data.raw.item at the moment.
        -- That won't work with rail-planners (wooden rails, powered rails, bridges),
        -- so we need to skip these!
      if data.raw.item[item.name] then
        crate_name = "deadlock-crate-" .. item.name
        new_item = items[crate_name]

        -- Create new item if necessary
        if not new_item then
         deadlock_crating.add_crate(item.name, "deadlock-crating-" .. level)
         --~ local test = deadlock_crating.add_crate(item.name, "deadlock-crating-" .. level)
--~ BioInd.show("Returned from add_crate", test)
--~ BioInd.show("new_item", new_item)

          new_item = items[crate_name]
          BioInd.created_msg(new_item)
        end

        -- Localize new item
        items_per_crate = item.stack_size/new_item.stack_size
        loc_name = item.localised_name or {"item-name." .. item.name}

        -- Reversed list: Last recipe will be first!
        src_recipe = recipe_list[item.name][1]

        new_item.localised_name = {"item-name.deadlock-crate-item", items_per_crate, loc_name}
        BioInd.show("localised name", {"item-name.deadlock-crate-item", items_per_crate, loc_name})
        BioInd.modified_msg("localization", new_item)

        -- Modify new recipes
        for r, r_type in ipairs({"pack", "unpack"}) do
BioInd.show("Expected recipe name", "deadlock-crates-" .. r_type .. "-" .. item.name)
          --~ new_recipe = recipes["deadlock-crates-" .. r_type .. "-" .. item.name]
          new_recipe = recipes["deadlock-" .. r_type .. "recipe-" .. item.name]
BioInd.show("Found recipe name", new_recipe and new_recipe.name or "nil")

          -- Localization
          new_recipe.localised_name = {"recipe-name.deadlock-" .. r_type .. "ing-recipe", loc_name}
          BioInd.modified_msg("localization", new_recipe)

          -- Subgroup
          new_recipe.subgroup = src_recipe.subgroup
          BioInd.modified_msg("subgroup", new_recipe)

          -- Order
          new_recipe.order = src_recipe.order .. "-[deadlock-crating-" .. r_type .. "]"
          BioInd.modified_msg("order", new_recipe)
        end
      end
    end
  end
end

--~ BioInd.writeDebug("Show deadlock crating items")
--~ for i, item in pairs(items) do
  --~ if i:match("deadlock") and i:match("crat") then
    --~ BioInd.writeDebug("Item %s: %s", {i, item.localised_name or "no localization"}, "line")
  --~ end
--~ end
--~ for r, recipe in pairs(recipes) do
  --~ if r:match("deadlock") and r:match("crat") then
    --~ BioInd.writeDebug("Recipe %s: %s", {r, recipe.localised_name or "no localization"}, "line")
  --~ end
--~ end


----------------------------------------        --------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")