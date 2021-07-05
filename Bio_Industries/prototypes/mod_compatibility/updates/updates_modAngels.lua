------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "angelspetrochem",
  "angelsbioprocessing",
  "angelsrefining",
}) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath .. "mod_bobangels/"
local icon_map

local recipe, item, entity, ingredients, addit

local items = data.raw.item
local fluids = data.raw.fluid
local recipes = data.raw.recipe

------------------------------------------------------------------------------------
--                               Solar boiler/plant                               --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if items["angels-electric-boiler"] and BI.Settings.BI_Solar_Additions then
  --~ recipe = recipes["bi-solar-boiler"]
  recipe = recipes[BI.additional_recipes.BI_Solar_Additions.solar_boiler.name]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "boiler")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "angels-electric-boiler",
      amount = 1}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                             Pellet coke from Carbon                            --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if items["solid-carbon"] and BI.Settings["BI_Coal_Processing"] then
  -- Change recipe icons
  icon_map = {
    ["bi-coke-coal"]            = "pellet_coke_1",
    ["bi-pellet-coke"]          = "pellet_coke_c",
    ["bi-pellet-coke-2"]        = "pellet_coke_a",
  }

  for r, r_data in ipairs({
    BI.additional_recipes.BI_Coal_Processing.coke_coal,
    BI.additional_recipes.BI_Coal_Processing.pellet_coke,
    BI.additional_recipes.mod_compatibility.pellet_coke_2
  }) do
    recipe = recipes[r_data.name] or BioInd.create_stuff(r_data)[1]
    BioInd.BI_change_icon(recipes[recipe.name], ICONPATH .. icon_map[recipe.name] .. ".png")
  end

  -- Add ingredient to "bi-pellet-coke-2"
  recipe = recipes[BI.additional_recipes.mod_compatibility.pellet_coke_2.name]
  if recipe then
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "solid-carbon",
      amount = 10
    })
    BioInd.modified_msg("ingredients", recipe)

    recipe.localised_name = {
      "recipe-name.bi-pellet-coke",
      {"item-name.solid-carbon"},
    }
    BioInd.modified_msg("localization", recipe)
  end
end


------------------------------------------------------------------------------------
--                           Update icons of Wood bricks                          --
------------------------------------------------------------------------------------
-- Angel's Bio Processing ("angelsbioprocessing")
--~ item = items["wood-bricks"]
item = items[BI.default_items.wood_bricks.name]
if mods["angelsbioprocessing"] and item then
  --~ BioInd.BI_change_icon(recipes["bi-wood-fuel-brick"],
  BioInd.BI_change_icon(recipes[BI.default_recipes.wood_fuel_brick.name],
                        "__angelsbioprocessing__/graphics/icons/wood-bricks.png", 32)

  BioInd.BI_change_icon(item,
                        "__angelsbioprocessing__/graphics/icons/wood-bricks.png", 32)
end

------------------------------------------------------------------------------------
--                   Add fertilizer recipe with Sodium hydroxide                  --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
item = items["solid-sodium-hydroxide"]
if item then

  -- Make sure the recipe exists
  --~ if not recipes[BI.additional_recipes.fertilizer.name] then
    --~ recipe = BioInd.create_stuff(BI.additional_recipes.fertilizer)[1]
  --~ end
  --~ recipe = recipes[BI.additional_recipes.fertilizer.name] or
            --~ BioInd.create_stuff(BI.additional_recipes.fertilizer)[1]
  recipe = recipes[BI.additional_recipes.mod_compatibility.fertilizer_2.name]

  -- Change ingredients
  if not BI_Functions.lib.recipe_has_ingredient(recipe, "sodium-hydroxide") then
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "solid-sodium-hydroxide",
      amount = 10
    })
    BioInd.modified_msg("ingredient \"solid-sodium-hydroxide\"", recipe, "Added")
  end
  thxbob.lib.recipe.replace_ingredient(recipe.name, "nitrogen", "gas-nitrogen")
  BioInd.modified_msg("ingredient \"nitrogen\"", recipe, "Replaced")

  -- Change localization
  recipe.localised_name = {
    --~ "recipe-name.bi-fertilizer-2",
    "recipe-name.bi-fertilizer",
    {"item-name.solid-sodium-hydroxide"},
  }
  --~ recipe.localised_description = {
    --~ "recipe-description.bi-fertilizer-2",
    --~ {"item-name.solid-sodium-hydroxide"},
  --~ }
  --~ recipe.localised_description = {"recipe-description.bi-fertilizer-1"}
  BioInd.modified_msg("localization", recipe)

  -- Change icons
  BioInd.BI_change_icon(recipe, ICONPATH .. "fertilizer_solid_sodium_hydroxide.png")
  BioInd.modified_msg("icon", recipe)

  -- Add unlock
  recipe.BI_add_to_tech = {"bi-tech-fertilizer"}
  BioInd.modified_msg("unlock", recipe, "Added")
