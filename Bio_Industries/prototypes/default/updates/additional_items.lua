--~ BI.entered_file()

--~ BI.additional_items = BI.additional_items or {}


--~ ------------------------------------------------------------------------------------
--~ ------------------------------------------------------------------------------------


--~ local ICONPATH = BioInd.iconpath

--~ local items = data.raw.fluid
--~ local techs = data.raw.technology
--~ local recipes = data.raw.recipe
--~ local tech, item, recipe


--~ ------------------------------------------------------------------------------------
--~ --                            Data of additional items                            --
--~ ------------------------------------------------------------------------------------
--~ -- Resin
--~ BI.additional_items.resin = {
  --~ type = "item",
  --~ name = "resin",
  --~ icon = ICONPATH .. "resin.png",
  --~ icon_size = 64,
  --~ BI_add_icon = true,
  --~ subgroup = "bio-bio-farm-raw",
  --  order = "a[bi]-a-b[bi-resin]",
  --~ order = "a[bi]-a-bb[bi-resin]",
  --~ stack_size = 200
--~ }

--~ BioInd.writeDebug("Read data for additional items.")

--~ ------------------------------------------------------------------------------------
--~ --                                    END OF FILE                                 --
--~ ------------------------------------------------------------------------------------
--~ BI.entered_file("leave")
