local BioInd = require('common')('Bio_Industries')
local coal_processing = require("prototypes.Bio_Farm.coal_processing")

local ICONPATH = BioInd.modRoot .. "/graphics/technology/"

---- Bio Farm
data:extend({
  {
    type = "technology",
    name = "bi-tech-coal-processing-1",
    localised_name = {"technology-name.bi-tech-coal-processing-1"},
    localised_description = {"technology-description.bi-tech-coal-processing-1"},
    icon = ICONPATH .. "bi-tech-coal-processing-1.png",
    icon_size = 256,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Coal_128.png",
        --~ icon_size = 128,
      --~ }
    --~ },
    effects = coal_processing[1],
    prerequisites = {"advanced-material-processing", "bi-tech-ash"},
    unit = {
      count = 150,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    --~ upgrade = false,
    upgrade = true,
  },

  {
    type = "technology",
    name = "bi-tech-coal-processing-2",
    localised_name = {"technology-name.bi-tech-coal-processing-2"},
    localised_description = {"technology-description.bi-tech-coal-processing-2"},
    icon = ICONPATH .. "bi-tech-coal-processing-2.png",
    icon_size = 256,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Coal_128.png",
        --~ icon_size = 128,
      --~ }
    --~ },
    --~ effects = {
      --~ {
        --~ type = "unlock-recipe",
        --~ recipe = "bi-coal-1"
      --~ },
      --~ {
        --~ type = "unlock-recipe",
        --~ recipe = "bi-pellet-coke"
      --~ },
      --~ -- Moved here from "bi-tech-coal-processing-1" (0.18.29):
      --~ {
        --~ type = "unlock-recipe",
        --~ recipe = "bi-solid-fuel"
      --~ },
      --~ {
        --~ type = "unlock-recipe",
        --~ recipe = "bi-stone-brick"
      --~ },
    --~ },
    effects = coal_processing[2],
    --~ prerequisites = {"bi-tech-coal-processing-1"},
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
    -- Changed for 0.18.34/1.1.4 (Fixes that tech is not listed among researched techs.)
    upgrade = true,
  },

  {
    type = "technology",
    name = "bi-tech-coal-processing-3",
    localised_name = {"technology-name.bi-tech-coal-processing-3"},
    localised_description = {"technology-description.bi-tech-coal-processing-3"},
    icon = ICONPATH .. "bi-tech-coal-processing-3.png",
    icon_size = 256,
    BI_add_icon = true,
    --~ icons = {
      --~ {
        --~ icon = ICONPATH .. "Coal_128.png",
        --~ icon_size = 128,
      --~ }
    --~ },
   --~ effects = {
      --~ {
        --~ type = "unlock-recipe",
        --~ recipe = "bi-coal-2"
      --~ },
      --~ {
        --~ type = "unlock-recipe",
        --~ recipe = "bi-coke-coal"
      --~ },
    --~ },
    effects = coal_processing[3],
    --~ prerequisites = {"bi-tech-coal-processing-2"},
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
    -- Changed for 0.18.34/1.1.4 (Fixes that tech is not listed among researched techs.)
    upgrade = true,
  },








    {
      type = "technology",
      name = "bi-tech-explosive-planting-1",
      localised_name = {"technology-name.bi-tech-explosive-planting-1"},
      localised_description = {"technology-description.bi-tech-explosive-planting-1"},
      icon = ICONPATH .. "bi-tech-explosive-planting-1.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-seed-bomb-basic"
        },
      },
      prerequisites = {"bi-tech-bio-farming-1", "rocketry"},
      unit = {
        count = 40,
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
      name = "bi-tech-explosive-planting-2",
      localised_name = {"technology-name.bi-tech-explosive-planting-2"},
      localised_description = {"technology-description.bi-tech-explosive-planting-2"},
      icon = ICONPATH .. "bi-tech-explosive-planting-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-seed-bomb-standard"
        },
      },
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
    },
    {
      type = "technology",
      name = "bi-tech-explosive-planting-3",
      localised_name = {"technology-name.bi-tech-explosive-planting-3"},
      localised_description = {"technology-description.bi-tech-explosive-planting-3"},
      icon = ICONPATH .. "bi-tech-explosive-planting-3.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-seed-bomb-advanced"
        },
      },
      prerequisites = {"bi-tech-explosive-planting-2", "bi-tech-advanced-fertilizers"},
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
    },

















  {
    type = "technology",
    name = "bi-tech-bio-farming-1",
      localised_name = {"technology-name.bi-tech-bio-farming-1"},
      localised_description = {"technology-description.bi-tech-bio-farming-1"},
    icon_size = 256,
    icon = ICONPATH .. "bi-tech-bio-farming-1.png",
    BI_add_icon = true,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "bi-bio-greenhouse"
      },
      {
        type = "unlock-recipe",
        recipe = "bi-seed-1"
      },
      {
        type = "unlock-recipe",
        recipe = "bi-seedling-1"
      },
    },
    prerequisites = {"optics"},
    unit = {
      count = 25,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 20
    },
  },

