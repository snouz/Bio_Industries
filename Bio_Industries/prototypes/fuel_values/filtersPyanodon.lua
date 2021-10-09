------------------------------------------------------------------------------------
--                                 Pyanodon's mods                                --
------------------------------------------------------------------------------------
if not BioInd.check_mods({
  "pyalienlife",
  "pycoalprocessing",
  "pyfusionenergy",
  "pyhightech",
  "pyindustry",
  "pypetroleumhandling",
  "pyrawores",
}) then
  BioInd.debugging.nothing_to_do("*")
  -- require("file") will return true unless the file returns a value ~= nil
  return {}
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




-- Dictionary of item.name and item.type
local blacklist_items = {
  ["abacus"] = "item",
  ["adaptable-automucosa"] = "item",
  ["adrenal-cortex"] = "item",
  ["alien-enzymes"] = "item",
  ["alien-sample-02"] = "item",
  ["alien-sample-03"] = "item",
  ["alien-sample01"] = "item",
  ["anabolic-rna"] = "item",
  ["antelope-codex"] = "item",
  ["barrel-milk"] = "item",
  ["biomimetic-skin"] = "item",
  ["bio-sample01"] = "item",
  ["blanket-chassi"] = "item",
  ["bmp"] = "item",
  ["cage-antelope"] = "item",
  ["caravan"] = "item-with-entity-data",
  ["charged-auog"] = "item",
  ["charged-dingrit"] = "item",
  ["chimeric-proteins"] = "item",
  ["cognition-osteochain"] = "item",
  ["coil-core"] = "item",
  ["cottongut"] = "item",
  ["dingrit-spike"] = "item",
  ["dna-polymerase"] = "item",
  ["dried-grods"] = "item",
  ["dried-meat"] = "item",
  ["energy-drink"] = "capsule",
  ["enzyme-pks"] = "item",
  ["equipment-chassi"] = "item",
  ["fat-cottongut"] = "item",
  ["fat-dhilmos"] = "item",
  ["fat-trits"] = "item",
  ["fat-vonix"] = "item",
  ["fat-zipir"] = "item",
  ["filled-comb"] = "item",
  ["filled-methanol-gas-canister"] = "item",
  ["filled-proto-tholins-vessel"] = "item",
  ["filled-tholins-vessel"] = "item",
  ["fish-egg"] = "item",
  ["fish-food-01"] = "item",
  ["fish-food-02"] = "item",
  ["gas-bladder"] = "item",
  ["geostabilization-tissue"] = "item",
  ["gh"] = "item",
  ["glandular-myocluster"] = "item",
  ["green-sic"] = "item",
  ["ground-sample01"] = "item",
  ["guano"]     = "item",
  ["guar-gum"] = "item",
  ["guar-gum-plantation"] = "item",
  ["guar-seeds"] = "item",
  ["guts"] = "item",
  ["hmas"] = "item",
  ["honeycomb"] = "item",
  ["hormonal"]  = "item",
  ["hot-air-caged-simik"] = "item",
  ["hot-stone-brick"] = "item",
  ["immunosupressants"] = "item",
  ["intestinal-ee"] = "item",
  ["keratin"]   = "item",
  ["keratin-caged-simik"]       = "item",
  ["kerogen"]   = "item",
  ["laboratory-grown-brain"] = "item",
  ["latex"]     = "item",
  ["lcc"]     = "item",
  ["lens"]      = "item",
  ["lignin"]    = "item",
  ["manure"] = "item",
  ["meat"]      = "item",
  ["megadar"]   = "item",
  ["melamine-resin"]   = "item",
  ["microcin-j25"] = "item",
  ["mmp"] = "item",
  ["mold"]      = "item",
  ["moss-gen"] = "item",
  ["nenbit-matrix"] = "item",
  ["neuromorphic-chip"] = "item",
  ["nonconductive-phazogen"] = "item",
  ["nuka-caravan"] = "item-with-entity-data",
  ["organics"] = "item",
  ["pacifastin"]        = "item",
  ["paragen"]   = "item",
  ["pelt"]      = "item",
  ["peptidase-m58"]     = "item",
  ["perfect-samples"] = "item",
  ["pesticide-mk01"] = "item",
  ["pesticide-mk02"] = "item",
  ["petri-dish"] = "item",
  ["petri-dish-bacteria"] = "item",
  ["pheromones"]        = "item",
  ["photophore"]        = "item",
  ["pineal-gland"]      = "item",
  ["plasmids"] = "item",
  ["polynuclear-ganglion"] = "item",
  ["ppd"] = "item",
  ["primers"] = "item",
  ["propeptides"]       = "item",
  ["purine-analogues"] = "item",
  ["qaavi"]     = "item-with-entity-data",
  ["ralesia"]   = "item",
  ["resveratrol"] = "item",
  ["retrovirus"] = "item",
  ["salt"]      = "item",
  ["saps"]      = "item",
  ["scafold-free-bones"]      = "item",
  ["skin"]      = "item",
  ["snarer-heart"] = "item",
  ["solidified-sarcorus"] = "item",
  ["space"]     = "item",
  ["space-suit"]        = "item",
  ["sporopollenin"]     = "item",
  ["starch"]    = "item",
  ["sternite-lung"] = "item",
  ["strangelets"] = "item",
  ["strorix-unknown-sample"] = "item",
  ["subdermal-chemosnare"] = "item",
  ["sugar"]     = "item",
  ["sulfuric-xeno"] = "item",
  ["tendon"]    = "item",
  ["tinned-cable"]    = "item",
  ["tissue-engineered-fat"] = "item",
  ["vat-brain"] = "item",
  ["venon-gland"] = "item",
  ["zymogens"] = "item",
  ["zipir"] = "item",

  --~ ["py-local-radar"] = "item",
  ["drp"] = "item",
  ["electric-furnace"] = "item",
  ["flyavan"] = "item-with-entity-data",
  ["guano"]   = "item",
  ["py-burner"] = "item",
  ["py-check-valve"] = "item",
  ["py-coal-tile"] = "item",
  ["py-deposit-active-provider"] = "item",
  ["py-deposit-basic"] = "item",
  ["py-deposit-buffer"] = "item",
  ["py-deposit-passive-provider"] = "item",
  ["py-deposit-requester"] = "item",
  ["py-deposit-storage"] = "item",
  ["py-gas-vent"] = "item",
  ["py-heat-exchanger"] = "item",
  ["py-overflow-valve"] = "item",
  ["py-shed-active-provider"] = "item",
  ["py-shed-basic"] = "item",
  ["py-shed-buffer"] = "item",
  ["py-shed-passive-provider"] = "item",
  ["py-shed-requester"] = "item",
  ["py-shed-storage"] = "item",
  ["py-sinkhole"] = "item",
  --~ ["py-tank-1000"] = "item",
  --~ ["py-tank-10000"] = "item",
  --~ ["py-tank-1500"] = "item",
  --~ ["py-tank-3000"] = "item",
  --~ ["py-tank-4000"] = "item",
  --~ ["py-tank-5000"] = "item",
  --~ ["py-tank-6500"] = "item",
  --~ ["py-tank-7000"] = "item",
  --~ ["py-tank-8000"] = "item",
  --~ ["py-tank-9000"] = "item",
  ["py-turbine"] = "item",
  ["py-underflow-valve"] = "item",
  ["pydrive"] = "item",
  ["rectisol"] = "item",

  -- Furnaces
  ["bof"] = "item",
  ["eaf"] = "item",
  ["hpf"] = "item",


  ["20-u-powder"] = "item",
  ["40-u-powder"] = "item",
  ["70-u-powder"] = "item",
  ["active-carbon"]     = "item",
  ["adam42-gen"]        = "item",
  ["agar"]      = "item",
  ["albumin"]   = "item",
  ["alumina"] = "item",
  ["ammonium-chloride"] = "item",
  ["antitumor"] = "item",
  ["antiviral"] = "item",
  ["aramid"]    = "item",
  ["biofilm"]   = "item",
  ["biomass"]   = "item",
  ["blanket"]   = "item",
  ["bolts"]     = "item",
  ["bonemeal"]  = "item",
  ["bones"]     = "item",
  ["brain"]     = "item",
  ["cage"]      = "item",
  ["capsule"]   = "item",
  ["carapace"]  = "item",
  ["carbon-black"]      = "item",
  ["carbon-filter"]     = "item",
  ["carbon-filter-mk02"]        = "item",
  ["carbon-filter-mk03"]        = "item",
  ["carbon-filter-mk04"]        = "item",
  ["casein"]    = "item",
  ["cbp"]       = "item",
  ["cdna"]      = "item",
  ["chitin"]    = "item",
  ["chitosan"]  = "item",
  ["cladding"]  = "item",
  ["co2-absorber"] = "item",
  ["coal"]      = "item",
  ["coal-mine"] = "item",
  ["coarse"]    = "item",
  ["coated-container"] = "item",
  ["cocoon"]    = "item",
  ["crawdad"]   = "item-with-entity-data",
  ["cryogland"] = "item",
  ["cysteine"]  = "item",
  ["cytostatics"]       = "item",
  ["denatured-seismite"]        = "item",
  ["destablilized-toxirus"]     = "item",
  ["dimensional-gastricorg"]    = "item",
  ["dingrido"]  = "item-with-entity-data",
  ["divertor"]  = "item",
  ["dried-meat"]        = "capsule",
  ["fur"]       = "item",
  ["hidden-beacon"] = "item",
  ["in-vitro-meat"]     = "item",
  ["mosfet"]    = "item",
  ["nanochondria"]      = "item",
  ["nanofibrils"]       = "item",
  ["nuclear-sample"] = "item",
  ["ocula"]     = "item-with-entity-data",
  ["orexigenic"]        = "item",
  ["quartz-tube"]       = "item",
  ["reca"] = "item",
  ["recombinant-ery"] = "item",
  ["reinforced-wall-shield"] = "item",
  ["rich-clay"] = "item",
  ["rich-dust"] = "item",
  ["salt-mine"] = "item",
  ["sample-cup"] = "item",
  ["serine"]    = "item",
  ["soil"]      = "item",
  ["solder"]    = "item",
  ["soot"] = "item",
  ["wall-shield"] = "item",
  ["warm-stone-brick"] = "item",
  ["warmer-stone-brick"] = "item",

  ["coal-briquette"] = "item",
  ["coal-dust"] = "item",
  ["coarse-coal"] = "item",
  ["coke"] = "item",
  ["redhot-coke"] = "item",



  ["ceramic" ] = "item",
  ["cermet" ] = "item",

  ["antimatter" ] = "item",
  ["b2o3-dust"] = "item",
  ["bakelite" ] = "item",
  ["biopolymer" ] = "item",
  ["bisphenol-a" ] = "item",
  ["borax"]     = "item",
  ["boron"]     = "item",
  ["calcinates"]        = "item",
  ["chlorinated-water"] = "item",
  ["chromite-sand"]     = "item",
  ["chromium"] = "item",
  ["clay"] = "item",
  ["collagen"] = "item",
  ["diamond"]   = "item",
  ["diamond-reject"] = "item",
  ["duralumin"] = "item",
  ["dynemicin"] = "item",
  ["enediyne"]  = "item",
  ["epoxy" ] = "item",
  ["ferrite"] = "item",
  ["fiber" ] = "item",
  ["fiberboard" ] = "item",
  ["fiberglass" ] = "item",
  ["formica" ] = "item",
  ["glass"]     = "item",
  ["grade-1-u"] = "item",
  ["grade-2-u"] = "item",
  ["graphene" ] = "item",
  ["graphite" ] = "item",
  ["gravel"]    = "item",
  ["high-tin-concentrate"] = "item",
  ["high-tin-mix"] = "item",
  ["hyaline"]   = "item",
  ["kevlar"]    = "item",
  ["kevlar-coating"] = "item",
  ["latex-slab"] = "item",
  ["lime"] = "item",
  ["limestone"] = "item",
  ["lithium-chloride" ] = "item",
  ["lithium-niobate" ] = "item",
  ["lithium-peroxide"] = "item",
  ["low-grade-rejects"] = "item",
  ["magnetic-beads"] = "item",
  ["magnetic-core"] = "item",
  ["magnetic-organ"] = "item",
  ["metallic-glass"] = "item",
  ["methyl-acrylate"] = "item",
  ["mixed-ores"] = "item",
  ["myoglobin" ] = "item",
  ["ndfeb-powder" ] = "item",
  ["nems" ] = "item",
  ["nano-cellulose"] = "item",
  ["negasium"] = "item",
  ["nichrome"] = "item",
  ["nisi"]      = "item",
  ["nylon" ] = "item",
  ["oil-sand"] = "item",
  ["optical-fiber"] = "item",
  ["p2s5"]      = "item",
  ["pdms" ] = "item",
  ["phenol" ] = "item",
  ["py-aluminium"] = "item",
  ["py-asphalt"] = "item",
  ["py-limestone"] = "item",
  ["py-nexelit"] = "item",
  ["pyphoon-bay"] = "item",
  ["pyrite"]    = "item",
  ["rayon" ] = "item",
  ["sic"]       = "item",
  ["silicon" ] = "item",
  ["sl-concentrate"] = "item",
  ["sncr-alloy"] = "item",
  ["super-alloy"] = "item",
  ["tailings-dust"] = "item",
  ["tailings-pond"] = "item",
  ["ticl4"]     = "item",
  ["urea" ] = "item",
  ["vanadium-oxide"] = "item",
  ["yellow-cake"] = "item",

  ["ag-biomass"] = "item",
  ["agzn-alloy"] = "item",
  ["al-biomass"] = "item",
  ["au-biomass"] = "item",
  ["co-biomass"] = "item",
  ["cu-biomass"] = "item",
  ["dried-biomass"] = "item",
  ["fe-biomass"] = "item",
  ["nacl-biomass"] = "item",
  ["nb-biomass"] = "item",
  ["ni-biomass"] = "item",
  ["pb-biomass"] = "item",
  ["powdered-biomass"] = "item",
  ["s-biomass"] = "item",
  ["sn-biomass"] = "item",
  ["ti-biomass"] = "item",
  ["zn-biomass"] = "item",

  ["rhe"] = "item",

}

