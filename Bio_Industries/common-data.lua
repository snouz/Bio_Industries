log("Entered file " .. debug.getinfo(1).source)


--~ local common = {}
local common = require("common")('Bio_Industries')

log(serpent.block(common))
--~ error("Break!")
------------------------------------------------------------------------------------
-- Set pathnames
common.graphicsmod = "__Bio_Industries_NE_graphics__"
common.graphics = common.graphicsmod .. "/graphics"
common.iconpath = common.graphics .. "/icons/"
common.techiconpath = common.graphics .. "/technology/"
common.entitypath = common.graphics .. "/entities/"

common.soundpath = common.graphicsmod .. "/sound/"


------------------------------------------------------------------------------------
-- Table with the difficulties we may need to check
common.difficulties = {"", "normal", "expensive"}



------------------------------------------------------------------------------------
-- Sane values for collision masks
-- Default: {"item-layer", "object-layer", "rail-layer", "floor-layer", "water-tile"}
common.RAIL_BRIDGE_MASK = {"floor-layer", "object-layer", "consider-tile-transitions"}
--~ common.RAIL_BRIDGE_MASK = {"object-layer", "consider-tile-transitions"}

--~ -- "Transport Drones" removes "object-layer" from rails, so if bridges have only
--~ -- {"object-layer"}, their collision mask will be empty, and they can be built even
--~ -- over cliffs. So we need to add another layer to bridges ("floor-layer").
--~ -- As of Factorio 1.1.0, rails need to have "rail-layer" in their mask. This will work
--~ -- alright, but isn't available in earlier versions of Factorio, so we will use
--~ -- "floor-layer" there instead.
common.RAIL_BRIDGE_MASK = {"object-layer", "rail-layer", "consider-tile-transitions"}


-- Rails use basically the same mask as rail bridges, ...
common.RAIL_MASK = util.table.deepcopy(common.RAIL_BRIDGE_MASK)
-- ... we just need to add some layers so our rails have the same mask as vanilla rails.
table.insert(common.RAIL_MASK, "item-layer")
table.insert(common.RAIL_MASK, "water-tile")



------------------------------------------------------------------------------------
-- Set maximum_wire_distance of Power-to-rail connectors
common.POWER_TO_RAIL_WIRE_DISTANCE = 4



--~ ------------------------------------------------------------------------------------
--~ -- Get the value of a startup setting
--~ common.get_startup_setting = function(setting_name)
  --~ return settings and settings.startup[setting_name] and settings.startup[setting_name].value
--~ end

--~ ------------------------------------------------------------------------------------
--~ -- Get values of all startup settings
--~ common.get_startup_settings = function()
  --~ for var, name in pairs({
    --~ BI_Bio_Fuel                               = "BI_Bio_Fuel",
    --~ BI_Bio_Garden                             = "BI_Bio_Garden",
    --~ BI_Coal_Processing                        = "BI_Coal_Processing",
    --~ BI_Darts                                  = "BI_Darts",
    --~ BI_Disassemble                            = "BI_Disassemble",
    --~ BI_Explosive_Planting                     = "BI_Explosive_Planting",
    --~ BI_Rails                                  = "BI_Rails",
    --~ BI_Rubber                                 = "BI_Rubber",
    --~ BI_Power_Production                       = "BI_Power_Production",
    --~ BI_Stone_Crushing                         = "BI_Stone_Crushing",
    --~ BI_Terraforming                           = "BI_Terraforming",
    --~ BI_Wood_Gasification                      = "BI_Wood_Gasification",
    --~ BI_Wood_Products                          = "BI_Wood_Products",
    --~ Bio_Cannon                                = "BI_Bio_Cannon",
    --~ BI_Game_Tweaks_Bot                        = "BI_Game_Tweaks_Bot",
    --~ BI_Game_Tweaks_Easy_Bio_Gardens           = "BI_Game_Tweaks_Easy_Bio_Gardens",
    --~ BI_Game_Tweaks_Emissions_Multiplier       = "BI_Game_Tweaks_Emissions_Multiplier",
    --~ BI_Game_Tweaks_Fuel_Values                = "BI_Game_Tweaks_Fuel_Values",
    --~ BI_Game_Tweaks_Player                     = "BI_Game_Tweaks_Player",
    --~ BI_Game_Tweaks_Production_Science         = "BI_Game_Tweaks_Production_Science",
    --~ BI_Game_Tweaks_Recipe                     = "BI_Game_Tweaks_Recipe",
    --~ BI_Game_Tweaks_Small_Tree_Collisionbox    = "BI_Game_Tweaks_Small_Tree_Collisionbox",
    --~ BI_Game_Tweaks_Stack_Size                 = "BI_Game_Tweaks_Stack_Size",
    --~ BI_Game_Tweaks_Tree                       = "BI_Game_Tweaks_Tree",
    --~ BI_Debug_To_Game                          = "BI_Debug_To_Game",
    --~ BI_Debug_To_Log                           = "BI_Debug_To_Log",
  --~ }) do
    --~ BI.Settings[var] = common.get_startup_setting(name)
  --~ end