{
      type = "technology",
      name = "bi-tech-bio-farming-2",
      localised_name = {"technology-name.bi-tech-bio-farming-2"},
      localised_description = {"technology-description.bi-tech-bio-farming-2"},
      icon = ICONPATH .. "bi-tech-bio-farming-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-seed-2"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-seedling-2"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-logs-2"
        },
      },
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
    },
    {
      type = "technology",
      name = "bi-tech-bio-farming-3",
      localised_name = {"technology-name.bi-tech-bio-farming-3"},
      localised_description = {"technology-description.bi-tech-bio-farming-3"},
      icon = ICONPATH .. "bi-tech-bio-farming-3.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-seed-3"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-seedling-3"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-logs-3"
        },
      },
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
    },
    {
      type = "technology",
      name = "bi-tech-bio-farming-4",
      localised_name = {"technology-name.bi-tech-bio-farming-4"},
      localised_description = {"technology-description.bi-tech-bio-farming-4"},
      icon = ICONPATH .. "bi-tech-bio-farming-4.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-seed-4"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-seedling-4"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-logs-4"
        },
      },
      prerequisites = {"bi-tech-bio-farming-3", "bi-tech-advanced-fertilizers"},
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
      name = "bi-tech-timber",
      localised_name = {"technology-name.bi-tech-timber"},
      localised_description = {"technology-description.bi-tech-timber"},
      icon = ICONPATH .. "bi-tech-timber.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-farm"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-logs-1"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-woodpulp"
        },

      },
      prerequisites = {"bi-tech-bio-farming-1", "bi-tech-stone-crushing-1"},
      unit = {
        count = 50,
        ingredients = {
          {"automation-science-pack", 1},
        },
        time = 30,
      },
      --~ upgrade = false,
      upgrade = true,
    },
    {
      type = "technology",
      name = "bi-tech-resin-extraction",
      localised_name = {"technology-name.bi-tech-resin-extraction"},
      localised_description = {"technology-description.bi-tech-resin-extraction"},
      icon = ICONPATH .. "bi-tech-resin-extraction.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-resin-pulp"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-resin-wood"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-wood-from-pulp"
        },
      },
      prerequisites = {"bi-tech-timber"},
      unit = {
        count = 75,
        ingredients = {
          {"automation-science-pack", 1},
        },
        time = 30,
      },
      --~ upgrade = false,
      upgrade = true,
    },
    {
      type = "technology",
      name = "bi-tech-ash",
      localised_name = {"technology-name.bi-tech-ash"},
      localised_description = {"technology-description.bi-tech-ash"},
      icon = ICONPATH .. "bi-tech-ash.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-cokery"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-ash-1"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-ash-2"
        },
      },
      -- Technology prerequisite 'steel-processing' on 'bi-tech-ash' is redundant
      -- as 'bi-tech-timber' already contains it in its prerequisite tree.
      --~ prerequisites = {"bi-tech-timber", "steel-processing"},
      prerequisites = {"bi-tech-timber"},
      unit = {
        count = 70,
        ingredients = {
          {"automation-science-pack", 1},
        },
        time = 30,
      },
      --~ upgrade = false,
      upgrade = true,
    },








    {
      type = "technology",
      name = "bi-terraforming-1",
      localised_name = {"technology-name.bi-terraforming-1"},
      localised_description = {"technology-description.bi-terraforming-1"},
      icon = ICONPATH .. "bi-terraforming-1.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-arboretum"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-arboretum-r1"
        },
      },
      prerequisites = {"bi-tech-bio-farming-1", "automation-2"},
      unit = {
        count = 50,
        ingredients = {
          {"automation-science-pack", 1},
        },
        time = 30,
      },
      --~ upgrade = false,
      upgrade = true,
    },
    {
      type = "technology",
      name = "bi-terraforming-2",
      localised_name = {"technology-name.bi-terraforming-2"},
      localised_description = {"technology-description.bi-terraforming-2"},
      icon = ICONPATH .. "bi-terraforming-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-arboretum-r2"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-arboretum-r4"
        },
      },
      prerequisites = {"bi-terraforming-1", "bi-tech-fertilizer"},
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
    },
    {
      type = "technology",
      name = "bi-terraforming-3",
      localised_name = {"technology-name.bi-terraforming-3"},
      localised_description = {"technology-description.bi-terraforming-3"},
      icon = ICONPATH .. "bi-terraforming-3.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-arboretum-r3"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-arboretum-r5"
        },
      },
      prerequisites = {"bi-terraforming-2", "bi-tech-advanced-fertilizers"},
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
    },




    {
      type = "technology",
      name = "bi-tech-fertilizer",
      localised_name = {"technology-name.bi-tech-fertilizer"},
      localised_description = {"technology-description.bi-tech-fertilizer"},
      icon = ICONPATH .. "bi-tech-fertilizer.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-liquid-air"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-nitrogen"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-fertilizer-1"
        },
      },
      prerequisites = {"fluid-handling","bi-tech-bio-farming-1"},
      unit = {
        count = 250,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1}
        },
        time = 30
      }
    },







    {
      type = "technology",
      name = "bi-tech-garden-1",
      localised_name = {"technology-name.bi-tech-garden-1"},
      localised_description = {"technology-description.bi-tech-garden-1"},
      icon = ICONPATH .. "bi-tech-garden-1.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-garden"
        },
      },
      prerequisites = {"bi-tech-fertilizer", "bi-tech-stone-crushing-1"},
      unit = {
        count = 170,
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
      name = "bi-tech-garden-2",
      localised_name = {"technology-name.bi-tech-garden-2"},
      localised_description = {"technology-description.bi-tech-garden-2"},
      icon = ICONPATH .. "bi-tech-garden-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-garden-large"
        },
      },
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
      --~ upgrade = false,
      upgrade = true,
    },
    {
      type = "technology",
      name = "bi-tech-garden-3",
      localised_name = {"technology-name.bi-tech-garden-3"},
      localised_description = {"technology-description.bi-tech-garden-3"},
      icon = ICONPATH .. "bi-tech-garden-3.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-garden-huge"
        },
      },
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
      --~ upgrade = false,
      upgrade = true,
    },




