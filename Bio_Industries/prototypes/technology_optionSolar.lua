local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.techiconpath

if BI.Settings.BI_Solar_Additions and not data.raw.technology["bob-solar-energy-2"] and not data.raw.technology["bob-solar-energy-3"] then

data:extend({

    {
      type = "technology",
      name = "bi-tech-electric-energy-super-accumulators",
      localised_name = {"technology-name.bi-tech-electric-energy-super-accumulators"},
      localised_description = {"technology-description.bi-tech-electric-energy-super-accumulators"},
      icon = ICONPATH .. "bi-tech-electric-energy-super-accumulators.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-accumulator"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

    {
      type = "technology",
      name = "bi-tech-steamsolar-combination",
      localised_name = {"technology-name.bi-tech-steamsolar-combination"},
      localised_description = {"technology-description.bi-tech-steamsolar-combination"},
      icon = ICONPATH .. "bi-tech-steamsolar-combination.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          --~ recipe = "bi-solar-boiler-panel"
          recipe = "bi-solar-boiler"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

    {
      type = "technology",
      name = "bi-tech-musk-floor",
      localised_name = {"technology-name.bi-tech-musk-floor"},
      localised_description = {"technology-description.bi-tech-musk-floor"},
      icon = ICONPATH .. "bi-tech-musk-floor.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-solar-mat"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

    {
      type = "technology",
      name = "bi-tech-super-solar-panels",
      localised_name = {"technology-name.bi-tech-super-solar-panels"},
      localised_description = {"technology-description.bi-tech-super-solar-panels"},
      icon = ICONPATH .. "bi-tech-super-solar-panels.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-solar-farm"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },


    {
      type = "technology",
      name = "bi-tech-huge-substation",
      localised_name = {"technology-name.bi-tech-huge-substation"},
      localised_description = {"technology-description.bi-tech-huge-substation"},
      icon = ICONPATH .. "bi-tech-huge-substation.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-large-substation"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },

})
end