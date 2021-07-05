------------------------------------------------------------------------------------
--                  Data for some techs that depend on a setting.                 --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_techs = BI.additional_techs or {}

local settings = {
  "BI_Bio_Fuel",
  "BI_Bio_Garden",
  "BI_Coal_Processing",
  "BI_Explosive_Planting",
  "BI_Rails",
  "BI_Rubber",
  "BI_Solar_Additions",
  "BI_Stone_Crushing",
  "BI_Terraforming",
  "BI_Wood_Gasification",
  "BI_Wood_Products",
  "Bio_Cannon",
  "BI_Darts",

}
for s, setting in pairs(settings) do
  BI.additional_techs[setting] = BI.additional_techs[setting] or {}
end

local triggers = {
  "BI_Trigger_Concrete",
}
for t, trigger in pairs(triggers) do
  BI.additional_techs[trigger] = BI.additional_techs[trigger] or {}
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.techiconpath
local techs = data.raw.technology

------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
-- Biomass processing 1
BI.additional_techs.BI_Bio_Fuel.biomass_reprocessing_1 = {
  type = "technology",
  name = "bi-tech-biomass-reprocessing-1",
  --~ localised_name = {"technology-name.bi-tech-biomass-reprocessing-1"},
  localised_description = {
    "technology-description.bi-tech-biomass-reprocessing-1",
    {"fluid-name.bi-biomass"},
    {"fluid-name.water"},
  },
  icon = ICONPATH .. "bi-tech-biomass-reprocessing-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-2"
    --~ -- },
  },
  order = "[bi-bio-fuel]-[biomass]-a-[biomass-reprocessing-1]",
  prerequisites = {"bi-tech-biomass"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}

-- Biomass processing 2
BI.additional_techs.BI_Bio_Fuel.biomass_reprocessing_2 = {
  type = "technology",
  name = "bi-tech-biomass-reprocessing-2",
  --~ localised_name = {"technology-name.bi-tech-biomass-reprocessing-2"},
  localised_description = {
    "technology-description.bi-tech-biomass-reprocessing-2",
    {"fluid-name.bi-biomass"}
  },
  icon = ICONPATH .. "bi-tech-biomass-reprocessing-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-3"
    --~ -- },
  },
  order = "[bi-bio-fuel]-[biomass]-a-[biomass-reprocessing-2]",
  prerequisites = {"bi-tech-biomass-reprocessing-1"},
  unit = {
    count = 175,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}

-- Biomass conversion
BI.additional_techs.BI_Bio_Fuel.biomass_conversion = {
  type = "technology",
  name = "bi-tech-biomass-conversion",
  localised_name = {"technology-name.bi-tech-biomass-conversion"},
  localised_description = {
    "technology-description.bi-tech-biomass-conversion",
    {"fluid-name.bi-biomass"}
  },
  icon = ICONPATH .. "bi-tech-biomass-conversion.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-1"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-2"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-3"
    --~ -- },
  },
  order = "[bi-bio-fuel]-[biomass]-b-[biomass-conversion]",
  prerequisites = {"bi-tech-biomass", "lubricant"},
  unit = {
    count = 300,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}


-- Cellulose 1
BI.additional_techs.BI_Bio_Fuel.cellulose_1 = {
  type = "technology",
  name = "bi-tech-cellulose-1",
  --~ localised_name = {"technology-name.bi-tech-cellulose-1"},
  localised_description = {"technology-description.bi-tech-cellulose-1", {"fluid-name.sulfuric-acid"}},
  icon = ICONPATH .. "bi-tech-cellulose-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-cellulose-1"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-4"
    --~ -- },
  },
  order = "[bi-bio-fuel]-[cellulose-1]",
  --~ prerequisites = {"bi-tech-biomass", "sulfur-processing"},
  prerequisites = {"bi-tech-biomass"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}

-- Cellulose 2
BI.additional_techs.BI_Bio_Fuel.cellulose_2 = {
  type = "technology",
  name = "bi-tech-cellulose-2",
  --~ localised_name = {"technology-name.bi-tech-cellulose-2"},
  localised_description = {"technology-description.bi-tech-cellulose-2"},
  icon = ICONPATH .. "bi-tech-cellulose-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-cellulose-2"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-plastic-2"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-battery"
    --~ -- },
  },
  order = "[bi-bio-fuel]-[cellulose-2]",
  --~ prerequisites = {"bi-tech-cellulose-1", "plastics", "battery"},
  prerequisites = {"bi-tech-cellulose-1", "battery"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}


