local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.modRoot .. "/graphics/icons/"

data:extend({

  --- Big Electric Pole
  {
    type = "recipe",
    name = "bi-wooden-pole-big",
    localised_name = {"entity-name.bi-wooden-pole-big"},
    localised_description = {"entity-description.bi-wooden-pole-big"},
    icon = ICONPATH .. "entity/big-wooden-pole.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/big-wooden-pole.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = false,
      ingredients = {
        {"wood", 5},
        {"small-electric-pole", 2},
      },
      result = "bi-wooden-pole-big",
      main_product = "",
    },
    expensive = {
      enabled = false,
      ingredients = {
        {"wood", 10},
        {"small-electric-pole", 4},
      },
      result = "bi-wooden-pole-big",
      main_product = "",
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-b[small-electric-pole]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },

  --- Huge Wooden Pole
  {
    type = "recipe",
    name = "bi-wooden-pole-huge",
    localised_name = {"entity-name.bi-wooden-pole-huge"},
    localised_description = {"entity-description.bi-wooden-pole-huge"},
    icon = ICONPATH .. "entity/huge-wooden-pole.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/huge-wooden-pole.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = false,
      ingredients = {
        {"wood", 5},
        {"concrete", 100},
        {"bi-wooden-pole-big", 6},
      },
      result = "bi-wooden-pole-huge",
      main_product = "",
    },
    expensive = {
      enabled = false,
      ingredients = {
        {"wood", 10},
        {"concrete", 150},
        {"bi-wooden-pole-big", 10},
      },
      result = "bi-wooden-pole-huge",
      main_product = "",
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-d[big-electric-pole]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },

  --- Wooden Fence
  {
    type = "recipe",
    name = "bi-wooden-fence",
    localised_name = {"entity-name.bi-wooden-fence"},
    localised_description = {"entity-description.bi-wooden-fence"},
    icon = ICONPATH .. "entity/wooden-fence.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/wooden-fence.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = true,
      ingredients = {
        {"wood", 2},
      },
      result = "bi-wooden-fence",
      main_product = "",
    },
    expensive = {
      enabled = true,
      ingredients = {
        {"wood", 4},
      },
      result = "bi-wooden-fence",
      main_product = "",
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "defensive-structure",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },

  --- Wooden Rail
  {
    type = "recipe",
    name = "bi-rail-wood",
    localised_name = {"entity-name.bi-rail-wood"},
    localised_description = {"entity-description.bi-rail-wood"},
    icon = ICONPATH .. "entity/rail-wood.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/rail-wood.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = false,
      ingredients = {
        {"wood", 6},
        {"stone", 1},
        {"steel-plate", 1},
        {"iron-stick", 1},
      },
      result = "bi-rail-wood",
      result_count = 2,
      main_product = "",
      requester_paste_multiplier = 4
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
      main_product = "",
      requester_paste_multiplier = 4,
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "train-transport",
    order = "a[train-system]-a[rail0]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },

  --- Wooden Rail to Concrete Rail
  {
    type = "recipe",
    name = "bi-rail-wood-to-concrete",
    icon = ICONPATH .. "entity/rail-wood-to-concrete.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/rail-wood-to-concrete.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = false,
      ingredients = {
        {"bi-rail-wood", 3},
        {"stone-brick", 10},
      },
      result = "rail",
      result_count = 2,
      main_product = "",
      requester_paste_multiplier = 4
    },
    expensive = {
      enabled = false,
      ingredients = {
        {"bi-rail-wood", 2},
        {"stone-brick", 10},
      },
      result = "rail",
      result_count = 1,
      main_product = "",
      requester_paste_multiplier = 4
    },
    subgroup = "train-transport",
    order = "a[train-system]-a[rail2]",
    always_show_made_in = true,
    allow_decomposition = false,
  },

  --- Wooden Bridge Rail
  {
    type = "recipe",
    name = "bi-rail-wood-bridge",
    localised_name = {"entity-name.bi-rail-wood-bridge"},
    localised_description = {"entity-description.bi-rail-wood-bridge"},
    name = "bi-rail-wood-bridge",
    icon = ICONPATH .. "entity/rail-wood-bridge.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/rail-wood-bridge.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = false,
      ingredients = {
        {"bi-rail-wood", 1},
        {"steel-plate", 1},
        {"wood", 32}
      },
      result = "bi-rail-wood-bridge",
      result_count = 2,
      main_product = "",
      requester_paste_multiplier = 4
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
      main_product = "",
      requester_paste_multiplier = 4
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "train-transport",
    order = "a[train-system]-a[rail5]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },

  --- Power Rail
  {
    type = "recipe",
    name = "bi-rail-power",
    localised_name = {"entity-name.bi-rail-power"},
    localised_description = {"entity-description.bi-rail-power"},
    icon = ICONPATH .. "entity/rail-concrete-power.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/rail-concrete-power.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = false,
      ingredients = {
        {"rail", 2},
        {"copper-cable", 4},
      },
      result = "bi-rail-power",
      result_count = 2,
      main_product = "",
      requester_paste_multiplier = 4
    },
    expensive = {
      enabled = false,
      ingredients = {
        {"rail", 1},
        {"copper-cable", 4},
      },
      result = "bi-rail-power",
      result_count = 1,
      main_product = "",
      requester_paste_multiplier = 4
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "train-transport",
    order = "a[train-system]-a[rail3]",
  },

  --- Wood Pipe
  {
    type = "recipe",
    name = "bi-wood-pipe",
    localised_name = {"entity-name.bi-wood-pipe"},
    localised_description = {"entity-description.bi-wood-pipe"},
    icon = ICONPATH .. "entity/wood_pipe.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/wood_pipe.png",
        icon_size = 64,
      }
    },
    normal = {
      energy_required = 1,
      enabled = true,
      ingredients = {
        {"copper-plate", 1},
        {"wood", 8}
      },
      result = "bi-wood-pipe",
      result_count = 4,
      main_product = "",
      requester_paste_multiplier = 15
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
      main_product = "",
      requester_paste_multiplier = 15
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "energy-pipe-distribution",
    order = "a[pipe]-1a[pipe]",
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },

  -- Wood Pipe to Ground
  {
    type = "recipe",
    name = "bi-wood-pipe-to-ground",
    localised_name = {"entity-name.bi-wood-pipe-to-ground"},
    localised_description = {"entity-description.bi-wood-pipe-to-ground"},
    icon = ICONPATH .. "entity/pipe-to-ground-wood.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/pipe-to-ground-wood.png",
        icon_size = 64,
      }
    },
    normal = {
      energy_required = 2,
      enabled = true,
      ingredients = {
        {"copper-plate", 4},
        {"bi-wood-pipe", 5}
      },
      result = "bi-wood-pipe-to-ground",
      result_count = 2,
      main_product = "",
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
      main_product = "",
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "energy-pipe-distribution",
    order = "a[pipe]-1b[pipe-to-ground]",
  },

  --- Rail to Power Pole
  {
    type = "recipe",
    name = "bi-power-to-rail-pole",
    localised_name = {"entity-name.bi-power-to-rail-pole"},
    localised_description = {"entity-description.bi-power-to-rail-pole"},
    icon = ICONPATH .. "entity/electric-to-rail.png",
    icon_size = 64,
    icon_mipmaps = 1,
    icons = {
      {
        icon = ICONPATH .. "entity/electric-to-rail.png",
        icon_size = 64,
      }
    },
    normal = {
      enabled = false,
      ingredients = {
        {"copper-cable", 2},
        {"medium-electric-pole", 1},
      },
      result = "bi-power-to-rail-pole",
      main_product = "",
    },
    expensive = {
      enabled = false,
      ingredients = {
        {"copper-cable", 4},
        {"medium-electric-pole", 1},
      },
      result = "bi-power-to-rail-pole",
      main_product = "",
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "train-transport",
    order = "a[train-system]-a[rail4]",
  },

  --- Large Wooden Chest
  {
    type = "recipe",
    name = "bi-wooden-chest-large",
    localised_name = {"entity-name.bi-wooden-chest-large"},
    localised_description = {"entity-description.bi-wooden-chest-large"},
    icon = ICONPATH .. "entity/large_wooden_chest_icon.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/large_wooden_chest_icon.png",
        icon_size = 64,
      }
    },
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
      main_product = "",
      requester_paste_multiplier = 4
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
      main_product = "",
      requester_paste_multiplier = 4,
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "storage",
    order = "a[items]-aa[wooden-chest]",
  },

  --- Huge Wooden Chest
  {
    type = "recipe",
    name = "bi-wooden-chest-huge",
    localised_name = {"entity-name.bi-wooden-chest-huge"},
    localised_description = {"entity-description.bi-wooden-chest-huge"},
    icon = ICONPATH .. "entity/huge_wooden_chest_icon.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/huge_wooden_chest_icon.png",
        icon_size = 64,
      }
    },
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
      main_product = "",
      requester_paste_multiplier = 4
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
      main_product = "",
      requester_paste_multiplier = 4,
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "storage",
    order = "a[items]-ab[wooden-chest]",
  },

  --- Giga Wooden Chest
  {
    type = "recipe",
    name = "bi-wooden-chest-giga",
    localised_name = {"entity-name.bi-wooden-chest-giga"},
    localised_description = {"entity-description.bi-wooden-chest-giga"},
    icon = ICONPATH .. "entity/giga_wooden_chest_icon.png",
    icon_size = 64,
    icons = {
      {
        icon = ICONPATH .. "entity/giga_wooden_chest_icon.png",
        icon_size = 64,
      }
    },
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
      main_product = "",
      requester_paste_multiplier = 4
    },
    expensive = {
      energy_required = 6,
      enabled = false,
      ingredients = {
        {"steel-plate", 48},
        {"concrete", 48},
        {"bi-wooden-chest-huge", 16}
      },
      main_product = "",
      result = "bi-wooden-chest-giga",
      result_count = 1,
      main_product = "",
      requester_paste_multiplier = 4,
    },
    always_show_made_in = true,
    allow_decomposition = false,
    subgroup = "storage",
    order = "a[items]-ac[wooden-chest]",
  },
 })
