local xxx, yyy, new_position, currentTilename, can_be_placed
local pos, surface, Inventory, stack

-- OmniFluid replaces all fluids with items, so the arboretum won't have a fluidbox!
local OmniFluid = script.active_mods["omnimatter_fluid"] and true or false

function Get_Arboretum_Recipe(ArboretumTable, event)

  if not ArboretumTable then
    BioInd.writeDebug("%s is not a valid ArboretumTable. Leaving immediately!")
    return
  else
    AlienBiomes = AlienBiomes or BioInd.AB_tiles()
    terrain_name_g1 = terrain_name_g1 or (AlienBiomes and "vegetation-green-grass-1" or "grass-1")
    terrain_name_g3 = terrain_name_g3 or (AlienBiomes and "vegetation-green-grass-3" or "grass-3")
    local recipe = ArboretumTable.base.get_recipe()

    --~ if recipe ~= nil and ArboretumTable.base.fluidbox[1] ~= nil then
    if recipe and (OmniFluid or ArboretumTable.base.fluidbox[1]) then
      --~ local Water_Name = ArboretumTable.base.fluidbox[1].name
      --~ local Water_Level = ArboretumTable.base.fluidbox[1].amount
      -- There willl only be water if OmniFluid isn't active!
      local Water_Name = (not OmniFluid) and ArboretumTable.base.fluidbox[1].name
      local Water_Level = (not OmniFluid) and ArboretumTable.base.fluidbox[1].amount
      Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)

      -- Check that all ingredients are available!
      local pass_qc = true
      for i = 1, #Inventory do
        if not Inventory[i].valid_for_read then
          pass_qc = false
          break
        end
      end

      if pass_qc and (OmniFluid or (Water_Name == "water" and Water_Level >= 100)) then
        local plant_radius = 75   -- Radius the building looks for areas to plant trees/change the terrain
        --~ local recipe_name = ArboretumTable.base.get_recipe().name
        local recipe_name = recipe.name
        local create_seedling
        pos = ArboretumTable.base.position
        surface = ArboretumTable.base.surface

        -- Just plant a tree and hope the ground is fertile!
        if recipe_name == "bi-arboretum-r1" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Just plant a tree")
          --~ local pos = ArboretumTable.base.position
          --~ local surface = ArboretumTable.base.surface

          --- 10 attempts to find a random spot to plant a tree and/or change terrain
          for k = 1, 10 do
            xxx = math.random(-plant_radius, plant_radius)
            yyy = math.random(-plant_radius, plant_radius)
            new_position = {x = pos.x + xxx, y = pos.y + yyy}
            can_be_placed = surface.can_place_entity{
              name= "seedling",
              position = new_position,
              force = "neutral"
            }

            if can_be_placed then
              --- Remove 100 Water
              if not OmniFluid then
                Water_Level = Water_Level - 100
                if Water_Level <= 0 then
                  Water_Level = 1
                end
              end

              ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}
              --- remove 1 inventory item
              Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)

              for i = 1, #Inventory do
                stack = Inventory[i]
                if stack.valid_for_read and stack.count > 0 then
                  stack.count  = stack.count - 1
                end
              end

              create_seedling = surface.create_entity({
                name = "seedling",
                position = new_position,
                force = "neutral"
              })
              seed_planted_arboretum(event, create_seedling)
              --- After sucessfully planting a tree, break out of the loop.
              break
            else
              BioInd.writeDebug("Can't plant here (attempt %s)", k)
            end
          end
        -- Fertilize the ground with normal fertilizer. Ignore tiles listed in Terrain_Check_1!
        elseif recipe_name == "bi-arboretum-r2" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Just change terrain to grass-3 (basic)")
          --~ local pos = ArboretumTable.base.position
          --~ local surface = ArboretumTable.base.surface

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            xxx = math.random(-plant_radius, plant_radius)
            yyy = math.random(-plant_radius, plant_radius)
            new_position = {x = pos.x + xxx, y = pos.y + yyy}
            currentTilename = surface.get_tile(new_position.x, new_position.y).name
            --~ local terrain_name_g1
            --~ local terrain_name_g3

            --~ if AlienBiomes then
              --~ terrain_name_g1 = "vegetation-green-grass-1"
              --~ terrain_name_g3 = "vegetation-green-grass-3"
            --~ else
              --~ terrain_name_g1 = "grass-1"
              --~ terrain_name_g3 = "grass-3"
            --~ end

            -- We need to fertilize the ground!
            --if Bi_Industries.fertility[currentTilename] and currentTilename ~= terrain_name_g1 then
            if Bi_Industries.fertility[currentTilename] and not Terrain_Check_1[currentTilename] then
              --- Remove 100 Water
              if not OmniFluid then
                Water_Level = Water_Level - 100
                if Water_Level <= 0 then
                  Water_Level = 1
                end
                ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}
              end
              -- Remove 1 item from inventory slots
              Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                stack = Inventory[i]
                if stack.valid_for_read and stack.count > 0 then
                  stack.count = stack.count - 1
                end
              end

              if currentTilename ~= terrain_name_g3 then
                surface.set_tiles(
                  {{name = terrain_name_g3, position = new_position}},
                  true,         -- correct_tiles
                  true,         -- remove_colliding_entities
                  true,         -- remove_colliding_decoratives
                  true          -- raise_event
                )
              end
              --~ surface.set_tiles{{name = terrain_name_g3, position = new_position}}
              --- After sucessfully changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("%s: Can't change terrain (%s)",
                                {k, currentTilename or "unknown tile"})
            end
          end
        -- Fertilize the ground with advanced fertilizer. Ignore tiles listed in Terrain_Check_2!
        elseif recipe_name == "bi-arboretum-r3" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Just change terrain to grass-1 (advanced)")
          --~ pos = ArboretumTable.base.position
          --~ surface = ArboretumTable.base.surface
          --~ local terrain_name_g1
          --~ local terrain_name_g3

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            xxx = math.random(-plant_radius, plant_radius)
            yyy = math.random(-plant_radius, plant_radius)
            new_position = {x = pos.x + xxx, y = pos.y + yyy}
            currentTilename = surface.get_tile(new_position.x, new_position.y).name
            --~ local terrain_name_g1
            --~ local terrain_name_g3

            --~ if AlienBiomes then
              --~ terrain_name_g1 = "vegetation-green-grass-1"
              --~ terrain_name_g3 = "vegetation-green-grass-3"
            --~ else
              --~ terrain_name_g1 = "grass-1"
              --~ terrain_name_g3 = "grass-3"
            --~ end

            if Bi_Industries.fertility[currentTilename] and currentTilename ~= terrain_name_g1 then
              --- Remove 100 Water
              if not OmniFluid then
                Water_Level = Water_Level - 100
                if Water_Level <= 0 then
                  Water_Level = 1
                end
                ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}
              end

              -- Remove 1 item from inventory slots
              Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                stack = Inventory[i]
                if stack.valid_for_read and stack.count > 0 then
                  stack.count  = stack.count - 1
                end
              end
              if currentTilename ~= terrain_name_g1 then
                surface.set_tiles(
                  {{name = terrain_name_g1, position = new_position}},
                  true,         -- correct_tiles
                  true,         -- remove_colliding_entities
                  true,         -- remove_colliding_decoratives
                  true          -- raise_event
                )
              end
              --~ surface.set_tiles{{name = terrain_name_g1, position = new_position}}
              --- After sucessfully changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("%s: Can't change terrain (%s)",
                                {k, currentTilename or "unknown tile"})
            end
          end
        -- Fertilize the ground with normal fertilizer. Ignore tiles listed in Terrain_Check_1!
        -- Also plant a tree.
        elseif recipe_name == "bi-arboretum-r4" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Plant Tree AND change the terrain to grass-3 (basic)")
          --~ pos = ArboretumTable.base.position
          --~ surface = ArboretumTable.base.surface

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            xxx = math.random(-plant_radius, plant_radius)
            yyy = math.random(-plant_radius, plant_radius)
            new_position = {x = pos.x + xxx, y = pos.y + yyy}
            currentTilename = surface.get_tile(new_position.x, new_position.y).name
            can_be_placed = surface.can_place_entity{
              name= "seedling",
              position = new_position,
              force = "neutral"
            }
            --~ local things = 0 --stacks that are large enough
            --~ local terrain_name_g1
            --~ local terrain_name_g3

            --~ if AlienBiomes then
              --~ terrain_name_g1 = "vegetation-green-grass-1"
              --~ terrain_name_g3 = "vegetation-green-grass-3"
            --~ else
              --~ terrain_name_g1 = "grass-1"
              --~ terrain_name_g3 = "grass-3"
            --~ end

            ---- Test to see if we can plant
            if can_be_placed and Bi_Industries.fertility[currentTilename] then
              --- Remove 100 Water
              if not OmniFluid then
                Water_Level = Water_Level - 100
                if Water_Level <= 0 then
                  Water_Level = 1
                end
                ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}
              end

              -- Remove 1 item from inventory slots
              Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                stack = Inventory[i]
                --~ BioInd.writeDebug(tostring(i) .. " contains: " .. tostring(stack.name))
                if stack.valid_for_read and stack.count > 0 then
                  -- Don't waste fertilizer on fertile ground!
                  if stack.name == 'fertiliser' and Terrain_Check_1[currentTilename] then
                    BioInd.writeDebug("Don't deduct Fertilizer")
                  else
                    stack.count  = stack.count - 1
                  end
                end
              end

              if currentTilename ~= terrain_name_g3 then
                surface.set_tiles(
                  {{name = terrain_name_g3, position = new_position}},
                  true,         -- correct_tiles
                  true,         -- remove_colliding_entities
                  true,         -- remove_colliding_decoratives
                  true          -- raise_event
                )              end
              create_seedling = surface.create_entity({
                name = "seedling",
                position = new_position,
                force = "neutral"
              })
              --~ entity = create_seedling
              --~ seed_planted_arboretum (event, entity)
              seed_planted_arboretum(event, create_seedling)
              --- After sucessfully planting a tree or changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("%s: Can't change terrain and plant a tree (%s)",
                                {k, currentTilename or "unknown tile"})
            end
          end
        -- Fertilize the ground with advanced fertilizer. Ignore tiles listed in Terrain_Check_2!
        -- Also plant a tree.
        elseif recipe_name == "bi-arboretum-r5" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Plant Tree and change the terrain to grass-1 (advanced)")
          --~ pos = ArboretumTable.base.position
          --~ surface = ArboretumTable.base.surface

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            xxx = math.random(-plant_radius, plant_radius)
            yyy = math.random(-plant_radius, plant_radius)
            new_position = {x = pos.x + xxx, y = pos.y + yyy}
            currentTilename = surface.get_tile(new_position.x, new_position.y).name
            can_be_placed = surface.can_place_entity{
              name= "seedling",
              position = new_position,
              force = "neutral"
            }
            --~ local terrain_name_g1
            --~ local terrain_name_g3

            --~ if AlienBiomes then
              --~ terrain_name_g1 = "vegetation-green-grass-1"
              --~ terrain_name_g3 = "vegetation-green-grass-3"
            --~ else
              --~ terrain_name_g1 = "grass-1"
              --~ terrain_name_g3 = "grass-3"
            --~ end

            if can_be_placed and Bi_Industries.fertility[currentTilename] then
              --- Remove 100 Water
              if not OmniFluid then
                Water_Level = Water_Level - 100
                if Water_Level <= 0 then
                  Water_Level = 1
                end
                ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}
              end

              -- Remove 1 item from inventory slots
              Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                stack = Inventory[i]
                if stack.valid_for_read and stack.count > 0 then
                  -- Don't waste fertilizer on fertile ground!
                  if stack.name == 'bi-adv-fertiliser' and Terrain_Check_2[currentTilename] then
                    BioInd.writeDebug("Don't deduct Adv Fertilizer")
                  else
                    stack.count  = stack.count - 1
                  end
                end
              end
              if currentTilename ~= terrain_name_g1 then
                surface.set_tiles(
                  {{name = terrain_name_g1, position = new_position}},
                  true,         -- correct_tiles
                  true,         -- remove_colliding_entities
                  true,         -- remove_colliding_decoratives
                  true          -- raise_event
                )
              end
              --~ surface.set_tiles{{name = terrain_name_g1, position = new_position}}
              create_seedling = surface.create_entity({
                name = "seedling",
                position = new_position,
                force = "neutral"
              })
              seed_planted_arboretum (event, create_seedling)
              --- After sucessfully planting a tree or changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("%s: Can't change terrain and plant a tree (%s)",
                                {k, currentTilename or "unknown tile"})
            end
          end
        else
          BioInd.writeDebug("Terraformer has no recipe!")
        end
      end
    end
  end
end