-- Bio plastics
BI.additional_techs.BI_Bio_Fuel.bio_plastics = {
  type = "technology",
  name = "bi-tech-bio-plastics",
  localised_name = {"technology-name.bi-tech-bio-plastics"},
  localised_description = {
    "technology-description.bi-tech-bio-plastics",
    {"fluid-name.bi-biomass"},
    {"fluid-name.light-oil"},
  },
  icon = ICONPATH .. "bi-tech-bio-plastics.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-5"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-plastic-1"
    --~ -- },
  },
  -- Technology prerequisite 'plastics' on 'bi-tech-bio-plastics' is redundant
  -- as 'advanced-oil-processing' already contains it in its prerequisite tree.
  --~ -- prerequisites = {"bi-tech-cellulose-1", "advanced-oil-processing", "plastics"},
  order = "[bi-bio-fuel]-[plastics]",
  prerequisites = {"bi-tech-cellulose-1", "advanced-oil-processing"},
  unit = {
    count = 175,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}

-- Bio boiler
BI.additional_techs.BI_Bio_Fuel.bio_boiler = {
  type = "technology",
  name = "bi-tech-bio-boiler",
  localised_name = {"technology-name.bi-tech-bio-boiler"},
  localised_description = {"technology-description.bi-tech-bio-boiler"},
  icon = ICONPATH .. "bi-tech-bio-boiler.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-bio-boiler"
    --~ -- },
  },
  order = "[bi-bio-boiler]",
  prerequisites = {"concrete"},
  unit = {
    count = 120,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                               Enable: Bio gardens                              --
--                           (BI.Settings.BI_Bio_Garden)                          --
------------------------------------------------------------------------------------
-- Bio gardens
BI.additional_techs.BI_Bio_Garden.garden_1 = {
  type = "technology",
  name = "bi-tech-garden-1",
  --~ localised_name = {"technology-name.bi-tech-garden-1"},
  localised_description = {"technology-description.bi-tech-garden-1"},
  icon = ICONPATH .. "bi-tech-garden-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-bio-garden"
    --~ --  },
  },
  order = "[bi-bio-garden]-a-[garden-1]",
  --~ prerequisites = {"bi-tech-fertilizer", "bi-tech-stone-crushing-1"},
  prerequisites = {"bi-tech-fertilizer"},
  unit = {
    count = 170,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}

-- Large gardens
BI.additional_techs.BI_Bio_Garden.garden_2 = {
  type = "technology",
  name = "bi-tech-garden-2",
  --~ localised_name = {"technology-name.bi-tech-garden-2"},
  localised_description = {"technology-description.bi-tech-garden-2"},
  icon = ICONPATH .. "bi-tech-garden-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-bio-garden-large"
    --~ --  },
  },
  order = "[bi-bio-garden]-a-[garden-2]",
  prerequisites = {"bi-tech-garden-1"},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}

-- Huge gardens
BI.additional_techs.BI_Bio_Garden.garden_3 = {
  type = "technology",
  name = "bi-tech-garden-3",
  --~ localised_name = {"technology-name.bi-tech-garden-3"},
  localised_description = {"technology-description.bi-tech-garden-3"},
  icon = ICONPATH .. "bi-tech-garden-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-bio-garden-huge"
    --~ --  },
  },
  order = "[bi-bio-garden]-a-[garden-3]",
  prerequisites = {"bi-tech-garden-2"},
  unit = {
    count = 270,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}

-- Air purification 1
BI.additional_techs.BI_Bio_Garden.depollution_1 = {
    type = "technology",
  name = "bi-tech-depollution-1",
  --~ localised_name = {"technology-name.bi-tech-depollution-1"},
  localised_description = {"technology-description.bi-tech-depollution-1"},
  icon = ICONPATH .. "bi-tech-depollution-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-purified-air-1"
    --~ --  },
  },
  order = "[bi-bio-garden]-b-[depollution-1]",
  prerequisites = {"bi-tech-garden-1"},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}

