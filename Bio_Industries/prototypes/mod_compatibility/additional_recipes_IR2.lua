

------------------------------------------------------------------------------------
--                               Bio farming recipes                              --
------------------------------------------------------------------------------------
-- Seeds from water
BI.default_recipes.seed_1 = {
  type = "recipe",
  name = "bi-seed-1",
  --~ localised_name = {"recipe-name.bi-seed-1"},
  localised_name = {"recipe-name.bi-seed"},
  localised_description = {"recipe-description.bi-seed", {"fluid-name.water"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  --~ localised_name = {"recipe-name.bi-seed-2"},
  localised_name = {"recipe-name.bi-seed-using", {"item-name.bi-ash"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  --~ localised_name = {"recipe-name.bi-seed-3"},
  localised_name = {"recipe-name.bi-seed-using", {"item-name.fertilizer"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  --~ localised_name = {"recipe-name.bi-seed-4"},
  localised_name = {"recipe-name.bi-seed-using", {"item-name.bi-adv-fertilizer"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  --~ localised_name = {"recipe-name.bi-seedling-1"},
  localised_name = {"recipe-name.bi-seedling"},
  localised_description = {"recipe-description.bi-seedling", {"fluid-name.water"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  --~ localised_name = {"recipe-name.bi-seedling-2"},
  localised_name = {"recipe-name.bi-seedling-using", {"item-name.bi-ash"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  --~ localised_name = {"recipe-name.bi-seedling-3"},
  localised_name = {"recipe-name.bi-seedling-using", {"item-name.fertilizer"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  --~ localised_name = {"recipe-name.bi-seedling-4"},
  localised_name = {"recipe-name.bi-seedling-using", {"item-name.bi-adv-fertilizer"}},
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
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
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
  localised_name = {"recipe-name.bi-logs-using", {"item-name.bi-ash"}},
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
  localised_name = {"recipe-name.bi-logs-using", {"item-name.fertilizer"}},
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
  localised_name = {"recipe-name.bi-logs-using", {"item-name.bi-adv-fertilizer"}},
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