end


------------------------------------------------------------------------------------
--        Replace Liquid air + Nitrogen with Angel's ingredients in recipes       --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if fluids["gas-nitrogen"] then
  for r, rec in pairs({
    BI.default_recipes.fertilizer_1,
    BI.additional_recipes.mod_compatibility.fertilizer_2
  }) do
    --~ recipe = recipes["bi-fertilizer-" .. i]
    recipe = recipes[rec.name]
    if recipe then
      thxbob.lib.recipe.replace_ingredient(recipe.name, "nitrogen", "gas-nitrogen")
      BioInd.modified_msg("ingredients", recipe)
    end
  end
end

if fluids["gas-compressed-air"] then
  for i = 2, 3 do
    --~ recipe = recipes["bi-biomass-" .. i]
    recipe = recipes[BI.additional_recipes.BI_Bio_Fuel["bio_mass_" .. i].name]
    if recipe then
      thxbob.lib.recipe.replace_ingredient(recipe.name, "liquid-air", "gas-compressed-air")
      BioInd.modified_msg("ingredients", recipe)
    end
  end
end


------------------------------------------------------------------------------------
--       Replace icons for biomass-conversion-2 and bi_basic_gas_processing       --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if mods["angelspetrochem"] and BI.Settings.BI_Bio_Fuel then
  -- Biomass conversion
  --~ recipe = recipes["bi-biomass-conversion-2"]
  recipe = recipes[BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_petroleum.name]
  if recipe then
    -- Change icon
    BioInd.BI_change_icon(recipe, ICONPATH .. "bio_conversion_2_angels.png")

    -- Change localization
    --~ recipe.localised_name = {"recipe-name." .. recipe.name .. "-methane"}
    --~ recipe.localised_description = {
      --~ "recipe-description." .. recipe.name .. "-methane",
      --~ {"fluid-name.bi-biomass"},
      --~ {"fluid-name.gas-methane"},
    --~ }
    recipe.localised_name = {
      "recipe-name.bi-biomass-conversion",
      {"fluid-name.bi-biomass"},
      2,
      {"fluid-name.gas-methane"},
    }
    recipe.localised_description = {
      "recipe-description.bi-biomass-conversion-petroleum",
      {"fluid-name.bi-biomass"},
      {"fluid-name.gas-methane"},
    }
    BioInd.modified_msg("localization", recipe)
  end


  -- Basic gas processing
  --~ recipe = recipes["bi-basic-gas-processing"]
  recipe = recipes[BI.additional_recipes.BI_Bio_Fuel.basic_gas_processing.name]
  if recipe then
    BioInd.BI_change_icon(recipe, ICONPATH .. "bi_basic_gas_processing_angels.png")
  end
end


------------------------------------------------------------------------------------
--        Replace Water with Sulfuric waste water in "biomass conversion-1"       --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-yellow-waste"] and BI.Settings.BI_Bio_Fuel then
  -- Replace water with water-yellow-waste in Algae Biomass conversion 1
  --~ recipe = recipes["bi-biomass-conversion-1"]
  recipe = recipes[BI.additional_recipes.BI_Bio_Fuel.bio_mass_conversion_crude_oil.name]
  if recipe then
    -- Change results
    thxbob.lib.recipe.remove_result(recipe.name, "water")
    thxbob.lib.recipe.add_result(recipe.name, {
      type = "fluid",
      name = "water-yellow-waste",
      amount = 40
    })
    BioInd.modified_msg("results", recipe)

    --~ -- Change recipe localizations
    --~ recipe.localised_description = {
      --~ "recipe-description.bi-biomass-conversion",
      --~ {"fluid-name.bi-biomass"},
      --~ 1,
      --~ {"fluid-name.crude-oil"},
      --~ --~-- {"fluid-name.water-yellow-waste"},
    --~ }
    --~ BioInd.modified_msg("localization", recipe)
  end
