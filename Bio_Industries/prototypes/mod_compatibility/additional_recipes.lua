------------------------------------------------------------------------------------
--    Data for some recipes that will be needed if one of several mods is used.   --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])
local ICONPATH = BioInd.iconpath
local items = data.raw.item

BI.additional_recipes = BI.additional_recipes or {}
BI.additional_recipes.mod_compatibility = BI.additional_recipes.mod_compatibility or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



--~ ------------------------------------------------------------------------------------
--~ --                General recipe for sand (will be adjusted later)                --
--~ ------------------------------------------------------------------------------------
--~ -- Angel's Smelting ("angelssmelting"),
--~ -- BioTech ("BioTech"),
--~ -- Krastorio2 ("Krastorio2")
--~ BI.additional_recipes.mod_compatibility.sand = {
  --~ type = "recipe",
  --~ name = "bi-sand",
  --~ --icon = ICONPATH .. "mod_aai/sand-aai.png",
  --~ --icon_size = 64, icon_mipmaps = 3,
  --~ --BI_add_icon = true,
  --icons = BioInd.make_icons({it1 = "sand", it2 = "crushed-stone", shift1_1=0 , shift1_2=0}),
  --~ icons = {it1 = "sand", it2 = "crushed-stone", shift1_1=0 , shift1_2=0},
  --~ BI_add_icon = true,
  --~ BI_add_to_tech = {"bi-tech-stone-crushing-1"},
  --~ category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  --subgroup = "bio-bio-farm-raw",
  --~ subgroup = BI.additional_categories.BI_Stone_Crushing.stone_crusher.name,
  --order = "a[bi]-a-z[bi-9-sand]",
  --~ order = "a[bi]-a-z[bi-9-stone-crushed-sand-1]",
  --~ energy_required = 1,
  --~ ingredients = {{"stone-crushed", 2}},
  --result = "sand",
  --result_count = 5,
  --~ main_product = "",
  --~ enabled = false,
  --always_show_made_in = true,
  --allow_decomposition = false,
  --allow_as_intermediate = false,
  --~ allow_as_intermediate = true,     -- Changed for 0.18.34/1.1.4
  --~ always_show_made_in = true,       -- Changed for 0.18.34/1.1.4
  --~ allow_decomposition = true,               -- Changed for 0.18.34/1.1.4
--~ }


------------------------------------------------------------------------------------
--                        Fertilizer from sodium-hydroxide                        --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem"),
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
BI.additional_recipes.mod_compatibility.fertilizer_2 = {
  type = "recipe",
  name = "bi-fertilizer-2",
  localised_name = {"recipe-name.bi-fertilizer"},
  localised_description = {"recipe-description.bi-fertilizer"},
  --icon = ICONPATH .. "mod_bobangels/fertilizer_sodium_hydroxide.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --~ icons = BioInd.make_icons({it1 = "fertilizer", it2 = "sodium-hydroxide", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}),
  icons = {it1 = "fertilizer", it2 = "sodium-hydroxide", it3 = "", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0},
  BI_add_icon = true,
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-fertilizer"},
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    -- Add "sodium-hydroxide" or "solid-sodium-hydroxide" in data-updates (Angel's/Bob's)!
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
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  order = "b[bi-fertilizer]",
}


------------------------------------------------------------------------------------
--        Pellet coke (alternative recipe, ingredients will be added later)       --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
BI.additional_recipes.mod_compatibility.pellet_coke_2 = {
  type = "recipe",
  name = "bi-pellet-coke-2",
  --~ localised_name = {"recipe-name.bi-pellet-coke"},
  --~ localised_description = {"recipe-description.bi-pellet-coke"},
  --icon = ICONPATH .. "mod_bobangels/pellet_coke_b.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  BI_add_to_tech = {"bi-tech-coal-processing-2"},
  category = BI.default_recipe_categories.smelting.name,
  subgroup = BI.default_item_subgroup.cokery.name,
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
BI.additional_recipes.mod_compatibility.sulfuric_waste = {
  type = "recipe",
  name = "bi-mineralized-sulfuric-waste",
  localised_name = {"recipe-name.bi-mineralized-sulfuric-waste"},
  --icon = ICONPATH .. "mod_bobangels/bi_mineralized_sulfuric.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
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
  main_product = "water-mineralized",
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
BI.additional_recipes.mod_compatibility.slag_slurry = {
  type = "recipe",
  name = "bi-slag-slurry",
  --icon = ICONPATH .. "mod_bobangels/bi_slurry.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
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
BI.additional_recipes.mod_compatibility.press_wood = {
  type = "recipe",
  name = "bi-press-wood",
  localised_name = {"recipe-name.bi-press-wood"},
  --icon = ICONPATH .. "mod_bobangels/bi_wooden_board.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --icons = BioInd.make_icons("wooden-board", "bi-woodpulp", 0,0, "resin", 0,0),
  --~ icons = BioInd.make_icons({it1 = "wooden-board", it2 = "woodpulp", it3 = "resin", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}),
  icons = {it1 = "wooden-board", it2 = "woodpulp", it3 = "resin", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0},
  BI_add_icon = true,
  BI_add_to_tech = {"electronics"},
  subgroup = "bob-boards",
  order = "c-a1bi[wooden-board]",
  category = "electronics",
  energy_required = 1,
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  always_show_made_in = false,
  allow_decomposition = false,
  allow_as_intermediate = true,
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



-- Status report
BioInd.debugging.readdata_msg(BI.additional_recipes, mod_compatibility,
                    "additional recipes", "compatibility with other mods")

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
