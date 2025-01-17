------------------------------------------------------------------------------------
--                             Game tweaks: Tree yield                            --
--                        (BI.Settings.BI_Game_Tweaks_Tree)                       --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Tree"
if not BI.Settings[setting] then
  BioInd.debugging.nothing_to_do("*")
  return
else
  BioInd.debugging.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local new_results = {
  {
    type = "item",
    name = "wood",
    amount_min = 1,
    amount_max = 6
  }
}

local ignore_trees = BioInd.tree_stuff.get_tree_ignore_list()

for tree_name, tree in pairs(data.raw["tree"] or {}) do
  if tree.minable and not ignore_trees[tree_name] then
    BioInd.debugging.writeDebug("Tree name: %s\tminable.result: %s\tminable.count: %s", {
                        tree.name,
                        (tree.minable and tree.minable.result or "nil"),
                        (tree.minable and tree.minable.count or "nil")
                      }, "line")
    BioInd.debugging.writeDebug("Tree name: %s\tminable.results: %s", {
                        tree.name,
                        (tree.minable and tree.minable.results or "nil")
                      }, "line")
    -- CHECK FOR SINGLE RESULTS
    -- mining.result may be set although mining.results exists (mining.result
    -- will be ignored in that case; happens, for example with IR2's rubber
    -- trees). In this case, overwriting mining.results with the data from
    -- mining.result could break other mods (e.g. IR2's rubber trees should
    -- yield "rubber-wood" instead of "wood"). So let's only
    if tree.minable.result and not tree.minable.results then
      BioInd.debugging.writeDebug("Tree has minable.result")
      --CHECK FOR VANILLA TREES WOOD x 4
      if tree.minable.result == "wood" and tree.minable.count == 4 then
        BioInd.debugging.writeDebug("Changing wood yield of %s to random value.", {tree.name})
        tree.minable.mining_particle = "wooden-particle"
        tree.minable.mining_time = 1.5
        tree.minable.results = new_results
      -- CONVERT RESULT TO RESULTS
      else
        BioInd.debugging.writeDebug("Converting tree.minable.result to tree.minable.results!")
        tree.minable.mining_particle = "wooden-particle"
        tree.minable.results = {
          {
            type = "item",
            name = tree.minable.result,
            amount = tree.minable.count,
          }
        }
      end
    --CHECK FOR RESULTS TABLE
    elseif tree.minable.results then
      BioInd.debugging.writeDebug("Checking minable.results!")
      for r, result in pairs(tree.minable.results) do
        --CHECK FOR RESULT WOOD x 4
        if result.name == "wood" and result.amount == 4 then
          BioInd.debugging.writeDebug("Changing result %s: %s", {r, result}, "line")
          result.amount = nil
          result.amount_min = 1
          result.amount_max = 6
        end
      end
      tree.minable.result = nil
      tree.minable.count = nil
    -- NEITHER RESULT NOR RESULTS EXIST -- CREATE RESULTS!
    else
      BioInd.debugging.writeDebug("Creating minable.results!")
      tree.minable.results = new_results
    end
    BioInd.debugging.writeDebug("New minable.results: %s",
                      {tree.minable and tree.minable.results or "nil"}, "line")
  else
    BioInd.debugging.writeDebug("Won't change results of %s!", {tree.name})
  end
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BioInd.debugging.entered_file("leave")
