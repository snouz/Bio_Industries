------------------------------------------------------------------------------------
--                           Enable: Prototype Artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
-- Don't duplicate what NE does!
if (not BI.Settings[setting]) or mods["Natural_Evolution_Buildings"] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local default_target_masks = data.raw["utility-constants"].default.default_trigger_target_mask_by_type
local worms = data.raw.turret

------------------------------------------------------------------------------------
--                       Add trigger_target_mask to spawners                      --
------------------------------------------------------------------------------------
-- Everything should have "common", unless there is specific reason not to
default_target_masks["unit-spawner"] = default_target_masks["unit-spawner"] or { "common" }
table.insert(default_target_masks["unit-spawner"], "Bio_Cannon_Ammo")


------------------------------------------------------------------------------------
--                        Add trigger_target_mask to worms                        --
------------------------------------------------------------------------------------
for w, worm in pairs(worms) do
  worm.trigger_target_mask = worm.trigger_target_mask or default_target_masks["turret"] or { "common" }
  table.insert(worm.trigger_target_mask, "Bio_Cannon_Ammo")
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
