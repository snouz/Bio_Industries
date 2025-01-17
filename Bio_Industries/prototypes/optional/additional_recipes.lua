------------------------------------------------------------------------------------
--                   Data for recipes that depend on a setting.                   --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

BI.additional_recipes = BI.additional_recipes or {}

local settings = {
  "BI_Bio_Fuel",
  "BI_Bio_Garden",
  "BI_Coal_Processing",
  "BI_Darts",
  "BI_Disassemble",
  "BI_Explosive_Planting",
  "BI_Rails",
  "BI_Rubber",
  "BI_Pollution_Detector",
  "BI_Power_Production",
  "BI_Stone_Crushing",
  "BI_Terraforming",
  "BI_Wood_Gasification",
  "BI_Wood_Products",
  "Bio_Cannon",
  "BI_Game_Tweaks_Production_Science",
}
for s, setting in pairs(settings) do
  BI.additional_recipes[setting] = BI.additional_recipes[setting] or {}
end

--~ local triggers = {
  --~ "BI_Trigger_Easy_Bio_Gardens",
  --~ "BI_Trigger_Sand",
--~ }
--~ for t, trigger in pairs(triggers) do
  --~ BI.additional_recipes[trigger] = BI.additional_recipes[trigger] or {}
--~ end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Enable additional technology trees                       --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
-- Bio boiler
BI.additional_recipes.BI_Bio_Fuel.bio_boiler = {
  type = "recipe",
  name = "bi-bio-boiler",
  localised_name = {"entity-name.bi-bio-boiler"},
  --~ localised_description = {"entity-description.bi-bio-boiler"},
  --localised_description = {""},
  icon = ICONPATH .. "entity/bio_boiler.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    energy_required = 10,
    ingredients = {
      {"boiler", 4},
      {"pipe", 5},
      {"steel-plate", 5},
      {"concrete", 8},
    },
    result = "bi-bio-boiler",
    result_count = 1,
    allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
    always_show_made_in = false,    -- Added for 0.18.34/1.1.4
    allow_decomposition = true,     -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 15,
    ingredients = {
      {"boiler", 4},
      {"pipe", 10},
      {"steel-plate", 10},
      {"concrete", 12},
    },
    result = "bi-bio-boiler",
    result_count = 1,
    allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
    always_show_made_in = false,    -- Added for 0.18.34/1.1.4
    allow_decomposition = true,     -- Added for 0.18.34/1.1.4
  },
  allow_as_intermediate = false,    -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,       -- Changed for 0.18.34/1.1.4
  --~ -- subgroup = "bio-energy-boiler",
  subgroup = "energy",              -- Changed for 0.18.34/1.1.4
  --~ -- order = "b-[steam-power]-a[boiler]-a[bi-bio-boiler]"      -- Changed for 0.18.34/1.1.4
  --order = "b[steam-power]-a[boiler-bio]",
  order = "b[steam-power]-a[cboiler2-bio]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-boiler"},
}

-- Basic petroleum-gas processing
BI.additional_recipes.BI_Bio_Fuel.basic_gas_processing = {
  type = "recipe",
  name = "bi-basic-gas-processing",
  --icon = ICONPATH .. "basic_gas_processing.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  category = "chemistry",
  enabled = false,
  energy_required = 5,
  ingredients = {
    {type = "item", name = "coal", amount = 20},
    {type = "item", name = "resin", amount = 10},
    {type = "fluid", name ="steam", amount = 50}
  },
  results = {
    --~ -- {type = "fluid", name = "petroleum-gas", amount = 15, fluidbox_index = 3},
    {type = "fluid", name = "petroleum-gas", amount = 15},
    {type = "item", name = "bi-ash", amount = 15}
  },
  subgroup = "bio-bio-fuel-other",
  order = "[bi-basic-gas-processing]",
  main_product = "",
  allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
  always_show_made_in = true,       -- Added for 0.18.34/1.1.4
  allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-2"},
  crafting_machine_tint = {
    primary     = util.color("ffffff"),
    secondary   = util.color("ffffff"),
    tertiary    = util.color("ffffff"),
    quaternary  = util.color("5d8e3c")
  },
}

-- Cellulose 1
BI.additional_recipes.BI_Bio_Fuel.cellulose_1 = {
  type = "recipe",
  name = "bi-cellulose-1",
  --localised_name = {"recipe-name.bi-cellulose-1"},
  localised_description = {
    "recipe-description.bi-cellulose-1",
    {"fluid-name.sulfuric-acid"}
  },
  icon = ICONPATH .. "cellulose.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 20,
  ingredients = {
    {type = "item", name = "bi-woodpulp", amount = 10},
    {type = "fluid", name = "sulfuric-acid", amount = 10},
  },
  results= {
    {type = "item", name = "bi-cellulose", amount = 10 }
  },
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = BI.default_item_subgroup.bio_farm_raw.name,
  order = "z[bi-cellulose-1]",
  --~ -- subgroup = "intermediate-product",
  --~ -- order = "b[cellulose-1]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-cellulose-1"},
  crafting_machine_tint = {
    primary     = util.color("d1c73b"),
    secondary   = util.color("bdb057"),
    tertiary    = util.color("dec864"),
    quaternary  = util.color("bdbc55")
  },
}

-- Cellulose 2
BI.additional_recipes.BI_Bio_Fuel.cellulose_2 = {
  type = "recipe",
  name = "bi-cellulose-2",
  --localised_name = {"recipe-name.bi-cellulose-2"},
  localised_description = {"recipe-description.bi-cellulose-2"},
  --icon = ICONPATH .. "cellulose_steam.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --icons = {
  --  { icon = ICONPATH .. "cellulose.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  --  { icon = "__base__/graphics/icons/fluid/steam.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {17, -15} },
  --},
  icons = BioInd.make_icons({it1 = "bi-cellulose", it2 = "steam"}),
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "fluid", name = "steam", amount = 10},
    {type = "item", name = "bi-woodpulp", amount = 10},
    {type = "fluid", name = "sulfuric-acid", amount = 20},
  },
  results = {
    {type = "item", name = "bi-cellulose", amount = 10 }
  },
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = BI.default_item_subgroup.bio_farm_raw.name,
  order = "z[bi-cellulose-2]",
  --~ -- subgroup = "intermediate-product",
  --~ -- order = "b[cellulose-2]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-cellulose-2"},
  crafting_machine_tint = {
    primary     = util.color("d1c73b"),
    secondary   = util.color("bdb057"),
    tertiary    = util.color("dec864"),
    quaternary  = util.color("bdbc55")
  },
}

-- Bio plastic 1
BI.additional_recipes.BI_Bio_Fuel.bio_plastic_1 = {
  type = "recipe",
  name = "bi-plastic-1",
  localised_name = {"recipe-name.bi-plastic", {"item-name.bi-woodpulp"}},
  localised_description = {"recipe-description.bi-plastic-1"},
  --icon = ICONPATH .. "bio_plastic_bar_1.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/plastic-bar.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/wood.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {17, -15} },
    { icon = "__base__/graphics/icons/fluid/light-oil.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {-19, -16} },
  },
  category = "chemistry",
  --subgroup = "raw-material",
  energy_required = 1,
  ingredients = {
    {type = "fluid", name = "steam", amount = 10},
    -- Let's use woodpulp instead of wood for the new version! Not changing this
    -- for 0.18.34/1.1.4  to avoid an additional (potentially factory-breaking)
    -- change shortly before the new release will change so many things anyway!
    --~ -- {type = "item", name = "wood", amount = 10},
    {type = "item", name = "bi-woodpulp", amount = 20},
    {type = "fluid", name = "light-oil", amount = 20},
  },
  results = {
    {type = "item", name = "plastic-bar", amount = 2}
  },
  crafting_machine_tint = {
    primary     = util.color("e3d7aa"),
    secondary   = util.color("c2b99f"),
    tertiary    = util.color("d4ac48"),
    quaternary  = util.color("e0b572")
  },
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "raw-material",
  order = "f[plastic-bara]",
  --~ -- subgroup = "intermediate-product",
  --~ -- order = "b[bi-plastic-1]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-plastics"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "plates",
  subgroup_5d = "plates-misc",
  --~ subgroup_order_5d = "n-a",
  order_5d = "b-[Bio_Industries]-[plates-misc]-[bi-plastic-1]",
}


-- WRONG ICON? Wood + Light oil doesn't match ingredients!
-- Bio plastic 2
BI.additional_recipes.BI_Bio_Fuel.bio_plastic_2 = {
  type = "recipe",
  name = "bi-plastic-2",
  localised_name = {"recipe-name.bi-plastic", {"item-name.bi-cellulose"}},
  localised_description = {"recipe-description.bi-plastic-2"},
  --icon = ICONPATH .. "bio_plastic_bar_1.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/plastic-bar.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/wood.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {17, -15} },
    { icon = "__base__/graphics/icons/fluid/light-oil.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {-19, -16} },
  },
  category = "chemistry",
  energy_required = 1,
  ingredients = {
    {type = "item", name = "bi-cellulose", amount = 1},
    {type = "fluid", name = "petroleum-gas", amount = 10},
  },
  results = {
    {type = "item", name = "plastic-bar", amount = 2}
  },
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "raw-material",
  order = "f[plastic-barb]",
  --~ -- subgroup = "intermediate-product",
  --~ -- order = "b[bi-plastic-2]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-cellulose-2"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "plates",
  subgroup_5d = "plates-misc",
  --~ subgroup_order_5d = "n-a",
  order_5d = "b-[Bio_Industries]-[plates-misc]-[bi-plastic-2]",
  crafting_machine_tint = {
    primary     = util.color("e3d7aa"),
    secondary   = util.color("c2b99f"),
    tertiary    = util.color("e3d1ba"),
    quaternary  = util.color("e3d7aa")
  },
}

-- Biomass 2
BI.additional_recipes.BI_Bio_Fuel.bio_mass_2 = {
  type = "recipe",
  name = "bi-biomass-2",
  --~ localised_name = {"recipe-name.bi-biomass-2"},
  localised_name = {"fluid-name.bi-biomass"},
  localised_description = {"recipe-description.bi-biomass-2", {"fluid-name.bi-biomass"}},
  --icon = ICONPATH .. "fluid_biomass_repro_1.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "signal/bi_signal_reprocess.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  },
  category = BI.default_recipe_categories.bioreactor.name,
  energy_required = 60,
  ingredients = {
    {type = "fluid", name = "water", amount = 90},
    {type = "fluid", name = "liquid-air", amount = 10},
    {type = "fluid", name = "bi-biomass", amount = 10},
  },
  results = {
    {type = "fluid", name = "bi-biomass", amount = 35},
  },
  main_product = "",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  --~ -- subgroup = "bio-bio-fuel-fluid",
  --~ -- order = "x[oil-processing]-z3[bi-biomass]"
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  order = "a-[biomass]-a-[bi-biomass-2]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-biomass-reprocessing-1"},
  crafting_machine_tint = { primary = util.color("67f45d") },
}

-- Biomass 3
BI.additional_recipes.BI_Bio_Fuel.bio_mass_3 = {
  type = "recipe",
  name = "bi-biomass-3",
  --~ localised_name = {"recipe-name.bi-biomass-3"},
  localised_name = {"fluid-name.bi-biomass"},
  localised_description = {"recipe-description.bi-biomass-3", {"fluid-name.bi-biomass"}},
  --icon = ICONPATH .. "fluid_biomass_repro_2.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "signal/bi_signal_reprocess.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "ash.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {18, -19} },
  },
  category = BI.default_recipe_categories.bioreactor.name,
  energy_required = 10,
  ingredients = {
    {type = "fluid", name = "water", amount = 90},
    {type = "fluid", name = "liquid-air", amount = 10},
    {type = "fluid", name = "bi-biomass", amount = 10},
    {type = "item", name = "bi-ash", amount = 10},
  },
  results = {
    {type = "fluid", name = "bi-biomass", amount = 100},
  },
  main_product = "",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  --~ -- subgroup = "bio-bio-fuel-fluid",
  --~ -- order = "x[oil-processing]-z2[bi-biomass]"
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  order = "a-[biomass]-a-[bi-biomass-3]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-biomass-reprocessing-2"},
  crafting_machine_tint = { primary = util.color("60c159") },
}

