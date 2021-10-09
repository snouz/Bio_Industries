------------------------------------------------------------------------------------
--               Data for item-categories that depend on other mods.              --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

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
BioInd.debugging.readdata_msg(BI.additional_categories, mod_compatibility,
                    "optional item categories", "mod_compatibility")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