--~ end


--~ ------------------------------------------------------------------------------------
--~ -- There may be trees for which we don't want to create variations. These patterns
--~ -- are used to build a list of trees we want to ignore.
--~ common.tree_ignore_name_patterns        = {
  --~ -- Ignore our own trees
  --~ "bio%-tree%-.+%-%d",
  --~ -- Tree prototypes created by "Robot Tree Farm" or "Tral's Robot Tree Farm"
  --~ "rtf%-.+%-%d+",
  --~ -- Tree prototypes created by "Industrial Revolution 2"
  --~ ".*%-*ir2%-.+",
--~ }


------------------------------------------------------------------------------------
-- Check if a mod (or several mods, or any of several mods) is installed
-- modlist: Name(s) of mod(s) we need to check (string or array of strings)
-- mode:    Any ("or") or all ("and") mods in modlist must be active.
common.check_mods = function(modlist, mode)
  common.entered_function()
                    --~ {modlist or "nil", mode or "nil"})
  modlist = type(modlist) == "string" and {modlist} or
            type(modlist) == "table" and modlist or
            common.arg_err(modlist or "nil", "string or array of strings")
  mode = mode and mode:lower() or "or"

  local active_mods = script and script.active_mods or mods
  local ret

  for m, mod_name in pairs(modlist) do
    -- We've found a required mod_name!
    if active_mods[mod_name] then
      ret = true
      -- If mode is "or", we've struck gold!
      if mode == "or" then
        if #modlist > 1 then
          common.writeDebug("Mod %s has been found and mode is \"or\". Return: %s", {mod_name, ret})
        end
        break
      end
    -- Mod is not active
    else
      -- If mode is "and", the test has failed!
      ret = false
      if mode == "and" then
        if #modlist > 1 then
          common.writeDebug("Mod %s isn't active and mode is \"and\". Return: %s", {mod_name, ret})
        end
        break
      end
    end
  end
  --~ common.show("Return", ret)
  return ret
end


------------------------------------------------------------------------------------
--                                  MOD SPECIFIC                                  --
------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
-- Make prototype.icons from prototype.icon
------------------------------------------------------------------------------------
common.BI_add_icons = function()
  common.entered_function()
  common.writeDebug("Trying to convert \"icon\" to \"icons\"")

  for tab_name, tab in pairs(data.raw) do
    --~ common.writeDebug("Checking data.raw[%s]", {tab_name})
    for proto_type_name, proto_type in pairs(data.raw[tab_name] or {}) do
