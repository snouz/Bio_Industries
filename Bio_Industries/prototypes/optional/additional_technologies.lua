------------------------------------------------------------------------------------
--                  Data for some techs that depend on a setting.                 --
------------------------------------------------------------------------------------
BI.entered_file()

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.techiconpath

BI.optional_techs = BI.optional_techs or {}

for s, setting in pairs({
  --~ "BI_Game_Tweaks_Easy_Bio_Gardens",
  --~ "BI_Game_Tweaks_Production_Science",
  --~ "BI_Game_Tweaks_Disassemble",
  "Bio_Cannon",
  "BI_Bio_Fuel",
  --~ "BI_Bigger_Wooden_Chests",
  "BI_Wood_Products",
  "BI_Solar_Additions",
  "BI_Stone_Crushing",
}) do
  BI.optional_techs[setting] = BI.optional_techs[setting] or {}
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
BI.optional_techs.Bio_Cannon.bio_cannon = {
  type = "technology",
  name = "bi-tech-bio-cannon",
  icon = ICONPATH .. "bi-tech-bio_cannon.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon-proto-ammo"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon-basic-ammo"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-cannon-poison-ammo"
    --~ },

  },
  prerequisites = {"military-2"},
  unit = {
    count = 300,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"military-science-pack", 1},
    },
    time = 30,
  }
}


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
-- Biomass processing 1
BI.optional_techs.BI_Bio_Fuel.biomass_processing_1 = {
  type = "technology",
  name = "bi-tech-biomass-reprocessing-1",
  localised_name = {"technology-name.bi-tech-biomass-reprocessing-1"},
  localised_description = {"technology-description.bi-tech-biomass-reprocessing-1"},
  icon = ICONPATH .. "bi-tech-biomass-reprocessing-1.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-2"
    --~ -- },
  },
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
BI.optional_techs.BI_Bio_Fuel.biomass_processing_2 = {
  type = "technology",
  name = "bi-tech-biomass-reprocessing-2",
  localised_name = {"technology-name.bi-tech-biomass-reprocessing-2"},
  localised_description = {"technology-description.bi-tech-biomass-reprocessing-2"},
  icon = ICONPATH .. "bi-tech-biomass-reprocessing-2.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-3"
    --~ -- },
  },
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
BI.optional_techs.BI_Bio_Fuel.biomass_conversion = {
  type = "technology",
  name = "bi-tech-biomass-conversion",
  localised_name = {"technology-name.bi-tech-biomass-conversion"},
  localised_description = {"technology-description.bi-tech-biomass-conversion"},
  icon = ICONPATH .. "bi-tech-biomass-conversion.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-2"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-3"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-4"
    --~ -- },
  },
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
BI.optional_techs.BI_Bio_Fuel.cellulose_1 = {
  type = "technology",
  name = "bi-tech-cellulose-1",
  localised_name = {"technology-name.bi-tech-cellulose-1"},
  localised_description = {"technology-description.bi-tech-cellulose-1"},
  icon = ICONPATH .. "bi-tech-cellulose-1.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-cellulose-1"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-acid"
    --~ -- },
  },
  prerequisites = {"bi-tech-biomass", "sulfur-processing"},
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
BI.optional_techs.BI_Bio_Fuel.cellulose_2 = {
  type = "technology",
  name = "bi-tech-cellulose-2",
  localised_name = {"technology-name.bi-tech-cellulose-2"},
  localised_description = {"technology-description.bi-tech-cellulose-2"},
  icon = ICONPATH .. "bi-tech-cellulose-2.png",
  icon_size = 256,
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
  prerequisites = {"bi-tech-cellulose-1", "plastics", "battery"},
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
BI.optional_techs.BI_Bio_Fuel.bio_plastics = {
  type = "technology",
  name = "bi-tech-bio-plastics",
  localised_name = {"technology-name.bi-tech-bio-plastics"},
  localised_description = {"technology-description.bi-tech-bio-plastics"},
  icon = ICONPATH .. "bi-tech-bio-plastics.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-biomass-conversion-1"
    --~ -- },
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-plastic-1"
    --~ -- },
  },
  -- Technology prerequisite 'plastics' on 'bi-tech-bio-plastics' is redundant
  -- as 'advanced-oil-processing' already contains it in its prerequisite tree.
  --~ -- prerequisites = {"bi-tech-cellulose-1", "advanced-oil-processing", "plastics"},
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
BI.optional_techs.BI_Bio_Fuel.bio_boiler = {
  type = "technology",
  name = "bi-tech-bio-boiler",
  localised_name = {"technology-name.bi-tech-bio-boiler"},
  localised_description = {"technology-description.bi-tech-bio-boiler"},
  icon = ICONPATH .. "bi-tech-bio-boiler.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-bio-boiler"
    --~ -- },
  },
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
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
-- Large chests
BI.optional_techs.BI_Wood_Products.wooden_storage_1 = {
  type = "technology",
  name = "bi-tech-wooden-storage-1",
  localised_name = {"technology-name.bi-tech-wooden-storage-1"},
  localised_description = {"technology-description.bi-tech-wooden-storage-1"},
  icon = ICONPATH .. "bi-tech-wooden-storage-1.png",
  icon_size = 256,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-wooden-chest-large"
    --~ -- },
  },
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
BI.optional_techs.BI_Wood_Products.wooden_storage_2 = {
  type = "technology",
  name = "bi-tech-wooden-storage-2",
  localised_name = {"technology-name.bi-tech-wooden-storage-2"},
  localised_description = {"technology-description.bi-tech-wooden-storage-2"},
  icon = ICONPATH .. "bi-tech-wooden-storage-2.png",
  icon_size = 256,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-wooden-chest-huge"
    --~ -- },
  },
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
BI.optional_techs.BI_Wood_Products.wooden_storage_3 = {
  type = "technology",
  name = "bi-tech-wooden-storage-3",
  localised_name = {"technology-name.bi-tech-wooden-storage-3"},
  localised_description = {"technology-description.bi-tech-wooden-storage-3"},
  icon = ICONPATH .. "bi-tech-wooden-storage-3.png",
  icon_size = 256,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-wooden-chest-giga"
    --~ -- },
  },
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
BI.optional_techs.BI_Wood_Products.wooden_pole_1 = {
  type = "technology",
  name = "bi-tech-wooden-pole-1",
  localised_name = {"technology-name.bi-tech-wooden-pole-1"},
  localised_description = {"technology-description.bi-tech-wooden-pole-1"},
  icon = ICONPATH .. "bi-tech-wooden-pole-1.png",
  icon_size = 256,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-wooden-pole-big"
    --~ },
  },
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
BI.optional_techs.BI_Wood_Products.wooden_pole_2 = {
  type = "technology",
  name = "bi-tech-wooden-pole-2",
  localised_name = {"technology-name.bi-tech-wooden-pole-2"},
  localised_description = {"technology-description.bi-tech-wooden-pole-2"},
  icon = ICONPATH .. "bi-tech-wooden-pole-2.png",
  icon_size = 256,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-wooden-pole-huge"
    --~ },
  },
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
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
-- Super accumulators
BI.optional_techs.BI_Solar_Additions.super_accumulators = {
  type = "technology",
  name = "bi-tech-electric-energy-super-accumulators",
  localised_name = {"technology-name.bi-tech-electric-energy-super-accumulators"},
  localised_description = {"technology-description.bi-tech-electric-energy-super-accumulators"},
  icon = ICONPATH .. "bi-tech-electric-energy-super-accumulators.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-bio-accumulator"
    --~ -- },
  },
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
BI.optional_techs.BI_Solar_Additions.steamsolar_combination = {
  type = "technology",
  name = "bi-tech-steamsolar-combination",
  localised_name = {"technology-name.bi-tech-steamsolar-combination"},
  localised_description = {"technology-description.bi-tech-steamsolar-combination"},
  icon = ICONPATH .. "bi-tech-steamsolar-combination.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      -- recipe = "bi-solar-boiler-panel"
      --~ -- recipe = "bi-solar-boiler"
    --~ -- },
  },
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
BI.optional_techs.BI_Solar_Additions.musk_floor = {
  type = "technology",
  name = "bi-tech-musk-floor",
  localised_name = {"technology-name.bi-tech-musk-floor"},
  localised_description = {"technology-description.bi-tech-musk-floor"},
  icon = ICONPATH .. "bi-tech-musk-floor.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-solar-mat"
    --~ -- },
  },
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
BI.optional_techs.BI_Solar_Additions.super_solar_panels = {
  type = "technology",
  name = "bi-tech-super-solar-panels",
  localised_name = {"technology-name.bi-tech-super-solar-panels"},
  localised_description = {"technology-description.bi-tech-super-solar-panels"},
  icon = ICONPATH .. "bi-tech-super-solar-panels.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-bio-solar-farm"
    --~ -- },
  },
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
BI.optional_techs.BI_Solar_Additions.huge_substation = {
  type = "technology",
  name = "bi-tech-huge-substation",
  localised_name = {"technology-name.bi-tech-huge-substation"},
  localised_description = {"technology-description.bi-tech-huge-substation"},
  icon = ICONPATH .. "bi-tech-huge-substation.png",
  icon_size = 256,
  BI_add_icon = true,
  effects = {
    --~ -- {
      --~ -- type = "unlock-recipe",
      --~ -- recipe = "bi-huge-substation"
    --~ -- },
  },
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
BI.optional_techs.BI_Solar_Additions.stone_crushing_1 = {
  type = "technology",
  name = "bi-tech-stone-crushing-1",
  localised_name = {"technology-name.bi-tech-stone-crushing-1"},
  localised_description = {"technology-description.bi-tech-stone-crushing-1"},
  icon = ICONPATH .. "bi-tech-stone-crushing-1.png",
  icon_size = 256,
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
  },
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
BI.optional_techs.BI_Solar_Additions.stone_crushing_2 = {
  type = "technology",
  name = "bi-tech-stone-crushing-2",
  localised_name = {"technology-name.bi-tech-stone-crushing-2"},
  localised_description = {"technology-description.bi-tech-stone-crushing-2"},
  icon = ICONPATH .. "bi-tech-stone-crushing-2.png",
  icon_size = 256,
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
  prerequisites = {"bi-tech-stone-crushing-1", "concrete"},
  unit = {
    count = 75,
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
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
