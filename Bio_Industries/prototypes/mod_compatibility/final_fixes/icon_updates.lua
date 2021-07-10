BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

--~ local function build_icons(_recipe, _icons, _mod)
  --~ _recipe = data.raw.recipe[_recipe] or nil
  --~ _icons = _icons or {}
  --~ local missingmod = _mod and not mods[_mod] or nil
  --~ if not missingmod then
    --~ if _recipe then
      --~ _recipe.icons = BioInd.make_icons(_icons)
    --~ end
  --~ end
--~ end
local function build_icons(_recipe, _icons, _mod)
  -- If the recipe doesn't exist, it will be nil, you don't need to set that again!
  -- (Also, we already have shorthands for data.raw.item and data.raw.recipe defined at the top.)
  _recipe = _recipe and recipes[_recipe]
  -- Better check for sane values: _icons must be a table! You don't have to check if _icons exist
  -- if you use type: type(nil) will be nil, so the test 'type(nil) == "table"' will fail.
  _icons = (type(_icons) == "table") and _icons or {}
  local missingmod = _mod and not mods[_mod] or nil
  if not missingmod and _recipe then
    _recipe.icons = BioInd.make_icons(_icons)
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
build_icons("bi-logs-1", {it4 = "woodpulp", it5 = "wood"})
build_icons("bi-logs-2", {it4 = "woodpulp", it5 = "wood", it7 = "ash"})
build_icons("bi-logs-3", {it4 = "woodpulp", it5 = "wood", custom_topright = BioInd.iconpath .. "signal/bi_signal_fert.png"})
build_icons("bi-logs-4", {it4 = "woodpulp", it5 = "wood", custom_topright = BioInd.iconpath .. "signal/bi_signal_adv_fert.png"})
build_icons("bi-ash-1", {it1 = "ash", it2 = "woodpulp"})
build_icons("bi-ash-2", {it1 = "ash", it2 = "wood"})
build_icons("bi-biomass-1", {it1 = "bi-biomass" })
build_icons("bi-biomass-2", {it1 = "bi-biomass", custom = BioInd.iconpath .. "signal/bi_signal_reprocess.png" })
build_icons("bi-biomass-3", {it1 = "bi-biomass", custom = BioInd.iconpath .. "signal/bi_signal_reprocess.png", it2 = "ash" })
build_icons("bi-wood-fuel-brick", {it1 = "wood-bricks"})
build_icons("bi-rubber", {it1 = "rubber", sh1 = {0,8}})
build_icons("bi-coke-coal", {it1 = "pellet-coke", it2 = "coal"})
build_icons("bi-pellet-coke", {it1 = "pellet-coke", it2 = "solid-fuel"})
build_icons("cellulose_1", {it1 = "cellulose"})
build_icons("cellulose_2", {it1 = "cellulose", it2 = "steam"})
build_icons("bi-wood-gasification", {it5 = "tar", it4 = "petroleum-gas", sc4 = 0.8})
build_icons("bi-biomass-conversion-crude-oil", {it1 = "crude-oil", it3 = "bi-biomass", sc3 = 1.2})
build_icons("bi-biomass-conversion-petroleum", {it1 = "petroleum-gas", it3 = "bi-biomass", sc3 = 1.2})
build_icons("bi-biomass-conversion-lubricant", {it1 = "lubricant", it3 = "bi-biomass", sc3 = 1.2})
build_icons("bi-biomass-conversion-sulfuric-acid", {it1 = "sulfuric-acid", it3 = "bi-biomass", sc3 = 1.2})
build_icons("bi-biomass-conversion-light-oil", {it1 = "light-oil", it3 = "bi-biomass", sc3 = 1.2})
build_icons("bi-charcoal-1", {it1 = "wood-charcoal", it2 = "woodpulp"})
build_icons("bi-charcoal-2", {it1 = "wood-charcoal", it2 = "wood"})
build_icons("bi-woodpulp", {it1 = "woodpulp"})
build_icons("bi-fertilizer-1", {it1 = "fertilizer" })
local stcrorgravel = mods["IndustrialRevolution"] and "gravel" or "stone-crushed"
build_icons("bi-crushed-stone-stone", {it1 = stcrorgravel, it2 = "stone"})
build_icons("bi-crushed-stone-stone-brick", {it1 = stcrorgravel, it2 = "stone-brick"})
build_icons("bi-crushed-stone-concrete", {it1 = stcrorgravel, it2 = "concrete"})
build_icons("bi-crushed-stone-hazard-concrete", {it1 = stcrorgravel, it2 = "hazard-concrete"})
build_icons("bi-crushed-stone-refined-concrete", {it1 = stcrorgravel, it2 = "refined-concrete"})
build_icons("bi-crushed-stone-refined-hazard-concrete", {it1 = stcrorgravel, it2 = "hazard-concrete"})

