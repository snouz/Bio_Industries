BioInd.entered_file()

BI.default_recipes = BI.default_recipes or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
--                                 Timber recipes                                 --
------------------------------------------------------------------------------------
-- Raw wood from water
BI.default_recipes.logs_1 = {
  type = "recipe",
  name = "bi-logs-1",
  icon = ICONPATH .. "wood_woodpulp.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-farm",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 400,
  ingredients = {
    {type = "item", name = "seedling", amount = 20},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "wood", amount = 40},
    {type = "item", name = "bi-woodpulp", amount = 80},
  },
  main_product = "",
  subgroup = "bio-bio-farm-fluid-3",
  order = "c[bi]-ssw-c1[raw-wood1]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-timber"},
  allow_as_intermediate = false,
}

-- Woodpulp
BI.default_recipes.woodpulp = {
  type = "recipe",
  name = "bi-woodpulp",
  icon = ICONPATH .. "woodpulp.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-bio-farm-raw",
  order = "a[bi]-a-a[bi-1-woodpulp]",
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  energy_required = 1,
  ingredients = {{"wood", 1}},
  result = "bi-woodpulp",
  result_count = 2,
  allow_as_intermediate = true,       -- Added for 0.18.34/1.1.4
  allow_intermediates = true,         -- Added for 0.18.35/1.1.5
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = false,        -- Added for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-timber"},
}

-- Wood fuel brick
BI.default_recipes.wood_fuel_brick = {
  type = "recipe",
  name = "bi-wood-fuel-brick",
  --~ --  localised_name = {"item-name.wood-bricks"},
  --~ --  localised_description = {"item-description.wood-bricks"},
  icon = ICONPATH .. "fuel_brick.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "bio-bio-farm-raw",
  order = "a[bi]-a-bx[bi-4-woodbrick]",
  energy_required = 2,
  ingredients = {{"bi-woodpulp", 24}},
  result = "wood-bricks",
  result_count = 1,
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ --  BI_add_to_tech = {"bi-tech-coal-processing-1"},
  BI_add_to_tech = {"bi-tech-timber"},
}


------------------------------------------------------------------------------------
--                               Bio farming recipes                              --
------------------------------------------------------------------------------------
-- Seeds from water
BI.default_recipes.seed_1 = {
  type = "recipe",
  name = "bi-seed-1",
  localised_name = {"recipe-name.bi-seed-1"},
  icon = ICONPATH .. "tree_seed.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 200,
  ingredients = {
    {type = "fluid", name = "water", amount = 100},
    {type = "item", name = "wood", amount = 20},
  },
  results = {
    {type = "item", name = "bi-seed", amount = 40},
  },
  enabled = false,
  show_amount_in_title = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "bio-bio-farm-fluid-1",
  order = "a[bi]-ssw-a1[bi-seed-1]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-1"},
}

-- Seeds from water & ash
BI.default_recipes.seed_2 = {
  type = "recipe",
  name = "bi-seed-2",
  localised_name = {"recipe-name.bi-seed-2"},
  icon = ICONPATH .. "tree_seed_ash.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 150,
  ingredients = {
    {type = "fluid", name = "water", amount = 40},
    {type = "item", name = "wood", amount = 20},
    {type = "item", name = "bi-ash", amount = 10},
  },
  results = {
    {type = "item", name = "bi-seed", amount = 50},
  },
  show_amount_in_title = false,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "bio-bio-farm-fluid-1",
  order = "a[bi]-ssw-a1[bi-seed-2]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-2"},
  allow_as_intermediate = false,
}

