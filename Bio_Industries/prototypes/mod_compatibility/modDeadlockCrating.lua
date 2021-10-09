------------------------------------------------------------------------------------
--                                Deadlock Crating                                --
------------------------------------------------------------------------------------
local mod_name = "DeadlockCrating"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


BioInd.create_stuff(BI.additional_categories.mod_compatibility.crating)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
