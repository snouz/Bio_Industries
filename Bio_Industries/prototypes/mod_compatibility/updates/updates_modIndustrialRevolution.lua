------------------------------------------------------------------------------------
--                             Industrial Revolution 2                            --
------------------------------------------------------------------------------------
local mod_name = "IndustrialRevolution"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe
local techs = data.raw.technology
local recipe, item, entity, tech, p_type, prototype


------------------------------------------------------------------------------------
--                       Adjustments to our big wooden poles                      --
------------------------------------------------------------------------------------
do
  -- Adjust localization of entity, item, and recipe
  for k, v in ipairs({
      BI.additional_recipes.BI_Wood_Products and BI.additional_recipes.BI_Wood_Products.big_pole,
      BI.additional_items.BI_Wood_Products and BI.additional_items.BI_Wood_Products.big_pole,
      BI.additional_entities.BI_Wood_Products and BI.additional_entities.BI_Wood_Products.big_pole
    }) do

    prototype = data.raw[v.type][v.name]
    if prototype then
      prototype.localised_name = {"entity-name.bi-wooden-pole-bigger"}
      prototype.localised_description = {"entity-description.bi-wooden-pole-bigger"}
      BioInd.debugging.modified_msg("localization", prototype)
    end
  end

  -- Adjust localization of remnants
  prototype = BI.additional_remnants.BI_Wood_Products and
              BI.additional_remnants.BI_Wood_Products.big_pole and
              data.raw.corpse[BI.additional_remnants.BI_Wood_Products.big_pole.name]
  if prototype then
    prototype.localised_name = {"entity-name.bi-wooden-pole-bigger-remnant"}
  end

  -- Adjust localization of technology
  tech = BI.additional_techs.BI_Wood_Products and
          BI.additional_techs.BI_Wood_Products.wooden_pole_1 and
          techs[BI.additional_techs.BI_Wood_Products.wooden_pole_1.name]
  p_type = BI.additional_entities.BI_Wood_Products and
            BI.additional_entities.BI_Wood_Products.big_pole

  prototype = p_type and data.raw[p_type.type] and data.raw[p_type.type][p_type.name]

  if tech and prototype then
    tech.localised_name = {
      "technology-name.bi-tech-wooden-pole-1",
      {"entity-name.bi-wooden-pole-bigger"}
    }
    tech.localised_description = {
      "technology-description.bi-tech-wooden-pole-1",
      {"entity-name.bi-wooden-pole-bigger"},
      prototype.maximum_wire_distance
    }
    BioInd.debugging.modified_msg("localization", tech)
  end
end

------------------------------------------------------------------------------------
-- Put recipe for Bio stone bricks in the same subgroup as concrete!
------------------------------------------------------------------------------------
do
  recipe = BI.additional_recipes.BI_Stone_Crushing and
            BI.additional_recipes.BI_Stone_Crushing.stone_brick and
            recipes[BI.additional_recipes.BI_Stone_Crushing.stone_brick.name]

  if recipe then
    recipe.subgroup = "ir2-tiles"
    BioInd.debugging.modified_msg("subgroup", recipe)
  end
end


------------------------------------------------------------------------------------
-- Replace BI-items with IR2-items in all recipes
------------------------------------------------------------------------------------
do
  local function replace(old, new)
    -- Replace in ingredients (all difficulties)
    thxbob.lib.recipe.replace_ingredient_in_all(old, new)
    BioInd.debugging.writeDebug("Exchanged \"%s\" in ingredients of all recipes with \"%s\"",
                      {old, new})

    -- Replace in results (all difficulties)
    thxbob.lib.recipe.replace_result_in_all(old, new)
    BioInd.debugging.writeDebug("Exchanged \"%s\" in results of all recipes with \"%s\"",
                      {old, new})
  end

  -- Replace "crushed stone" with "gravel"
  if BI.additional_items.BI_Trigger_Crushed_Stone_Create and
      BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone then
    replace(BI.additional_items.BI_Trigger_Crushed_Stone_Create.crushed_stone.name, "gravel")
  end

  -- Replace "wood-charcoal" with "charcoal"
  if BI.additional_items.BI_Trigger_Wood_Charcoal_Create and
      BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal then
    replace(BI.additional_items.BI_Trigger_Wood_Charcoal_Create.wood_charcoal.name,  "charcoal")
  end

  -- Replace "woodpulp" with "woodchips"
  if BI.additional_items.BI_Trigger_Woodpulp_Create and
      BI.additional_items.BI_Trigger_Woodpulp_Create.woodpulp then
    replace(BI.additional_items.BI_Trigger_Woodpulp_Create.woodpulp.name, "wood-chips")

    -- Change localization of some recipe names
    for i = 1, 4 do
      recipe = recipes[BI.default_recipes["logs_" ..i].name]
      if recipe then
        recipe.localised_name[2] = {"item-name.wood-chips"}
        BioInd.debugging.modified_msg("localised_name", recipe)
      end
    end
  end