--~ common.show("proto_type.BI_add_icon", proto_type.BI_add_icon or "nil" )
      if proto_type.BI_add_icon then
        -- Prototype already has icons, but we still must bake the layers
        if proto_type.icons and proto_type.icons["it1"] then
          proto_type.icons = common.make_icons(proto_type.icons)

          proto_type.BI_add_icon = nil
          common.modified_msg("icons", proto_type, "Added")

        -- Prototype has icon, convert it to icons
        elseif proto_type.icon and not proto_type.icons then
          proto_type.icons = {
            {
              icon = proto_type.icon,
              icon_size = proto_type.icon_size,
              icon_mipmaps = proto_type.icon_mipmaps,
              scale = proto_type.scale
            }
          }
          proto_type.BI_add_icon = nil
        --~ common.writeDebug("Added \"icons\" property to data.raw[\"%s\"][\"%s\"]: %s",
                          --~ {tab_name, proto_type_name, proto_type.icons}, "line")
          common.modified_msg("icons", proto_type, "Added")
        end
      end
    end
  end
  common.entered_function("leave")
end



  common.make_icons = function(args)
    common.entered_function({args})

    local it = {}

    for i=1,10 do
      table.insert(it, {ite = args["it" .. i]} or {})
      it[i].sca = args["sc" .. i] or 1
      it[i].shi = args["sh" .. i] or {0,0}
    end

    local customicon_up = args.custom or nil
    local customicon_down = args.customunder or nil
    local custom_topright = args.custom_topright or nil

    local icontable = {{icon = common.iconpath .. "empty64.png", icon_size = 64, icon_mipmaps = 0, scale = 1, shift = {0,0}}}

    local function transform_item(it_name)
      local _type
      _type = it_name and (thxbob.lib.item.get_type(it_name) or thxbob.lib.item.get_type("bi-" .. it_name)) or nil
      return _type and (data.raw[_type][it_name] or data.raw[_type]["bi-" .. it_name]) or nil
    end

    if customicon_down then table.insert(icontable, {icon = customicon_down, icon_size = 64, mipmaps = 4, scale = 1, shift = {0,0}}) end

    for k=1, #it do
      local _item = it[k].ite or nil
      local _scale = it[k].sca or 1
      local _shift = it[k].shi or {0,0}

      if k==2 or k==7 then
        _scale = (_scale * 0.5)
        _shift = {(_shift[1] + 16),(_shift[2] - 16)}
      end
      if k==3 then
        _scale = (_scale * 0.5)
        _shift = {(_shift[1] - 16),(_shift[2] - 16)}
      end
      if k==4 then
        _scale = (_scale * 0.75)
        _shift = {(_shift[1] + 10),(_shift[2])}
      end
      if k==5 then
        _scale = (_scale * 0.75)
        _shift = {(_shift[1] - 10),(_shift[2])}
      end
      if k==6 then
        _scale = (_scale * 0.5)
        _shift = {(_shift[1] - 16),(_shift[2] + 16)}
      end

      _item = _item and transform_item(_item)
      if _item then
        if not _item.icon and _item.icons then
          for i=1,#_item.icons do
            local layer = {}
            local layershift = _item.icons[i].shift or {0,0}
            local relativescale = (64 / ((_item.icons[1].icon_size or 1) * (_item.icons[1].scale or 1)))
            local layerscale = _item.icons[i].scale or 1
            layer.icon = _item.icons[i].icon
            layer.icon_size = _item.icons[i].icon_size
            layer.icon_mipmaps = _item.icons[i].icon_mipmaps
            layer.shift = {(((layershift[1] * relativescale) * _scale)+ _shift[1]), (((layershift[2] * relativescale) * _scale) + _shift[2])}
            --layer.scale = _item.icons[i].scale or 1
            layer.scale = ((layerscale * relativescale) * _scale)
            if _item.icons[i].tint then layer.tint = _item.icons[i].tint end
            table.insert(icontable, layer)
          end
        else
          table.insert(icontable, {icon = _item.icon, icon_size = _item.icon_size, icon_mipmaps = _item.icon_mipmaps, scale = ((64 / _item.icon_size) * _scale), shift = _shift})
        end
      end
    end
    if customicon_up then table.insert(icontable, {icon = customicon_up, icon_size = 64, mipmaps = 4, scale = 1, shift = {0,0}}) end
    if custom_topright then table.insert(icontable, {icon = custom_topright, icon_size = 64, mipmaps = 4, scale = 0.4, shift = {20, -20}}) end

    common.entered_function("leave")
    return icontable
  end


