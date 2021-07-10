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
-- Lists of recipes producing only one item, indexed by name of recipe result
local recipe_list = {}

local stack_name, crate_name, loc_name, stack_size, items_per_crate, src_recipe
local cnt, check_item

-- Must declare the tables outside of if-then!
local crated_items, stacked_items

------------------------------------------------------------------------------------
--                             List of stackable items                            --
-- The order of items in these lists is the same as the order in the tech screen! --
------------------------------------------------------------------------------------
-- global table set by the stacking mod
if deadlock then
  stacked_items = {
    -- Key: tech level. Value: item data
    [1] = {
      BI.additional_items.BI_Darts.wooden_fence,
      BI.additional_items.BI_Wood_Products.wood_pipe,
      BI.additional_items.BI_Wood_Products.wood_pipe_to_ground,
      BI.default_items.seed,
      BI.default_items.seedling,
      BI.default_items.woodpulp,
      BI.default_items.wood_bricks,
      BI.additional_items.ash,
      BI.additional_items.BI_Rubber.resin,
      BI.additional_items.BI_Rubber.rubber,
      BI.additional_items.BI_Stone_Crushing.crushed_stone,
    },

    [2] = {
      BI.default_items.fertilizer,
      BI.default_items.adv_fertilizer,
      BI.additional_items.BI_Coal_Processing.wood_charcoal,
      BI.additional_items.BI_Coal_Processing.pellet_coke,


      BI.additional_items.BI_Bio_Fuel.cellulose,



      BI.additional_items.BI_Rails.rail_wood,
      BI.additional_items.BI_Rails.rail_wood_bridge,
      -- We'll need graphics for stacked vanilla rails!
      --~ BI.additional_items.BI_Rails.rail_concrete,
      BI.additional_items.BI_Rails.rail_power,

      BI.additional_items.BI_Rubber.rubber_mat,

      BI.additional_items.BI_Power_Production.solar_mat,


      BI.additional_items.BI_Wood_Products.big_pole,
      BI.additional_items.BI_Wood_Products.huge_pole,

      -- @snouz: These could be stacked, but do you think it makes sense (needs new icons)?
      --~ BI.additional_items.BI_Explosive_Planting.seed_bomb_advanced,
      --~ BI.additional_items.BI_Explosive_Planting.seed_bomb_basic,
      --~ BI.additional_items.BI_Explosive_Planting.seed_bomb_standard,
      --~ BI.additional_items.Bio_Cannon.bio_cannon_ammo_basic,
      --~ BI.additional_items.Bio_Cannon.bio_cannon_ammo_poison,
      --~ BI.additional_items.Bio_Cannon.bio_cannon_ammo_proto,
      --~ BI.additional_entities.BI_Darts.dart_magazine_basic
      --~ BI.additional_entities.BI_Darts.dart_magazine_standard
      --~ BI.additional_entities.BI_Darts.dart_magazine_enhanced
      --~ BI.additional_entities.BI_Darts.dart_magazine_poison

      -- Special case: Prototype artillery, darts, and seedbombs are entirely our
      -- own things. Artillery shells are vanilla, and there are varieties by other mods.
      -- Stacking may be a good idea (small stacksize) -- but only for our own shells?
      --~ BI.additional_items.Bio_Cannon.poison_artillery_shell,

    }
  }
end