-- Seeds from water & fertilizer
BI.default_recipes.seed_3 = {
  type = "recipe",
  name = "bi-seed-3",
  localised_name = {"recipe-name.bi-seed-3"},
  icon = ICONPATH .. "tree_seed_fert1.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 100,
  ingredients = {
    {type = "fluid", name = "water", amount = 40},
    {type = "item", name = "wood", amount = 20},
    {type = "item", name = "fertilizer", amount = 10},
  },
  results = {
    {type = "item", name = "bi-seed", amount = 60},
  },
  show_amount_in_title = false,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "bio-bio-farm-fluid-1",
  order = "a[bi]-ssw-a1[bi-seed-3]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-3"},
  allow_as_intermediate = false,
  crafting_machine_tint = {
    primary = { r = 0.43, g = 0.73, b = 0.37, a = 0.60},
    secondary = { r = 0, g = 0, b = 0, a = 0},
    tertiary = {r = 0, g = 0, b = 0, a = 0},
    quaternary = {r = 0, g = 0, b = 0, a = 0}
  },
}

-- Seeds from water & advanced fertilizer
BI.default_recipes.seed_4 = {
  type = "recipe",
  name = "bi-seed-4",
  localised_name = {"recipe-name.bi-seed-4"},
  icon = ICONPATH .. "tree_seed_fert2.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 50,
  ingredients = {
    {type = "item", name = "wood", amount = 20},
    {type = "item", name = "bi-adv-fertilizer", amount = 10},
    {type = "fluid", name = "water", amount = 40},
  },
  results = {
    {type = "item", name = "bi-seed", amount = 80},
  },
  show_amount_in_title = false,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "bio-bio-farm-fluid-1",
  order = "a[bi]-ssw-a1[bi-seed-4]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-4"},
  allow_as_intermediate = false,
  crafting_machine_tint = {
    primary = { r = 0.73, g = 0.37, b = 0.52, a = 0.60},
    secondary = {r = 0, g = 0, b = 0, a = 0},
    tertiary = {r = 0, g = 0, b = 0, a = 0},
    quaternary = {r = 0, g = 0, b = 0, a = 0}
  },
}


-- Seedlings from water
BI.default_recipes.seedling_1 = {
  type = "recipe",
  name = "bi-seedling-1",
  localised_name = {"recipe-name.bi-seedling-1"},
  icon = ICONPATH .. "seedling.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 400,
  ingredients = {
    {type = "item", name = "bi-seed", amount = 20},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "seedling", amount = 40},
  },
  enabled = false,
  show_amount_in_title = false,
  always_show_made_in = true,
  allow_decomposition = true,
  subgroup = "bio-bio-farm-fluid-1",
  order = "b[bi]-ssw-b1[bi-Seedling-1]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-1"},
}

-- Seedlings from water & ash
BI.default_recipes.seedling_2 = {
  type = "recipe",
  name = "bi-seedling-2",
  localised_name = {"recipe-name.bi-seedling-2"},
  icon = ICONPATH .. "seedling_ash.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 300,
  ingredients = {
    {type = "item", name = "bi-seed", amount = 25},
    {type = "item", name = "bi-ash", amount = 10},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "seedling", amount = 60},
  },
  show_amount_in_title = false,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "bio-bio-farm-fluid-1",
  order = "b[bi]-ssw-b1[bi-Seedling-2]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-2"},
  allow_as_intermediate = false,
}

-- Seedlings from water & fertilizer
BI.default_recipes.seedling_3 = {
  type = "recipe",
  name = "bi-seedling-3",
  localised_name = {"recipe-name.bi-seedling-3"},
  icon = ICONPATH .. "seedling_fert1.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 200,
  ingredients = {
    {type = "item", name = "bi-seed", amount = 30},
    {type = "item", name = "fertilizer", amount = 10},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "seedling", amount = 90},
  },
  show_amount_in_title = false,
  enabled = false,
  always_show_made_in = true,
  subgroup = "bio-bio-farm-fluid-1",
  order = "b[bi]-ssw-b1[bi-Seedling-3]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-3"},
  allow_as_intermediate = false,
  crafting_machine_tint = {
    primary = {r = 0.43, g = 0.73, b = 0.37, a = 0.60},
    secondary = {r = 0, g = 0, b = 0, a = 0},
    tertiary = {r = 0, g = 0, b = 0, a = 0},
    quaternary = {r = 0, g = 0, b = 0, a = 0}
  },
}

