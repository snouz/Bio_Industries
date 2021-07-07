BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local items = data.raw.item
local recipes = data.raw.recipe


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

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
if data.raw.recipe["bi-logs-2"] then data.raw.recipe["bi-logs-2"].icons = BioInd.make_icons({it4 = "woodpulp", it5 = "wood", it2 = "ash"}) end
if data.raw.recipe["bi-logs-3"] then data.raw.recipe["bi-logs-3"].icons = BioInd.make_icons({it4 = "woodpulp", it5 = "wood", custom_topright = BioInd.iconpath .. "signal/bi_signal_fert.png"}) end
if data.raw.recipe["bi-logs-4"] then data.raw.recipe["bi-logs-4"].icons = BioInd.make_icons({it4 = "woodpulp", it5 = "wood", custom_topright = BioInd.iconpath .. "signal/bi_signal_adv_fert.png"}) end
if data.raw.recipe["bi-ash-1"] then data.raw.recipe["bi-ash-1"].icons = BioInd.make_icons({it1 = "ash", it2 = "woodpulp"}) end
if data.raw.recipe["bi-ash-2"] then data.raw.recipe["bi-ash-2"].icons = BioInd.make_icons({it1 = "ash", it2 = "wood"}) end
if data.raw.recipe["bi-stone-brick"] then data.raw.recipe["bi-stone-brick"].icons = BioInd.make_icons({it1 = "stone-brick", it2 = "ash", it3 = "stone-crushed"}) end
if data.raw.recipe["bi-biomass-1"] then data.raw.recipe["bi-biomass-1"].icons = BioInd.make_icons({it1 = "biomass" }) end
if data.raw.recipe["bi-biomass-2"] then data.raw.recipe["bi-biomass-2"].icons = BioInd.make_icons({it1 = "biomass", customunder = BioInd.iconpath .. "signal/bi_signal_reprocess.png" }) end
if data.raw.recipe["bi-biomass-3"] then data.raw.recipe["bi-biomass-3"].icons = BioInd.make_icons({it1 = "biomass", customunder = BioInd.iconpath .. "signal/bi_signal_reprocess.png", it2 = "ash" }) end
if data.raw.recipe["bi-sulfur"] then data.raw.recipe["bi-sulfur"].icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid"}) end
if data.raw.recipe["bi-press-wood"] then data.raw.recipe["bi-press-wood"].icons = BioInd.make_icons({it1 = "wooden-board", it2 = "woodpulp", it3 = "resin"}) end
if data.raw.recipe["bi-wood-fuel-brick"] then data.raw.recipe["bi-wood-fuel-brick"].icons = BioInd.make_icons({it1 = "wood-bricks"}) end
if data.raw.recipe["bi-sand"] then data.raw.recipe["bi-sand"].icons = BioInd.make_icons({it1 = "sand", it2 = "stone-crushed"}) end
  if mods["angelsrefining"] then if data.raw.recipe["bi-sand"] then data.raw.recipe["bi-sand"].icons = BioInd.make_icons({it1 = "solid-sand", it2 = "stone-crushed"}) end end