------------------------------------------------------------------------------------
--                             List of crateable items                            --
-- The order of items in these lists is the same as the order in the tech screen! --
------------------------------------------------------------------------------------
-- deadlock_crating is a global table created the crating mod!
if deadlock_crating then

  crated_items = {
  -- Key: tech level. Value: item data

    [1] = {
      BI.additional_items.BI_Wood_Products.wood_pipe,
      BI.additional_items.BI_Wood_Products.wood_pipe_to_ground,
      BI.default_items.seed,
      BI.default_items.seedling,
      BI.default_items.woodpulp,
      BI.default_items.wood_bricks,

      BI.additional_items.BI_Rubber.resin,
      BI.additional_items.BI_Rubber.rubber,
      BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone,
      BI.additional_items.ash,
    },
    [2] = {
      BI.default_items.fertilizer,
      BI.default_items.adv_fertilizer,

      BI.additional_items.BI_Coal_Processing.wood_charcoal,
      BI.additional_items.BI_Coal_Processing.pellet_coke,
      BI.additional_items.BI_Bio_Fuel.cellulose,
      BI.additional_items.BI_Rubber.rubber_mat,
      BI.additional_items.BI_Power_Production.solar_mat,
      --~ BI.additional_items.BI_Rails.power_to_rail_pole,

      -- Unfortunately, the crating mod only allows for data.raw.item to be crated!
      --~ BI.additional_items.BI_Explosive_Planting.seed_bomb_advanced,
      --~ BI.additional_items.BI_Explosive_Planting.seed_bomb_basic,
      --~ BI.additional_items.BI_Explosive_Planting.seed_bomb_standard,
      --~ BI.additional_items.Bio_Cannon.bio_cannon_ammo_basic,
      --~ BI.additional_items.Bio_Cannon.bio_cannon_ammo_poison,
      --~ BI.additional_items.Bio_Cannon.bio_cannon_ammo_proto,
      --~ BI.additional_items.Bio_Cannon.poison_artillery_shell,
    }
  }
end


--~ ------------------------------------------------------------------------------------
--~ --                      Remove non-existant items from lists                      --
--~ ------------------------------------------------------------------------------------
--~ local function clean_list(list)
  --~ BioInd.entered_function()

  --~ local run_again
  --~ local cnt = 0

  --~ -- Removing
  --~ repeat
    --~ -- Endless loops if set before repeat!
    --~ run_again = false
    --~ for i, item in ipairs(i_data) do
      --~ -- Some things (rail-planner, ammo etc.) are considered items although they are
      --~ -- of another prototype type!
      --~ if not data.raw[item.type][item.name] then
        --~ BioInd.show("Removing non-existent item", item.name)
        --~ stacked_items[level][i] = nil
        --~ cnt = cnt + 1
        --~ run_again = true
        --~ break

        --~ if not next(stacked_items[level]) then
          --~ stacked_items[level] = nil
        --~ end
      --~ end
    --~ end
  --~ until not run_again

  --~ BioInd.entered_function("leave")
  --~ return cnt
--~ end




------------------------------------------------------------------------------------
--   Compile list of all recipes making items from the stackable/crateable lists  --
------------------------------------------------------------------------------------
-- Go over all our recipes and find those that have just one ITEM as result. Store
-- the recipes in a table indexed by result names. The table will probably contain
-- more results than we need, but we don't have to go over all recipes for each item
-- this way.
------------------------------------------------------------------------------------
local function get_one_result_recipes(recipe)
  BioInd.entered_function()

  if type(recipe) == "table" and recipe.name and type(item_name) == "string" then
    -- Skip recipes that exist in the list but have not been created
    if not recipes[recipe.name] then
      BioInd.writeDebug("Recipe %s does not exist -- returning immediately!", {recipe.name})
    -- Check recipe
    else
      BioInd.show("Checking recipe", recipe.name)
      local results = BI_Functions.lib.get_recipe_results(recipe)
      -- Only check recipes with one result!
      if not results or table_size(results) ~= 1 then
        BioInd.writeDebug("Ignoring recipe %s (has %s results)",
        {recipe.name, results and table_size(results) or 0})
      else
        local r, result = next(results)
        -- We can't stack or crate fluids!
        if result.type == "fluid" then
          BioInd.writeDebug("Ignoring recipe %s (result is a fluid!)", {recipe.name})
        -- We've struck gold!
        else
          recipe_list[result.name] = recipe_list[result.name] or {}
          table.insert(recipe_list[result.name], recipe)
        end
      end
    end
  end

  BioInd.entered_function("leave")
end


-- Check default recipes
BioInd.writeDebug("\nCHECKING DEFAULT RECIPES!")
for r, recipe in pairs(BI.default_recipes) do
  get_one_result_recipes(recipe)
end

