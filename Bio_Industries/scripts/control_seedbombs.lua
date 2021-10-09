------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                   SEED BOMBS                                   --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

-- ManagedLuaBootstrap instance from ErLib
local seedbomb_script = BioInd.erlib.Events.get_managed_script("seedbombs")

local BI_seedbombs = {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                             Local variables/tables                             --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- Data that will be needed for planting trees, depending on the seedbomb used.
local effects = {
  ["seedling"] = {
    -- Number of seedlings created by projectile
    total_seeds = 600,
    -- Area around point of impact where seeds will be spread
    radius = 24,
    -- Seeds will be spread in stages, in rings around the point of impact. They
    -- will be placed first near the center, and last at the outer border.
    --~ rings = 5,
    rings = 30,
    -- This table will contain precalculated data for each ring.
    ring_data = {},
    -- Ticks until seeds are planted in the next ring
    --~ next_ring_delay = 60,
    next_ring_delay = 5,
  },
  ["seedling-2"] = {
    total_seeds = 800,
    radius = 27,
    --~ rings = 5,
    rings = 30,
    ring_data = {},
    --~ next_ring_delay = 60,
    next_ring_delay = 6,
  },
  ["seedling-3"] = {
    total_seeds = 1000,
    radius = 30,
    --~ rings = 5,
    rings = 30,
    ring_data = {},
    --~ next_ring_delay = 60,
    next_ring_delay = 8,
  }
}

-- When math.random() is used with two arguments, it will return an integer. We want
-- to get fractional positions, so we use this factor to scale up the allowed values
-- when calling math.random(), and to scale down the final position values again.
local scale_up = 1000
local scale_down = 1 / scale_up

do
  -- Distance of inner/outer border of each ring from the point of impact
  local min_distance, max_distance
  -- Width of each ring
  local width
  -- The area covered by the center ring is the base value (1), the factor for the outer
  -- rings is the proportion outer_ring_area : center_ring_area.
  local area_factors = {}
  -- Sum of all area_factors. As outer rings cover a larger area than inner rings,
  -- potentially more seeds can be planted there. The ratio seeds[ring] : seeds is the
  -- same as area_factor[ring] : area_portions.
  local area_portions
  -- Number of seeds per area portion, will be multiplied with area_factors[ring] to
  -- get the maximum number of seeds planted in that ring.
  local seeds

  for e_name, e_data in pairs(effects) do
    width = e_data.radius / e_data.rings
    area_portions = 0

    for r = 1, e_data.rings do
      -- Calculate ring borders
      e_data.ring_data[r] = {}
      e_data.ring_data[r].min_distance = math.floor(scale_up * width * (r-1))
      e_data.ring_data[r].max_distance = math.floor(scale_up * width * r)

      -- Determine factor for this ring (1, 3, 5 …)
      area_factors[r] = area_factors[r] or 2 * r - 1
      area_portions = area_portions + area_factors[r]
    end

    -- We now know the proportions of the ring areas, so we can store the maximum
    -- number of seeds that can be planted in each ring.
    seeds = e_data.total_seeds / area_portions
    for r = 1, e_data.rings do
      e_data.ring_data[r].seeds = seeds * area_factors[r]
    end
  end
  BioInd.debugging.show("effects", effects)
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

local function get_direction()
  return math.random() - 0.5 < 0 and -1 or 1
end



local function scale_and_direction(value)
  return value * scale_down * get_direction()
end



local function get_y(x, r_min, r_max)
  local y

  -- No need to calulate anything
  if x == r_max then
    y = 0

  -- We must find a suitable y
  else
    local y_min, y_max

    -- Range is given by the radii of inner and outer circles
    if x == 0 then
      y_min = r_min
      y_max = r_max
    -- Must calculate y_min and y_max if x < r_min
    elseif x < r_min then
      y_min = math.sqrt(r_min^2 - x^2)
      y_max = math.sqrt(r_max^2 - x^2)
    -- Must calculate y_max if r_min < x < r_max
    else
      y_min = 0
      y_max = math.sqrt(r_max^2 - x^2)
    end
    y = math.random(y_min, y_max)
BioInd.debugging.writeDebug("x: %s\ty_min: %s\ty_max: %s\ty: %s", {x, y_min, y_max, y})
  end

  return y
end


local function get_position(center, ring_data)
  BioInd.debugging.entered_function({center, ring_data})

  local r_min, r_max = ring_data.min_distance, ring_data.max_distance

  -- Calculate coordinates with upscaled values so we have more variety for math.random
  local x = math.random(0, r_max)
  local y = get_y(x, r_min, r_max)

  -- Scale coordinates down, and choose direction
  x = scale_and_direction(x)
  y = scale_and_direction(y)

  return {x = center.x + x, y = center.y + y}
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 AutoCache stuff                                --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                       Functions visible from other files                       --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

BI_seedbombs.plant_seedlings = function(data)
 BioInd.debugging.entered_function({data})

  local effect  = data.create_this and effects[data.create_this] or
                    BioInd.debugging.arg_err(data.create_this, "seedling name")
  local ring    = data.ring and effect.ring_data[data.ring] or
                    BioInd.debugging.arg_err(data.ring, "ring identifier (number)")
  local center  = data.position and BioInd.normalize_position(data.position) or
                    BioInd.debugging.arg_err(data.position, "position")
  local surface = data.surface and game.surfaces[data.surface] or
                    BioInd.debugging.arg_err(data.surface, "surface index")
  local force   = data.force or "neutral"

  local fail_cnt, success_cnt = 0, 0
  local new_pos
  local new_entity, rendering_id

  for i = 1, ring.seeds do
    new_pos = get_position(center, ring)

    if surface.can_place_entity({
      name = data.create_this,
      position = new_pos,
      force = force,
      build_check_type = defines.build_check_type.manual,
    }) then

      new_entity = surface.create_entity({
        name = data.create_this,
        --~ position = get_position(center, ring),
        position = new_pos,
        force = force,
        --~ raise_built = true,
        create_build_effect_smoke = false,
        spawn_decorations = true,
        move_stuck_players = false
      })
      -- In scripts/event_handlers.lua, event_handlers.On_Built will also trigger
      -- for script_raised_built. We'll need to add a flag to avoid that a second
      -- entity is created by the other script, so we can't use surface.create_entity
      -- with raise_built, but must raise the event explicitly.
      script.raise_event(defines.events.script_raised_built, {
        entity = new_entity,
        seedbomb = true
      })
      success_cnt = success_cnt + 1
    else
      fail_cnt = fail_cnt + 1
      if BioInd.debugging.is_debug then
        rendering_id = rendering.draw_circle({
          color = {r = 1},
          radius = 0.25,
          filled = true,
          target = new_pos,
          surface = surface,
          draw_on_ground = true,
          only_in_alt_mode = true
        })
        rendering.bring_to_front(rendering_id)
      end
    end
  end
  BioInd.debugging.writeDebug("Created %s %ss (failed to create %s).", {success_cnt, data.create_this, fail_cnt})

  BioInd.debugging.entered_function("leave")
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--                                 Event handlers                                 --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--                            on_trigger_created_entity                           --
------------------------------------------------------------------------------------
--~ seedbomb_script.on_event(defines.events.on_trigger_created_entity, function(event)
seedbomb_script.on_event(defines.events.script_raised_built, function(event)
  BioInd.debugging.entered_event(event)

  local entity = event.entity
  local surface = entity.surface
  local position = entity.position

  local fertilizer_tiles = BioInd.tree_stuff.fertilizer_tiles

  -- Basic
  if entity.name == "seedling" then
    BioInd.debugging.writeDebug("Seed Bomb Activated - Basic")
    BI_scripts.trees.seed_planted_trigger(event)

  -- Standard
  elseif entity.name == "seedling-2" then
    BioInd.debugging.writeDebug("Seed Bomb Activated - Standard")
    --~ surface.set_tiles{{name = fertilizer_tiles.common, position = position}}
    if fertilizer_tiles.common then
      surface.set_tiles{{name = fertilizer_tiles.common, position = position}}
    end
    BI_scripts.trees.seed_planted_trigger(event)

  -- Advanced
  elseif entity.name == "seedling-3" then
    BioInd.debugging.writeDebug("Seed Bomb Activated - Advanced")
    --~ surface.set_tiles{{name = fertilizer_tiles.advanced, position = position}}
    if fertilizer_tiles.advanced then
      surface.set_tiles{{name = fertilizer_tiles.advanced, position = position}}
    end
    BI_scripts.trees.seed_planted_trigger(event)
  end
--~ error("Break!")
  BioInd.debugging.entered_event(event, "leave")
end)



------------------------------------------------------------------------------------
--            Seedbomb has been used: Plant around the point of impact!           --
------------------------------------------------------------------------------------
seedbomb_script.on_event(defines.events.on_script_trigger_effect, function(event)
  BioInd.debugging.entered_event(event)

  local effect = event.effect_id:gsub("^BI_seedbomb_", "")
  local data = effects[effect]

  if data then
    local force = event.source_entity and event.source_entity.force and
                    event.source_entity.force.name or "neutral"
    local position = event.target_position
    local surface = event.surface_index
    local delay = data.next_ring_delay

    if position and surface then
      -- Draw the rings on the ground if debugging is on
      if BioInd.debugging.is_debug then
        for ring = data.rings, 1, -1 do
BioInd.debugging.show("ring", ring)
          rendering.draw_circle({
            color = {g = ring / data.rings},
            radius = data.ring_data[ring].max_distance * scale_down,
            filled = true,
            target = position,
            surface = surface,
            draw_on_ground = true,
            only_in_alt_mode = true,
            time_to_live = 60 * 60 * 10,
          })
        end
      end

      -- Schedule planting for each ring
      for ring = 1, data.rings do
        BioInd.erlib.TickedAction.enqueue('seedbomb', 'plant_seedlings', delay * (ring - 1) + 1, {
          create_this = effect,
          ring = ring,
          position = position,
          surface = surface,
          force = force,
        })
BioInd.debugging.show("Delay for ring " .. ring, delay * (ring - 1) + 1)
BioInd.debugging.show("Creating entity", effect)
      end
    end
  end

  --~ error("Break!")
  BioInd.debugging.entered_event(event, "leave")
end)




------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_seedbombs
