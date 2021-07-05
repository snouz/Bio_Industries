------------------------------------------------------------------------------------
--                                     BioTech                                    --
------------------------------------------------------------------------------------
local mod_name = "BioTech"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipe

------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
if BI.Settings.BI_Stone_Crushing and data.raw.item["biotech-sand"] then

  -- Make sure our sand recipe exists
  recipe = data.raw.recipe[BI.additional_recipes.mod_compatibility.sand.name] or
            BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sand)[1]

  if recipe then
    -- Adjust result
    recipe.result = "biotech-sand"
    recipe.result_count = 5
    BioInd.modified_msg("result", recipe)

    -- Adjust localization
    recipe.localised_name = {"recipe-name.bi-sand", {"item-name.biotech-sand"}}
    BioInd.modified_msg("localization", recipe)
  end

end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
