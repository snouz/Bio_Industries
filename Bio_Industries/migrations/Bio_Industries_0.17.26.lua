BioInd.debugging.entered_file()

for index, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  if game.technology_prototypes["bi-tech-coal-processing-3"] and recipes["bi-coke-coal"] then
    recipes["bi-coke-coal"].enabled = true
    recipes["bi-coke-coal"].reload()
  end

  force.reset_recipes()
  force.reset_technologies()
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