-- Check additional recipes
BioInd.writeDebug("\nCHECKING ADDITIONAL RECIPES!")
for t, tab in pairs(BI.additional_recipes) do

  -- Mod compatibility: BI.additional_recipes.RECIPE
  if tab.type == "recipe" then
    BioInd.writeDebug("\nChecking a recipe added for mod compatibility")
    get_one_result_recipes(tab)

  -- Settings: BI.additional_recipes.SETTING.RECIPE
  else
    BioInd.writeDebug("\nChecking a recipe added for a setting")
    for r, recipe in pairs(tab) do
      get_one_result_recipes(recipe)
    end
  end
end
BioInd.writeDebug("Complete recipe list: %s", {recipe_list})


------------------------------------------------------------------------------------
--            Sort recipes by order string and return the last recipe.            --
------------------------------------------------------------------------------------
-- We will lump all crating recipes for the main BI group together in a separate
-- subgroup, but for items placed in vanilla groups (solar additions etc.), the  --
-- crating recipes should be sorted immediately after the normal ones.            --
local function get_last_recipe(item_name)
  local r_list = item_name and recipe_list[item_name] or
                  error(string.format("%s is not a valid item_name or there are no data!", item_name))

  table.sort(r_list, function(a, b)
    return a and b and a.order and b.order and a.order < b.order
  end)

  return r_list[#r_list]
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                 Deadlock's Stacking Beltboxes & Compact Loaders                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- deadlock is a global table provided by the stacking mod!
if deadlock then
  -- Limit the scope of subgroup to this block, we probably won't need it after this!
  do
    -- Snouz
    -- hit the subgroups again to cover any added since data.lua load
BioInd.writeDebug("Creating item-subgroups?")
    -- If the same string is used more than once, cache it in a variable!
    local subgroup
    for g, group in pairs(data.raw["item-group"]) do
BioInd.show(g, group)
      -- Don't use string.format if you only want to append a string at the end! It's
      -- really good for adding things inside of a string, though.
      subgroup ="stacks-" .. group.name
BioInd.show("subgroup", subgroup)
BioInd.show(subgroup, data.raw["item-subgroup"][subgroup])
      if not data.raw["item-subgroup"][subgroup] then
BioInd.writeDebug("Must create subgroup %s!", subgroup)
        -- @snouz: Use BioInd.create_stuff (logs new creations) instead of data:extend!
        --~ data:extend({
          --~ {
            --~ type = "item-subgroup",
            --~ name = subgroup,
            --~ group = group.name,
            --~ order = "zzzzz",
          --~ },
        --~ })
        BioInd.create_stuff({
          type = "item-subgroup",
          name = subgroup,
          group = group.name,
          order = "zzzzz",
        })
      end
    end
  end

  --~ -- Remove non-existant items from stacked_items
  --~ for level, i_data in pairs(stacked_items) do
    --~ cnt = clean_list(i_data)
    --~ BioInd.writeDebug("Removed %s items from list of stackable items. Need to check these items:", {cnt})
    --~ for i, item in pairs(i_data) do
      --~ BioInd.writeDebug(item.name)
    --~ end
  --~ end

  for level, i_data in pairs(stacked_items) do
    for i, item in ipairs(i_data) do
      -- Some things (rail-planner, ammo etc.) are considered items although they are
      -- of another prototype type (but the stack items are of type "item")!
      check_item = data.raw[item.type][item.name]
      --~ if data.raw[item.type][item.name] then
      if check_item and recipe_list[item.name] then
        stack_name = "deadlock-stack-" .. item.name
BioInd.show("stack_name", stack_name)
        new_item = items[stack_name]
BioInd.show("new_item", new_item)
        -- Create new item if necessary
        if not new_item then
BioInd.writeDebug("Must create stack!")
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
BioInd.show("Created new_item", new_item)
          --~ items[stack_name].item_subgroup = {string.format("stacks-%s", data.raw[item.type][item.name].item_subgroup)}
          items[stack_name].item_subgroup = "stacks-" .. tostring(check_item.item_subgroup or "no_name")
BioInd.show("subgroup of stack item", items[stack_name].item_subgroup)
          BioInd.created_msg(new_item)
        end


        -- Localize new item
        stack_size = deadlock.get_item_stack_density(item.name, item.type)
        loc_name = item.localised_name or {"item-name." .. item.name}

        new_item.localised_name = {"item-name.deadlock-stacking-stack", loc_name, stack_size}
        BioInd.modified_msg("localization", new_item)

        -- Modify new recipes
        for r, r_type in ipairs({"stack", "unstack"}) do
          new_recipe = recipes["deadlock-stacks-" .. r_type .. "-" .. item.name]

          if new_recipe then
            -- Localization
            new_recipe.localised_name = {"recipe-name.deadlock-stacking-" .. r_type, loc_name}
            BioInd.modified_msg("localization", new_recipe)

            -- Subgroup
            --new_recipe.subgroup = src_recipe.subgroup
            --new_recipe.subgroup = {"stacks-" .. src_recipe.subgroup}
            --if not data.raw["item-subgroup"][string.format("stacks-%s", group.name)] then
            new_recipe.category = "unstacking"
            BioInd.modified_msg("category", new_recipe)

            -- Order
            src_recipe = get_last_recipe(item.name)
            --~ new_recipe.order = src_recipe.order .. "-[deadlock-stacking-" .. r_type .. "]"
            new_recipe.order = (item.order_crating or src_recipe.order) ..
                                "-[deadlock-crating-" .. r_type .. "]"
            BioInd.modified_msg("order", new_recipe)
          end
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
------------------------------------------------------------------------------------
--                           Deadlock's Crating Machine                           --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- deadlock_crating is a global variable created by DCM!
if deadlock_crating then


  --~ -- Remove non-existant items from crated_items.
  --~ -- (That really can't be put into the next for-loop!)
  --~ for level, i_data in pairs(crated_items) do
    --~ cnt = clean_list(i_data)
    --~ BioInd.writeDebug("Removed %s items from list of crateable items. Need to check these items:", {cnt})
    --~ for i, item in pairs(i_data) do
      --~ BioInd.writeDebug(item.name)
    --~ end
  --~ end


  for level, i_data in pairs(crated_items) do
    for i, item in ipairs(i_data) do
BioInd.writeDebug("%s: %s", {i, item})
      -- Some things (rail-planner, ammo etc.) are considered items although they are
      -- of another prototype type (but the stack items are of type "item")!
      --~ if data.raw[item.type][item.name] then
      if items[item.name] and recipe_list[item.name] then
        crate_name = "deadlock-crate-" .. item.name
        new_item = items[crate_name]

        -- Create new item if necessary
        if not new_item then
          deadlock_crating.add_crate(item.name, "deadlock-crating-" .. level)
          new_item = items[crate_name]
          BioInd.created_msg(new_item)
        end

        -- Localize new item
        items_per_crate = item.stack_size/new_item.stack_size
        loc_name = item.localised_name or {"item-name." .. item.name}

        new_item.localised_name = {"item-name.deadlock-crate-item", items_per_crate, loc_name}
        BioInd.show("localised name", {"item-name.deadlock-crate-item", items_per_crate, loc_name})
        BioInd.modified_msg("localization", new_item)

        -- Modify new recipes
        for r, r_type in ipairs({"pack", "unpack"}) do
          new_recipe = recipes["deadlock-" .. r_type .. "recipe-" .. item.name]

          if new_recipe then
            -- Localization
            new_recipe.localised_name = {"recipe-name.deadlock-" .. r_type .. "ing-recipe", loc_name}
            BioInd.modified_msg("localization", new_recipe)

            -- Subgroup
            src_recipe = get_last_recipe(item.name)
            new_recipe.subgroup = item.order_crating and
                                    BI.additional_categories.mod_compatibility.crating.name or
                                    src_recipe.subgroup
            BioInd.modified_msg("subgroup", new_recipe)

            -- Order
            new_recipe.order = (item.order_crating or src_recipe.order) ..
                                "-[deadlock-crating-" .. r_type .. "]"
            BioInd.modified_msg("order", new_recipe)
          end
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


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
