ICONPATH = BioInd.iconpath
SIGPATH = ICONPATH .. "signal/"

data:extend(
{
  {
    type = "item-subgroup",
    name = "bi-signal",
    group = "signals",
    order = "f-bioindustries"
  },
  {
    type = "virtual-signal",
    name = "bi_signal_pollution_particle",
    icon = SIGPATH .. "bi_signal_pollution_particle.png",
    subgroup = "bi-signal",
    icon_size = 64,
    icon_mipmaps = 4,
    order = "f-bioindustries-1",
  },
  {
    type = "virtual-signal",
    name = "bi_signal_clean_particle",
    icon = SIGPATH .. "bi_signal_clean_particle.png",
    subgroup = "bi-signal",
    icon_size = 64,
    icon_mipmaps = 4,
    order = "f-bioindustries-2",
  },
  {
    type = "virtual-signal",
    name = "bi_signal_fert",
    icon = SIGPATH .. "bi_signal_fert.png",
    subgroup = "bi-signal",
    icon_size = 64,
    icon_mipmaps = 4,
    order = "f-bioindustries-3",
  },
  {
    type = "virtual-signal",
    name = "bi_signal_adv_fert",
    icon = SIGPATH .. "bi_signal_adv_fert.png",
    subgroup = "bi-signal",
    icon_size = 64,
    icon_mipmaps = 4,
    order = "f-bioindustries-4",
  },
  {
    type = "virtual-signal",
    name = "bi_signal_recycle",
    icon = SIGPATH .. "bi_signal_recycle.png",
    subgroup = "bi-signal",
    icon_size = 64,
    icon_mipmaps = 4,
    order = "f-bioindustries-5",
  },
  {
    type = "virtual-signal",
    name = "bi_signal_leaf",
    icon = SIGPATH .. "bi_signal_leaf.png",
    subgroup = "bi-signal",
    icon_size = 64,
    icon_mipmaps = 4,
    order = "f-bioindustries-6",
  },
  {
    type = "virtual-signal",
    name = "bi-signal-sun",
    icon = SIGPATH .. "bi_signal_sun.png",
    subgroup = "bi-signal",
    icon_size = 64,
    icon_mipmaps = 4,
    order = "f-bioindustries-7",
  },
  {
    type = "virtual-signal",
    name = "bi-signal-clean-air",
    icon = ICONPATH .. "clean-air.png",
    subgroup = "bi-signal",
    icon_size = 128,
    icon_mipmaps = 4,
    order = "f-bioindustries-8",
  },
  {
    type = "virtual-signal",
    name = "bi-signal-planting-tree",
    icon = ICONPATH .. "change_fert_plant_1.png",
    subgroup = "bi-signal",
    icon_size = 128,
    icon_mipmaps = 4,
    order = "f-bioindustries-9",
  },

})