-- Air purification 2
BI.additional_techs.BI_Bio_Garden.depollution_2 = {
  type = "technology",
  name = "bi-tech-depollution-2",
  --~ localised_name = {"technology-name.bi-tech-depollution-2"},
  localised_description = {"technology-description.bi-tech-depollution-2"},
  icon = ICONPATH .. "bi-tech-depollution-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-purified-air-2"
    --~ --  },
  },
  order = "[bi-bio-garden]-b-[depollution-3]",
  prerequisites = {"bi-tech-depollution-1", "bi-tech-advanced-fertilizer"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                             Enable: Coal processing                            --
--                        (BI.Settings.BI_Coal_Processing)                        --
------------------------------------------------------------------------------------
-- Coal processing 1
BI.additional_techs.BI_Coal_Processing.coal_processing_1 = {
  type = "technology",
  name = "bi-tech-coal-processing-1",
  --~ localised_name = {"technology-name.bi-tech-coal-processing-1"},
  localised_description = {"technology-description.bi-tech-coal-processing-1"},
  icon = ICONPATH .. "bi-tech-coal-processing-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-charcoal-1"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-charcoal-2"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-wood-fuel-brick"
    --~ },
  },
  order = "[bi-coal-processing]-[bi-coal-processing-1]",
  prerequisites = {"advanced-material-processing", "bi-tech-ash"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1}
    },
    time = 30
  },
  upgrade = true,
}

-- Coal processing 2
BI.additional_techs.BI_Coal_Processing.coal_processing_2 = {
  type = "technology",
  name = "bi-tech-coal-processing-2",
  --~ localised_name = {"technology-name.bi-tech-coal-processing-2"},
  localised_description = {"technology-description.bi-tech-coal-processing-2"},
  icon = ICONPATH .. "bi-tech-coal-processing-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
              --~ {
                --~ type = "unlock-recipe",
                --~ recipe = "bi-coal-1"
              --~ },
              --~ {
                --~ type = "unlock-recipe",
                --~ recipe = "bi-pellet-coke"
              --~ },
              -- Moved here from "bi-tech-coal-processing-1" (0.18.29):
              --~ {
                --~ type = "unlock-recipe",
                --~ recipe = "bi-solid-fuel"
              --~ },
              --~ {
                --~ type = "unlock-recipe",
                --~ recipe = "bi-stone-brick"
              --~ },
  },
  order = "[bi-coal-processing]-[bi-coal-processing-2]",
  prerequisites = {"bi-tech-coal-processing-1", "chemical-science-pack"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 35
  },
  upgrade = true,
}

-- Coal processing 3
BI.additional_techs.BI_Coal_Processing.coal_processing_3 = {
  type = "technology",
  name = "bi-tech-coal-processing-3",
  --~ localised_name = {"technology-name.bi-tech-coal-processing-3"},
  localised_description = {"technology-description.bi-tech-coal-processing-3"},
  icon = ICONPATH .. "bi-tech-coal-processing-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
              --~ {
                --~ type = "unlock-recipe",
                --~ recipe = "bi-coal-2"
              --~ },
              --~ {
                --~ type = "unlock-recipe",
                --~ recipe = "bi-coke-coal"
              --~ },
  },
  order = "[bi-coal-processing]-[bi-coal-processing-3]",
  prerequisites = {"bi-tech-coal-processing-2", "production-science-pack"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
    },
    time = 40
  },
  upgrade = true,
}


------------------------------------------------------------------------------------
--                               Enable: Seed bombs                               --
--                       (BI.Settings.BI_Explosive_Planting)                      --
------------------------------------------------------------------------------------
-- Explosive planting 1
BI.additional_techs.BI_Explosive_Planting.explosive_planting_1 = {
  type = "technology",
  name = "bi-tech-explosive-planting-1",
  --~ localised_name = {"technology-name.bi-tech-explosive-planting-1"},
  localised_description = {"technology-description.bi-tech-explosive-planting-1"},
  icon = ICONPATH .. "bi-tech-explosive-planting-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seed-bomb-basic"
    --~ },
  },
  order = "[bi-explosive-planting]-[bi-explosive-planting-1]",
  prerequisites = {"bi-tech-bio-farming-1", "rocketry"},
  unit = {
    count = 40,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  upgrade = true,
}

-- Explosive planting 2
BI.additional_techs.BI_Explosive_Planting.explosive_planting_2 = {
  type = "technology",
  name = "bi-tech-explosive-planting-2",
  --~ localised_name = {"technology-name.bi-tech-explosive-planting-2"},
  localised_description = {"technology-description.bi-tech-explosive-planting-2"},
  icon = ICONPATH .. "bi-tech-explosive-planting-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seed-bomb-standard"
    --~ },
  },
  order = "[bi-explosive-planting]-[bi-explosive-planting-2]",
  prerequisites = {"bi-tech-explosive-planting-1", "bi-tech-fertilizer",},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}