------------------------------------------------------------------------------------
-- Combine icon mips to pictures
------------------------------------------------------------------------------------
common.add_pix = function(icon, count)
  local ret = {}
  for i = 1, count do
    ret[i] = {
      size = 64,
      filename = common.iconpath .. "mips/" .. icon .. "_" ..  i .. ".png",
      scale = 0.25
    }
  end
  return ret
end

------------------------------------------------------------------------------------
-- Exchange icons
------------------------------------------------------------------------------------
common.BI_change_icon = function(prototype, icon, ...)
  common.entered_function()
  common.check_args(icon, "string", "path to an icon")
  local proto_type = prototype and prototype.type or common.arg_err(prototype, "prototype")
  local proto_name = prototype and prototype.name or common.arg_err(prototype, "prototype")

  local icon_size, icon_mips = ...

  if data.raw[proto_type][proto_name] then
    prototype.icon = icon
    prototype.icon_size = icon_size or 64
    prototype.icon_mipmaps = icon_mips or prototype.icon_mipmaps or 0
    prototype.BI_add_icon = true

    common.modified_msg("icon", prototype)
  end
end


------------------------------------------------------------------------------------
--                       Add recipe unlocks to technologies                       --
------------------------------------------------------------------------------------
common.BI_add_unlocks = function()
  common.entered_function()
  local techs = data.raw.technology

  for r, recipe in pairs(data.raw.recipe) do
    -- There may be several techs that unlock a recipe!
    for t, tech in pairs(recipe.BI_add_to_tech or {}) do
      if techs[tech] then
        thxbob.lib.tech.add_recipe_unlock(tech, recipe.name)
        common.modified_msg("unlock for recipe " .. r, techs[tech], "Added")
      end
    end
    recipe.BI_add_to_tech = nil
  end
end


------------------------------------------------------------------------------------
--                       Add difficulty to all our recipes                        --
------------------------------------------------------------------------------------
common.BI_add_difficulty = function()
  common.entered_function()

  for r, recipe in pairs(BI.default_recipes) do
    thxbob.lib.recipe.difficulty_split(recipe)
    common.modified_msg("difficulties", recipe, "Added")
  end
  for l, recipe_list in pairs(BI.additional_recipes) do
    for r, recipe in pairs(recipe_list) do
      --~ thxbob.lib.recipe.difficulty_split(recipe)
      --~ common.modified_msg("difficulties", recipe, "Added")
      if thxbob.lib.recipe.difficulty_split(recipe) then
        common.modified_msg("difficulties", recipe, "Added")
      end
    end
  end

  common.entered_function("leave")
end

------------------------------------------------------------------------------------
--                           Make remnants for an entity                          --
------------------------------------------------------------------------------------
common.make_remnants_for_entity = function(remnants, entity)
  --~ common.entered_function()
  local pattern = "^" .. entity.name:gsub("%-", "%%-") .. "%-remnant"

  -- We want to extend single items as well as complete arrays!
  remnants = remnants and (remnants.type and remnants.name) and
              {remnants} or
              remnants

  for r, remnant in pairs(remnants or {}) do
    if remnant.name:match(pattern) then
      data:extend({remnant})
      common.created_msg(remnant)
      break
    end
  end
end

------------------------------------------------------------------------------------
--                                  Create things                                 --
------------------------------------------------------------------------------------
common.create_stuff = function(create_list)
  --~ common.entered_function()

  common.check_args (create_list, "table")

  -- We want to extend single items as well as complete arrays!
  create_list = (create_list.type and create_list.name) and {create_list} or create_list

  local ret = {}

  for entry, entry_data in pairs(create_list) do
    if not (data.raw[entry_data.type] and data.raw[entry_data.type][entry_data.name]) then
      data:extend({ table.deepcopy(entry_data) })
      BioInd.created_msg(entry_data)
    end
    ret[#ret + 1] = data.raw[entry_data.type] and
                    data.raw[entry_data.type][entry_data.name]
  end
  return ret
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
log("Leaving file " .. debug.getinfo(1).source)

return common
