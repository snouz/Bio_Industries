------------------------------------------------------------------------------------
--                           Enable: Prototype Artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
-- Don't duplicate what NE does!
if (not BI.Settings[setting]) or mods["Natural_Evolution_Buildings"] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local default_target_masks = data.raw["utility-constants"].default.default_trigger_target_mask_by_type
local spawners = data.raw["unit-spawner"]
local worms = data.raw.turret
local added
local trigger = "Bio_Cannon_Ammo"

local function add_to_table(tab, add_this)
  local addit = true
  for k, v in pairs(tab) do
    if v == add_this then
      addit = false
      break
    end
  end
  if addit then
    table.insert(tab, add_this)
  end

  return addit
end

------------------------------------------------------------------------------------
--                       Add trigger_target_mask to spawners                      --
------------------------------------------------------------------------------------
-- Everything should have "common", unless there is specific reason not to
default_target_masks["unit-spawner"] = default_target_masks["unit-spawner"] or { "common" }
--~ table.insert(default_target_masks["unit-spawner"], "Bio_Cannon_Ammo")
--~ add_to_table(default_target_masks["unit-spawner"], "Bio_Cannon_Ammo")
add_to_table(default_target_masks["unit-spawner"], trigger)

for s, spawner in pairs(spawners) do
  spawner.trigger_target_mask = spawner.trigger_target_mask or default_target_masks["unit-spawner"]
  --~ table.insert(worm.trigger_target_mask, "Bio_Cannon_Ammo")
  --~ added = add_to_table(spawner.trigger_target_mask, "Bio_Cannon_Ammo")
  added = add_to_table(spawner.trigger_target_mask, trigger)
  BioInd.debugging.writeDebug("%s \"%s\" to trigger_target_mask of spawner \"%s\": %s",
                              {added and "Added" or "Didn't add", trigger, spawner.name, spawner.trigger_target_mask}, "line")

end


------------------------------------------------------------------------------------
--                        Add trigger_target_mask to worms                        --
------------------------------------------------------------------------------------
default_target_masks["turret"] = default_target_masks["turret"] or { "common" }
add_to_table(default_target_masks["unit-spawner"], "Bio_Cannon_Ammo")
for w, worm in pairs(worms) do
  worm.trigger_target_mask = worm.trigger_target_mask or default_target_masks["turret"]
  --~ table.insert(worm.trigger_target_mask, "Bio_Cannon_Ammo")
  --~ add_to_table(worm.trigger_target_mask, "Bio_Cannon_Ammo")
  added = add_to_table(worm.trigger_target_mask, trigger)
  BioInd.debugging.writeDebug("%s \"%s\" to trigger_target_mask of turret \"%s\": %s",
                              {added and "Added" or "Didn't add", trigger, worm.name, worm.trigger_target_mask}, "line")
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
