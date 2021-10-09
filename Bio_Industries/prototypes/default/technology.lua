BioInd.debugging.entered_file()

BI.default_techs = BI.default_techs or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.techiconpath


------------------------------------------------------------------------------------
--                                   Bio farming                                  --
------------------------------------------------------------------------------------
-- Bio-farming 1
BI.default_techs.bio_farming_1 = {
  type = "technology",
  name = "bi-tech-bio-farming-1",
  --~ localised_name = {"technology-name.bi-tech-bio-farming-1"},
  localised_description = {"technology-description.bi-tech-bio-farming-1"},
  icon_size = 256, icon_mipmaps = 4,
  icon = ICONPATH .. "bi-tech-bio-farming-1.png",
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-greenhouse"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seed-1"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seedling-1"
    --~ },
  },
  order = "[bio-farming]-a-[bio-farming-1]",
  prerequisites = {"optics"},
  unit = {
    count = 25,
    ingredients = {
      {"automation-science-pack", 1}
    },
    time = 20
  },
}

-- Bio-farming 2
BI.default_techs.bio_farming_2 = {
  type = "technology",
  name = "bi-tech-bio-farming-2",
  --~ localised_name = {"technology-name.bi-tech-bio-farming-2"},
  localised_description = {"technology-description.bi-tech-bio-farming-2"},
  icon = ICONPATH .. "bi-tech-bio-farming-2.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seed-2"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seedling-2"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-logs-2"
    --~ },
  },
  order = "[bio-farming]-a-[bio-farming-2]",
  prerequisites = {"bi-tech-ash"},
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

-- Bio-farming 3
BI.default_techs.bio_farming_3 = {
  type = "technology",
  name = "bi-tech-bio-farming-3",
  --~ localised_name = {"technology-name.bi-tech-bio-farming-3"},
  localised_description = {"technology-description.bi-tech-bio-farming-3"},
  icon = ICONPATH .. "bi-tech-bio-farming-3.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seed-3"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seedling-3"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-logs-3"
    --~ },
  },
  order = "[bio-farming]-a-[bio-farming-3]",
  prerequisites = {"bi-tech-bio-farming-2", "bi-tech-fertilizer"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}

-- Bio-farming 4
BI.default_techs.bio_farming_4 = {
  type = "technology",
  name = "bi-tech-bio-farming-4",
  --~ localised_name = {"technology-name.bi-tech-bio-farming-4"},
  localised_description = {"technology-description.bi-tech-bio-farming-4"},
  icon = ICONPATH .. "bi-tech-bio-farming-4.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seed-4"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-seedling-4"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-logs-4"
    --~ },
  },
  order = "[bio-farming]-a-[bio-farming-4]",
  prerequisites = {"bi-tech-bio-farming-3", "bi-tech-advanced-fertilizer"},
  unit = {
    count = 250,
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
--                                     Timber                                     --
------------------------------------------------------------------------------------
BI.default_techs.timber = {
  type = "technology",
  name = "bi-tech-timber",
  localised_name = {"technology-name.bi-tech-timber"},
  localised_description = {"technology-description.bi-tech-timber"},
  icon = ICONPATH .. "bi-tech-timber.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-farm"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-logs-1"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-woodpulp"
    --~ },

  },
  order = "[bio-farming]-b-[timber]",
  --~ prerequisites = {"bi-tech-bio-farming-1", "bi-tech-stone-crushing-1"},
  prerequisites = {"bi-tech-bio-farming-1"},
  unit = {
    count = 50,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                                       Ash                                      --
------------------------------------------------------------------------------------
BI.default_techs.ash = {
  type = "technology",
  name = "bi-tech-ash",
  localised_name = {"technology-name.bi-tech-ash"},
  localised_description = {"technology-description.bi-tech-ash"},
  icon = ICONPATH .. "bi-tech-ash.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-cokery"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-ash-1"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-ash-2"
    --~ },
  },
  --~ -- Technology prerequisite 'steel-processing' on 'bi-tech-ash' is redundant
  --~ -- as 'bi-tech-timber' already contains it in its prerequisite tree.
  prerequisites = {"bi-tech-timber", "steel-processing"},
  --~ prerequisites = {"bi-tech-timber"},
  order = "[bio-farming]-c-[ash]",
  unit = {
    count = 70,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 30,
  },
  --~ upgrade = false,
  upgrade = true,
}


------------------------------------------------------------------------------------
--                                   Fertilizer                                   --
------------------------------------------------------------------------------------
BI.default_techs.fertilizer = {
  type = "technology",
  name = "bi-tech-fertilizer",
  localised_name = {"technology-name.bi-tech-fertilizer"},
  localised_description = {"technology-description.bi-tech-fertilizer"},
  icon = ICONPATH .. "bi-tech-fertilizer.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-liquid-air"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-nitrogen"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-fertilizer-1"
    --~ },
  },
  order = "[bi-fertilizer]-a-[fertilizer]",
  --~ prerequisites = {"fluid-handling","bi-tech-bio-farming-1"},
  --~ prerequisites = {"fluid-handling", "bi-tech-ash"},
  prerequisites = {"sulfur-processing", "bi-tech-ash"},
  unit = {
    count = 250,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1}
    },
    time = 30
  }
}


------------------------------------------------------------------------------------
--                                     Biomass                                    --
------------------------------------------------------------------------------------
BI.default_techs.biomass = {
  type = "technology",
  name = "bi-tech-biomass",
  localised_name = {"technology-name.bi-tech-biomass"},
  localised_description = {"technology-description.bi-tech-biomass", {"fluid-name.bi-biomass"}},
  icon = ICONPATH .. "bi-tech-biomass.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-bio-reactor"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-biomass-1"
    --~ },
  },
  order = "[bi-biomass]-a-[biomass]",
  prerequisites = {"chemical-science-pack", "bi-tech-fertilizer"},
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
--                              Advanced fertilizers                              --
------------------------------------------------------------------------------------
BI.default_techs.advanced_fertilizer = {
  type = "technology",
  name = "bi-tech-advanced-fertilizer",
  localised_name = {"technology-name.bi-tech-advanced-fertilizer"},
  localised_description = {"technology-description.bi-tech-advanced-fertilizer"},
  icon = ICONPATH .. "bi-tech-advanced-fertilizers.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "bi-adv-fertilizer-1"
    --~ },
  },
  order = "[bi-fertilizer]-b-[advanced-fertilizer]",
  prerequisites = {"bi-tech-biomass"},
  unit = {
    count = 225,
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


--~ ------------------------------------------------------------------------------------
--~ --                                Pollution sensor                                --
--~ ------------------------------------------------------------------------------------
--~ BI.default_techs.pollution_sensor = {
  --~ type = "technology",
  --~ name = "bi-tech-pollution-sensor",
  --~ localised_name = {"technology-name.bi-tech-pollution-sensor"},
  --~ localised_description = {"technology-description.bi-tech-pollution-sensor"},
  --~ icon = ICONPATH .. "bi-tech-pollution-sensor.png",
  --~ icon_size = 256, icon_mipmaps = 4,
  --~ BI_add_icon = true,
  --~ effects = {
  --~ },
  --~ order = "[bi-pollution]-b-[pollution-sensor]",
  --~ prerequisites = {"advanced-electronics", "circuit-network"},
  --~ unit = {
    --~ count = 120,
    --~ ingredients = {
      --~ {"automation-science-pack", 1},
      --~ {"logistic-science-pack", 1},
    --~ },
    --~ time = 30,
  --~ },
  --~ upgrade = false,
--~ }


------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_techs)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
