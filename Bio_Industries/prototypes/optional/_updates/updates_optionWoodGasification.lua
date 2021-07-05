------------------------------------------------------------------------------------
--                            Enable: Wood gasification                           --
--                       (BI.Settings.BI_Wood_Gasification)                       --
------------------------------------------------------------------------------------
local setting = "BI_Wood_Gasification"
if not BI.Settings[setting] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local recipes = data.raw.recipe
local techs = data.raw.technology
local recipe, tech


------------------------------------------------------------------------------------
--                  Use tar instead of rubber for the rubber mats                 --
------------------------------------------------------------------------------------
--~ recipe = recipes["bi-rubber-mat"]
recipe = recipes[BI.additional_recipes.BI_Rubber.rubber_mat.name]
if recipe then
  thxbob.lib.recipe.replace_ingredient(recipe.name, "resin", "tar")
  BioInd.modified_msg("ingredient \"resin\"", recipe)

  recipe.category = "crafting-with-fluid"
  BioInd.modified_msg("category", recipe)
end


------------------------------------------------------------------------------------
--           Remove "Timber" from prerequisites of "Wood gasification"?           --
------------------------------------------------------------------------------------
-- Technology prerequisite 'bi-tech-timber' on 'bi-tech-wood-gasification' is
-- redundant as 'oil-processing' already contains it in its prerequisite tree.
if techs[BI.additional_techs.BI_Rubber.rubber_production.name] then
  tech = techs[BI.additional_techs.BI_Wood_Gasification.wood_gasification.name]
  thxbob.lib.tech.remove_prerequisite(tech.name, BI.default_techs.timber.name)
  BioInd.modified_msg("prerequisite \"" .. BI.default_techs.timber.name .. "\"", tech, "Removed")
end

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
