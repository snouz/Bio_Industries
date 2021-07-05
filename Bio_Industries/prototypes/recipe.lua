local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath


data:extend({

  --- Seeds from Water (BASIC)
  {
    type = "recipe",
    name = "bi-seed-1",
    localised_name = {"recipe-name.bi-seed-1"},
    icon = ICONPATH .. "bio_seed1.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bio_seed1.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
  },


  --- Seeds from Water & Ash
  {
    type = "recipe",
    name = "bi-seed-2",
    localised_name = {"recipe-name.bi-seed-2"},
    icon = ICONPATH .. "bio_seed2.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bio_seed2.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    allow_as_intermediate = false,
  },


  --- Seeds from Water & fertilizer
  {
    type = "recipe",
    name = "bi-seed-3",
    localised_name = {"recipe-name.bi-seed-3"},
    icon = ICONPATH .. "bio_seed3.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bio_seed3.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    allow_as_intermediate = false,
    crafting_machine_tint = { primary = {r=0.43,g=0.73,b=0.37,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  --- Seeds from Water & Adv-fertilizer
  {
    type = "recipe",
    name = "bi-seed-4",
    localised_name = {"recipe-name.bi-seed-4"},
    icon = ICONPATH .. "bio_seed4.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bio_seed4.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    allow_as_intermediate = false,
    crafting_machine_tint = { primary = {r=0.73,g=0.37,b=0.52,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  --- Seedlings from Water (BASIC)
  {
    type = "recipe",
    name = "bi-seedling-1",
    localised_name = {"recipe-name.bi-seedling-1"},
    icon = ICONPATH .. "Seedling1.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling1.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    order = "b[bi]-ssw-b1[bi-Seedling_Mk1]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },


  --- Seedlings from Water & Ash
  {
    type = "recipe",
    name = "bi-seedling-2",
    localised_name = {"recipe-name.bi-seedling-2"},
    icon = ICONPATH .. "Seedling2.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling2.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    order = "b[bi]-ssw-b1[bi-Seedling_Mk2]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    allow_as_intermediate = false,
  },


  --- Seedlings from Water & fertilizer
  {
    type = "recipe",
    name = "bi-seedling-3",
    localised_name = {"recipe-name.bi-seedling-3"},
    icon = ICONPATH .. "Seedling3.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling3.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    order = "b[bi]-ssw-b1[bi-Seedling_Mk3]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    allow_as_intermediate = false,
    crafting_machine_tint = { primary = {r=0.43,g=0.73,b=0.37,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  --- Seedlings from Water & Adv-fertilizer
  {
    type = "recipe",
    name = "bi-seedling-4",
    localised_name = {"recipe-name.bi-seedling-4"},
    icon = ICONPATH .. "Seedling4.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling4.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    order = "b[bi]-ssw-b1[bi-Seedling_Mk4]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    allow_as_intermediate = false,
    crafting_machine_tint = { primary = {r=0.73,g=0.37,b=0.52,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  --- Raw Wood from Water (BASIC)
  {
    type = "recipe",
    name = "bi-logs-1",
    icon = ICONPATH .. "raw-wood-mk1.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "raw-wood-mk1.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    allow_as_intermediate = false,
  },


  --- Raw Wood from Water & Ash
  {
    type = "recipe",
    name = "bi-logs-2",
    icon = ICONPATH .. "raw-wood-mk2.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "raw-wood-mk2.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    allow_as_intermediate = false,
  },


  --- Raw Wood from Water & fertilizer
  {
    type = "recipe",
    name = "bi-logs-3",
    icon = ICONPATH .. "raw-wood-mk3.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "raw-wood-mk3.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    allow_as_intermediate = false,
    crafting_machine_tint = { primary = {r=0.43,g=0.73,b=0.37,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  --- Raw Wood from adv-fertilizer
  {
    type = "recipe",
    name = "bi-logs-4",
    icon = ICONPATH .. "raw-wood-mk4.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "raw-wood-mk4.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    allow_as_intermediate = false,
    crafting_machine_tint = { primary = {r=0.73,g=0.37,b=0.52,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },



  -- Woodpulp--
  {
    type = "recipe",
    name = "bi-woodpulp",
    icon = ICONPATH .. "Woodpulp_raw-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Woodpulp_raw-wood.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
  },


  --- Resin recipe Pulp
  {
    type = "recipe",
    name = "bi-resin-pulp",
    icon = ICONPATH .. "bi_resin_pulp.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bi_resin_pulp.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    subgroup = "bio-bio-farm-raw",
    order = "a[bi]-a-ba[bi-2-resin-2-pulp]",
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    energy_required = 1,
    ingredients = {
       {type = "item", name = "bi-woodpulp", amount = 3},
    },
    result = "resin",
    result_count = 1,
    allow_as_intermediate = true,       -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Added for 0.18.34/1.1.4
    allow_decomposition = false,        -- Added for 0.18.34/1.1.4
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },



  -- Wood from pulp--
  {
    type = "recipe",
    name = "bi-wood-from-pulp",
    icon = ICONPATH .. "wood_from_pulp.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "wood_from_pulp.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    subgroup = "bio-bio-farm-raw",
    order = "a[bi]-a-c[bi-3-wood_from_pulp]",
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    energy_required = 1.25,
    ingredients = {
       {type = "item", name = "bi-woodpulp", amount = 4},
       {type = "item", name = "resin", amount = 1},
    },
    result = "wood",
    result_count = 2,
    --~ allow_as_intermediate = true,       -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Added for 0.18.34/1.1.4
    allow_decomposition = false,        -- Added for 0.18.34/1.1.4
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    allow_as_intermediate = false,
  },



  -- Wood Fuel Brick
  {
    type = "recipe",
    name = "bi-wood-fuel-brick",
    --~ localised_name = {"item-name.wood-bricks"},
    --~ localised_description = {"item-description.wood-bricks"},
    icon = ICONPATH .. "Fuel_Brick.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Fuel_Brick.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    subgroup = "bio-bio-farm-raw",
    order = "a[bi]-a-bx[bi-4-woodbrick]",
    energy_required = 2,
    ingredients = {{"bi-woodpulp", 24}},
    result = "wood-bricks",
    result_count = 1,
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },


  -- ASH --
  {
    type = "recipe",
    name = "bi-ash-1",
    icon = ICONPATH .. "ash_raw-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "ash_raw-wood.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-smelting",
    subgroup = "bio-cokery",
    order = "a[bi]-a-cb[bi-5-ash-1]",
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
  },


  -- ASH 2--
  {
    type = "recipe",
    name = "bi-ash-2",
    icon = ICONPATH .. "ash_woodpulp.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "ash_woodpulp.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-smelting",
    subgroup = "bio-cokery",
    order = "a[bi]-a-ca[bi-5-ash-2]",
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
    allow_as_intermediate = false,
  },


  -- CHARCOAL 1
  {
    type = "recipe",
    name = "bi-charcoal-1",
    icon = ICONPATH .. "charcoal_woodpulp.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "charcoal_woodpulp.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-smelting",
    subgroup = "bio-cokery",
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
  },


  -- CHARCOAL 2
  {
    type = "recipe",
    name = "bi-charcoal-2",
    icon = ICONPATH .. "charcoal_raw-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "charcoal_raw-wood.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    subgroup = "bio-cokery",
    order = "a[bi]-a-d[bi-6-charcoal-2]",
    category = "biofarm-mod-smelting",
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
  },


  -- COAL 1 --
  {
    type = "recipe",
    name = "bi-coal-1",
    icon = ICONPATH .. "coal.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "coal_mk1.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-smelting",
    subgroup = "bio-cokery",
    order = "a[bi]-a-ea[bi-6-coal-1]",
    energy_required = 20,
    ingredients = {{"wood-charcoal", 10}},
    result = "coal",
    result_count = 12,
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4

  },


  -- COAL 2 --
  {
    type = "recipe",
    name = "bi-coal-2",
    icon = ICONPATH .. "coal_mk2.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "coal_mk2.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-smelting",
    subgroup = "bio-cokery",
    order = "a[bi]-a-eb[bi-6-coal-2]",
    energy_required = 20,
    ingredients = {{"wood-charcoal", 10}},
    result = "coal",
    result_count = 16,
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4

  },


  -- Solid Fuel
  {
    type = "recipe",
    name = "bi-solid-fuel",
    icon = ICONPATH .. "bi_solid_fuel_wood_brick.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bi_solid_fuel_wood_brick.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    subgroup = "bio-bio-farm-raw",
    order = "a[bi]-a-fa[bi-7-solid_fuel]",
    category = "chemistry",
    energy_required = 2,
    ingredients = {{"wood-bricks", 3}},
    result = "solid-fuel",
    result_count = 2,
    show_amount_in_title = false,
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
    always_show_made_in = true, -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4

  },


  -- Pellet-Coke from Coal -- Used to be Coke-Coal
    {
    type = "recipe",
    name = "bi-coke-coal",
    --~ localised_name = {"item-name.pellet-coke"},
    --~ localised_description = {"item-description.pellet-coke"},
    icon = ICONPATH .. "pellet_coke_coal.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "pellet_coke_coal.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-smelting",
    subgroup = "bio-cokery",
    order = "a[bi]-a-g[bi-8-coke-coal]-1",
    energy_required = 20,
    ingredients = {{"coal", 12}},
    result = "pellet-coke",
    result_count = 2,
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_as_intermediate = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4

  },


    -- Pellet-Coke from Solid Fuel -- Used to be Coke-Coal
    {
    type = "recipe",
    name = "bi-pellet-coke",
    --~ localised_name = {"item-name.pellet-coke"},
    --~ localised_description = {"item-description.pellet-coke"},
    icon = ICONPATH .. "pellet_coke_solid.png",
    --icon = "__Bio_Industries__/graphics/icons/pellet_coke_c.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "pellet_coke_solid.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-smelting",
    subgroup = "bio-cokery",
    order = "a[bi]-a-g[bi-8-coke-coal]-3",
    energy_required = 6,
    ingredients = {{"solid-fuel", 5}},
    result = "pellet-coke",
    result_count = 3,
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_as_intermediate = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },

 -- CRUSHED STONE from stone --
  {
    type = "recipe",
    name = "bi-crushed-stone-1",
    icon = ICONPATH .. "crushed-stone-stone.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "crushed-stone-stone.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-crushing",
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

  },

 -- CRUSHED STONE from concrete --
  {
    type = "recipe",
    name = "bi-crushed-stone-2",
    --localised_description = {"recipe-description.bi-crushed-stone"},
    icon = ICONPATH .. "crushed-stone-concrete.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "crushed-stone-concrete.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-crushing",
    subgroup = "bio-stone-crusher",
    order = "a[bi]-a-z[bi-9-stone-crushed-2]",
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
  },

 -- CRUSHED STONE from hazard concrete --
  {
    type = "recipe",
    name = "bi-crushed-stone-3",
    --localised_description = {"recipe-description.bi-crushed-stone"},
    icon = ICONPATH .. "crushed-stone-hazard-concrete.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "crushed-stone-hazard-concrete.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-crushing",
    subgroup = "bio-stone-crusher",
    order = "a[bi]-a-z[bi-9-stone-crushed-3]",
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
  },

 -- CRUSHED STONE from refined concrete --
  {
    type = "recipe",
    name = "bi-crushed-stone-4",
    --localised_description = {"recipe-description.bi-crushed-stone"},
    icon = ICONPATH .. "crushed-stone-refined-concrete.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "crushed-stone-refined-concrete.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-crushing",
    subgroup = "bio-stone-crusher",
    order = "a[bi]-a-z[bi-9-stone-crushed-4]",
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
  },

 -- CRUSHED STONE from refined hazard concrete --
  {
    type = "recipe",
    name = "bi-crushed-stone-5",
    --localised_description = {"recipe-description.bi-crushed-stone"},
    icon = ICONPATH .. "crushed-stone-refined-hazard-concrete.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "crushed-stone-refined-hazard-concrete.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "biofarm-mod-crushing",
    subgroup = "bio-stone-crusher",
    order = "a[bi]-a-z[bi-9-stone-crushed-5]",
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
  },

 -- STONE Brick--
  {
    type = "recipe",
    name = "bi-stone-brick",
    icon = ICONPATH .. "bi_stone_brick.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bi_stone_brick.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    --category = "smelting",
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
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    always_show_made_in = true,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    allow_as_intermediate = false,
  },



  -- LIQUID-AIR --
  {
    type = "recipe",
    name = "bi-liquid-air",
    icon = ICONPATH .. "liquid-air.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "liquid-air.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "chemistry",
    energy_required = 1,
    ingredients = {},
    results = {
      {type = "fluid", name = "liquid-air", amount = 10}
    },
    enabled = false,
    always_show_made_in = true,
    allow_decomposition = false,
    allow_as_intermediate = false,
    subgroup = "bio-bio-farm-intermediate-product",
    order = "aa",
  },

  ---NITROGEN --
  {
    type = "recipe",
    name = "bi-nitrogen",
    icon = ICONPATH .. "nitrogen.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "nitrogen.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "chemistry",
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "liquid-air", amount = 10}
    },
    results = {
      {type = "fluid", name = "nitrogen", amount = 10},
    },
    enabled = false,
    always_show_made_in = true,
    allow_decomposition = false,
    allow_as_intermediate = false,
    --main_product= "nitrogen",
    subgroup = "bio-bio-farm-intermediate-product",
    order = "ab",
  },


  -- fertilizer- Sulfur-
  {
    type = "recipe",
    name = "bi-fertilizer-1",
    icon = ICONPATH .. "fertilizer.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "fertilizer_sulfur.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
  },


-- BIOMASS 1 --
  {
    type = "recipe",
    name = "bi-biomass-1",
    localised_name = {"recipe-name.bi-biomass-1"},
    localised_description = {"recipe-description.bi-biomass-1"},
    icon = ICONPATH .. "biomass_1.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "biomass_1.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    order = "x[oil-processing]-z1[bi-biomass]"
  },

  -- Advanced fertilizer 1 --
  {
    type = "recipe",
    name = "bi-adv-fertilizer-1",
    icon = ICONPATH .. "fertilizer_advanced.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "advanced_fertilizer_64.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "chemistry",
    energy_required = 50,
    ingredients = {
      {type = "item", name = "fertilizer", amount = 25},
      {type = "fluid", name = "bi-biomass", amount = 10}, -- <== Need to add during Data Updates
      --{type = "fluid", name = "NE_enhanced-nutrient-solution", amount = 5}, -- Will be added if you have Natural Evolution Buildings Mod installed.
    },
    results = {
      {type = "item", name = "bi-adv-fertilizer", amount = 50}
    },
    enabled = false,
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,
    allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
    always_show_made_in = true,         -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    subgroup = "bio-bio-farm-intermediate-product",
    order = "b[bi-fertilizer]-b[bi-adv-fertilizer-1]",
  },


  -- Advanced fertilizer 2--
  {
    type = "recipe",
    name = "bi-adv-fertilizer-2",
    icon = ICONPATH .. "fertilizer_advanced.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "advanced_fertilizer_64.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
  },


  --- Seed Bomb - Basic
  {
    type = "recipe",
    name = "bi-seed-bomb-basic",
    --~ localised_name = {"item-name.bi-seed-bomb-basic"},
    --~ localised_description = {"item-description.bi-seed-bomb-basic"},
    icon = ICONPATH .. "weapon/Seed_bomb_icon_b.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seed_bomb_icon_b.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
    always_show_made_in = false,        -- Added for 0.18.34/1.1.4
    allow_decomposition = true,         -- Added for 0.18.34/1.1.4
    subgroup = "bi-ammo",
    order = "a[rocket-launcher]-x[seed-bomb]-a",
  },


  --- Seed Bomb - Standard
  {
    type = "recipe",
    name = "bi-seed-bomb-standard",
    --~ localised_name = {"item-name.bi-seed-bomb-standard"},
    --~ localised_description = {"item-description.bi-seed-bomb-standard"},
    icon = ICONPATH .. "weapon/Seed_bomb_icon_s.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seed_bomb_icon_s.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
    always_show_made_in = false,        -- Added for 0.18.34/1.1.4
    allow_decomposition = true,         -- Added for 0.18.34/1.1.4
    subgroup = "bi-ammo",
    order = "a[rocket-launcher]-x[seed-bomb]-b",
  },


  --- Seed Bomb - Advanced
  {
    type = "recipe",
    name = "bi-seed-bomb-advanced",
    --~ localised_name = {"item-name.bi-seed-bomb-advanced"},
    --~ localised_description = {"item-description.bi-seed-bomb-advanced"},
    icon = ICONPATH .. "weapon/Seed_bomb_icon_a.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seed_bomb_icon_a.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
    always_show_made_in = false,        -- Added for 0.18.34/1.1.4
    allow_decomposition = true,         -- Added for 0.18.34/1.1.4
    subgroup = "bi-ammo",
    order = "a[rocket-launcher]-x[seed-bomb]-c",
    },


  ---     Arboretum -  Plant Trees
  {
    type = "recipe",
    name = "bi-arboretum-r1",
    localised_name = {"recipe-name.bi-arboretum-r1"},
    icon = ICONPATH .. "bi_change_0.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Seedling_b.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "bi-arboretum",
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
    always_show_made_in = false,
    allow_decomposition = true,
    allow_as_intermediate = false,
    subgroup = "bio-arboretum-fluid",
    order = "a[bi]-ssw-a1[bi-arboretum-r1]",
  },


  ---     Arboretum - Change Terrain
  {
    type = "recipe",
    name = "bi-arboretum-r2",
    localised_name = {"recipe-name.bi-arboretum-r2"},
    icon = ICONPATH .. "bi_change_1.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bi_change_1.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "bi-arboretum",
    energy_required = 10000,
    ingredients = {
      {type = "item", name = "fertilizer", amount = 1},
      {type = "fluid", name = "water", amount = 100},
    },
    results = {
      {type = "item", name = "bi-arboretum-r2", amount = 1, probability = 0},
    },
    enabled = false,
    show_amount_in_title = false,
    always_show_made_in = false,
    allow_decomposition = true,
    allow_as_intermediate = false,
    subgroup = "bio-arboretum-fluid",
    order = "a[bi]-ssw-a1[bi-arboretum-r2]",
    crafting_machine_tint = { primary = {r=0.43,g=0.73,b=0.37,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  ---     Arboretum -  Change Terrain - Advanced
  {
    type = "recipe",
    name = "bi-arboretum-r3",
    localised_name = {"recipe-name.bi-arboretum-r3"},
    icon = ICONPATH .. "bi_change_2.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bi_change_2.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "bi-arboretum",
    energy_required = 10000,
    ingredients = {
      {type = "item", name = "bi-adv-fertilizer", amount = 1},
      {type = "fluid", name = "water", amount = 100},
    },
    results = {
      {type = "item", name = "bi-arboretum-r3", amount = 1, probability = 0},
    },
    enabled = false,
    show_amount_in_title = false,
    always_show_made_in = false,
    allow_decomposition = true,
    allow_as_intermediate = false,
    subgroup = "bio-arboretum-fluid",
    order = "a[bi]-ssw-a1[bi-arboretum-r4]",
    crafting_machine_tint = { primary = {r=0.73,g=0.37,b=0.52,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  ---     Arboretum -  Plant Trees & Change Terrain
  {
    type = "recipe",
    name = "bi-arboretum-r4",
    localised_name = {"recipe-name.bi-arboretum-r4"},
    icon = ICONPATH .. "bi_change_plant_1.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bi_change_plant_1.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "bi-arboretum",
    energy_required = 10000,
    ingredients = {
      {type = "item", name = "seedling", amount = 1},
      {type = "item", name = "fertilizer", amount = 1},
      {type = "fluid", name = "water", amount = 100},
    },
    results = {
      {type = "item", name = "bi-arboretum-r4", amount = 1, probability = 0},
    },
    enabled = false,
    show_amount_in_title = false,
    always_show_made_in = false,
    allow_decomposition = true,
    allow_as_intermediate = false,
    subgroup = "bio-arboretum-fluid",
    order = "a[bi]-ssw-a1[bi-arboretum-r3]",
    crafting_machine_tint = { primary = {r=0.43,g=0.73,b=0.37,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },


  ---     Arboretum -  Plant Trees & Change Terrain Advanced
  {
    type = "recipe",
    name = "bi-arboretum-r5",
    localised_name = {"recipe-name.bi-arboretum-r5"},
    icon = ICONPATH .. "bi_change_plant_2.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bi_change_plant_2.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    category = "bi-arboretum",
    energy_required = 10000,
    ingredients = {
      {type = "item", name = "seedling", amount = 1},
      {type = "item", name = "bi-adv-fertilizer", amount = 1},
      {type = "fluid", name = "water", amount = 100},
    },
    results = {
      {type = "item", name = "bi-arboretum-r5", amount = 1, probability = 0},
    },
    enabled = false,
    show_amount_in_title = false,
    always_show_made_in = false,
    allow_decomposition = true,
    allow_as_intermediate = false,
    subgroup = "bio-arboretum-fluid",
    order = "a[bi]-ssw-a1[bi-arboretum-r5]",
    crafting_machine_tint = { primary = {r=0.73,g=0.37,b=0.52,a=0.60}, secondary = {r=0,g=0,b=0,a=0}, tertiary = {r=0,g=0,b=0,a=0}, quaternary = {r=0,g=0,b=0,a=0}},
  },
})