------------------------------------------------------------------------------------
--           Trigger: Crafting of bioreactor recipes in the oil refinery          --
--                       (BI.Triggers.BI_Trigger_BiRefinery)                      --
------------------------------------------------------------------------------------
-- IR2 sets a fixed recipe to the oil-refinery, so we are polite and don't do this
-- if the mod is active!
--
-- Mods: "Industrial Revolution 2"
-- Entity: "oil-refinery"
local trigger = "BI_Trigger_BiRefinery"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local refinery, addit


------------------------------------------------------------------------------------
--  Allow recipes made in the bioreactor to also be crafted in the oil refinery!  --
------------------------------------------------------------------------------------
refinery = data.raw["assembling-machine"]["oil-refinery"]
if refinery then
  addit = true
  for c, category in ipairs(refinery.crafting_categories) do
    if category == "biofarm-mod-bioreactor" then
      addit = false
      break
    end
  end
  if addit then
    table.insert(refinery.crafting_categories, "biofarm-mod-bioreactor")
    BioInd.modified_msg("crafting_categories", refinery)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
