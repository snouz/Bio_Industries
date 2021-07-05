------------------------------------------------------------------------------------
--                Data for ammo-categories that depend on settings.               --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_categories = BI.additional_categories or {}

for s, setting in pairs({
  "BI_Darts",
  "Bio_Cannon",
}) do
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
BI.additional_categories.Bio_Cannon.ammo = BI.additional_categories.BI_Darts.ammo


BioInd.writeDebug("Read data for optional categories (ammo).")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
