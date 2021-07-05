------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ENTITYPATH = BioInd.entitypath
local ICONPATH = BioInd.iconpath

local entity


------------------------------------------------------------------------------------
--                               Auxiliary functions                              --
------------------------------------------------------------------------------------
-- Find ties
function find_ties (table_name, table, entity_type)
  if not (type(table) == "table") then
    return
  end
  -- only tables
  if table_name == "ties" then
    -- we have found ties
    return true
  end
  for i, v in pairs (table) do
    -- probably lower can be ties
    local cash = find_ties(i, v, entity_type)
    -- if we have found ties then
    if cash then
      local new_name = string.gsub(table_name, '_', '-') -- ohh! All names have '-' in the name
      BI.global[entity_type][#BI.global[entity_type] + 1] = {name = new_name, table = v}
    end
  end
end


-- Tint rails
function set_tint_to_rails (rails_entities, tint)
  -- two tables:
  -- first table is a list of elements
  -- second is a tint
  --local wood_tint = {r = 183/255, g = 125/255, b = 62/255, a = 1}
  --local concrete_tint = {r = 183/255, g = 183/255, b = 183/255, a = 1}
  --~ local tint = tint
  local sheet_path_ties = ENTITYPATH .. "wood_products/rails/ties/"
  local rails_entities = rails_entities or  -- or vanilla
    {
      data.raw["straight-rail"]["straight-rail"],
      data.raw["curved-rail"]["curved-rail"]
    }
  BI.global = BI.global or {}
  BI.global["rails"] = {}
  --BioInd.writeDebug("Start rails")    ---------------------
  for i, v in pairs (rails_entities) do
    local r_table = serpent.block(find_ties(i, v, "rails"))
  end
  --BioInd.writeDebug("BI.global table of rails is complete: %s", {#BI.global.rails})
  for i, handler in pairs (BI.global.rails) do
    --handler.name = "straight_rail_horizontal"
    local was_filename = handler.table.filename
    handler.table.filename = sheet_path_ties .. handler.name .. "-ties.png"
    handler.table.hr_version.filename = sheet_path_ties .. "hr-" .. handler.name .. "-ties.png"
    BioInd.writeDebug('Replaced: %s ===>>> %s', {was_filename, handler.table.filename})
    handler.table.tint = tint
    handler.table.hr_version.tint = tint -- oops, i've forgot it, added in 0.0.3
  end
  --BioInd.writeDebug("End rails")        ---------------------
end


-- Tint rail remnants
function set_tint_to_remnants(remnants_entities, tint)  -- tha same function, actually
local sheet_path_ties = ENTITYPATH .. "wood_products/rails/ties/"
local remnants_entities = remnants_entities or {  -- or vanilla  {
  data.raw["rail-remnants"]["straight-rail-remnants"],
  data.raw["rail-remnants"]["curved-rail-remnants"]
}
BI.global = BI.global or {}
BI.global["remnants"] = {}
--BioInd.writeDebug("Start remnants")         ---------------------
for i, v in pairs (remnants_entities) do
  local r_table = serpent.block(find_ties(i, v, "remnants"))
end
--BioInd.writeDebug("BI.global table of remnants is complete: %s", {#BI.global.remnants})
for i, handler in pairs (BI.global.remnants) do
  --remnants.name = "straight_rail_horizontal"
  local was_filename = handler.table.filename
  handler.table.filename = sheet_path_ties .. handler.name .. "-ties-remnants.png"
  handler.table.hr_version.filename = sheet_path_ties .. "hr-" .. handler.name .. "-ties-remnants.png"
  BioInd.writeDebug('Replaced: %s ===>>> %s', {was_filename, handler.table.filename})
  handler.table.tint = tint
  handler.table.hr_version.tint = tint -- oops, i'mm forgot it, added in 0.0.3
end
--BioInd.writeDebug("End remnants")           ---------------------
end


------------------------------------------------------------------------------------
--                             Actually tint the rails                            --
------------------------------------------------------------------------------------
-- Concrete rails (Update vanilla rails to use and look like concrete)
local straight = data.raw["straight-rail"]
local curved = data.raw["curved-rail"]
local remnants = data.raw["rail-remnants"]

set_tint_to_rails(
  {
    straight["straight-rail"],
    curved["curved-rail"]
  },
  {r = 183/255, g = 183/255, b = 183/255, a = 1}
)

-- Remnants of Concrete rails
set_tint_to_remnants(
  {
    remnants["straight-rail-remnants"],
    remnants["curved-rail-remnants"]
  },
  {r = 183/255, g = 183/255, b = 183/255, a = 1}
)

-- Wooden rails
set_tint_to_rails(
  {
    straight["bi-straight-rail-wood"],
    curved["bi-curved-rail-wood"]
  },
  {r = 183/255, g = 125/255, b = 62/255, a = 1}
)

-- Remnants of Wooden rails
set_tint_to_remnants(
  {
    remnants["straight-rail-wood-remnants"],
    remnants["curved-rail-wood-remnants"]
  },
  {r = 183/255, g = 125/255, b = 62/255, a = 1}
)

-- Powered rails
set_tint_to_rails(
  {
    straight["straight-rail"],
    curved["curved-rail"]
  },
  {r = 150/255, g = 150/255, b = 150/255, a = 1}
) -- mix


------------------------------------------------------------------------------------
--                          Update icons of vanilla rails                         --
------------------------------------------------------------------------------------
local icon_map = {
  ["straight-rail"]     = {"straight-rail",     "entity/rail-concrete.png"},
  ["curved-rail"]       = {"curved-rail",       "entity/rail-concrete-curved.png"},
  ["rail-planner"]      = {"rail",              "entity/rail-concrete.png"}
}
for r_type, r_data in pairs(icon_map) do
  BioInd.BI_change_icon(data.raw[r_type][r_data[1]], ICONPATH .. r_data[2])
end


------------------------------------------------------------------------------------
--                          Change order of vanilla rails                         --
------------------------------------------------------------------------------------
entity = data.raw["rail-planner"]["rail"]
entity.order = "a[train-system]-a[rail1]"
BioInd.modified_msg("order", entity)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