local blacklist_patterns = {

  -- PyAlienLife
  "^.+%-rennea%-seeds.+",
  "^arqad%-.+",
  "^arthurian%-.+",
  "^auog%-.+",
  "^bhoddos%-.+",
  "^blood%-.+",
  "^bone%-.+",
  "^brain%-.+",
  "^cadaveric%-.+",
  "^caged%-.+",
  "^chitin%-.+",
  "^cocoon%-.+",
  "^cottongut%-.+",
  "^cracker%-.+",
  "^creature%-chamber%-.+",
  "^cridren%-.+",
  "^dhilmos%-.+",
  "^dingrits%-.+",
  "^earth%-.+%-sample",
  "^fat%-caged%-.+",
  "^fawogae%-.+",
  "^fungal%-substrate.*",
  "^grods%-.+",
  "^grod%-.+",
  "^guts%-.+",
  "^kicalk%-.+",
  "^kmauts%-.+",
  "^korlex%-.+",
  ".*%-*meat%-.+",
  ".*%-*meat$",
  "^moondrop%-.+",
  "^mukmoux%-.+",
  "^navens%-.+",
  "^phadai%-.+",
  "^phagnot%-.+",
  "^ralesia%-.+",
  "^rennea%-.+",
  "^replicator%-.+",
  "^sap%-.+",
  "^scrondrix%-.+",
  "^sea%-sponge%-.+",
  "^seaweed%-.+",
  "^simik%-.+",
  "^skin%-.+",
  "^space%-dingrit.*",
  "^sponge%-.+",
  "^spore%-.+",
  "^trits%-.+",
  "^tuuphra%-.+",
  "^ulric%-.+",
  "^used%-.+",
  "^vonix%-.+",
  "^vrauks%-.+",
  "^xeno%-.+",
  "^xenopen%-.+",
  "^xyhiphoe%-.+",
  "^yaedols%-.+",
  "^yotoi%-.+",
  "^zipir%-.+",

  "^py%-.+%-robot%-%d+",


  ".+%-core$",
  "^clean%-.+",
  "^crude%-.+",
  "^crushed%-.+",
  "^dry%-.+",
  "^empty%-.+",
  "^fiber%-.+",
  "^fine%-.+",
  "^fuelrod%-.+",
  "^heavy%-.+",
  "^light%-.+",
  "^powdered%-.+",
  "^processed%-.+",
  "^pure%-.+",
  "^purified%-.+",
  "^raw%-.+",
  "^reduced%-.+",
  "^rich%-.+",
  "^sintered%-.+",



  "^alumina%-.+",
  ".+%-alumina%-.+",
  ".+%-alumina$",
  "^borax%-.+",
  ".+%-borax%-.+",
  ".+%-borax$",
  "^boron%-.+",
  ".+%-boron%-.+",
  ".+%-boron$",
  "^brass%-.+",
  ".+%-brass%-.+",
  ".+%-brass$",
  "^carbon%-.+",
  ".+%-carbon%-.+",
  ".+%-carbon$",
  "^calcium%-.+",
  ".+%-calcium%-.+",
  ".+%-calcium$",
  "^chromite%-.+",
  ".+%-chromite%-.+",
  ".+%-chromite$",
  "^cobalt%-.+",
  ".+%-cobalt%-.+",
  ".+%-cobalt$",
  ".*%-*diamond",
  "^graphene%-.+",
  ".+%-graphene%-.+",
  ".+%-graphene$",
  "^gold%-.+",
  ".+%-gold%-.+",
  ".+%-gold$",
  "^kimberlite%-.+",
  ".+%-kimberlite%-.+",
  ".+%-kimberlite$",
  "^lead%-.+",
  ".+%-lead%-.+",
  ".+%-lead$",
  "^molybdenite%-.+",
  ".+%-molybdenite%-.+",
  ".+%-molybdenite$",
  "^molybdenum%-.+",
  ".+%-molybdenum%-.+",
  ".+%-molybdenum$",
  "^nbfe%-.+",
  ".+%-nbfe%-.+",
  ".+%-nbfe$",
  "^nexelit%-.+",
  ".+%-nexelit%-.+",
  ".+%-nexelit$",
  "^nickel%-.+",
  ".+%-nickel%-.+",
  ".+%-nickel$",
  "^niobium%-.+",
  ".+%-niobium%-.+",
  ".+%-niobium$",
  "^quartz%-.+",
  ".+%-quartz%-.+",
  ".+%-quartz$",
  "^phosphate%-.+",
  ".+%-phosphate%-.+",
  ".+%-phosphate$",
  "^regolite%-.+",
  ".+%-regolite%-.+",
  ".+%-regolite$",
  "^sand%-.+",
  ".+%-sand%-.+",
  ".+%-sand$",
  "^silica%-.+",
  ".+%-silica%-.+",
  ".+%-silica$",
  "^silver%-.+",
  ".+%-silver%-.+",
  ".+%-silver$",
  "^sodium%-.+",
  ".+%-sodium%-.+",
  ".+%-sodium$",
  "^ti%-.+",
  ".+%-ti%-.+",
  ".+%-ti$",
  "^ti%-powder%-.+",
  ".+%-ti%-powder%-.+",
  ".+%-ti%-powder$",
  "^tin%-.+",
  ".+%-tin%-.+",
  ".+%-tin$",
  "^zinc%-.+",
  ".+%-zinc%-.+",
  ".+%-zinc$",

  "^pcb%d+.*",
  "^sc%-.+",

  ".+%-alloy$",
  ".+%-concentrate$",
  ".+%-dust$",
  ".+%-rejects$",
  ".+%-residue$",

  -- Entities
  ".+%-ht$",
  "^ht%-.+$",
  ".+%-mine$",
  --~ ".+%-mk%d+",
  ".+mk%d+$",
  ".*nuclear.*",
  "^py%-tank%-%d+",

}

local whitelist_items = {}

local whitelist_patterns = {}

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return {
  blacklist_items = blacklist_items or {},
  whitelist_items = whitelist_items or {},
  blacklist_patterns = blacklist_patterns or {},
  whitelist_patterns = whitelist_patterns or {},
}
