BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local function build_icons(_recipe, _icons, _mod)
  _recipe = data.raw.recipe[_recipe] or nil
  _icons = _icons or {}
  local missingmod = _mod and not mods[_mod] or nil
  if not missingmod then
    if _recipe then
      _recipe.icons = BioInd.make_icons(_icons)
    end
  end
end

build_icons("bi-seed-1", {it1 = "seed"})
build_icons("bi-seed-2", {it1 = "seed", it2 = "ash"})
build_icons("bi-seed-3", {it1 = "seed", custom_topright = BioInd.iconpath .. "signal/bi_signal_fert.png"})
build_icons("bi-seed-4", {it1 = "seed", custom_topright = BioInd.iconpath .. "signal/bi_signal_adv_fert.png"})
build_icons("bi-seedling-1", {it1 = "seedling"})
build_icons("bi-seedling-2", {it1 = "seedling", it2 = "ash"})
build_icons("bi-seedling-3", {it1 = "seedling", custom_topright = BioInd.iconpath .. "signal/bi_signal_fert.png"})
build_icons("bi-seedling-4", {it1 = "seedling", custom_topright = BioInd.iconpath .. "signal/bi_signal_adv_fert.png"})

-- ash
if data.raw.recipe["bi-seed-1"] then data.raw.recipe["bi-seed-1"].icons = BioInd.make_icons({it1 = "seed"}) end
if data.raw.recipe["bi-seed-2"] then data.raw.recipe["bi-seed-2"].icons = BioInd.make_icons({it1 = "seed", it2 = "ash"}) end
if data.raw.recipe["bi-seed-3"] then data.raw.recipe["bi-seed-3"].icons = BioInd.make_icons({it1 = "seed", custom_topright = BioInd.iconpath .. "signal/bi_signal_fert.png"}) end
if data.raw.recipe["bi-seed-4"] then data.raw.recipe["bi-seed-4"].icons = BioInd.make_icons({it1 = "seed", custom_topright = BioInd.iconpath .. "signal/bi_signal_adv_fert.png"}) end
if data.raw.recipe["bi-seedling-1"] then data.raw.recipe["bi-seedling-1"].icons = BioInd.make_icons({it1 = "seedling"}) end
if data.raw.recipe["bi-seedling-2"] then data.raw.recipe["bi-seedling-2"].icons = BioInd.make_icons({it1 = "seedling", it2 = "ash"}) end
if data.raw.recipe["bi-seedling-3"] then data.raw.recipe["bi-seedling-3"].icons = BioInd.make_icons({it1 = "seedling", custom_topright = BioInd.iconpath .. "signal/bi_signal_fert.png"}) end
if data.raw.recipe["bi-seedling-4"] then data.raw.recipe["bi-seedling-4"].icons = BioInd.make_icons({it1 = "seedling", custom_topright = BioInd.iconpath .. "signal/bi_signal_adv_fert.png"}) end
if data.raw.recipe["bi-logs-1"] then data.raw.recipe["bi-logs-1"].icons = BioInd.make_icons({it4 = "woodpulp", it5 = "wood"}) end
if data.raw.recipe["bi-logs-2"] then data.raw.recipe["bi-logs-2"].icons = BioInd.make_icons({it4 = "woodpulp", it5 = "wood", it7 = "ash"}) end
if data.raw.recipe["bi-logs-3"] then data.raw.recipe["bi-logs-3"].icons = BioInd.make_icons({it4 = "woodpulp", it5 = "wood", custom_topright = BioInd.iconpath .. "signal/bi_signal_fert.png"}) end
if data.raw.recipe["bi-logs-4"] then data.raw.recipe["bi-logs-4"].icons = BioInd.make_icons({it4 = "woodpulp", it5 = "wood", custom_topright = BioInd.iconpath .. "signal/bi_signal_adv_fert.png"}) end
if data.raw.recipe["bi-ash-1"] then data.raw.recipe["bi-ash-1"].icons = BioInd.make_icons({it1 = "ash", it2 = "woodpulp"}) end
if data.raw.recipe["bi-ash-2"] then data.raw.recipe["bi-ash-2"].icons = BioInd.make_icons({it1 = "ash", it2 = "wood"}) end
if data.raw.recipe["bi-stone-brick"] then data.raw.recipe["bi-stone-brick"].icons = BioInd.make_icons({it1 = "stone-brick", it2 = "ash", it3 = "stone-crushed"}) end
if data.raw.recipe["bi-biomass-1"] then data.raw.recipe["bi-biomass-1"].icons = BioInd.make_icons({it1 = "bi-biomass" }) end
if data.raw.recipe["bi-biomass-2"] then data.raw.recipe["bi-biomass-2"].icons = BioInd.make_icons({it1 = "bi-biomass", custom = BioInd.iconpath .. "signal/bi_signal_reprocess.png" }) end
if data.raw.recipe["bi-biomass-3"] then data.raw.recipe["bi-biomass-3"].icons = BioInd.make_icons({it1 = "bi-biomass", custom = BioInd.iconpath .. "signal/bi_signal_reprocess.png", it2 = "ash" }) end
if data.raw.recipe["bi-sulfur"] then data.raw.recipe["bi-sulfur"].icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid"}) end
if data.raw.recipe["bi-press-wood"] then data.raw.recipe["bi-press-wood"].icons = BioInd.make_icons({it1 = "wooden-board", it2 = "woodpulp", it3 = "resin"}) end
if data.raw.recipe["bi-wood-fuel-brick"] then data.raw.recipe["bi-wood-fuel-brick"].icons = BioInd.make_icons({it1 = "wood-bricks"}) end
if data.raw.recipe["bi-sand"] then data.raw.recipe["bi-sand"].icons = BioInd.make_icons({it1 = "sand", it2 = "stone-crushed"}) end
  if mods["angelsrefining"] then if data.raw.recipe["bi-sand"] then data.raw.recipe["bi-sand"].icons = BioInd.make_icons({it1 = "solid-sand", it2 = "stone-crushed"}) end end
