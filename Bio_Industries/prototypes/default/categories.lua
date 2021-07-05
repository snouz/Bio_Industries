BioInd.entered_file()

BI.default_item_group           = BI.default_item_group or {}
BI.default_item_subgroup        = BI.default_item_subgroup or {}
BI.default_recipe_categories    = BI.default_recipe_categories or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.techiconpath


------------------------------------------------------------------------------------
--                                   Item group                                   --
------------------------------------------------------------------------------------
BI.default_item_group.bio_industries = {
  type = "item-group",
  name = "bio-industries",
  order = "vaa-a",
  inventory_order = "v-a",
  icon = ICONPATH .. "BioIndustries_itemgroup.png",
  icon_size = 128, icon_mipmaps = 4,
  BI_add_icon = true
}


------------------------------------------------------------------------------------
--                            Item subgroups: Bio farm                            --
------------------------------------------------------------------------------------
-- Bio farm and Bio nursery
BI.default_item_subgroup.biofarm = {
  type = "item-subgroup",
  name = "bio-production-machine",
  group = "production",
  order = "e-1",
}

-- Raw materials
BI.default_item_subgroup.bio_farm_raw = {
  type = "item-subgroup",
  name = "bio-bio-farm-raw",
  group = "bio-industries",
  order = "b-a",
}

-- Intermediate products
BI.default_item_subgroup.bio_farm_intermediate_product = {
  type = "item-subgroup",
  name = "bio-bio-farm-intermediate-product",
  group = "bio-industries",
  order = "c-a",
}

-- Fluids
BI.default_item_subgroup.biofarm_fluid_1 = {
  type = "item-subgroup",
  name = "bio-bio-farm-fluid-1",
  group = "bio-industries",
  order = "a-a",
}

BI.default_item_subgroup.biofarm_fluid_2 = {
  type = "item-subgroup",
  name = "bio-bio-farm-fluid-2",
  group = "bio-industries",
  order = "a-b",
}

BI.default_item_subgroup.biofarm_fluid_3 = {
  type = "item-subgroup",
  name = "bio-bio-farm-fluid-3",
  group = "bio-industries",
  order = "a-c",
}

--~ -- Fluid entities
--~ BI.default_item_subgroup.biofarm_fluid_entity = {
  --~ type = "item-subgroup",
  --~ name = "bio-bio-farm-fluid-entity",
  --~ group = "bio-industries",
  --~ order = "a-d",
--~ }


------------------------------------------------------------------------------------
--                             Item subgroups: Cokery                             --
------------------------------------------------------------------------------------
BI.default_item_subgroup.cokery = {
  type = "item-subgroup",
  name = "bio-cokery",
  group = "bio-industries",
  order = "b-b",
}


------------------------------------------------------------------------------------
--                      Item subgroups: Bio reactor/Bio mass                      --
------------------------------------------------------------------------------------
--- Bio Reactor and Bio-Mass
BI.default_item_subgroup.bio_fuel_fluid = {
  type = "item-subgroup",
  name = "bio-bio-fuel-fluid",
  group = "bio-industries",
  order = "d-a-1"
}

--~ BI.default_item_subgroup.bio_fuel_fluid_entity = {
  --~ type = "item-subgroup",
  --~ name = "bio-bio-fuel-fluid-entity",
  --~ group = "bio-industries",
  --~ order = "d-a-2"
--~ }


--~ ------------------------------------------------------------------------------------
--~ --                           Item subgroups: Production                           --
--~ ------------------------------------------------------------------------------------
--~ -- Tool
--~ BI.default_item_subgroup.tool = {
  --~ type = "item-subgroup",
  --~ name = "bio-tool",
  --~ group = "production",
  --~ order = "a-1",
--~ }


