----------------------------------------------------------------------------------
-- If "Early wooden defenses" (setting BI_Darts) is active, set the items players
-- get on starting a new game or on respawning!
----------------------------------------------------------------------------------
BioInd.entered_file()


----------------------------------------------------------------------------------
--                               Auxiliary functions                            --
----------------------------------------------------------------------------------
local function remove_items(items, remove_lists)
  --~ BioInd.entered_function({items, remove_lists})
  BioInd.entered_function()
  for l, list in pairs(remove_lists) do
    for name, n in pairs(list) do
      items[name] = nil
      -- Stop once we've removed everything from items!
      if not next(items) then
        break
      end
    end
  end

  BioInd.entered_function("leave")
  return items
end


local function add_items(items, new_items)
  --~ BioInd.entered_function({items, new_items})
  BioInd.entered_function()
  for l, list in pairs(new_items or {}) do

    -- Item
    if list.name and list.amount then
      items[list.name] = (items[list.name] or 0) + list.amount
    -- Arrays of items
    else
      items = add_items(items, list)
    end
  end

  BioInd.entered_function("leave")
  return items
end


local function get_items(what)
  BioInd.entered_function({what})
BioInd.show("remote.interfaces[\"ir2-world\"]", remote.interfaces["ir2-world"])
  return
    (remote.interfaces["ir2-world"] and remote.call("ir2-world", "get-crate-items")) or
    (remote.interfaces["freeplay"] and remote.call("freeplay", "get_" .. what .. "_items"))
end


local function set_items(items, what)
  BioInd.entered_function({items, what})
BioInd.show("remote.interfaces[\"ir2-world\"]", remote.interfaces["ir2-world"])
  return
    (remote.interfaces["ir2-world"] and remote.call("ir2-world", "set-crate-items", items)) or
    (remote.interfaces["freeplay"] and remote.call("freeplay", "set_" .. what .. "_items", items))
end


----------------------------------------------------------------------------------
-- If "Early wooden defenses" (setting BI_Darts) is active, set the items players
-- get on starting a new game or on respawning!
----------------------------------------------------------------------------------
--~ BioInd.change_startup_items = function()
local change_startup_items = function()
  BioInd.entered_function()

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
BioInd.show(l, list)
    for a, ammo in ipairs(list) do
      k[ammo.name] = true
    end
  end
  -- Convert to list that can be used for filtering
  for ammo, a in pairs(k) do
    keep_ammo[#keep_ammo + 1] = ammo
  end
BioInd.show("keep_ammo", keep_ammo)

  -- All available weapons except new_gun
  local remove_guns = game.get_filtered_item_prototypes({
    {filter = "type", type = "gun"},
    {filter = "name", name = new_gun.name, invert = true, mode = "and"}
  })
  -- All available ammo except keep_ammo
  local remove_ammo = game.get_filtered_item_prototypes({
    {filter = "type", type = "ammo"},
    {filter = "name", name = keep_ammo, invert = true, mode = "and"}
  })

  local items

  ----------------------------------------------------------------------------------
  -- Replace stuff!
BioInd.writeDebug("Read data -- checking for remote interfaces now!")

  -- Industrial Revolution 2
  if remote.interfaces["ir2-world"] then
    BioInd.writeDebug("Found remote interfaces of IR2.")

    items = remove_items(get_items(), {remove_guns, remove_ammo})
    new_ammo.respawn = nil
    set_items(add_items(items, {new_gun, new_ammo}))

  -- Vanilla game
  elseif remote.interfaces["freeplay"] then
    BioInd.writeDebug("Using default remote interfaces.")
    -- New gun must be added first, so that ammo will be placed in the player's
    -- ammo slot!
    items = add_items(get_items("created"), {new_gun})
    set_items(items, "created")

    -- Add ammo to everything!
    for what, add_ammo in pairs(new_ammo) do
      items = remove_items(get_items(what), {remove_guns, remove_ammo})
      set_items(add_items(items, add_ammo), what)
    end
  end

  BioInd.entered_function("leave")
end



----------------------------------------------------------------------------------
--                                   END OF FILE                                --
----------------------------------------------------------------------------------
BioInd.entered_file("leave")

return change_startup_items
