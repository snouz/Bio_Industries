local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.techiconpath


if BI.Settings.BI_Bigger_Wooden_Chests then 

data:extend({
  

    {
      type = "technology",
      name = "bi-tech-wooden-storage-1",
      localised_name = {"technology-name.bi-tech-wooden-storage-1"},
      localised_description = {"technology-description.bi-tech-wooden-storage-1"},
      icon = ICONPATH .. "bi-tech-wooden-storage-1.png",
      icon_size = 256,
      effects = {
        BI.Settings.BI_Bigger_Wooden_Chests and {
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
        BI.Settings.BI_Bigger_Wooden_Chests and {
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
        BI.Settings.BI_Bigger_Wooden_Chests and {
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
end