end



------------------------------------------------------------------------------------
--                          Replace Angels Charcoal Icon                          --
------------------------------------------------------------------------------------
-- Angel's Bio Processing ("angelsbioprocessing")
if mods["angelsbioprocessing"] and BI.Settings.BI_Coal_Processing then
  recipe = recipes[BI.additional_recipes.BI_Coal_Processing.charcoal_1.name]
  if recipe then
    -- Change icon
    BioInd.BI_change_icon(recipe, ICONPATH .. "charcoal_pellets.png")

    -- Change category
    recipe.category = "biofarm-mod-smelting"
    BioInd.modified_msg("category", recipe)
  end

  item = items[BI.additional_items.BI_Coal_Processing.wood_charcoal.name]
  if item then
    -- Change icon
    BioInd.BI_change_icon(item, ICONPATH .. "charcoal_pellets.png")

    -- Change fuel emission multiplier
    item.fuel_emissions_multiplier = 1.05
    BioInd.modified_msg("fuel_emissions_multiplier", item)
  end
end

------------------------------------------------------------------------------------
--                        Replace Angel's Pellet coke icon                        --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if mods["angelspetrochem"] and BI.Settings.BI_Coal_Processing then

  item = items[BI.additional_items.BI_Coal_Processing.pellet_coke.name]
  if item then
    -- Change icon
    BioInd.BI_change_icon(item, "__angelspetrochem__/graphics/icons/pellet-coke.png", 32)

    -- Change speed boosts
    item.fuel_acceleration_multiplier = 1.1
    BioInd.modified_msg("fuel_acceleration_multiplier", item)

    item.fuel_top_speed_multiplier = 1.2
    BioInd.modified_msg("fuel_top_speed_multiplier", item)

    --~ recipe = recipes["pellet-coke"]
    recipe = recipes[BI.additional_recipes.BI_Coal_Processing.pellet_coke.name]
    if recipe then
      -- Change category
      recipe.category = "biofarm-mod-smelting"
      BioInd.modified_msg("category", recipe)

      -- Change unlock
      thxbob.lib.tech.remove_recipe_unlock("angels-coal-processing-2", recipe.name)
      thxbob.lib.tech.add_recipe_unlock("angels-coal-cracking", recipe.name)
      BioInd.modified_msg("unlock", recipe)
    end
  end
end


------------------------------------------------------------------------------------
--                Change prerequisites of our Fertilizer technology               --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")

-- I can't find this setting in any of Angel's or Bob's mods. Also, "angels-fluid-
-- barreling" is only referenced in the locale file, but nowhere else. Let's remove
-- this for now!
--~ if BioInd.get_startup_setting("angels-use-angels-barreling") then
  --~ data.raw.technology["bi-tech-fertilizer"].prerequisites = {
    --~ "bi-tech-bio-farming",
    --~ -- AND (
    --~ "water-treatment", -- sulfur
    --~ -- OR
    --~ "angels-fluid-barreling", -- barreling (needed 'water-treatment' as prerequisites)
    --~ -- )
  --~ }
--~ end

-- We do this now for all recipes in prototypes/default/final-fixes/ash.lua
--~ ------------------------------------------------------------------------------------
--~ --              Replace bi-ash with generic ash in slag-slurry recipe             --
--~ ------------------------------------------------------------------------------------
--~ -- Angel's Refining ("angelsrefining")
--~ if items["ash"] then
  --~ recipe = recipes[BI.additional_recipes.mod_compatibility.slag_slurry.name]
  --~ if recipe then
    --~ thxbob.lib.recipe.replace_ingredient(recipe.name, "bi-ash", "ash")
    --~ BioInd.modified_msg("ingredients", recipe)
  --~ end
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