-- Biomass conversion 1 (Biomass to Crude oil)
--~ BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_1 = {
BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_crude_oil = {
  type = "recipe",
  name = "bi-biomass-conversion-crude-oil",
  localised_name = {
    "recipe-name.bi-biomass-conversion",
    {"fluid-name.bi-biomass"},
    1,
    {"fluid-name.crude-oil"},
  },
  localised_description = {
    "recipe-description.bi-biomass-conversion-crude-oil",
    {"fluid-name.bi-biomass"},
    {"fluid-name.crude-oil"},
    {"fluid-name.water"},
  },
  --icon = ICONPATH .. "bio_conversion_1.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/fluid/crude-oil.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 0.6, shift = {-18, -14} },
  },
  --~ category = "oil-processing",
  category = BI.default_recipe_categories.bioreactor.name,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 10,
  ingredients = {
    {type = "item", name = "coal", amount = 20},
    {type = "fluid", name = "bi-biomass", amount = 10},
    {type = "fluid", name = "steam", amount = 50}
  },
  results = {
    {type = "fluid", name = "crude-oil", amount = 50},
    {type = "fluid", name = "water", amount = 50},
  },
  main_product = "",
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  order = "a-[biomass]-b-[conversion]-1-[crude-oil]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-biomass-conversion"},
  crafting_machine_tint = { primary = util.color("2c482a") },
}

-- Biomass conversion 2 (Biomass to Petroleum gas)
BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_petroleum = {
  type = "recipe",
  name = "bi-biomass-conversion-petroleum",
  --localised_name = {"recipe-name.bi-biomass-conversion-2"},
  localised_name = {
    "recipe-name.bi-biomass-conversion",
    {"fluid-name.bi-biomass"},
    2,
    {"fluid-name.petroleum-gas"},
  },
  localised_description = {
    "recipe-description.bi-biomass-conversion-petroleum",
    {"fluid-name.bi-biomass"},
    {"fluid-name.petroleum-gas"},
  },
  --icon = ICONPATH .. "bio_conversion_2.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/fluid/petroleum-gas.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 9} },
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 0.6, shift = {-18, -14} },
  },
  --~ category = "oil-processing",
  category = BI.default_recipe_categories.bioreactor.name,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 5,
  ingredients = {
    {type = "fluid", name = "bi-biomass", amount = 10},
    {type = "fluid", name = "water", amount = 10},
  },
  results = {
    {type = "fluid", name = "petroleum-gas", amount = 20}
  },
  main_product = "",
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  order = "a-[biomass]-b-[conversion]-2-[petroleum-gas]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-biomass-conversion"},
  crafting_machine_tint = { primary = util.color("9adf95") },
}


-- Biomass conversion 3 (Biomass to Lubricant)
--~ BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_3 = {
BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_lubricant = {
  type = "recipe",
  name = "bi-biomass-conversion-lubricant",
  --localised_name = {"recipe-name.bi-biomass-conversion-3"},
  localised_name = {
    "recipe-name.bi-biomass-conversion",
    {"fluid-name.bi-biomass"},
    3,
    {"fluid-name.lubricant"},
  },
  localised_description = {
    "recipe-description.bi-biomass-conversion-lubricant",
    {"fluid-name.bi-biomass"},
    {"fluid-name.lubricant"},
  },
  --icon = ICONPATH .. "bio_conversion_3.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/fluid/lubricant.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 0.6, shift = {-18, -14} },
  },
  --~ category = "oil-processing",
  category = BI.default_recipe_categories.bioreactor.name,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 2.5,
  ingredients = {
    {type = "fluid", name = "bi-biomass", amount = 10},
    {type = "fluid", name = "water", amount = 10},
  },
  results = {
    {type = "fluid", name = "lubricant", amount = 10}
  },
  main_product = "",
  crafting_machine_tint = { primary = util.color("64de41") },
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  order = "a-[biomass]-b-[conversion]-3-[lubricant]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-biomass-conversion"},
}

-- Biomass conversion 4 (Biomass to Sulfuric acid)
BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_sulfuric_acid = {
  type = "recipe",
  name = "bi-biomass-conversion-sulfuric-acid",
  localised_name = {
    "recipe-name.bi-biomass-conversion",
    {"fluid-name.bi-biomass"},
    4,
    {"fluid-name.sulfuric-acid"},
  },
  localised_description = {
    "recipe-description.bi-biomass-conversion-sulfuric-acid",
    {"fluid-name.bi-biomass"},
    {"fluid-name.sulfuric-acid"},
  },
  --icon = ICONPATH .. "bio_sulfturic_acid.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/fluid/sulfuric-acid.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 7} },
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 0.6, shift = {-18, -14} },
  },
  --~ category = "chemistry",
  category = BI.default_recipe_categories.bioreactor.name,
  energy_required = 10,
  ingredients = {
    {type = "fluid", name = "water", amount = 90},
    {type = "fluid", name = "bi-biomass", amount = 10},
    {type = "item", name = "bi-cellulose", amount = 5},
  },
  results = {
    {type = "fluid", name = "sulfuric-acid", amount = 50},
  },
  main_product = "",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  crafting_machine_tint = {
    primary     = util.color("e2df69"),
    secondary   = util.color("b6c4a7"),
    tertiary    = util.color("85b87d"),
    quaternary  = util.color("b9ba8a")
  },
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  --~ -- subgroup = "fluid-recipes",
  order = "a-[biomass]-b-[conversion]-4-[sulfuric-acid]",
  --~ -- order = "a",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-cellulose-1"},
}

-- Biomass conversion 5 (Biomass to Light oil)
BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_light_oil = {
  type = "recipe",
  name = "bi-biomass-conversion-light-oil",
  --~ localised_name = {"recipe-name.bi-biomass-conversion-5"},
  localised_name = {
    "recipe-name.bi-biomass-conversion",
    {"fluid-name.bi-biomass"},
    5,
    {
      "",
      {"fluid-name.light-oil"},
      ", ",
      {"item-name.bi-cellulose"},
    }
  },
  localised_description = {
    "recipe-description.bi-biomass-conversion-light-oil",
    {"fluid-name.bi-biomass"},
    {"fluid-name.light-oil"},
  },
  --icon = ICONPATH .. "bio_conversion_4.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/fluid/light-oil.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 0.6, shift = {-18, -14} },
  },
  --~ category = "oil-processing",
  category = BI.default_recipe_categories.bioreactor.name,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  energy_required = 5,
  ingredients = {
    {type = "fluid", name = "bi-biomass", amount = 100},
    {type = "fluid", name = "water", amount = 10},
  },
  results = {
    {type = "item", name = "bi-cellulose", amount = 2},
    {type = "fluid", name = "light-oil", amount = 80},
  },
  main_product = "",
  crafting_machine_tint = { primary = util.color("efd544") },
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  order = "a-[biomass]-b-[conversion]-5-[light-oil]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-plastics"},
}

-- Bio Battery
BI.additional_recipes.BI_Bio_Fuel.bio_battery = {
  type = "recipe",
  name = "bi-battery",
  --icon = ICONPATH .. "bio_battery.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/battery.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "fluid_biomass.png", icon_size = 64, icon_mipmaps = 4, scale = 0.6, shift = {-18, -14} },
  },
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "item", name = "plastic-bar", amount = 1},
    {type = "fluid", name = "bi-biomass", amount = 10},
    {type = "item", name = "bi-cellulose", amount = 1},
  },
  results = {
    {type = "item", name = "battery", amount = 1},
  },
  enabled = false,
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,    -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,       -- Added for 0.18.34/1.1.4
  allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  crafting_machine_tint = {
    primary     = util.color("dff0da"),
    secondary   = util.color("e0df77"),
    tertiary    = util.color("88ba8a"),
    quaternary  = util.color("bbb38f")
  },
  subgroup = "raw-material",
  order = "h[batteryb]",
  --~ -- subgroup = "raw-material",
  --~ -- order = "h[bi-battery]",
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-cellulose-2"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "intermediate",
  subgroup_5d = "intermediate-misc",
  --~ subgroup_order_5d = "n-a",
  order_5d = "e-[Bio_Industries]-[intermediate-misc]-[bi-battery]",
}


-- Sulfuric acid to Sulfur
BI.additional_recipes.BI_Bio_Fuel.bio_sulfur = {
  type = "recipe",
  name = "bi-sulfur",
  --icon = ICONPATH .. "bio_sulfur.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --icons = {
  --  { icon = "__base__/graphics/icons/sulfur.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  --  { icon = ICONPATH .. "ash.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -17} },
  --  { icon = "__base__/graphics/icons/fluid/sulfuric-acid.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {-16, -16} },
  --},
  --~ icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}),
  icons = {it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0},
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 2,
  ingredients = {
    {type = "fluid", name = "sulfuric-acid", amount = 2},
    {type = "item", name = "bi-ash", amount = 2},
  },
  results = {
    {type = "item", name = "sulfur", amount = 2}
  },
  crafting_machine_tint = {
    primary     = util.color("eadc30"),
    secondary   = util.color("ebdd28"),
    tertiary    = util.color("eadc30"),
    quaternary  = util.color("ebdd28")
  },
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  subgroup = "raw-material",
  order = "g[sulfur]-[Bio Industries]",
  --~ -- subgroup = "raw-material",
  --~ -- order = "g[sulfur]-[bi-sulfur]",
  allow_as_intermediate = false,

  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-cellulose-1"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "plates",
  subgroup_5d = "plates-misc",
  --~ subgroup_order_5d = "n-a",
  order_5d = "c-[Bio_Industries]-[plates-misc]-[bi-sulfur]",
}


------------------------------------------------------------------------------------
--                               Enable: Bio gardens                              --
--                           (BI.Settings.BI_Bio_Garden)                          --
------------------------------------------------------------------------------------
--- Bio garden
BI.additional_recipes.BI_Bio_Garden.bio_garden = {
  type = "recipe",
  name = "bi-bio-garden",
  localised_name = {"entity-name.bi-bio-garden"},
  --~ --  localised_description = {"entity-description.bi-bio-garden"},
  icon = ICONPATH .. "entity/garden_3x3.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  enabled = false,
  energy_required = 10,
  ingredients = {
    {"stone-wall", 10},
    -- We'll add this in data-updates, depending on what's available!
    --~ {"stone-crushed", 40},
    {"seedling", 30}
  },
  result = "bi-bio-garden",
  subgroup = "bio-bio-gardens-fluid",
  order = "a[bi]-1",
  --~ --  subgroup = "production-machine",
  --~ --  order = "x[bi]-b[bi_bio_garden]",
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  allow_as_intermediate = true,      -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  --~ -- This is a custom property for use by "Krastorio 2" (it will change
  --~ -- ingredients/results; used for wood/wood pulp)
  --~ mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-garden-1"},
}

-- Large garden
BI.additional_recipes.BI_Bio_Garden.bio_garden_large = {
  type = "recipe",
  name = "bi-bio-garden-large",
  localised_name = {"entity-name.bi-bio-garden-large"},
  --localised_description = {"entity-description.bi-bio-garden-large"},
  icon = ICONPATH .. "entity/garden_9x9.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  enabled = false,
  energy_required = 25,
  ingredients = {
    {"bi-bio-garden", 9},
    {"seedling", 10},
    {"concrete", 10}
  },
  result = "bi-bio-garden-large",
  subgroup = "bio-bio-gardens-fluid",
  order = "a[bi]-2",
  allow_as_intermediate = true,
  always_show_made_in = false,
  allow_decomposition = true,
  --~ -- This is a custom property for use by "Krastorio 2" (it will change ingredients/results; used for wood/wood pulp)
  --~ mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-garden-2"},
}

-- Huge garden
BI.additional_recipes.BI_Bio_Garden.bio_garden_huge = {
  type = "recipe",
  name = "bi-bio-garden-huge",
  localised_name = {"entity-name.bi-bio-garden-huge"},
  --localised_description = {"entity-description.bi-bio-garden-huge"},
  icon = ICONPATH .. "entity/garden_27x27.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  enabled = false,
  energy_required = 60,
  ingredients = {
    {"bi-bio-garden-large", 9},
    {"iron-plate", 30},
    {"concrete", 40},
    {"seedling", 100}
  },
  result = "bi-bio-garden-huge",
  subgroup = "bio-bio-gardens-fluid",
  order = "a[bi]-3",
  allow_as_intermediate = true,
  always_show_made_in = false,
  allow_decomposition = true,
  --~ -- This is a custom property for use by "Krastorio 2" (it will change ingredients/results; used for wood/wood pulp)
  --~ mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-garden-3"},
}

-- Clean Air 1
BI.additional_recipes.BI_Bio_Garden.purified_air_1 = {
  type = "recipe",
  name = "bi-purified-air-1",
  --~ localised_name = {"recipe-name.bi-purified-air-1"},
  localised_name = {"recipe-name.bi-purified-air", {"item-name.fertilizer"}},
  localised_description = {
    "recipe-description.bi-purified-air-1",
    {"fluid-name.water"},
  },
  icon = ICONPATH .. "clean-air_fert1.png",
  icon_size = 128, icon_mipmaps = 4,
  BI_add_icon = true,
  order = "zzz-clean-air",
  category = BI.additional_categories.BI_Bio_Garden.clean_air.name,
  subgroup = "bio-bio-gardens-fluid",
  order = "bi-purified-air-1",
  enabled = false,
  --~ always_show_made_in = false,
  always_show_made_in = true,
  allow_decomposition = false,
  show_amount_in_title = false,
  energy_required = 40,
  ingredients = {
    {type = "fluid", name = "water", amount = 50},
    {type = "item", name = "fertilizer", amount = 1}
  },
  results = {
    {type = "item", name = "bi-purified-air", amount = 1, probability = 0},
  },
  crafting_machine_tint = {
    primary     = {r = 0.43, g = 0.73, b = 0.37, a = 0.60},
    secondary   = {r = 0, g = 0, b = 0, a = 0},
    tertiary    = {r = 0, g = 0, b = 0, a = 0},
    quaternary  = {r = 0, g = 0, b = 0, a = 0}
  },
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-depollution-1"},
}