-- Explosive planting 3
BI.additional_techs.BI_Explosive_Planting.explosive_planting_3 = {
  type = "technology",
  name = "bi-tech-explosive-planting-3",
  --~ localised_name = {"technology-name.bi-tech-explosive-planting-3"},
  localised_description = {"technology-description.bi-tech-explosive-planting-3"},
  icon = ICONPATH .. "bi-tech-explosive-planting-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seed-bomb-advanced"
    --~ },
  },
  order = "[bi-explosive-planting]-[bi-explosive-planting-3]",
  prerequisites = {"bi-tech-explosive-planting-2", "bi-tech-advanced-fertilizer"},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
-- Rail bridges
BI.additional_techs.BI_Rails.rail_bridge = {
  type = "technology",
  name = "bi-tech-rail-bridge",
  localised_name = {"technology-name.bi-tech-rail-bridge"},
  localised_description = {"technology-description.bi-tech-rail-bridge"},
  icon = ICONPATH .. "bi-tech-rail-bridge.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-rail-wood-bridge"
    --~ },
  },
  order = "[bi-rails]-b-[wooden-bridge]",
  prerequisites = {"railway"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}

-- Concrete rails
BI.additional_techs.BI_Rails.concrete_rails = {
  type = "technology",
  name = "bi-tech-concrete-rails",
  localised_name = {"technology-name.bi-tech-concrete-rails"},
  localised_description = {"technology-description.bi-tech-concrete-rails"},
  icon = ICONPATH .. "bi-tech-concrete-rails.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "rail"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-rail-wood-to-concrete"
    --~ },
  },
  order = "[bi-rails]-a-[concrete-rails]",
  prerequisites = {"concrete", "railway"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}

-- Powered rails
BI.additional_techs.BI_Rails.power_conducting_rails = {
  type = "technology",
  name = "bi-tech-power-conducting-rails",
  localised_name = {"technology-name.bi-tech-power-conducting-rails"},
  localised_description = {"technology-description.bi-tech-power-conducting-rails"},
  icon = ICONPATH .. "bi-tech-power-conducting-rails.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-rail-power"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-power-to-rail-pole"
    --~ },
  },
  order = "[bi-rails]-a-[powered-rails]",
  prerequisites = {"bi-tech-concrete-rails", "electric-energy-distribution-1"},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
BI.additional_techs.BI_Rubber.resin_extraction = {
  type = "technology",
  name = "bi-tech-resin-extraction",
  --~ localised_name = {"technology-name.bi-tech-resin-extraction"},
  --~ localised_description = {"technology-description.bi-tech-resin-extraction"},
  icon = ICONPATH .. "bi-tech-resin-extraction.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-resin-pulp"
    --~ --  },
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-resin-wood"
    --~ --  },
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-wood-from-pulp"
    --~ --  },
  },
  order = "[bi-rubber]-a-[resin-extraction]",
  prerequisites = {"bi-tech-timber"},
  unit = {
    count = 75,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}


BI.additional_techs.BI_Rubber.rubber_production = {
  type = "technology",
  name = "bi-tech-rubber-production",
  --~ localised_name = {"technology-name.bi-tech-resin-extraction"},
  --~ localised_description = {"technology-description.bi-tech-resin-extraction"},
  icon = ICONPATH .. "bi-tech-rubber-production.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-rubber"
    --~ --  },
  },
  order = "[bi-rubber]-b-[rubber-production]",
  prerequisites = {"bi-tech-resin-extraction"},
  unit = {
    count = 100,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}


BI.additional_techs.BI_Rubber.rubber_mat = {
  type = "technology",
  name = "bi-tech-rubber-mat",
  --~ localised_name = {"technology-name.bi-tech-rubber-mat"},
  --~ localised_description = {"technology-description.bi-tech-rubber-mat"},
  icon = ICONPATH .. "bi-tech-rubber-mat.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-rubber-mat"
    --~ --  },
  },
  --~ prerequisites = {"military", "bi-tech-rubber-production", "concrete"},
  order = "[bi-rubber]-c-[rubber-mat]",
  prerequisites = {"military", "concrete"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 50,
  },
  --~ --  upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
