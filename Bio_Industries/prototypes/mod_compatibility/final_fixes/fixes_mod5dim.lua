------------------------------------------------------------------------------------
--                                   5Dim's mods                                  --
--  (The core mod is required by all others, so we just need to check for that!)  --
------------------------------------------------------------------------------------
local mod_name = "5dim_core"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe
local groups = data.raw["item-group"]
local subgroups = data.raw["item-subgroup"]
local item, recipe, group, subgroup, check
local opt_item, opt_recipe, opt_groups, opt_group


------------------------------------------------------------------------------------
--                            Change stack size of wood                           --
------------------------------------------------------------------------------------
if BioInd.get_startup_setting("5d-change-stack") then
  item = items["wood"]
  if item then
    item.stack_size = math.max(210, item.stack_size)
    BioInd.modified_msg("stacksize", item)
  end
end


------------------------------------------------------------------------------------
--                          Add our items to 5D's groups                          --
------------------------------------------------------------------------------------
-- Rail stuff
group = "trains"
subgroup = "trains-rails"
if groups[group] and subgroups[subgroup] and subgroups[subgroup].group == group then
BioInd.writeDebug("Must move items to subgroup %s!", {subgroup})
  for i, opt_item in ipairs({
    BI.additional_items.BI_Rails.rail_wood,
    BI.additional_items.BI_Rails.rail_wood_bridge,
    BI.additional_items.BI_Rails.rail_power,
    BI.additional_items.BI_Rails.power_to_rail_pole,
  }) do
    item = data.raw[opt_item.type][opt_item.name]
    if item then
      item.subgroup = subgroup
      BioInd.modified_msg("subgroup", item)
    end
  end

  for r, opt_recipe in pairs(BI.additional_recipes.BI_Rails) do
    recipe = recipes[opt_recipe.name]
    if recipe then
      recipe.subgroup = nil
      BioInd.modified_msg("subgroup", recipe)
    end
  end
end


-- Chests
group = "mining"
subgroup = "store-solid"
if groups[group] and subgroups[subgroup] and subgroups[subgroup].group == group then
BioInd.writeDebug("Must move items to subgroup %s!", {subgroup})
  for i, opt_item in ipairs({
    BI.additional_items.BI_Wood_Products.large_wooden_chest,    BI.additional_items.BI_Wood_Products.huge_wooden_chest,
    BI.additional_items.BI_Wood_Products.giga_wooden_chest,
  }) do
    item = data.raw[opt_item.type][opt_item.name]
    if item then
      item.subgroup = subgroup
      BioInd.modified_msg("subgroup", item)
    end
  end

  for r, opt_recipe in pairs({
    BI.additional_recipes.BI_Wood_Products.large_wooden_chest,
    BI.additional_recipes.BI_Wood_Products.huge_wooden_chest,
    BI.additional_recipes.BI_Wood_Products.giga_wooden_chest,
  }) do
    recipe = opt_recipe and recipes[opt_recipe.name]
    if recipe then
      recipe.subgroup = nil
      BioInd.modified_msg("subgroup", recipe)
    end
  end
end


-- Energy production
group = "energy"
--~ opt_groups = BI.additional_categories.BI_Solar_Additions

