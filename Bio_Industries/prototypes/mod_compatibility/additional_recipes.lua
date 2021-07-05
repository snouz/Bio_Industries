------------------------------------------------------------------------------------
--    Data for some recipes that will be needed if one of several mods is used.   --
------------------------------------------------------------------------------------
BI.entered_file()

local BioInd = require('common')('Bio_Industries')
local ICONPATH = BioInd.iconpath

BI.additional_recipes = BI.additional_recipes or {}

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--          General recipe for sand (will be adjusted later if necessary)         --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining"),
-- BioTech ("BioTech"),
-- Krastorio2 ("Krastorio2")
BI.additional_recipes.sand = {
  type = "recipe",
  name = "bi-sand",
  icon = ICONPATH .. "mod_aai/sand-aai.png",
  icon_size = 64,
  BI_add_icon = true,
  BI_add_to_tech = {"bi-tech-stone-crushing-1"},
  category = "biofarm-mod-crushing",
  --~ subgroup = "bio-bio-farm-raw",
  subgroup = "bio-stone-crusher",
  --~ order = "a[bi]-a-z[bi-9-sand]",
  order = "a[bi]-a-z[bi-9-stone-crushed-sand-1]",
  energy_required = 1,
  ingredients = {{"stone-crushed", 2}},
  result = "sand",
  result_count = 5,
  main_product = "",
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  allow_as_intermediate = true,     -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,       -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,               -- Changed for 0.18.34/1.1.4
}


------------------------------------------------------------------------------------
--                        Fertilizer from sodium-hydroxide                        --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem"),
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
BI.additional_recipes.fertilizer = {
  type = "recipe",
  name = "bi-fertilizer-2",
  icon = ICONPATH .. "mod_bobangels/fertilizer_sodium_hydroxide.png",
  icon_size = 64,
  BI_add_icon = true,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-fertilizer"},
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "fluid", name = "nitrogen", amount = 10},
    {type = "item", name = "bi-ash", amount = 10}
  },
  results = {
    {type = "item", name = "fertilizer", amount = 5}
  },
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  allow_as_intermediate = true,       -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,         -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,         -- Changed for 0.18.34/1.1.4
  subgroup = "bio-bio-farm-intermediate-product",
  order = "b[bi-fertilizer]",
}


------------------------------------------------------------------------------------
--        Pellet coke (alternative recipe, ingredients will be added later)       --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
BI.additional_recipes.pellet_coke = {
  type = "recipe",
  name = "bi-pellet-coke-2",
  icon = ICONPATH .. "mod_bobangels/pellet_coke_b.png",
  icon_size = 64,
  BI_add_icon = true,
  BI_add_to_tech = {"bi-tech-coal-processing-2"},
  category = "biofarm-mod-smelting",
  subgroup = "bio-bio-farm-raw",
  order = "a[bi]-a-g[bi-coke-coal]-2",
  energy_required = 4,
  ingredients = {},
  result = "pellet-coke",
  result_count = 1,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  enabled = false,
}


------------------------------------------------------------------------------------
--                        Mineralized sulfuric waste water                        --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
BI.additional_recipes.sulfuric_waste = {
  type = "recipe",
  name = "bi-mineralized-sulfuric-waste",
  icon = ICONPATH .. "mod_bobangels/bi_mineralized_sulfuric.png",
  icon_size = 64,
  BI_add_icon = true,
  BI_add_to_tech = {"water-treatment"},
  category = "liquifying",
  subgroup = "water-treatment",
  energy_required = 2,
  ingredients = {
    {type = "fluid", name = "water-purified", amount = 100},
    {type = "item", name = "stone-crushed", amount = 90},
    {type = "item", name = "wood-charcoal", amount = 30},
  },
  results= {
    {type = "fluid", name = "water-yellow-waste", amount = 40},
     {type = "fluid", name = "water-mineralized", amount = 60},
  },
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  allow_decomposition = false,
  order = "a[water-water-mineralized]-2",
}


------------------------------------------------------------------------------------
--                                   Slag slurry                                  --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
BI.additional_recipes.slag_slurry = {
  type = "recipe",
  name = "bi-slag-slurry",
  icon = ICONPATH .. "mod_bobangels/bi_slurry.png",
  icon_size = 64,
  BI_add_icon = true,
  BI_add_to_tech = {"slag-processing-1"},
  category = "liquifying",
  subgroup = "liquifying",
  energy_required = 4,
  ingredients = {
    {type = "fluid", name = "water-saline", amount = 50},
    {type = "item", name = "stone-crushed", amount = 90},
    {type = "item", name = "bi-ash", amount = 40},
  },
  results = {
    {type = "fluid", name = "slag-slurry", amount = 100},
  },
  enabled = false,
  allow_as_intermediate = false,
  always_show_made_in = true,
  allow_decomposition = false,
  order = "i [slag-processing-dissolution]-2",
}
--~ thxbob.lib.tech.add_recipe_unlock("water-treatment", "bi-mineralized-sulfuric-waste")
--~ thxbob.lib.tech.add_recipe_unlock("slag-processing-1", "bi-slag-slurry")


------------------------------------------------------------------------------------
--                      Alternative recipe for Wooden boards                      --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
BI.additional_recipes.press_wood = {
  type = "recipe",
  name = "bi-press-wood",
  localised_name = {"recipe-name.bi-press-wood"},
  icon = ICONPATH .. "mod_bobangels/bi_wooden_board.png",
  icon_size = 64,
  BI_add_icon = true,
  BI_add_to_tech = {"electronics"},
  subgroup = "bob-boards",
  order = "c-a1[wooden-board]",
  category = "electronics",
  energy_required = 1,
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  ingredients = {
    {type = "item", name = "bi-woodpulp", amount = 3},
    {type = "item", name = "resin", amount = 1},
  },
  results = {
    {type = "item", name = "wooden-board", amount = 6}
  },
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
}


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
