BI.entered_file()

BI.default_recipes = BI.default_recipes or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
--                                 Timber entities                                --
------------------------------------------------------------------------------------
--- Bio Farm
BI.default_recipes.bio_farm = {
  type = "recipe",
  name = "bi-bio-farm",
  localised_name = {"entity-name.bi-bio-farm"},
  --~ localised_description = {"entity-description.bi-bio-farm"},
  icon = ICONPATH .. "entity/biofarm.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
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
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-timber"},
}


------------------------------------------------------------------------------------
--                              Bio farming entities                              --
------------------------------------------------------------------------------------
-- Bio nursery (Greenhouse)
BI.default_recipes.bio_greenhouse = {
  type = "recipe",
  name = "bi-bio-greenhouse",
  localised_name = {"entity-name.bi-bio-greenhouse"},
  --~ localised_description = {"entity-description.bi-bio-greenhouse"},
  icon = ICONPATH .. "entity/greenhouse.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
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
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-bio-farming-1"},
}


------------------------------------------------------------------------------------
--                                  Ash entities                                  --
------------------------------------------------------------------------------------
-- Cokery
BI.default_recipes.cokery = {
  type = "recipe",
  name = "bi-cokery",
  localised_name = {"entity-name.bi-cokery"},
  --~ localised_description = {"entity-description.bi-cokery"},
  icon = ICONPATH .. "entity/cokery.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
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
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-ash"},
}


------------------------------------------------------------------------------------
--                                Biomass entities                                --
------------------------------------------------------------------------------------
-- Bio reactor
BI.default_recipes.bio_reactor = {
  type = "recipe",
  name = "bi-bio-reactor",
  localised_name = {"entity-name.bi-bio-reactor"},
  --~ localised_description = {"entity-description.bi-bio-reactor"},
  icon = ICONPATH .. "entity/bioreactor.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
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
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-biomass"},
}


------------------------------------------------------------------------------------
--                                 Create recipes                                 --
------------------------------------------------------------------------------------
--~ for r, r_data in pairs(BI.default_recipes or {}) do
  --~ data:extend({r_data})
  --~ BioInd.created_msg(r_data)
--~ end
BioInd.create_stuff(BI.default_recipes)

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
