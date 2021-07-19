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

game.reload_script()


for index, force in pairs(game.forces) do
  force.reset_recipes()
  force.reset_technologies()
end


for name, surface in pairs(game.surfaces) do
  for e, entity in pairs(surface.find_entities_filtered({name = "bi-arboretum-hidden-radar"})) do
    entity.destroy()
  end
end

--[[
for name, surface in pairs(game.surfaces) do
  for e, entity in pairs(surface.find_entities_filtered({name = "bi-arboretum"})) do

    local entsurface = entity.surface
    local new_ent = entsurface.create_entity{name = entity.name, position = entity.position, direction = entity.direction, force = entity.force}
    entity.destroy()
    entity = new_ent
  end
end
]]--

--[[global.panels = {
  entity = "bi-arboretum"
}

function on_configuration_changed(data)
  if data.mod_changes.Bio_Industries then
    local old_version = data.mod_changes.Bio_Industries.old_version
    if old_version and old_version < "1.1.111" then --(1.0.0 is the version where you introduced panel2 as the new type)
      for _, ent in pairs(global.panels) do
        local surface = ent.entity.surface
        local new_ent = surface.create_entity{name="bi-arboretum", position=ent.entity.position, force=ent.entity.force, direction=ent.entity.direction}
        ent.entity.destroy()
        ent.entity = new_ent
      end
    end
  end
end
]]--



--[[
for name, surface in pairs(game.surfaces) do
  for e, ent in pairs(surface.find_entities_filtered({name = "bi-arboretum"})) do
    local new_ent = surface.create_entity{name = "bi-arboretum", position=ent.position, force=ent.force, direction=ent.direction}
    ent.destroy()
    ent = new_ent
  end
end
]]--

--[[
for _, ent in pairs(global.panels) do
  local surface = ent.entity.surface
  local new_ent = surface.create_entity{name="panel2", position=ent.entity.position, force=ent.entity.force, direction=ent.entity.direction}
  ent.entity.destroy()
  ent.entity = new_ent
end

]]--

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
