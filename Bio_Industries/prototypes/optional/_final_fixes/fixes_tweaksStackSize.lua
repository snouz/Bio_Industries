------------------------------------------------------------------------------------
--                             Game tweaks: Stack size                            --
--                     (BI.Settings.BI_Game_Tweaks_Stack_Size)                    --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Stack_Size"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Changed for 0.18.34/1.1.4
local tweaks = {
  ["wood"]            = 400,
  ["stone"]           = 400,
  ["stone-crushed"]   = 800,
  ["concrete"]        = 400,
  ["slag"]            = 800,
}
local item

for tweak_name, tweak in pairs(tweaks) do
  item = data.raw.item[tweak_name]
  if item and item.stack_size < tweak then
    item.stack_size = 800
    --~ BioInd.debugging.writeDebug("Changing stacksize of %s from %s to %s", {item.name, item.stack_size, tweak})
    BioInd.debugging.modified_msg("stack_size", item)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