build_icons("bi-stone-brick", {it1 = "stone-brick", it2 = "ash", it3 = "stone-crushed"})
build_icons("bi-sulfur", {it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid"})
build_icons("bi-basic-gas-processing", {it4 = "ash", it5 = "petroleum-gas", sh4 = {0,-16}, sh5 = {0,16} })
build_icons("bi-plastic-1", {it1 = "plastic-bar", it2 = "light-oil", it3 = "woodpulp"})
build_icons("bi-plastic-2", {it1 = "plastic-bar", it2 = "cellulose", it3 = "petroleum-gas"})
build_icons("solid-fuel-from-tar", {it1 = "solid-fuel", it3 = "tar"})
build_icons("bi-solid-fuel", {it1 = "solid-fuel", it3 = "wood-bricks"})
build_icons("bi-battery", {it1 = "battery", it3 = "bi-biomass"})

-------compatibility
build_icons("bi-press-wood", {it1 = "wooden-board", it2 = "woodpulp", it3 = "resin"})
if data.raw.recipe["bi-sand"] then
  build_icons("bi-sand", {it1 = "sand", it2 = "stone-crushed"})
  build_icons("bi-sand", {it1 = "solid-sand", it2 = "stone-crushed"}, "angelsrefining")
end
if data.raw.recipe["bi-pellet-coke-2"] then build_icons("bi-pellet-coke-2", {it1 = "pellet-coke", it2 = data.raw.recipe["bi-pellet-coke-2"].ingredients[1].name}) end
if data.raw.recipe["bi-fertilizer-2"] then build_icons("bi-fertilizer-2", {it1 = "fertilizer", it2 = data.raw.recipe["bi-fertilizer-2"].ingredients[2].name }) end
build_icons("bi-mineralized-sulfuric-waste", {it1 = "water-mineralized", it6 = "water-yellow-waste", sc6 = 0.5, sh6 = {-4,4}})
build_icons("bi-slag-slurry", {it1 = "slag-slurry", sh1 = {0,8}, it2 = "water-saline", sc2 = 0.4, it3 = "stone-crushed", sc3 = 0.4})

--bobplates
build_icons("bob-resin-oil", {it1 = "resin", it2 = "heavy-oil"}, "bobplates")
build_icons("sulfur-2", {it1 = "sulfur", it2 = "sulfur-dioxide", it3 = "hydrogen"}, "bobplates")
build_icons("sulfur-3", {it1 = "sulfur", it2 = "hydrogen-sulfide", it3 = "oxygen"}, "bobplates")
build_icons("solid-fuel-from-hydrogen", {it1 = "solid-fuel", it2 = "coal", it3 = "hydrogen"}, "bobplates")

--bobrevamp
build_icons("solid-fuel-from-sour-gas", {it1 = "solid-fuel", it3 = "sour-gas"}, "bobrevamp")

--angelpetrochem
build_icons("bi-basic-gas-processing", {it1 = "gas-methane", sc1 = 0.9, it6 = "ash", sc6 = 0.7, sh6 = {-7,7}}, "angelspetrochem")
build_icons("bi-plastic-1", {it1 = "plastic-bar", it2 = "liquid-fuel-oil", it3 = "woodpulp", sc2 = 0.8, sc3 = 0.8}, "angelspetrochem")
build_icons("bi-plastic-2", {it1 = "plastic-bar", it2 = "cellulose", it3 = "gas-methane", sc2 = 0.8, sc3 = 0.8}, "angelspetrochem")
build_icons("bi-wood-gasification", {it5 = "tar", sh5 = {-5,0}, it4 = "gas-methane"}, "angelspetrochem")
build_icons("bi-biomass-conversion-crude-oil", {it1 = "crude-oil", it3 = "bi-biomass", sc3 = 1.2, it6 = "water-yellow-waste", sc6 = 0.7, sh = {-5,5}}, "angelspetrochem")
build_icons("bi-biomass-conversion-petroleum", {it1 = "gas-methane", it3 = "bi-biomass", sc1 = 0.9, sc3 = 1.2}, "angelspetrochem")
build_icons("bi-biomass-conversion-lubricant", {it1 = "lubricant", it3 = "bi-biomass", sc1 = 1.3, sh1 = {0,8}, sc3 = 1.2}, "angelspetrochem")
build_icons("bi-biomass-conversion-sulfuric-acid", {it1 = "liquid-sulfuric-acid", it3 = "bi-biomass", sc1 = 0.9, sc3 = 1.2}, "angelspetrochem")
build_icons("bi-biomass-conversion-light-oil", {it1 = "liquid-fuel-oil", it3 = "bi-biomass", sc3 = 1.2, it6 = "cellulose", sc6 = 0.7, sh = {-5,5}}, "angelspetrochem")
build_icons("bi-sulfur", {it1 = "sulfur", it2 = "ash", it3 = "liquid-sulfuric-acid", sc3 = 0.6}, "angelspetrochem")
build_icons("bi-solid-fuel", {it1 = "solid-fuel", it6 = "wood-bricks", sc6 = 0.7, sh6 = {-8,8}}, "angelspetrochem")
build_icons("solid-fuel-from-tar", {it1 = "solid-fuel", it6 = "tar", sc6 = 0.7, sh6 = {-8,8}}, "angelspetrochem")
build_icons("enriched-fuel-from-liquid-fuel", {it1 = "enriched-fuel", it6 = "liquid-fuel", sc6 = 0.7, sh6 = {-8,8}}, "angelspetrochem")
build_icons("solid-resin", {it1 = "resin", it2 = "liquid-resin"}, "angelspetrochem")
build_icons("bob-rubber", {it1 = "rubber", it2 = "resin", sh1 = {0,8}}, "angelspetrochem")
build_icons("solid-rubber", {it1 = "rubber", it2 = "liquid-rubber", sh1 = {0,8}}, "angelspetrochem")

--IndustrialRevolution
build_icons("bi-coal-1", {it1 = "coal"}, "IndustrialRevolution")
build_icons("bi-coal-2", {it1 = "coal", custom_topright = BioInd.iconpath .. "signal/bi_signal_plus.png"}, "IndustrialRevolution")
build_icons("bi-wood-gasification", {it5 = "tar", it4 = "petroleum-gas", it7 = "wood"}, "IndustrialRevolution")

--pycoalprocessing
build_icons("coaldust-ash", {it1 = "ash"}, "pycoalprocessing")
build_icons("fluegas-filtration", {it1 = "ash"}, "pycoalprocessing")

--changes recipe position in menu based on installed mod
--args ("mod that makes the change", "recipe to move", "New Subgroup", "New Order (1987)")
local function change_sub(_mod, _recipe, _subgroup, _order)
  local recipe = recipes[_recipe] or nil
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

change_sub("IndustrialRevolution", "bi-wooden-fence", "ir2-walls", "c1")
change_sub("IndustrialRevolution", "bi-battery", "ir2-vessels", "bab")
change_sub("IndustrialRevolution", "bi-plastic-1", "fluid-recipes", "zzza1")
change_sub("IndustrialRevolution", "bi-plastic-2", "fluid-recipes", "zzza2")
change_sub("IndustrialRevolution", "bi-solid-fuel", "ir2-fuels", "c1")
change_sub("IndustrialRevolution", "solid-fuel-from-tar", "ir2-fuels", "c2")
change_sub("IndustrialRevolution", "bi-sulfur", "fluid-recipes", "z1-la-zz")

--args ("mod that disables recipe", "recipe to remove", "check that this recipe exists before removing")
local function disable_recipe(_mod, _reciperemoved, _recipecheck)
  _reciperemoved = data.raw.recipe[_reciperemoved] or nil
  if _recipecheck then
    _recipecheck = data.raw.recipe[_recipecheck] or nil
  else
    _recipecheck = "nocheck"
  end
  if _reciperemoved and _recipecheck then
    --~ _reciperemoved.enabled = false
    --~ _reciperemoved.hidden = true
    --~ if _reciperemoved.normal then
      --~ _reciperemoved.normal.enabled = false
      --~ _reciperemoved.normal.hidden = true
    --~ end
    --~ if _reciperemoved.expensive then
      --~ _reciperemoved.expensive.enabled = false
      --~ _reciperemoved.expensive.hidden = true
    --~ end
    thxbob.lib.recipe.set_enabled(_reciperemoved, false)
    thxbob.lib.recipe.set_hidden(_reciperemoved, true)
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

disable_recipe("IndustrialRevolution", "bi-production-science-pack", "production-science-pack")



--make wood recipe from krastorio 100* slower to encorage using our more complete system
if mods["Krastorio2"] then
  if recipes["kr-grow-wood-plus"] then
    recipes["kr-grow-wood-plus"].energy_required = 600
  end
  if recipes["kr-grow-wood-with-water"] then
    recipes["kr-grow-wood-with-water"].energy_required = 600
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
