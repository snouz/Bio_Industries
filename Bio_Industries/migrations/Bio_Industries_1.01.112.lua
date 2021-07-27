BioInd.entered_file()

------------------------------------------------------------------------------------
--     Remove tables from global that can be created with AutoCache from ErLib    --
------------------------------------------------------------------------------------
global.bi_arboretum_recipe_table        = nil
global.bi.trees                         = nil
global.bi.barren_tiles                  = nil
global.compatible                       = nil
global.compound_entities                = nil


------------------------------------------------------------------------------------
--                         Rename tables for growing trees                        --
------------------------------------------------------------------------------------
global.bi_trees = table.deepcopy(global.bi)
global.bi = nil

global.bi_trees.growing = table.deepcopy(global.bi_trees.tree_growing)
global.bi_trees.tree_growing = nil

for i = 1, 4 do
  global.bi_trees["stage_" .. i] = table.deepcopy(global.bi_trees["tree_growing_stage_" .. i])
  global.bi_trees["tree_growing_stage_" .. i] = nil
end




------------------------------------------------------------------------------------
--     The radars of Terraformers have been fucked up, so lets's destroy them!    --
--  (If necessary, they will be automatically recreated when the game is loaded.) --
------------------------------------------------------------------------------------
for name, surface in pairs(game.surfaces) do
  for e, entity in pairs(surface.find_entities_filtered({name = "bi-arboretum-hidden-radar", type = "radar"})) do
BioInd.show("Destroying", BioInd.argprint(entity))
    entity.destroy()
  end
end

-- This shouldn't be needed anymore after the version number has been bumped to 1.1.112!
--~ game.reload_script()


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