-- Clean Air 2
BI.additional_recipes.BI_Bio_Garden.purified_air_2 = {
  type = "recipe",
  name = "bi-purified-air-2",
  --~ localised_name = {"recipe-name.bi-purified-air-2"},
  localised_name = {"recipe-name.bi-purified-air", {"item-name.bi-adv-fertilizer"}},
  icon = ICONPATH .. "clean-air_fert2.png",
  icon_size = 128, icon_mipmaps = 4,
  BI_add_icon = true,
  order = "zzz-clean-air2",
  category = BI.additional_categories.BI_Bio_Garden.clean_air.name,
  subgroup = "bio-bio-gardens-fluid",
  order = "bi-purified-air-2",
  enabled = false,
  --~ always_show_made_in = false,
  always_show_made_in = true,
  allow_decomposition = false,
  show_amount_in_title = false,
  energy_required = 100,
  ingredients = {
    {type = "fluid", name = "water", amount = 50},
    {type = "item", name = "bi-adv-fertilizer", amount = 1},
  },
  results = {
    {type = "item", name = "bi-purified-air", amount = 1, probability = 0},
  },
  crafting_machine_tint = {
    primary     = {r = 0.73, g = 0.37, b = 0.52, a = 0.60},
    secondary   = {r = 0, g = 0, b = 0, a = 0},
    tertiary    = {r = 0, g = 0, b = 0, a = 0},
    quaternary  = {r = 0, g = 0, b = 0, a = 0}
  },
   -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-depollution-2"},
}


------------------------------------------------------------------------------------
--                             Enable: Coal processing                            --
--                        (BI.Settings.BI_Coal_Processing)                        --
------------------------------------------------------------------------------------
-- Charcoal from woodpulp
BI.additional_recipes.BI_Coal_Processing.charcoal_1 = {
  type = "recipe",
  name = "bi-charcoal-1",
  localised_description = {"recipe-description.bi-charcoal"},
  --icon = ICONPATH .. "charcoal_woodpulp.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "charcoal.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "woodpulp.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -17} },
  },
  category = BI.default_recipe_categories.smelting.name,
  subgroup = BI.default_item_subgroup.cokery.name,
  order = "a[bi]-a-d[bi-6-charcoal-1]",
  energy_required = 15,
  ingredients = {{"bi-woodpulp", 24}},
  result = "wood-charcoal",
  result_count = 5,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-1"},
}

-- Charcoal from wood
BI.additional_recipes.BI_Coal_Processing.charcoal_2 = {
  type = "recipe",
  name = "bi-charcoal-2",
  localised_description = {"recipe-description.bi-charcoal"},
  --icon = ICONPATH .. "charcoal_wood.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "charcoal.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/wood.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {17, -15} },
  },
  subgroup = BI.default_item_subgroup.cokery.name,
  order = "a[bi]-a-d[bi-6-charcoal-2]",
  category = BI.default_recipe_categories.smelting.name,
  energy_required = 20,
  ingredients = {{"wood", 20}},
  result = "wood-charcoal",
  result_count = 8,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-1"},
}

-- Coal from charcoal (basic)
BI.additional_recipes.BI_Coal_Processing.coal_1 = {
  type = "recipe",
  name = "bi-coal-1",
  icon = "__base__/graphics/icons/coal.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.default_recipe_categories.smelting.name,
  subgroup = BI.default_item_subgroup.cokery.name,
  order = "a[bi]-a-ea[bi-6-coal-1]",
  energy_required = 20,
  --~ ingredients = {{"wood-charcoal", 10}},
  ingredients = {{"wood-charcoal", 16}},
  result = "coal",
  --~ result_count = 12,
  result_count = 10,
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-2"},
}

-- Coal from charcoal (advanced)
BI.additional_recipes.BI_Coal_Processing.coal_2 = {
  type = "recipe",
  name = "bi-coal-2",
  --icon = ICONPATH .. "coal_plus.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --icons = {
  --  { icon = "__base__/graphics/icons/coal-dark-background.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  --  { icon = ICONPATH .. "signal/bi_signal_plus.png", icon_size = 64, icon_mipmaps = 4, scale = 0.45, shift = {18, -18} },
  --},
  icons = BioInd.make_icons({it1 = "coal", custom_topright = BioInd.iconpath .. "signal/bi_signal_plus.png"}),
  category = BI.default_recipe_categories.smelting.name,
  subgroup = BI.default_item_subgroup.cokery.name,
  order = "a[bi]-a-eb[bi-6-coal-2]",
  energy_required = 20,
  --~ ingredients = {{"wood-charcoal", 10}},
  ingredients = {{"wood-charcoal", 12}},
  result = "coal",
  --~ result_count = 16,
  result_count = 10,
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-3"},
}

-- Pellet coke from coal
BI.additional_recipes.BI_Coal_Processing.coke_coal = {
  type = "recipe",
  name = "bi-coke-coal",
  --~ --  localised_name = {"item-name.pellet-coke"},
  --~ --  localised_description = {"item-description.pellet-coke"},
  icon = ICONPATH .. "pellet_coke.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.default_recipe_categories.smelting.name,
  subgroup = BI.default_item_subgroup.cokery.name,
  order = "a[bi]-a-g[bi-8-coke-coal]-1",
  energy_required = 20,
  ingredients = {{"coal", 12}},
  result = "pellet-coke",
  result_count = 2,
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_as_intermediate = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-2"},
}

-- Pellet coke from solid fuel
BI.additional_recipes.BI_Coal_Processing.pellet_coke = {
  type = "recipe",
  name = "bi-pellet-coke",
  --~ --  localised_name = {"item-name.pellet-coke"},
  --~ --  localised_description = {"item-description.pellet-coke"},
  --icon = ICONPATH .. "pellet_coke_solid-fuel.png",
  --icon = "__Bio_Industries__/graphics/icons/pellet_coke_c.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "pellet_coke.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/solid-fuel.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {17, -15} },
  },
  category = BI.default_recipe_categories.smelting.name,
  subgroup = BI.default_item_subgroup.cokery.name,
  order = "a[bi]-a-g[bi-8-coke-coal]-3",
  energy_required = 6,
  ingredients = {{"solid-fuel", 5}},
  result = "pellet-coke",
  result_count = 3,
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_as_intermediate = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-3"},
}

-- Solid fuel from wood bricks
BI.additional_recipes.BI_Coal_Processing.solid_fuel = {
  type = "recipe",
  name = "bi-solid-fuel",
  --icon = ICONPATH .. "bi_solid_fuel_wood_brick.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/solid-fuel.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "fuel_brick.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {-16, -19} },
  },
  subgroup = "fluid-recipes",
  order = "b[fluid-chemistry]-c[solid-fuel-from-wood-brick]",
  category = "chemistry",
  energy_required = 2,
  ingredients = {{"wood-bricks", 3}},
  result = "solid-fuel",
  result_count = 2,
  crafting_machine_tint = {
    primary     = util.color("454237"),
    secondary   = util.color("454237"),
    tertiary    = util.color("504725"),
    quaternary  = util.color("8d846b")
  },
  --~ show_amount_in_title = false,
  show_amount_in_title = true,
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
  always_show_made_in = true, -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-coal-processing-2"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "liquid",
  subgroup_5d = "liquid-recipe",
  --~ subgroup_order_5d = "n-a",
  order_5d = "b[fluid-chemistry]-f[solid-fuel-from-wood-brick]",
}


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
--- Dart Rifle
BI.additional_recipes.BI_Darts.dart_rifle = {
  type = "recipe",
  name = "bi-dart-rifle",
  --localised_name = {"item-name.bi-dart-rifle"},
  --~ localised_description = {"item-description.bi-dart-rifle"},
  icon = ICONPATH .. "weapon/dart_rifle.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = true,
    energy_required = 8,
    ingredients = {
      {"copper-plate", 5},
      {"wood", 15},
    },
    result = "bi-dart-rifle",
    result_count = 1,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = true,
    energy_required = 16,
    ingredients = {
      {"copper-plate", 10},
      {"wood", 25},
    },
    result = "bi-dart-rifle",
    result_count = 1,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "gun",
  --~ order = "[bi-dart-rifle]"
  order = "a[basic-clips]-b[bi-dart-rifle]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "equipment",
  subgroup_5d = "equipment-dart",
  subgroup_order_5d = "0-[Bio_Industries]-[equipment-darts]",
  order_5d = "[Bio_Industries]-a[bi-dart-rifle]",
}

--- Dart Turret
BI.additional_recipes.BI_Darts.dart_turret = {
  type = "recipe",
  name = "bi-dart-turret",
  localised_name = {"entity-name.bi-dart-turret"},
  --~ localised_description = {"entity-description.bi-dart-turret"},
  localised_description = {"entity"},
  icon = ICONPATH .. "entity/dart_turret.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = true,
    energy_required = 8,
    ingredients = {
      {"iron-gear-wheel", 5},
      {"wood", 20},
    },
    result = "bi-dart-turret",
    result_count = 1,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = true,
    energy_required = 16,
    ingredients = {
      {"iron-gear-wheel", 10},
      {"wood", 25},
    },
    result = "bi-dart-turret",
    result_count = 1,
    main_product = "",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "defensive-structure",
  order = "b[turret]-e[bi-dart-turret]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
}

-- Wooden Fence
BI.additional_recipes.BI_Darts.wooden_fence = {
  type = "recipe",
  name = "bi-wooden-fence",
  localised_name = {"entity-name.bi-wooden-fence"},
  --~ localised_description = {"entity-description.bi-wooden-fence"},
  icon = ICONPATH .. "entity/wooden-fence.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = true,
    ingredients = {
      {"wood", 2},
    },
    result = "bi-wooden-fence",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = true,
    ingredients = {
      {"wood", 4},
    },
    result = "bi-wooden-fence",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "defensive-structure",
  order = "a-a[stone-wall]-aa[wooden-fence]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
}

--- Basic Dart Ammo
BI.additional_recipes.BI_Darts.dart_magazine_basic = {
  type = "recipe",
  name = "bi-dart-magazine-basic",
  --localised_name = {"item-name.bi-dart-magazine-basic"},
  --localised_description = {"item-description.bi-dart-magazine-basic"},
  icon = ICONPATH .. "weapon/dart_1_basic.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = true,
    energy_required = 4,
    ingredients = {
      {"wood", 10},
    },
    result = "bi-dart-magazine-basic",
    result_count = 10,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = true,
    energy_required = 6,
    ingredients = {
      {"wood", 10},
    },
    result = "bi-dart-magazine-basic",
    result_count = 8,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = BI.additional_categories.BI_Darts.ammo.name,
  order = "[bio-ammo]-a-[darts]-1",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "equipment",
  subgroup_5d = "equipment-dart",
  subgroup_order_5d = "0-[Bio_Industries]-[equipment-darts]",
  order_5d = "[Bio_Industries]-b[bio-ammo]-a-[darts]-1",
}

