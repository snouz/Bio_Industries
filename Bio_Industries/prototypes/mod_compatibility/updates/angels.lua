------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
if not BI.check_mods({
  "angelspetrochem",
  "angelsbioprocessing",
  "angelsrefining",
}) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')
require('prototypes.mod_compatibility.additional_recipes')

local ICONPATH = BioInd.iconpath .. "mod_bobangels/"
local icon_map

local recipe, item, entity

local items = data.raw.item
local fluids = data.raw.fluid
local recipes = data.raw.recipe

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--                               Solar boiler/plant                               --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if items["angels-electric-boiler"] then
  recipe = recipes["bi-solar-boiler"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "boiler")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "angels-electric-boiler",
      amount = 1}
    )
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                             Pellet coke from Carbon                            --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if items["solid-carbon"] then
  -- Change recipe icons
  --~ recipe = recipes["bi-coke-coal"]
  --~ if recipe then
    --~ recipe.icon = ICONPATH .. "mod_bobangels/pellet_coke_1.png"
    --~ recipe.icon_size = 64
    --~ recipe.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
  --~ end

  --~ recipe = recipes["bi-pellet-coke"]
  --~ if recipe then
    --~ recipe.icon = ICONPATH .. "mod_bobangels/pellet_coke_c.png"
    --~ recipe.icon_size = 64
    --~ recipe.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
  --~ end

  --~ recipe = recipes["bi-pellet-coke-2"]
  --~ if recipe then
    --~ recipe.icon = ICONPATH .. "mod_bobangels/pellet_coke_a.png"
    --~ recipe.icon_size = 64
    --~ recipe.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
  --~ end

  icon_map = {
    ["bi-coke-coal"]            = "pellet_coke_1",
    ["bi-pellet-coke"]          = "pellet_coke_c",
    ["bi-pellet-coke-2"]        = "pellet_coke_a",
  }
  for recipe, icon in pairs(icon_map) do
    BioInd.BI_change_icon(recipes[recipe], ICONPATH .. icon .. ".png")
  end
  --~ -- Add unlock tech of "bi-pellet-coke-2"
  --thxbob.lib.tech.add_recipe_unlock("bi-tech-coal-processing-2", "bi-pellet-coke-2")
  --~ recipe.BI_add_to_tech = {"bi-tech-coal-processing-2"}

  -- Add ingredient to "bi-pellet-coke-2"
  recipe = recipes["bi-pellet-coke-2"]
  if recipe then
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "solid-carbon",
      amount = 10
    })
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                           Update icons of Wood bricks                          --
------------------------------------------------------------------------------------
-- Angel's Bio Processing ("angelsbioprocessing")
item = items["wood-bricks"]
if item then
  BioInd.BI_change_icon(recipes["bi-wood-fuel-brick"],
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
  --~ local recipe_name = BI.additional_recipes.fertilizer.name

  -- Make sure the recipe exists
  --~ recipe = recipes[recipe_name]
  if not recipes[BI.additional_recipes.fertilizer.name] then
    data:extend({BI.additional_recipes.fertilizer})
    --~ BioInd.writeDebug("Created recipe %s", {BI.additional_recipes.fertilizer.name})
    BioInd.created_msg(BI.additional_recipes.fertilizer)
  end
  recipe = recipes[BI.additional_recipes.fertilizer.name]

  -- Change ingredients
  --~ thxbob.lib.recipe.add_new_ingredient("bi-fertilizer-2", {
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "solid-sodium-hydroxide",
    amount = 10
  })
  --~ thxbob.lib.recipe.replace_ingredient("bi-fertilizer-2", "nitrogen", "gas-nitrogen")
  thxbob.lib.recipe.replace_ingredient(recipe.name, "nitrogen", "gas-nitrogen")
  --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
  BioInd.modified_msg("ingredients", recipe)

  -- Change icons
  --~ recipe = recipes["bi-fertilizer-2"]
  --~ recipe.icon = ICONPATH .. "fertilizer_solid_sodium_hydroxide.png"
  --~ recipe.icon_size = 64
  --~ recipe.BI_add_icon = true
  --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
  BioInd.BI_change_icon(recipe, ICONPATH .. "fertilizer_solid_sodium_hydroxide.png")

  recipe.BI_add_to_tech = {"bi-tech-fertilizer"}
  --~ thxbob.lib.tech.add_recipe_unlock("bi-tech-fertilizer", "bi-fertilizer-2")
  --~ BioInd.writeDebug("Added unlock to recipe \"%s\"", {recipe.name})
  BioInd.modified_msg("unlock", recipe, "Added")
end


------------------------------------------------------------------------------------
--        Replace Liquid air + Nitrogen with Angel's ingredients in recipes       --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if fluids["gas-nitrogen"] then
  --~ recipe = recipes["bi-fertilizer-1"]
  --~ if recipe then
    -- thxbob.lib.recipe.replace_ingredient("bi-fertilizer-1", "nitrogen", "gas-nitrogen")
    --~ thxbob.lib.recipe.replace_ingredient(recipe.name, "nitrogen", "gas-nitrogen")
    -- BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    --~ BioInd.modified_msg("ingredients", recipe)
  --~ end

  --~ recipe = recipes["bi-fertilizer-2"]
  --~ if recipe then
    -- thxbob.lib.recipe.replace_ingredient("bi-fertilizer-2", "nitrogen", "gas-nitrogen")
    --~ thxbob.lib.recipe.replace_ingredient(recipe.name, "nitrogen", "gas-nitrogen")
    -- BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    --~ BioInd.modified_msg("ingredients", recipe)
  --~ end

  for i = 1, 2 do
    recipe = recipes["bi-fertilizer-" .. i]
    if recipe then
      thxbob.lib.recipe.replace_ingredient(recipe.name, "nitrogen", "gas-nitrogen")
      BioInd.modified_msg("ingredients", recipe)
    end
  end
end

if fluids["gas-compressed-air"] then
  --~ recipe = recipes["bi-biomass-2"]
  --~ if recipe then
    -- thxbob.lib.recipe.replace_ingredient("bi-biomass-2", "liquid-air", "gas-compressed-air")
    --~ thxbob.lib.recipe.replace_ingredient(recipe.name, "liquid-air", "gas-compressed-air")
    -- BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    --~ BioInd.modified_msg("ingredients", recipe)

    --~ recipe = recipes["bi-biomass-3"]
    -- thxbob.lib.recipe.replace_ingredient("bi-biomass-3", "liquid-air", "gas-compressed-air")
    --~ thxbob.lib.recipe.replace_ingredient(recipe.name, "liquid-air", "gas-compressed-air")
    -- BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    --~ BioInd.modified_msg("ingredients", recipe)
  --~ end
  for i = 2, 3 do
    recipe = recipes["bi-biomass-" .. i]
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
if mods["angelspetrochem"] then
  -- Biomass conversion
  recipe = recipes["bi-biomass-conversion-2"]
  if recipe then
    --~ recipe.icon = ICONPATH .. "mod_bobangels/bio_conversion_2_angels.png"
    --~ recipe.icon_size = 64
    --~ recipe.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
    BioInd.BI_change_icon(recipe, ICONPATH .. "bio_conversion_2_angels.png")

    recipe.localised_name = {"recipe-name." .. recipe.name .. "-methane"}
    recipe.localised_description = {"recipe-description." .. recipe.name .. "-methane"}
    --~ BioInd.writeDebug("Changed localization of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("localization", recipe)
  end

  -- Basic gas processing
  recipe = recipes["bi-basic-gas-processing"]
  if recipe then
    --~ recipe.icon = ICONPATH .. "mod_bobangels/bi_basic_gas_processing_angels.png"
    --~ recipe.icon_size = 64
    --~ recipe.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
    BioInd.BI_change_icon(recipe, ICONPATH .. "bi_basic_gas_processing_angels.png")
  end
end


------------------------------------------------------------------------------------
--        Replace Water with Sulfuric waste water in "biomass conversion-2"       --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-yellow-waste"] then
  -- Replace water with water-yellow-waste in Algae Biomass conversion 4
  recipe = recipes["bi-biomass-conversion-4"]
  if recipe then
    -- Change results
    --~ thxbob.lib.recipe.remove_result("bi-biomass-conversion-4", "water")
    thxbob.lib.recipe.remove_result(recipe.name, "water")
    --~ thxbob.lib.recipe.add_result("bi-biomass-conversion-4", {
    thxbob.lib.recipe.add_result(recipe.name, {
      type = "fluid",
      name = "water-yellow-waste",
      amount = 40
    })
    --~ BioInd.writeDebug("Changed results of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("results", recipe)

    -- Change recipe localizations
    recipe.localised_name = {"recipe-name.bi-biomass-conversion-4-yellow-waste"}
    recipe.localised_description = {"recipe-description.bi-biomass-conversion-4-yellow-waste"}
    --~ BioInd.writeDebug("Changed localization of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("localization", recipe)
  end
end



------------------------------------------------------------------------------------
--                          Replace Angels Charcoal Icon                          --
------------------------------------------------------------------------------------
-- Angel's Bio Processing ("angelsbioprocessing")
recipe = recipes["wood-charcoal"]
if recipe then
  --~ recipe.icon = ICONPATH .. "mod_bobangels/charcoal_pellets.png"
  --~ recipe.icon_size = 64
  --~ recipe.BI_add_icon = true
  --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
  BioInd.BI_change_icon(recipe, ICONPATH .. "charcoal_pellets.png")

  recipe.category = "biofarm-mod-smelting"
  --~ BioInd.writeDebug("Changed  of recipe \"%s\"", {recipe.name})
  BioInd.modified_msg("category", recipe)
end

item = items["wood-charcoal"]
if item then
  --~ item.icon = ICONPATH .. "charcoal.png"
  --~ item.icon_size = 64
  --~ item.BI_add_icon = true
  --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
  BioInd.BI_change_icon(item, ICONPATH .. "charcoal_pellets.png")

  item.fuel_emissions_multiplier = 1.05
  BioInd.writeDebug("Changed fuel-emissions multiplier of item \"%s\"", {item.name})
  BioInd.modified_msg("fuel_emissions_multiplier", item)
end


------------------------------------------------------------------------------------
--                        Replace Angel's Pellet coke icon                        --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
item = data.raw.item["pellet-coke"]
if item then
  --~ item.icon = "__angelspetrochem__/graphics/icons/pellet-coke.png"
  --~ item.icon_size = 32
  --~ item.BI_add_icon = true
  --~ BioInd.writeDebug("Changed icon of item \"%s\"", {item.name})
  BioInd.BI_change_icon(item, "__angelspetrochem__/graphics/icons/pellet-coke.png", 32)

  item.fuel_acceleration_multiplier = 1.1
  BioInd.modified_msg("fuel_acceleration_multiplier", item)
  item.fuel_top_speed_multiplier = 1.2
  BioInd.modified_msg("fuel_top_speed_multiplier", item)
  --~ BioInd.writeDebug("Changed speed boosts of item \"%s\"", {item.name})

  recipe = recipes["pellet-coke"]
  if recipe then
    recipe.category = "biofarm-mod-smelting"
    --~ BioInd.writeDebug("Changed category of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("category", recipe)

    --~ thxbob.lib.tech.remove_recipe_unlock ("angels-coal-processing-2", "pellet-coke")
    --~ thxbob.lib.tech.add_recipe_unlock("angels-coal-cracking", "pellet-coke")
    thxbob.lib.tech.remove_recipe_unlock ("angels-coal-processing-2", recipe.name)
    thxbob.lib.tech.add_recipe_unlock("angels-coal-cracking", recipe.name)
    --~ BioInd.writeDebug("Changed unlock of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("unlock", recipe)
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


------------------------------------------------------------------------------------
--              Replace bi-ash with generic ash in slag-slurry recipe             --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if items["ash"] then
  recipe = recipes["bi-slag-slurry"]
  thxbob.lib.recipe.replace_ingredient(recipe.name, "bi-ash", "ash")
  --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
  BioInd.modified_msg("ingredients", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
