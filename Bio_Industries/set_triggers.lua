BioInd.debugging.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
--                Set triggers depending on multiple settings/mods                --
------------------------------------------------------------------------------------

BI.Triggers = {
  -- Crafting of bioreactor recipes in the oil refinery?
  BI_Trigger_BiRefinery           = not BioInd.check_mods("IndustrialRevolution") and
                                    data.raw["assembling-machine"]["oil-refinery"],

  -- Create new tech "Refined concrete"?
  BI_Trigger_Concrete             = BI.Settings.BI_Game_Tweaks_Recipe or
                                    BI.Settings.BI_Rubber or
                                    BI.Settings.BI_Stone_Crushing,
  --~ -- Create new tech "Refined concrete"?
  --~ BI_Trigger_Concrete_Create          = not BioInd.check_mods("IndustrialRevolution") and
                                    --~ (BI.Settings.BI_Game_Tweaks_Recipe or
                                      --~ BI.Settings.BI_Rubber or
                                      --~ BI.Settings.BI_Stone_Crushing),

  -- Create item Crushed stone?
  BI_Trigger_Crushed_Stone_Create = BI.Settings.BI_Stone_Crushing and
                                    not BioInd.check_mods("IndustrialRevolution"),

  -- Create item Wood Charcoal?
  BI_Trigger_Wood_Charcoal_Create = BI.Settings.BI_Coal_Processing and
                                    not BioInd.check_mods("IndustrialRevolution"),

  -- Create item Wood pulp?
  BI_Trigger_Woodpulp_Create      = not BioInd.check_mods("IndustrialRevolution"),

  --~ -- Replace ingredient Crushed stone with Stone in recipes?
  --~ BI_Trigger_Crushed_Stone_Replace= not BI.Settings.BI_Stone_Crushing,

  -- Create fluid fertilizers?
  BI_Trigger_Easy_Bio_Gardens     = BI.Settings.BI_Bio_Garden and
                                    BI.Settings.BI_Game_Tweaks_Easy_Bio_Gardens,

  -- Move unlock of "Military 2" behind Rubber mats?
  BI_Trigger_Rubber_Darts         = BI.Settings.BI_Rubber and
                                    (BI.Settings.BI_Darts or mods["Natural_Evolution_Buildings"]),

  -- Add prerequisite "Wood gasification" to "Rubber-coated concrete"?
  BI_Trigger_Rubber_Woodgas       = BI.Settings.BI_Rubber and BI.Settings.BI_Wood_Gasification,

  -- Sort recipes into item-subgroups provided by other mods?
  BI_Trigger_Subgroups            = BioInd.check_mods("5dim_core"),

  -- Sort recipes into item-subgroups provided by other mods?
  BI_Trigger_Subgroups_rail       = BioInd.check_mods("5dim_core") and BI.Settings.BI_Rails,

  -- Create "bi-wood-floor" tiles?
  BI_Trigger_Woodfloor            = not BioInd.get_startup_setting("dectorio-wood"),

  -- Do we have early access to glass?
  BI_Trigger_Glass_bobs           = BioInd.check_mods({"bobplates", "bobores"}, "and") and
                                    BioInd.get_startup_setting("bobmods-ores-enablequartz"),

  -- Do we need a recipe for sand?
  BI_Trigger_Sand                 = BI.Settings.BI_Stone_Crushing and BioInd.check_mods({
                                      "aai-industry", "angelssmelting", "BioTech",
                                      "Krastorio2", "pycoalprocessing"}),

  -- Do we need to replace solar panels in the recipe of the Solar farm?
  BI_Trigger_IR2_Power_production = BI.Settings.BI_Power_Production and BioInd.check_mods({
                                      "IndustrialRevolution"})
}

-- Convert triggers to Boolean values!
for k, v in pairs(BI.Triggers) do
  BI.Triggers[k] = v and true or false
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
