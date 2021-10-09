------------------------------------------------------------------------------------
--                              Enable: Wood products                             --
--                         (BI.Settings.BI_Wood_Products)                         --
------------------------------------------------------------------------------------
local setting = "BI_Wood_Products"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end

BI.additional_entities = BI.additional_entities or {}
BI.additional_entities[setting] = BI.additional_entities[setting] or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ENTITYPATH = BioInd.entitypath

local pipes = data.raw.pipe
local upipes = data.raw["pipe-to-ground"]
local items = data.raw.item
local recipes = data.raw.recipe
local techs = data.raw.technology
local recipe, item, tech, chest, pole, name, p_type


------------------------------------------------------------------------------------
--                                      Data                                      --
------------------------------------------------------------------------------------
local pipes_sheet = {
  straight_vertical_single = {
    number = 11,
    position = {x = 0, y = 0},
    size = {x = 8, y = 8},
  },

  ending_right = {
    number = 12,
    position = {x = 8, y = 0},
    size = {x = 6, y = 8},
    shift = {x = 1, y = 0}, --where must be center
  },
  straight_horizontal_window = {
    number = 13,
    position = {x = 14, y = 0},
    size = {x = 4, y = 8},
  },
  straight_horizontal = {
    number = 14,
    position = {x = 18, y = 0},
    size = {x = 4, y = 8},
  },
  ending_left = {
    number = 15,
    position = {x = 22, y = 0},
    size = {x = 6, y = 8},
    shift = {x = -1, y = 0},
  },
  ending_down = {
    number = 21,
    position = {x = 0, y = 8},
    size = {x = 8, y = 6},
    shift = {x = 0, y = 1},
  },
  straight_vertical_window = {
    number = 31,
    position = {x = 0, y = 14},
    size = {x = 8, y = 4},
  },
  straight_vertical = {
    number = 41,
    position = {x = 0, y = 18},
    size = {x = 8, y = 4},
  },
  ending_up = {
    number = 51,
    position = {x = 0, y = 22},
    size = {x = 8, y = 6},
    shift = {x = 0, y = -1},
  },
  corner_down_right = {
    number = 22,
    position = {x = 8, y = 8},
    size = {x = 6, y = 6},
    shift = {x = 1, y = 1},
  },
  t_down = {
    number = 23,
    position = {x = 14, y = 8},
    size = {x = 4, y = 6},
    shift = {x = 0, y = 1},
  },
  corner_down_left = {
    number = 24,
    position = {x = 18, y = 8},
    size = {x = 6, y = 6},
    shift = {x = -1, y = 1},
  },
  t_right = {
    number = 32,
    position = {x = 8, y = 14},
    size = {x = 6, y = 4},
    shift = {x = 1, y = 0},
  },
  cross = {
    number = 33,
    position = {x = 14, y = 14},
    size = {x = 4, y = 4},
  },
  t_left = {
    number = 34,
    position = {x = 18, y = 14},
    size = {x = 6, y = 4},
    shift = {x = -1, y = 0},
  },
  corner_up_right = {
    number = 42,
    position = {x = 8, y = 18},
    size = {x = 6, y = 6},
    shift = {x = 1, y = -1},
  },
  t_up = {
    number = 43,
    position = {x = 14, y = 18},
    size = {x = 4, y = 6},
    shift = {x = 0, y = -1},
  },
  corner_up_left = {
    number = 44,
    position = {x = 18, y = 18},
    size = {x = 6, y = 6},
    shift = {x = -1, y = -1},
  },

  --data.raw[pipe-to-ground][pipe-to-ground].pictures.up
  down = {
    number = 25,
    position = {x = 24, y = 8},
    size = {x = 8, y = 6},
    shift = {x = 0, y = 1},
  },
  up = {
    number = 35,
    position = {x = 24, y = 14},
    size = {x = 8, y = 6},
    shift = {x = 0, y = -1}, -- not 26
  },
  right = {
    number = 52,
    position = {x = 8, y = 24},
    size = {x = 6, y = 8},
    shift = {x = 1, y = 0},
  },
  left = {
    number = 53,
    position = {x = 14, y = 24},
    size = {x = 6, y = 8},
    shift = {x = -1, y = 0},
  }
}

local sheet_path = ENTITYPATH .. "wood_products/wood_pipe/"
local sheet_name = "pipe_sheet.png"

