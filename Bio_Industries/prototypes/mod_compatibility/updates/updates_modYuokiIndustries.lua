------------------------------------------------------------------------------------
--                                Yuoki Industries                                --
------------------------------------------------------------------------------------
local mod_name = "Yuoki"
if not BioInd.check_mods(mod_name) then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local category = BI.additional_categories.BI_Stone_Crushing.crushing
local assemblers = data.raw["assembling-machine"]


------------------------------------------------------------------------------------
--         Allow our stone-crushing recipes to be made in Yuoki's crushers
------------------------------------------------------------------------------------
if data.raw[category.type][category.name] then

  for c, crusher in ipairs({"y-crusher", "y_crusher2"}) do
    if assemblers[crusher] then
      table.insert(assemblers[crusher].crafting_categories, category.name)
      BioInd.debugging.modified_msg("category \"" .. category.name .. "\"", assemblers[crusher], "Added")
    end
  end
end

------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