-- Seedlings from water & advanced fertilizer
BI.default_recipes.seedling_4 = {
  type = "recipe",
  name = "bi-seedling-4",
  localised_name = {"recipe-name.bi-seedling-4"},
  icon = ICONPATH .. "seedling_fert2.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-greenhouse",
  energy_required = 100,
  ingredients = {
    {type = "item", name = "bi-seed", amount = 40},
    {type = "fluid", name = "water", amount = 100},
    {type = "item", name = "bi-adv-fertilizer", amount = 10},
  },
  results = {
    {type = "item", name = "seedling", amount = 160},
  },
  show_amount_in_title = false,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "bio-bio-farm-fluid-1",
  order = "b[bi]-ssw-b1[bi-Seedling-4]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-4"},
  allow_as_intermediate = false,
  crafting_machine_tint = {
    primary = {r = 0.73, g = 0.37, b = 0.52, a = 0.60},
    secondary = {r = 0 , g = 0, b = 0, a = 0},
    tertiary = {r = 0, g = 0, b = 0, a = 0},
    quaternary = {r = 0, g = 0, b = 0, a = 0}
  },
}

--- Raw wood from water & ash
BI.default_recipes.logs_2 = {
  type = "recipe",
  name = "bi-logs-2",
  icon = ICONPATH .. "wood_woodpulp_ash.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-farm",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 360,
  ingredients = {
    {type = "item", name = "seedling", amount = 30},
    {type = "item", name = "bi-ash", amount = 10},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "wood", amount = 75},
    {type = "item", name = "bi-woodpulp", amount = 150},
  },
  main_product = "",
  subgroup = "bio-bio-farm-fluid-3",
  order = "c[bi]-ssw-c1[raw-wood2]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-2"},
  allow_as_intermediate = false,
}

--- Raw wood from water & fertilizer
BI.default_recipes.logs_3 = {
  type = "recipe",
  name = "bi-logs-3",
  icon = ICONPATH .. "wood_woodpulp_fert1.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-farm",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 300,
  ingredients = {
    {type = "item", name = "seedling", amount = 45},
    {type = "item", name = "fertilizer", amount = 10},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "wood", amount = 135},
    {type = "item", name = "bi-woodpulp", amount = 270},
  },
  main_product = "",
  subgroup = "bio-bio-farm-fluid-3",
  order = "c[bi]-ssw-c1[raw-wood3]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-3"},
  allow_as_intermediate = false,
  crafting_machine_tint = {
    primary = {r = 0.43, g = 0.73, b = 0.37, a = 0.60},
    secondary = {r = 0, g = 0, b = 0, a = 0},
    tertiary = {r = 0, g = 0, b = 0, a = 0},
    quaternary = {r = 0, g = 0, b = 0, a = 0}
  },
}

--- Raw wood from advanced fertilizer
BI.default_recipes.logs_4 = {
  type = "recipe",
  name = "bi-logs-4",
  icon = ICONPATH .. "wood_woodpulp_fert2.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-farm",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 100,
  ingredients = {
    {type = "item", name = "seedling", amount = 40},
    {type = "fluid", name = "water", amount = 100},
    {type = "item", name = "bi-adv-fertilizer", amount = 5},
  },
  results = {
    {type = "item", name = "wood", amount = 160},
    {type = "item", name = "bi-woodpulp", amount = 320},
  },
  main_product = "",
  subgroup = "bio-bio-farm-fluid-3",
  order = "c[bi]-ssw-c1[raw-wood4]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-4"},
  allow_as_intermediate = false,
  crafting_machine_tint = {
    primary = {r = 0.73, g = 0.37, b = 0.52, a = 0.60},
    secondary = {r = 0, g = 0, b = 0, a = 0},
    tertiary = {r = 0, g =0 , b = 0, a = 0},
    quaternary = {r = 0, g = 0, b = 0, a = 0}
  },
}


