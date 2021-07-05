BioInd.entered_file()


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


local ICONPATH = BioInd.iconpath

--[[

Big thanks to OwnlyMe and his "Robot Tree Farm" code!
https://mods.factorio.com/mod/robot_tree_farm
License:  CC BY-SA 4.0

]]

-- Don't create prototypes for trees in this table!
local ignore_trees = BioInd.get_tree_ignore_list()
BioInd.show("Ignoring these trees", ignore_trees)

local COLLISION_BOX = {{-0.1, -0.1}, {0.1, 0.1}}
local TREE_LEVELS = 4
local extend = {}
local wooden, branch, leaf

for i = 1, TREE_LEVELS do
  wooden = table.deepcopy(data.raw["optimized-particle"]["wooden-particle"])
  wooden.name = "bio-" .. wooden.name .. "-" .. i
  for _, pic in pairs(wooden.pictures) do
    pic.scale = (pic.scale or 1)/TREE_LEVELS*i
    pic.hr_version.scale = (pic.hr_version.scale or 1)/TREE_LEVELS*i
  end
  for _, pic in pairs(wooden.shadows) do
    pic.scale = (pic.scale or 1)/TREE_LEVELS*i
    pic.hr_version.scale = (pic.hr_version.scale or 1)/TREE_LEVELS*i
  end
  extend[#extend + 1] = wooden

  branch = table.deepcopy(data.raw["optimized-particle"]["branch-particle"])
  branch.name = "bio-" .. branch.name .. "-" .. i
  for _, pic in pairs(branch.pictures) do
    pic.scale = (pic.scale or 1)/TREE_LEVELS*i
    pic.hr_version.scale = (pic.hr_version.scale or 1)/TREE_LEVELS*i
  end
  for _, pic in pairs(branch.shadows) do
    pic.scale = (pic.scale or 1)/TREE_LEVELS*i
    pic.hr_version.scale = (pic.hr_version.scale or 1)/TREE_LEVELS*i
  end
  extend[#extend + 1] = branch

  leaf = table.deepcopy(data.raw["optimized-particle"]["leaf-particle"])
  leaf.name = "bio-" .. leaf.name .. "-" .. i
  for _, pic in pairs(leaf.pictures) do
    pic.scale = (pic.scale or 1)/TREE_LEVELS*math.max(2, i)
    --pic.hr_version.scale = (pic.hr_version.scale or 1)/TREE_LEVELS*i
  end
  for _, pic in pairs(leaf.shadows) do
    pic.scale = (pic.scale or 1)/TREE_LEVELS*math.max(2, i)
    --pic.hr_version.scale = (pic.hr_version.scale or 1)/TREE_LEVELS*i
  end
  extend[#extend + 1] = leaf
end
BioInd.create_stuff(extend)


local tree, stump, trunk, leaves, branches, shadow
extend = {}
for id, prototype in pairs(data.raw.tree) do
--~ BioInd.show("id", id)
  if prototype.variations and not ignore_trees[id] then
    for i = 1, TREE_LEVELS do
      tree = table.deepcopy(prototype)
      tree.name = "bio-tree-" .. tree.name .. "-" .. i
      if i < (TREE_LEVELS-1) then
        tree.localised_name = {"bi-misc.growing-tree"}
        tree.localised_description = {"bi-misc.growing-tree-desc"}
      else
        tree.localised_name = {"bi-misc.young-tree"}
        tree.localised_description = {"bi-misc.young-tree-desc"}
      end
      tree.max_health = math.floor(50 * i/TREE_LEVELS)
      tree.flags = {"placeable-neutral", "breaths-air"}
      tree.collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile", "layer-13"}
      tree.autoplace = nil
      tree.selection_box = {
        {-0.9/TREE_LEVELS * i, -2.2/TREE_LEVELS * i},
        {0.9/TREE_LEVELS * i, 0.6/TREE_LEVELS * i}
      }
      if BI.Settings.BI_Game_Tweaks_Small_Tree_Collisionbox then
        tree.collision_box = COLLISION_BOX
      end
      tree.minable.mining_particle = "bio-wooden-particle-" .. i
      -- The longer a tree has grown, the harder it is to mine
      --~ tree.minable.mining_time = 0.25
      tree.minable.mining_time = 0.25 * i
      --~ tree.minable.count = nil

      -- Now the tree-level thingie starts to make sense: higher growing stages correspond
      -- to a higher probability of getting something when the tree is mined!
      --~ tree.minable.results = {}
      tree.minable.results = {
        {
          name = (i < TREE_LEVELS) and "seedling" or "wood",
          probability = i/TREE_LEVELS,
          amount = 1,
        }
      }
      -- minable.result will be ignored by Factorio if minable.results exists, but
      -- in data-final-fixes, we check for minable.result == "wood" before setting
      -- minable.results to yield a random number of wood. We therefore must remove
      -- tree.minable.result!
      tree.minable.result = nil

      for var_id, variation in pairs(tree.variations) do
        trunk = variation.trunk
        trunk.scale = (trunk.scale or 1) * i / TREE_LEVELS
        if trunk.shift then
          trunk.shift[1] = trunk.shift[1] / TREE_LEVELS * i
          trunk.shift[2] = trunk.shift[2] / TREE_LEVELS * i
        end

        if trunk.hr_version then
          trunk.hr_version.scale = (trunk.hr_version.scale or 1) * i / TREE_LEVELS

          if trunk.hr_version.shift then
            trunk.hr_version.shift[1] = (trunk.hr_version.shift[1] or 0) / TREE_LEVELS * i
            trunk.hr_version.shift[2] = (trunk.hr_version.shift[2] or 0) / TREE_LEVELS * i

          end
        end

        -- This doesn't make sense, the condition can never be true! Either more
        -- than 4 levels have been used originally, or it should be compared to just
        -- TREE_LEVELS, not TREE_LEVELS/10 (i.e. typo)
        -- EDIT: OwnlyMe's Robot Tree Farm has 20 grow stages per default (min 3, max 200),
        -- so we should use a limit of i<=2.)
        --~ local max = TREE_LEVELS /10
        local max = 2
        if i <= max then
          trunk.layers = {{
            filename = ICONPATH .. "seedling_short.png",
            priority = "extra-high",
            width = 64,
            height = 64,
            scale = 0.5,
            frame_count = 1,
            tint= {
              --~ r = 0.7-0.5*i/(TREE_LEVELS/10),
              --~ g = 0.7-0.5*i/(TREE_LEVELS/10),
              --~ b = 0.7-0.5*i/(TREE_LEVELS/10),
              --~ a = 0.7-0.5*i/(TREE_LEVELS/10)
              r = 0.7-0.5*i/max,
              g = 0.7-0.5*i/max,
              b = 0.7-0.5*i/max,
              a = 0.7-0.5*i/max
            }
          }}
          trunk.frame_count = 1
        end

        leaves = variation.leaves
        leaves.scale = (leaves.scale or 1) * i / TREE_LEVELS
        if leaves.shift then
          leaves.shift[1] = (leaves.shift[1] or 0) / TREE_LEVELS * i
          leaves.shift[2] = (leaves.shift[2] or 0) / TREE_LEVELS * i
        end

        if leaves.hr_version then
          leaves.hr_version.scale = (leaves.hr_version.scale or 1) * i / TREE_LEVELS
          if leaves.hr_version.shift then
            leaves.hr_version.shift[1] = (leaves.hr_version.shift[1] or 0) /TREE_LEVELS * i
            leaves.hr_version.shift[2] = (leaves.hr_version.shift[2] or 0) /TREE_LEVELS * i
          end
        end

        leaf = variation.leaf_generation
        leaf.scale = (leaf.scale or 1) * i / TREE_LEVELS
        leaf.offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
        leaf.initial_height = 2/TREE_LEVELS*i
        leaf.initial_height_deviation = 1/TREE_LEVELS*i
        leaf.entity_name = "bio-leaf-particle-" .. i

        branch = variation.branch_generation
        branch.scale = (branch.scale or 1) * i / TREE_LEVELS
        branch.offset_deviation = {
          {0.5 * i /TREE_LEVELS, 0.5 * i / TREE_LEVELS},
          {0.5 * i / TREE_LEVELS, 0.5 * i / TREE_LEVELS}
        }
        branch.initial_height = 2 / TREE_LEVELS * i
        branch.initial_height_deviation = 2 / TREE_LEVELS * i
        branch.entity_name = "bio-branch-particle-" .. i

        shadow = variation.shadow
        shadow.scale = (shadow.scale or 1) * i / TREE_LEVELS

        if shadow.shift then
          shadow.shift[1] = (shadow.shift[1] or 0) / TREE_LEVELS * i
          shadow.shift[2] = (shadow.shift[2] or 0) / TREE_LEVELS * i
        end

        if shadow.hr_version then
          shadow.hr_version.scale = (shadow.hr_version.scale or 1) * i / TREE_LEVELS
          if shadow.hr_version.shift then
            shadow.hr_version.shift[1] = (shadow.hr_version.shift[1] or 0) / TREE_LEVELS * i
            shadow.hr_version.shift[2] = (shadow.hr_version.shift[2] or 0) / TREE_LEVELS * i
          end
        end
      end


      stump = table.deepcopy(data.raw.corpse[tree.remains_when_mined])

      if stump then
        stump.name = "bio-tree-" .. stump.name .. "-" .. i
        stump.time_before_removed = 60 * 5      -- 5 secs

        tree.remains_when_mined = stump.name
        tree.corpse = stump.name
        extend[#extend + 1] = tree

        for _, variation in pairs(stump.animation) do
          variation.scale = (variation.scale or 1) * i / TREE_LEVELS
          variation.hr_version = nil
          variation.shift[1] = variation.shift[1]/TREE_LEVELS*i
          variation.shift[2] = variation.shift[2]/TREE_LEVELS*i

        end
        extend[#extend + 1] = stump
      end
    end
  end
end
BioInd.create_stuff(extend)


------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BioInd.entered_file("leave")
