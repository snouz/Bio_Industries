------------------------------------------------------------------------------------
--                              5Dim's mod - New Core                             --
------------------------------------------------------------------------------------
local mod_name = "5dim_core"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                            Change stack size of wood                           --
------------------------------------------------------------------------------------
if BioInd.get_startup_setting("5d-change-stack") then
  local item = data.raw.item["wood"]
  if item then
    item.stack_size = math.max(210, item.stack_size)
    BioInd.modified_msg("stacksize", item)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