-- Super accumulators
BI.additional_techs.BI_Solar_Additions.super_accumulators = {
  type = "technology",
  name = "bi-tech-electric-energy-super-accumulators",
  localised_name = {"technology-name.bi-tech-electric-energy-super-accumulators"},
  localised_description = {"technology-description.bi-tech-electric-energy-super-accumulators"},
  icon = ICONPATH .. "bi-tech-electric-energy-super-accumulators.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-bio-accumulator"
    --~ -- },
  },
  order = "[bi-solar-additions]-a-[distribution]-a-[accumulator]",
  prerequisites = {"electric-energy-accumulators","concrete", "electric-energy-distribution-2"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}

-- Steam-solar combination
BI.additional_techs.BI_Solar_Additions.steamsolar_combination = {
  type = "technology",
  name = "bi-tech-steamsolar-combination",
  localised_name = {"technology-name.bi-tech-steamsolar-combination"},
  localised_description = {"technology-description.bi-tech-steamsolar-combination", {"fluid-name.steam"}},
  icon = ICONPATH .. "bi-tech-steamsolar-combination.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      -- recipe = "bi-solar-boiler-panel"
      --~ -- recipe = "bi-solar-boiler"
    --~ -- },
  },
  order = "[bi-solar-additions]-b-[production]-a-[solar-boiler]",
  prerequisites = {"solar-energy", "fluid-handling"},
  unit = {
    count = 225,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}

-- Musk floor
BI.additional_techs.BI_Solar_Additions.musk_floor = {
  type = "technology",
  name = "bi-tech-musk-floor",
  localised_name = {"technology-name.bi-tech-musk-floor"},
  localised_description = {"technology-description.bi-tech-musk-floor"},
  icon = ICONPATH .. "bi-tech-musk-floor.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-solar-mat"
    --~ -- },
  },
  order = "[bi-solar-additions]-b-[production]-c-[musk-floor]",
  prerequisites = {"solar-energy", "advanced-electronics"},
  unit = {
    count = 300,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"utility-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}

-- Super solar panels
BI.additional_techs.BI_Solar_Additions.super_solar_panels = {
  type = "technology",
  name = "bi-tech-super-solar-panels",
  localised_name = {"technology-name.bi-tech-super-solar-panels"},
  localised_description = {"technology-description.bi-tech-super-solar-panels"},
  icon = ICONPATH .. "bi-tech-super-solar-panels.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-bio-solar-farm"
    --~ -- },
  },
  order = "[bi-solar-additions]-b-[production]-b-[solar-farm]",
  prerequisites = {"solar-energy"},
  unit = {
    count = 350,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}


-- Huge substation
BI.additional_techs.BI_Solar_Additions.huge_substation = {
  type = "technology",
  name = "bi-tech-huge-substation",
  localised_name = {"technology-name.bi-tech-huge-substation"},
  localised_description = {"technology-description.bi-tech-huge-substation"},
  icon = ICONPATH .. "bi-tech-huge-substation.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-huge-substation"
    --~ -- },
  },
  order = "[bi-solar-additions]-a-[distribution]-b-[substation]",
  prerequisites = {"electric-energy-distribution-2", "concrete"},
  unit = {
    count = 325,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"utility-science-pack", 1},
    },
    time = 30,
  },
  --~ -- upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
  -- Stone crushing 1 (crushed stone from stone)
BI.additional_techs.BI_Stone_Crushing.stone_crushing_1 = {
  type = "technology",
  name = "bi-tech-stone-crushing-1",
  --~ localised_name = {"technology-name.bi-tech-stone-crushing-1"},
  localised_description = {"technology-description.bi-tech-stone-crushing-1"},
  icon = ICONPATH .. "bi-tech-stone-crushing-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-stone-crusher"
    -- },
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-1"
    -- },
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-6"
    -- },
  },
  order = "[bi-stone-crushing]-a-[bi-stone-crushing-1]",
  prerequisites = {"steel-processing"},
  unit = {
    count = 75,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 30,
  },
  -- upgrade = false,
  upgrade = true,
}


