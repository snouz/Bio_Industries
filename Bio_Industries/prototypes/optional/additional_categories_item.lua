------------------------------------------------------------------------------------
--                Data for ammo-categories that depend on settings.               --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_categories = BI.additional_categories or {}

local settings = {
  "BI_Bio_Fuel",
  "BI_Bio_Garden",
  "BI_Disassemble",
  "BI_Solar_Additions",
  "BI_Stone_Crushing",
  "BI_Terraforming",
}
for s, setting in pairs(settings) do
  BI.additional_categories[setting] = BI.additional_categories[setting] or {}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.techiconpath


------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
--~ ---- Bio Fuel Solids
--~ BI.additional_categories.BI_Bio_Fuel.bio_fuel_solid = {
  --~ type = "item-subgroup",
  --~ name = "bio-bio-fuel-solid",
  --~ group = "bio-industries",
  --~ order = "e"
--~ }

---- Bio Fuel OTHER
BI.additional_categories.BI_Bio_Fuel.bio_fuel_other = {
  type = "item-subgroup",
  name = "bio-bio-fuel-other",
  group = "bio-industries",
  order = "f"
}


------------------------------------------------------------------------------------
--                               Enable: Bio gardens                              --
--                           (BI.Settings.BI_Bio_Garden)                          --
------------------------------------------------------------------------------------
-- Item subgroup for Bio garden fluids
BI.additional_categories.BI_Bio_Garden.bio_gardens_fluid = {
  type = "item-subgroup",
  name = "bio-bio-gardens-fluid",
  group = "bio-industries",
  order = "x-a"
}


------------------------------------------------------------------------------------
--                           Enable: Disassemble recipes                          --
--                          (BI.Settings.BI_Disassemble)                          --
------------------------------------------------------------------------------------
-- Item subgroup
BI.additional_categories.BI_Disassemble.disassemble = {
  type = "item-subgroup",
  name = "bio-disassemble",
  group = "bio-industries",
  order = "zzzz",
}


------------------------------------------------------------------------------------
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
-- Item subgroup for solar entities
BI.additional_categories.BI_Solar_Additions.solar_entity = {
  type = "item-subgroup",
  name = "bio-bio-solar-entity",
  group = "bio-industries",
  order = "a-solar",
}

-- Item subgroup for Solar panel
BI.additional_categories.BI_Solar_Additions.energy_solar_panel = {
  type = "item-subgroup",
  name = "bio-energy-solar-panel",
  group = "production",
  order = "b-c"
}

-- Item subgroup for Accumulator
BI.additional_categories.BI_Solar_Additions.energy_accumulator = {
  type = "item-subgroup",
  name = "bio-energy-accumulator",
  group = "production",
  order = "b-d"
}



--~ -- Arboretum fluid entities
--~ BI.default_item_subgroup.arboretum_fluid_entity = {
  --~ type = "item-subgroup",
  --~ name = "bio-arboretum-fluid-entity",
  --~ group = "bio-industries",
  --~ order = "w-d",
--~ }


------------------------------------------------------------------------------------
--                             Enable: Stone crushing                             --
--                         (BI.Settings.BI_Stone_Crushing)                        --
------------------------------------------------------------------------------------
-- Item subgroup for Stone crushing
BI.additional_categories.BI_Stone_Crushing.stone_crusher = {
  type = "item-subgroup",
  name = "bio-stone-crusher", --prev bio-bio-farm-raw-entity
  group = "bio-industries",
  order = "b-c",
}


------------------------------------------------------------------------------------
--                              Enable: Terraforming                              --
--                          (BI.Settings.BI_Terraforming)                         --
------------------------------------------------------------------------------------
-- Item subgroup for Arboretum fluids
BI.additional_categories.BI_Terraforming.arboretum_fluid = {
  type = "item-subgroup",
  name = "bio-arboretum-fluid",
  group = "bio-industries",
  order = "w-c",
}


--~ ------------------------------------------------------------------------------------
--~ --                           Item subgroups: Bio garden                           --
--~ ------------------------------------------------------------------------------------
--~ -- Bio garden fluid entities
--~ BI.default_item_subgroup.bio_gardens_fluid_entity = {
  --~ type = "item-subgroup",
  --~ name = "bio-bio-gardens-fluid-entity",
  --~ group = "bio-industries",
  --~ order = "x-b"
--~ }


------------------------------------------------------------------------------------
--                       Item subgroups: Transport/Logistics                      --
------------------------------------------------------------------------------------
--~ -- Transport
--~ BI.default_item_subgroup.transport = {
  --~ type = "item-subgroup",
  --~ name = "bio-transport",
  --~ group = "bio-industries",
  --~ order = "e-a",
--~ }

--~ -- Logistic bots
--~ BI.default_item_subgroup.logistic_robots = {
  --~ type = "item-subgroup",
  --~ name = "bio-logistic-robots",
  --~ group = "bio-industries",
  --~ order = "f-a",
--~ }

--~ -- Logistic roboport
--~ BI.default_item_subgroup.logistic_roboport = {
  --~ type = "item-subgroup",
  --~ name = "bio-logistic-roboport",
  --~ group = "bio-industries",
  --~ order = "f-b",
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


-- Status report
BioInd.readdata_msg(BI.additional_categories, settings,
                    "optional item categories", "setting")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
