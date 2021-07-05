data:extend(
{

        -- Add/enable stuff
   {
    type = "bool-setting",
    name = "BI_Solar_Additions",
    setting_type = "startup",
    default_value = true,
    order = "a[modifier]-a[Solar_Farm]",
  },

  {
    type = "bool-setting",
    name = "BI_Bio_Fuel",
    setting_type = "startup",
    default_value = true,
    order = "a[modifier]-b[Bio_Fuel]",
  },

  {
    type = "bool-setting",
    name = "BI_Bio_Cannon",
    setting_type = "startup",
    default_value = true,
    order = "a[modifier]-c[Bio_Cannon]",
  },

  {
    type = "bool-setting",
    name = "BI_Show_musk_floor_in_mapview",
    setting_type = "startup",
    default_value = true,
    order = "a[modifier]-d[Musk_floor]",
  },

  {
    type = "bool-setting",
    name = "BI_Easy_Bio_Gardens",
    setting_type = "startup",
    default_value = false,
    order = "a[modifier]-e[Fluid_fertilizer]",
  },

        -- Game tweaks
  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Emissions_Multiplier",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-a[Fuel_emission_multiplier]",
    per_user = true,
  },

  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Stack_Size",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-b[Stack_size]",
  },

  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Recipe",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-c1[Recipe]",
  },
  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Disassemble",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-c2[Disassemble]",
  },
  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Production_Science",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-c3[Production_science]",
  },

  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Tree",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-d1[Trees]",
  },

  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Small_Tree_Collisionbox",
    setting_type = "startup",
    default_value = true,
    order = "b[tweaks]-d2[Tree_collision_box]",
  },

  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Player",
    setting_type = "startup",
    default_value = false,
    order = "b[tweaks]-e[Player_tweaks]",
  },

  {
    type = "bool-setting",
    name = "BI_Game_Tweaks_Bot",
    setting_type = "startup",
    default_value = false,
    order = "b[tweaks]-f[Bot_tweaks]",
  },

})

-- Compatibility with other mods (optional)

        -- Debugging
if mods["gvv"] then
  data:extend({
  {
    type = "bool-setting",
    name = "BI_Enable_gvv_support",
    setting_type = "startup",
    default_value = false,
        order = "c[compatibility]-c1[debugging_gvv]",
  },
})
end


--[[
Types of settings:
        • startup - game must be restarted if changed (such a setting may affect prototypes' changes)
        • runtime-global - per-world setting
        • runtime-per-user - per-user setting

Types of values:
        • bool-setting
        • double-setting
        • int-setting
        • string-setting

Files being processed by the game:
        • settings.lua
        • settings-updates.lua
        • settings-final-fixes.lua

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