end

------------------------------------------------------------------------------------
-- Add unlocks for our stone-crushing recipes
------------------------------------------------------------------------------------
do
  local crushing = {
    ["bi-crushed-stone-stone"]                   = {category = "grinding-1", item = "stone"},
    ["bi-crushed-stone-stone-brick"]             = {category = "grinding-1", item = "stone-brick"},
    ["bi-crushed-stone-concrete"]                = {category = "grinding-2", item = "concrete"},
    ["bi-crushed-stone-hazard-concrete"]         = {category = "grinding-2", item = "hazard-concrete"},
    ["bi-crushed-stone-refined-concrete"]        = {category = "grinding-3", item = "refined-concrete"},
    ["bi-crushed-stone-refined-hazard-concrete"] = {category = "grinding-3", item = "refined-hazard-concrete"},
  }

  for r_name, r_data in pairs(crushing) do
  BioInd.debugging.writeDebug("r_name: %s\tr_data: %s", {r_name, r_data})
  BioInd.debugging.show("r_data.category", r_data.category)
    recipe = recipes[r_name]
    if recipe then
      -- Change category
      recipe.category = r_data.category
      BioInd.debugging.modified_msg("category", recipe)

      -- Change localization
        --~ recipe.localised_name = {
          --~ "recipe-name.bi-crushed-stone-IR",
          --~ {"item-name." .. r_data.item}
        --~ }
        recipe.localised_name = {
          "recipe-name.bi-crushed-stone",
          {"item-name.gravel"},
          {"item-name." .. r_data.item}
        }
        recipe.localised_description = {
          "recipe-description.bi-crushed-stone-IR",
          {"item-name." .. r_data.item}
        }
      BioInd.debugging.modified_msg("localization", recipe)

      -- Add unlock
      thxbob.lib.tech.add_recipe_unlock("ir2-" .. r_data.category, recipe.name)
      BioInd.debugging.modified_msg("unlock", recipe)
    end
  end
end


