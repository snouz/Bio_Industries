------------------------------------------------------------------------------------
--                              Enable: Wooden rails                              --
--                             (BI.Settings.BI_Rails)                             --
------------------------------------------------------------------------------------
local setting = "BI_Rails"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.entitypath .. "wood_products/rails/"

local pix = {
  "straight_rail_horizontal",
  "straight_rail_vertical",
  "straight_rail_diagonal_left_bottom",  "straight_rail_diagonal_left_top",
  "straight_rail_diagonal_right_bottom", "straight_rail_diagonal_right_top",

  "curved_rail_horizontal_left_bottom",  "curved_rail_horizontal_left_top",
  "curved_rail_horizontal_right_bottom", "curved_rail_horizontal_right_top",
  "curved_rail_vertical_left_bottom",    "curved_rail_vertical_left_top",
  "curved_rail_vertical_right_bottom",   "curved_rail_vertical_right_top",
}
local PATH, FILE, HR_FILE
local rail_type, direction, img, proto

for p, pic in ipairs(pix) do
  -- Extract rail_type and direction from the string and replace underscores with "-"
  rail_type = pic:match("^([^_]+_rail)_.+$"):gsub("_", "-")
  direction = pic:match("^.+_rail_(.+)$"):gsub("_", "-")
BioInd.show("rail_type", rail_type)
BioInd.show("direction", direction)

  -- Rails
  PATH = ICONPATH .. rail_type .. "-bridge"
  FILE = PATH .. "/" .. rail_type .. "-" .. direction .. "-"
  HR_FILE = PATH .. "/hr-" .. rail_type .. "-" .. direction .. "-"
BioInd.show("PATH", PATH)
BioInd.show("FILE", FILE)
BioInd.show("HR_FILE", HR_FILE)

BioInd.show("rail name", "bi-" .. rail_type .. "-wood-bridge")


  --~ img = data.raw[rail_type]["bi-" .. rail_type .. "-wood-bridge"].pictures[pic]
  proto = data.raw[rail_type]["bi-" .. rail_type .. "-wood-bridge"]
  --~ if proto then
    img = proto.pictures[pic]

    img.stone_path.filename = FILE .. "stone-path.png"
    img.stone_path.hr_version.filename = HR_FILE .. "stone-path.png"

    img.stone_path_background.filename = FILE.."stone-path-background.png"
    img.stone_path_background.hr_version.filename = HR_FILE.."stone-path-background.png"
    BioInd.modified_msg("graphics", proto)
  --~ end

  -- Remnants
  --~ img = data.raw["rail-remnants"][rail_type .. "-remnants-wood-bridge"].pictures[pic]
BioInd.show("data.raw[rail-remnants]", table_size(data.raw["rail-remnants"]))
BioInd.show("rail name", rail_type .. "-wood-bridge-remnants")
  proto = data.raw["rail-remnants"][rail_type .. "-wood-bridge-remnants"]
BioInd.show("proto type", proto and proto.type or "nil")
BioInd.show("proto name", proto and proto.name or "nil")
  --~ if proto then
    img = proto.pictures[pic]

    img.stone_path.filename = ICONPATH ..  "remnants/remnants.png"
    img.stone_path.hr_version.filename = ICONPATH ..  "remnants/hr-remnants.png"

    img.stone_path_background.filename = ICONPATH ..  "remnants/remnants.png"
    img.stone_path_background.hr_version.filename = ICONPATH ..  "remnants/hr-remnants.png"
    BioInd.modified_msg("graphics", proto)
  --~ end
end


-- Localize remnants!
local remnants
for f, form in ipairs({"straight", "curved"}) do
  remnants = data.raw["rail-remnants"][form .. "-rail-wood-bridge-remnants"]

  remnants.localised_name = {"entity-name.rail-wood-bridge-remnants"}
  remnants.localised_description = {"entity-description.rail-wood-bridge-remnants"}
  BioInd.modified_msg("localization", remnants)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