if data.raw.recipe["bi-basic-gas-processing"] then data.raw.recipe["bi-basic-gas-processing"].icons = BioInd.make_icons({it4 = "ash", it5 = "petroleum-gas", sh4 = {0,-16}, sh5 = {0,16} }) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-basic-gas-processing"] then data.raw.recipe["bi-basic-gas-processing"].icons = BioInd.make_icons({it1 = "gas-methane", sc1 = 0.7, it6 = "ash", sc6 = 0.7}) end end
if data.raw.recipe["bi-crushed-stone-stone"] then data.raw.recipe["bi-crushed-stone-stone"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "stone"}) end
if data.raw.recipe["bi-crushed-stone-stone-brick"] then data.raw.recipe["bi-crushed-stone-stone-brick"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "stone-brick"}) end
if data.raw.recipe["bi-crushed-stone-concrete"] then data.raw.recipe["bi-crushed-stone-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "concrete"}) end
if data.raw.recipe["bi-crushed-stone-hazard-concrete"] then data.raw.recipe["bi-crushed-stone-hazard-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "hazard-concrete"}) end
if data.raw.recipe["bi-crushed-stone-refined-concrete"] then data.raw.recipe["bi-crushed-stone-refined-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "refined-concrete"}) end
if data.raw.recipe["bi-crushed-stone-refined-hazard-concrete"] then data.raw.recipe["bi-crushed-stone-refined-hazard-concrete"].icons = BioInd.make_icons({it1 = "stone-crushed", it2 = "hazard-concrete"}) end
if data.raw.recipe["bi-rubber"] then data.raw.recipe["bi-rubber"].icons = BioInd.make_icons({it1 = "rubber"}) end
if data.raw.recipe["bi-coke-coal"] then data.raw.recipe["bi-coke-coal"].icons = BioInd.make_icons({it1 = "pellet-coke", it2 = data.raw.recipe["bi-coke-coal"].ingredients[1].name}) end
if data.raw.recipe["bi-pellet-coke"] then data.raw.recipe["bi-pellet-coke"].icons = BioInd.make_icons({it1 = "pellet-coke", it2 = data.raw.recipe["bi-pellet-coke"].ingredients[1].name}) end
if data.raw.recipe["bi-pellet-coke-2"] then data.raw.recipe["bi-pellet-coke-2"].icons = BioInd.make_icons({it1 = "pellet-coke", it2 = data.raw.recipe["bi-pellet-coke-2"].ingredients[1].name}) end
if data.raw.recipe["cellulose_1"] then data.raw.recipe["cellulose_1"].icons = BioInd.make_icons({it1 = "cellulose"}) end
if data.raw.recipe["cellulose_2"] then data.raw.recipe["cellulose_2"].icons = BioInd.make_icons({it1 = "cellulose", it2 = "steam"}) end
if data.raw.recipe["bi-plastic-1"] then data.raw.recipe["bi-plastic-1"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "light-oil", it3 = "woodpulp"}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-plastic-1"] then data.raw.recipe["bi-plastic-1"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "liquid-fuel-oil", it3 = "woodpulp", sc2 = 0.5, sc3 = 0.5}) end end
if data.raw.recipe["bi-plastic-2"] then data.raw.recipe["bi-plastic-2"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "cellulose", it3 = "petroleum-gas"}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-plastic-2"] then data.raw.recipe["bi-plastic-2"].icons = BioInd.make_icons({it1 = "plastic-bar", it2 = "cellulose", it3 = "gas-methane", sc2 = 0.5, sc3 = 0.5}) end end
if data.raw.recipe["bi-wood-gasification"] then data.raw.recipe["bi-wood-gasification"].icons = BioInd.make_icons({it5 = "tar", it4 = "petroleum-gas", sc4 = 0.8}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-wood-gasification"] then data.raw.recipe["bi-wood-gasification"].icons = BioInd.make_icons({it5 = "tar", it4 = "gas-methane"}) end end
if data.raw.recipe["solid-fuel-from-tar"] then data.raw.recipe["solid-fuel-from-tar"].icons = BioInd.make_icons({it1 = "solid-fuel", it3 = "tar"}) end
if data.raw.recipe["bi-solid-fuel"] then data.raw.recipe["bi-solid-fuel"].icons = BioInd.make_icons({it1 = "solid-fuel", it3 = "wood-bricks"}) end
if data.raw.recipe["bi-biomass-conversion-crude-oil"] then data.raw.recipe["bi-biomass-conversion-crude-oil"].icons = BioInd.make_icons({it1 = "crude-oil", it3 = "biomass", sc3 = 1.4}) end
if data.raw.recipe["bi-biomass-conversion-petroleum"] then data.raw.recipe["bi-biomass-conversion-petroleum"].icons = BioInd.make_icons({it1 = "petroleum-gas", it3 = "biomass", sc3 = 1.4}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-petroleum"] then data.raw.recipe["bi-biomass-conversion-petroleum"].icons = BioInd.make_icons({it1 = "gas-methane", it3 = "biomass", sc3 = 1.4}) end end
if data.raw.recipe["bi-biomass-conversion-lubricant"] then data.raw.recipe["bi-biomass-conversion-lubricant"].icons = BioInd.make_icons({it1 = "lubricant", it3 = "biomass", sc3 = 1.4}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-lubricant"] then data.raw.recipe["bi-biomass-conversion-lubricant"].icons = BioInd.make_icons({it1 = "lubricant", it3 = "biomass", sc3 = 1.4}) end end
if data.raw.recipe["bi-biomass-conversion-sulfuric-acid"] then data.raw.recipe["bi-biomass-conversion-sulfuric-acid"].icons = BioInd.make_icons({it1 = "sulfuric-acid", it3 = "biomass", sc3 = 1.4}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-sulfuric-acid"] then data.raw.recipe["bi-biomass-conversion-sulfuric-acid"].icons = BioInd.make_icons({it1 = "liquid-sulfuric-acid", it3 = "biomass", sc3 = 1.4}) end end
if data.raw.recipe["bi-biomass-conversion-light-oil"] then data.raw.recipe["bi-biomass-conversion-light-oil"].icons = BioInd.make_icons({it1 = "light-oil", it3 = "biomass", sc3 = 1.4}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-biomass-conversion-light-oil"] then data.raw.recipe["bi-biomass-conversion-light-oil"].icons = BioInd.make_icons({it1 = "liquid-fuel-oil", it3 = "biomass", sc3 = 1.4}) end end
if data.raw.recipe["bi-charcoal-1"] then data.raw.recipe["bi-charcoal-1"].icons = BioInd.make_icons({it1 = "wood-charcoal", it2 = "woodpulp"}) end
if data.raw.recipe["bi-charcoal-2"] then data.raw.recipe["bi-charcoal-2"].icons = BioInd.make_icons({it1 = "wood-charcoal", it2 = "wood"}) end
if data.raw.recipe["bi-sulfur"] then data.raw.recipe["bi-sulfur"].icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "sulfuric-acid"}) end
  if mods["angelspetrochem"] then if data.raw.recipe["bi-sulfur"] then data.raw.recipe["bi-sulfur"].icons = BioInd.make_icons({it1 = "sulfur", it2 = "ash", it3 = "liquid-sulfuric-acid", sc3 = 0.6}) end end
if data.raw.recipe["bi-battery"] then data.raw.recipe["bi-battery"].icons = BioInd.make_icons({it1 = "battery", it3 = "biomass"}) end
if data.raw.recipe["bi-woodpulp"] then data.raw.recipe["bi-woodpulp"].icons = BioInd.make_icons({it1 = "woodpulp"}) end
if data.raw.recipe["bi-fertilizer-2"] then data.raw.recipe["bi-fertilizer-2"].icons = BioInd.make_icons({it1 = "fertilizer", it2 = data.raw.recipe["bi-fertilizer-2"].ingredients[2].name }) end
if data.raw.recipe["bi-mineralized-sulfuric-waste"] then data.raw.recipe["bi-mineralized-sulfuric-waste"].icons = BioInd.make_icons({it1 = "water-mineralized", it6 = "water-yellow-waste", sc6 = 0.5, sh6 = {-4,4}}) end
if data.raw.recipe["bi-slag-slurry"] then data.raw.recipe["bi-slag-slurry"].icons = BioInd.make_icons({it1 = "slag-slurry", sh1 = {0,8}, it2 = "water-saline", sc2 = 0.4, it3 = "stone-crushed", sc3 = 0.4}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end
--if data.raw.recipe[""] then data.raw.recipe[""].icons = BioInd.make_icons({it1 = "", it2 = "", it3 = ""}) end



------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
