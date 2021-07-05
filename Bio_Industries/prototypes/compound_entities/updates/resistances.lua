------------------------------------------------------------------------------------
--                     Add resistances to our hidden entities                     --
------------------------------------------------------------------------------------
BI.entered_file()

local BioInd = require('common')('Bio_Industries')

local ICONPATH = BioInd.iconpath


------------------------------------------------------------------------------------
-- Make resistances for each damage type
local resistances = {}
for damage, d in pairs(data.raw["damage-type"]) do
  resistances[#resistances + 1] = {
    type = damage,
    percent = 100
  }
end

-- Add resistances to prototypes
-- (h_type is not guaranteed to be a prototype type -- it's the short handle that we
-- use compound_entities.hidden!)
local h_type
for h_key, h_names in pairs(BI.hidden_entities.types) do
  h_type = BioInd.HE_map[h_key]
  for h_name, h in pairs(h_names) do
--~ -- BioInd.writeDebug("h_type: %s\th_name: %s\th:%s", {h_type, h_name, h})
    data.raw[h_type][h_name].resistances = resistances
    BioInd.writeDebug("Added resistances to %s (%s): %s",
                      {h_name, h_type, data.raw[h_type][h_name].resistances})
  end
end

------------------------------------------------------------------------------------
-- Adjust resistances for radar of the terraformers. Unlike the other hidden parts
-- of compound entities, this one is visible, and should suffer the same as the base
-- when it gets hurt. (Also, damaging the radar will damage the base entity as well.)
local compound = BioInd.compound_entities["bi-arboretum"]
local b = compound.base
local r = compound.hidden.radar
if b and r then
  local resistances = data.raw[b.type][b.name].resistances
  if resistances then
    data.raw[r.type][r.name].resistances = util.table.deepcopy(resistances)
    BioInd.writeDebug("Copied resistances from %s to %s!", {b.name, r.name})
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
