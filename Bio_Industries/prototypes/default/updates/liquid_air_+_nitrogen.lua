BioInd.entered_file()

BI.additional_fluids = BI.additional_fluids or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local fluids = data.raw.fluid
local techs = data.raw.technology
local recipes = data.raw.recipe
local f_liquid_air = BI.additional_fluids.liquid_air
local f_nitrogen = BI.additional_fluids.nitrogen
local recipe, substitutes, subst_liquid_air, subst_nitrogen, check


------------------------------------------------------------------------------------
--                                   Liquid air                                   --
------------------------------------------------------------------------------------
--~ fluid = BI.additional_fluids.liquid_air
recipe = BI.additional_recipes.liquid_air

-- Liquid air already exists!
if fluids[f_liquid_air.name] then
  BioInd.writeDebug("%s already exists!", {f_liquid_air.name})

-- Create fluid and recipes?
else

  -- Do we really need liquid air? We could use other fluids as substitute!
  substitutes = {
    -- Angel's Petrochemical Processing ("angelspetrochem")
    "gas-compressed-air",
    -- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
    "bob-liquid-air",
  }

  -- Check all substitutes in our list
  for s, s_name in ipairs(substitutes) do
BioInd.show("Checking for liquid-air substitute", s_name)
    -- Substitute exists!
    if fluids[s_name] then
BioInd.writeDebug("%s exists!", {s_name})
      --~ -- Use the substitute instead of liquid air in recipes
      --~ for r, recipe in ipairs({"bi-biomass-2", "bi-biomass-3"}) do
        --~ thxbob.lib.recipe.replace_ingredient(recipe, fluid.name, s_name)
        --~ BioInd.modified_msg("ingredients", recipes[recipe])
      --~ end
      --~ check = true
      subst_liquid_air = s_name
      break
    end
  end

  -- No substitute found!
  --~ if not check then
  if not subst_liquid_air then
    -- Create liquid air
    --~ BioInd.create_stuff(fluid)
    BioInd.create_stuff(f_liquid_air)

    -- Create recipe
    BioInd.create_stuff(recipe)
  end
end


------------------------------------------------------------------------------------
--                                    Nitrogen                                    --
------------------------------------------------------------------------------------
-- We only need nitrogen if no other mod provides it.
--~ fluid = BI.additional_fluids.nitrogen
recipe = BI.additional_recipes.nitrogen

--~ -- Nitrogen exists
--~ if fluids[fluid.name] then
  --~ BioInd.writeDebug("%s already exists!", {fluid.name})

--~ -- Create fluid and recipes?
--~ else
  --~ BioInd.writeDebug("Check if we need to create nitrogen fluid and recipe!")
  --~ -- Do we really need nitrogen? We could use other fluids as substitute!
  --~ local substitutes = {
    --~ -- Angel's Petrochemical Processing ("angelspetrochem")
    --~ "gas-nitrogen",
    --~ "gas-oxygen",
    --~ "oxygen",
  --~ }
  --~ local success

  --~ -- Check all substitutes in our list
  --~ for s, s_name in ipairs(substitutes) do
--~ BioInd.show("Checking for nitrogen substitute", s_name)
    --~ -- Substitute exists!
    --~ if fluids[s_name] then
--~ BioInd.writeDebug("%s exists!", {s_name})
      --~ success = true
      --~ substitute = s_name
      --~ break
    --~ end
  --~ end

  --~ -- No substitute found!
  --~ if not success then
    --~ -- Create nitrogen
    --~ BioInd.create_stuff(fluid)

    --~ -- Create recipe
    --~ BioInd.create_stuff(recipe)
  --~ end
--~ end

-- Create fluid?
if not fluids[f_nitrogen.name] then
  BioInd.writeDebug("Check if we need to create nitrogen fluid and recipe!")
  -- Do we really need nitrogen? We could use other fluids as substitute!
  local substitutes = {
    -- Angel's Petrochemical Processing ("angelspetrochem")
    "gas-nitrogen",
    "gas-oxygen",
    "oxygen",
  }

  -- Check all substitutes in our list
  for s, s_name in ipairs(substitutes) do
BioInd.show("Checking for nitrogen substitute", s_name)
    -- Substitute exists!
    if fluids[s_name] then
BioInd.writeDebug("%s exists!", {s_name})
      --~ success = true
      subst_nitrogen = s_name
      break
    end
  end

  -- No substitute found -- create fluid and recipe!
  if not subst_nitrogen then
    -- Create nitrogen
    BioInd.create_stuff(f_nitrogen)

    -- Create recipe
    BioInd.create_stuff(recipe)
  end
end

local BI_recipes = {}
for r, recipe in pairs(BI.default_recipes) do
  BI_recipes[r] = recipe
end

for l, list in pairs(BI.additional_recipes) do
  -- Default
  if list.type == "recipe" then
    BI_recipes[l] = list
  -- Mod compatibility/Settings
  else
    for r, recipe in pairs(list) do
      BI_recipes[r] = recipe
    end
  end
end

--~ local function replace_in_BI_rec(old, new)
  --~ for r, recipe in pairs(BI.default_recipes) do
    --~ if recipes[recipe.name] then
      --~ thxbob.lib.recipe.replace_ingredient(recipe, old, new)
    --~ end
  --~ end
  --~ for r, recipe in pairs(BI.additional_recipes) do
    --~ if recipes[recipe.name] then
      --~ thxbob.lib.recipe.replace_ingredient(recipe, old, new)
    --~ end
  --~ end
--~ end

------------------------------------------------------------------------------------
-- Check if we need to replace the original fluids with substitutes
for r, recipe in pairs(BI_recipes) do
  -- Only if the recipe has been created!
  if recipes[recipe.name] then
    -- Substitute nitrogen?
    if subst_nitrogen then
      thxbob.lib.recipe.replace_ingredient(recipe, f_nitrogen.name, subst_nitrogen)
      BioInd.modified_msg("ingredient", recipe)
    end
    -- Substitute liquid air?
    if subst_liquid_air then
      thxbob.lib.recipe.replace_ingredient(recipe, f_liquid_air.name, subst_liquid_air)
      BioInd.modified_msg("ingredient", recipe)
    end
  end
end

--~ ------------------------------------------------------------------------------------
--~ -- If we substitute liquid air, we must also replace it in the nitrogen recipe!
--~ if substitute then
  --~ thxbob.lib.recipe.replace_ingredient(recipe.name, fluid.name, substitute)
  --~ BioInd.modified_msg("ingredient", recipe)
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
