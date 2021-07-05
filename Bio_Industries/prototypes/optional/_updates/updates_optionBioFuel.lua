------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Fuel"
--~ -- We only want to do this when the setting is not active!
--~ if BI.Settings[setting] then
  --~ BioInd.nothing_to_do("*")
  --~ return
--~ else
  BioInd.entered_file()
--~ end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local techs = data.raw.technology
local items = data.raw.item

local item, recipe, tech

------------------------------------------------------------------------------------
--          Create recipe for Basic gas processing if resin is available          --
------------------------------------------------------------------------------------
--~ if BI.Settings[setting] then
--~ BioInd.writeDebug("Check if we must create Basic gas processing recipe")
  --~ local name = BI.additional_techs.BI_Rubber.resin_extraction.name
  --~ BioInd.writeDebug("Needed tech %s exists: %s", {name, techs[name] and true or false})

  --~ tech = techs[BI.additional_techs.BI_Rubber.resin_extraction.name]
  --~ BioInd.show("tech", tech)
  --~ if tech then
    --~ BioInd.create_stuff(BI.additional_recipes.BI_Bio_Fuel.basic_gas_processing)
  --~ end
--~ end
if BI.Settings[setting] then
BioInd.writeDebug("Check if we must create Basic gas processing recipe")
  -- Resin will be created if our "Resin extraction" tech exists.
  if techs[BI.additional_techs.BI_Rubber.resin_extraction.name] or
  -- It may also have been created by another mod.
      items[BI.additional_items.BI_Rubber.resin.name] then

    BioInd.create_stuff(BI.additional_recipes.BI_Bio_Fuel.basic_gas_processing)
  else
    BioInd.nothing_to_do("")
  end
end


------------------------------------------------------------------------------------
--               Use more fertilizer in advanced fertilizer recipes               --
------------------------------------------------------------------------------------
if not BI.Settings[setting] then
  -- Common fertilizer
  --~ recipe = recipes["bi-adv-fertilizer-1"]
  recipe = recipes[BI.additional_recipes.adv_fertilizer_1.name]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "fertilizer")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "fertilizer",
      amount = 50
    })
    BioInd.modified_msg("ingredients", recipe)
  end

  -- Advanced fertilizer
  --~ recipe = recipes["bi-adv-fertilizer-2"]
  recipe = recipes[BI.default_recipes.adv_fertilizer_2.name]
  if recipe then
    thxbob.lib.recipe.remove_ingredient(recipe.name, "fertilizer")
    thxbob.lib.recipe.add_new_ingredient(recipe.name, {
      type = "item",
      name = "fertilizer",
      amount = 30
    })
    BioInd.modified_msg("ingredients", recipe)
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
