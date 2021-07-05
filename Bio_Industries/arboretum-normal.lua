function Get_Arboretum_Recipe(ArboretumTable, event)

  if ArboretumTable == nil then
    global.Arboretum_Table = {}
    return
  else
    local AlienBiomes = BioInd.AB_tiles()
    local recipe = ArboretumTable.base.get_recipe()

    if recipe ~= nil and ArboretumTable.base.fluidbox[1] ~= nil then
      local Water_Name = ArboretumTable.base.fluidbox[1].name
      local Water_Level = ArboretumTable.base.fluidbox[1].amount
      local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
      local pass_qc = true
      for i = 1, #Inventory do
        if not Inventory[i].valid_for_read then
          pass_qc = false
          break
        end
      end

      if Water_Name == "water" and Water_Level >= 100 and pass_qc then
        local plant_radius = 75   -- Radius the building looks for areas to plant trees/change the terrain
        local recipe_name = ArboretumTable.base.get_recipe().name

        if recipe_name == "bi-arboretum-r1" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Just plant a tree")
          local pos = ArboretumTable.base.position
          local surface = ArboretumTable.base.surface

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            local xxx = math.random(-plant_radius, plant_radius)
            local yyy = math.random(-plant_radius, plant_radius)
            local new_position = {x = pos.x + xxx, y = pos.y + yyy}
            local can_be_placed = surface.can_place_entity{
              name= "seedling",
              position = new_position,
              force = "neutral"
            }

            if can_be_placed then
              --- Remove 100 Water
              Water_Level = Water_Level - 100
              if Water_Level <= 0 then
                Water_Level = 1
              end

              ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}
              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(  defines.inventory.assembling_machine_input)

              for i = 1, #Inventory do
                local stack = Inventory[i]
                if stack.count > 0 then
                  stack.count  = stack.count - 1
                end
              end

              local create_seedling = surface.create_entity({
                name = "seedling",
                position = new_position,
                force = "neutral"
              })
              seed_planted_arboretum (event, create_seedling)
              --- After sucessfully planting a tree, break out of the loop.
              break
            else
              BioInd.writeDebug("can't plant here")
              BioInd.writeDebug(tostring(k))
            end
          end
        elseif recipe_name == "bi-arboretum-r2" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Just change terrain to grass-3 (basic)")
          local pos = ArboretumTable.base.position
          local surface = ArboretumTable.base.surface

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            local xxx = math.random(-plant_radius, plant_radius)
            local yyy = math.random(-plant_radius, plant_radius)
            local new_position = {x = pos.x + xxx, y = pos.y + yyy}
            local currentTilename = surface.get_tile(new_position.x, new_position.y).name
            local terrain_name_g1
            local terrain_name_g3

            if AlienBiomes then
              terrain_name_g1 = "vegetation-green-grass-1"
              terrain_name_g3 = "vegetation-green-grass-3"
            else
              terrain_name_g1 = "grass-1"
              terrain_name_g3 = "grass-3"
            end

            --if Bi_Industries.fertility[currentTilename] and currentTilename ~= terrain_name_g1 then
            if Bi_Industries.fertility[currentTilename] and not Terrain_Check_1[currentTilename] then
              --- Remove 100 Water
              Water_Level = Water_Level - 100
              if Water_Level <= 0 then
                Water_Level = 1
              end
              ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                local stack = Inventory[i]
                if stack.count > 0 then
                  stack.count = stack.count - 1
                end
              end

              surface.set_tiles{{name = terrain_name_g3, position = new_position}}
              --- After sucessfully planting a tree or changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("can't change here")
              BioInd.writeDebug(tostring(k))
            end
          end
        elseif recipe_name == "bi-arboretum-r3" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Just change terrain to grass-1 (advanced)")
          local pos = ArboretumTable.base.position
          local surface = ArboretumTable.base.surface
          local terrain_name_g1
          local terrain_name_g3

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            local xxx = math.random(-plant_radius, plant_radius)
            local yyy = math.random(-plant_radius, plant_radius)
            local new_position = {x = pos.x + xxx, y = pos.y + yyy}
            local currentTilename = surface.get_tile(new_position.x, new_position.y).name
            --~ local terrain_name_g1
            --~ local terrain_name_g3

            if AlienBiomes then
              terrain_name_g1 = "vegetation-green-grass-1"
              terrain_name_g3 = "vegetation-green-grass-3"
            else
              terrain_name_g1 = "grass-1"
              terrain_name_g3 = "grass-3"
            end

            if Bi_Industries.fertility[currentTilename] and currentTilename ~= terrain_name_g1 then
              --- Remove 100 Water
              Water_Level = Water_Level - 100
              if Water_Level <= 0 then
                Water_Level = 1
              end
              ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                local stack = Inventory[i]
                if stack.count > 0 then
                  stack.count  = stack.count - 1
                end
              end
              surface.set_tiles{{name = terrain_name_g1, position = new_position}}
              --- After sucessfully planting a tree or changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("can't change here")
              BioInd.writeDebug(tostring(k))
            end
          end
        elseif recipe_name == "bi-arboretum-r4" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Plant Tree AND change the terrain to grass-3 (basic)")
          local pos = ArboretumTable.base.position
          local surface = ArboretumTable.base.surface

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            local xxx = math.random(-plant_radius, plant_radius)
            local yyy = math.random(-plant_radius, plant_radius)
            local new_position = {x = pos.x + xxx, y = pos.y + yyy}
            local currentTilename = surface.get_tile(new_position.x, new_position.y).name
            local can_be_placed = surface.can_place_entity{
              name= "seedling",
              position = new_position,
              force = "neutral"
            }
            local things = 0 --stacks that are large enough
            local terrain_name_g1
            local terrain_name_g3

            if AlienBiomes then
              terrain_name_g1 = "vegetation-green-grass-1"
              terrain_name_g3 = "vegetation-green-grass-3"
            else
              terrain_name_g1 = "grass-1"
              terrain_name_g3 = "grass-3"
            end

            ---- Test to see if we can plant
            if can_be_placed and Bi_Industries.fertility[currentTilename] then
              --- Remove 100 Water
              Water_Level = Water_Level - 100
              if Water_Level <= 0 then
                Water_Level = 1
              end
              ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                local stack = Inventory[i]
                BioInd.writeDebug(tostring(i) .. " contains: " .. tostring(stack.name))
                if stack.count > 0 then
                  if stack.name == 'fertiliser' and Terrain_Check_1[currentTilename] then
                    BioInd.writeDebug("Don't deduct Fertilizer")
                  else
                    stack.count  = stack.count - 1
                  end
                end
              end

              if currentTilename ~= terrain_name_g1 then
                surface.set_tiles{{name = terrain_name_g3, position = new_position}}
              end
              local create_seedling = surface.create_entity({
                name = "seedling",
                position = new_position,
                force = "neutral"
              })
              --~ entity = create_seedling
              --~ seed_planted_arboretum (event, entity)
              seed_planted_arboretum (event, create_seedling)
              --- After sucessfully planting a tree or changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("can't plant or change terrain here")
              BioInd.writeDebug(tostring(k))
            end
          end
        elseif recipe_name == "bi-arboretum-r5" then
          BioInd.writeDebug(tostring(recipe_name) .. ": Plant Tree and change the terrain to grass-1 (advanced)")
          local pos = ArboretumTable.base.position
          local surface = ArboretumTable.base.surface

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
            local xxx = math.random(-plant_radius, plant_radius)
            local yyy = math.random(-plant_radius, plant_radius)
            local new_position = {x = pos.x + xxx, y = pos.y + yyy}
            local currentTilename = surface.get_tile(new_position.x, new_position.y).name
            local can_be_placed = surface.can_place_entity{
              name= "seedling",
              position = new_position,
              force = "neutral"
            }
            local terrain_name_g1
            local terrain_name_g3

            if AlienBiomes then
              terrain_name_g1 = "vegetation-green-grass-1"
              terrain_name_g3 = "vegetation-green-grass-3"
            else
              terrain_name_g1 = "grass-1"
              terrain_name_g3 = "grass-3"
            end

            if can_be_placed and Bi_Industries.fertility[currentTilename] then
              --- Remove 100 Water
              Water_Level = Water_Level - 100
              if Water_Level <= 0 then
                Water_Level = 1
              end
              ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                local stack = Inventory[i]
                if stack.count > 0 then
                  if stack.name == 'bi-adv-fertiliser' and Terrain_Check_2[currentTilename] then
                    BioInd.writeDebug("Don't deduct Adv Fertilizer")
                  else
                    stack.count  = stack.count - 1
                  end
                end
              end
              surface.set_tiles{{name = terrain_name_g1, position = new_position}}
              local create_seedling = surface.create_entity({
                name = "seedling",
                position = new_position,
                force = "neutral"
              })
              seed_planted_arboretum (event, create_seedling)
              --- After sucessfully planting a tree or changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("can't plant or change terrain here")
              BioInd.writeDebug(tostring(k))
            end
          end
        else
          BioInd.writeDebug("no recipe")
        end
      end
    end
  end
end
