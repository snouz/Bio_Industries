BI.entered_file()

BI.additional_fluids = BI.additional_fluids or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local fluids = data.raw.fluid
local techs = data.raw.technology
local recipes = data.raw.recipe
local fluid, recipe, substitute


--~ ------------------------------------------------------------------------------------
--~ --                                   Liquid air                                   --
--~ ------------------------------------------------------------------------------------
--~ fluid = BI.additional_fluids.liquid_air
--~ recipe = BI.additional_recipes.liquid_air

--~ ------------------------------------------------------------------------------------
--~ -- We only need to create the fluid if no other mod provides it.
--~ if not fluids[fluid.name] then

  --~ -- Do we really need liquid air? We could use other fluids as substitute!
  --~ local substitutes = {
    --~ "oxygen",
    --~ "gas-compressed-air",
  --~ }
  --~ local success

  --~ -- Check all substitutes in our list
  --~ for s, s_name in ipairs(substitutes) do
    --~ -- Substitute exists!
    --~ if fluids[s_name] then
      --~ -- Use the substitute instead of liquid air in recipes
      --~ for r, recipe in ipairs({"bi-biomass-2", "bi-biomass-3"}) do
        --~ thxbob.lib.recipe.replace_ingredient(
          --~ recipe,
          --~ fluid.name,
          --~ s_name
        --~ )
       --~ -- BioInd.writeDebug("Replaced \"liquid-air\" with \"oxygen\" in recipes \"bi-biomass-2\" and \"bi-biomass-3\"")
        --~ BioInd.modified_msg("ingredients", recipes[recipe])
      --~ end
      --~ success = true
      --~ substitute = s_name
      --~ break
    --~ end
  --~ end

  --~ -- No substitute found!
  --~ if not success then
    --~ -- Create liquid air
    --~ data:extend({fluid})
    --~ BioInd.created_msg(fluid)

    --~ -- Create recipe
    --~ data:extend({recipe})
    --~ BioInd.created_msg(recipe)
  --~ end
--~ end


--~ ------------------------------------------------------------------------------------
--~ --                                    Nitrogen                                    --
--~ ------------------------------------------------------------------------------------
--~ fluid = BI.additional_fluids.nitrogen
--~ recipe = BI.additional_recipes.nitrogen

--~ ------------------------------------------------------------------------------------
--~ -- We will always need nitrogen. If no other mod provides it, we create it.
--~ if not fluids[fluid.name] then
  --~ -- Create fluid
  --~ BioInd.create_stuff(fluid)
--~ end

--~ ------------------------------------------------------------------------------------
--~ -- Create recipe
--~ BioInd.create_stuff(recipe)

--~ ------------------------------------------------------------------------------------
--~ -- If we substitute liquid air, we must also replace it in the nitrogen recipe!
--~ if substitute then
  --~ thxbob.lib.recipe.replace_ingredient(recipe.name, fluid.name, substitute)
  --~ BioInd.modified_msg(recipe)
--~ end


--~ ------------------------------------------------------------------------------------
--~ --                                    Nitrogen                                    --
--~ ------------------------------------------------------------------------------------
--~ -- We only need nitrogen if no other mod provides it.
--~ fluid = BI.additional_fluids.nitrogen
--~ recipe = BI.additional_recipes.nitrogen

--~ if not fluids[fluid.name] then
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
    --~ -- Substitute exists!
    --~ if fluids[s_name] then
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


------------------------------------------------------------------------------------
--                                   Liquid air                                   --
------------------------------------------------------------------------------------
fluid = BI.additional_fluids.liquid_air
recipe = BI.additional_recipes.liquid_air
substitute = nil

-- Liquid air already exists!
if fluids[fluid.name] then
  BioInd.writeDebug("%s already exists!", {fluid.name})

-- Create fluid and recipes?
else

  -- Do we really need liquid air? We could use other fluids as substitute!
  local substitutes = {
    -- Angel's Petrochemical Processing ("angelspetrochem")
    "gas-compressed-air",
    -- Bob's Metals, Chemicals and Intermediates mod ("bobplates")
    "bob-liquid-air",
  }
  local success

  -- Check all substitutes in our list
  for s, s_name in ipairs(substitutes) do
BioInd.show("Checking for liquid-air substitute", s_name)
    -- Substitute exists!
    if fluids[s_name] then
BioInd.writeDebug("%s exists!", {s_name})
      -- Use the substitute instead of liquid air in recipes
      for r, recipe in ipairs({"bi-biomass-2", "bi-biomass-3"}) do
        thxbob.lib.recipe.replace_ingredient(
          recipe,
          fluid.name,
          s_name
        )
        --~ BioInd.writeDebug("Replaced \"liquid-air\" with \"oxygen\" in recipes \"bi-biomass-2\" and \"bi-biomass-3\"")
        BioInd.modified_msg("ingredients", recipes[recipe])
      end
      success = true
      substitute = s_name
      break
    end
  end

  -- No substitute found!
  if not success then
    -- Create liquid air
    BioInd.create_stuff(fluid)

    -- Create recipe
    BioInd.create_stuff(recipe)
  end
end


------------------------------------------------------------------------------------
--                                    Nitrogen                                    --
------------------------------------------------------------------------------------
-- We only need nitrogen if no other mod provides it.
fluid = BI.additional_fluids.nitrogen
recipe = BI.additional_recipes.nitrogen

-- Nitrogen exists
if fluids[fluid.name] then
  BioInd.writeDebug("%s already exists!", {fluid.name})

-- Create fluid and recipes?
else
  BioInd.writeDebug("Check if we need to create nitrogen fluid and recipe!")
  -- Do we really need nitrogen? We could use other fluids as substitute!
  local substitutes = {
    -- Angel's Petrochemical Processing ("angelspetrochem")
    "gas-nitrogen",
    "gas-oxygen",
    "oxygen",
  }
  local success

  -- Check all substitutes in our list
  for s, s_name in ipairs(substitutes) do
BioInd.show("Checking for nitrogen substitute", s_name)
    -- Substitute exists!
    if fluids[s_name] then
BioInd.writeDebug("%s exists!", {s_name})
      success = true
      substitute = s_name
      break
    end
  end

  -- No substitute found!
  if not success then
    -- Create nitrogen
    BioInd.create_stuff(fluid)

    -- Create recipe
    BioInd.create_stuff(recipe)
  end
end


------------------------------------------------------------------------------------
-- If we substitute liquid air, we must also replace it in the nitrogen recipe!
if substitute then
  thxbob.lib.recipe.replace_ingredient(recipe.name, fluid.name, substitute)
  BioInd.modified_msg("ingredient", recipe)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