{
      type = "technology",
      name = "bi-tech-depollution-1",
      localised_name = {"technology-name.bi-tech-depollution-1"},
      localised_description = {"technology-description.bi-tech-depollution-1"},
      icon = ICONPATH .. "bi-tech-depollution-1.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-purified-air-1"
        },
      },
      prerequisites = {"bi-tech-garden-1"},
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
    },

    {
      type = "technology",
      name = "bi-tech-depollution-2",
      localised_name = {"technology-name.bi-tech-depollution-2"},
      localised_description = {"technology-description.bi-tech-depollution-2"},
      icon = ICONPATH .. "bi-tech-depollution-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-purified-air-2"
        },
      },
      prerequisites = {"bi-tech-depollution-1", "bi-tech-advanced-fertilizers"},
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
      name = "bi-tech-biomass",
      localised_name = {"technology-name.bi-tech-biomass"},
      localised_description = {"technology-description.bi-tech-biomass"},
      icon = ICONPATH .. "bi-tech-biomass.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-reactor"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-biomass-1"
        },
      },
      prerequisites = {"bi-tech-fertilizer"},
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
    },



    {
      type = "technology",
      name = "bi-tech-advanced-fertilizers",
      localised_name = {"technology-name.bi-tech-advanced-fertilizers"},
      localised_description = {"technology-description.bi-tech-advanced-fertilizers"},
      icon = ICONPATH .. "bi-tech-advanced-fertilizers.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-adv-fertilizer-2"
        },
      },
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
    },




    {
      type = "technology",
      name = "bi-tech-stone-crushing-1",
      localised_name = {"technology-name.bi-tech-stone-crushing-1"},
      localised_description = {"technology-description.bi-tech-stone-crushing-1"},
      icon = ICONPATH .. "bi-tech-stone-crushing-1.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-stone-crusher"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-crushed-stone-1"
        },
      },
      prerequisites = {"steel-processing"},
      unit = {
        count = 75,
        ingredients = {
          {"automation-science-pack", 1},
        },
        time = 30,
      },
      --~ upgrade = false,
      upgrade = true,
    },


    {
      type = "technology",
      name = "bi-tech-stone-crushing-2",
      localised_name = {"technology-name.bi-tech-stone-crushing-2"},
      localised_description = {"technology-description.bi-tech-stone-crushing-2"},
      icon = ICONPATH .. "bi-tech-stone-crushing-2.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-crushed-stone-2"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-crushed-stone-3"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-crushed-stone-4"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-crushed-stone-5"
        },
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
      --~ upgrade = false,
      upgrade = true,
    },







    {
      type = "technology",
      name = "bi-tech-rail-bridge",
      localised_name = {"technology-name.bi-tech-rail-bridge"},
      localised_description = {"technology-description.bi-tech-rail-bridge"},
      icon = ICONPATH .. "bi-tech-rail-bridge.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-rail-wood-bridge"
        },
      },
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
    },

    {
      type = "technology",
      name = "bi-tech-concrete-rails",
      localised_name = {"technology-name.bi-tech-concrete-rails"},
      localised_description = {"technology-description.bi-tech-concrete-rails"},
      icon = ICONPATH .. "bi-tech-concrete-rails.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "rail"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-rail-wood-to-concrete"
        },
      },
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
    },

    {
      type = "technology",
      name = "bi-tech-power-conducting-rails",
      localised_name = {"technology-name.bi-tech-power-conducting-rails"},
      localised_description = {"technology-description.bi-tech-power-conducting-rails"},
      icon = ICONPATH .. "bi-tech-power-conducting-rails.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-rail-power"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-power-to-rail-pole"
        },
      },
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
    },










