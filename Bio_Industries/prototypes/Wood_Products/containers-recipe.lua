if not BI.Settings.BI_Bigger_Wooden_Chests then
  return
end

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.modRoot .. "/graphics/icons/"


BioInd.writeDebug("Creating recipes for bigger wooden chests!")

data:extend({
  -- Large wooden chest
  {
    type = "recipe",
    name = "bi-wooden-chest-large",
    localised_name = {"entity-name.bi-wooden-chest-large"},
    --~ localised_description = {"entity-description.bi-wooden-chest-large"},
    icon = ICONPATH .. "entity/large_wooden_chest_icon.png",
    icon_size = 64,
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = true,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },

  -- Huge wooden chest
  {
    type = "recipe",
    name = "bi-wooden-chest-huge",
    localised_name = {"entity-name.bi-wooden-chest-huge"},
    --~ localised_description = {"entity-description.bi-wooden-chest-huge"},
    icon = ICONPATH .. "entity/huge_wooden_chest_icon.png",
    icon_size = 64,
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = true,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },

  -- Gigantic wooden chest
  {
    type = "recipe",
    name = "bi-wooden-chest-giga",
    localised_name = {"entity-name.bi-wooden-chest-giga"},
    --~ localised_description = {"entity-description.bi-wooden-chest-giga"},
    icon = ICONPATH .. "entity/giga_wooden_chest_icon.png",
    icon_size = 64,
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
    --~ always_show_made_in = true,
    --~ allow_decomposition = false,
    allow_as_intermediate = false,      -- Added for 0.18.34/1.1.4
    always_show_made_in = false,        -- Changed for 0.18.34/1.1.4
    allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  },
})
