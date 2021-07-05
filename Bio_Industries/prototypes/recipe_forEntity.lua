local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath


data:extend({

  --- Bio Greenhouse (ENTITY)
  {
    type = "recipe",
    name = "bi-bio-greenhouse",
    localised_name = {"entity-name.bi-bio-greenhouse"},
    --~ localised_description = {"entity-description.bi-bio-greenhouse"},
    icon = ICONPATH .. "entity/bio_greenhouse.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bio_greenhouse.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    normal = {
      enabled = false,
      --~ energy_required = 5,
      energy_required = 2.5,
      ingredients = {
        {"iron-stick", 10},
        {"stone-brick", 10},
        {"small-lamp", 5},
      },
      result = "bi-bio-greenhouse",
      result_count = 1,
      allow_as_intermediate = true,     -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,      -- Added for 0.18.34/1.1.4
    },
    expensive = {
      enabled = false,
      --~ energy_required = 8,
      energy_required = 4,
      ingredients = {
        {"iron-stick", 15},
        {"stone-brick", 15},
        {"small-lamp", 5},
      },
      result = "bi-bio-greenhouse",
      result_count = 1,
      main_product = "",
      allow_as_intermediate = true,     -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,      -- Added for 0.18.34/1.1.4
    },
    subgroup = "bio-bio-farm-fluid-1",
    order = "a[bi]",
    allow_as_intermediate = true,       -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },


  --- Bio Farm (ENTITY)
  {
    type = "recipe",
    name = "bi-bio-farm",
    localised_name = {"entity-name.bi-bio-farm"},
    --~ localised_description = {"entity-description.bi-bio-farm"},
    icon = ICONPATH .. "entity/Bio_Farm_Icon.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Bio_Farm_Icon.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    normal = {
      enabled = false,
      --~ energy_required = 10,
      energy_required = 5,
      ingredients = {
        {"bi-bio-greenhouse", 4},
        {"stone-crushed", 10},
        {"copper-cable", 10},
      },
      result = "bi-bio-farm",
      result_count = 1,
      allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    },
    expensive = {
      enabled = false,
      --~ energy_required = 15,
      energy_required = 7.5,
      ingredients = {
        {"bi-bio-greenhouse", 8},
        {"stone-crushed", 20},
        {"copper-cable", 20},
      },
      result = "bi-bio-farm",
      result_count = 1,
      allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    },
    subgroup = "bio-bio-farm-fluid-3",
    order = "b[bi]",
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },


  -- COKERY (ENTITY)--
  {
    type = "recipe",
    name = "bi-cokery",
    localised_name = {"entity-name.bi-cokery"},
    --~ localised_description = {"entity-description.bi-cokery"},
    icon = ICONPATH .. "entity/cokery.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "cokery.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    normal = {
      enabled = false,
      energy_required = 8,
      ingredients = {
        {"stone-furnace", 3},
        {"steel-plate", 10},
      },
      result = "bi-cokery",
      result_count = 1,
      allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
      always_show_made_in = false,        -- Added for 0.18.34/1.1.4
      allow_decomposition = true,         -- Added for 0.18.34/1.1.4
    },
    expensive = {
      enabled = false,
      energy_required = 10,
      ingredients = {
        {"stone-furnace", 3},
        {"steel-plate", 12},
      },
      result = "bi-cokery",
      result_count = 1,
      allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
      always_show_made_in = false,        -- Added for 0.18.34/1.1.4
      allow_decomposition = true,         -- Added for 0.18.34/1.1.4
    },
    subgroup = "bio-cokery",
    order = "a[bi]",
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },


  -- STONE CRUSHER (ENTITY) --
  {
    type = "recipe",
    name = "bi-stone-crusher",
    localised_name = {"entity-name.bi-stone-crusher"},
    --~ localised_description = {"entity-description.bi-stone-crusher"},
    icon = ICONPATH .. "entity/stone_crusher.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "stone_crusher.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    subgroup = "bio-stone-crusher",
    order = "a[bi]",
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,        -- Added for 0.18.34/1.1.4
    always_show_made_in = false,          -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,           -- Added for 0.18.34/1.1.4
  },

  -- BIO Reactor (ENTITY)--
  {
    type = "recipe",
    name = "bi-bio-reactor",
    localised_name = {"entity-name.bi-bio-reactor"},
    --~ localised_description = {"entity-description.bi-bio-reactor"},
    icon = ICONPATH .. "entity/bioreactor.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "bioreactor.png",
        --~ icon_size = 64,
      --~ }
    --~ },
    normal = {
      enabled = false,
      energy_required = 20,
      ingredients = {
        {"assembling-machine-1", 1},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
      },
      result = "bi-bio-reactor",
      result_count = 1,
      allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    },
    expensive = {
      enabled = false,
      energy_required = 30,
      ingredients = {
        {"assembling-machine-1", 2},
        {"steel-plate", 5},
        {"electronic-circuit", 5},
      },
      result = "bi-bio-reactor",
      result_count = 1,
      allow_as_intermediate = false,    -- Added for 0.18.34/1.1.4
      always_show_made_in = false,      -- Added for 0.18.34/1.1.4
      allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    },
    subgroup = "bio-bio-fuel-fluid",
    order = "a",
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Changed for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4  },
  },


  --- Arboretum (ENTITY)
  {
    type = "recipe",
    name = "bi-arboretum",
    localised_name = {"entity-name.bi-arboretum"},
    --~ localised_description = {"entity-description.bi-arboretum"},
    icon = ICONPATH .. "entity/Arboretum_Icon.png",
    icon_size = 64,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "entity/Arboretum_Icon.png",
        --~ icon_size = 64,
      --~ }
    --~ },
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },



})
