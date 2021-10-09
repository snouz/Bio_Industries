------------------------------------------------------------------------------------
--                  Data for some techs that depend on a trigger.                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

BI.additional_techs = BI.additional_techs or {}

local triggers = {
  "BI_Trigger_Concrete",
  --~ "BI_Trigger_Concrete_Create",
}
for t, trigger in pairs(triggers) do
  BI.additional_techs[trigger] = BI.additional_techs[trigger] or {}
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.techiconpath
local techs = data.raw.technology


--~ ------------------------------------------------------------------------------------
--~ --                     Trigger: Make tech for Refined concrete                    --
--~ --                        (BI.Triggers.BI_Trigger_Concrete)                       --
--~ ------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                     Trigger: Make tech for Refined concrete                    --
--                    (BI.Triggers.BI_Trigger_Concrete_Create)                    --
------------------------------------------------------------------------------------
-- Refined concrete
BI.additional_techs.BI_Trigger_Concrete.refined_concrete = {
--~ BI.additional_techs.BI_Trigger_Concrete_Create.refined_concrete = {
  type = "technology",
  name = "bi-tech-refined-concrete",
  localised_name = {"technology-name.bi-tech-refined-concrete"},
  localised_description = {"technology-description.bi-tech-refined-concrete"},
  icon = ICONPATH .. "bi-tech-refined-concrete.png",
  icon_size = 256, icon_mipmaps = 4,
  BI_add_icon = true,
  effects = {
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "refined-concrete"
    --~ },
    --~ {
      --~ type = "unlock-recipe",
      --~ recipe = "refined-hazard-concrete"
    --~ },
  },
  order = techs["concrete"] and techs["concrete"].order .. "-[bi-refined-concrete]" or
                                "c-c-c-[bi-refined-concrete]",
  prerequisites = {"concrete"},
  unit = {
    count = 150,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30,
  }
}


-- Status report
BioInd.debugging.readdata_msg(BI.additional_techs, triggers, "optional technologies", "trigger")


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
