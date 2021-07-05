------------------------------------------------------------------------------------
--           Trigger: Sort recipes into item-subgroups from other mods?           --
--    (Just creating the missing item-subgroups here, we'll add things later.)    --
--                       (BI.Triggers.BI_Trigger_Subgroups)                       --
------------------------------------------------------------------------------------
-- Mods: "5dim_core",
local trigger = "BI_Trigger_Subgroups"
if not BI.Triggers[trigger] then
  BioInd.nothing_to_do("*")
  return
else
  BioInd.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local item_groups       = data.raw["item-group"]
local item_subgroups    = data.raw["item-subgroup"]
local searchlist
local done_list = {}



------------------------------------------------------------------------------------
-- Create new subgroups
local function make_subgroup(subgroup, group, order)
  local create
  if subgroup and group then
    create = {
      type = "item-subgroup",
      name = subgroup,
      group = group,
      order = order
    }
    BioInd.create_stuff(create)
  end
end


------------------------------------------------------------------------------------
--        Look for any new item-subgroups we need to create for other mods        --
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- things:      Complete table with recipe definitions and possibly subtables
--              (e.g. BI.additional_recipes)
-- mod_handle:  string appended to the subgroup definitions
--              (e.g. "5d" --> item.subgroup_5d, item.subgroup_order_5d)
local function add_subgroups(things, mod_handle)

  BioInd.check_args(things, "table")
  BioInd.check_args(mod_handle, "string", "mod handle")


  local group           = "group_" .. mod_handle
  local subgroup        = "subgroup_" .. mod_handle

  -- Order of the subgroup in the item-group
  local subgroup_order  = "subgroup_order_" .. mod_handle

  local real_thing


  for l, list in pairs(things) do
    searchlist = (list.type or list.name) and {list} or list

    -- Things for which we have stored data in our table
    for t, thing in pairs(searchlist) do
      -- No need to proceed if something from our table hasn't been created!
      if data.raw[thing.type][thing.name] then
        -- Check if the groups we need (have stored in our table) exist or create them
        if thing[subgroup] and not item_subgroups[thing[subgroup]] then
          make_subgroup(thing[subgroup], thing[group], thing[subgroup_order])
        end
      end
    end
  end
end


------------------------------------------------------------------------------------
--                          Create groups for 5D's groups                         --
------------------------------------------------------------------------------------
--~ local mod_handle = "5d"

--~ BioInd.show("mod_handle", mod_handle)

--~ if mod_handle then
  for l, list in pairs({
    BI.default_items, BI.default_recipes,
    BI.additional_items, BI.additional_recipes,
  }) do

    --~ add_subgroups(list, mod_handle)
    add_subgroups(list, "5d")
  end
--~ end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
