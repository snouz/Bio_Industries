--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])

if not thxbob.lib.machine then thxbob.lib.machine = {} end


function thxbob.lib.machine.has_category(machine, category_in)
  local hasit = false
  if machine and machine.crafting_categories then
    for i, category in pairs(machine.crafting_categories) do
      if category == category_in then
        hasit = true
      end
    end
  end
  return hasit
end

function thxbob.lib.machine.add_category(machine, category)
  if machine and data.raw["recipe-category"][category] then
    if not machine.crafting_categories then
      machine.crafting_categories = {category}
    elseif not thxbob.lib.machine.has_category(machine, category) then
      table.insert(machine.crafting_categories, category)
    end
  else
    if not data.raw["recipe-category"][category] then
      BioInd.debugging.writeDebug("Crafting category %s does not exist.", {category})
    end
  end
end

function thxbob.lib.machine.if_add_category(machine, category, category_to_add)
  if machine and data.raw["recipe-category"][category] and data.raw["recipe-category"][category_to_add] then
    if thxbob.lib.machine.has_category(machine, category) then
      thxbob.lib.machine.add_category(machine, category_to_add)
    end
  else
    if not data.raw["recipe-category"][category] then
      BioInd.debugging.writeDebug("Crafting category %s does not exist.", {category})
    end
    if not data.raw["recipe-category"][category_to_add] then
      BioInd.debugging.writeDebug("Crafting category %s does not exist.", {category_to_add})
    end
  end
end

function thxbob.lib.machine.type_if_add_category(machine_type, category, category_to_add)
  if data.raw["recipe-category"][category] and data.raw["recipe-category"][category_to_add] then
    for i, machine in pairs(data.raw[machine_type]) do
      thxbob.lib.machine.if_add_category(machine, category, category_to_add)
    end
  else
    if not data.raw["recipe-category"][category] then
      BioInd.debugging.writeDebug("Crafting category %s does not exist.", {category})
    end
    if not data.raw["recipe-category"][category_to_add] then
      BioInd.debugging.writeDebug("Crafting category %s does not exist.", {category_to_add})
    end
  end
end


function thxbob.lib.machine.has_resource_category(machine, category_in)
  local hasit = false
  if machine and machine.resource_categories then
    for i, category in pairs(machine.resource_categories) do
      if category == category_in then
        hasit = true
      end
    end
  end
  return hasit
end

function thxbob.lib.machine.add_resource_category(machine, category)
  if machine and data.raw["resource-category"][category] then
    if not machine.resource_categories then
      machine.resource_categories = {category}
    elseif not thxbob.lib.machine.has_resource_category(machine, category) then
      table.insert(machine.resource_categories, category)
    end
  else
    if not data.raw["resource-category"][category] then
      BioInd.debugging.writeDebug("Resource category %s does not exist.", {category})
    end
  end
end

function thxbob.lib.machine.if_add_resource_category(machine, category, category_to_add)
  if machine and data.raw["resource-category"][category] and data.raw["resource-category"][category_to_add] then
    if thxbob.lib.machine.has_resource_category(machine, category) then
      thxbob.lib.machine.add_resource_category(machine, category_to_add)
    end
  else
    if not data.raw["resource-category"][category] then
      BioInd.debugging.writeDebug("Resource category %s does not exist.", {category})
    end
    if not data.raw["resource-category"][category_to_add] then
      BioInd.debugging.writeDebug("Resource category %s does not exist.", {category_to_add})
    end
  end
end

function thxbob.lib.machine.type_if_add_resource_category(machine_type, category, category_to_add)
  if data.raw["resource-category"][category] and data.raw["resource-category"][category_to_add] then
    for i, machine in pairs(data.raw[machine_type]) do
      thxbob.lib.machine.if_add_resource_category(machine, category, category_to_add)
    end
  else
    if not data.raw["resource-category"][category] then
      BioInd.debugging.writeDebug("Resource category %s does not exist.", {category})
    end
    if not data.raw["resource-category"][category_to_add] then
      BioInd.debugging.writeDebug("Resource category %s does not exist.", {category_to_add})
    end
  end
end
