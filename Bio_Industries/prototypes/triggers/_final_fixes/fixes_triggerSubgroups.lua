------------------------------------------------------------------------------------
--           Trigger: Sort recipes into item-subgroups from other mods?           --
--                       (BI.Triggers.BI_Trigger_Subgroups)                       --
------------------------------------------------------------------------------------
-- Mods: "5dim_core"
local trigger = "BI_Trigger_Subgroups"
if not BI.Triggers[trigger] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items             = data.raw.item
local recipes           = data.raw.recipe
local item_groups       = data.raw["item-group"]
local item_subgroups    = data.raw["item-subgroup"]
local item_searchlist, recipe_searchlist
local done_list = {}



--~ ------------------------------------------------------------------------------------
--~ -- Create new subgroups
--~ local function make_subgroup(subgroup, group, order)
  --~ local create
  --~ if subgroup and group then
    --~ create = {
      --~ type = "item-subgroup",
      --~ name = subgroup,
      --~ group = group,
      --~ order = order
    --~ }
    --~ BioInd.create_stuff(create)
  --~ end
--~ end


------------------------------------------------------------------------------------
--                          Add our items to 5D's groups                          --
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- First, we check our own items (recipes making them will inherit the item-subgroup
-- from the item). IF any of our recipes produce items from vanilla or other mods,
-- data for item-subgroup  will be stored directly there.
-- items:       Complete table with item definitions and possibly subtables
--              (e.g. BI.additional_items)
-- recipes:     Complete table with recipe definitions and possibly subtables
--              (e.g. BI.additional_recipes)
-- mod_handle:  string appended to the subgroup definitions
--              (e.g. "5d" --> item.subgroup_5d, item.subgroup_order_5d)
local function change_subgroups(items, recipes, mod_handle)

  BioInd.debugging.check_args(items, "table", "item list")
  BioInd.debugging.check_args(recipes, "table", "recipe list")
  BioInd.debugging.check_args(mod_handle, "string", "mod handle")

  -- item-group and order of the subgroup in the item-group
  local group           = "group_" .. mod_handle
  local subgroup_order  = "subgroup_order_" .. mod_handle
  -- subgroup and order of the item/recipe in the subgroup
  local subgroup        = "subgroup_" .. mod_handle
  local order           = "order_" .. mod_handle

  for il, item_list in pairs(items) do
    item_searchlist = (item_list.type or item_list.name) and {item_list} or item_list

    for i, opt_item in pairs(item_searchlist) do
      item = data.raw[opt_item.type][opt_item.name]
  BioInd.debugging.show("Checking item", item and item.name or "nil")
  BioInd.debugging.show("Item has 5D-subgroup", item and item[subgroup] or "nil")

      -- Data for vanilla rails (possibly other entities?) are stored in our tables,
      -- but have never been created because we don't overwrite existing things. As
      -- we want to use the stored group/order data, we must refer to our table!
      if item and
          (item[subgroup] or opt_item[subgroup]) and
          (item[order] or opt_item[order]) then

        --~ -- Create subgroup?
        --~ if not item_subgroups[item[subgroup]] then
          --~ make_subgroup(item[subgroup], item[group], item[subgroup_order])
        --~ end

        item.subgroup = item[subgroup] or opt_item[subgroup]
        BioInd.debugging.modified_msg("subgroup", item)

        item.order = item[order] or opt_item[order]
        BioInd.debugging.modified_msg("order", item)

BioInd.debugging.show("Looking for recipes making", item.name)
        for rl, recipe_list in pairs(recipes) do
          recipe_searchlist = (recipe_list.type or recipe_list.name) and {recipe_list} or recipe_list
          for r, opt_recipe in pairs(recipe_searchlist) do
BioInd.debugging.show("Must check recipe", opt_recipe.name)
            recipe = data.raw.recipe[opt_recipe.name]
            -- The recipe exists and we didn't change the subgroup yet
            if recipe and not done_list[recipe.name] then
              -- The recipe creates a BI item and inherits its subgroup/order
              if BI_Functions.lib.recipe_has_result(recipe, item.name) or
                  BI_Functions.lib.recipe_get_property(recipe, "main_product") == item.name then
BioInd.debugging.writeDebug("Must add recipe %s to subgroup %s", {recipe.name, item[subgroup] or opt_item[subgroup]})
                recipe.subgroup = item[subgroup]
                recipe.order = item[order]
                done_list[recipe.name] = true
                BioInd.debugging.modified_msg("subgroup", recipe)
              -- The recipe creates a vanilla/mod item and has its own subgroup/order data
              elseif recipe[subgroup] then
                --~ if not item_subgroups[recipe[subgroup]] then
                  --~ make_subgroup(recipe[subgroup], recipe[group], recipe[subgroup_order])
                --~ end

                recipe.subgroup = recipe[subgroup]
                recipe.order = recipe[order]
                done_list[recipe.name] = true

                BioInd.debugging.modified_msg("subgroup", recipe)
              end
            else
              BioInd.debugging.writeDebug("Skipping recipe %s -- %s!", {
                                recipe and recipe.name or opt_recipe.name,
                                recipe and "already added to new subgroup" or "recipe doesn't exist"
              })
            end
          end
        end
      end
    end
  end
end


------------------------------------------------------------------------------------
--                          Add our stuff to 5D's groups                          --
------------------------------------------------------------------------------------
-- Check default items/recipes
change_subgroups(BI.default_items, BI.default_recipes, "5d")

-- Check additoinal items/recipes
change_subgroups(BI.additional_items, BI.additional_recipes, "5d")



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
