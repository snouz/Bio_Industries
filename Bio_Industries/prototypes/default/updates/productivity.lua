BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe


------------------------------------------------------------------------------------
--                        Enable "Productivity" in recipes                        --
------------------------------------------------------------------------------------
for recipe, r in pairs(recipes) do
  for p, pattern in ipairs({
    "bi%-acid",
    "bi%-basic%-gas%-processing",
    "bi%-battery",
    "bi%-biomass%-%d",
    "bi%-biomass%-conversion%-%d",
    "bi%-cellulose%-%d",
    "bi%-crushed%-stone%-%d",
    "bi%-liquid%-air",
    "bi%-logs%-%d",
    "bi%-nitrogen",
    "bi%-plastic%-%d",
    "bi%-press%-wood",
    "bi%-production%-science%-pack",
    "bi%-resin%-pulp",
    "bi%-resin%-wood",
    "bi%-seed%-%d",
    "bi%-seedling%-%d",
    "bi%-stone%-brick",
    "bi%-sulfur",
    "bi%-sulfur%-angels",
    "bi%-wood%-from%-pulp",
    "bi%-woodpulp",
  }) do

    if recipe:match(pattern) then
      BI_Functions.lib.allow_productivity(recipe)
      break
    end
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
