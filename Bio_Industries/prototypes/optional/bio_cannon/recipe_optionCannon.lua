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


local BioInd = require('common')('Bio_Industries')

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



--~ data:extend({
  --~ ------------------------------------------------------------------------------------
  --~ --                                   Bio Cannon                                   --
  --~ ------------------------------------------------------------------------------------
  --~ {
    --~ type = "recipe",
    --~ name = "bi-bio-cannon",
    --~ localised_name = {"entity-name.bi-bio-cannon"},
    -- localised_description = {"entity-description.bi-bio.cannon"},
    --~ normal = {
      --~ enabled = false,
      --~ energy_required = 50,
      --~ ingredients = {
        --~ {"concrete", 100},
        --~ {"radar", 1},
        --~ {"steel-plate", 80},
        --~ {"electric-engine-unit", 5},
      --~ },
      --~ result = "bi-bio-cannon-area",
      --~ result_count = 1,
      --~ allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,    -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,     -- Added for 0.18.34/1.1.4
    --~ },
    --~ expensive = {
      --~ enabled = false,
      --~ energy_required = 100,
      --~ ingredients = {
        --~ {"concrete", 100},
        --~ {"radar", 1},
        --~ {"steel-plate", 120},
        --~ {"electric-engine-unit", 15},
      --~ },
      --~ result = "bi-bio-cannon-area",
      --~ result_count = 1,
      --~ allow_as_intermediate = false,  -- Added for 0.18.34/1.1.4
      --~ always_show_made_in = false,    -- Added for 0.18.34/1.1.4
      --~ allow_decomposition = true,     -- Added for 0.18.34/1.1.4
    --~ },
    --~ allow_as_intermediate = false,
    --~ always_show_made_in = false,      -- Changed for 0.18.34/1.1.4
    --~ allow_decomposition = true,       -- Changed for 0.18.34/1.1.4
    --~ subgroup = "defensive-structure",
    --~ order = "b[turret]-e[bi-prototype-artillery-turret]",
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  --~ },



  --~ ------------------------------------------------------------------------------------
  --~ --                                   Projectiles                                  --
  --~ ------------------------------------------------------------------------------------

  --~ -- Prototype Ammo
  --~ {
    --~ type= "recipe",
    --~ name= "bi-bio-cannon-proto-ammo",
    --~ --localised_name = {"item-name.bi-bio-cannon-proto-ammo"},
    --~ --localised_description = {"item-description.bi-bio-cannon-proto-ammo"},
    --~ enabled = false,
    --~ energy_required = 2,
    --~ ingredients = {
      --~ {"iron-plate", 10},
      --~ {"explosives", 10}
    --~ },
    --~ result = "bi-bio-cannon-proto-ammo",
    --~ result_count = 1,
    --~ subgroup = "bi-ammo",
    --~ order = "z[Bio_Cannon_Ammo]-a[Proto]",
    --~ allow_as_intermediate = true,     -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  --~ },

  --~ -- Basic Ammo
  --~ {
    --~ type= "recipe",
    --~ name= "bi-bio-cannon-basic-ammo",
    --~ --localised_name = {"item-name.bi-bio-cannon-basic-ammo"},
    --~ --localised_description = {"item-description.bi-bio-cannon-basic-ammo"},
    --~ enabled = false,
    --~ energy_required = 4,
    --~ ingredients = {
      --~ {"bi-bio-cannon-proto-ammo", 1},
      --~ {"rocket", 10}
    --~ },
    --~ result = "bi-bio-cannon-basic-ammo",
    --~ result_count = 1,
    --~ subgroup = "bi-ammo",
    --~ order = "z[Bio_Cannon_Ammo]-b[Basic]",
    --~ allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  --~ },

  --~ -- Poison Ammo
  --~ {
    --~ type= "recipe",
    --~ name= "bi-bio-cannon-poison-ammo",
    --~ --localised_name = {"item-name.bi-bio-cannon-poison-ammo"},
    --~ --localised_description = {"item-description.bi-bio-cannon-poison-ammo"},
    --~ enabled = false,
    --~ energy_required = 8,
    --~ ingredients = {
      --~ {"bi-bio-cannon-basic-ammo", 1},
      --~ {"poison-capsule", 5},
      --~ {"explosive-rocket", 5}
    --~ },
    --~ result = "bi-bio-cannon-poison-ammo",
    --~ result_count = 1,
    --~ subgroup = "bi-ammo",
    --~ order = "z[Bio_Cannon_Ammo]-c[Poison]",
    --~ allow_as_intermediate = true,    -- Added for 0.18.34/1.1.4
    --~ always_show_made_in = false,      -- Added for 0.18.34/1.1.4
    --~ allow_decomposition = true,       -- Added for 0.18.34/1.1.4
    --~ -- Custom property that allows to automatically add our recipes to tech unlocks.
    --~ BI_add_to_tech = {"bi-tech-bio-cannon"},
  --~ },
--~ })




------------------------------------------------------------------------------------
--                                 Create recipes                                 --
------------------------------------------------------------------------------------
for r, r_data in pairs(BI.optional_recipes[setting] or {}) do
  data:extend({r_data})
  BioInd.created_msg(r_data)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
