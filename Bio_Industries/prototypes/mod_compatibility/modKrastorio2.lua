------------------------------------------------------------------------------------
--                                   Krastorio 2                                  --
------------------------------------------------------------------------------------
local mod_name = "Krastorio2"
if not BioInd.check_mods(mod_name) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end

local ICONPATH = BioInd.iconpath .. "mod_krastorio/"
local recipe

local recipes = data.raw.recipe

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--             Add recipe for sand from crushed stone if there is sand            --
------------------------------------------------------------------------------------
if BI.Settings.BI_Stone_Crushing and data.raw.item["sand"] then

  BioInd.writeDebug("Generating recipe for sand from crushed stone!")

  -- Make sure our sand recipe exists
  recipe = recipes[BI.additional_recipes.mod_compatibility.sand] or
            BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sand)[1]

  if recipe then
    -- Adjust icon
    BioInd.BI_change_icon(recipe, ICONPATH .. "sand-Krastorio.png")

    -- Adjust result
    recipe.result = "sand"
    recipe.result_count = 5
    BioInd.modified_msg("result", recipe)

    -- Adjust localization
    recipe.localised_name = {"recipe-name.bi-sand", {"item-name.sand"}}
    BioInd.modified_msg("localization", recipe)
  end
end


-- Removed this! We just disable the setting if Krastorio is active!
--~ ------------------------------------------------------------------------------------
--~ -- Our alternative recipe for Production science packs will break the balance if  --
--~ -- Krastorio is active, so we remove it again!                                    --
--~ ------------------------------------------------------------------------------------
--~ recipe = recipes[BI.additional_recipes.BI_Game_Tweaks_Production_Science.production_science_pack]

--~ if recipe then
  --~ recipe = nil
  --~ BioInd.writeDebug("Removed %s \"%s\"!", {recipe.type, recipe.name})
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
