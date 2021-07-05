------------------------------------------------------------------------------------
--                                   Bob's mods                                   --
------------------------------------------------------------------------------------
if not BI.check_mods({
  "bobpower",
  "bobelectronics",
  "bobplates",
  "bobrevamp",
  "bobgreenhouse",
}) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end
    recipe.icon = ICONPATH .. "mod_bobangels/pellet_coke_b.png"

local BioInd = require('common')('Bio_Industries')
require('prototypes.mod_compatibility.additional_recipes')

local ICONPATH = BioInd.iconpath .. "mod_bobangels/"
local icon_map

local recipe, item

local items = data.raw.item
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


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
  recipe = "bi-wooden-pole-huge"
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "wood")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "tinned-copper-cable",
      amount = 15}
    )
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
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
    thxbob.lib.recipe.remove_ingredient(recipe.name, "solar-panel")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "solar-panel-large",
      amount = 30}
    )
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
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
    thxbob.lib.recipe.remove_ingredient(recipe.name, "substation")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "substation-3",
      amount = 6}
    )
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
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
    thxbob.lib.recipe.remove_ingredient(recipe.name, "accumulator")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "large-accumulator",
      amount = 30}
    )
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end
end

-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["aluminium-plate"] then
  recipe = recipes["bi-bio-accumulator"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "copper-cable")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "aluminium-plate",
      amount = 50
    })
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
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
    thxbob.lib.recipe.remove_ingredient(recipe.name, "steel-plate")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "aluminium-plate",
      amount = 1}
    )
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end
end

-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["silicon-wafer"] then
  recipe = recipes["bi-solar-mat"]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "copper-cable")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "silicon-wafer",
      amount = 4}
    )
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                             Pellet coke from Carbon                            --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["carbon"] then

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
    --~ recipe.icon = ICONPATH .. "mod_bobangels/pellet_coke_b.png"
    --~ recipe.icon_size = 64
    --~ recipe.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of recipe \"%s\"", {recipe.name})
  --~ end
  icon_map = {
    ["bi-coke-coal"]            = "pellet_coke_1",
    ["bi-pellet-coke"]          = "pellet_coke_c",
    ["bi-pellet-coke-2"]        = "pellet_coke_b",
  }
  for recipe, icon in pairs(icon_map) do
    BioInd.BI_change_icon(recipes[recipe], ICONPATH .. icon .. ".png")
  end

  -- Add ingredient to "bi-pellet-coke-2"
  recipe = recipes["bi-pellet-coke-2"]
  if recipe then
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "carbon",
      amount = 10
    })
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end

  --~ -- Add recipe unlock for "bi-pellet-coke-2"
  --~ recipe.BI_add_to_tech = {"bi-tech-coal-processing-2"}
  --thxbob.lib.tech.add_recipe_unlock("bi-tech-coal-processing-2", "bi-pellet-coke-2")
end


------------------------------------------------------------------------------------
--                   Add fertilizer recipe with Sodium hydroxide                  --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items["sodium-hydroxide"] then

  --~ recipe = data.raw.recipe["bi-fertilizer-2"]
  -- Make sure the recipe exists
  if not recipes[BI.additional_recipes.fertilizer.name] then
    data:extend({BI.additional_recipes.fertilizer})
    --~ BioInd.writeDebug("Created recipe \"%s\"!", {recipe.name})
    BioInd.created_msg(BI.additional_recipes.fertilizer)
  end
  recipe = recipes[BI.additional_recipes.fertilizer.name]

  -- Change ingredients
  --~ thxbob.lib.recipe.add_new_ingredient("bi-fertilizer-2", {
  thxbob.lib.recipe.add_new_ingredient(recipe.name, {
    type = "item",
    name = "sodium-hydroxide",
    amount = 10
  })
  --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
  BioInd.modified_msg("ingredients", recipe)

  -- Add unlock
  recipe.BI_add_to_tech = {"bi-tech-fertilizer"}
  --~ thxbob.lib.tech.add_recipe_unlock("bi-tech-fertilizer", "bi-fertilizer-2")
  --~ BioInd.writeDebug("Changed unlock of recipe \"%s\"", {recipe.name})
  BioInd.modified_msg("unlock", recipe)
end


------------------------------------------------------------------------------------
--                Replace copper cable with glass in Biofarm recipe               --
------------------------------------------------------------------------------------
-- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
if items.glass  then
  recipe = recipes["bi-bio-farm"]
  if recipe then
    thxbob.lib.recipe.replace_ingredient(recipe.name, "copper-cable", "glass")
    --~ BioInd.writeDebug("Changed ingredients of recipe \"%s\"", {recipe.name})
    BioInd.modified_msg("ingredients", recipe)
  end
end


------------------------------------------------------------------------------------
--                Replace copper cable with glass in Biofarm recipe               --
------------------------------------------------------------------------------------
-- Bob's Revamp mod ("bobrevamp")

-- This tech depends on settings, so it may not exist!
if data.raw.technology["solid-fuel"] then
  recipe = recipes["bi-solid-fuel"]
  if recipe then
    --~ thxbob.lib.tech.remove_recipe_unlock ("bi-tech-coal-processing-1", "bi-solid-fuel")
    thxbob.lib.tech.remove_recipe_unlock ("bi-tech-coal-processing-2", recipe.name)
    thxbob.lib.tech.add_recipe_unlock("solid-fuel", recipe.name)
    --~ BioInd.writeDebug("Changed unlock of recipe \"%s\"", {recipe.name})
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
    --~ item.icon = ICONPATH .. "seedling.png"
    --~ item.icon_size = 64
    --~ item.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of item \"%s\"", {item.name})
    BioInd.BI_change_icon(item, ICONPATH .. "seedling.png")

    item.place_result = "seedling"
    --~ BioInd.writeDebug("Changed place result of item \"%s\"", {item.name})
    BioInd.modified_msg("place_result", item)
  end

  item = items["fertilizer"]
  if item then
    --~ item.icon = ICONPATH .. "fertilizer.png"
    --~ item.icon_size = 64
    --~ item.BI_add_icon = true
    --~ BioInd.writeDebug("Changed icon of item \"%s\"", {item.name})
    BioInd.BI_change_icon(item, ICONPATH .. "fertilizer.png")

    -- Moved to data-final-fixes!
    --~ item.place_as_tile = {
      --~ result = BioInd.AB_tiles() and "vegetation-green-grass-3" or "grass-3",
      --~ condition_size = 1,
      --~ condition = { "water-tile" }
    --~ }
    --~ BioInd.writeDebug("Adjusted Seedling and Fertilizer items (Bob's Greenhouse mod).")
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
