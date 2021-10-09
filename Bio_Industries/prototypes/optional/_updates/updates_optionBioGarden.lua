------------------------------------------------------------------------------------
--                               Enable: Bio gardens                              --
--                           (BI.Settings.BI_Bio_Garden)                          --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Garden"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local recipes = data.raw.recipe
local items = data.raw.item
local recipe, item, amount

------------------------------------------------------------------------------------
--       Add crushed stone, or gravel, or stone to ingredients of Bio garden      --
------------------------------------------------------------------------------------
recipe = BI.additional_recipes.BI_Bio_Garden.bio_garden and
          recipes[BI.additional_recipes.BI_Bio_Garden.bio_garden.name]

if recipe then
  -- Amount of stones
  amount = 20

  -- Stone crushing is enabled, and IR2 is not active
  if BI.Triggers.BI_Trigger_Crushed_Stone_Create then
    item = items[BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone.name]
    amount = amount * 2
  -- IR2 should provide "gravel"
  elseif BioInd.check_mods("IndustrialRevolution") then
    item = items["gravel"]
    amount = amount * 2
  -- Use plain stone
  else
    item = items["stone"]
  end

  -- Add the item, if it exists
  if item then
    thxbob.lib.recipe.add_new_ingredient(recipe, {item.name, amount})
    BioInd.debugging.modified_msg("ingredient", recipe, "Added")
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
