if not data.raw.item["alien-artifact"] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
--         If the Alien Artifact is in the game, use it for some recipes!         --
------------------------------------------------------------------------------------
-- Alternative recipe for advanced fertilizer
BioInd.create_stuff(BI.additional_recipes.adv_fertilizer_2)



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