{
      type = "technology",
      name = "bi-tech-wooden-pole-1",
      localised_name = {"technology-name.bi-tech-wooden-pole-1"},
      localised_description = {"technology-description.bi-tech-wooden-pole-1"},
      icon = ICONPATH .. "bi-tech-wooden-pole-1.png",
      icon_size = 256,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-wooden-pole-big"
        },
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
    },



    {
      type = "technology",
      name = "bi-tech-wooden-pole-2",
      localised_name = {"technology-name.bi-tech-wooden-pole-2"},
      localised_description = {"technology-description.bi-tech-wooden-pole-2"},
      icon = ICONPATH .. "bi-tech-wooden-pole-2.png",
      icon_size = 256,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-wooden-pole-huge"
        },
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
    },









    {
      type = "technology",
      name = "bi-tech-wooden-storage-1",
      localised_name = {"technology-name.bi-tech-wooden-storage-1"},
      localised_description = {"technology-description.bi-tech-wooden-storage-1"},
      icon = ICONPATH .. "bi-tech-wooden-storage-1.png",
      icon_size = 256,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-wooden-chest-large"
        },
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
    },



    {
      type = "technology",
      name = "bi-tech-wooden-storage-2",
      localised_name = {"technology-name.bi-tech-wooden-storage-2"},
      localised_description = {"technology-description.bi-tech-wooden-storage-2"},
      icon = ICONPATH .. "bi-tech-wooden-storage-2.png",
      icon_size = 256,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-wooden-chest-huge"
        },
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
    },


    
    {
      type = "technology",
      name = "bi-tech-wooden-storage-3",
      localised_name = {"technology-name.bi-tech-wooden-storage-3"},
      localised_description = {"technology-description.bi-tech-wooden-storage-3"},
      icon = ICONPATH .. "bi-tech-wooden-storage-3.png",
      icon_size = 256,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-wooden-chest-giga"
        },
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
    },





    
})



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






if BI.Settings.Bio_Cannon then

  data:extend({
    {
      type = "technology",
      name = "bi-tech-bio-cannon",
      icon = ICONPATH .. "bi-tech-bio_cannon.png",
      icon_size = 256,
      BI_add_icon = true,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "bi-bio-cannon"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-bio-cannon-proto-ammo"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-bio-cannon-basic-ammo"
        },
        {
          type = "unlock-recipe",
          recipe = "bi-bio-cannon-poison-ammo"
        },

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
    },
  })
end
