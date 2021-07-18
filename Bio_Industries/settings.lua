local setting_list = {}

------------------------------------------------------------------------------------
--                        Enable different technology trees                       --
------------------------------------------------------------------------------------
setting_list.BI_Bio_Cannon = {
  type = "bool-setting",
  name = "BI_Bio_Cannon",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-a-[weapons]-[BI_Bio_Cannon]",
}

setting_list.BI_Darts = {
  type = "bool-setting",
  name = "BI_Darts",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-a-[weapons]-[BI_Darts]",
}

setting_list.BI_Bio_Fuel = {
  type = "bool-setting",
  name = "BI_Bio_Fuel",
  localised_name = {"mod-setting-name.BI_Bio_Fuel", {"fluid-name.bi-biomass"}},
  localised_description = {
    "mod-setting-description.BI_Bio_Fuel",
    {"", {"fluid-name.crude-oil"}, ", ", {"fluid-name.petroleum-gas"}, " etc."},
    {"fluid-name.bi-biomass"}
  },
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-b-[resources]-[Bio_Fuel]",
}

setting_list.BI_Coal_Processing = {
  type = "bool-setting",
  name = "BI_Coal_Processing",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-b-[resources]-[BI_Coal_Processing]",
}

setting_list.BI_Stone_Crushing = {
  type = "bool-setting",
  name = "BI_Stone_Crushing",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-b-[resources]-[BI_Stone_Crushing]",
}

setting_list.BI_Bio_Garden = {
  type = "bool-setting",
  name = "BI_Bio_Garden",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-c-[planting]-[BI_Bio_Garden]",
}
setting_list.BI_Explosive_Planting = {
  type = "bool-setting",
  name = "BI_Explosive_Planting",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-c-[planting]-[BI_Explosive_Planting]",
}

setting_list.BI_Terraforming = {
  type = "bool-setting",
  name = "BI_Terraforming",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-c-[planting]-[BI_Terraforming]",
}


setting_list.BI_Power_Production = {
  type = "bool-setting",
  name = "BI_Power_Production",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-d-[production]-[BI_Power_Production]",
}


setting_list.BI_Rails = {
  type = "bool-setting",
  name = "BI_Rails",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-d-[production]-[BI_Rails]",
}


-- Chests, pipes, poles
setting_list.BI_Wood_Products = {
  type = "bool-setting",
  name = "BI_Wood_Products",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-d-[production]-[BI_Wood_Products]",
}


setting_list.BI_Pollution_Detector = {
  type = "bool-setting",
  name = "BI_Pollution_Detector",
  setting_type = "startup",
  default_value = true,
  order = "a[enable]-e-[utility]-[BI_Pollution_Detector]",
}


------------------------------------------------------------------------------------
--                                   Game tweaks                                  --
------------------------------------------------------------------------------------
setting_list.BI_Game_Tweaks_Easy_Bio_Gardens = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Easy_Bio_Gardens",
  setting_type = "startup",
  default_value = false,
  order = "a[tweaks]-a-[planting]-[BI_Game_Tweaks_Easy_Bio_Gardens]",
}

setting_list.BI_Game_Tweaks_Tree = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Tree",
  setting_type = "startup",
  default_value = true,
  order = "b[tweaks]-a-[planting]-[BI_Game_Tweaks_Tree]",
}

setting_list.BI_Game_Tweaks_Small_Tree_Collisionbox = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Small_Tree_Collisionbox",
  setting_type = "startup",
  default_value = true,
  order = "b[tweaks]-a-[planting]-[BI_Game_Tweaks_Small_Tree_Collisionbox]",
}

setting_list.BI_Game_Tweaks_Emissions_Multiplier = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Emissions_Multiplier",
  setting_type = "startup",
  default_value = true,
  order = "b[tweaks]-b-[production]-[BI_Game_Tweaks_Emissions_Multiplier]",
}

setting_list.BI_Game_Tweaks_Fuel_Values = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Fuel_Values",
  setting_type = "startup",
  default_value = true,
  order = "b[tweaks]-b-[production]-[BI_Game_Tweaks_Fuel_Values]",
}

setting_list.BI_Game_Tweaks_Easy_Bio_Gardens = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Easy_Bio_Gardens",
  setting_type = "startup",
  default_value = false,
  order = "a[tweaks]-a-[planting]-[BI_Game_Tweaks_Easy_Bio_Gardens]",
}

setting_list.BI_Game_Tweaks_Recipe = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Recipe",
  setting_type = "startup",
  default_value = false,
  order = "b[tweaks]-b-[production]-[BI_Game_Tweaks_Recipe]",
}

--~ setting_list.BI_Game_Tweaks_Production_Science = {
  --~ type = "bool-setting",
  --~ name = "BI_Game_Tweaks_Production_Science",
  --~ setting_type = "startup",
  --~ default_value = true,
  --~ order = "b[tweaks]-b-[production]-[BI_Game_Tweaks_Production_Science]",
--~ }

setting_list.BI_Game_Tweaks_Show_musk_floor_in_mapview = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Show_musk_floor_in_mapview",
  setting_type = "startup",
  default_value = true,
  order = "b[tweaks-b-[production]-[Musk_floor]",
}

setting_list.BI_Game_Tweaks_Player = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Player",
  setting_type = "startup",
  default_value = false,
  order = "b[tweaks]-c[BI_Game_Tweaks_Player]",
}

