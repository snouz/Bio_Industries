BioInd.debugging.entered_file()

------------------------------------------------------------------------------------
--                         Move  tables for growing trees                         --
------------------------------------------------------------------------------------
global.bi_trees = table.deepcopy(global.bi) or {}

global.bi_trees.growing = table.deepcopy(global.bi_trees.tree_growing) or {}
global.bi_trees.tree_growing = nil

for i = 1, 4 do
  global.bi_trees["stage_" .. i] = table.deepcopy(global.bi_trees["tree_growing_stage_" .. i]) or {}
  global.bi_trees["tree_growing_stage_" .. i] = nil
end

------------------------------------------------------------------------------------
--     Remove tables from global that can be created with AutoCache from ErLib    --
------------------------------------------------------------------------------------
global.bi_arboretum_recipe_table        = nil
global.compatible                       = nil
global.compound_entities                = nil
--~ if global.bi then
  --~ global.bi.trees                         = nil
  --~ global.bi.barren_tiles                  = nil
--~ end
global.bi                               = nil





------------------------------------------------------------------------------------
--                           Recreate the terraformers!                           --
------------------------------------------------------------------------------------
local new_entity
for s, surface in pairs(game.surfaces) do
BioInd.debugging.writeDebug("Looking for terraformers on surface %s", {s})
  ------------------------------------------------------------------------------------
  -- Terraformers have 8 instead of 2 pipe connections now. On loading, the images
  -- are correct, but apparently only the original 2 pipes exist. Replacing them (with
  -- entity.clone, not create_entity, to keep recipes/inventories!) fixes the problem.
  -- (The new terraformers should be registered, and missing hidden entities restored,
  -- when on_configuration_changed is triggered.)
  for e, entity in pairs(surface.find_entities_filtered({name = "bi-arboretum"})) do
    new_entity = entity.clone({
      position = entity.position,
      surface = surface,
      force = entity.force,
      create_build_effect_smoke = false
    })
    BioInd.debugging.writeDebug("Cloned %s", {BioInd.debugging.argprint(entity)})

    entity.destroy()
    BioInd.debugging.writeDebug("Removed source of new", {BioInd.debugging.argprint(new_entity)})
  end

  ------------------------------------------------------------------------------------
  --     The radars of Terraformers have been fucked up, so lets's destroy them!    --
  --  (If necessary, they will be automatically recreated when the game is loaded.) --
  ------------------------------------------------------------------------------------
  for e, entity in pairs(surface.find_entities_filtered({name = "bi-arboretum-hidden-radar", type = "radar"})) do
BioInd.debugging.show("Destroying", BioInd.debugging.argprint(entity))
    entity.destroy()
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
