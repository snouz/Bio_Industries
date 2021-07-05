------------------------------------------------------------------------------------
--                             Industrial Revolution 2                            --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
-- We only want to create crushed stone if IR2 is NOT active!
if BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local refinery, addit

------------------------------------------------------------------------------------
--               If the stone crusher exists, create crushed stone!               --
------------------------------------------------------------------------------------
if items[BI.additional_items.BI_Stone_Crushing.stone_crusher.name] then
  BioInd.create_stuff(BI.additional_items.BI_Stone_Crushing.crushed_stone)
else
  BioInd.writeDebug("Did not create %s because %s does not exist.", {
    BI.additional_items.BI_Stone_Crushing.crushed_stone.name,
    BI.additional_items.BI_Stone_Crushing.stone_crusher.name
  })
end


------------------------------------------------------------------------------------
--  Allow recipes made in the bioreactor to also be crafted in the oil refinery!  --
------------------------------------------------------------------------------------
-- IR2 sets a fixed recipe to the oil-refinery, so we only need to do this if the
-- mod is not active!
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