-- Stone crushing 2 (crushed stone from concrete)
BI.additional_techs.BI_Stone_Crushing.stone_crushing_2 = {
  type = "technology",
  name = "bi-tech-stone-crushing-2",
  --~ localised_name = {"technology-name.bi-tech-stone-crushing-2"},
  localised_description = {"technology-description.bi-tech-stone-crushing-2"},
  icon = ICONPATH .. "bi-tech-stone-crushing-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-2"
    -- },
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-3"
    -- },
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-4"
    -- },
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-5"
    -- },
  },
  order = "[bi-stone-crushing]-a-[bi-stone-crushing-2]",
  prerequisites = {"bi-tech-stone-crushing-1", "concrete"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  -- upgrade = false,
  upgrade = true,
}


-- Stone crushing 3 (crushed stone from refined concrete)
BI.additional_techs.BI_Stone_Crushing.stone_crushing_3 = {
  type = "technology",
  name = "bi-tech-stone-crushing-3",
  --~ localised_name = {"technology-name.bi-tech-stone-crushing-3"},
  localised_description = {"technology-description.bi-tech-stone-crushing-3"},
  icon = ICONPATH .. "bi-tech-stone-crushing-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-4"
    -- },
    -- {
      -- type = "unlock-recipe",
      -- recipe = "bi-crushed-stone-5"
    -- },
  },
  order = "[bi-stone-crushing]-a-[bi-stone-crushing-3]",
  prerequisites = {"bi-tech-stone-crushing-2"},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  -- upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                              Enable: Terraforming                              --
--                          (BI.Settings.BI_Terraforming)                         --
------------------------------------------------------------------------------------
-- Terraforming 1
BI.additional_techs.BI_Terraforming.terraforming_1 = {
  type = "technology",
  name = "bi-terraforming-1",
  --~ localised_name = {"technology-name.bi-terraforming-1"},
  localised_description = {"technology-description.bi-terraforming-1"},
  icon = ICONPATH .. "bi-terraforming-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-arboretum"
    --~ --  },
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-arboretum-r1"
    --~ --  },
  },
  order = "[bi-terraforming]-a-[bi-terraforming-1]",
  prerequisites = {"bi-tech-bio-farming-1", "automation-2"},
  unit = {
    count = 50,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}

-- Terraforming 2
BI.additional_techs.BI_Terraforming.terraforming_2 = {
  type = "technology",
  name = "bi-terraforming-2",
  --~ localised_name = {"technology-name.bi-terraforming-2"},
  localised_description = {"technology-description.bi-terraforming-2"},
  icon = ICONPATH .. "bi-terraforming-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-arboretum-r2"
    --~ --  },
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-arboretum-r4"
    --~ --  },
  },
  order = "[bi-terraforming]-a-[bi-terraforming-2]",
  prerequisites = {"bi-terraforming-1", "bi-tech-fertilizer"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}

-- Terraforming 3
BI.additional_techs.BI_Terraforming.terraforming_3 = {
  type = "technology",
  name = "bi-terraforming-3",
  --~ localised_name = {"technology-name.bi-terraforming-3"},
  localised_description = {"technology-description.bi-terraforming-3"},
  icon = ICONPATH .. "bi-terraforming-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-arboretum-r3"
    --~ --  },
    --~ --  {
      --~ --  type = "unlock-recipe",
      --~ --  recipe = "bi-arboretum-r5"
    --~ --  },
  },
  order = "[bi-terraforming]-a-[bi-terraforming-3]",
  prerequisites = {"bi-terraforming-2", "bi-tech-advanced-fertilizer"},
  unit = {
    count = 200,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ --  upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
-- Large chests
BI.additional_techs.BI_Wood_Products.wooden_storage_1 = {
  type = "technology",
  name = "bi-tech-wooden-storage-1",
  --~ localised_name = {"technology-name.bi-tech-wooden-storage-1"},
  localised_description = {"technology-description.bi-tech-wooden-storage-1"},
  icon = ICONPATH .. "bi-tech-wooden-storage-1.png",
  icon_size = 256, icon_mipmaps = 4,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-wooden-chest-large"
    --~ -- },
  },
  order = "[wooden-storage]-a-[wooden-storage-1]",
  prerequisites = {"bi-tech-timber", "logistics"},
  unit = {
    count = 30,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  upgrade = false,
}


