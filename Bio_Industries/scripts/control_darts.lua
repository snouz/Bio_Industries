------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--        If "Early wooden defenses" (setting BI_Darts) are toggled, change       --
--         the items players get on starting a new game or on respawning!         --
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
BioInd.debugging.entered_file()

local BI_darts = {}

------------------------------------------------------------------------------------
--                           Local variables and tables                           --
------------------------------------------------------------------------------------

  ----------------------------------------------------------------------------------
  -- Make list of available/replacement weapons and ammo
  local new_gun = {name = "bi-dart-rifle", amount = 1}
  local new_ammo = {
    -- Item distribution for vanilla game:
    created = {
      -- This is the total amount of items the player will get. If items set here
      -- are also placed in "debris" or "ship", they will be taken from the
      -- "created" items. See data.base.scenarios.freeplay.freeplay:
      -- local on_player_created = function(event)
      -- util.insert_safe(player, global.created_items)
      -- util.remove_safe(player, global.crashed_ship_items)
      -- util.remove_safe(player, global.crashed_debris_items)
      {name = "bi-dart-magazine-basic",    amount = 10},
      {name = "bi-dart-magazine-standard", amount = 5},
      {name = "bi-dart-magazine-enhanced", amount = 2},
      {name = "bi-dart-magazine-poison",   amount = 1},
    },
    respawn = {
      {name = "bi-dart-magazine-basic",    amount = 10},
    },
    ship ={
      {name = "bi-dart-magazine-basic",    amount = 2},
      {name = "bi-dart-magazine-standard", amount = 1},
    },
    debris = {
      {name = "bi-dart-magazine-basic",    amount = 6},
      {name = "bi-dart-magazine-standard", amount = 4},
      {name = "bi-dart-magazine-enhanced", amount = 2},
      {name = "bi-dart-magazine-poison",   amount = 1},
    },
  }
  -- Used for filtering item prototypes
  local k, keep_ammo = {}, {}
  -- Make dictionary so every item is only listed once
  for l, list in pairs(new_ammo) do
