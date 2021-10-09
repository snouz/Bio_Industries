------------------------------------------------------------------------------------
--                                   5Dim's mods                                  --
--  (The core mod is required by all others, so we just need to check for that!)  --
------------------------------------------------------------------------------------
local mod_name = "5dim_core"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe
local item, recipe, group, subgroup, check
local opt_item, opt_recipe, opt_groups, opt_group


------------------------------------------------------------------------------------
--                            Change stack size of wood                           --
------------------------------------------------------------------------------------
if BioInd.get_startup_setting("5d-change-stack") then
  item = items["wood"]
  if item then
    item.stack_size = math.max(200, item.stack_size)
    BioInd.debugging.modified_msg("stacksize", item)
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