--- Standard Dart Ammo
BI.additional_recipes.BI_Darts.dart_magazine_standard = {
  type = "recipe",
  name = "bi-dart-magazine-standard",
  --localised_name = {"item-name.bi-dart-magazine-standard"},
  --localised_description = {"item-description.bi-dart-magazine-standard"},
  icon = ICONPATH .. "weapon/dart_2_standard.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ BI_add_to_tech = {"military"},
  BI_add_to_tech = {"bi-tech-darts-1"},
  normal = {
    enabled = false,
    energy_required = 5,
    ingredients = {
      {"bi-dart-magazine-basic", 10},
      {"copper-plate", 5},
    },
    result = "bi-dart-magazine-standard",
    result_count = 10,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 8,
    ingredients = {
      {"bi-dart-magazine-basic", 8},
      {"copper-plate", 5},
    },
    result = "bi-dart-magazine-standard",
    result_count = 8,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = BI.additional_categories.BI_Darts.ammo.name,
  order = "[bio-ammo]-a-[darts]-2",
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "equipment",
  subgroup_5d = "equipment-dart",
  subgroup_order_5d = "0-[Bio_Industries]-[equipment-darts]",
  order_5d = "[Bio_Industries]-b[bio-ammo]-a-[darts]-2",
}

--- Enhanced Dart Ammo
BI.additional_recipes.BI_Darts.dart_magazine_enhanced = {
  type = "recipe",
  name = "bi-dart-magazine-enhanced",
  --localised_name = {"item-name.bi-dart-magazine-enhanced"},
  --localised_description = {"item-description.bi-dart-magazine-enhanced"},
  icon = ICONPATH .. "weapon/dart_3_enhanced.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ BI_add_to_tech = {"military-2"},
  BI_add_to_tech = {"bi-tech-darts-2"},
  normal = {
    enabled = false,
    energy_required = 6,
    ingredients = {
      {"bi-dart-magazine-standard", 10},
      {"plastic-bar", 5},
    },
    result = "bi-dart-magazine-enhanced",
    result_count = 10,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 9,
    ingredients = {
      {"bi-dart-magazine-standard", 8},
      {"plastic-bar", 5},
    },
    result = "bi-dart-magazine-enhanced",
    result_count = 8,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = BI.additional_categories.BI_Darts.ammo.name,
  order = "[bio-ammo]-a-[darts]-3",
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "equipment",
  subgroup_5d = "equipment-dart",
  subgroup_order_5d = "0-[Bio_Industries]-[equipment-darts]",
  order_5d = "[Bio_Industries]-b[bio-ammo]-a-[darts]-3",
}

--- Poison Dart Ammo
BI.additional_recipes.BI_Darts.dart_magazine_poison = {
  type = "recipe",
  name = "bi-dart-magazine-poison",
  --localised_name = {"item-name.bi-dart-magazine-poison"},
  --localised_description = {"item-description.bi-dart-magazine-poison"},
  icon = ICONPATH .. "weapon/dart_4_poison.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  --~ BI_add_to_tech = {"military-3"},
  BI_add_to_tech = {"bi-tech-darts-3"},
  normal = {
    enabled = false,
    energy_required = 8,
    ingredients = {
      {"bi-dart-magazine-enhanced", 10},
      {"poison-capsule", 5},
    },
    result = "bi-dart-magazine-poison",
    result_count = 10,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 12,
    ingredients = {
      {"bi-dart-magazine-enhanced", 8},
      {"poison-capsule", 5},
    },
    result = "bi-dart-magazine-poison",
    result_count = 8,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = BI.additional_categories.BI_Darts.ammo.name,
  order = "[bio-ammo]-a-[darts]-4",
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "equipment",
  subgroup_5d = "equipment-dart",
  subgroup_order_5d = "0-[Bio_Industries]-[equipment-darts]",
  order_5d = "[Bio_Industries]-b[bio-ammo]-a-[darts]-4",
}


------------------------------------------------------------------------------------
--                           Enable: Disassemble recipes                          --
--                          (BI.Settings.BI_Disassemble)                          --
------------------------------------------------------------------------------------
-- Burner mining drill
BI.additional_recipes.BI_Disassemble.burner_drill = {
  type = "recipe",
  name = "bi-burner-mining-drill-disassemble",
  localised_name = {"recipe-name.bi-disassemble", {"entity-name.burner-mining-drill"}},
  localised_description = {"recipe-description.bi-disassemble-recipes"},
  --icon = ICONPATH .. "disassemble_burner-mining-drill.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "burner-mining-drill", custom = ICONPATH .. "signal/bi_signal_deconstruct.png"}),
  category = "advanced-crafting",
  subgroup = "bio-disassemble",
  order = "a[Disassemble]-a[bi-burner-mining-drill-disassemble]",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = false,
  allow_decomposition = false,
  energy_required = 2,
  ingredients = {
    {type = "item", name = "burner-mining-drill", amount = 1},
  },
  results = {
    {"stone", 4},
    {"iron-plate", 4}
  },
  main_product = "",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"automation-2"},
}

-- Burner inserter
BI.additional_recipes.BI_Disassemble.burner_inserter = {
  type = "recipe",
  name = "bi-burner-inserter-disassemble",
  localised_name = {"recipe-name.bi-disassemble", {"entity-name.burner-inserter"}},
  localised_description = {"recipe-description.bi-disassemble-recipes"},
  --icon = ICONPATH .. "disassemble_burner_inserter.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "burner-inserter", custom = ICONPATH .. "signal/bi_signal_deconstruct.png"}),
  category = "advanced-crafting",
  subgroup = "bio-disassemble",
  order = "a[Disassemble]-b[bi-burner-inserter-disassemble]",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = false,
  allow_decomposition = false,
  energy_required = 2,
  ingredients = {
    {type = "item", name = "burner-inserter", amount = 1},
  },
  results = {
    {"iron-plate", 2},
  },
  main_product = "",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"automation-2"},
}

-- Long-handed inserter
BI.additional_recipes.BI_Disassemble.long_handed_inserter = {
  type = "recipe",
  name = "bi-long-handed-inserter-disassemble",
  localised_name = {"recipe-name.bi-disassemble", {"entity-name.long-handed-inserter"}},
  localised_description = {"recipe-description.bi-disassemble-recipes"},
  --icon = ICONPATH .. "disassemble_long_handed_inserter.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "long-handed-inserter", custom = ICONPATH .. "signal/bi_signal_deconstruct.png"}),
  category = "advanced-crafting",
  subgroup = "bio-disassemble",
  order = "a[Disassemble]-c[bi-long-handed-inserter-disassemble]",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = false,
  allow_decomposition = false,
  energy_required = 2,
  ingredients = {
    {type = "item", name = "long-handed-inserter", amount = 1},
  },
  results = {
    {"iron-gear-wheel", 1},
    {"iron-plate", 1},
    {"electronic-circuit", 1},
  },
  main_product = "",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"automation-2"},
}

-- Stone furnace
BI.additional_recipes.BI_Disassemble.stone_furnace = {
  type = "recipe",
  name = "bi-stone-furnace-disassemble",
  localised_name = {"recipe-name.bi-disassemble", {"entity-name.stone-furnace"}},
  localised_description = {"recipe-description.bi-disassemble-recipes"},
  --icon = ICONPATH .. "disassemble_stone_furnace.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "stone-furnace", custom = ICONPATH .. "signal/bi_signal_deconstruct.png"}),
  category = "advanced-crafting",
  subgroup = "bio-disassemble",
  order = "a[Disassemble]-d[bi-stone-furnace-disassemble]",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = false,
  allow_decomposition = false,
  energy_required = 2,
  ingredients = {
    {type = "item", name = "stone-furnace", amount = 1},
  },
  results = {
    {"stone", 3},
  },
  main_product = "",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"automation-2"},
}

-- Steel furnace
BI.additional_recipes.BI_Disassemble.steel_furnace = {
  type = "recipe",
  name = "bi-steel-furnace-disassemble",
  localised_name = {"recipe-name.bi-disassemble", {"entity-name.steel-furnace"}},
  localised_description = {"recipe-description.bi-disassemble-recipes"},
  --icon = ICONPATH .. "disassemble_steel-furnace.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "steel-furnace", custom = ICONPATH .. "signal/bi_signal_deconstruct.png"}),
  category = "advanced-crafting",
  subgroup = "bio-disassemble",
  order = "a[Disassemble]-e[bi-steel-furnace-disassemble]",
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = false,
  allow_decomposition = false,
  energy_required = 2,
  ingredients = {
    {type = "item", name = "steel-furnace", amount = 1},
  },
  results = {
    {"steel-plate", 4},
    {"stone-brick", 4}
  },
  main_product = "",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"advanced-material-processing"},
}


------------------------------------------------------------------------------------
--                               Enable: Seed bombs                               --
--                       (BI.Settings.BI_Explosive_Planting)                      --
------------------------------------------------------------------------------------
-- Basic seed bomb
BI.additional_recipes.BI_Explosive_Planting.seed_bomb_basic = {
  type = "recipe",
  name = "bi-seed-bomb-basic",
  localised_name = {"item-name.bi-seed-bomb-basic"},
  --~ --  localised_description = {"item-description.bi-seed-bomb-basic"},
  icon = ICONPATH .. "weapon/seed-bomb-1.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    energy_required = 8,
    ingredients = {
    {"bi-seed", 400},
    {"rocket", 1},
    },
    result = "bi-seed-bomb-basic",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 8,
    ingredients = {
      {"bi-seed", 400},
      {"rocket", 2},
    },
    result = "bi-seed-bomb-basic",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = true,         -- Added for 0.18.34/1.1.4
  subgroup = "bi-ammo",
  order = "a[rocket-launcher]-x[seed-bomb]-a",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-explosive-planting-1"},
}

--- Standard seed bomb
BI.additional_recipes.BI_Explosive_Planting.seed_bomb_standard = {
  type = "recipe",
  name = "bi-seed-bomb-standard",
  localised_name = {"item-name.bi-seed-bomb-standard"},
  --~ --  localised_description = {"item-description.bi-seed-bomb-standard"},
  --icon = ICONPATH .. "weapon/seed-bomb-2.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "bi-seed-bomb-standard", custom_topright = ICONPATH .. "signal/bi_signal_fert.png"}),
  normal = {
    enabled = false,
    energy_required = 8,
    ingredients = {
      {"bi-seed", 400},
      {"fertilizer", 200},
      {"rocket", 1},
    },
    result = "bi-seed-bomb-standard",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 8,
    ingredients = {
      {"bi-seed", 400},
      {"fertilizer", 200},
      {"rocket", 2},
    },
    result = "bi-seed-bomb-standard",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = true,         -- Added for 0.18.34/1.1.4
  subgroup = "bi-ammo",
  order = "a[rocket-launcher]-x[seed-bomb]-b",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-explosive-planting-2"},
}

--- Advanced seed bomb
BI.additional_recipes.BI_Explosive_Planting.seed_bomb_advanced = {
  type = "recipe",
  name = "bi-seed-bomb-advanced",
  localised_name = {"item-name.bi-seed-bomb-advanced"},
  --~ --  localised_description = {"item-description.bi-seed-bomb-advanced"},
  --icon = ICONPATH .. "weapon/seed-bomb-3.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "bi-seed-bomb-advanced", custom_topright = ICONPATH .. "signal/bi_signal_adv_fert.png"}),
  normal = {
    enabled = false,
    energy_required = 8,
    ingredients = {
      {"bi-seed", 400},
      {"bi-adv-fertilizer", 200},
      {"rocket", 1},
    },
    result = "bi-seed-bomb-advanced",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 8,
    ingredients = {
      {"bi-seed", 400},
      {"bi-adv-fertilizer", 200},
      {"rocket", 2},
    },
    result = "bi-seed-bomb-advanced",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = true,         -- Added for 0.18.34/1.1.4
  subgroup = "bi-ammo",
  order = "a[rocket-launcher]-x[seed-bomb]-c",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-explosive-planting-3"},
}


------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
-- Wooden Rail
BI.additional_recipes.BI_Rails.rail_wood = {
  type = "recipe",
  name = "bi-rail-wood",
  localised_name = {"entity-name.bi-rail-wood"},
  --~ -- localised_description = {"entity-description.bi-rail-wood"},
  icon = ICONPATH .. "entity/rail-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    ingredients = {
      --~ {"stone", 1},
      --~ {"steel-plate", 1},
      --~ {"iron-stick", 1},
      --~ {"wood", 6},
      {"stone", 1},
      {"iron-stick", 6},
      {"wood", 8},
    },
    result = "bi-rail-wood",
    result_count = 2,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    ingredients = {
      --~ {"stone", 1},
      --~ {"steel-plate", 1},
      --~ {"iron-stick", 1},
      --~ {"wood", 6},
      {"stone", 1},
      {"iron-stick", 6},
      {"wood", 8},
    },
    result = "bi-rail-wood",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "train-transport",
  order = "a[train-system]-[Bio_Industries]-a[wood]-a[rail]",

  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"railway"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "trains",
  subgroup_5d = "trains-rails",
  --~ subgroup_order_5d = "n-a",
  order_5d = "[Bio_Industries]-[rails]-a[wood]-a[rail]",
}

--- Wooden Rail to Concrete Rail
BI.additional_recipes.BI_Rails.rail_wood_to_concrete = {
  type = "recipe",
  name = "bi-rail-wood-to-concrete",
  --icon = ICONPATH .. "entity/rail-concrete_from_rail-wood.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = BioInd.make_icons({it1 = "rail", it2 = "bi-rail-wood"}),
  normal = {
    enabled = false,
    ingredients = {
      --~ {"bi-rail-wood", 3},
      --~ {"stone-brick", 10},
      {"bi-rail-wood", 3},
      {"stone-brick", 10},
      {"steel-plate", 2},
   },
    result = "rail",
    result_count = 2,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    ingredients = {
      --~ {"bi-rail-wood", 2},
      --~ {"stone-brick", 10},
      {"bi-rail-wood", 3},
      {"stone-brick", 10},
      {"steel-plate", 2},
    },
    result = "rail",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  subgroup = "train-transport",
  order = "a[train-system]-[Bio_Industries]-a[wood]-c[upgrade]",
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-concrete-rails"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "trains",
  subgroup_5d = "trains-rails",
  --~ subgroup_order_5d = "n-a",
  order_5d = "[Bio_Industries]-[rails]-a[wood]-c[upgrade]",
}

--- Wooden Bridge Rail
BI.additional_recipes.BI_Rails.rail_wood_bridge = {
  type = "recipe",
  name = "bi-rail-wood-bridge",
  localised_name = {"entity-name.bi-rail-wood-bridge"},
  --~ -- localised_description = {"entity-description.bi-rail-wood-bridge"},
  icon = ICONPATH .. "entity/rail-bridge-wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    ingredients = {
      {"bi-rail-wood", 1},
      {"steel-plate", 1},
      {"wood", 32}
    },
    result = "bi-rail-wood-bridge",
    result_count = 2,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    ingredients = {
      {"bi-rail-wood", 1},
      {"steel-plate", 1},
      {"wood", 32}
    },
    result = "bi-rail-wood-bridge",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "train-transport",
  order = "a[train-system]-[Bio_Industries]-a[wood]-b[bridge]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-rail-bridge"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "trains",
  subgroup_5d = "trains-rails",
  --~ subgroup_order_5d = "n-a",
  order_5d = "[Bio_Industries]-[rails]-a[wood]-b[bridge]",
}

--- Power Rail
BI.additional_recipes.BI_Rails.rail_power = {
  type = "recipe",
  name = "bi-rail-power",
  localised_name = {"entity-name.bi-rail-power"},
  --~ -- localised_description = {"entity-description.bi-rail-power"},
  icon = ICONPATH .. "entity/rail-concrete-power.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    ingredients = {
      {"rail", 2},
      {"copper-cable", 4},
    },
    result = "bi-rail-power",
    result_count = 2,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    ingredients = {
      {"rail", 1},
      {"copper-cable", 4},
    },
    result = "bi-rail-power",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "train-transport",
  order = "a[train-system]-[Bio_Industries]-c[powered]-a[rail]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-power-conducting-rails"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "trains",
  subgroup_5d = "trains-rails",
  --~ subgroup_order_5d = "n-a",
  order_5d = "[Bio_Industries]-[rails]-c[powered]-a[rail]",
}

