------------------------------------------------------------------------------------
--               Data for item-categories that depend on other mods.              --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_categories = BI.additional_categories or {}
BI.additional_categories.mod_compatibility = BI.additional_categories.mod_compatibility or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
--                                 Crating recipes                                --
------------------------------------------------------------------------------------
-- DeadlockCrating ("DeadlockCrating"),
BI.additional_categories.mod_compatibility.crating = {
  type = "item-subgroup",
  name = "bio-crating",
  group = "bio-industries",
  order = "zzzzz"
}


-- Status report
BioInd.readdata_msg(BI.additional_categories, mod_compatibility,
                    "optional item categories", "mod_compatibility")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
