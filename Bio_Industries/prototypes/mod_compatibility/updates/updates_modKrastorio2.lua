------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
local mod_name = "Krastorio2"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe


------------------------------------------------------------------------------------
--       Replace liquid air with oxygen in Algae Biomass conversion 2 and 3       --
------------------------------------------------------------------------------------
if data.raw.fluid["oxygen"] then
  for r, recipe in ipairs({"bi-biomass-2", "bi-biomass-3"}) do
    if recipes[recipe] then
      -- Change ingredients
      thxbob.lib.recipe.replace_ingredient(recipe, "liquid-air", "oxygen")
      BioInd.modified_msg("ingredients", recipe)
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
