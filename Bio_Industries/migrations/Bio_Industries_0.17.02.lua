BioInd.debugging.entered_file()


for index, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  if game.technology_prototypes["steel-processing"] and
    technologies["steel-processing"].researched and
    recipes["bi-stone-crusher"] then

      recipes["bi-stone-crusher"].enabled = true
      recipes["bi-stone-crusher"].reload()
  end

  force.reset_recipes()
  force.reset_technologies()
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