------------------------------------------------------------------------------------
--                               Auxiliary function                               --
------------------------------------------------------------------------------------
function change_graphics(was_picture, sheet_element, quality)
  local picture = {}
  local k = 1
  if not sheet_element.shift then
    sheet_element.shift = {x = 0, y = 0}
  end
  if (quality == "hq") and (was_picture.hr_version) then
    picture = was_picture.hr_version
    k = 2
  else
    picture = was_picture
    k = 1
  end

  if not (picture) then
    return
  end

  local size = sheet_element.size
  if type(size) == "number" then
    size = {x = size, y = size}
  elseif type(size) == "table" and not (size.x and size.y) then
    size = {x = size[1], y = size[2]}
  end

  picture.filename = sheet_path .. quality .. "_" .. sheet_name
  --~ picture.width = 8 * k * size.x
  --~ picture.height = 8 * k * size.y
  picture.size = {8 * k * size.x, 8 * k * size.y}
  picture.scale = 1/k
  picture.x = 8 * k * (sheet_element.position.x or sheet_element.position[1])
  picture.y = 8 * k * (sheet_element.position.y or sheet_element.position[2])
  picture.shift = {}
  --picture.shift.x = -8/32 * k * sheet_element.shift.x
  --picture.shift.y = -8/32 * k * sheet_element.shift.y
  picture.shift.x = -8/32  * (sheet_element.shift.x or sheet_element.shift[1])
  picture.shift.y = -8/32  * (sheet_element.shift.y or sheet_element.shift[2])
  --BioInd.debugging.writeDebug("%s Quality: %s - Success", {sheet_element.number, quality})
end


------------------------------------------------------------------------------------
--                         Change graphics of wooden pipes                        --
------------------------------------------------------------------------------------
-- Wooden pipes
local pipe_pictures = pipes["bi-wood-pipe"] and pipes["bi-wood-pipe"].pictures
for i, was_picture in pairs(pipe_pictures or {}) do
  for j, sheet_element in pairs(pipes_sheet) do
    if i == j then
      change_graphics(was_picture, sheet_element, "hq")
      change_graphics(was_picture, sheet_element, "lq")
    end
  end
end
BioInd.debugging.modified_msg("graphics", pipes["bi-wood-pipe"])

-- Wooden underground pipes
local pipe_to_ground_pictures = upipes["bi-wood-pipe-to-ground"] and
                                  upipes["bi-wood-pipe-to-ground"].pictures

for i, was_picture in pairs(pipe_to_ground_pictures or {}) do
  for j, sheet_element in pairs(pipes_sheet) do
    if i == j then
      change_graphics(was_picture, sheet_element, "hq")
      change_graphics(was_picture, sheet_element, "lq")
    end
  end
end
BioInd.debugging.modified_msg("graphics", upipes["bi-wood-pipe-to-ground"])


------------------------------------------------------------------------------------
--   If resin doesn't exist, remove it from the recipe of the Big wooden chest!   --
------------------------------------------------------------------------------------
item = BI.additional_items.BI_Rubber.resin
if not items[item.name] then
  recipe = recipes[BI.additional_recipes.BI_Wood_Products.large_wooden_chest.name]
  thxbob.lib.recipe.remove_ingredient(recipe.name, item.name)
  BioInd.debugging.modified_msg("ingredient " .. item.name, recipe, "Removed")
end


------------------------------------------------------------------------------------
--               Change the localization of the vanilla wooden chest              --
------------------------------------------------------------------------------------
name = "wooden-chest"
for p, p_type in ipairs({"container", "item", "recipe"}) do
  chest = data.raw[p_type][name]
  if chest then
    chest.localised_name = {"entity-name.bi-wooden-chest"}
    chest.localised_description = {"entity-description.bi-wooden-chest"}
    BioInd.debugging.modified_msg("localization", chest)
  end
end


------------------------------------------------------------------------------------
--                  Adjust localization of techs for wooden poles                 --
------------------------------------------------------------------------------------
tech = techs[BI.additional_techs.BI_Wood_Products.wooden_pole_1.name]
if tech then
  p_type = BI.additional_entities[setting].big_pole
  pole = data.raw[p_type.type][p_type.name]
  tech.localised_name = {
    "technology-name.bi-tech-wooden-pole-1",
    {"entity-name.bi-wooden-pole-big"}
  }
  tech.localised_description = {
    "technology-description.bi-tech-wooden-pole-1",
    {"entity-name.bi-wooden-pole-big"},
    pole.maximum_wire_distance
  }
  BioInd.debugging.modified_msg("localization", tech)
end


tech = techs[BI.additional_techs.BI_Wood_Products.wooden_pole_2.name]
if tech then
  p_type = BI.additional_entities[setting].huge_pole
  pole = data.raw[p_type.type][p_type.name]
  tech.localised_description = {
    "technology-description.bi-tech-wooden-pole-2",
    pole.maximum_wire_distance
  }
  BioInd.debugging.modified_msg("localization", tech)
end


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
