------------------------------------------------------------------------------------
--                                   Bob's mods                                   --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "bobpower",
  "bobelectronics",
  "bobplates",
  "bobrevamp",
  "bobgreenhouse",
}) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Icons we use per default in BI
local ICONPATH = BioInd.iconpath
-- Custom icons for compatibility with Bob's/Angel's mods
local BOBICONPATH = BioInd.iconpath .. "mod_bobangels/"

local icon_map

local recipe, item, tech

local items = data.raw.item
local recipes = data.raw.recipe
local techs = data.raw.technology

------------------------------------------------------------------------------------
-- DO WE STILL WANT TO DO THIS, OR DO WE KEEP OUR TECHS?
------------------------------------------------------------------------------------
--~ --- Adds Solar Farm, Solar Plant, Musk Floor, Bio Accumulator and Substation to Tech tree
--~ if BI.Settings.BI_Power_Production then
  --~ if data.raw.technology["bob-solar-energy-2"] then
    --~ thxbob.lib.tech.add_recipe_unlock("bob-electric-energy-accumulators-3", "bi-bio-accumulator")
    --~ thxbob.lib.tech.add_recipe_unlock("electric-energy-distribution-2", "bi-huge-substation")
    --~ thxbob.lib.tech.add_recipe_unlock("bob-solar-energy-2", "bi-bio-solar-farm")
    --~ -- thxbob.lib.tech.add_recipe_unlock("bob-solar-energy-2", "bi-solar-boiler-hidden-panel")
    --~ -- thxbob.lib.tech.add_recipe_unlock("bob-solar-energy-2", "bi-solar-boiler-hidden-panel")
    --~ thxbob.lib.tech.add_recipe_unlock("bob-solar-energy-2", "bi-solar-boiler")
  --~ -- else
    --~ -- thxbob.lib.tech.add_recipe_unlock("electric-energy-accumulators", "bi-bio-accumulator")
    --~ -- thxbob.lib.tech.add_recipe_unlock("electric-energy-distribution-2", "bi-huge-substation")
    --~ -- thxbob.lib.tech.add_recipe_unlock("solar-energy", "bi-bio-solar-farm")
    --~ -- thxbob.lib.tech.add_recipe_unlock("solar-energy", "bi-solar-boiler-hidden-panel")
    --~ -- thxbob.lib.tech.add_recipe_unlock("solar-energy", "bi-solar-boiler")
  --~ end

  --~ if data.raw.technology["bob-solar-energy-3"] then
    --~ thxbob.lib.tech.add_recipe_unlock("bob-solar-energy-3", "bi-solar-mat")
  --~ -- else
    --~ -- thxbob.lib.tech.add_recipe_unlock("solar-energy", "bi-solar-mat")
  --~ end
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
--                               Huge Electric Pole                               --
------------------------------------------------------------------------------------
-- Bob's Electronics mod ("bobelectronics")
item = "tinned-copper-cable"
if items[item] and BI.additional_entities.BI_Wood_Products then
  --~ recipe = recipes["bi-wooden-pole-huge"]
  recipe = recipes[BI.additional_entities.BI_Wood_Products.huge_pole.name]
  if recipe then
    -- Change ingredients
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "wood")
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "tinned-copper-cable",
      --~ amount = 15}
    --~ )
    thxbob.lib.recipe.replace_ingredient(recipe, "wood", {
      type = "item",
      name = item,
      amount = 15
    })
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                                   Solar Farm                                   --
------------------------------------------------------------------------------------
-- Bob's Power mod ("bobpower")
item = "solar-panel-large"
if items[item] and BI.additional_recipes.BI_Power_Production then
  --~ recipe = recipes["bi-bio-solar-farm"]
  recipe =  recipes[BI.additional_recipes.BI_Power_Production.solar_farm.name]
  if recipe then
    -- Change ingredients
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "solar-panel")
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "solar-panel-large",
      --~ amount = 30}
    --~ )
    thxbob.lib.recipe.replace_ingredient(recipe, "solar-panel", {
      type = "item",
      name = item,
      amount = 30}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end

------------------------------------------------------------------------------------
--                                Huge Sub Station                                --
------------------------------------------------------------------------------------
-- Bob's Power mod ("bobpower")
item = "substation-3"
if items[item] and BI.additional_recipes.BI_Power_Production then
  --~ recipe = recipes["bi-huge-substation"]
  recipe = recipes[BI.additional_recipes.BI_Power_Production.huge_substation.name]
  if recipe then
    -- Change ingredients
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "substation")
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "substation-3",
      --~ amount = 6}
    --~ )
    thxbob.lib.recipe.replace_ingredient(recipe, "substation", {
      type = "item",
      name = item,
      amount = 6}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                                Huge Accumulator                                --
------------------------------------------------------------------------------------
-- Bob's Power mod ("bobpower")
--~ item =
if items["large-accumulator-2"] and BI.additional_recipes.BI_Power_Production then
  recipe = recipes[BI.additional_recipes.BI_Power_Production.huge_accumulator.name]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, "accumulator")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "large-accumulator",
      amount = 30}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end