--- Rail to Power Pole
BI.additional_recipes.BI_Rails.power_to_rail_pole = {
  type = "recipe",
  name = "bi-power-to-rail-pole",
  localised_name = {"entity-name.bi-power-to-rail-pole"},
  --~ -- localised_description = {"entity-description.bi-power-to-rail-pole"},
  icon = ICONPATH .. "entity/rail_power_connector.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    ingredients = {
      {"copper-cable", 2},
      {"medium-electric-pole", 1},
    },
    result = "bi-power-to-rail-pole",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    ingredients = {
      {"copper-cable", 4},
      {"medium-electric-pole", 1},
    },
    result = "bi-power-to-rail-pole",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  --~ -- allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "train-transport",
  order = "a[train-system]-[Bio_Industries]-c[powered]-c[connector]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-power-conducting-rails"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "trains",
  subgroup_5d = "trains-rails",
  --~ subgroup_order_5d = "n-a",
  order_5d = "[Bio_Industries]-[rails]-c[powered]-c[connector]",
}

-- Concrete rails are just the vanilla rails. Change localization and order
BI.additional_recipes.BI_Rails.rail_concrete = table.deepcopy(data.raw.recipe.rail)
BI.additional_recipes.BI_Rails.rail_concrete.localised_name = {"entity-name.bi-rail-concrete"}
BI.additional_recipes.BI_Rails.rail_concrete.order =
                    "a[train-system]-[Bio_Industries]-b[concrete]-a[rail]"
-- Group/subgroup if "5Dim's mod - New Core" is used
BI.additional_recipes.BI_Rails.rail_concrete.group_5d = "trains"
BI.additional_recipes.BI_Rails.rail_concrete.subgroup_5d = "trains-rails"
-- BI.additional_items.BI_Rails.rail_concrete.subgroup_order_5d = "n-a"
BI.additional_recipes.BI_Rails.rail_concrete.order_5d = "[Bio_Industries]-[rails]-b[concrete]-a[rail]"


------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
-- Resin from woodpulp
BI.additional_recipes.BI_Rubber.resin_pulp = {
  type = "recipe",
  name = "bi-resin-pulp",
  localised_name = {"recipe-name.bi-resin", {"item-name.bi-woodpulp"}},
  localised_description = {"recipe-description.bi-resin-pulp"},
  --icon = ICONPATH .. "resin_woodpulp.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --icons = {
  --  { icon = ICONPATH .. "resin.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  --  { icon = ICONPATH .. "woodpulp.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -17} },
  --},
  --icons = BioInd.make_icons("resin", "woodpulp", 0,-1),
  --~ icons = BioInd.make_icons({it1 = "resin", it2 = "woodpulp", shift1_1 = 0, shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}),
  icons = {it1 = "resin", it2 = "woodpulp", shift1_1 = 0, shift1_2 = 0, shift2_1 = 0, shift2_2 = 0},
  BI_add_icon = true,
  subgroup = BI.default_item_subgroup.bio_farm_raw.name,
  order = "a[bi]-a-ba[bi-2-resin-2-pulp]",
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  energy_required = 1,
  ingredients = {
     {type = "item", name = "bi-woodpulp", amount = 3},
  },
  result = "resin",
  result_count = 1,
  main_procuct = "",                  -- Display recipe name instead of results in crafting menu!
  allow_as_intermediate = true,       -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = false,        -- Added for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-resin-extraction"},
}

-- Resin recipe - Wood
BI.additional_recipes.BI_Rubber.resin_wood = {
  type = "recipe",
  name = "bi-resin-wood",
  --~ localised_name = {"recipe-name.bi-resin-wood"},
  --~ localised_description = {"recipe-description.bi-resin-wood"},
  localised_name = {"recipe-name.bi-resin", {"item-name.wood"}},
  localised_description = {"recipe-description.bi-resin-wood"},
  --icon = ICONPATH .. "resin_wood.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --icons = {
  --  { icon = ICONPATH .. "resin.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  --  { icon = "__base__/graphics/icons/wood.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {17, -15} },
  --},
  --icons = BioInd.make_icons("resin", "wood", 2,1),
  --~ icons = BioInd.make_icons({it1 = "resin", it2 = "wood", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}),
  icons = {it1 = "resin", it2 = "wood", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0},
  BI_add_icon = true,
  subgroup = BI.default_item_subgroup.bio_farm_raw.name,
  --~ --  -- order = "a[bi]-a-aa[bi-2-resin-1-wood]",
  order = "a[bi]-a-bb[bi-2-resin-2-wood]",
  enabled = false,
  --~ --  -- allow_as_intermediate = false,
  --~ --  -- always_show_made_in = true,
  --~ --  -- allow_decomposition = false,
  allow_as_intermediate = true,     -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,       -- Changed for 0.18.34/1.1.4
  energy_required = 1,
  ingredients = {
     {type = "item", name = "wood", amount = 1}
  },
  result = "resin",
  result_count = 1,
  main_procuct = "",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-resin-extraction"},
}

-- Wood from woodpulp
BI.additional_recipes.BI_Rubber.wood_from_pulp = {
  type = "recipe",
  name = "bi-wood-from-pulp",
  icon = "__base__/graphics/icons/wood.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = BI.default_item_subgroup.bio_farm_raw.name,
  order = "a[bi]-a-c[bi-3-wood_from_pulp]",
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  energy_required = 1.25,
  ingredients = {
     {type = "item", name = "bi-woodpulp", amount = 4},
     {type = "item", name = "resin", amount = 1},
  },
  result = "wood",
  result_count = 2,
  --~ --  allow_as_intermediate = true,       -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = false,        -- Added for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-resin-extraction"},
  allow_as_intermediate = false,
}

-- Rubber
BI.additional_recipes.BI_Rubber.rubber = {
  type = "recipe",
  name = "bi-rubber",
  icon = ICONPATH .. "rubber.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = BI.default_item_subgroup.bio_farm_raw.name,
  order = "a[bi]-a-c[bi-4-rubber]",
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  energy_required = 1.5,
  ingredients = {
     {type = "item", name = "resin", amount = 3},
  },
  result = "rubber",
  result_count = 1,
  --~ allow_as_intermediate = true,           -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = false,        -- Added for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-rubber-production"},
  allow_as_intermediate = false,
}

-- Rubber mat
BI.additional_recipes.BI_Rubber.rubber_mat = {
  type = "recipe",
  name = "bi-rubber-mat",
  icon = ICONPATH .. "entity/rubber-mat.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = "defensive-structure",
  order = "a-a[stone-wall]-ab[rubber-mat]",
  enabled = false,
  --~ --  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  --~ --  allow_as_intermediate = false,
  energy_required = 1.5,
  ingredients = {
     {type = "item", name = "resin", amount = 4},
     {type = "item", name = "concrete", amount = 1},
     {type = "item", name = "rubber", amount = 3},
  },
  result = "bi-rubber-mat",
  result_count = 1,
  --~ allow_as_intermediate = true,           -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = false,        -- Added for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-rubber-mat"},
  allow_as_intermediate = false,
}


------------------------------------------------------------------------------------
--                  Enable: Bio power production and distribution                 --
--                        (BI.Settings.BI_Power_Production)                       --
------------------------------------------------------------------------------------
-- Solar farm
BI.additional_recipes.BI_Power_Production.solar_farm = {
  type = "recipe",
  name = "bi-bio-solar-farm",
  localised_name = {"entity-name.bi-bio-solar-farm"},
  --~ -- localised_description = {"entity-description.bi-bio-solar-farm"},
  icon = ICONPATH .. "entity/solar-panel-large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  enabled = false,
  energy_required = 60,
  ingredients = {
    {"solar-panel", 60},
    {"medium-electric-pole", 25},
    {"concrete", 400},
  },
  result = "bi-bio-solar-farm",
  --~ -- subgroup = "bio-bio-solar-entity",
  --~ -- order = "a[bi]",
  subgroup = "energy",
  order = "d[solar-panel]-a[solar-panel]-a[bi-bio-solar-farm]",
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-super-solar-panels"},
}


-- Solar plant and boiler
BI.additional_recipes.BI_Power_Production.solar_boiler = {
  type = "recipe",
  --~ -- name = "bi-solar-boiler-hidden-panel",
  name = "bi-solar-boiler",
  localised_name = {"entity-name.bi-solar-boiler"},
  --~ -- localised_description = {"entity-description.bi-solar-boiler"},
  icon = ICONPATH .. "entity/solar-boiler.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  enabled = false,
  energy_required = 15,
  ingredients = {
    {"solar-panel", 30},
    {"storage-tank", 4},
    {"boiler", 1},
  },
  result = "bi-solar-boiler",
  subgroup = "energy",
  order = "b[steam-power]-c[steam-engine]",
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,               -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-steamsolar-combination"},
}

-- Musk floor/Solar mat
BI.additional_recipes.BI_Power_Production.solar_mat = {
  type = "recipe",
  name = "bi-solar-mat",
  localised_name = {"entity-name.bi-solar-mat"},
  --~ -- localised_description = {"entity-description.bi-solar-mat"},
  icon = ICONPATH .. "entity/solar-mat.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  enabled = false,
  energy_required = 5,
  ingredients = {
    {"steel-plate", 1},
    {"advanced-circuit", 3},
    {"copper-cable", 4},
  },
  result = "bi-solar-mat",
  --~ -- subgroup = "bio-bio-solar-entity",
  --~ -- order = "c[bi]",
  subgroup = "energy",
  order = "d[solar-panel]-aa[solar-panel-1-a]",
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,               -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-musk-floor"},
}

-- Huge accumulator
BI.additional_recipes.BI_Power_Production.huge_accumulator = {
  type = "recipe",
  name = "bi-bio-accumulator",
  localised_name = {"entity-name.bi-bio-accumulator"},
  --~ -- localised_description = {"entity-description.bi-bio-accumulator"},
  icon = ICONPATH .. "entity/accumulator_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  energy_required = 60,
  enabled = false,
  ingredients = {
    {"accumulator", 60},
    {"copper-cable", 50},
    {"concrete", 200},
  },
  result = "bi-bio-accumulator",
  --~ -- subgroup = "bio-bio-solar-entity",
  --~ -- order = "d[bi]",
  subgroup = "energy",
  order = "e[accumulator]-a[bi-accumulator]",
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,       -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-electric-energy-super-accumulators"},
}

