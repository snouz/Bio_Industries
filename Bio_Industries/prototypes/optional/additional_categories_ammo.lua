------------------------------------------------------------------------------------
--                Data for ammo-categories that depend on settings.               --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_categories = BI.additional_categories or {}

local settings = {
  "BI_Darts",
  "Bio_Cannon",
  "BI_Explosive_Planting",
}
for s, setting in pairs(settings) do
  BI.additional_categories[setting] = BI.additional_categories[setting] or {}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                          Enable: Early wooden defenses                         --
--                             (BI.Settings.BI_Darts)                             --
------------------------------------------------------------------------------------
-- Dart turrets: Ammo category
BI.additional_categories.BI_Darts.turret_ammo = {
  type = "ammo-category",
  name = "Bio_Turret_Ammo",
  order = "1"
}

-- Dart turrets: Damage type
BI.additional_categories.BI_Darts.bob_pierce = {
  type = "damage-type",
  name = "bob-pierce"
}

-- Dart turrets: Ammo item-subgroup
BI.additional_categories.BI_Darts.ammo = {
  type = "item-subgroup",
  name = "bi-ammo",
  group = "combat",
  order = "b-[bi-ammo]"
}


------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
-- Bio cannon: Ammo category
BI.additional_categories.Bio_Cannon.cannon_ammo = {
  type = "ammo-category",
  name = "Bio_Cannon_Ammo",
  order = "1"
}

-- Bio cannon: Ammo item-subgroup
--~ BI.additional_categories.Bio_Cannon.ammo = {
  --~ type = "item-subgroup",
  --~ name = "bi-ammo",
  --~ group = "combat",
  --~ order = "b-[bi-ammo]"
--~ }
BI.additional_categories.Bio_Cannon.ammo = table.deepcopy(BI.additional_categories.BI_Darts.ammo)

BI.additional_categories.Bio_Cannon.trigger_target = {
  type = "trigger-target-type",
  name = "Bio_Cannon_Ammo"
}


------------------------------------------------------------------------------------
--                               Enable: Seed bombs                               --
--                       (BI.Settings.BI_Explosive_Planting)                      --
------------------------------------------------------------------------------------
-- Explosive planting 1
BI.additional_categories.BI_Explosive_Planting.ammo = table.deepcopy(BI.additional_categories.BI_Darts.ammo)



-- Status report
BioInd.readdata_msg(BI.additional_categories, settings,
                    "optional ammo categories", "setting")

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
