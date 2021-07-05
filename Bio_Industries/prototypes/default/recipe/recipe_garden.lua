BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

------------------------------------------------------------------------------------
--                                   Bio Gardens                                  --
------------------------------------------------------------------------------------
data:extend({
  --- Bio garden
  {
    type = "recipe",
    name = "bi-bio-garden",
    localised_name = {"entity-name.bi-bio-garden"},
    --~ localised_description = {"entity-description.bi-bio-garden"},
    icon = ICONPATH .. "entity/garden_3x3.png",
    icon_size = 64,
    BI_add_icon = true,
    enabled = false,
    energy_required = 10,
    ingredients = {
      {"stone-wall", 10},
      {"stone-crushed", 40},
      {"seedling", 30}
    },
    result = "bi-bio-garden",
    subgroup = "bio-bio-gardens-fluid",
    order = "a[bi]-1",
    --~ subgroup = "production-machine",
    --~ order = "x[bi]-b[bi_bio_garden]",
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = true,      -- Changed for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
    -- This is a custom property for use by "Krastorio 2" (it will change
    -- ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-garden-1"},
  },
  -- Large garden
  {
    type = "recipe",
    name = "bi-bio-garden-large",
    localised_name = {"entity-name.bi-bio-garden-large"},
    --localised_description = {"entity-description.bi-bio-garden-large"},
    icon = ICONPATH .. "entity/garden_9x9.png",
    icon_size = 64,
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
    -- This is a custom property for use by "Krastorio 2" (it will change ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-garden-2"},
  },
  -- Huge garden
  {
    type = "recipe",
    name = "bi-bio-garden-huge",
    localised_name = {"entity-name.bi-bio-garden-huge"},
    --localised_description = {"entity-description.bi-bio-garden-huge"},
    icon = ICONPATH .. "entity/garden_27x27.png",
    icon_size = 64,
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
    -- This is a custom property for use by "Krastorio 2" (it will change ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-garden-3"},
  },
})

------------------------------------------------------------------------------------
--                                  Purified air                                  --
------------------------------------------------------------------------------------
data:extend({
  --- Clean Air 1
  {
    type = "recipe",
    name = "bi-purified-air-1",
    localised_name = {"recipe-name.bi-purified-air-1"},
    --~ localised_description = {"recipe-description.bi-purified-air-1"},
    icon = ICONPATH .. "clean-air_fert1.png",
    icon_size = 64,
    BI_add_icon = true,
    order = "zzz-clean-air",
    category = "clean-air",
    subgroup = "bio-bio-gardens-fluid",
    order = "bi-purified-air-1",
    enabled = false,
    always_show_made_in = false,
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
      primary = {r = 0.43, g = 0.73, b = 0.37, a = 0.60},
      secondary = {r = 0, g = 0, b = 0, a = 0},
      tertiary = {r = 0, g = 0, b = 0, a = 0},
      quaternary = {r = 0, g = 0, b = 0, a = 0}
    },
    -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-depollution-1"},
  },

  --- Clean Air 2
  {
    type = "recipe",
    name = "bi-purified-air-2",
    localised_name = {"recipe-name.bi-purified-air-2"},
    --~ localised_description = {"recipe-description.bi-purified-air-2"},
    icon = ICONPATH .. "clean-air_fert2.png",
    icon_size = 64,
    BI_add_icon = true,
    order = "zzz-clean-air2",
    category = "clean-air",
    subgroup = "bio-bio-gardens-fluid",
    order = "bi-purified-air-2",
    enabled = false,
    always_show_made_in = false,
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
      primary = {r = 0.73, g = 0.37, b = 0.52, a = 0.60},
      secondary = {r = 0, g = 0, b = 0, a = 0},
      tertiary = {r = 0, g = 0, b = 0, a = 0},
      quaternary = {r = 0, g = 0, b = 0, a = 0}
    },
     -- Custom property that allows to automatically add our recipes to tech unlocks.
    BI_add_to_tech = {"bi-tech-depollution-2"},
 },
})


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