--~ ------------------------------------------------------------------------------------
--~ --                             Item subgroups: Energy                             --
--~ ------------------------------------------------------------------------------------
--~ -- Boiler
--~ BI.default_item_subgroup.energy_boiler = {
  --~ type = "item-subgroup",
  --~ name = "bio-energy-boiler",
  --~ group = "production",
  --~ order = "b-a"
--~ }

--~ -- Steam engine
--~ BI.default_item_subgroup.energy_steam_engine = {
  --~ type = "item-subgroup",
  --~ name = "bio-energy-steam-engine",
  --~ group = "production",
  --~ order = "b-b"
--~ }


--~ -- Extraction machine
--~ BI.default_item_subgroup.energy_steam_engine = {
  --~ type = "item-subgroup",
  --~ name = "bio-extraction-machine",
  --~ group = "production",
  --~ order = "c-a",
--~ }

--~ -- Pump
--~ BI.default_item_subgroup.energy_pump = {
  --~ type = "item-subgroup",
  --~ name = "bio-pump",
  --~ group = "production",
  --~ order = "c-b",
--~ }


--~ ------------------------------------------------------------------------------------
--~ --                            Item subgroups: Machines                            --
--~ ------------------------------------------------------------------------------------
--~ -- Smelting machine
--~ BI.default_item_subgroup.smelting_machine = {
  --~ type = "item-subgroup",
  --~ name = "bio-smelting-machine",
  --~ group = "production",
  --~ order = "d-a",
--~ }

--~ -- Smelting machine
--~ BI.default_item_subgroup.production_machine = {
  --~ type = "item-subgroup",
  --~ name = "bio-production-machine",
  --~ group = "production",
  --~ order = "e-a",
--~ }

--~ -- Assembling machine
--~ BI.default_item_subgroup.assembling_machine = {
  --~ type = "item-subgroup",
  --~ name = "bio-assembly-machine",
  --~ group = "production",
  --~ order = "e-b",
--~ }

--~ -- Chemical machine
--~ BI.default_item_subgroup.chemical_machine = {
  --~ type = "item-subgroup",
  --~ name = "bio-chemical-machine",
  --~ group = "production",
  --~ order = "e-c",
--~ }

--~ -- Smelting machine
--~ BI.default_item_subgroup.electrolyser_machine = {
  --~ type = "item-subgroup",
  --~ name = "bio-electrolyser-machine",
  --~ group = "production",
  --~ order = "e-d",
--~ }

--~ -- Refinery machine
--~ BI.default_item_subgroup.refinery_machine = {
  --~ type = "item-subgroup",
  --~ name = "bio-refinery-machine",
  --~ group = "production",
  --~ order = "e-e",
--~ }


------------------------------------------------------------------------------------
--                                Recipe categories                               --
------------------------------------------------------------------------------------

-- Terraformer (Arboretum)
BI.default_recipe_categories.arboretum = {
  type = "recipe-category",
  name = "bi-arboretum"
}

-- Bio farm
BI.default_recipe_categories.farm = {
  type = "recipe-category",
  name = "biofarm-mod-farm"
}

-- Bio reactor
BI.default_recipe_categories.bioreactor = {
  type = "recipe-category",
  name = "biofarm-mod-bioreactor"
}

-- Greenhouse
BI.default_recipe_categories.greenhouse = {
  type = "recipe-category",
  name = "biofarm-mod-greenhouse"
}

-- Depollution
BI.default_recipe_categories.clean_air = {
  type = "recipe-category",
  name = "clean-air"
}

-- Crushing
BI.default_recipe_categories.crushing = {
  type = "recipe-category",
  name = "biofarm-mod-crushing"
}

-- Smelting
BI.default_recipe_categories.smelting = {
  type = "recipe-category",
  name = "biofarm-mod-smelting"
}


------------------------------------------------------------------------------------
--                               Create item groups                               --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_item_group)


------------------------------------------------------------------------------------
--                              Create item subgroups                             --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_item_subgroup)


------------------------------------------------------------------------------------
--                            Create recipe categories                            --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_recipe_categories)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
