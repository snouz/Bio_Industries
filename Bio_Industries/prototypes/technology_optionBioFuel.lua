local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.techiconpath

if BI.Settings.BI_Bio_Fuel then

data:extend({

    {
      type = "technology",
      name = "bi-tech-biomass-reprocessing-1",
      localised_name = {"technology-name.bi-tech-biomass-reprocessing-1"},
      localised_description = {"technology-description.bi-tech-biomass-reprocessing-1"},
      icon = ICONPATH .. "bi-tech-biomass-reprocessing-1.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-biomass-2"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

    {
      type = "technology",
      name = "bi-tech-biomass-reprocessing-2",
      localised_name = {"technology-name.bi-tech-biomass-reprocessing-2"},
      localised_description = {"technology-description.bi-tech-biomass-reprocessing-2"},
      icon = ICONPATH .. "bi-tech-biomass-reprocessing-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-biomass-3"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

    {
      type = "technology",
      name = "bi-tech-biomass-conversion",
      localised_name = {"technology-name.bi-tech-biomass-conversion"},
      localised_description = {"technology-description.bi-tech-biomass-conversion"},
      icon = ICONPATH .. "bi-tech-biomass-conversion.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-biomass-conversion-2"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-biomass-conversion-3"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-biomass-conversion-4"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },


    {
      type = "technology",
      name = "bi-tech-cellulose-1",
      localised_name = {"technology-name.bi-tech-cellulose-1"},
      localised_description = {"technology-description.bi-tech-cellulose-1"},
      icon = ICONPATH .. "bi-tech-cellulose-1.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-cellulose-1"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-acid"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

    {
      type = "technology",
      name = "bi-tech-cellulose-2",
      localised_name = {"technology-name.bi-tech-cellulose-2"},
      localised_description = {"technology-description.bi-tech-cellulose-2"},
      icon = ICONPATH .. "bi-tech-cellulose-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-cellulose-2"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-plastic-2"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-battery"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },


    {
      type = "technology",
      name = "bi-tech-bio-plastics",
      localised_name = {"technology-name.bi-tech-bio-plastics"},
      localised_description = {"technology-description.bi-tech-bio-plastics"},
      icon = ICONPATH .. "bi-tech-bio-plastics.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-biomass-conversion-1"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-plastic-1"
        },
      },
      -- Technology prerequisite 'plastics' on 'bi-tech-bio-plastics' is redundant
      -- as 'advanced-oil-processing' already contains it in its prerequisite tree.
      --~ prerequisites = {"bi-tech-cellulose-1", "advanced-oil-processing", "plastics"},
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
      --~ upgrade = false,
      upgrade = true,
    },


    {
      type = "technology",
      name = "bi-tech-bio-boiler",
      localised_name = {"technology-name.bi-tech-bio-boiler"},
      localised_description = {"technology-description.bi-tech-bio-boiler"},
      icon = ICONPATH .. "bi-tech-bio-boiler.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-boiler"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

})
end
