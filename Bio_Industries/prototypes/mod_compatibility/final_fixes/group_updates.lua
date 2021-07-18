BioInd.entered_file()

-- THIS ISN'T USED YET!
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



local recipes = data.raw.recipe
local subgroups = data.raw["item-subgroup"]
local group, subgroup, group_order, order
local item_type, item


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--changes recipe position in menu based on installed mod
--args ("mod that makes the change", "recipe to move", "New Subgroup", "New Order (1987)")
local function change_sub(_mod, _recipe, _subgroup, _order)
  local recipe = recipes[_recipe] or nil
  if _mod and mods[_mod] and recipe then
    if _subgroup and data.raw["item-subgroup"][_subgroup] then
      recipe.subgroup = _subgroup
    end
    if _mod and recipe and _order then
      recipe.order = _order
    end
  end
end


local function change_subgroups(items, recipes, mod_handle)

  BioInd.check_args(items, "table", "item list")
  BioInd.check_args(recipes, "table", "recipe list")
  BioInd.check_args(mod_handle, "string", "mod handle")

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
  BioInd.show("Checking item", item and item.name or "nil")
  BioInd.show("Item has 5D-subgroup", item and item[subgroup] or "nil")

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
        BioInd.modified_msg("subgroup", item)

        item.order = item[order] or opt_item[order]
        BioInd.modified_msg("order", item)

BioInd.show("Looking for recipes making", item.name)
        for rl, recipe_list in pairs(recipes) do
          recipe_searchlist = (recipe_list.type or recipe_list.name) and {recipe_list} or recipe_list
          for r, opt_recipe in pairs(recipe_searchlist) do
BioInd.show("Must check recipe", opt_recipe.name)
            recipe = data.raw.recipe[opt_recipe.name]
            -- The recipe exists and we didn't change the subgroup yet
            if recipe and not done_list[recipe.name] then
              -- The recipe creates a BI item and inherits its subgroup/order
              if BI_Functions.lib.recipe_has_result(recipe, item.name) or
                  BI_Functions.lib.recipe_get_property(recipe, "main_product") == item.name then