-- Huge substation
BI.additional_recipes.BI_Power_Production.huge_substation = {
  type = "recipe",
  name = "bi-huge-substation",
  localised_name = {"entity-name.bi-huge-substation"},
  --~ -- localised_description = {"entity-description.bi-huge-substation"},
  icon = ICONPATH .. "entity/substation_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  enabled = false,
  ingredients = {
    {"steel-plate", 10},
    {"concrete", 200},
    {"substation", 4}
  },
  result = "bi-huge-substation",
  --~ -- subgroup = "bio-bio-solar-entity",
  --~ -- order = "e[bi]",
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-d[substation]-b[large-substation]",
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,               -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-huge-substation"},
}


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
-- STONE CRUSHER (ENTITY)
BI.additional_recipes.BI_Stone_Crushing.stone_crusher = {
  type = "recipe",
  name = "bi-stone-crusher",
  localised_name = {"entity-name.bi-stone-crusher"},
  --~ -- localised_description = {"entity-description.bi-stone-crusher"},
  icon = ICONPATH .. "entity/stone_crusher.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    energy_required = 3,
    ingredients = {
      {"iron-plate", 10},
      {"steel-plate", 10},
      {"iron-gear-wheel", 5},
    },
    result = "bi-stone-crusher",
    result_count = 1,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Added for 0.18.34/1.1.4
    allow_decomposition = true,         -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 5,
    ingredients = {
      {"iron-plate", 12},
      {"steel-plate", 12},
      {"iron-gear-wheel", 8},
    },
    result = "bi-stone-crusher",
    result_count = 1,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Added for 0.18.34/1.1.4
    allow_decomposition = true,         -- Added for 0.18.34/1.1.4
  },
  subgroup = BI.additional_categories.BI_Stone_Crushing.stone_crusher.name,
  order = "a[bi]",
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,        -- Added for 0.18.34/1.1.4
  always_show_made_in = false,          -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,           -- Added for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-stone-crushing-1"},
}

-- Crushed stone from stone
BI.additional_recipes.BI_Stone_Crushing.crushed_stone_stone = {
  type = "recipe",
  name = "bi-crushed-stone-stone",
  localised_name = {
    "recipe-name.bi-crushed-stone",
    {"item-name.stone-crushed"},
    {"item-name.stone"}
  },
  icon = ICONPATH .. "crushed-stone.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  subgroup = "bio-stone-crusher",
  order = "a[bi]-a-z[bi-9-stone-crushed-1]",
  energy_required = 1.5,
  ingredients = {{"stone", 1}},
  result = "stone-crushed",
  result_count = 2,
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  allow_as_intermediate = true,      -- Added for 0.18.34/1.1.4
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-stone-crushing-1"},
}

-- Crushed stone from stone-brick
BI.additional_recipes.BI_Stone_Crushing.crushed_stone_stone_brick = {
  type = "recipe",
  name = "bi-crushed-stone-stone-brick",
  --~ localised_name = {"recipe-name.bi-crushed-stone-2", {"item-name.stone-brick"}},
  localised_name = {
    "recipe-name.bi-crushed-stone",
    {"item-name.stone-crushed"},
    {"item-name.stone-brick"}
  },
  localised_description = {"recipe-description.bi-crushed-stone-2", {"item-name.stone-brick"}},
  --icon = ICONPATH .. "crushed-stone-stone-brick.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "crushed-stone.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/stone-brick.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -16} },
  },
  category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  subgroup = "bio-stone-crusher",
  order = "a[bi]-a-z[bi-9-stone-crushed-2-stone-brick]",
  energy_required = 1.5,    -- Increased crafting time
  ingredients = {{"stone-brick", 1}},
  result = "stone-crushed",
  --~ result_count = 4,
  result_count = 3,
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-stone-crushing-2"},
  BI_add_to_tech = {"bi-tech-stone-crushing-1"},
}

-- Crushed stone from concrete
BI.additional_recipes.BI_Stone_Crushing.crushed_stone_concrete = {
  type = "recipe",
  name = "bi-crushed-stone-concrete",
  --~ localised_name = {"recipe-name.bi-crushed-stone-2", {"item-name.concrete"}},
  localised_name = {"recipe-name.bi-crushed-stone", {"item-name.stone-crushed"}, {"item-name.concrete"}},
  localised_description = {"recipe-description.bi-crushed-stone-2", {"item-name.concrete"}},
  --icon = ICONPATH .. "crushed-stone-concrete.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "crushed-stone.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/concrete.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -16} },
  },
  category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  subgroup = "bio-stone-crusher",
  order = "a[bi]-a-z[bi-9-stone-crushed-3-concrete]",
  energy_required = 2.5,  -- Increased crafting time
  ingredients = {{"concrete", 1}},
  result = "stone-crushed",
  result_count = 2,
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-stone-crushing-2"},
}

-- Crushed stone from hazard concrete
BI.additional_recipes.BI_Stone_Crushing.crushed_stone_hazard_concrete = {
  type = "recipe",
  name = "bi-crushed-stone-hazard-concrete",
  --~ localised_name = {"recipe-name.bi-crushed-stone-2", {"item-name.hazard-concrete"}},
  localised_name = {
    "recipe-name.bi-crushed-stone",
    {"item-name.stone-crushed"},
    {"item-name.hazard-concrete"}
  },
  localised_description = {"recipe-description.bi-crushed-stone-2", {"item-name.hazard-concrete"}},
  --icon = ICONPATH .. "crushed-stone-hazard-concrete.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "crushed-stone.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/hazard-concrete.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -16} },
  },
  category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  subgroup = "bio-stone-crusher",
  order = "a[bi]-a-z[bi-9-stone-crushed-4-hazard-concrete]",
  energy_required = 2.5,  -- Increased crafting time
  ingredients = {{"hazard-concrete", 1}},
  result = "stone-crushed",
  result_count = 2,
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-stone-crushing-2"},
}

-- Crushed stone from refined concrete
BI.additional_recipes.BI_Stone_Crushing.crushed_stone_refined_concrete = {
  type = "recipe",
  name = "bi-crushed-stone-refined-concrete",
  --~ localised_name = {"recipe-name.bi-crushed-stone-2", {"item-name.refined-concrete"}},
  localised_name = {
    "recipe-name.bi-crushed-stone",
    {"item-name.stone-crushed"},
    {"item-name.refined-concrete"}
  },
  localised_description = {"recipe-description.bi-crushed-stone-2", {"item-name.refined-concrete"}},
  --icon = ICONPATH .. "crushed-stone-refined-concrete.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "crushed-stone.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/refined-concrete.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -16} },
  },
  category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  subgroup = "bio-stone-crusher",
  order = "a[bi]-a-z[bi-9-stone-crushed-5-refined-concrete]",
  energy_required = 5,    -- Increased crafting time
  ingredients = {{"refined-concrete", 1}},
  result = "stone-crushed",
  result_count = 4,
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-stone-crushing-2"},
  BI_add_to_tech = {"bi-tech-stone-crushing-3"},
}

-- Crushed stone from refined hazard concrete
BI.additional_recipes.BI_Stone_Crushing.crushed_stone_refined_hazard_concrete = {
  type = "recipe",
  name = "bi-crushed-stone-refined-hazard-concrete",
  --~ localised_name = {"recipe-name.bi-crushed-stone-2", {"item-name.refined-hazard-concrete"}},
  localised_name = {
    "recipe-name.bi-crushed-stone",
    {"item-name.stone-crushed"},
    {"item-name.refined-hazard-concrete"}
  },
  localised_description = {"recipe-description.bi-crushed-stone-2", {"item-name.refined-hazard-concrete"}},
  --icon = ICONPATH .. "crushed-stone-refined-hazard-concrete.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "crushed-stone.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/refined-hazard-concrete.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -16} },
  },
  category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  subgroup = "bio-stone-crusher",
  order = "a[bi]-a-z[bi-9-stone-crushed-6-refined-hazard-concrete]",
  energy_required = 5,    -- Increased crafting time
  ingredients = {{"refined-hazard-concrete", 1}},
  result = "stone-crushed",
  result_count = 4,
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-stone-crushing-2"},
  BI_add_to_tech = {"bi-tech-stone-crushing-3"},
}

-- Stone brick
BI.additional_recipes.BI_Stone_Crushing.stone_brick = {
  type = "recipe",
  name = "bi-stone-brick",
  --icon = ICONPATH .. "bi_stone_brick.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --icons = {
  --  { icon = "__base__/graphics/icons/stone-brick.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  --  { icon = ICONPATH .. "ash.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {16, -16} },
  --  { icon = ICONPATH .. "crushed-stone.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {-16, -16} },
  --},
  --~ icons = BioInd.make_icons({it1 = "stone-brick", it2 = "ash", it3 = "crushed-stone", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}),
  icons = {it1 = "stone-brick", it2 = "ash", it3 = "crushed-stone", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0},
  BI_add_icon = true,
  category = "chemistry",
  subgroup = "terrain",
  order = "a[stone-brick]-bi",
  energy_required = 2.5,
  ingredients = {
    {type = "item", name = "stone-crushed", amount = 3},
    {type = "item", name = "bi-ash", amount = 1},
  },
  results = {
    {type = "item", name = "stone-brick", amount = 1},
  },
  crafting_machine_tint = {
    primary     = util.color("8d846b"),
    secondary   = util.color("776f58"),
    tertiary    = util.color("848380"),
    quaternary  = util.color("848380")
  },
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  allow_as_intermediate = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-coal-processing-2"},
  BI_add_to_tech = {"bi-tech-ash"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "decoration",
  subgroup_5d = "decoration-floor",
  --~ subgroup_order_5d = "n-a",
  order_5d = "a-a-[Bio_Industries]-[decoration-floor]-[bi-stone-brick]",
}


------------------------------------------------------------------------------------
--                              Enable: Terraforming                              --
--                          (BI.Settings.BI_Terraforming)                         --
------------------------------------------------------------------------------------
--- Arboretum (ENTITY)
BI.additional_recipes.BI_Terraforming.arboretum = {
  type = "recipe",
  name = "bi-arboretum",
  localised_name = {"entity-name.bi-arboretum"},
  --~ --  localised_description = {"entity-description.bi-arboretum"},
  icon = ICONPATH .. "entity/terraformer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    energy_required = 10,
    ingredients = {
      {"bi-bio-greenhouse", 4},
      {"assembling-machine-2", 2},
      {"stone-brick", 10},
    },
    result = "bi-arboretum-area",
    result_count = 1,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 15,
    ingredients = {
      {"bi-bio-greenhouse", 4},
      {"assembling-machine-2", 4},
      {"stone-brick", 20},
    },
    result = "bi-arboretum-area",
    result_count = 1,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  subgroup = "bio-arboretum-fluid",
  order = "1-a[bi]",
  always_show_made_in = true,
  --~ --  allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-terraforming-1"},
}

-- Plant trees
BI.additional_recipes.BI_Terraforming.arboretum_r1 = {
  type = "recipe",
  name = "bi-arboretum-r1",
  localised_name = {"recipe-name.bi-arboretum-r1"},
  localised_description = {"recipe-description.bi-arboretum-recipes"},
  icon = ICONPATH .. "change_plant.png",
  icon_size = 128, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.additional_categories.BI_Terraforming.arboretum.name,
  energy_required = 10000,
  ingredients = {
    {type = "item", name = "seedling", amount = 1},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "bi-arboretum-r1", amount = 1, probability = 0},
  },
  enabled = false,
  show_amount_in_title = false,
  --~ always_show_made_in = false,
  always_show_made_in = true,
  allow_decomposition = true,
  allow_as_intermediate = false,
  subgroup = "bio-arboretum-fluid",
  order = "a[bi]-ssw-a1[bi-arboretum-r1]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-terraforming-1"},
}

-- Change terrain (fertilizer)
BI.additional_recipes.BI_Terraforming.arboretum_r2 = {
  type = "recipe",
  name = "bi-arboretum-r2",
  localised_name = {"recipe-name.bi-arboretum-r2"},
  localised_description = {"recipe-description.bi-arboretum-recipes"},
  icon = ICONPATH .. "change_fert_1.png",
  icon_size = 128, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.additional_categories.BI_Terraforming.arboretum.name,
  energy_required = 10000,
  ingredients = {
    {type = "item", name = "fertilizer", amount = 1},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "bi-arboretum-r2", amount = 1, probability = 0},
  },
  crafting_machine_tint = {
    primary     = {r = 0.43, g = 0.73, b = 0.37, a = 0.60},
    secondary   = {r = 0, g = 0, b = 0, a = 0},
    tertiary    = {r = 0, g = 0, b = 0, a = 0},
    quaternary  = {r = 0, g = 0, b = 0, a = 0}
  },
  enabled = false,
  show_amount_in_title = false,
  --~ always_show_made_in = false,
  always_show_made_in = true,
  allow_decomposition = true,
  allow_as_intermediate = false,
  subgroup = "bio-arboretum-fluid",
  order = "a[bi]-ssw-a1[bi-arboretum-r2]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-terraforming-2"},
}

