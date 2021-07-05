------------------------------------------------------------------------------------
--                              5Dim's mod - New Core                             --
------------------------------------------------------------------------------------
local mod_name = "5dim_core"
if not BI.check_mods(mod_name) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


local BioInd = require('common')('Bio_Industries')

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                            Change stack size of wood                           --
------------------------------------------------------------------------------------
if BioInd.get_startup_setting("5d-change-stack") then
  local item = data.raw.item["wood"]
  if item then
    item.stack_size = math.max(210, item.stack_size)
    --~ BioInd.writeDebug("Set stacksize of item %s to %s", {item.name, item.stack_size})
    BioInd.modified_msg("stacksize", item)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