-- Huge chests
BI.additional_techs.BI_Wood_Products.wooden_storage_2 = {
  type = "technology",
  name = "bi-tech-wooden-storage-2",
  --~ localised_name = {"technology-name.bi-tech-wooden-storage-2"},
  localised_description = {"technology-description.bi-tech-wooden-storage-2"},
  icon = ICONPATH .. "bi-tech-wooden-storage-2.png",
  icon_size = 256, icon_mipmaps = 4,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-wooden-chest-huge"
    --~ -- },
  },
  order = "[wooden-storage]-a-[wooden-storage-2]",
  prerequisites = {"bi-tech-wooden-storage-1", "logistics-2"},
  unit = {
    count = 100,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  upgrade = false,
}


-- Gigantic chests
BI.additional_techs.BI_Wood_Products.wooden_storage_3 = {
  type = "technology",
  name = "bi-tech-wooden-storage-3",
  --~ localised_name = {"technology-name.bi-tech-wooden-storage-3"},
  localised_description = {"technology-description.bi-tech-wooden-storage-3"},
  icon = ICONPATH .. "bi-tech-wooden-storage-3.png",
  icon_size = 256, icon_mipmaps = 4,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-wooden-chest-giga"
    --~ -- },
  },
  order = "[wooden-storage]-a-[wooden-storage-3]",
  prerequisites = {"bi-tech-wooden-storage-2", "logistics-3", "concrete"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
    },
    time = 30,
  },
  upgrade = false,
}

-- Large poles
BI.additional_techs.BI_Wood_Products.wooden_pole_1 = {
  type = "technology",
  name = "bi-tech-wooden-pole-1",
  --~ localised_name = {
    --~ "technology-name.bi-tech-wooden-pole-1",
    --~ {"entity-name.bi-wooden-pole-big"}
  --~ },
  --~ localised_description = {
    --~ "technology-description.bi-tech-wooden-pole-1",
    --~ {"entity-name.bi-wooden-pole-big"}
  --~ },
  icon = ICONPATH .. "bi-tech-wooden-pole-1.png",
  icon_size = 256, icon_mipmaps = 4,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-wooden-pole-big"
    --~ },
  },
  order = "[wooden-pole]-a-[wooden-pole-1]",
  prerequisites = {"bi-tech-timber"},
  unit = {
    count = 100,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  upgrade = false,
}

-- Huge poles
BI.additional_techs.BI_Wood_Products.wooden_pole_2 = {
  type = "technology",
  name = "bi-tech-wooden-pole-2",
  localised_name = {"technology-name.bi-tech-wooden-pole-2"},
  --~ localised_description = {"technology-description.bi-tech-wooden-pole-2"},
  icon = ICONPATH .. "bi-tech-wooden-pole-2.png",
  icon_size = 256, icon_mipmaps = 4,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-wooden-pole-huge"
    --~ },
  },
  order = "[wooden-pole]-a-[wooden-pole-2]",
  prerequisites = {"electric-energy-distribution-2", "bi-tech-wooden-pole-1"},
  unit = {
    count = 110,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  },
  upgrade = false,
}


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
BI.additional_techs.Bio_Cannon.bio_cannon_1 = {
  type = "technology",
  name = "bi-tech-bio-cannon-1",
  --~ localised_name = {"technology-name.bi-tech-bio-cannon-1"},
  localised_description = {"technology-description.bi-tech-bio-cannon-1"},
  icon = ICONPATH .. "bi-tech-bio-cannon-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon-ammo-proto"
    --~ },

  },
  order = "[bio-ammo]-ab-[bio-cannon-1]",
  --~ prerequisites = {"military-2"},
  prerequisites = {"military-science-pack"},
  unit = {
    --~ count = 300,
    count = 75,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"military-science-pack", 1},
    },
    --~ time = 30,
    time = 20,
  }
}


BI.additional_techs.Bio_Cannon.bio_cannon_2 = {
  type = "technology",
  name = "bi-tech-bio-cannon-2",
  --~ localised_name = {"technology-name.bi-tech-bio-cannon-2"},
  localised_description = {"technology-description.bi-tech-bio-cannon-2"},
  icon = ICONPATH .. "bi-tech-bio-cannon-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon-ammo-basic"
    --~ },

  },
  order = "[bio-ammo]-ab-[bio-cannon-2]",
  prerequisites = {"bi-tech-bio-cannon-1", "rocketry"},
  unit = {
    --~ count = 300,
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"military-science-pack", 1},
    },
    time = 30,
  }
}


