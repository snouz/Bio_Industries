------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "pypetroleumhandling",
}) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe


------------------------------------------------------------------------------------
--                     Fix for hotair-molybdenum-plate recipe                     --
------------------------------------------------------------------------------------
-- When hotair-recipes are created, main_product is not copied to the new recipes'
-- difficulties. So far, "hotair-molybdenum-plate" is the only recipe that will
-- cause a crash with BI, but other recipes may be affected as well.
-- Hopefully, this will be taken care of in "pypetroleumhandling" at some point, but
-- until then, we'll fix this from our end.

for r_name, recipe in pairs(recipes) do
  if recipe.main_product and r_name:match("^hotair%-.+$") then
    for d, diff in ipairs({"normal", "expensive"}) do
      if recipe[diff] and not recipe[diff].main_product then
        recipe[diff].main_product = recipe.main_product
        log(string.format("Added main_product \"%s\" to difficulty \"%s\" of recipe \"%s\".",
                            recipe.main_product, diff, r_name))
      end
    end
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
