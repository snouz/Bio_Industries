------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
local setting = "BI_Wood_Products"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.techiconpath

--~ data:extend({
  --~ -- Large chests
  --~ {
    --~ type = "technology",
    --~ name = "bi-tech-wooden-storage-1",
    --~ localised_name = {"technology-name.bi-tech-wooden-storage-1"},
    --~ localised_description = {"technology-description.bi-tech-wooden-storage-1"},
    --~ icon = ICONPATH .. "bi-tech-wooden-storage-1.png",
    --~ icon_size = 256,
    --~ effects = {
      -- {
        -- type = "unlock-recipe",
        -- recipe = "bi-wooden-chest-large"
      -- },
    --~ },
    --~ prerequisites = {"bi-tech-timber", "logistics"},
    --~ unit = {
      --~ count = 30,
      --~ ingredients = {
        --~ {"automation-science-pack", 1},
        --~ {"logistic-science-pack", 1},
      --~ },
      --~ time = 30,
    --~ },
    --~ upgrade = false,
  --~ },

  --~ -- Huge chests
  --~ {
    --~ type = "technology",
    --~ name = "bi-tech-wooden-storage-2",
    --~ localised_name = {"technology-name.bi-tech-wooden-storage-2"},
    --~ localised_description = {"technology-description.bi-tech-wooden-storage-2"},
    --~ icon = ICONPATH .. "bi-tech-wooden-storage-2.png",
    --~ icon_size = 256,
    --~ effects = {
      -- {
        -- type = "unlock-recipe",
        -- recipe = "bi-wooden-chest-huge"
      -- },
    --~ },
    --~ prerequisites = {"bi-tech-wooden-storage-1", "logistics-2"},
    --~ unit = {
      --~ count = 100,
      --~ ingredients = {
        --~ {"automation-science-pack", 1},
        --~ {"logistic-science-pack", 1},
      --~ },
      --~ time = 30,
    --~ },
    --~ upgrade = false,
  --~ },

  --~ -- Gigantic chests
  --~ {
    --~ type = "technology",
    --~ name = "bi-tech-wooden-storage-3",
    --~ localised_name = {"technology-name.bi-tech-wooden-storage-3"},
    --~ localised_description = {"technology-description.bi-tech-wooden-storage-3"},
    --~ icon = ICONPATH .. "bi-tech-wooden-storage-3.png",
    --~ icon_size = 256,
    --~ effects = {
      -- {
        -- type = "unlock-recipe",
        -- recipe = "bi-wooden-chest-giga"
      -- },
    --~ },
    --~ prerequisites = {"bi-tech-wooden-storage-2", "logistics-3", "concrete"},
    --~ unit = {
      --~ count = 150,
      --~ ingredients = {
        --~ {"automation-science-pack", 1},
        --~ {"logistic-science-pack", 1},
        --~ {"chemical-science-pack", 1},
        --~ {"production-science-pack", 1},
      --~ },
      --~ time = 30,
    --~ },
    --~ upgrade = false,
  --~ },
--~ })



------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
for t_name, tech in pairs(BI.optional_techs[setting] or {}) do
  data:extend({tech})
  BioInd.created_msg(tech)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