------------------------------------------------------------------------------------
-- Add IR2's crafting categories to our stone crusher! It should be able to craft
-- the recipes that can be made by IR2's Copper crusher ("grinding", "grinding-1")
-- and Electric crusher ("grinding-2").
------------------------------------------------------------------------------------
do
  local crusher = BI.additional_entities.BI_Stone_Crushing and
                    BI.additional_entities.BI_Stone_Crushing.stone_crusher
  crusher = crusher and data.raw[crusher.type][crusher.name]

  if crusher then
    for c, category in ipairs({
      "grinding", "grinding-1", "grinding-2",
    }) do

      crusher.crafting_categories[#crusher.crafting_categories + 1] = category
      BioInd.debugging.modified_msg("category \"" .. category .. "\"", crusher, "Added")
    end
  end
end


------------------------------------------------------------------------------------
--                          Adjustments to the Bio boiler                         --
------------------------------------------------------------------------------------
do
  -- Recipe
  recipe = BI.additional_recipes.BI_Bio_Fuel and
            BI.additional_recipes.BI_Bio_Fuel.bio_boiler and
            recipes[BI.additional_recipes.BI_Bio_Fuel.bio_boiler.name]
  item = items["steel-frame-large"] -- Includes "advanced computer"!

  if recipe and item then
    thxbob.lib.recipe.remove_ingredient(recipe, "steel-plate")
    thxbob.lib.recipe.add_ingredient(recipe, {"steel-frame-large", 1})
    BioInd.debugging.modified_msg("ingredients", recipe)
  end

  -- Technology
  tech = BI.additional_techs.BI_Bio_Fuel and
          BI.additional_techs.BI_Bio_Fuel.bio_boiler and
          techs[BI.additional_techs.BI_Bio_Fuel.bio_boiler.name]
  local prereq = techs["ir2-electronics-2"]

  if tech and prereq then
    -- Change prerequisites
    thxbob.lib.tech.add_prerequisite(tech, prereq)
    BioInd.debugging.modified_msg("prerequisite \"" .. prereq.name .. "\"", tech, "Added")

    -- Make research more expensive
    local p_unit, new_unit
    for d, difficulty in pairs(BioInd.difficulties) do
      -- Use unit of difficulty, or fall back to unit of no difficulty
      p_unit = difficulty == "" and prereq.unit or
                (prereq[difficulty] and prereq[difficulty].unit) or
                prereq.unit
      if p_unit and not p_unit.count_formula then
        new_unit = table.deepcopy(p_unit)
        new_unit.count = math.ceil((new_unit.count or 1) * 1.1)
        thxbob.lib.tech.replace_difficulty_unit(tech, difficulty, new_unit)
        BioInd.debugging.modified_msg("unit for difficulty \"" ..  difficulty .. "\"", tech)
      end
    end
  end
end


------------------------------------------------------------------------------------
-- As steel is a late tech, the stone crusher and cokery should be made with iron --
-- beams instead of steel plates.                                                 --
------------------------------------------------------------------------------------
do
  local map = {
    cokery = {
      recipe = BI.default_recipes.cokery,
      -- This is already in the dependency tree!
      --~ tech = BI.default_techs.ash
    },
    crusher = {
      recipe = BI.additional_recipes.BI_Stone_Crushing and
                BI.additional_recipes.BI_Stone_Crushing.stone_crusher,
      tech = BI.additional_techs.BI_Stone_Crushing and
              BI.additional_techs.BI_Stone_Crushing.stone_crushing_1
    },
  }

  local i_old = "steel-plate"
  local i_new = "iron-beam"
  local p_old = "steel-processing"
  local p_new = "ir2-iron-milestone"


  for object, object_data in pairs(map) do

    -- Replace ingredients
    BioInd.debugging.writeDebug("Checking recipe for %s", object)
    recipe = object_data.recipe and recipes[object_data.recipe.name]

    if recipe then
      thxbob.lib.recipe.replace_ingredient(recipe, i_old, i_new)
      BioInd.debugging.modified_msg("ingredient", recipe, "Replaced")
    else
      BioInd.debugging.writeDebug("No recipe!")
    end

    -- Replace prerequisite
    BioInd.debugging.writeDebug("Checking prerequisite technology for %s", object)
    tech = object_data.tech and techs[object_data.tech.name]

    if tech then
      thxbob.lib.tech.replace_prerequisite(tech, p_old, p_new)
      BioInd.debugging.modified_msg("prerequisite", tech, "Replaced")
    else
      BioInd.debugging.writeDebug("No technology!")
    end
  end
end


------------------------------------------------------------------------------------
--                  The cokery should require electric furnaces!                  --
------------------------------------------------------------------------------------
do
  -- Change recipe ingredients
  recipe = BI.default_recipes.cokery and recipes[BI.default_recipes.cokery.name]
  if recipe then
    thxbob.lib.recipe.replace_ingredient(recipe, "stone-furnace", "electric-furnace")
    BioInd.debugging.modified_msg("ingredient", recipe, "Replaced")
  end

  -- Add prerequisite to technology
  tech = BI.default_techs.ash and techs[BI.default_techs.ash.name]
  prereq = techs["ir2-furnaces-2"]
  if tech and prereq then
    thxbob.lib.tech.add_prerequisite(tech, prereq)
    BioInd.debugging.modified_msg("prerequisite", tech, "Added")
  end
end


------------------------------------------------------------------------------------
--   Iron gears require an advanced tech, so they can't be used in dart turrets!  --
------------------------------------------------------------------------------------
do
  recipe = BI.additional_recipes.BI_Darts.dart_turret and
            recipes[BI.additional_recipes.BI_Darts.dart_turret.name]

  if recipe then
    local old = "iron-gear-wheel"
    local new = "copper-gear-wheel"

    thxbob.lib.recipe.replace_ingredient(recipe, old, new)
    BioInd.debugging.modified_msg("ingredient", recipe, "Replaced")
    thxbob.lib.recipe.add_ingredient(recipe, {"copper-frame-small", 1})
    BioInd.debugging.modified_msg("ingredient", recipe, "Added")
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
