------------------------------------------------------------------------------------
--                                  Angel's mods                                  --
------------------------------------------------------------------------------------
--~ BI.writeDebug(BI.entered_msg, {debug.getinfo(1).source})

if not BI.check_mods({
  "angelspetrochem",
  --~ "angelsbioprocessing",
  "angelsrefining"
}) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')
require('prototypes.mod_compatibility.additional_recipes')

local recipe
local items = data.raw.item
local fluids = data.raw.fluid
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--                       Sink for Charcoal and Crushed stone                      --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-purified"] and
    fluids["water-yellow-waste"] and
    fluids["water-mineralized"] then

  data:extend({BI.additional_recipes.sulfuric_waste})
  --~ BioInd.writeDebug("Created recipe %s.", {BI.additional_recipes.sulfuric_waste.name})
  BioInd.created_msg(BI.additional_recipes.sulfuric_waste)
end

  --~ data:extend({
    --~ -- Sink for Charcoal and Crushed stone
    --~ {
      --~ type = "recipe",
      --~ name = "bi-mineralized-sulfuric-waste",
      --~ icon = ICONPATH .. "mod_bobangels/bi_mineralized_sulfuric.png",
      --~ icon_size = 64,
      --~ BI_add_icon = true,
      --~ BI_add_to_tech = {"water-treatment"},
      --~ category = "liquifying",
      --~ subgroup = "water-treatment",
      --~ energy_required = 2,
      --~ ingredients = {
        --~ {type = "fluid", name = "water-purified", amount = 100},
        --~ {type = "item", name = "stone-crushed", amount = 90},
        --~ {type = "item", name = "wood-charcoal", amount = 30},
      --~ },
      --~ results= {
        --~ {type = "fluid", name = "water-yellow-waste", amount = 40},
         --~ {type = "fluid", name = "water-mineralized", amount = 60},
      --~ },
      --~ enabled = false,
      --~ allow_as_intermediate = false,
      --~ always_show_made_in = true,
      --~ allow_decomposition = false,
      --~ order = "a[water-water-mineralized]-2",
    --~ },

------------------------------------------------------------------------------------
--                         Sink for Ash and Crushed stone                         --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if fluids["water-saline"] and fluids["slag-slurry"] then
  data:extend({BI.additional_recipes.slag_slurry})
  --~ BioInd.writeDebug("Created recipe %s.", {BI.additional_recipes.slag_slurry.name})
  BioInd.created_msg(BI.additional_recipes.slag_slurry)
end
--~ -- Sink for Ash and Crushed stone
--~ {
  --~ type = "recipe",
  --~ name = "bi-slag-slurry",
  --~ icon = ICONPATH .. "mod_bobangels/bi_slurry.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ BI_add_to_tech = {"slag-processing-1"},
  --~ category = "liquifying",
  --~ subgroup = "liquifying",
  --~ energy_required = 4,
  --~ ingredients = {
    --~ {type = "fluid", name = "water-saline", amount = 50},
    --~ {type = "item", name = "stone-crushed", amount = 90},
    --~ {type = "item", name = "bi-ash", amount = 40},
  --~ },
  --~ results = {
    --~ {type = "fluid", name = "slag-slurry", amount = 100},
  --~ },
  --~ enabled = false,
  --~ allow_as_intermediate = false,
  --~ always_show_made_in = true,
  --~ allow_decomposition = false,
  --~ order = "i [slag-processing-dissolution]-2",
--~ },
--~ })
--~ -- thxbob.lib.tech.add_recipe_unlock("water-treatment", "bi-mineralized-sulfuric-waste")
--~ -- thxbob.lib.tech.add_recipe_unlock("slag-processing-1", "bi-slag-slurry")


------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
-- Angel's Refining ("angelsrefining")
if items["solid-sand"] then
  -- Make sure our sand recipe exists
  if not data.raw.recipe[BI.additional_recipes.sand.name] then
    data:extend({BI.additional_recipes.sand})
    --~ BioInd.writeDebug("Created recipe %s.", {BI.additional_recipes.sand.name})
    BioInd.created_msg(BI.additional_recipes.sand)
  end
  recipe = data.raw.recipe[BI.additional_recipes.sand.name]

  -- Adjust result
  recipe.result = "solid-sand"
  --~ BioInd.writeDebug("Changed result of recipe \"%s\".", {recipe.name})
  BioInd.modified_msg("result", BI.additional_recipes.sand)

  --~ -- Add recipe to technology
  --~ recipe.BI_add_to_tech = {"bi-tech-stone-crushing-1"}
  --~ BioInd.writeDebug("Added unlock for recipe %s.", {recipe.name})
  --~ thxbob.lib.tech.add_recipe_unlock("bi-tech-stone-crushing-1", "bi-sand")


  -- MOVED TO DATA-UPDATES.LUA!
  --~ -- Use alternative descriptions for stone crusher!
  --~ BioInd.writeDebug("Using alternative descriptions for \"bi-stone-crusher\"!")
  --~ for _, t in ipairs({"furnace", "item", "recipe"}) do
    --~ data.raw[t]["bi-stone-crusher"].localised_description =
      --~ {"entity-description.bi-stone-crusher-sand"}
  --~ end
end


------------------------------------------------------------------------------------
--                 Create fertilizer recipe with Sodium hydroxide                 --
------------------------------------------------------------------------------------
-- Angel's Petrochemical Processing ("angelspetrochem")
if items["solid-sodium-hydroxide"] and
    not recipes[BI.additional_recipes.fertilizer.name] then
  data:extend({BI.additional_recipes.fertilizer})
  --~ BioInd.writeDebug("Created recipe %s.", {BI.additional_recipes.fertilizer.name})
  BioInd.created_msg(BI.additional_recipes.fertilizer)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
