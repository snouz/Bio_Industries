local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.modRoot .. "/graphics/icons/"

--- Bio Gardens
data:extend({

  --- Garden (ENTITY)
  {
    type = "recipe",
    name = "bi-bio-garden",
    localised_name = {"entity-name.bi-bio-garden"},
    --localised_description = {"entity-description.bi-bio-garden"},
    icon = ICONPATH .. "entity/bio_garden_icon.png",
    icon_size = 64,
    enabled = false,
    energy_required = 10,
    ingredients = {
      {"stone-wall", 10},
      {"stone-crushed", 40},
      {"seedling", 30}
    },
    result = "bi-bio-garden",
    main_product = "",
    subgroup = "bio-bio-gardens-fluid",
    order = "a[bi]-1",
    always_show_made_in = false,
    allow_decomposition = false,
    -- This is a custom property for use by "Krastorio 2" (it will change ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },
  {
    type = "recipe",
    name = "bi-bio-garden-large",
    localised_name = {"entity-name.bi-bio-garden-large"},
    --localised_description = {"entity-description.bi-bio-garden-large"},
    icon = ICONPATH .. "entity/bio_garden_large_icon.png",
    icon_size = 64,
    enabled = false,
    energy_required = 20,
    ingredients = {
      {"bi-bio-garden", 10},
      {"seedling", 40}
    },
    result = "bi-bio-garden-large",
    main_product = "",
    subgroup = "bio-bio-gardens-fluid",
    order = "a[bi]-2",
    always_show_made_in = false,
    allow_decomposition = false,
    -- This is a custom property for use by "Krastorio 2" (it will change ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },
  {
    type = "recipe",
    name = "bi-bio-garden-huge",
    localised_name = {"entity-name.bi-bio-garden-huge"},
    --localised_description = {"entity-description.bi-bio-garden-huge"},
    icon = ICONPATH .. "entity/bio_garden_huge_icon.png",
    icon_size = 64,
    enabled = false,
    energy_required = 30,
    ingredients = {
      {"bi-bio-garden-large", 10},
      {"iron-plate", 30},
      {"seedling", 100}
    },
    result = "bi-bio-garden-huge",
    main_product = "",
    subgroup = "bio-bio-gardens-fluid",
    order = "a[bi]-3",
    always_show_made_in = false,
    allow_decomposition = false,
    -- This is a custom property for use by "Krastorio 2" (it will change ingredients/results; used for wood/wood pulp)
    mod = "Bio_Industries",
  },














  --- Clean Air 1
  {
    type = "recipe",
    name = "bi-purified-air-1",
    --~ localised_name = {"recipe-name.bi-purified-air-1"},
    --~ localised_description = {"recipe-description.bi-purified-air-1"},
    icon = ICONPATH .. "clean-air_mk1.png",
    icon_size = 64,
    order = "zzz-clean-air",
    category = "clean-air",
    subgroup = "bio-bio-gardens-fluid",
    order = "bi-purified-air-1",
    enabled = false,
    always_show_made_in = false,
    allow_decomposition = false,
    energy_required = 40,
    ingredients = {
      {type = "fluid", name = "water", amount = 50},
      {type = "item", name = "fertilizer", amount = 1}
    },
    results = {
      {type = "item", name = "bi-purified-air", amount = 1, probability = 0},
    },
    main_product = "",
  },


  --- Clean Air 2
  {
    type = "recipe",
    name = "bi-purified-air-2",
    --~ localised_name = {"recipe-name.bi-purified-air-2"},
    --~ localised_description = {"recipe-description.bi-purified-air-2"},
    icon = ICONPATH .. "clean-air_mk2.png",
    icon_size = 64,
    order = "zzz-clean-air2",
    category = "clean-air",
    subgroup = "bio-bio-gardens-fluid",
    order = "bi-purified-air-2",
    enabled = false,
    always_show_made_in = false,
    allow_decomposition = false,
    energy_required = 100,
    ingredients = {
      {type = "fluid", name = "water", amount = 50},
      {type = "item", name = "bi-adv-fertilizer", amount = 1},
    },
    results = {
      {type = "item", name = "bi-purified-air", amount = 1, probability = 0},
    },
    main_product = "",
  },

})
