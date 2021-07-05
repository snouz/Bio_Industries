BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

data:extend({

  --~ --- Big Electric Pole
  --~ {
    --~ type = "recipe",
    --~ name = "bi-wooden-pole-big",
    --~ localised_name = {"entity-name.bi-wooden-pole-big"},
    --~ -- localised_description = {"entity-description.bi-wooden-pole-big"},
    --~ icon = ICONPATH .. "entity/big-wooden-pole.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ normal = {
      --~ enabled = false,
      --~ ingredients = {
        --~ {"wood", 5},
        --~ {"small-electric-pole", 2},
      --~ },
      --~ result = "bi-wooden-pole-big",
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ expensive = {
      --~ enabled = false,
      --~ ingredients = {
        --~ {"wood", 10},
        --~ {"small-electric-pole", 4},
      --~ },
      --~ result = "bi-wooden-pole-big",
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ -- always_show_made_in = true,
    --~ -- allow_decomposition = false,
    --~ allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    --~ allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    --~ subgroup = "energy-pipe-distribution",
    --~ order = "a[energy]-b[small-electric-pole]",
    --~ -- This is a custom property for use by "Krastorio 2" (it will change
    --~ -- ingredients/results; used for wood/wood pulp)
    --~ mod = "Bio_Industries",
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-wooden-pole-1"},
  --~ },

  --~ --- Huge Wooden Pole
  --~ {
    --~ type = "recipe",
    --~ name = "bi-wooden-pole-huge",
    --~ localised_name = {"entity-name.bi-wooden-pole-huge"},
    --~ -- localised_description = {"entity-description.bi-wooden-pole-huge"},
    --~ icon = ICONPATH .. "entity/huge-wooden-pole.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ normal = {
      --~ enabled = false,
      --~ ingredients = {
        --~ {"wood", 5},
        --~ {"concrete", 100},
        --~ {"bi-wooden-pole-big", 6},
      --~ },
      --~ result = "bi-wooden-pole-huge",
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ expensive = {
      --~ enabled = false,
      --~ ingredients = {
        --~ {"wood", 10},
        --~ {"concrete", 150},
        --~ {"bi-wooden-pole-big", 10},
      --~ },
      --~ result = "bi-wooden-pole-huge",
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ -- always_show_made_in = true,
    --~ -- allow_decomposition = false,
    --~ allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    --~ allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    --~ subgroup = "energy-pipe-distribution",
    --~ order = "a[energy]-d[big-electric-pole]",
    --~ -- This is a custom property for use by "Krastorio 2" (it will change
    --~ -- ingredients/results; used for wood/wood pulp)
    --~ mod = "Bio_Industries",
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-wooden-pole-2"},
  --~ },

  --~ --- Wooden Fence
  --~ {
    --~ type = "recipe",
    --~ name = "bi-wooden-fence",
    --~ localised_name = {"entity-name.bi-wooden-fence"},
    --~ -- localised_description = {"entity-description.bi-wooden-fence"},
    --~ icon = ICONPATH .. "entity/wooden-fence.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ normal = {
      --~ enabled = true,
      --~ ingredients = {
        --~ {"wood", 2},
      --~ },
      --~ result = "bi-wooden-fence",
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ expensive = {
      --~ enabled = true,
      --~ ingredients = {
        --~ {"wood", 4},
      --~ },
      --~ result = "bi-wooden-fence",
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    -- always_show_made_in = true,
    -- allow_decomposition = false,
    --~ allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    --~ allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    --~ subgroup = "defensive-structure",
    --~ -- This is a custom property for use by "Krastorio 2" (it will change
    --~ -- ingredients/results; used for wood/wood pulp)
    --~ mod = "Bio_Industries",
  --~ },

  --- Wooden Rail
  {
    type = "recipe",
    name = "bi-rail-wood",
    localised_name = {"entity-name.bi-rail-wood"},
    --~ localised_description = {"entity-description.bi-rail-wood"},
    icon = ICONPATH .. "entity/rail-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    normal = {
      enabled = false,
      ingredients = {
        {"stone", 1},
        {"steel-plate", 1},
        {"iron-stick", 1},
        {"wood", 6},
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
        {"wood", 6},
        {"stone", 1},
        {"steel-plate", 1},
        {"iron-stick", 1},
      },
      result = "bi-rail-wood",
      result_count = 1,
      requester_paste_multiplier = 4,
      allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    },
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    subgroup = "train-transport",
    order = "a[train-system]-a[rail0]",

    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"railway"},
  },

  --- Wooden Rail to Concrete Rail
  {
    type = "recipe",
    name = "bi-rail-wood-to-concrete",
    icon = ICONPATH .. "entity/rail-concrete_from_rail-wood.png",
    icon_size = 64,
    BI_add_icon = true,
    normal = {
      enabled = false,
      ingredients = {
        {"bi-rail-wood", 3},
        {"stone-brick", 10},
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
        {"bi-rail-wood", 2},
        {"stone-brick", 10},
      },
      result = "rail",
      result_count = 1,
      requester_paste_multiplier = 4,
      allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    },
    subgroup = "train-transport",
    order = "a[train-system]-a[rail2]",
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-concrete-rails"},
  },

  --- Wooden Bridge Rail
  {
    type = "recipe",
    name = "bi-rail-wood-bridge",
    localised_name = {"entity-name.bi-rail-wood-bridge"},
    --~ localised_description = {"entity-description.bi-rail-wood-bridge"},
    icon = ICONPATH .. "entity/rail-bridge-wood.png",
    icon_size = 64,
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    subgroup = "train-transport",
    order = "a[train-system]-a[rail5]",

    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-rail-bridge"},
  },

  --- Power Rail
  {
    type = "recipe",
    name = "bi-rail-power",
    localised_name = {"entity-name.bi-rail-power"},
    --~ localised_description = {"entity-description.bi-rail-power"},
    icon = ICONPATH .. "entity/rail-concrete-power.png",
    icon_size = 64,
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    subgroup = "train-transport",
    order = "a[train-system]-a[rail3]",
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-power-conducting-rails"},
  },

  --~ --- Wood Pipe
  --~ {
    --~ type = "recipe",
    --~ name = "bi-wood-pipe",
    --~ localised_name = {"entity-name.bi-wood-pipe"},
    --~ -- localised_description = {"entity-description.bi-wood-pipe"},
    --~ icon = ICONPATH .. "entity/wood_pipe.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ normal = {
      --~ energy_required = 1,
      --~ enabled = true,
      --~ ingredients = {
        --~ {"copper-plate", 1},
        --~ {"wood", 8}
      --~ },
      --~ result = "bi-wood-pipe",
      --~ result_count = 4,
      --~ requester_paste_multiplier = 15,
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ expensive = {
      --~ energy_required = 2,
      --~ enabled = true,
      --~ ingredients = {
        --~ {"copper-plate", 1},
        --~ {"wood", 12}
      --~ },
      --~ result = "bi-wood-pipe",
      --~ result_count = 4,
      --~ requester_paste_multiplier = 15,
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ -- always_show_made_in = true,
    --~ -- allow_decomposition = false,
    --~ allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    --~ allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    --~ subgroup = "energy-pipe-distribution",
    --~ order = "a[pipe]-1a[pipe]",
    --~ -- This is a custom property for use by "Krastorio 2" (it will change
    --~ -- ingredients/results; used for wood/wood pulp)
    --~ mod = "Bio_Industries",
  --~ },

  --~ -- Wood Pipe to Ground
  --~ {
    --~ type = "recipe",
    --~ name = "bi-wood-pipe-to-ground",
    --~ localised_name = {"entity-name.bi-wood-pipe-to-ground"},
    --~ -- localised_description = {"entity-description.bi-wood-pipe-to-ground"},
    --~ icon = ICONPATH .. "entity/pipe-to-ground-wood.png",
    --~ icon_size = 64,
    --~ BI_add_icon = true,
    --~ normal = {
      --~ energy_required = 2,
      --~ enabled = true,
      --~ ingredients = {
        --~ {"copper-plate", 4},
        --~ {"bi-wood-pipe", 5}
      --~ },
      --~ result = "bi-wood-pipe-to-ground",
      --~ result_count = 2,
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ expensive = {
      --~ energy_required = 4,
      --~ enabled = true,
      --~ ingredients = {
        --~ {"copper-plate", 5},
        --~ {"bi-wood-pipe", 6}
      --~ },
      --~ result = "bi-wood-pipe-to-ground",
      --~ result_count = 2,
      --~ allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ },
    --~ -- always_show_made_in = true,
    --~ -- allow_decomposition = false,
    --~ allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    --~ allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    --~ subgroup = "energy-pipe-distribution",
    --~ order = "a[pipe]-1b[pipe-to-ground]",
  --~ },

  --- Rail to Power Pole
  {
    type = "recipe",
    name = "bi-power-to-rail-pole",
    localised_name = {"entity-name.bi-power-to-rail-pole"},
    --~ localised_description = {"entity-description.bi-power-to-rail-pole"},
    icon = ICONPATH .. "entity/rail-concrete-power-pole.png",
    icon_size = 64,
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    --~ allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    subgroup = "train-transport",
    order = "a[train-system]-a[rail4]",
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-power-conducting-rails"},
  },
})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
