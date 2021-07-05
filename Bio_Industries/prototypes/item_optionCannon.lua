local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath

if BI.Settings.Bio_Cannon then
  data:extend({
    -- Hive Buster Turret
    {
      type = "item",
      name = "bi-bio-cannon-area",
      localised_name = {"entity-name.bi-bio-cannon"},
      localised_description = {"entity-description.bi-bio-cannon"},
      icon = ICONPATH .. "entity/biocannon_icon.png",
      icon_size = 64,
      --~ icon_mipmaps = 1,
      BI_add_icon = true,
      --~ icons = {
        --~ {
          --~ icon = ICONPATH .. "entity/biocannon_icon.png",
          --~ icon_size = 64,
        --~ }
      --~ },
      subgroup = "defensive-structure",
      order = "x[turret]-x[gun-turret]",
      place_result = "bi-bio-cannon-area",
      stack_size = 1,
    },









----------------------------------------------------------------------------
---------------------------- PROJECTILES -----------------------------------
----------------------------------------------------------------------------



-- Prototype Artillery Proto Ammo
    {
      type = "ammo",
      name = "bi-bio-cannon-proto-ammo",
      icon = ICONPATH .. "weapon/Bio_Cannon_Proto_Ammo_Icon.png",
      icon_size = 64,
      BI_add_icon = true,
      --~ icons = {
        --~ {
          --~ icon = ICONPATH .. "Bio_Cannon_Proto_Ammo_Icon.png",
          --~ icon_size = 64,
        --~ }
      --~ },
      ammo_type = {
        category = "Bio_Cannon_Ammo",
        target_type = "direction",
        action = {
          {
            type = "direct",
            action_delivery = {
              type = "projectile",
              projectile = "bi-bio-cannon-proto-ammo",
              starting_speed = 1,
              direction_deviation = 0.8,
              range_deviation = 0.8,
              max_range = 90
            }
          }
        }
      },
      subgroup = "ammo",
      order = "z[Bio_Cannon_Ammo]-a[Proto]",
      stack_size = 50,
    },


    -- Prototype Artillery Basic Ammo
    {
      type = "ammo",
      name = "bi-bio-cannon-basic-ammo",
      icon = ICONPATH .. "weapon/Bio_Cannon_Basic_Ammo_Icon.png",
      icon_size = 64,
      BI_add_icon = true,
      --~ icons = {
        --~ {
          --~ icon = ICONPATH .. "Bio_Cannon_Basic_Ammo_Icon.png",
          --~ icon_size = 64,
        --~ }
      --~ },
      ammo_type = {
        category = "Bio_Cannon_Ammo",
        target_type = "direction",
        action = {
          {
            type = "direct",
            action_delivery = {
              type = "projectile",
              projectile = "bi-bio-cannon-basic-ammo",
              starting_speed = 1,
              direction_deviation = 0.8,
              range_deviation = 0.8,
              max_range = 90
            }
          }
        }
      },
      subgroup = "ammo",
      order = "z[Bio_Cannon_Ammo]-b[Basic]",
      stack_size = 50,
    },

      -- Prototype Artillery Poison Ammo
    {
      type = "ammo",
      name = "bi-bio-cannon-poison-ammo",
      icon = ICONPATH .. "weapon/Bio_Cannon_Poison_Ammo_Icon.png",
      icon_size = 64,
      BI_add_icon = true,
      --~ icons = {
        --~ {
          --~ icon = ICONPATH .. "Bio_Cannon_Poison_Ammo_Icon.png",
          --~ icon_size = 64,
        --~ }
      --~ },
      ammo_type = {
        category = "Bio_Cannon_Ammo",
        target_type = "direction",
        action = {
          {
            type = "direct",
            action_delivery = {
              type = "projectile",
              projectile = "bi-bio-cannon-poison-ammo",
              starting_speed = 1,
              direction_deviation = 0.8,
              range_deviation = 0.8,
              max_range = 90
            }
          }
        }
      },
      subgroup = "ammo",
      order = "z[Bio_Cannon_Ammo]-c[Poison]",
      stack_size = 50,
    },









  })
end
