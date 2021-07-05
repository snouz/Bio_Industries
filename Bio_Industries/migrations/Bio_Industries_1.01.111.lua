BioInd.entered_file()

------------------------------------------------------------------------------------
-- Remove Musk-floor tiles that shouldn't be there!
------------------------------------------------------------------------------------

global = global or {}
global.mod_settings = global.mod_settings or {}


if not global.mod_settings.BI_Power_Production then

  -- If we have no Musk-floor tiles stored in the global table, remove all
  -- hidden entities for Musk-floor from all surfaces!
  if global.bi_musk_floor_table and
      global.bi_musk_floor_table.tiles and
      not next(global.bi_musk_floor_table.tiles) then

    local hidden = {
      BioInd.musk_floor_panel_name,
      BioInd.musk_floor_pole_name,
    }

    for name, surface in pairs(game.surfaces) do
      BioInd.writeDebug("Looking for hidden entities from Musk floor on surface %s:", {name})
      for e, entity in pairs(surface.find_entities_filtered({name = hidden})) do
        BioInd.writeDebug("Removing %s", {BioInd.argprint(entity)})
        entity.destroy()
      end
    end
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