--if data.raw.recipe["bi-basic-gas-processing"] then data.raw.recipe["bi-basic-gas-processing"].icons = BioInd.make_icons({it4 = "ash", it5 = "petroleum-gas", sh4 = {0,-16}, sh5 = {0,16} }) end
--  if mods["angelspetrochem"] then if data.raw.recipe["bi-basic-gas-processing"] then data.raw.recipe["bi-basic-gas-processing"].icons = BioInd.make_icons({it1 = "gas-methane", sc1 = 0.6, it6 = "ash", sc6 = 0.7}) end end
build_icons("bi-basic-gas-processing", {it4 = "ash", it5 = "petroleum-gas", sh4 = {0,-16}, sh5 = {0,16} })
build_icons("bi-basic-gas-processing", {it1 = "gas-methane", sc1 = 0.9, it6 = "ash", sc6 = 0.7, sh6 = {-7,7}}, "angelspetrochem")
if data.raw.recipe["bi-crushed-stone-stone"] then data.raw.recipe["bi-crushed-stone-stone"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "stone"}) end
if data.raw.recipe["bi-crushed-stone-stone-brick"] then data.raw.recipe["bi-crushed-stone-stone-brick"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "stone-brick"}) end
if data.raw.recipe["bi-crushed-stone-concrete"] then data.raw.recipe["bi-crushed-stone-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "concrete"}) end
if data.raw.recipe["bi-crushed-stone-hazard-concrete"] then data.raw.recipe["bi-crushed-stone-hazard-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "hazard-concrete"}) end
if data.raw.recipe["bi-crushed-stone-refined-concrete"] then data.raw.recipe["bi-crushed-stone-refined-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "refined-concrete"}) end
if data.raw.recipe["bi-crushed-stone-refined-hazard-concrete"] then data.raw.recipe["bi-crushed-stone-refined-hazard-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "hazard-concrete"}) end
if data.raw.recipe["bi-rubber"] then data.raw.recipe["bi-rubber"].icons = BioInd.make_icons({it1 = "rubber", sh1 = {0,8}}) end
if data.raw.recipe["bi-coke-coal"] then data.raw.recipe["bi-coke-coal"].icons = BioInd.make_icons({it1 = "pellet-coke", it2 = "coal"}) end
if data.raw.recipe["bi-pellet-coke"] then data.raw.recipe["bi-pellet-coke"].icons = BioInd.make_icons({it1 = "pellet-coke", it2 = "solid-fuel"}) end
if data.raw.recipe["bi-pellet-coke-2"] then data.raw.recipe["bi-pellet-coke-2"].icons = BioInd.make_icons({it1 = "pellet-coke", it2 = data.raw.recipe["bi-pellet-coke-2"].ingredients[1].name}) end
if data.raw.recipe["cellulose_1"] then data.raw.recipe["cellulose_1"].icons = BioInd.make_icons({it1 = "cellulose"}) end
if data.raw.recipe["cellulose_2"] then data.raw.recipe["cellulose_2"].icons = BioInd.make_icons({it1 = "cellulose", it2 = "steam"}) end
if data.raw.recipe["bi-plastic-1"] then data.raw.recipe["bi-plastic-1"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "light-oil", it3 = "woodpulp"}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-plastic-1"] then data.raw.recipe["bi-plastic-1"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "liquid-fuel-oil", it3 = "woodpulp", sc2 = 0.8, sc3 = 0.8}) end end
if data.raw.recipe["bi-plastic-2"] then data.raw.recipe["bi-plastic-2"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "cellulose", it3 = "petroleum-gas"}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-plastic-2"] then data.raw.recipe["bi-plastic-2"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "cellulose", it3 = "gas-methane", sc2 = 0.8, sc3 = 0.8}) end end
if data.raw.recipe["bi-wood-gasification"] then data.raw.recipe["bi-wood-gasification"].icons = BioInd.make_icons({it5 = "tar", it4 = "petroleum-gas", sc4 = 0.8}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-wood-gasification"] then data.raw.recipe["bi-wood-gasification"].icons = BioInd.make_icons({it5 = "tar", sh5 = {-5,0}, it4 = "gas-methane"}) end end
if data.raw.recipe["solid-fuel-from-tar"] then data.raw.recipe["solid-fuel-from-tar"].icons = BioInd.make_icons({it1 = "solid-fuel", it3 = "tar"}) end
if data.raw.recipe["bi-solid-fuel"] then data.raw.recipe["bi-solid-fuel"].icons = BioInd.make_icons({it1 = "solid-fuel", it3 = "wood-bricks"}) end
if data.raw.recipe["bi-biomass-conversion-crude-oil"] then data.raw.recipe["bi-biomass-conversion-crude-oil"].icons = BioInd.make_icons({it1 = "crude-oil", it3 = "bi-biomass", sc3 = 1.2}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-crude-oil"] then data.raw.recipe["bi-biomass-conversion-crude-oil"].icons = BioInd.make_icons({it1 = "crude-oil", it3 = "bi-biomass", sc3 = 1.2, it6 = "water-yellow-waste", sc6 = 0.7, sh = {-5,5}}) end end
if data.raw.recipe["bi-biomass-conversion-petroleum"] then data.raw.recipe["bi-biomass-conversion-petroleum"].icons = BioInd.make_icons({it1 = "petroleum-gas", it3 = "bi-biomass", sc3 = 1.2}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-petroleum"] then data.raw.recipe["bi-biomass-conversion-petroleum"].icons = BioInd.make_icons({it1 = "gas-methane", it3 = "bi-biomass", sc1 = 0.9, sc3 = 1.2}) end end
if data.raw.recipe["bi-biomass-conversion-lubricant"] then data.raw.recipe["bi-biomass-conversion-lubricant"].icons = BioInd.make_icons({it1 = "lubricant", it3 = "bi-biomass", sc3 = 1.2}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-lubricant"] then data.raw.recipe["bi-biomass-conversion-lubricant"].icons = BioInd.make_icons({it1 = "lubricant", it3 = "bi-biomass", sc1 = 1.3, sh1 = {0,8}, sc3 = 1.2}) end end
if data.raw.recipe["bi-biomass-conversion-sulfuric-acid"] then data.raw.recipe["bi-biomass-conversion-sulfuric-acid"].icons = BioInd.make_icons({it1 = "sulfuric-acid", it3 = "bi-biomass", sc3 = 1.2}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-sulfuric-acid"] then data.raw.recipe["bi-biomass-conversion-sulfuric-acid"].icons = BioInd.make_icons({it1 = "liquid-sulfuric-acid", it3 = "bi-biomass", sc1 = 0.9, sc3 = 1.2}) end end
if data.raw.recipe["bi-biomass-conversion-light-oil"] then data.raw.recipe["bi-biomass-conversion-light-oil"].icons = BioInd.make_icons({it1 = "light-oil", it3 = "bi-biomass", sc3 = 1.2}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-light-oil"] then data.raw.recipe["bi-biomass-conversion-light-oil"].icons = BioInd.make_icons({it1 = "liquid-fuel-oil", it3 = "bi-biomass", sc3 = 1.2, it6 = "cellulose", sc6 = 0.7, sh = {-5,5}}) end end
if data.raw.recipe["bi-charcoal-1"] then data.raw.recipe["bi-charcoal-1"].icons = BioInd.make_icons({it1 = "wood-charcoal", it2 = "woodpulp"}) end
if data.raw.recipe["bi-charcoal-2"] then data.raw.recipe["bi-charcoal-2"].icons = BioInd.make_icons({it1 = "wood-charcoal", it2 = "wood"}) end
if data.raw.recipe["bi-sulfur"] then data.raw.recipe["bi-sulfur"].icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid"}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-sulfur"] then data.raw.recipe["bi-sulfur"].icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "liquid-sulfuric-acid", sc3 = 0.6}) end end
if data.raw.recipe["bi-battery"] then data.raw.recipe["bi-battery"].icons = BioInd.make_icons({it1 = "battery", it3 = "bi-biomass"}) end
if data.raw.recipe["bi-woodpulp"] then data.raw.recipe["bi-woodpulp"].icons = BioInd.make_icons({it1 = "woodpulp"}) end
if data.raw.recipe["bi-fertilizer-1"] then data.raw.recipe["bi-fertilizer-1"].icons = BioInd.make_icons({it1 = "fertilizer" }) end
if data.raw.recipe["bi-fertilizer-2"] then data.raw.recipe["bi-fertilizer-2"].icons = BioInd.make_icons({it1 = "fertilizer", it2 = data.raw.recipe["bi-fertilizer-2"].ingredients[2].name }) end
if data.raw.recipe["bi-mineralized-sulfuric-waste"] then data.raw.recipe["bi-mineralized-sulfuric-waste"].icons = BioInd.make_icons({it1 = "water-mineralized", it6 = "water-yellow-waste", sc6 = 0.5, sh6 = {-4,4}}) end
if data.raw.recipe["bi-slag-slurry"] then data.raw.recipe["bi-slag-slurry"].icons = BioInd.make_icons({it1 = "slag-slurry", sh1 = {0,8}, it2 = "water-saline", sc2 = 0.4, it3 = "stone-crushed", sc3 = 0.4}) end

--bobplates
build_icons("bob-resin-oil", {it1 = "resin", it2 = "heavy-oil"}, "bobplates")
build_icons("sulfur-2", {it1 = "sulfur", it2 = "sulfur-dioxide", it3 = "hydrogen"}, "bobplates")
build_icons("sulfur-3", {it1 = "sulfur", it2 = "hydrogen-sulfide", it3 = "oxygen"}, "bobplates")
build_icons("solid-fuel-from-hydrogen", {it1 = "solid-fuel", it2 = "coal", it3 = "hydrogen"}, "bobplates")
build_icons("solid-fuel-from-sour-gas", {it1 = "solid-fuel", it3 = "sour-gas"}, "bobrevamp")

--angelpetrochem
build_icons("bi-solid-fuel", {it1 = "solid-fuel", it6 = "wood-bricks", sc6 = 0.7, sh6 = {-8,8}}, "angelspetrochem")
build_icons("solid-fuel-from-tar", {it1 = "solid-fuel", it6 = "tar", sc6 = 0.7, sh6 = {-8,8}}, "angelspetrochem")
build_icons("enriched-fuel-from-liquid-fuel", {it1 = "enriched-fuel", it6 = "liquid-fuel", sc6 = 0.7, sh6 = {-8,8}}, "angelspetrochem")
build_icons("solid-resin", {it1 = "resin", it2 = "liquid-resin"}, "angelspetrochem")
build_icons("bob-rubber", {it1 = "rubber", it2 = "resin", sh1 = {0,8}}, "angelspetrochem")
build_icons("solid-rubber", {it1 = "rubber", it2 = "liquid-rubber", sh1 = {0,8}}, "angelspetrochem")


--changes recipe position in menu based on installed mod
--args ("mod that makes the change", "recipe to move", "New Subgroup", "New Order (1987)")
local function change_sub(_mod, _recipe, _subgroup, _order)
  local recipe = data.raw.recipe[_recipe] or nil
  if _mod and mods[_mod] and recipe then
    if _subgroup and data.raw["item-subgroup"][_subgroup] then
      recipe.subgroup = _subgroup
    end
    if _mod and recipe and _order then
      recipe.order = _order
    end
  end
end

change_sub("boblogistics", "bi-wood-pipe", "pipe")
change_sub("boblogistics", "bi-wood-pipe-to-ground", "pipe-to-ground")
change_sub("boblogistics", "bi-wooden-chest-large", "", "a[items]-g[bigchests]")
change_sub("boblogistics", "bi-wooden-chest-huge", "", "a[items]-h[bigchests]")
change_sub("boblogistics", "bi-wooden-chest-giga", "", "a[items]-i[bigchests]")
change_sub("bobplates", "bob-resin-oil", "bio-bio-farm-raw", "a[bi]-a-bc[resin]")
change_sub("bobplates", "solid-fuel-from-hydrogen", "fluid-recipes", "b[fluid-chemistry]-h[solid-fuel-from-hydrogen]")
change_sub("bobplates", "enriched-fuel-from-liquid-fuel", "fluid-recipes", "b[fluid-chemistry]-j[enriched-fuel-from-liquid-fuel]")
change_sub("bobplates", "sulfur-2", "raw-material", "g[sulfur]-b[bobs]-2")
change_sub("bobplates", "sulfur-3", "raw-material", "g[sulfur]-b[bobs]-3")
change_sub("bobpower", "bi-bio-boiler", "bob-energy-boiler", "b[steam-power]-a[boiler-1bio]")
change_sub("bobrevamp", "solid-fuel-from-sour-gas", "fluid-recipes", "b[fluid-chemistry]-i[solid-fuel-from-sour-gas]")
change_sub("bobrevamp", "enriched-fuel-from-hydrazine", "fluid-recipes", "b[fluid-chemistry]-k[enriched-fuel-from-hydrazine]")

change_sub("angelspetrochem", "bi-sulfur", "petrochem-sulfur")
change_sub("angelspetrochem", "bi-solid-fuel", "petrochem-fuel", "f[bi-solid-fuel]")
change_sub("angelspetrochem", "solid-fuel-from-tar", "petrochem-fuel", "g[solid-fuel-from-tar]")
change_sub("angelspetrochem", "enriched-fuel-from-liquid-fuel", "petrochem-fuel", "h[enriched-fuel-from-liquid-fuel]")



change_sub("angelspetrochem", "bi-plastic-1", "petrochem-solids", "a[plastic]-c")
change_sub("angelspetrochem", "bi-plastic-2", "petrochem-solids", "a[plastic]-d")
change_sub("angelspetrochem", "bi-resin-pulp", "petrochem-solids", "b[resin]-c")
change_sub("angelspetrochem", "bi-resin-wood", "petrochem-solids", "b[resin]-d")
change_sub("angelsindustries", "bi-bio-boiler", "angels-power-steam-boiler", "aaa")
change_sub("angelsindustries", "bi-wooden-pole-big", "angels-power-poles", "a[small]-b")
change_sub("angelsindustries", "bi-wooden-pole-huge", "angels-power-poles", "a[small]-c")
change_sub("angelsindustries", "bi-battery", "angels-batteries", "aa")
change_sub("angelsindustries", "bi-press-wood", "angels-board", "z[bob]-aa")
change_sub("angelsindustries", "empty-nuclear-fuel-cell", "angels-power-nuclear-fuel-cell", "a[uranium]-1a")
change_sub("angelsindustries", "bi-wooden-chest-large", "angels-chests-small-a", "a[chest]-c[bi1]")
change_sub("angelsindustries", "bi-wooden-chest-huge", "angels-chests-small-a", "a[chest]-c[bi2]")
change_sub("angelsindustries", "bi-wooden-chest-giga", "angels-chests-small-a", "a[chest]-c[bi3]")
change_sub("Krastorio2", "bi-wooden-chest-huge", "", "a[items]-db[hugechest]")
change_sub("Krastorio2", "bi-huge-substation", "", "a[energy]-f[huge-substation]")
change_sub("Krastorio2", "kr-grow-wood-plus", "", "ab[wood]")
change_sub("Krastorio2", "bi-wooden-fence", "defensive-structure", "a[wooden-fence]")
change_sub("Krastorio2", "stone-wall", "defensive-structure", "a[wooden-fence]")
change_sub("Krastorio2", "gate", "defensive-structure", "c[gate]")
change_sub("Krastorio2", "bi-rubber-mat", "defensive-structure", "d[rubber-mat]")
change_sub("Krastorio2", "bi-dart-turret", "vanilla-turrets", "004[dart-turret]")
change_sub("Krastorio2", "bi-bio-cannon", "vanilla-turrets", "04a[prototype-artillery]")
change_sub("Krastorio2", "artillery-targeting-remote", "vanilla-turrets", "04b[artillery-targeting-remote]")


--args ("mod that disables recipe", "recipe to remove", "check that this recipe exists before removing")
local function disable_recipe(_mod, _reciperemoved, _recipecheck)
  _reciperemoved = data.raw.recipe[_reciperemoved] or nil
  _recipecheck = data.raw.recipe[_recipecheck] or nil
  if _reciperemoved and _recipecheck then
    _reciperemoved.enabled = false
    _reciperemoved.hidden = true
    if _reciperemoved.normal then
      _reciperemoved.normal.enabled = false
      _reciperemoved.normal.hidden = true
    end
    if _reciperemoved.expensive then
      _reciperemoved.expensive.enabled = false
      _reciperemoved.expensive.hidden = true
    end
  end
end

disable_recipe("bobplates", "bob-resin-wood", "bi-resin-wood")
disable_recipe("bobplates", "bob-coal-from-wood", "bi-coal-1")
disable_recipe("bobplates", "bi-rubber", "bob-rubber")
disable_recipe("angelssmelting", "bi-stone-brick", "stone-brick")
disable_recipe("angelsbioprocessing", "bi-wood-fuel-brick", "wood-bricks")
disable_recipe("angelsbioprocessing", "bi-charcoal-1", "wood-charcoal")
disable_recipe("angelsbioprocessing", "bi-charcoal-2", "wood-charcoal")
disable_recipe("angelsbioprocessing", "bi-resin-pulp", "bio-resin-wood-reprocessing")
disable_recipe("angelsbioprocessing", "bi-resin-wood", "bio-resin-wood-reprocessing")
disable_recipe("Krastorio2", "bi-liquid-air", "kr-atmospheric-condenser")


--make wood recipe from krastorio 100* slower to encorage using our more complete system
if mods["Krastorio2"] then
  if data.raw.recipe["kr-grow-wood-plus"] then
    data.raw.recipe["kr-grow-wood-plus"].energy_required = 600
  end
  if data.raw.recipe["kr-grow-wood-with-water"] then
    data.raw.recipe["kr-grow-wood-with-water"].energy_required = 600
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
