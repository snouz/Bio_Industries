--~ if not (data.raw.recipe[BI.additional_recipes.mod_compatibility.sand.name] and
          --~ BI.additional_entities.BI_Stone_Crushing) then
if not BI.Triggers.BI_Trigger_Sand then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local prototype, name


------------------------------------------------------------------------------------
--    Use alternative descriptions for stone crusher if our sand recipe exists!   --
------------------------------------------------------------------------------------
name = BI.additional_entities.BI_Stone_Crushing.stone_crusher.name

for _, t in ipairs({"furnace", "item", "recipe"}) do
  prototype = data.raw[t] and data.raw[t][name]
  if prototype then
    prototype.localised_description = {
      "entity-description." .. prototype.name .. "-sand"
    }
    BioInd.modified_msg("localization", prototype)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