BI.additional_techs.Bio_Cannon.bio_cannon_3 = {
  type = "technology",
  name = "bi-tech-bio-cannon-3",
  --~ localised_name = {"technology-name.bi-tech-bio-cannon-3"},
  localised_description = {"technology-description.bi-tech-bio-cannon-3"},
  icon = ICONPATH .. "bi-tech-bio-cannon-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon-ammo-poison"
    --~ },
  },
  order = "[bio-ammo]-ab-[bio-cannon-3]",
  prerequisites = {"bi-tech-bio-cannon-2", "military-3"},
  unit = {
    --~ count = 300,
    count = 175,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"military-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    --~ time = 30,
    time = 40,
  }
}


------------------------------------------------------------------------------------
--                            Enable: Wood gasification                           --
--                       (BI.Settings.BI_Wood_Gasification)                       --
------------------------------------------------------------------------------------
BI.additional_techs.BI_Wood_Gasification.wood_gasification = {
  type = "technology",
  name = "bi-tech-wood-gasification",
  localised_name = {"technology-name.bi-tech-wood-gasification"},
  localised_description = {
    "technology-description.bi-tech-wood-gasification",
    {"fluid-name.petroleum-gas"},
    {"fluid-name.tar"},
  },
  icon = ICONPATH .. "bi-tech-refined-concrete.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "refined-concrete"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "refined-hazard-concrete"
    --~ },
  },
  order = techs["concrete"] and techs["concrete"].order .. "-[bi-refined-concrete]" or
                                "c-c-c-[bi-refined-concrete]",
  prerequisites = {"bi-tech-timber", "oil-processing"},
  unit = {
    count = 120,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  }
}


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
-- Piercing darts
BI.additional_techs.BI_Darts.piercing_darts = {
  type = "technology",
  name = "bi-tech-darts-1",
  --~ localised_name = {"technology-name.bi-tech-darts-1"},
  localised_description = {"technology-description.bi-tech-darts-1"},
  icon = ICONPATH .. "bi-tech-darts-1.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-dart-magazine-standard"
    --~ },
  },
  order = "[bio-ammo]-aa-[darts-1]",
  prerequisites = {"bi-tech-resin-extraction", "automation"},
  unit = {
    count = 100,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 30,
    --~ time = 25,
  }
}

-- Enhanced darts
BI.additional_techs.BI_Darts.enhanced_darts = {
  type = "technology",
  name = "bi-tech-darts-2",
  --~ localised_name = {"technology-name.bi-tech-darts-2"},
  localised_description = {"technology-description.bi-tech-darts-2"},
  icon = ICONPATH .. "bi-tech-darts-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-dart-magazine-enhanced"
    --~ },
  },
  order = "[bio-ammo]-aa-[darts-2]",
  prerequisites = {"bi-tech-darts-1", "plastics"},
  unit = {
    count = 225,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  }
}

-- Poison darts
BI.additional_techs.BI_Darts.poison_darts = {
  type = "technology",
  name = "bi-tech-darts-3",
  --~ localised_name = {"technology-name.bi-tech-darts-3"},
  localised_description = {"technology-description.bi-tech-darts-3"},
  icon = ICONPATH .. "bi-tech-darts-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-dart-magazine-poison"
    --~ },
  },
  order = "[bio-ammo]-aa-[darts-3]",
  prerequisites = {"bi-tech-darts-2", "military-3"},
  unit = {
    count = 120,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"military-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 30,
  }
}


------------------------------------------------------------------------------------
--                     Trigger: Make tech for Refined concrete                    --
--                        (BI.Triggers.BI_Trigger_Concrete)                       --
------------------------------------------------------------------------------------
-- Refined concrete
BI.additional_techs.BI_Trigger_Concrete.refined_concrete = {
  type = "technology",
  name = "bi-tech-refined-concrete",
  localised_name = {"technology-name.bi-tech-refined-concrete"},
  localised_description = {"technology-description.bi-tech-refined-concrete"},
  icon = ICONPATH .. "bi-tech-refined-concrete.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "refined-concrete"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "refined-hazard-concrete"
    --~ },
  },
  order = techs["concrete"] and techs["concrete"].order .. "-[bi-refined-concrete]" or
                                "c-c-c-[bi-refined-concrete]",
  prerequisites = {"concrete"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  }
}


-- Status report
BioInd.readdata_msg(BI.additional_techs, settings,
                    "optional technologies", "setting")
BioInd.readdata_msg(BI.additional_techs, triggers,
                    "optional technologies", "trigger")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
