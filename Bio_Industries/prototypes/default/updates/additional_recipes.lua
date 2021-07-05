BioInd.entered_file()

BI.additional_recipes = BI.additional_recipes or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
--                                  Fluid recipes                                 --
------------------------------------------------------------------------------------
-- Liquid air
BI.additional_recipes.liquid_air = {
  type = "recipe",
  name = "bi-liquid-air",
  icon = ICONPATH .. "fluid_liquid-air.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 1,
  ingredients = {},
  results = {
    {type = "fluid", name = "liquid-air", amount = 10}
  },
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  subgroup = "bio-bio-farm-intermediate-product",
  order = "aa",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-fertilizer"},
}


-- Nitrogen
BI.additional_recipes.nitrogen = {
  type = "recipe",
  name = "bi-nitrogen",
  icon = ICONPATH .. "fluid_nitrogen.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "fluid", name = "liquid-air", amount = 10}
  },
  results = {
    {type = "fluid", name = "nitrogen", amount = 10},
  },
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  --main_product= "nitrogen",
  subgroup = "bio-bio-farm-intermediate-product",
  order = "ab",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-fertilizer"},
}


------------------------------------------------------------------------------------
--                               Fertilizer recipes                               --
------------------------------------------------------------------------------------
-- Advanced fertilizer 1
BI.additional_recipes.adv_fertilizer_1 = {
  type = "recipe",
  name = "bi-adv-fertilizer-1",
  --~ icon = ICONPATH .. "advanced_fertilizer_64.png",
  icon = ICONPATH .. "fertilizer_advanced.png",
  icon_size = 64, icon_mipmaps = 3,
  icon_mipmaps = 4,
  BI_add_icon = true,
  --~ icons = {
    --~ {
      -- icon = ICONPATH .. "advanced_fertilizer_64.png",
      --~ icon = ICONPATH .. "fertilizer_advanced.png",
      --~ icon_size = 64,
    --~ }
  --~ },
  category = "chemistry",
  energy_required = 50,
  ingredients = {
    {type = "item", name = "alien-artifact", amount = 5},
    {type = "item", name = "fertilizer", amount = 25},
    {type = "fluid", name = "bi-biomass", amount = 10},
  },
  results = {
    {type = "item", name = "bi-adv-fertilizer", amount = 50}
  },
  main_product = "",
  enabled = false,
  --~ --always_show_made_in = true,
  --~ --allow_decomposition = false,
  --~ --allow_as_intermediate = false,
  allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,         -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "bio-bio-farm-intermediate-product",
  order = "b[bi-fertilizer]-b[bi-adv-fertilizer-1]",
}


-- Status report
BioInd.readdata_msg(BI.additional_recipes, nil, "additional recipes")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