-- Change terrain (advanced fertilizer)
BI.additional_recipes.BI_Terraforming.arboretum_r3 = {
  type = "recipe",
  name = "bi-arboretum-r3",
  localised_name = {"recipe-name.bi-arboretum-r3"},
  localised_description = {"recipe-description.bi-arboretum-recipes"},
  icon = ICONPATH .. "change_fert_2.png",
  icon_size = 128, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.additional_categories.BI_Terraforming.arboretum.name,
  energy_required = 10000,
  ingredients = {
    {type = "item", name = "bi-adv-fertilizer", amount = 1},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "bi-arboretum-r3", amount = 1, probability = 0},
  },
  crafting_machine_tint = {
    primary     = {r = 0.73, g = 0.37, b = 0.52, a = 0.60},
    secondary   = {r = 0, g = 0, b = 0, a = 0},
    tertiary    = {r = 0, g = 0, b = 0, a = 0},
    quaternary  = {r = 0, g = 0, b = 0, a = 0}
  },
  enabled = false,
  show_amount_in_title = false,
  --~ always_show_made_in = false,
  always_show_made_in = true,
  allow_decomposition = true,
  allow_as_intermediate = false,
  subgroup = "bio-arboretum-fluid",
  order = "a[bi]-ssw-a1[bi-arboretum-r4]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-terraforming-3"},
}

-- Plant trees & change terrain (fertilizer)
BI.additional_recipes.BI_Terraforming.arboretum_r4 = {
  type = "recipe",
  name = "bi-arboretum-r4",
  localised_name = {"recipe-name.bi-arboretum-r4"},
  localised_description = {"recipe-description.bi-arboretum-recipes"},
  icon = ICONPATH .. "change_fert_plant_1.png",
  icon_size = 128, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.additional_categories.BI_Terraforming.arboretum.name,
  energy_required = 10000,
  ingredients = {
    {type = "item", name = "seedling", amount = 1},
    {type = "item", name = "fertilizer", amount = 1},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "bi-arboretum-r4", amount = 1, probability = 0},
  },
  crafting_machine_tint = {
    primary     = {r = 0.43, g = 0.73, b = 0.37, a = 0.60},
    secondary   = {r = 0, g = 0, b = 0, a = 0},
    tertiary    = {r = 0, g = 0, b = 0, a = 0},
    quaternary  = {r = 0, g = 0, b = 0, a = 0}
  },
  enabled = false,
  show_amount_in_title = false,
  --~ always_show_made_in = false,
  always_show_made_in = true,
  allow_decomposition = true,
  allow_as_intermediate = false,
  subgroup = "bio-arboretum-fluid",
  order = "a[bi]-ssw-a1[bi-arboretum-r3]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-terraforming-2"},
}

-- Plant trees & change terrain (advanced fertilizer)
BI.additional_recipes.BI_Terraforming.arboretum_r5 = {
  type = "recipe",
  name = "bi-arboretum-r5",
  localised_name = {"recipe-name.bi-arboretum-r5"},
  localised_description = {"recipe-description.bi-arboretum-recipes"},
  icon = ICONPATH .. "change_fert_plant_2.png",
  icon_size = 128, icon_mipmaps = 3,
  BI_add_icon = true,
  category = BI.additional_categories.BI_Terraforming.arboretum.name,
  energy_required = 10000,
  ingredients = {
    {type = "item", name = "seedling", amount = 1},
    {type = "item", name = "bi-adv-fertilizer", amount = 1},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "item", name = "bi-arboretum-r5", amount = 1, probability = 0},
  },
  crafting_machine_tint = {
    primary     = {r = 0.73, g = 0.37, b = 0.52, a = 0.60},
    secondary   = {r = 0, g = 0, b = 0, a = 0},
    tertiary    = {r = 0, g = 0, b = 0, a = 0},
    quaternary  = {r = 0, g = 0, b = 0, a = 0}
  },
  enabled = false,
  show_amount_in_title = false,
  --~ always_show_made_in = false,
  always_show_made_in = true,
  allow_decomposition = true,
  allow_as_intermediate = false,
  subgroup = "bio-arboretum-fluid",
  order = "a[bi]-ssw-a1[bi-arboretum-r5]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-terraforming-3"},
}


------------------------------------------------------------------------------------
--                          Enable: BI_Pollution_Detector                         --
--                       (BI.Settings.BI_Pollution_Detector)                      --
------------------------------------------------------------------------------------
-- Pollution sensor
BI.additional_recipes.BI_Pollution_Detector.pollution_sensor = {
  type = "recipe",
  name = "bi-pollution-sensor",
  localised_name = {"entity-name.bi-pollution-sensor"},
  -- localised_description = {"entity-description.bi-bio-reactor"},
  icon = ICONPATH .. "entity/pollution_sensor.png",
  icon_size = 64, icon_mipmaps = 4,
  BI_add_icon = true,
  normal = {
    enabled = false,
    energy_required = 1,
    ingredients =
    {
      {"constant-combinator", 1},
      {"advanced-circuit", 5}
    },
    result = "bi-pollution-sensor",
    result_count = 1,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {"constant-combinator", 2},
      {"advanced-circuit", 6}
    },
    result = "bi-pollution-sensor",
    result_count = 1,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  subgroup = "circuit-network",
  order = "c[combinators]-c[constant-combinator2]",
  -- always_show_made_in = true,
  -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4  },
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-pollution-sensor"},
}



------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
-- Large wooden chest
BI.additional_recipes.BI_Wood_Products.large_wooden_chest = {
  type = "recipe",
  name = "bi-wooden-chest-large",
  localised_name = {"entity-name.bi-wooden-chest-large"},
  --~ -- localised_description = {"entity-description.bi-wooden-chest-large"},
  icon = ICONPATH .. "entity/wood_chest_large.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    energy_required = 2,
    enabled = false,
    ingredients = {
      {"copper-plate", 16},
      {"resin", 24},
      {"wooden-chest", 8}
    },
    result = "bi-wooden-chest-large",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    energy_required = 4,
    enabled = false,
    ingredients = {
      {"copper-plate", 24},
      {"resin", 32},
      {"wooden-chest", 8}
    },
    result = "bi-wooden-chest-large",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = true,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-wooden-storage-1"},
}


-- Huge wooden chest
BI.additional_recipes.BI_Wood_Products.huge_wooden_chest = {
  type = "recipe",
  name = "bi-wooden-chest-huge",
  localised_name = {"entity-name.bi-wooden-chest-huge"},
  --~ -- localised_description = {"entity-description.bi-wooden-chest-huge"},
  icon = ICONPATH .. "entity/wood_chest_huge.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    energy_required = 2,
    enabled = false,
    ingredients = {
      {"iron-stick", 32},
      {"stone-brick", 32},
      {"bi-wooden-chest-large", 16}
    },
    result = "bi-wooden-chest-huge",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    energy_required = 4,
    enabled = false,
    ingredients = {
      {"iron-stick", 48},
      {"stone-brick", 48},
      {"bi-wooden-chest-large", 16}
    },
    result = "bi-wooden-chest-huge",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = true,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-wooden-storage-2"},
}


-- Gigantic wooden chest
BI.additional_recipes.BI_Wood_Products.giga_wooden_chest = {
  type = "recipe",
  name = "bi-wooden-chest-giga",
  localised_name = {"entity-name.bi-wooden-chest-giga"},
  --~ -- localised_description = {"entity-description.bi-wooden-chest-giga"},
  icon = ICONPATH .. "entity/wood_chest_giga.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    energy_required = 4,
    enabled = false,
    ingredients = {
      {"steel-plate", 32},
      {"concrete", 32},
      {"bi-wooden-chest-huge", 16}
    },
    result = "bi-wooden-chest-giga",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    energy_required = 6,
    enabled = false,
    ingredients = {
      {"steel-plate", 48},
      {"concrete", 48},
      {"bi-wooden-chest-huge", 16}
    },
    result = "bi-wooden-chest-giga",
    result_count = 1,
    requester_paste_multiplier = 4,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ -- always_show_made_in = true,
  --~ -- allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-wooden-storage-3"},
}


-- Big Electric Pole
BI.additional_recipes.BI_Wood_Products.big_pole = {
  type = "recipe",
  name = "bi-wooden-pole-big",
  localised_name = {"entity-name.bi-wooden-pole-big"},
  --~ localised_description = {"entity-description.bi-wooden-pole-big"},
  icon = ICONPATH .. "entity/wood_pole_big.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    ingredients = {
      {"wood", 5},
      {"small-electric-pole", 2},
    },
    result = "bi-wooden-pole-big",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    ingredients = {
      {"wood", 10},
      {"small-electric-pole", 4},
    },
    result = "bi-wooden-pole-big",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-b[small-electric-pole]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-wooden-pole-1"},
}

--- Huge Wooden Pole
BI.additional_recipes.BI_Wood_Products.huge_pole = {
  type = "recipe",
  name = "bi-wooden-pole-huge",
  localised_name = {"entity-name.bi-wooden-pole-huge"},
  --~ localised_description = {"entity-description.bi-wooden-pole-huge"},
  icon = ICONPATH .. "entity/wood_pole_huge.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    enabled = false,
    ingredients = {
      {"wood", 5},
      {"concrete", 100},
      {"bi-wooden-pole-big", 6},
    },
    result = "bi-wooden-pole-huge",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    ingredients = {
      {"wood", 10},
      {"concrete", 150},
      {"bi-wooden-pole-big", 10},
    },
    result = "bi-wooden-pole-huge",
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "energy-pipe-distribution",
  order = "a[energy]-d[big-electric-pole]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-wooden-pole-2"},
}

--- Wood Pipe
BI.additional_recipes.BI_Wood_Products.wood_pipe = {
  type = "recipe",
  name = "bi-wood-pipe",
  localised_name = {"entity-name.bi-wood-pipe"},
  --~ localised_description = {"entity-description.bi-wood-pipe"},
  icon = ICONPATH .. "entity/wood_pipe.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    energy_required = 1,
    enabled = true,
    ingredients = {
      {"copper-plate", 1},
      {"wood", 8}
    },
    result = "bi-wood-pipe",
    result_count = 4,
    requester_paste_multiplier = 15,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    energy_required = 2,
    enabled = true,
    ingredients = {
      {"copper-plate", 1},
      {"wood", 12}
    },
    result = "bi-wood-pipe",
    result_count = 4,
    requester_paste_multiplier = 15,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "energy-pipe-distribution",
  order = "a[pipe]-1a[pipe]",
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
}

-- Wood Pipe to Ground
BI.additional_recipes.BI_Wood_Products.wood_pipe_to_ground = {
  type = "recipe",
  name = "bi-wood-pipe-to-ground",
  localised_name = {"entity-name.bi-wood-pipe-to-ground"},
  --~ localised_description = {"entity-description.bi-wood-pipe-to-ground"},
  icon = ICONPATH .. "entity/wood_pipe_to_ground.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  normal = {
    energy_required = 2,
    enabled = true,
    ingredients = {
      {"copper-plate", 4},
      {"bi-wood-pipe", 5}
    },
    result = "bi-wood-pipe-to-ground",
    result_count = 2,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  expensive = {
    energy_required = 4,
    enabled = true,
    ingredients = {
      {"copper-plate", 5},
      {"bi-wood-pipe", 6}
    },
    result = "bi-wood-pipe-to-ground",
    result_count = 2,
    allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
    always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  },
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
  always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "energy-pipe-distribution",
  order = "a[pipe]-1b[pipe-to-ground]",
}


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
-- Bio cannon
BI.additional_recipes.Bio_Cannon.bio_cannon = {
  type = "recipe",
  name = "bi-bio-cannon",
  localised_name = {"entity-name.bi-bio-cannon"},
  --~ localised_description = {"entity-description.bi-bio.cannon"},
  normal = {
    enabled = false,
    energy_required = 50,
    ingredients = {
      {"concrete", 100},
      {"radar", 1},
      {"steel-plate", 80},
      {"electric-engine-unit", 5},
    },
    --~ result = "bi-bio-cannon-area",
    result = "bi-bio-cannon",
    result_count = 1,
    allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
    always_show_made_in = false,    -- Added for 0.18.34/1.1.4
    allow_decomposition = true,     -- Added for 0.18.34/1.1.4
  },
  expensive = {
    enabled = false,
    energy_required = 100,
    ingredients = {
      {"concrete", 100},
      {"radar", 1},
      {"steel-plate", 120},
      {"electric-engine-unit", 15},
    },
    --~ result = "bi-bio-cannon-area",
    result = "bi-bio-cannon",
    result_count = 1,
    allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
    always_show_made_in = false,    -- Added for 0.18.34/1.1.4
    allow_decomposition = true,     -- Added for 0.18.34/1.1.4
  },
  allow_as_intermediate = false,
  always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,       -- Changed for 0.18.34/1.1.4
  subgroup = "defensive-structure",
  order = "b[turret]-e[bi-prototype-artillery-turret]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-cannon-1"},
}