if groups[group] and BI.additional_categories.BI_Solar_Additions then
BioInd.writeDebug("Must move subgroup %s to group %s!", {subgroup, group})
  for s, subgroup in ipairs(BI.additional_categories.BI_Solar_Additions) do
    subgroups[subgroup.name].group = group
    BioInd.modified_msg("group", subgroup)
  end

  for i, opt_item in pairs({
    BI.additional_items.BI_Bio_Fuel.bio_boiler,
    BI.additional_items.BI_Solar_Additions.solar_boiler,
    BI.additional_items.BI_Solar_Additions.solar_farm,
    BI.additional_items.BI_Solar_Additions.solar_mat,
  }) do
    item = items[opt_item.name]
    item.subgroup = subgroups[BI.additional_categories.BI_Solar_Additions.energy_solar_panel.name].name
  end
  item = items[BI.additional_items.BI_Solar_Additions.huge_accumulator.name]
  item.subgroup = subgroups[BI.additional_categories.BI_Solar_Additions.energy_accumulator.name].name
    BioInd.modified_msg("subgroup", item)

    --~ BI.additional_recipes.BI_Bio_Fuel.bio_boiler,
    --~ BI.additional_recipes.BI_Solar_Additions.solar_boiler,
    --~ BI.additional_recipes.BI_Solar_Additions.solar_farm,
    --~ BI.additional_recipes.BI_Solar_Additions.solar_mat,
    --~ BI.additional_recipes.BI_Solar_Additions.huge_accumulator,
    --~ recipe = opt_recipe and recipes[opt_recipe.name]
    --~ if recipe then
      --~ recipe.subgroup = nil
      --~ BioInd.modified_msg("subgroup", recipe)
    --~ end
end


-- Poles/Huge substation
group = "energy"
subgroup = "energy-pole"
if groups[group] and subgroups[subgroup] and subgroups[subgroup].group == group then
BioInd.writeDebug("Must move items to subgroup %s!", {subgroup})
  for i, opt_item in ipairs({
    BI.additional_items.BI_Wood_Products.big_pole,
    BI.additional_items.BI_Wood_Products.huge_pole,
    BI.additional_items.BI_Solar_Additions.huge_substation,
  }) do
    item = data.raw[opt_item.type][opt_item.name]
    if item then
      item.subgroup = subgroup
      BioInd.modified_msg("subgroup", item)
    end
  end

  for r, opt_recipe in pairs({
    BI.additional_recipes.BI_Wood_Products.big_pole,
    BI.additional_recipes.BI_Wood_Products.huge_pole,
    BI.additional_recipes.BI_Solar_Additions.huge_substation,
  }) do
    recipe = opt_recipe and recipes[opt_recipe.name]
    if recipe then
      recipe.subgroup = nil
      BioInd.modified_msg("subgroup", recipe)
    end
  end
end


-- Wooden pipes
group = "liquid"
subgroup = "transport-pipe"
if groups[group] and subgroups[subgroup] and subgroups[subgroup].group == group then
BioInd.writeDebug("Must move items to subgroup %s!", {subgroup})
  opt_item = BI.additional_items.BI_Wood_Products.wood_pipe
  item = data.raw[opt_item.type][opt_item.name]
  if item then
    item.subgroup = subgroup
    BioInd.modified_msg("subgroup", item)
  end
  local opt_recipe = BI.additional_recipes.BI_Wood_Products.wood_pipe
  recipe = opt_recipe and recipes[opt_recipe.name]
  if recipe then
    recipe.subgroup = nil
    BioInd.modified_msg("subgroup", recipe)
  end
end

subgroup = "transport-pipe-ground"
if groups[group] and subgroups[subgroup] and subgroups[subgroup].group == group then
  opt_item = BI.additional_items.BI_Wood_Products.wood_pipe_to_ground
  item = data.raw[opt_item.type][opt_item.name]
  if item then
    item.subgroup = subgroup
    BioInd.modified_msg("subgroup", item)
  end
  opt_recipe = BI.additional_recipes.BI_Wood_Products.wood_pipe_to_ground
  recipe = opt_recipe and recipes[opt_recipe.name]
  if recipe then
    recipe.subgroup = nil
    BioInd.modified_msg("subgroup", recipe)
  end
end


-- Alternative stone brick recipe
group = "decoration"
subgroup = "decoration-floor"
if groups[group] and subgroups[subgroup] and subgroups[subgroup].group == group then
BioInd.writeDebug("Must move items to subgroup %s!", {subgroup})
  opt_recipe = BI.additional_recipes.BI_Stone_Crushing.stone_brick
  recipe = opt_recipe and recipes[opt_recipe.name]
  if recipe then
    recipe.subgroup = nil
    BioInd.modified_msg("subgroup", recipe)
    recipe.order = "a-aa"
    BioInd.modified_msg("order", recipe)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
