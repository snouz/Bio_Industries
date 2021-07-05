------------------------------------------------------------------------------------
--                           Natural Evolution Buildings                          --
------------------------------------------------------------------------------------
local mod_name = "Natural_Evolution_Buildings"
-- Don't duplicate what NE does!
if BI.check_mods(mod_name) or not data.raw.gun["bi-dart-rifle"] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath
local tech, recipe
local techs = data.raw.technology
local recipes = data.raw.recipe
local ammos = data.raw.ammo

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                         Hide the recipe for the pistol                         --
------------------------------------------------------------------------------------
recipe = recipes["pistol"]
if recipe then
  recipe.enabled = false
  BioInd.modified_msg("enabled", recipe)

  recipe.hidden = true
  BioInd.modified_msg("hidden", recipe)

  recipe.hide_from_player_crafting = true
  BioInd.modified_msg("hide_from_player_crafting", recipe)
end


------------------------------------------------------------------------------------
--                     Lock bullets behind "military" research                    --
------------------------------------------------------------------------------------
recipe = recipes["firearm-magazine"]
if recipe then
  recipe.enabled = false
  BioInd.modified_msg("enabled", recipe)

  thxbob.lib.tech.add_recipe_unlock("military", recipe.name)
  BioInd.modified_msg("unlock", recipe, "Added")
end



------------------------------------------------------------------------------------
--                          Give fuel value to dart rifle!                        --
-- We want to make the dart rifle the default starting weapon that replaces the   --
-- pistol. The main grudge with the pistol is that it can't be re-used, and they  --
-- tend to accumulate because you always get another one on respawning. We avoid  --
-- that by allowing to burn excess dart rifles.                                   --
------------------------------------------------------------------------------------
local wood = data.raw.item.wood
local gun = data.raw.gun["bi-dart-rifle"]
recipe = recipes["bi-dart-rifle"]

-- We already know the gun exists, otherwise we wouldn't be here!
if wood and recipe then
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
    BioInd.modified_msg("fuel_value", gun)

    gun.fuel_category = wood.fuel_category
    BioInd.modified_msg("fuel_category", gun)
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
