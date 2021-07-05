------------------------------------------------------------------------------------
--                     Add resistances to our hidden entities                     --
------------------------------------------------------------------------------------
BI.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


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
local h_type
for h_key, h_names in pairs(BI.hidden_entities.types) do
  -- (h_type is not guaranteed to be a prototype type -- it's the short handle that we
  -- use in compound_entities.hidden!)
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
local b = compound and compound.base
local r = compound and compound and compound.hidden.radar

if b and r then
  local resistances = data.raw[b.type] and
                        data.raw[b.type][b.name] and
                        data.raw[b.type][b.name].resistances

  if resistances then
    data.raw[r.type][r.name].resistances = table.deepcopy(resistances)
    BioInd.writeDebug("Copied resistances from %s to %s!", {b.name, r.name})
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
