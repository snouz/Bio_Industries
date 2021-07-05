--~ local BioInd = require(['"]common['"])(["']Bio_Industries['"])


-- Merges table2's contents into table1.
function thxbob.lib.table_merge(table1, table2)
  for index, value in pairs(table2) do
    if type(value) == "table" then
      if type(table1[index]) == "table" then
        thxbob.lib.table_merge(table1[index], table2[index])
      else
        table1[index] = util.table.deepcopy(table2[index])
      end
    else
      table1[index] = value
    end
  end
end


-- Converts recipe.result to recipe.results!
function thxbob.lib.result_check(object)
--~ BioInd.show("Entered function result_check", object)
BioInd.entered_function()
  if object then
    object.results = object.results or {}
--~ BioInd.show("object.results", object.results)

    if object.result then
      local item = thxbob.lib.item.basic_item({name = object.result})
BioInd.writeDebug("item: %s", {item}, "line")
      if object.result_count then
        item.amount = object.result_count
        object.result_count = nil
      end

--~ BioInd.show("object.results", object.results)
      thxbob.lib.item.add_new(object.results, item)
--~ BioInd.show("object.results after add_new", object.results)

      if object.ingredients then  -- It's a recipe
        if not object.main_product then
          if object.icon or object.subgroup or object.order or item.type ~= "item" then -- if we already have one, add the rest
--~ BioInd.writeDebug("data.raw[%s][%s]: %s", {item.type, item.name, data.raw[item.type][item.name] or "nil"})
            if (not object.icon) and data.raw[item.type][item.name] and
                                      data.raw[item.type][item.name].icon then
              object.icon = data.raw[item.type][item.name].icon
              object.icon_size = data.raw[item.type][item.name].icon_size
            --~ end
            -- Make sure objects also have an icons definition
            elseif not object.icons and data.raw[item.type][item.name] and
                                          data.raw[item.type][item.name].icons and
                                          -- Don't assume that an icon already exists,
                                          -- it could be set later on!
                                          data.raw[item.type][item.name].icon then
              object.icons = {
                {
                  icon = data.raw[item.type][item.name].icon,
                  icon_size = 64,
                  data.raw[item.type][item.name].icon_mipmaps
                }
              }
            end
            if not object.subgroup and data.raw[item.type][item.name] and
                                        data.raw[item.type][item.name].subgroup then
              object.subgroup = data.raw[item.type][item.name].subgroup
            end
            if not object.order and data.raw[item.type][item.name] and
                                      data.raw[item.type][item.name].order then
              object.order = data.raw[item.type][item.name].order
            end
            if data.raw[item.type][item.name] and
                data.raw[item.type][item.name].main_product then
              object.main_product = data.raw[item.type][item.name].main_product
            end
          else -- otherwise just use main_product as a cheap way to set them all.
            object.main_product = object.result
          end
        end
      end
      object.result = nil
    end

  else
    BioInd.writeDebug("%s does not exist.", {object})
  end
BioInd.entered_function("leave")
end


function thxbob.lib.belt_speed_ips(ips)
  return ips * 1/480
end
