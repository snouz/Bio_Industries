------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  --~ "pycoalprocessing",
  "pyrawores",
  "pyindustry",

}) then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe
local item
local walls = data.raw.wall
local fence_bi, fence_py, factor, ingredients, recipe
local py_name = "wood-fence"


------------------------------------------------------------------------------------
--    Our wooden fence has more health, so it should require more ingredients!    --
------------------------------------------------------------------------------------
fence_bi = BI.additional_entities.BI_Darts and walls[BI.additional_entities.BI_Darts.wooden_fence.name]
fence_py = walls[py_name]

if fence_bi and fence_py and recipes[py_name] then
--~ log(string.format("fence_bi: %s\tfence_py: %s", serpent.block(fence_bi), serpent.block(fence_py)))
  factor = fence_bi.max_health / (fence_py.max_health or 1)
--~ log(string.format("factor: %s", factor))
--~ log("Wooden fence: " .. serpent.block(recipes[BI.additional_recipes.BI_Darts.wooden_fence.name]))
  recipe = recipes[BI.additional_recipes.BI_Darts.wooden_fence.name]

  for d, diff in ipairs({"", "normal", "expensive"}) do
    ingredients = BI_Functions.lib.get_difficulty_recipe_ingredients(py_name, diff)
    item = ingredients["wood"] or ingredients["treated-wood"]

    if item then
      item = thxbob.lib.item.item(item)
      item.name = "wood"
      item.amount = item.amount and item.amount * factor
      item.amount_min = item.amount_min and item.amount_min * factor
      item.amount_max = item.amount_max and item.amount_max * factor

      thxbob.lib.recipe.set_difficulty_ingredient(recipe, diff, item)
      BioInd.modified_msg("ingredients", recipe)
    end
  end
end



------------------------------------------------------------------------------------
--     If there are wooden rails, replace wood with concrete in normal rails!     --
------------------------------------------------------------------------------------
recipe = recipes["rail-2"]
if recipe and recipes[BI.additional_recipes.BI_Rails.rail_wood.name] then
  thxbob.lib.recipe.replace_ingredient(recipe, "wood", "concrete")
  thxbob.lib.recipe.replace_ingredient(recipe, "treated-wood", "concrete")
  BioInd.modified_msg("ingredients", recipe)
end



------------------------------------------------------------------------------------
--                         Replace our ash with Pyanodon's                        --
------------------------------------------------------------------------------------
-- Moved to prototypes/default/final-fixes.lua because other mods use "ash" as well!

--~ old = items["bi-ash"]
--~ new = items["ash"]
--~ recipe = recipes[BI.additional_recipes.BI_Bio_Fuel.basic_gas_processing.name]

--~ if recipe and old and new then
    --~ thxbob.lib.recipe.remove_result(recipe, old)
    --~ thxbob.lib.recipe.add_result(recipe, {
      --~ type = "item",
      --~ name = "ash",
      --~ amount = 15
    --~ })
--~ end




------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                           Moved the rest to updates!                           --
------------------------------------------------------------------------------------




--~ local ICONPATH = BioInd.iconpath .. "mod_py/"

--~ local recipe, item, tech, check, tech_level

--~ local recipes = data.raw.recipe
--~ local BI_recipes = BI.additional_recipes.BI_Coal_Processing

--~ local items = data.raw.item

--~ local techs = data.raw.technology
--~ local src_tech = "bi-tech-coal-processing-"
--~ local mod_techs = {
  --~ ["pyrawores"] = "coal-mk0",
  --~ ["pycoalprocessing"] = "coal-processing-"
--~ }

--~ local mod_order = {"pyrawores", "pycoalprocessing"}


--~ local max_level = 3


--~ ------------------------------------------------------------------------------------
--~ --                            Make sure all techs exist!                          --
--~ ------------------------------------------------------------------------------------
--~ BioInd.show("mod_techs", mod_techs)

--~ for mod_name, tech in pairs(mod_techs) do
--~ BioInd.writeDebug("Checking tech %s for mod %s", {tech, mod_name})
  --~ check = true
  --~ for i = 1, max_level do
    --~ -- Missing techs, remove mod from list!
--~ BioInd.show(tech .. i, tostring(techs[tech .. i]))
    --~ if not techs[tech .. i] then
      --~ mod_techs[mod_name] = nil
--~ BioInd.writeDebug("Removed %s from list!", {mod_name})
      --~ break
    --~ end
  --~ end
--~ BioInd.show("mod_techs", mod_techs)
--~ end


--~ ------------------------------------------------------------------------------------
--~ --                   Move our unlocks to techs from other mods!                   --
--~ ------------------------------------------------------------------------------------
--~ for m, mod_name in pairs(mod_order) do
--~ BioInd.writeDebug("Priority: %s\tMod: %s", {m, mod_name})
  --~ -- All techs from that mod exist
  --~ if mod_techs[mod_name] then
--~ BioInd.writeDebug("mod_techs[%s]: %s", {mod_name, mod_techs[mod_name]})
    --~ -- Check recipes
    --~ for r, recipe in pairs(BI_recipes) do
--~ BioInd.show("Checking recipe", recipe.name)
      --~ if recipes[recipe.name] then
--~ BioInd.writeDebug("Recipe exists!")
        --~ -- Find the unlock tech
        --~ for u, unlock in pairs(recipes[recipe.name].BI_add_to_tech or {}) do
          --~ tech_level = unlock:match("^" .. src_tech .. "(%d+)$")
--~ BioInd.show("tech_level", tech_level)
          --~ -- Found original tech
          --~ if tech_level then
--~ BioInd.show("Changing unlock to", mod_techs[mod_name] .. tech_level)
            --~ unlock = mod_techs[mod_name] .. tech_level
          --~ end
        --~ end
      --~ end
    --~ end
--~ BioInd.writeDebug("Techs from mod with highest priority (%s) are used now. Breaking out of the loop!", {mod_name} )
    --~ -- We've used the techs from the mod with the highest priority. Skip the rest!
    --~ break
  --~ else
--~ BioInd.writeDebug("Target techs don't exist, trying next mod!")
  --~ end
--~ end


--~ ------------------------------------------------------------------------------------
--~ --                                    END OF FILE                                 --
--~ ------------------------------------------------------------------------------------
--~ BioInd.entered_file("leave")
