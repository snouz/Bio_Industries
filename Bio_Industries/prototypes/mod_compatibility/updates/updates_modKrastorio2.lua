------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
local mod_name = "Krastorio2"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local recipe, fluid

------------------------------------------------------------------------------------
--       Replace liquid air with oxygen in Algae Biomass conversion 2 and 3       --
------------------------------------------------------------------------------------
fluid = "oxygen"
if data.raw.fluid[fluid] then
  for r, r_name in ipairs({"bi-biomass-2", "bi-biomass-3"}) do
    recipe = recipes[r_name]
    if recipe then
      -- Change ingredients
      thxbob.lib.recipe.replace_ingredient(recipe.name, "liquid-air", fluid)
      BioInd.modified_msg("ingredients", recipe)
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