BioInd.debugging.show(l, list)
    for a, ammo in ipairs(list) do
      k[ammo.name] = true
    end
  end
  -- Convert to list that can be used for filtering
  for ammo, a in pairs(k) do
    keep_ammo[#keep_ammo + 1] = ammo
  end
 BioInd.debugging.show("keep_ammo", keep_ammo)


------------------------------------------------------------------------------------
--                                Auxiliary functions                             --
------------------------------------------------------------------------------------

-- These guns should be removed from startup items
local make_remove_guns_list = function()
  return game.get_filtered_item_prototypes({
    {filter = "type", type = "gun"},
    {filter = "name", name = new_gun.name, invert = true, mode = "and"}
  })
end

-- These ammo types should be removed from startup items
local make_remove_ammo_list = function()
  return game.get_filtered_item_prototypes({
    {filter = "type", type = "ammo"},
    {filter = "name", name = keep_ammo, invert = true, mode = "and"}
  })
end



-- Remove items from a dictionary (the format used by the get/set functions)
local function remove_items(items, remove_lists)
  --~ BioInd.debugging.entered_function({items, remove_lists})
  BioInd.debugging.entered_function()
  for l, list in pairs(remove_lists) do
    for name, n in pairs(list) do
      items[name] = nil
      -- Stop once we've removed everything from items!
      if not next(items) then
        break
      end
    end
  end

  BioInd.debugging.entered_function("leave")
  return items
end


-- Add items to a dictionary (the format used by the get/set functions).
-- If the dictionary already contains the item, increase its amount!
local function add_items(items, new_items)
  --~ BioInd.debugging.entered_function({items, new_items})
  BioInd.debugging.entered_function()
  for l, list in pairs(new_items or {}) do

    -- Item
    if list.name and list.amount then
      items[list.name] = (items[list.name] or 0) + list.amount
    -- Arrays of items
    else
      items = add_items(items, list)
    end
  end

  BioInd.debugging.entered_function("leave")
  return items
end


-- Add new items to a dictionary (the format used by the get/set functions).
-- Only add items that are not yet in the dictionary!
local function add_new_items(items, new_items)
  BioInd.debugging.entered_function({items, new_items})
  for l, list in pairs(new_items or {}) do

    -- Item
    if list.name and list.amount then
      items[list.name] = items[list.name] or list.amount
    -- Arrays of items
    else
      items = add_new_items(items, list)
    end
  end

  BioInd.debugging.entered_function("leave")
  return items
end


-- Combine two raw lists
local function combine_raw_lists(list_a, list_b)
  BioInd.debugging.entered_function({list_a, list_b})

  local ret = {}
  for name, amount in pairs(add_items({}, {list_a, list_b})) do
    ret[#ret + 1] = {name = name, amount = amount}
  end

  BioInd.debugging.entered_function("leave")
  return ret
end


-- Get the startup items from the scenario
local function get_items(what)
  BioInd.debugging.entered_function({what})

  return
    (remote.interfaces["ir2-world"] and remote.call("ir2-world", "get-crate-items")) or
    (remote.interfaces["freeplay"] and remote.call("freeplay", "get_" .. what .. "_items"))
end

-- Set new startup items for the scenario
local function set_items(items, what)
  BioInd.debugging.entered_function({items, what})

  return
    (remote.interfaces["ir2-world"] and remote.call("ir2-world", "set-crate-items", items)) or
    (remote.interfaces["freeplay"] and remote.call("freeplay", "set_" .. what .. "_items", items))
end


------------------------------------------------------------------------------------
-- If "Early wooden defenses" (setting BI_Darts) is active, set the items players --
-- get on starting a new game or on respawning!                                   --
------------------------------------------------------------------------------------
BI_darts.use_darts = function()
  BioInd.debugging.entered_function()

  BioInd.debugging.writeDebug("Replacing weapons and ammo with dart rifle and darts.")

  local remove_guns = make_remove_guns_list()
  local remove_ammo = make_remove_ammo_list()
  local items


  ----------------------------------------------------------------------------------
  -- Replace stuff!
  --~ BioInd.debugging.writeDebug("Read data -- checking for remote interfaces now!")

  -- Industrial Revolution 2
  if remote.interfaces["ir2-world"] then
    BioInd.debugging.writeDebug("Found remote interfaces of IR2.")

    -- Replace weapons/ammo with dart rifle and darts
    items = remove_items(get_items(), {remove_guns, remove_ammo})
    -- IR2 doesn't support respawn items
    new_ammo.respawn = nil
    -- Always add items for "created"
    items = add_items(items, {new_gun, new_ammo.created})
    -- IR2 lumps items for "created"/"ship"/"debris" together, so we only want to
    -- add items from "ship"/"debris" that are not in "created" (add_new_items).
    -- However, we must first merge the "ship" and "debris" lists because they may
    -- contain identical items which are not in "created" (combine_raw_lists)!
    set_items(add_new_items(items, {combine_raw_lists(new_ammo.ship, new_ammo.debris)}))

  -- Vanilla game
  elseif remote.interfaces["freeplay"] then
    BioInd.debugging.writeDebug("Using default remote interfaces.")

    -- New gun must be added first, so that ammo will be placed in the player's
    -- ammo slot!
    for w, what in pairs({"created", "respawn" }) do
      items = get_items(what)
      BioInd.debugging.show("items", items)
      items = add_items(items, {new_gun})
      BioInd.debugging.show("items", items)
      set_items(items, what)
    end

    -- Add ammo to everything!
    for what, add_ammo in pairs(new_ammo) do
      items = remove_items(get_items(what), {remove_guns, remove_ammo})
      set_items(add_items(items, add_ammo), what)
    end
  end

  BioInd.debugging.entered_function("leave")
end


-- Reset weapons/ammo to defaults (depending on active scenario)
BI_darts.use_defaults = function()

  local items

  -- Use IR2 defaults
  if remote.interfaces["ir2-world"] then
    BioInd.debugging.writeDebug("Restoring crate items from IR2.")
    items = get_items()
    set_items(items)

  -- Vanilla Freeplay scenario
  elseif remote.interfaces["freeplay"] then
    BioInd.debugging.writeDebug("Restoring default items for vanilla Freeplay scenario.")

    for where, what in pairs(new_ammo) do
      items = get_items(where)
      set_items(items, where)
    end
  end
end

----------------------------------------------------------------------------------
--                                   END OF FILE                                --
----------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")

return BI_darts
