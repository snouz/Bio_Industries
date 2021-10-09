------------------------------------------------------------------------------------
--                           Natural Evolution Buildings                          --
------------------------------------------------------------------------------------
local mod_name = "Natural_Evolution_Buildings"
-- Don't duplicate what NE does!
if BioInd.check_mods(mod_name) or not data.raw.gun["bi-dart-rifle"] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local tech, recipe, wood, gun
local techs = data.raw.technology
local recipes = data.raw.recipe
local ammos = data.raw.ammo


------------------------------------------------------------------------------------
--                         Hide the recipe for the pistol                         --
------------------------------------------------------------------------------------
recipe = recipes["pistol"]
BioInd.debugging.show("Pistol", recipe)
if recipe then
  -- The functions set a property for all difficulties!
  --~ recipe.enabled = false
  thxbob.lib.recipe.set_enabled(recipe, false)
  BioInd.debugging.modified_msg("enabled", recipe)

  --~ recipe.hidden = true
  thxbob.lib.recipe.set_hidden(recipe, true)
  BioInd.debugging.modified_msg("hidden", recipe)

  --~ recipe.hide_from_player_crafting = true
  --~ recipe.hide_from_player_crafting = true
  thxbob.lib.recipe.set_hide_from_player_crafting(recipe, true)
  BioInd.debugging.modified_msg("hide_from_player_crafting", recipe)
end


------------------------------------------------------------------------------------
--                     Lock bullets behind "military" research                    --
------------------------------------------------------------------------------------
recipe = recipes["firearm-magazine"]
if recipe then
  --~ recipe.enabled = false
  thxbob.lib.recipe.set_enabled(recipe, false)
  BioInd.debugging.modified_msg("enabled", recipe)

  thxbob.lib.tech.add_recipe_unlock("military", recipe.name)
  BioInd.debugging.modified_msg("unlock", recipe, "Added")
end



------------------------------------------------------------------------------------
--                          Give fuel value to dart rifle!                        --
-- We want to make the dart rifle the default starting weapon that replaces the   --
-- pistol. The main grudge with the pistol is that it can't be re-used, and they  --
-- tend to accumulate because you always get another one on respawning. We avoid  --
-- that by allowing to burn excess dart rifles.                                   --
------------------------------------------------------------------------------------
wood = data.raw.item.wood
gun = data.raw.gun["bi-dart-rifle"]
--~ recipe = recipes["bi-dart-rifle"]
recipe = recipes[BI.additional_recipes.BI_Darts.dart_rifle.name]

if wood and gun and recipe then
  -- Prefer ingredients from normal mode over expensive mode!
  local ingredients = recipe.normal and recipe.normal.ingredients or
                        recipe.ingredients or
                        recipe.expensive and recipe.expensive.ingredients

  local amount
  for i, ingredient in pairs(ingredients or {}) do
    if (ingredient.name == "wood") or (ingredient[1] == "wood") then
      amount = ingredient.amount or ingredient[2]
      break
    end
  end

  if amount then
    local fuel_value, unit = wood.fuel_value:gmatch("(.-)%s*(%a+)")()
    -- You get a free dart rifle on each respawn. We could refund the complete amount
    -- of wood used in the recipe, but in order to prevent abuse, we'll give the dart
    -- rifle just a fraction of the fuel value the raw wood would have.
    local fraction = 1/3

    gun.fuel_value = tostring(fuel_value * amount * fraction) .. unit
    BioInd.debugging.modified_msg("fuel_value", gun)

    gun.fuel_category = wood.fuel_category
    BioInd.debugging.modified_msg("fuel_category", gun)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
