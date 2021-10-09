------------------------------------------------------------------------------------
--        Trigger: Use different prerequisites/ingredients if IR2 is active       --
--                  (BI.Triggers.BI_Trigger_IR2_Power_production)                 --
------------------------------------------------------------------------------------
-- Mods: "IndustrialRevolution"
-- Setting: BI.Settings.BI_Power_Production
local trigger = "BI_Trigger_IR2_Power_production"
if not BI.Triggers[trigger] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local techs = data.raw.technology
local recipes = data.raw.recipe
local items = data.raw.item
local tech, tech_map, recipe, new, old



------------------------------------------------------------------------------------
--                        Exchange ingredient of Solar farm                       --
------------------------------------------------------------------------------------
recipe = BI.additional_recipes.BI_Power_Production.solar_farm and
          recipes[BI.additional_recipes.BI_Power_Production.solar_farm.name]

if recipe then
  new = "solar-array"
  old = "solar-panel"

  thxbob.lib.recipe.replace_ingredient(recipe, old, new)
  BioInd.debugging.modified_msg("ingredient", recipe, "Replaced")
end


------------------------------------------------------------------------------------
--             Change prerequisite techs of Solar farm and Musk floor             --
------------------------------------------------------------------------------------
--~ tech = BI.additional_techs.BI_Power_Production.super_solar_panels and
        --~ techs[BI.additional_techs.BI_Power_Production.super_solar_panels.name]

--~ if tech then
  --~ new = "ir2-solar-energy-2"
  --~ old = "solar-energy"

  --~ -- Change prerequisite tech
  --~ thxbob.lib.tech.remove_prerequisite(tech, old)
  --~ thxbob.lib.tech.add_prerequisite(tech, new)
  --~ BioInd.debugging.modified_msg("prerequisite", tech)

  --~ -- Adjust research cost
  --~ old = techs["ir2-solar-energy-2"]
  --~ if old then
    --~ for d, difficulty in ipairs({"normal", "expensive"}) do
      --~ new = old[difficulty] and table.deepcopy(old[difficulty].unit) or
                                  --~ table.deepcopy(old.unit)
      --~ new.count = new.count * 1.1
      --~ thxbob.lib.tech.replace_difficulty_unit(tech, difficulty, new)
      --~ BioInd.debugging.modified_msg("unit count for difficulty " .. difficulty, tech)
    --~ end
  --~ end
--~ end



--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------
--~ --                                 Musk floor                                     --
--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------


--~ ------------------------------------------------------------------------------------
--~ --                               Change prerequisite                              --
--~ ------------------------------------------------------------------------------------
--~ tech = BI.additional_techs.BI_Power_Production.musk_floor and
        --~ techs[BI.additional_techs.BI_Power_Production.musk_floor.name]
tech_map = {
  musk_floor            = {old = "solar-energy", new = "ir2-solar-energy-1"},
  steamsolar_combination= {old = "solar-energy", new = "ir2-solar-energy-1"},
  super_solar_panels    = {old = "solar-energy", new = "ir2-solar-energy-2"},
}

for t_name, t_data in pairs(tech_map) do
  tech = BI.additional_techs.BI_Power_Production[t_name] and
          techs[BI.additional_techs.BI_Power_Production[t_name].name]

  if tech then
    new = t_data.new
    old = t_data.old

    -- Change prerequisite tech
    thxbob.lib.tech.remove_prerequisite(tech, old)
    thxbob.lib.tech.add_prerequisite(tech, new)
    BioInd.debugging.modified_msg("prerequisite", tech)

    -- Our tech requires the same science packs as (but 10% more than) the prerequisite
    -- from IR2
    old = techs[t_data.new]
    if old then
      for d, difficulty in ipairs({"normal", "expensive"}) do
        new = old[difficulty] and table.deepcopy(old[difficulty].unit) or
                                    table.deepcopy(old.unit)
        new.count = new.count * 1.1
        thxbob.lib.tech.replace_difficulty_unit(tech, difficulty, new)
        BioInd.debugging.modified_msg("unit count for difficulty " .. difficulty, tech)
      end
    end
  end
end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
