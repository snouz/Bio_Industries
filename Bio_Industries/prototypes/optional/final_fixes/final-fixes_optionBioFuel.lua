------------------------------------------------------------------------------------
--                           Enable: Bio fuel production                          --
--                            (BI.Settings.BI_Bio_Fuel)                           --
------------------------------------------------------------------------------------
local setting = "BI_Bio_Fuel"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

local BioInd = require('common')('Bio_Industries')

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

-- Make vanilla and Bio boilers exchangeable
local boilers = data.raw.boiler
local boiler_group = boilers["boiler"].fast_replaceable_group or "boiler"
local boiler

for b, b_name in ipairs({"boiler", "bi-bio-boiler"}) do
  boiler = boilers[b_name]
  boiler.fast_replaceable_group = boiler_group
  BioInd.modified_msg("fast_replaceable_group", boiler)
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
