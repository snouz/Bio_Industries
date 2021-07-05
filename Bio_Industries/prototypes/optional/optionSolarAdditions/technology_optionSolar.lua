------------------------------------------------------------------------------------
--                           Enable: Bio solar additions                          --
--                        (BI.Settings.BI_Solar_Additions)                        --
------------------------------------------------------------------------------------
local setting = "BI_Solar_Additions"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

--~ if not BI.Settings.BI_Solar_Additions then
if not BI.Settings[setting] or
    (data.raw.technology["bob-solar-energy-2"] and data.raw.technology["bob-solar-energy-3"]) then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
--                               Create technologies                              --
------------------------------------------------------------------------------------
--~ for t_name, tech in pairs(BI.additional_techs[setting] or {}) do
  --~ data:extend({tech})
  --~ BioInd.created_msg(tech)
--~ end
BioInd.create_stuff(BI.additional_techs[setting])


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
