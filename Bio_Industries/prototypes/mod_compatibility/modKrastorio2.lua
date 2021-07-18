--~ ------------------------------------------------------------------------------------
--~ --                                   Krastorio 2                                  --
--~ ------------------------------------------------------------------------------------
--~ local mod_name = "Krastorio2"
--~ if not BioInd.check_mods(mod_name) then
  --~ BioInd.nothing_to_do("*")
  --~ return
--~ else
  --~ BioInd.entered_file()
--~ end

--~ local ICONPATH = BioInd.iconpath .. "mod_krastorio/"
--~ local recipe

--~ local recipes = data.raw.recipe

--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------

--~ ------------------------------------------------------------------------------------
--~ --             Add recipe for sand from crushed stone if there is sand            --
--~ ------------------------------------------------------------------------------------
--~ if BI.Settings.BI_Stone_Crushing and data.raw.item["sand"] then

  --~ BioInd.writeDebug("Generating recipe for sand from crushed stone!")

  --~ -- Make sure our sand recipe exists
  --~ recipe = recipes[BI.additional_recipes.mod_compatibility.sand] or
            --~ BioInd.create_stuff(BI.additional_recipes.mod_compatibility.sand)[1]

  --~ if recipe then
    --~ -- Adjust icon
    --~ --BioInd.BI_change_icon(recipe, ICONPATH .. "sand-Krastorio.png")
    --~ --recipe.icons = BioInd.make_icons("sand", "crushed-stone", 0, 0)
    --~ recipe.icons = {it1 = "sand", it2 = "crushed-stone", shift1_1 = 0 , shift1_2 = 0, shift2_1 = 0, shift2_2 = 0}
    --~ recipe.BI_add_icon = true

    --~ -- Adjust result
    --~ recipe.result = "sand"
    --~ recipe.result_count = 5
    --~ BioInd.modified_msg("result", recipe)

    --~ -- Adjust localization
    --~ recipe.localised_name = {"recipe-name.bi-sand", {"item-name.sand"}}
    --~ BioInd.modified_msg("localization", recipe)
  --~ end
--~ end


--~ ------------------------------------------------------------------------------------
--~ --                                    END OF FILE                                 --
--~ ------------------------------------------------------------------------------------
--~ BioInd.entered_file("leave")
