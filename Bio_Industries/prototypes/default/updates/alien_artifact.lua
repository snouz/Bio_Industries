if not data.raw.item["alien-artifact"] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item


------------------------------------------------------------------------------------
--         If the Alien Artifact is in the game, use it for some recipes!         --
------------------------------------------------------------------------------------
--~ if items["alien-artifact"] then
  --- Alternative recipe for advanced fertilizer
  BioInd.create_stuff(BI.additional_recipes.adv_fertilizer_1)
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
