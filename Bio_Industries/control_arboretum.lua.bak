local BioInd = require('common')('Bio_Industries')

BioInd.writeDebug("Entered control_arboretum.lua")

---Arboretum Stuff

--~ local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(true)
local Event = require('__stdlib__/stdlib/event/event').set_protected_mode(false)

local Terrain_Check_1 = {
  ["landfill"] = true,
  ["grass-1"] = true,
  ["grass-3"] = true,
  ["vegetation-green-grass-1"] = true,
  ["vegetation-green-grass-3"] = true,
}

local Terrain_Check_2 = {
  ["landfill"] = true,
  ["grass-1"] = true,
  ["vegetation-green-grass-1"] = true,
}



function Get_Arboretum_Recipe(ArboretumTable, event)
BioInd.writeDebug("Entered function Get_Arboretum_Recipe!\nArboretumTable: %s\tevent: %s", {ArboretumTable, event})
  --~ if ArboretumTable == nil then
    --~ global.Arboretum_Table = {}
    --~ return
  if not ArboretumTable then
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
          BioInd.writeDebug("%s: Just plant a tree", {recipe_name})
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
                  stack.count = stack.count - 1
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
              BioInd.writeDebug("Can't plant here!")
              BioInd.writeDebug("%s", {k})
            end
          end
        elseif recipe_name == "bi-arboretum-r2" then
          BioInd.writeDebug("%s: Just change terrain to grass-3 (basic)", {recipe_name})
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
              BioInd.writeDebug("Can't change terrain here!")
              BioInd.writeDebug(tostring(k))
            end
          end
        elseif recipe_name == "bi-arboretum-r3" then
          BioInd.writeDebug("%s: Just change terrain to grass-1 (advanced)", {recipe_name})
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
              BioInd.writeDebug("Can't change terrain here!")
              BioInd.writeDebug(tostring(k))
            end
          end
        elseif recipe_name == "bi-arboretum-r4" then
          BioInd.writeDebug("%s: Plant Tree AND change the terrain to grass-3 (basic)", {recipe_name})
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
                BioInd.writeDebug("%i contains: %s", {i, stack.name})
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
          BioInd.writeDebug("%s: Plant Tree and change the terrain to grass-1 (advanced)", {recipe_name})
          local pos = ArboretumTable.base.position
          local surface = ArboretumTable.base.surface
          --~ local terrain_name_g1
          --~ local terrain_name_g3
          local terrain_name_g1 = AlienBiomes and "vegetation-green-grass-1" or "grass-1"
          local terrain_name_g3 = AlienBiomes and "vegetation-green-grass-3" or "grass-3"
          local xxx, yyy
          local new_position, currentTilename, can_be_placed

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
BioInd.writeDebug("Attempt %g to place tree: %s\tFertility: %s", {k, can_be_placed, Bi_Industries.fertility[currentTilename] or "not available"})

            if can_be_placed and Bi_Industries.fertility[currentTilename] then
BioInd.writeDebug("Removing water")
              --- Remove 100 Water
              Water_Level = Water_Level - 100
              if Water_Level <= 0 then
                Water_Level = 1
              end
              ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}
BioInd.writeDebug("Water contents: %s", {ArboretumTable.base.fluidbox[1]})

              --- remove 1 inventory item
BioInd.writeDebug("Removing inventory item")
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                local stack = Inventory[i]
                if stack.count > 0 then
                  if stack.name == 'bi-adv-fertiliser' and Terrain_Check_2[currentTilename] then
BioInd.writeDebug("Don't deduct Adv Fertilizer")
                  else
                    stack.count  = stack.count - 1
BioInd.writeDebug("Removed: %s\tstack.count: %s", {stack.name, stack.count})
                  end
                end
              end
              surface.set_tiles{{name = terrain_name_g1, position = new_position}}
              local create_seedling = surface.create_entity({
                name = "seedling",
                position = new_position,
                force = "neutral"
              })
BioInd.writeDebug("Created seedling")
              seed_planted_arboretum(event, create_seedling)
              --- After sucessfully planting a tree or changing the terrain, break out of the loop.
              break
            else
              BioInd.writeDebug("Can't plant or change terrain here!")
              BioInd.writeDebug(tostring(k))
            end
          end
        else
          BioInd.writeDebug("No recipe!")
        end
      end
    end
  end
end


function Get_Arboretum_Recipe_omnimatter_fluid(ArboretumTable, event)
  --~ if ArboretumTable == nil then
    --~ global.Arboretum_Table = {}
    --~ return
  if not ArboretumTable then
    return
  else

    local AlienBiomes = BioInd.AB_tiles()
    local recipe = ArboretumTable.base.get_recipe()

    if recipe ~= nil then --and ArboretumTable.base.fluidbox[1] ~= nil then
      --local Water_Name = ArboretumTable.base.fluidbox[1].name
      --local Water_Level = ArboretumTable.base.fluidbox[1].amount
      local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
      local pass_qc = true

      for i = 1, #Inventory do
        if not Inventory[i].valid_for_read then
          pass_qc = false
          break
        end
      end

      --if Water_Name == "water" and Water_Level >= 100 and pass_qc then
      if pass_qc then
        local plant_radius = 75   -- Radius the building looks for areas to plant trees/change the terrain
        local recipe_name = ArboretumTable.base.get_recipe().name

        if recipe_name == "bi-arboretum-r1" then
          BioInd.writeDebug("%s: Just plant a tree", {recipe_name})
          local pos = ArboretumTable.base.position
          local surface = ArboretumTable.base.surface

          local xxx, yyy
          local new_position, can_be_placed

          for k = 1, 10 do --- 10 attempts to find a random spot to plant a tree and / or change terrain
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
              --Water_Level = Water_Level - 100
              --ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
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
          BioInd.writeDebug("%s: Just change terrain to grass-3 (basic)", {recipe_name})
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
              --Water_Level = Water_Level - 100
              --ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                local stack = Inventory[i]
                if stack.count > 0 then
                  stack.count  = stack.count - 1
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
          BioInd.writeDebug("%s: Just change terrain to grass-1 (advanced)", {recipe_name})
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

            if Bi_Industries.fertility[currentTilename] and currentTilename ~= terrain_name_g1 then
              --- Remove 100 Water
              --Water_Level = Water_Level - 100
              --ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

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
          BioInd.writeDebug("%s: Plant Tree AND change the terrain to grass-3 (basic)", {recipe_name})
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
              --Water_Level = Water_Level - 100
              --ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

              --- remove 1 inventory item
              local Inventory = ArboretumTable.base.get_inventory(defines.inventory.assembling_machine_input)
              for i = 1, #Inventory do
                local stack = Inventory[i]
                BioInd.writeDebug("%s contains: %s", {i, stack.name})
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
          BioInd.writeDebug("%s: Plant Tree and change the terrain to grass-1 (advanced)", {recipe_name})
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
              -- Remove 100 Water
              --Water_Level = Water_Level - 100
              --ArboretumTable.base.fluidbox[1] = {name = 'water', amount = Water_Level}

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
