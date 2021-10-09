------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 TICKED ACTIONS                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()


local ticked_actions = {
  check_trees_on_tick = function()
      BI_scripts.trees.check_trees_on_tick()
    end,
  check_bio_cannon_radars = function(tick)
      BI_scripts.bio_cannon.check_radars(tick)
    end,
  plant_seedlings = function(data)
      BI_scripts.seedbombs.plant_seedlings(data)
    end,
}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
script.on_event(BioInd.erlib.Events.events.on_ticked_action, function(event)
  BioInd.debugging.entered_event(event)

  -- Tree growing
  if event.module_name == 'trees' then
    if event.method_name == 'check_trees_on_tick' then
      ticked_actions.check_trees_on_tick()
    end

  -- Bio cannon
  elseif event.module_name == 'bio_cannon' then
    if event.method_name == 'check_bio_cannon_radars' then
      ticked_actions.check_bio_cannon_radars(event.tick)
    end

  -- Seedbombs
  elseif event.module_name == 'seedbomb' then
    if event.method_name == 'plant_seedlings' then
      ticked_actions.plant_seedlings(event.parameter)
    end
  end

  BioInd.debugging.entered_event(event, "leave")
end)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_trees
