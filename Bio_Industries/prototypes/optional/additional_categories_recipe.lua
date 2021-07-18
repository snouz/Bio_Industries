------------------------------------------------------------------------------------
--               Data for recipe categories that depend on settings.              --
------------------------------------------------------------------------------------
BioInd.entered_file()

BI.additional_categories = BI.additional_categories or {}

local settings = {
  "BI_Bio_Garden",
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
--                                Recipe categories                               --
------------------------------------------------------------------------------------

-- Terraformer (Arboretum)
BI.additional_categories.BI_Terraforming.arboretum = {
  type = "recipe-category",
  name = "bi-arboretum"
}


-- Depollution
BI.additional_categories.BI_Bio_Garden.clean_air = {
  type = "recipe-category",
  name = "clean-air"
}

-- Crushing
BI.additional_categories.BI_Stone_Crushing.crushing = {
  type = "recipe-category",
  name = "biofarm-mod-crushing"
}


-- Status report
BioInd.readdata_msg(BI.additional_categories, settings,
                    "optional item categories", "setting")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