-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
item = "aluminium-plate"
if items[item] and BI.additional_recipes.BI_Power_Production then
  recipe = recipes[BI.additional_recipes.BI_Power_Production.huge_accumulator.name]
  if recipe then
    -- Change ingredients
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "copper-cable")
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "aluminium-plate",
      --~ amount = 50
    --~ })
    thxbob.lib.recipe.replace_ingredient(recipe, "copper-cable", {
      type = "item",
      name = item,
      amount = 50
    })
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                          Adjust recipe for Musk floor                          --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
item = "aluminium-plate"
if items[item] and BI.additional_recipes.BI_Power_Production then
  --~ recipe = recipes["bi-solar-mat"]
  recipe = recipes[BI.additional_recipes.BI_Power_Production.solar_mat.name]
  if recipe then
    -- Change ingredients
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "steel-plate")
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "aluminium-plate",
      --~ amount = 1}
    --~ )
    thxbob.lib.recipe.replace_ingredient(recipe, "steel-plate", {
      type = "item",
      name = item,
      amount = 1}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end

-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
item = "silicon-wafer"
if items[item] and BI.additional_recipes.BI_Power_Production then
  --~ recipe = recipes["bi-solar-mat"]
  recipe = recipes[BI.additional_recipes.BI_Power_Production.solar_mat.name]
  if recipe then
    -- Change ingredients
    --~ thxbob.lib.recipe.remove_ingredient(recipe.name, "copper-cable")
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "silicon-wafer",
      --~ amount = 4}
    --~ )
    thxbob.lib.recipe.replace_ingredient(recipe, "copper-cable", {
      type = "item",
      name = item,
      amount = 4}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                             Pellet coke from Carbon                            --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
item = "carbon"
if items[item] and BI.Settings["BI_Coal_Processing"] then

  -- Change recipe icons
  icon_map = {
    [BI.additional_recipes.BI_Coal_Processing.coke_coal.name]           = "pellet_coke_1",
    [BI.additional_recipes.BI_Coal_Processing.pellet_coke.name]         = "pellet_coke_c",
    [BI.additional_recipes.mod_compatibility.pellet_coke_2.name]        = "pellet_coke_b",
  }
  for r_name, r_data in ipairs(icon_map) do
    recipe = recipes[r_name] or BioInd.create_stuff(r_name)[1]
    BioInd.BI_change_icon(recipes[r_name], BOBICONPATH .. icon_map[r_data] .. ".png")
  end

  -- Add ingredient to "bi-pellet-coke-2"
  recipe = recipes[BI.additional_recipes.mod_compatibility.pellet_coke_2.name]
  if recipe then
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = item,
      amount = 10
    })
    BioInd.modified_msg("ingredients", recipe)

    -- Change localization of "bi-pellet-coke-2"
    recipe.localised_name = {
      "recipe-name.bi-pellet-coke",
      {"item-name.carbon"},
    }
    BioInd.modified_msg("localization", recipe)
  end
end


------------------------------------------------------------------------------------
--                   Add fertilizer recipe with Sodium hydroxide                  --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
item = "sodium-hydroxide"
if items[item] then

  recipe = recipes[BI.additional_recipes.mod_compatibility.fertilizer_2.name]

  -- Add item to ingredients unless it's already used!
  if recipe then
    --~ thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      --~ type = "item",
      --~ name = "sodium-hydroxide",
      --~ amount = 10
    --~ })
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = item,
      amount = 10
    })
    BioInd.modified_msg("ingredients", recipe)
    -- Add unlock
    --~ recipe.BI_add_to_tech = {"bi-tech-fertilizer"}
    recipe.BI_add_to_tech = {BI.default_techs.fertilizer.name}
    BioInd.modified_msg("unlock", recipe)
  end
end


------------------------------------------------------------------------------------
--                Replace copper cable with glass in Biofarm recipe               --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
item = "glass"
if items[item] then
  --~ recipe = recipes["bi-bio-farm"]
  recipe = recipes[BI.default_recipes.bio_farm.name]
  if recipe then
    -- Change ingredients
    --~ thxbob.lib.recipe.replace_ingredient(recipe.name, "copper-cable", "glass")
    thxbob.lib.recipe.replace_ingredient(recipe.name, "copper-cable", item)
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                Move unlock of solid-fuel recipe to another tech                --
------------------------------------------------------------------------------------
-- Bob's Revamp mod ("bobrevamp")

-- This tech depends on settings, so it may not exist!
tech = "solid-fuel"
if techs[tech] and BI.additional_recipes.BI_Coal_Processing then
  --~ recipe = recipes["bi-solid-fuel"]
  recipe = recipes[BI.additional_recipes.BI_Coal_Processing.solid_fuel.name]
  if recipe then
    --~ thxbob.lib.tech.remove_recipe_unlock("bi-tech-coal-processing-2", recipe.name)
    --~ thxbob.lib.tech.add_recipe_unlock("solid-fuel", recipe.name)
    thxbob.lib.tech.remove_recipe_unlock(
      BI.additional_techs.BI_Coal_Processing.coal_processing_2.name, recipe.name)
    thxbob.lib.tech.add_recipe_unlock(tech, recipe.name)
    BioInd.modified_msg("unlock", recipe)
  end
end


------------------------------------------------------------------------------------
--                        Support for Bob's Greenhouse mod                        --
------------------------------------------------------------------------------------
-- Bob's Greenhouse mod ("bobgreenhouse")
if items["bob-greenhouse"] then
  item = items["seedling"]
  if item then
    -- Change icon
    BioInd.BI_change_icon(item, ICONPATH .. "seedling.png")

    -- Change place result
    item.place_result = "seedling"
    BioInd.modified_msg("place_result", item)
  end

  item = items["fertilizer"]
  if item then
    -- Change icon
    BioInd.BI_change_icon(item, ICONPATH .. "fertilizer.png")

    -- Moved to data-final-fixes!
    --~ item.place_as_tile = {
      --~ result = BioInd.AB_tiles() and "vegetation-green-grass-3" or "grass-3",
      --~ condition_size = 1,
      --~ condition = { "water-tile" }
    --~ }
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
