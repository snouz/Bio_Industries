BioInd.debugging.entered_file()


BI.default_signals = BI.default_signals or {}

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath
local SIGPATH = ICONPATH .. "signal/"


-- Moved to categories.lua
  --~ {
    --~ type = "item-subgroup",
    --~ name = "bi-signal",
    --~ group = "signals",
    --~ order = "f-bioindustries"
  --~ },

------------------------------------------------------------------------------------
--                                 Virtual signals                                --
------------------------------------------------------------------------------------
BI.default_signals.pollution_particle = {
  type = "virtual-signal",
  name = "bi_signal_pollution_particle",
  icon = SIGPATH .. "bi_signal_pollution_particle.png",
  subgroup = "bi-signal",
  icon_size = 64,
  icon_mipmaps = 4,
  order = "f-bioindustries-1",
}


BI.default_signals.clean_particle = {
  type = "virtual-signal",
  name = "bi_signal_clean_particle",
  icon = SIGPATH .. "bi_signal_clean_particle.png",
  subgroup = "bi-signal",
  icon_size = 64,
  icon_mipmaps = 4,
  order = "f-bioindustries-2",
}


BI.default_signals.fertilizer = {
  type = "virtual-signal",
  name = "bi_signal_fert",
  icon = SIGPATH .. "bi_signal_fert.png",
  subgroup = "bi-signal",
  icon_size = 64,
  icon_mipmaps = 4,
  order = "f-bioindustries-3",
}


BI.default_signals.advanced_fertilizer = {
  type = "virtual-signal",
  name = "bi_signal_adv_fert",
  icon = SIGPATH .. "bi_signal_adv_fert.png",
  subgroup = "bi-signal",
  icon_size = 64,
  icon_mipmaps = 4,
  order = "f-bioindustries-4",
}


BI.default_signals.recycle = {
  type = "virtual-signal",
  name = "bi_signal_recycle",
  icon = SIGPATH .. "bi_signal_recycle.png",
  subgroup = "bi-signal",
  icon_size = 64,
  icon_mipmaps = 4,
  order = "f-bioindustries-5",
}


BI.default_signals.leaf = {
  type = "virtual-signal",
  name = "bi_signal_leaf",
  icon = SIGPATH .. "bi_signal_leaf.png",
  subgroup = "bi-signal",
  icon_size = 64,
  icon_mipmaps = 4,
  order = "f-bioindustries-6",
}


BI.default_signals.sun = {
  type = "virtual-signal",
  name = "bi-signal-sun",
  icon = SIGPATH .. "bi_signal_sun.png",
  subgroup = "bi-signal",
  icon_size = 64,
  icon_mipmaps = 4,
  order = "f-bioindustries-7",
}


BI.default_signals.clean_air = {
  type = "virtual-signal",
  name = "bi-signal-clean-air",
  icon = ICONPATH .. "clean-air.png",
  subgroup = "bi-signal",
  icon_size = 128,
  icon_mipmaps = 4,
  order = "f-bioindustries-8",
}


BI.default_signals.plant_tree = {
  type = "virtual-signal",
  name = "bi-signal-planting-tree",
  icon = ICONPATH .. "change_fert_plant_1.png",
  subgroup = "bi-signal",
  icon_size = 128,
  icon_mipmaps = 4,
  order = "f-bioindustries-9",
}


------------------------------------------------------------------------------------
--                             Create virtual signals                             --
------------------------------------------------------------------------------------
BioInd.create_stuff(BI.default_signals)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
