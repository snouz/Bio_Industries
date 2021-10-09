------------------------------------------------------------------------------------
--                   Data for recipes that depend on a trigger.                   --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

BI.additional_recipes = BI.additional_recipes or {}

local triggers = {
  "BI_Trigger_Easy_Bio_Gardens",
  "BI_Trigger_Sand",
  "BI_Trigger_Woodpulp_Create",
}
for t, trigger in pairs(triggers) do
  BI.additional_recipes[trigger] = BI.additional_recipes[trigger] or {}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                    Triggers                                    --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                            Trigger: Easy Bio gardens                           --
--                    (BI.Triggers.BI_Trigger_Easy_Bio_Gardens)                   --
------------------------------------------------------------------------------------
-- Fertilizer fluid (Tints will be added later)
BI.additional_recipes.BI_Trigger_Easy_Bio_Gardens.fertilizer_fluid = {
  type = "recipe",
  name = "bi-fertilizer-fluid",
  localised_description = {
    "recipe-description.bi-fertilizer-fluid",
    {"fluid-name.water"},
  },
  icon = ICONPATH .. "fluid_fertilizer.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "item", name = "fertilizer", amount = 3},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "fluid", name = "bi-fertilizer-fluid", amount = 100}
  },
  main_product = "",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  order = "b[bi-fertilizer]-b[bi-fertilizer-fluid-1]",
  crafting_machine_tint = {
    -- Kettle
    primary     = util.color("5e9347"),
    secondary   = util.color("72be51"),
    -- Chimney
    tertiary    = util.color("63ae42"),
    quaternary  = util.color("58af33")
  },
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-fertilizer"},
}

-- Advanced fertilizer fluid (Tints will be added later)
BI.additional_recipes.BI_Trigger_Easy_Bio_Gardens.adv_fertilizer_fluid = {
  type = "recipe",
  name = "bi-adv-fertilizer-fluid",
  localised_description = {
    "recipe-description.bi-adv-fertilizer-fluid",
    {"fluid-name.water"},
  },
  icon = ICONPATH .. "fluid_fertilizer_advanced.png",
  icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  category = "chemistry",
  energy_required = 5,
  ingredients = {
    {type = "item", name = "bi-adv-fertilizer", amount = 3},
    {type = "fluid", name = "water", amount = 100},
  },
  results = {
    {type = "fluid", name = "bi-adv-fertilizer-fluid", amount = 100}
  },
  main_product = "",
  enabled = false,
  always_show_made_in = true,
  allow_decomposition = false,
  allow_as_intermediate = false,
  subgroup = BI.default_item_subgroup.bio_farm_intermediate_product.name,
  order = "b[bi-fertilizer]-b[bi-fertilizer-fluid-2]",
  crafting_machine_tint = {
    -- Kettle
    primary     = util.color("d04677"),
    secondary   = util.color("b82e5f"),
    -- Chimney
    tertiary    = util.color("b64f73"),
    quaternary  = util.color("b85e84")
  },
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-advanced-fertilizer"},
}


------------------------------------------------------------------------------------
--                General recipe for sand (will be adjusted later)                --
------------------------------------------------------------------------------------
-- Angel's Smelting ("angelssmelting"),
-- BioTech ("BioTech"),
-- Krastorio2 ("Krastorio2")
BI.additional_recipes.BI_Trigger_Sand.sand = {
  type = "recipe",
  name = "bi-sand",
  --icon = ICONPATH .. "mod_aai/sand-aai.png",
  --icon_size = 64, icon_mipmaps = 3,
  --BI_add_icon = true,
  --~ --icons = BioInd.make_icons({it1 = "sand", it2 = "crushed-stone", shift1_1=0 , shift1_2=0}),
  icons = {it1 = "sand", it2 = "crushed-stone", shift1_1=0 , shift1_2=0},
  BI_add_icon = true,
  BI_add_to_tech = {"bi-tech-stone-crushing-1"},
  category = BI.additional_categories.BI_Stone_Crushing.crushing.name,
  --~ --subgroup = "bio-bio-farm-raw",
  subgroup = BI.additional_categories.BI_Stone_Crushing.stone_crusher.name,
  --~ --order = "a[bi]-a-z[bi-9-sand]",
  order = "a[bi]-a-z[bi-9-stone-crushed-sand-1]",
  energy_required = 1,
  ingredients = {{"stone-crushed", 2}},
  --~ --result = "sand",
  --~ --result_count = 5,
  main_product = "",
  enabled = false,
  --~ --always_show_made_in = true,
  --~ --allow_decomposition = false,
  --~ --allow_as_intermediate = false,
  allow_as_intermediate = true,     -- Changed for 0.18.34/1.1.4
  always_show_made_in = true,       -- Changed for 0.18.34/1.1.4
  allow_decomposition = true,               -- Changed for 0.18.34/1.1.4
}


------------------------------------------------------------------------------------
--                        Trigger: Create item "wood pulp"?                       --
--                    (BI.Triggers.BI_Trigger_Woodpulp_Create)                    --
------------------------------------------------------------------------------------
-- Mods: not "IndustrialRevolution"
-- Wood Pulp
BI.additional_recipes.BI_Trigger_Woodpulp_Create.woodpulp = {
  type = "recipe",
  name = "bi-woodpulp",
  --icon = ICONPATH .. "woodpulp.png",
  --icon_size = 64, icon_mipmaps = 3,
  BI_add_icon = true,
  subgroup = BI.default_item_subgroup.bio_farm_raw.name,
  order = "a[bi]-a-a[bi-1-woodpulp]",
  enabled = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ allow_as_intermediate = false,
  energy_required = 1,
  ingredients = {{"wood", 1}},
  result = "bi-woodpulp",
  result_count = 2,
  allow_as_intermediate = true,       -- Added for 0.18.34/1.1.4
  allow_intermediates = true,         -- Added for 0.18.35/1.1.5
  always_show_made_in = false,        -- Added for 0.18.34/1.1.4
  allow_decomposition = false,        -- Added for 0.18.34/1.1.4
  -- This is a custom property for use by "Krastorio 2" (it will change
  -- ingredients/results; used for wood/wood pulp)
  mod = "Bio_Industries",
  -- Custom property that allows to automatically add our recipes to tech unlocks.
  BI_add_to_tech = {"bi-tech-timber"},
}


-- Status report
BioInd.debugging.readdata_msg(BI.additional_recipes, triggers, "optional recipes", "trigger")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
