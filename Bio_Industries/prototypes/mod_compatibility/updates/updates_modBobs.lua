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

local recipe, item

local items = data.raw.item
local recipes = data.raw.recipe
local techs = data.raw.technology

------------------------------------------------------------------------------------
-- DO WE STILL WANT TO DO THIS, OR DO WE KEEP OUR TECHS?
------------------------------------------------------------------------------------
--~ --- Adds Solar Farm, Solar Plant, Musk Floor, Bio Accumulator and Substation to Tech tree
--~ if BI.Settings.BI_Solar_Additions then
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
if items["tinned-copper-cable"] then
  recipe = recipes["bi-wooden-pole-huge"]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, "wood")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "tinned-copper-cable",
      amount = 15}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                                   Solar Farm                                   --
------------------------------------------------------------------------------------
-- Bob's Power mod ("bobpower")
if items["solar-panel-large"] then
  recipe = recipes["bi-bio-solar-farm"]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, "solar-panel")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "solar-panel-large",
      amount = 30}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end

------------------------------------------------------------------------------------
--                                Huge Sub Station                                --
------------------------------------------------------------------------------------
-- Bob's Power mod ("bobpower")
if items["substation-3"] then
  recipe = recipes["bi-huge-substation"]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, "substation")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "substation-3",
      amount = 6}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end

-- Angel's Smelting ("angelssmelting") -- "electrum-alloy" was removed in 0.4.4!
--~ if items["electrum-alloy"] then
  --~ thxbob.lib.recipe.remove_ingredient("bi-huge-substation", "steel-plate")
  --~ thxbob.lib.recipe.add_new_ingredient("bi-huge-substation", {
    --~ type = "item",
    --~ name = "electrum-alloy",
    --~ amount = 10}
  --~ )
--~ end


------------------------------------------------------------------------------------
--                                Huge Accumulator                                --
------------------------------------------------------------------------------------
-- Bob's Power mod ("bobpower")
if items["large-accumulator-2"] then
  recipe = recipes["bi-bio-accumulator"]
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
if items["aluminium-plate"] then
  recipe = recipes["bi-bio-accumulator"]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, "copper-cable")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "aluminium-plate",
      amount = 50
    })
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                          Adjust recipe for Musk floor                          --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["aluminium-plate"] then
  recipe = recipes["bi-solar-mat"]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, "steel-plate")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "aluminium-plate",
      amount = 1}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end

-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["silicon-wafer"] then
  recipe = recipes["bi-solar-mat"]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.remove_ingredient(recipe.name, "copper-cable")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "silicon-wafer",
      amount = 4}
    )
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                             Pellet coke from Carbon                            --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["carbon"] and BI.Settings["BI_Coal_Processing"] then

  -- Change recipe icons
  icon_map = {
    ["bi-coke-coal"]            = "pellet_coke_1",
    ["bi-pellet-coke"]          = "pellet_coke_c",
    ["bi-pellet-coke-2"]        = "pellet_coke_b",
  }
  for r, r_data in ipairs({
    BI.additional_recipes.BI_Coal_Processing.coke_coal,
    BI.additional_recipes.BI_Coal_Processing.pellet_coke,
    BI.additional_recipes.pellet_coke_2
  }) do
    recipe = recipes[r_data.name] or BioInd.create_stuff(r_data)[1]
    BioInd.BI_change_icon(recipes[recipe.name], BOBICONPATH .. icon_map[recipe.name] .. ".png")
  end

  -- Add ingredient to "bi-pellet-coke-2"
  recipe = recipes["bi-pellet-coke-2"]
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "carbon",
    amount = 10
  })
  BioInd.modified_msg("ingredients", recipe)

end


------------------------------------------------------------------------------------
--                   Add fertilizer recipe with Sodium hydroxide                  --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["sodium-hydroxide"] then

  -- Make sure the recipe exists
  --~ recipe = BI.additional_recipes.fertilizer.name
  --~ if not recipes[recipe.name] then
    --~ data:extend({recipe})
    --~ BioInd.created_msg(recipe)
    --~ BioInd.create_stuff(recipe)
  --~ end
  --~ recipe = recipes[BI.additional_recipes.fertilizer.name]
  recipe = BioInd.create_stuff(BI.additional_recipes.fertilizer)[1]

  -- Change ingredients
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "sodium-hydroxide",
    amount = 10
  })
  BioInd.modified_msg("ingredients", recipe)

  -- Add unlock
  recipe.BI_add_to_tech = {"bi-tech-fertilizer"}
  BioInd.modified_msg("unlock", recipe)
end


------------------------------------------------------------------------------------
--                Replace copper cable with glass in Biofarm recipe               --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items.glass  then
  recipe = recipes["bi-bio-farm"]
  if recipe then
    -- Change ingredients
    thxbob.lib.recipe.replace_ingredient(recipe.name, "copper-cable", "glass")
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                Move unlock of solid-fuel recipe to another tech                --
------------------------------------------------------------------------------------
-- Bob's Revamp mod ("bobrevamp")

-- This tech depends on settings, so it may not exist!
if techs["solid-fuel"] then
  recipe = recipes["bi-solid-fuel"]
  if recipe then
    thxbob.lib.tech.remove_recipe_unlock("bi-tech-coal-processing-2", recipe.name)
    thxbob.lib.tech.add_recipe_unlock("solid-fuel", recipe.name)
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