setting_list.BI_Game_Tweaks_Bot = {
  type = "bool-setting",
  name = "BI_Game_Tweaks_Bot",
  setting_type = "startup",
  default_value = false,
  order = "b[tweaks]-c[BI_Game_Tweaks_Bot]",
}


------------------------------------------------------------------------------------
--                                    Debugging                                   --
------------------------------------------------------------------------------------
setting_list.BI_Debug_To_Log = {
  type = "bool-setting",
  name = "BI_Debug_To_Log",
  setting_type = "startup",
  default_value = false,
  order = "c[debugging]-c1[BI_Debugging]",
}

setting_list.BI_Debug_To_Game = {
  type = "bool-setting",
  name = "BI_Debug_To_Game",
  setting_type = "startup",
  default_value = false,
  order = "c[debugging]-c2[BI_Debugging]",
}

-- Compatibility with other mods (optional)
-- Industrial Revolution + AAI Industry
if not (mods["IndustrialRevolution"] or mods["aai-industry"]) then
  setting_list.BI_Disassemble = {
    type = "bool-setting",
    name = "BI_Disassemble",
    setting_type = "startup",
    default_value = true,
    order = "a[enable]-d-[production]-[BI_Disassemble]",
  }
  setting_list.BI_Rubber = {
    type = "bool-setting",
    name = "BI_Rubber",
    setting_type = "startup",
    default_value = true,
    order = "a[enable]-b-[resources]-[BI_Rubber]",
  }
end

-- Krastorio 2 + Industrial Revolution
if not (mods["Krastorio2"] or mods["IndustrialRevolution"]) then
  setting_list.BI_Game_Tweaks_Production_Science = {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Production_Science",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-b-[production]-[BI_Game_Tweaks_Production_Science]",
  }
end

-- Wood Gasification (Don't duplicate what's already there!)
if not mods["Wood_Gasification"] then
  setting_list.BI_Wood_Gasification = {
    type = "bool-setting",
    name = "BI_Wood_Gasification",
    localised_description = {
      "mod-setting-description.BI_Wood_Gasification",
      {"fluid-name.tar"},
      {"fluid-name.petroleum-gas"},
      {"technology-name.bi-tech-wood-gasification"},
    },
    setting_type = "startup",
    default_value = true,
    order = "a[enable]-b-[resources]-[BI_Wood_Gasification]",
  }
end

-- Lua API global Variable Viewer (gvv)
if mods["gvv"] then
  setting_list.BI_Debug_gvv = {
    type = "bool-setting",
    name = "BI_Debug_gvv",
    localised_name = {"mod-setting-name.BI_Debug_gvv", {"gvv-mod.title"}},
    localised_description = {
      "mod-setting-description.BI_Debug_gvv",
      {"gvv-mod.title"},
      {"mod-name.Bio_Industries"},
    },
    setting_type = "startup",
    default_value = false,
    order = "c[debugging]-c3[BI_Debug_gvv]",
  }
end

for name, setting in pairs(setting_list) do
  data:extend({setting})
  --~ log("Added setting " .. setting.name .. "\tDefault value: " .. tostring(setting.default_value) .. "\tType: " .. setting.setting_type)
end

--[[
Types of settings:
      - startup - game must be restarted if changed (such a setting may affect prototypes' changes)
      - runtime-global - per-world setting
      - runtime-per-user - per-user setting

Types of values:
      - bool-setting
      - double-setting
      - int-setting
      - string-setting

Files being processed by the game:
      - settings.lua
      - settings-updates.lua
      - settings-final-fixes.lua

Using in DATA.lua:
data:extend({
 {
    type = "int-setting",
    name = "setting-name1",
    setting_type = "runtime-per-user",
    default_value = 25,
    minimum_value = -20,
    maximum_value = 100,
    per_user = true,
 },
 {
    type = "bool-setting",
    name = "setting-name2",
    setting_type = "runtime-per-user",
    default_value = true,
    per_user = true,
 },
 {
    type = "double-setting",
    name = "setting-name3",
    setting_type = "runtime-per-user",
    default_value = -23,
    per_user = true,
 },
 {
    type = "string-setting",
    name = "setting-name4",
    setting_type = "runtime-per-user",
    default_value = "Hello",
    allowed_values = {"Hello", "foo", "bar"},
    per_user = true,
 },
})

Using in LOCALE.cfg:
      [mod-setting-name]
      setting-name1=Seting name
      [mod-setting-description]
      setting-name1=Seting description

Using in CONTROL.lua and in other code for reading:
      EVENT: on_runtime_mod_setting_changed - called when a player changed its setting
              event.player_index
              event.setting
      GET: settings.startup["setting-name"].value - current value of startup setting; can be used in DATA.lua
      GET: settings.global["setting-name"].value - current value of per-world setting
      GET: set = settings.get_player_settings(LuaPlayer) - current values for per-player settings; then use set["setting-name"].value
      GET: settings.player - default values
]]

--[[data:extend({
  {
    type = "int-setting",
    name = "pollution_detector_update_interval",
    order = "aa",
    setting_type = "runtime-global",
    default_value = 120,
    minimum_value = 1,
    maximum_value = 216000, -- 1h
  },
})]]--
