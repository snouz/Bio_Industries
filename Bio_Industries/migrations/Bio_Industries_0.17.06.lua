BioInd.entered_file()


for index, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  if game.technology_prototypes["steel-processing"] and
    technologies["steel-processing"].researched and
    recipes["bi-crushed-stone-1"] then

      recipes["bi-crushed-stone-1"].enabled = true
      recipes["bi-crushed-stone-1"].reload()
  end

  force.reset_recipes()
  force.reset_technologies()
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