------------------------------------------------------------------------------------
--                                   Ash recipes                                  --
------------------------------------------------------------------------------------
-- Ash from woodpulp
BI.default_recipes.ash_1 = {
  type = "recipe",
  name = "bi-ash-1",
  icon = ICONPATH .. "ash_woodpulp.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-smelting",
  subgroup = "bio-cokery",
  order = "a[bi]-a-c[bi-5-ash-1]",
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4

  energy_required = 0.4,
  ingredients = {{"bi-woodpulp", 2}},
  result = "bi-ash",
  result_count = 1,
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-ash"},
  allow_as_intermediate = false,
}

-- Ash from wood
BI.default_recipes.ash_2 = {
  type = "recipe",
  name = "bi-ash-2",
  icon = ICONPATH .. "ash_raw-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-smelting",
  subgroup = "bio-cokery",
  order = "a[bi]-a-c[bi-5-ash-2]",
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  energy_required = 0.6,
  ingredients = {{"wood", 1}},
  result = "bi-ash",
  result_count = 1,
  allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-ash"},
}


------------------------------------------------------------------------------------
--                                 Biomass recipes                                --
------------------------------------------------------------------------------------
-- Biomass (basic)
BI.default_recipes.biomass_1 = {
  type = "recipe",
  name = "bi-biomass-1",
  localised_name = {"recipe-name.bi-biomass-1"},
  localised_description = {"recipe-description.bi-biomass-1"},
  icon = ICONPATH .. "fluid_biomass.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "biofarm-mod-bioreactor",
  energy_required = 10,
  ingredients = {
    {type = "fluid", name = "water", amount = 100},
    {type = "item", name = "fertilizer", amount = 10},
  },
  results = {
    {type = "fluid", name = "bi-biomass", amount = 50},
  },
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = true,
  subgroup = "bio-bio-fuel-fluid",
  order = "x[oil-processing]-z1[bi-biomass]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-biomass"},
}


------------------------------------------------------------------------------------
--                               Fertilizer recipes                               --
------------------------------------------------------------------------------------
-- Fertilizer from sulfur
BI.default_recipes.fertilizer_1 = {
  type = "recipe",
  name = "bi-fertilizer-1",
  icon = ICONPATH .. "fertilizer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "item", name = "sulfur", amount = 1},
    {type = "fluid", name = "nitrogen", amount = 10},
    {type = "item", name = "bi-ash", amount = 10}
  },
  results = {
    {type = "item", name = "fertilizer", amount = 5}
  },
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,         -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "bio-bio-farm-intermediate-product",
  order = "b[bi-fertilizer]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-fertilizer"},
}


------------------------------------------------------------------------------------
--                           Advanced fertilizer recipes                          --
------------------------------------------------------------------------------------
-- Fertilizer from sulfur
BI.default_recipes.fertilizer_1 = {
  type = "recipe",
  name = "bi-fertilizer-1",
  icon = ICONPATH .. "fertilizer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "item", name = "sulfur", amount = 1},
    {type = "fluid", name = "nitrogen", amount = 10},
    {type = "item", name = "bi-ash", amount = 10}
  },
  results = {
    {type = "item", name = "fertilizer", amount = 5}
  },
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,         -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "bio-bio-farm-intermediate-product",
  order = "b[bi-fertilizer]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-fertilizer"},
}


-- Advanced fertilizer 2
BI.default_recipes.adv_fertilizer_2 = {
  type = "recipe",
  name = "bi-adv-fertilizer-2",
  icon = ICONPATH .. "fertilizer_advanced.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 50,
  ingredients = {
    {type = "item", name = "fertilizer", amount = 20},
    {type = "fluid", name = "bi-biomass", amount = 10},
    {type = "item", name = "bi-woodpulp", amount = 10},
  },
  results = {
    {type = "item", name = "bi-adv-fertilizer", amount = 20}
  },
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,         -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "bio-bio-farm-intermediate-product",
  order = "b[bi-fertilizer]-b[bi-adv-fertilizer-2]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-advanced-fertilizers"},
}


------------------------------------------------------------------------------------
--                                 Create recipes                                 --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_recipes)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
