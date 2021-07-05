------------------------------------------------------------------------------------
--                           Enable: Prototype artillery                          --
--                            (BI.Settings.Bio_Cannon)                            --
------------------------------------------------------------------------------------
local setting = "Bio_Cannon"
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
  --~ {
    --~ type = "technology",
    --~ name = "bi-tech-bio-cannon",
    --~ icon = ICONPATH .. "bi-tech-bio_cannon.png",
    --~ icon_size = 256,
    --~ BI_add_icon = true,
    --~ effects = {
      -- {
        -- type = "unlock-recipe",
        -- recipe = "bi-bio-cannon"
      -- },
      -- {
        -- type = "unlock-recipe",
        -- recipe = "bi-bio-cannon-proto-ammo"
      -- },
      -- {
        -- type = "unlock-recipe",
        -- recipe = "bi-bio-cannon-basic-ammo"
      -- },
      -- {
        -- type = "unlock-recipe",
        -- recipe = "bi-bio-cannon-poison-ammo"
      -- },

    --~ },
    --~ prerequisites = {"military-2"},
    --~ unit = {
      --~ count = 300,
      --~ ingredients = {
        --~ {"automation-science-pack", 1},
        --~ {"logistic-science-pack", 1},
        --~ {"military-science-pack", 1},
      --~ },
      --~ time = 30,
    --~ }
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