BioInd.writeDebug("Must add recipe %s to subgroup %s", {recipe.name, item[subgroup] or opt_item[subgroup]})
                recipe.subgroup = item[subgroup]
                recipe.order = item[order]
                done_list[recipe.name] = true
                BioInd.modified_msg("subgroup", recipe)
              -- The recipe creates a vanilla/mod item and has its own subgroup/order data
              elseif recipe[subgroup] then
                --~ if not item_subgroups[recipe[subgroup]] then
                  --~ make_subgroup(recipe[subgroup], recipe[group], recipe[subgroup_order])
                --~ end

                recipe.subgroup = recipe[subgroup]
                recipe.order = recipe[order]
                done_list[recipe.name] = true

                BioInd.modified_msg("subgroup", recipe)
              end
            else
              BioInd.writeDebug("Skipping recipe %s -- %s!", {
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
-- Create new subgroups
local function make_subgroup(subgroup, group, order)
  local create
  if subgroup and group then
    create = {
      type = "item-subgroup",
      name = subgroup,
      group = group,
      order = order
    }
    BioInd.create_stuff(create)
  end
end

local function set_group_and_order(object, data)
  if object and data then
BioInd.show("Changing group and order of", object.name)
    local group, subgroup = data.group, data.subgroup
    local group_order, order = data.group_order, data.order

    if group and subgroup and not subgroups[subgroup] then
      make_subgroup(subgroup, group, group_order)
    end

    object.subgroup = subgroup or object.subgroup
BioInd.show("subgroup", object.subgroup)
    object.order = order or object.order
BioInd.show("order", object.order)
    BioInd.modified_msg("subgroup and order", object)
  end
end

------------------------------------------------------------------------------------
-- Group data
------------------------------------------------------------------------------------
local group_data = require("prototypes.mod_compatibility.final_fixes.group_data")

for mod_name, _ in pairs(group_data) do
  mod_name.items = mod_name.items or {}
  mod_name.recipes = mod_name.recipes or {}
end

if BI.Settings.BI_Wood_Products then
  ["boblogistics"] = {
    items = {
      [BI.additional_items.BI_Wood_Products.wood_pipe.name] = {group = "bob-logistics", subgroup = "pipe"},
      [BI.additional_items.BI_Wood_Products.wood_pipe_to_ground.name] = {
        group = "bob-logistics",
        subgroup = "pipe-to-ground"
      },
      [BI.additional_items.BI_Wood_Products.large_wooden_chest.name] = {order = "a[items]-g[bigchests]"},
      [BI.additional_items.BI_Wood_Products.huge_wooden_chest.name] = {order = "a[items]-h[bigchests]"},
      [BI.additional_items.BI_Wood_Products.giga_wooden_chest.name] = {order = "a[items]-i[bigchests]"},
    },
  },
  ["bobplates"] = {
    items = {
      [BI.additional_items.BI_Rubber.resin.name] = {
        subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
        order = "x[bi]-a[wood-production]-[products]-ba[resin]",
      },
    },
    recipes = {
      ["bob-resin-oil"] = {
        group = BI.default_item_group.bio_industries.name,
        subgroup = BI.default_item_subgroup.bio_farm_raw.name,
        order = "a[bi]-a-bc[resin]"
      },
      ["solid-fuel-from-hydrogen"] = {
        subgroup = "fluid-recipes",
        order = "b[fluid-chemistry]-h[solid-fuel-from-hydrogen]"
      },
      ["enriched-fuel-from-liquid-fuel"] = {
        subgroup = "fluid-recipes",
        order = "b[fluid-chemistry]-j[enriched-fuel-from-liquid-fuel]"
      },
      ["sulfur-2"] = {
        subgroup = "raw-material",
        order = "g[sulfur]-b[bobs]-2"
      },
      ["sulfur-3"] = {
        subgroup = "raw-material",
        order = "g[sulfur]-b[bobs]-3"
      },
    }
  },
  ["bobpower"] = {
    recipes = {
      [BI.additional_recipes.BI_Bio_Fuel.bio_boiler.name] = {subgroup = "bob-energy-boiler", order = "b[steam-power]-a[boiler-1bio]"},
    },
  },
  ["bobrevamp"] = {
    recipes = {
      ["solid-fuel-from-sour-gas"] = {
        subgroup = "fluid-recipes",
        --~ order = "b[fluid-chemistry]-i[solid-fuel-from-sour-gas]"
        order = "b[fluid-chemistry]-c[solid-fuel-from-sour-gas]"
      },
      ["enriched-fuel-from-hydrazine"] = {
        subgroup = "fluid-recipes",
        order = "b[fluid-chemistry]-k[enriched-fuel-from-hydrazine]"
      },
    },
  },
  ["angelspetrochem"] = {
    recipes = {
      [BI.additional_recipes.BI_Bio_Fuel.bio_sulfur.name] = {subgroup = "petrochem-sulfur"},
      [BI.additional_recipes.BI_Coal_Processing.solid_fuel.name] = {
        subgroup = "petrochem-fuel",
        order = "f[bi-solid-fuel]"
      },
      [BI.additional_recipes.BI_Wood_Gasification.solid_fuel.name]  = {
        subgroup = "petrochem-fuel",
        order = "g[solid-fuel-from-tar]"
      },
      ["enriched-fuel-from-liquid-fuel"] = {subgroup = "petrochem-fuel", order = "h[enriched-fuel-from-liquid-fuel]"},
      [BI.additional_recipes.BI_Bio_Fuel.bio_plastic_1.name] = {
        subgroup = "petrochem-solids",
        order = "a[plastic]-c"
      },
      [BI.additional_recipes.BI_Bio_Fuel.bio_plastic_2.name] = {
        subgroup = "petrochem-solids",
        order = "a[plastic]-d"
      },
      [BI.additional_recipes.BI_Rubber.resin_pulp.name] = {subgroup = "petrochem-solids", order = "b[resin]-c"},
      [BI.additional_recipes.BI_Rubber.resin_wood.name] = {subgroup = "petrochem-solids", order = "b[resin]-d"},
    },
  },
  ["angelsindustries"] = {
    items = {
      [BI.additional_items.BI_Bio_Fuel.bio_boiler.name] = {subgroup = "angels-power-steam", order = "aaa"},
      [BI.additional_items.BI_Wood_Products.big_pole.name] = {subgroup = "angels-power-poles", order = "a[small]-b"},
      [BI.additional_items.BI_Wood_Products.huge_pole.name] = {subgroup = "angels-power-poles", order = "a[small]-c"},
      [BI.additional_items.BI_Power_Production.huge_substation.name] = {
        subgroup = "angels-power-poles", order = "d[substation]-a[BI-huge-substation]"},

      [BI.additional_items.BI_Power_Production.solar_farm.name] = {
        subgroup = "angels-power-solar", order = "a[solar-panel]-a[BI-solar-farm]"},
      [BI.additional_items.BI_Power_Production.solar_mat.name] = {
        subgroup = "angels-power-solar", order = "a[solar-panel]-b[BI-solar-mat]"},
      [BI.additional_items.BI_Power_Production.solar_boiler.name] = {
        subgroup = "angels-power-solar", order = "a[solar-panel]-c[BI-solar-boiler]"},

      [BI.additional_items.BI_Power_Production.huge_accumulator.name] = {
        subgroup = "angels-power-solar", order = "b[accumulator]-a[BI-huge-accumulator]"},

      [BI.additional_items.BI_Wood_Products.large_wooden_chest.name] = {
        subgroup = "angels-chests-small-a", order = "a[chest]-c[bi1]"},
      [BI.additional_items.BI_Wood_Products.huge_wooden_chest.name] = {
        subgroup = "angels-chests-small-a", order = "a[chest]-c[bi2]"},
      [BI.additional_items.BI_Wood_Products.giga_wooden_chest.name] = {
        subgroup = "angels-chests-small-a", order = "a[chest]-c[bi3]"},

      [BI.additional_items.BI_Darts.dart_turret.name] = {
        subgroup = "defensive-structure", order = "aa[turret]-a[gun-turret]"},
      [BI.additional_items.Bio_Cannon.bio_cannon.name] = {
        subgroup = "defensive-structure", order = "b[turret]-d[artillery-turret]-[BI-bio-cannon]"},
    },
    recipes = {
      [BI.additional_recipes.BI_Bio_Fuel.bio_boiler.name] = {subgroup = "angels-power-steam", order = "aaa"},
      [BI.additional_recipes.BI_Wood_Products.big_pole.name] = {
        subgroup = "angels-power-poles", order = "a[small]-b"},
      [BI.additional_recipes.BI_Wood_Products.huge_pole.name] = {
        subgroup = "angels-power-poles", order = "a[small]-c"},
      [BI.additional_recipes.BI_Power_Production.huge_substation.name] = {
        subgroup = "angels-power-poles", order = "d[substation]-a[BI-huge-substation]"},

      [BI.additional_recipes.BI_Power_Production.solar_farm.name] = {
        subgroup = "angels-power-solar", order = "a[solar-panel]-a[BI-solar-farm]"},
      [BI.additional_recipes.BI_Power_Production.solar_mat.name] = {
        subgroup = "angels-power-solar", order = "a[solar-panel]-b[BI-solar-mat]"},
      [BI.additional_recipes.BI_Power_Production.solar_boiler.name] = {
        subgroup = "angels-power-solar", order = "a[solar-panel]-c[BI-solar-boiler]"},

      [BI.additional_recipes.BI_Power_Production.huge_accumulator.name] = {
        subgroup = "angels-power-solar", order = "b[accumulator]-a[BI-huge-accumulator]"},

      [BI.additional_recipes.BI_Wood_Products.large_wooden_chest.name] = {
        subgroup = "angels-chests-small-a", order = "a[chest]-c[bi1]"},
      [BI.additional_recipes.BI_Wood_Products.huge_wooden_chest.name] = {
        subgroup = "angels-chests-small-a", order = "a[chest]-c[bi2]"},
      [BI.additional_recipes.BI_Wood_Products.giga_wooden_chest.name] = {
        subgroup = "angels-chests-small-a", order = "a[chest]-c[bi3]"},

      [BI.additional_recipes.BI_Darts.dart_turret.name] = {
        subgroup = "defensive-structure", order = "aa[turret]-a[gun-turret]"},
      [BI.additional_recipes.Bio_Cannon.bio_cannon.name] = {
        subgroup = "defensive-structure", order = "b[turret]-d[artillery-turret]-[BI-bio-cannon]"},

      [BI.additional_recipes.BI_Rubber.rubber_mat.name] = {
        subgroup = "defensive-structure", order = "a-a[stone-wall]-a[bi-rubber-mat]"},

      [BI.additional_recipes.BI_Bio_Fuel.bio_battery.name] = {subgroup = "angels-batteries", order = "aa"},
      [BI.additional_recipes.mod_compatibility.press_wood.name] = {subgroup = "angels-board", order = "z[bob]-aa"},
      ["empty-nuclear-fuel-cell"] = {subgroup = "angels-power-nuclear-fuel-cell", order = "a[uranium]-1a"},
    },
  },
  ["angelsexploration"] = {
    items = {
      [BI.additional_entities.BI_Darts.dart_rifle.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "a[gun]-a[BI-darts]"},
      [BI.additional_items.BI_Darts.dart_turret.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "b[turret]-a[BI-darts]"},

      [BI.additional_entities.BI_Darts.dart_magazine_basic.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-a[BI-basic-darts]"},
      [BI.additional_entities.BI_Darts.dart_magazine_standard.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-b[BI-standard-darts]"},
      [BI.additional_entities.BI_Darts.dart_magazine_enhanced.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-c[BI-enhanced-darts]"},
      [BI.additional_entities.BI_Darts.dart_magazine_poison.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-d[BI-poison-darts]"},


      [BI.additional_items.Bio_Cannon.bio_cannon.name] = {
        group = "angels-exploration", group_order = "f-1a",
        subgroup = "angels-prototype-artillery", order = "b[turret]-d[artillery-turret]-[BI-bio-cannon]"},

      [BI.additional_recipes.BI_Rubber.rubber_mat.name] = {
        subgroup = "angels-exploration-walls", order = "a[BI]-a[rubber-mat]"},
      [BI.additional_items.BI_Darts.wooden_fence.name] = {
        subgroup = "angels-exploration-walls", order = "a[BI]-b[wooden-fence]"},

    },
    recipes = {
      [BI.additional_recipes.BI_Darts.dart_rifle.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "a[gun]-a[BI-darts]"},
      [BI.additional_recipes.BI_Darts.dart_turret.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "b[turret]-a[BI-darts]"},

      [BI.additional_recipes.BI_Darts.dart_magazine_basic.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-a[BI-basic-darts]"},
      [BI.additional_recipes.BI_Darts.dart_magazine_standard.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-b[BI-standard-darts]"},
      [BI.additional_recipes.BI_Darts.dart_magazine_enhanced.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-c[BI-enhanced-darts]"},
      [BI.additional_recipes.BI_Darts.dart_magazine_poison.name] = {
        group = "angels-exploration", group_order = "a-a",
        subgroup = "angels-physical-a", order = "c[ammo]-d[BI-poison-darts]"},


      [BI.additional_recipes.Bio_Cannon.bio_cannon.name] = {
        group = "angels-exploration", group_order = "f-1a",
        subgroup = "angels-prototype-artillery", order = "b[turret]-d[artillery-turret]-[BI-bio-cannon]"},

      [BI.additional_recipes.BI_Rubber.rubber_mat.name] = {
        subgroup = "angels-exploration-walls", order = "a[BI]-a[rubber-mat]"},
      [BI.additional_recipes.BI_Darts.wooden_fence.name] = {
        subgroup = "angels-exploration-walls", order = "a[BI]-b[wooden-fence]"},
    }
  },
  ["Krastorio2"] = {
    items = {
      [BI.additional_items.BI_Wood_Products.huge_wooden_chest.name] = {order = "a[items]-db[hugechest]"},
      [BI.additional_items.BI_Power_Production.huge_substation.name] = {order = "a[energy]-f[huge-substation]"},
      [BI.additional_items.BI_Darts.wooden_fence.name] = {
        subgroup = "defensive-structure",
        order = "a[wooden-fence]"
      },
      ["stone-wall"] = {subgroup = "defensive-structure", order = "a[wooden-fence]"},
      ["gate"] = {subgroup = "defensive-structure", order = "c[gate]"},
      [BI.additional_items.BI_Rubber.rubber_mat.name] = {subgroup = "defensive-structure", order = "d[rubber-mat]"},
      [BI.additional_items.BI_Darts.dart_turret.name] =  {subgroup = "vanilla-turrets", order = "004[dart-turret]"},
      [BI.additional_items.Bio_Cannon.bio_cannon.name] = {
        subgroup = "vanilla-turrets",
        order = "04a[prototype-artillery]"
      },
      ["artillery-targeting-remote"] = {subgroup = "vanilla-turrets", order = "04b[artillery-targeting-remote]"},
    },
    recipes = {
      ["kr-grow-wood-plus"] = {order = "ab[wood]"},
    },
  },
  ["IndustrialRevolution"] = {
    items = {
      [BI.additional_items.BI_Darts.wooden_fence.name] = {subgroup = "ir2-walls", order = "c1"},
    },
    recipes = {
      [BI.additional_recipes.BI_Bio_Fuel.bio_battery.name] = {subgroup = "ir2-vessels", order = "bab"},
      [BI.additional_recipes.BI_Bio_Fuel.bio_plastic_1.name] = {subgroup = "fluid-recipes", order = "zzza1"},
      [BI.additional_recipes.BI_Bio_Fuel.bio_plastic_2.name] = {subgroup = "fluid-recipes", order = "zzza2"},
      [BI.additional_recipes.BI_Coal_Processing.solid_fuel.name] = {subgroup = "ir2-fuels", order = "c1"},
      [BI.additional_recipes.BI_Wood_Gasification.solid_fuel.name] = {subgroup = "ir2-fuels", order = "c2"},
      [BI.additional_recipes.BI_Bio_Fuel.bio_sulfur.name] = {subgroup = "fluid-recipes", order = "z1-la-zz"},
    }
  }
}

for mod_name, mod_data in pairs(group_data) do
  if mods[mod_name] then
BioInd.show("Changing groups/order on account of mod", mod_name)
    -- Items
    for item_name, item_data in pairs(mod_data.items or {}) do
      item_type = thxbob.lib.item.get_type(item_name)
      item = item_type and data.raw[item_type][item_name]

      if item then
BioInd.show("Changing group and order of", item.name)
        --~ group, subgroup = item_data.group, item_data.subgroup
        --~ group_order, order = item_data.group_order, item_data.order

        --~ if group and subgroup and not subgroups[subgroup] then
          --~ make_subgroup(subgroup, group, group_order)
        --~ end

        --~ item.subgroup = subgroup or item.subgroup
--~ BioInd.show("item.subgroup", item.subgroup)
        --~ item.order = order or item.order
--~ BioInd.show("item.order", item.order)
        --~ BioInd.modified_msg("subgroup and order", item)
        set_group_and_order(item, item_data)
      end
    end

    -- Recipes
    for recipe_name, recipe_data in pairs(mod_data.recipes or {}) do
      recipe = recipes[recipe_name]
      if recipe then
--~ BioInd.show("Changing group and order of", recipe.name)
        --~ group, subgroup = recipe_data.group, recipe_data.subgroup
        --~ group_order, order = recipe_data.group_order, recipe_data.order

        --~ if group and subgroup and not subgroups[subgroup] then
          --~ make_subgroup(subgroup, group, group_order)
        --~ end

        --~ recipe.subgroup = subgroup or recipe.subgroup
--~ BioInd.show("recipe.subgroup", recipe.subgroup)
        --~ recipe.order = order or recipe.order
--~ BioInd.show("recipe.order", recipe.order)
        --~ BioInd.modified_msg("subgroup and order", recipe)
        set_group_and_order(recipe, recipe_data)
      end
    end
  end
end

BioInd.show("item-subgroups:", subgroups)
--~ change_sub("boblogistics", "bi-wood-pipe", "pipe")
--~ change_sub("boblogistics", "bi-wood-pipe-to-ground", "pipe-to-ground")
--~ change_sub("boblogistics", "bi-wooden-chest-large", "", "a[items]-g[bigchests]")
--~ change_sub("boblogistics", "bi-wooden-chest-huge", "", "a[items]-h[bigchests]")
--~ change_sub("boblogistics", "bi-wooden-chest-giga", "", "a[items]-i[bigchests]")

--~ change_sub("bobplates", "bob-resin-oil", "bio-bio-farm-raw", "a[bi]-a-bc[resin]")
--~ change_sub("bobplates", "solid-fuel-from-hydrogen", "fluid-recipes", "b[fluid-chemistry]-h[solid-fuel-from-hydrogen]")
--~ change_sub("bobplates", "enriched-fuel-from-liquid-fuel", "fluid-recipes", "b[fluid-chemistry]-j[enriched-fuel-from-liquid-fuel]")
--~ change_sub("bobplates", "sulfur-2", "raw-material", "g[sulfur]-b[bobs]-2")
--~ change_sub("bobplates", "sulfur-3", "raw-material", "g[sulfur]-b[bobs]-3")

--~ change_sub("bobpower", "bi-bio-boiler", "bob-energy-boiler", "b[steam-power]-a[boiler-1bio]")

--~ change_sub("bobrevamp", "solid-fuel-from-sour-gas", "fluid-recipes", "b[fluid-chemistry]-i[solid-fuel-from-sour-gas]")
--~ change_sub("bobrevamp", "enriched-fuel-from-hydrazine", "fluid-recipes", "b[fluid-chemistry]-k[enriched-fuel-from-hydrazine]")

--~ change_sub("angelspetrochem", "bi-sulfur", "petrochem-sulfur")
--~ change_sub("angelspetrochem", "bi-solid-fuel", "petrochem-fuel", "f[bi-solid-fuel]")
--~ change_sub("angelspetrochem", "solid-fuel-from-tar", "petrochem-fuel", "g[solid-fuel-from-tar]")
--~ change_sub("angelspetrochem", "enriched-fuel-from-liquid-fuel", "petrochem-fuel", "h[enriched-fuel-from-liquid-fuel]")
--~ change_sub("angelspetrochem", "bi-plastic-1", "petrochem-solids", "a[plastic]-c")
--~ change_sub("angelspetrochem", "bi-plastic-2", "petrochem-solids", "a[plastic]-d")
--~ change_sub("angelspetrochem", "bi-resin-pulp", "petrochem-solids", "b[resin]-c")
--~ change_sub("angelspetrochem", "bi-resin-wood", "petrochem-solids", "b[resin]-d")

--~ change_sub("angelsindustries", "bi-bio-boiler", "angels-power-steam-boiler", "aaa")
--~ change_sub("angelsindustries", "bi-wooden-pole-big", "angels-power-poles", "a[small]-b")
--~ change_sub("angelsindustries", "bi-wooden-pole-huge", "angels-power-poles", "a[small]-c")
--~ change_sub("angelsindustries", "bi-battery", "angels-batteries", "aa")
--~ change_sub("angelsindustries", "bi-press-wood", "angels-board", "z[bob]-aa")
--~ change_sub("angelsindustries", "empty-nuclear-fuel-cell", "angels-power-nuclear-fuel-cell", "a[uranium]-1a")
--~ change_sub("angelsindustries", "bi-wooden-chest-large", "angels-chests-small-a", "a[chest]-c[bi1]")
--~ change_sub("angelsindustries", "bi-wooden-chest-huge", "angels-chests-small-a", "a[chest]-c[bi2]")
--~ change_sub("angelsindustries", "bi-wooden-chest-giga", "angels-chests-small-a", "a[chest]-c[bi3]")

--~ change_sub("Krastorio2", "bi-wooden-chest-huge", "", "a[items]-db[hugechest]")
--~ change_sub("Krastorio2", "bi-huge-substation", "", "a[energy]-f[huge-substation]")
--~ change_sub("Krastorio2", "kr-grow-wood-plus", "", "ab[wood]")
--~ change_sub("Krastorio2", "bi-wooden-fence", "defensive-structure", "a[wooden-fence]")
--~ change_sub("Krastorio2", "stone-wall", "defensive-structure", "a[wooden-fence]")
--~ change_sub("Krastorio2", "gate", "defensive-structure", "c[gate]")
--~ change_sub("Krastorio2", "bi-rubber-mat", "defensive-structure", "d[rubber-mat]")
--~ change_sub("Krastorio2", "bi-dart-turret", "vanilla-turrets", "004[dart-turret]")
--~ change_sub("Krastorio2", "bi-bio-cannon", "vanilla-turrets", "04a[prototype-artillery]")
--~ change_sub("Krastorio2", "artillery-targeting-remote", "vanilla-turrets", "04b[artillery-targeting-remote]")

--~ change_sub("IndustrialRevolution", "bi-wooden-fence", "ir2-walls", "c1")
--~ change_sub("IndustrialRevolution", "bi-battery", "ir2-vessels", "bab")
--~ change_sub("IndustrialRevolution", "bi-plastic-1", "fluid-recipes", "zzza1")
--~ change_sub("IndustrialRevolution", "bi-plastic-2", "fluid-recipes", "zzza2")
--~ change_sub("IndustrialRevolution", "bi-solid-fuel", "ir2-fuels", "c1")
--~ change_sub("IndustrialRevolution", "solid-fuel-from-tar", "ir2-fuels", "c2")
--~ change_sub("IndustrialRevolution", "bi-sulfur", "fluid-recipes", "z1-la-zz")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