-- Prototype Ammo
BI.additional_recipes.Bio_Cannon.bio_cannon_ammo_proto = {
  type = "recipe",
  name = "bi-bio-cannon-ammo-proto",
  --localised_name = {"item-name.bi-bio-cannon-ammo-proto"},
  --localised_description = {"item-description.bi-bio-cannon-ammo-proto"},
  --~ localised_description = {"item-description.bi-bio-cannon-ammo"},
  enabled = false,
  energy_required = 2,
  ingredients = {
    {"iron-plate", 10},
    {"explosives", 10}
  },
  result = "bi-bio-cannon-ammo-proto",
  result_count = 1,
  subgroup = "bi-ammo",
  order = "z[Bio_Cannon_Ammo]-a[Proto]",
  allow_as_intermediate = true,     -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Added for 0.18.34/1.1.4
  allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  BI_add_to_tech = {"bi-tech-bio-cannon-1"},
}

-- Basic Ammo
BI.additional_recipes.Bio_Cannon.bio_cannon_ammo_basic = {
  type = "recipe",
  name = "bi-bio-cannon-ammo-basic",
  --localised_name = {"item-name.bi-bio-cannon-ammo-basic"},
  --localised_description = {"item-description.bi-bio-cannon-ammo-basic"},
  --~ localised_description = {"item-description.bi-bio-cannon-ammo"},
  enabled = false,
  energy_required = 4,
  ingredients = {
    {"bi-bio-cannon-ammo-proto", 1},
    {"rocket", 10}
  },
  result = "bi-bio-cannon-ammo-basic",
  result_count = 1,
  subgroup = "bi-ammo",
  order = "z[Bio_Cannon_Ammo]-b[Basic]",
  allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Added for 0.18.34/1.1.4
  allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  BI_add_to_tech = {"bi-tech-bio-cannon-2"},
}

-- Poison Ammo
BI.additional_recipes.Bio_Cannon.bio_cannon_ammo_poison = {
  type = "recipe",
  name = "bi-bio-cannon-ammo-poison",
  --localised_name = {"item-name.bi-bio-cannon-ammo-poison"},
  --localised_description = {"item-description.bi-bio-cannon-ammo-poison"},
  --~ localised_description = {"item-description.bi-bio-cannon-ammo"},
  enabled = false,
  energy_required = 8,
  ingredients = {
    {"bi-bio-cannon-ammo-basic", 1},
    {"poison-capsule", 5},
    {"explosive-rocket", 5}
  },
  result = "bi-bio-cannon-ammo-poison",
  result_count = 1,
  subgroup = "bi-ammo",
  order = "z[Bio_Cannon_Ammo]-c[Poison]",
  allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Added for 0.18.34/1.1.4
  allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  BI_add_to_tech = {"bi-tech-bio-cannon-3"},
}

-- Poison artillery shell
BI.additional_recipes.Bio_Cannon.poison_artillery_shell = {
  type = "recipe",
  name = "bi-poison-artillery-shell",
  --localised_name = {"item-name.bi-bio-cannon-ammo-poison"},
  --localised_description = {"item-description.bi-bio-cannon-ammo-poison"},
  enabled = false,
  energy_required = 8,
  ingredients = {
    {"artillery-shell", 1},
    {"poison-capsule", 5},
  },
  result = "bi-poison-artillery-shell",
  result_count = 1,
  subgroup = "ammo",
  order = "d[explosive-cannon-shell]-d[artillery]-[bi-poison]",
  allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
  always_show_made_in = false,      -- Added for 0.18.34/1.1.4
  allow_decomposition = true,       -- Added for 0.18.34/1.1.4
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  BI_add_to_tech = {"artillery"},
}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                   Game tweaks                                  --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                            Enable: Wood gasification                           --
--                       (BI.Settings.BI_Wood_Gasification)                       --
------------------------------------------------------------------------------------
BI.additional_recipes.BI_Wood_Gasification.wood_gasification = {
  type = "recipe",
  name = "bi-wood-gasification",
  category = "chemistry",
  subgroup = BI.default_item_subgroup.bio_fuel_fluid.name,
  order = "z[bi-wood-gasification]",
  enabled = false,
  energy_required = 5,
  ingredients = {
    {type="item", name="wood", amount=10},
  },
  results = {
    {type="fluid", name="petroleum-gas", amount=20},
    {type="fluid", name="tar", amount=8},
  },
  subgroup = "bio-bio-fuel-other",
  order = "[bi-tar]",
  --icon = ICONPATH .. "diluted_bitumen_from_wood.png",
  --icon_size = 64, icon_mipmaps = 4,
  --BI_add_icon = true,
  icons = {
    { icon = ICONPATH .. "fluid_diluted_bitumen.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = "__base__/graphics/icons/fluid/petroleum-gas.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {18, 20} },
    { icon = "__base__/graphics/icons/fluid/petroleum-gas.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {-18, 20} },
    { icon = ICONPATH .. "fluid_diluted_bitumen.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
  },
  crafting_machine_tint = {
    primary     = util.color("7e98b0"),
    secondary   = util.color("6c859c"),
    tertiary    = util.color("81785d"),
    quaternary  = util.color("81785d")
  },
  main_product = "",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-wood-gasification"},
}

BI.additional_recipes.BI_Wood_Gasification.solid_fuel = {
  type = "recipe",
  name = "solid-fuel-from-tar",
  category = "chemistry",
  enabled = false,
  energy_required = 5,
  --icon = ICONPATH .. "solid_fuel_from_bitumen.png",
  --icon_size = 64, icon_mipmaps = 4,
  --BI_add_icon = true,
  icons = {
    { icon = "__base__/graphics/icons/solid-fuel.png", icon_size = 64, icon_mipmaps = 4, scale = 1, shift = {0, 0} },
    { icon = ICONPATH .. "fluid_diluted_bitumen.png", icon_size = 64, icon_mipmaps = 4, scale = 0.5, shift = {-18, -16} },
  },
  ingredients = {
    {type="fluid", name="tar", amount=32},
  },
  results = {
    {type="item", name="solid-fuel", amount=1},
  },
  crafting_machine_tint = {
    primary     = util.color("2a3035"),
    secondary   = util.color("242f37"),
    tertiary    = util.color("7e98b0"),
    quaternary  = util.color("6c859c")
  },
  subgroup = "fluid-recipes",
  order = "b[fluid-chemistry]-c[solid-fuel-from-tar]",
  always_show_products = true,
  always_show_made_in = true,
  allow_decomposition = false,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-wood-gasification"},
  -- Group/subgroup if "5Dim's mod - New Core" is used
  group_5d = "liquid",
  subgroup_5d = "liquid-recipe",
  --~ subgroup_order_5d = "n-a",
  order_5d = "b[fluid-chemistry]-g[solid-fuel-from-tar]",
}


------------------------------------------------------------------------------------
--           Game tweaks: Alternative recipe for Production Science Pack          --
--                 (BI.Settings.BI_Game_Tweaks_Production_Science)                --
------------------------------------------------------------------------------------
-- Alternative recipe for Production Science Pack
BI.additional_recipes.BI_Game_Tweaks_Production_Science.production_science_pack = {
  type = "recipe",
  name = "bi-production-science-pack",
  enabled = false,
  energy_required = 21,
  ingredients = {
    {"electric-furnace", 1},
    {"productivity-module", 1},
    {"bi-rail-wood", 40}
  },
  result_count = 3,
  result = "production-science-pack",
  order = "e[production-science-pack]-[Bio Industries]",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"production-science-pack"},
}



--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------
--~ --                                    Triggers                                    --
--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------


--~ ------------------------------------------------------------------------------------
--~ --                            Trigger: Easy Bio gardens                           --
--~ --                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
--~ ------------------------------------------------------------------------------------
--~ -- Fertilizer fluid (Tints will be added later)
--~ BI.additional_recipes.BI_Trigger_Easy_Bio_Gardens.fertilizer_fluid = {
  --~ type = "recipe",
  --~ name = "bi-fertilizer-fluid",
  --~ localised_description = {
    --~ "recipe-description.bi-fertilizer-fluid",
    --~ {"fluid-name.water"},
  --~ },
  --~ icon = ICONPATH .. "fluid_fertilizer.png",
  --~ icon_size = 64, icon_mipmaps = 3,
  --~ BI_add_icon = true,
  --~ category = "chemistry",
  --~ energy_required = 5,
  --~ ingredients = {
    --~ {type = "item", name = "fertilizer", amount = 3},
    --~ {type = "fluid", name = "water", amount = 100},
  --~ },
  --~ results = {
    --~ {type = "fluid", name = "bi-fertilizer-fluid", amount = 100}
  --~ },
  --~ main_product = "",
  --~ enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  --~ subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "b[bi-fertilizer]-b[bi-fertilizer-fluid-1]",
  --~ -- This will be added in optionsEasyBioGardens.lua!
  --~ crafting_machine_tint = {
    --~ primary     = util.color("5e9347"),
    --~ secondary   = util.color("72be51"),
    --~ tertiary    = util.color("63ae42"),
    --~ quaternary  = util.color("58af33")
  --~ },
  --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-fertilizer"},
--~ }

--~ -- Advanced fertilizer fluid (Tints will be added later)
--~ BI.additional_recipes.BI_Trigger_Easy_Bio_Gardens.adv_fertilizer_fluid = {
  --~ type = "recipe",
  --~ name = "bi-adv-fertilizer-fluid",
  --~ localised_description = {
    --~ "recipe-description.bi-adv-fertilizer-fluid",
    --~ {"fluid-name.water"},
  --~ },
  --~ icon = ICONPATH .. "fluid_fertilizer_advanced.png",
  --~ icon_size = 64, icon_mipmaps = 3,
  --~ BI_add_icon = true,
  --~ category = "chemistry",
  --~ energy_required = 5,
  --~ ingredients = {
    --~ {type = "item", name = "bi-adv-fertilizer", amount = 3},
    --~ {type = "fluid", name = "water", amount = 100},
  --~ },
  --~ results = {
    --~ {type = "fluid", name = "bi-adv-fertilizer-fluid", amount = 100}
  --~ },
  --~ main_product = "",
  --~ enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  --~ subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  --~ order = "b[bi-fertilizer]-b[bi-fertilizer-fluid-2]",
  --~ -- This will be added in optionsEasyBioGardens.lua!
  --~ crafting_machine_tint = {
    --~ primary     = util.color("d04677"),
    --~ secondary   = util.color("b82e5f"),
    --~ tertiary    = util.color("b64f73"),
    --~ quaternary  = util.color("b85e84")
  --~ },
  --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
  --~ BI_add_to_tech = {"bi-tech-advanced-fertilizer"},
--~ }


--~ ------------------------------------------------------------------------------------
--~ --                General recipe for sand (will be adjusted later)                --
--~ ------------------------------------------------------------------------------------
--~ -- Angel's Smelting ("angelssmelting"),
--~ -- BioTech ("BioTech"),
--~ -- Krastorio2 ("Krastorio2")
--~ BI.additional_recipes.BI_Trigger_Sand.sand = {
  --~ type = "recipe",
  --~ name = "bi-sand",
  --~ --icon = ICONPATH .. "mod_aai/sand-aai.png",
  --~ --icon_size = 64, icon_mipmaps = 3,
  --~ --BI_add_icon = true,
  --icons = BioInd.make_icons({it1 = "sand", it2 = "crushed-stone", shift1_1=0 , shift1_2=0}),
  --~ icons = {it1 = "sand", it2 = "crushed-stone", shift1_1=0 , shift1_2=0},
  --~ BI_add_icon = true,
  --~ BI_add_to_tech = {"bi-tech-stone-crushing-1"},
  --~ category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  --subgroup = "bio-bio-farm-raw",
  --~ subgroup = BI.additional_categories.BI_Stone_Crushing.stone_crusher.name,
  --order = "a[bi]-a-z[bi-9-sand]",
  --~ order = "a[bi]-a-z[bi-9-stone-crushed-sand-1]",
  --~ energy_required = 1,
  --~ ingredients = {{"stone-crushed", 2}},
  --result = "sand",
  --result_count = 5,
  --~ main_product = "",
  --~ enabled = false,
  --always_show_made_in = true,
  --allow_decomposition = false,
  --allow_as_intermediate = false,
  --~ allow_as_intermediate = true,     -- Changed for 0.18.34/1.1.4
  --~ always_show_made_in = true,       -- Changed for 0.18.34/1.1.4
  --~ allow_decomposition = true,               -- Changed for 0.18.34/1.1.4
--~ }



-- Status report
BioInd.debugging.readdata_msg(BI.additional_recipes, settings,
                    "optional recipes", "setting")
--~ BioInd.debugging.readdata_msg(BI.additional_recipes, triggers,
                    --~ "optional recipes", "trigger")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
