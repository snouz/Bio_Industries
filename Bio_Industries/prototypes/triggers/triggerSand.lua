------------------------------------------------------------------------------------
--                        Trigger: Create recipe "bi-sand"?                       --
--                          (BI.Triggers.BI_Trigger_Sand)                         --
------------------------------------------------------------------------------------
-- Mods: "aai-industry", "angelssmelting", "BioTech", "Krastorio2", "pycoalprocessing"
-- Setting: BI.Settings.BI_Stone_Crushing
local trigger = "BI_Trigger_Sand"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe
local item, recipe


------------------------------------------------------------------------------------
--                       If sand exists, create our recipe!                       --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.additional_recipes[trigger])


------------------------------------------------------------------------------------
--                 Adjust our recipe, depending on the active mods                --
------------------------------------------------------------------------------------

-- Make sure our sand recipe exists

recipe = recipes[BI.additional_recipes.BI_Trigger_Sand.sand.name] or
          BioInd.create_stuff(BI.additional_recipes.BI_Trigger_Sand.sand.sand)[1]

if recipe then
  -- Angel's Smelting ("angelssmelting")
  -- (Let's do that first. We will overwrite it if "AAI Industry" is active!)
  item = "solid-sand"
  if items[item] then

    -- Adjust result
    recipe.result = item
    recipe.result_count = 5
    BioInd.modified_msg("result", recipe)

    -- Adjust localization
    recipe.localised_name = {"recipe-name.bi-sand", {"item-name.solid-sand"}}
    BioInd.modified_msg("localization", recipe)
  end

  item = "biotech-sand"
  if items[item] then
    recipe.result = item
    recipe.result_count = 5
    BioInd.modified_msg("result", recipe)

    -- Adjust localization
    recipe.localised_name = {"recipe-name.bi-sand", {"item-name.biotech-sand"}}
    BioInd.modified_msg("localization", recipe)
  end

  item = "sand"
  if items[item] then
    -- Adjust icon
    recipe.icons = {it1 = "sand", it2 = "crushed-stone", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}
    recipe.BI_add_icon = true

    -- Adjust result
    recipe.result = "sand"
    recipe.result_count = 5
    BioInd.modified_msg("result", recipe)

    -- Adjust localization
    recipe.localised_name = {"recipe-name.bi-sand", {"item-name.sand"}}
    BioInd.modified_msg("localization", recipe)
  end

end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
