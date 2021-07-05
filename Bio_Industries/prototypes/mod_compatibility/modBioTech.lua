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
  if not data.raw.recipe[BI.additional_recipes.mod_compatibility.sand.name] then
    --~ data:extend({BI.additional_recipes.sand})
    --~ BioInd.created_msg(BI.additional_recipes.sand)
    BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sand)
  end
  recipe = data.raw.recipe[BI.additional_recipes.mod_compatibility.sand.name]

  -- Adjust result
  recipe.result = "biotech-sand"
  BioInd.modified_msg("result", recipe)

end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
