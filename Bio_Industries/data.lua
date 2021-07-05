local BioInd = require('common')('Bio_Industries')

if not BI then BI = {} end
if not BI.Settings then BI.Settings = {} end

--~ if not BI_Config then BI_Config = {} end
--~ if not BI_Config.mod then BI_Config.mod = {} end
if not BI_Functions then BI_Functions = {} end
if not BI_Functions.lib then BI_Functions.lib = {} end

if not thxbob then thxbob = {} end
if not thxbob.lib then thxbob.lib = {} end

for var, name in pairs({
  Bio_Cannon = "BI_Bio_Cannon",
  BI_Bio_Fuel = "BI_Bio_Fuel",
  BI_Easy_Bio_Gardens = "BI_Easy_Bio_Gardens",
  BI_Bigger_Wooden_Chests = "BI_Bigger_Wooden_Chests",
  BI_Game_Tweaks_Stack_Size = "BI_Game_Tweaks_Stack_Size",
  BI_Game_Tweaks_Recipe = "BI_Game_Tweaks_Recipe",
  BI_Game_Tweaks_Tree = "BI_Game_Tweaks_Tree",
  BI_Game_Tweaks_Small_Tree_Collisionbox = "BI_Game_Tweaks_Small_Tree_Collisionbox",
  BI_Game_Tweaks_Player = "BI_Game_Tweaks_Player",
  BI_Game_Tweaks_Disassemble = "BI_Game_Tweaks_Disassemble",
  BI_Game_Tweaks_Bot = "BI_Game_Tweaks_Bot",
  BI_Solar_Additions = "BI_Solar_Additions"
}) do
  BI.Settings[var] = BioInd.get_startup_setting(name)
end

--~ BioInd.show("BI.Settings.BI_Easy_Bio_Gardens", BI.Settings.BI_Easy_Bio_Gardens)
--~ BioInd.show("BI.Settings.BI_Game_Tweaks_Disassemble", BI.Settings.BI_Game_Tweaks_Disassemble)
--- Help Files
require ("libs.item-functions") -- From Bob's Libary
require ("libs.recipe-functions") -- From Bob's Libary
require ("libs.technology-functions") -- From Bob's Libary
require ("libs.functions") -- From Bob's Libary
require ("libs.category-functions") -- From Bob's Libary
require ("libs.bi_functions") -- Functions



-- Create the hidden entities
--require("prototypes.hidden_entities.hidden_entities")

--~ BioInd.show("BioInd.compound_entities", BioInd.compound_entities)
--~ error("Break!")






----------------CATEGORIES
require ("prototypes.categories_item")
require ("prototypes.categories_recipe")
require ("prototypes.damage-type")


require ("prototypes.fluid")

----------------TECHNOLOGY
require ("prototypes.technology")
require ("prototypes.technology_optionBioFuel")
require ("prototypes.technology_optionSolar")
require ("prototypes.technology_optionChests")

require ("prototypes.technology_optionCannon")

----------------ENTITY
require ("prototypes.entity_remnants")
require ("prototypes.entity")
require ("prototypes.entity_garden")
require ("prototypes.entity_woodproducts")
require ("prototypes.entity_trees")

require ("prototypes.entity_optionBioFuel")
require ("prototypes.entity_optionSolar")
require ("prototypes.entity_optionChests")
require ("prototypes.entity_optionCannon")
require ("prototypes.entity_optionDarts")

require ("prototypes.compound_entities.hidden_entities") --after other entities

----------------ITEM
require ("prototypes.item")
require ("prototypes.item_garden")
require ("prototypes.item_woodproducts")

require ("prototypes.item_optionBioFuel")
require ("prototypes.item_optionSolar")
require ("prototypes.item_optionChests")
require ("prototypes.item_optionDarts")
require ("prototypes.item_optionCannon")

----------------RECIPE
require ("prototypes.recipe")
require ("prototypes.recipe_forEntity")
require ("prototypes.recipe_garden")
require ("prototypes.recipe_woodproducts")

require ("prototypes.recipe_optionBioFuel")
require ("prototypes.recipe_optionSolar")
require ("prototypes.recipe_optionChests")
require ("prototypes.recipe_optionDarts")
require ("prototypes.recipe_optionCannon")




------------------------------------------------------------------------------------
-- Alien Biomes will degrade tiles to "landfill" if more than 255 tiles are defined
-- in the game. We can register the musk-floor tiles with Alien Biomes so it will
-- try to prioritize the tiles if they exist.
alien_biomes_priority_tiles = alien_biomes_priority_tiles or {}
table.insert(alien_biomes_priority_tiles, "bi-solar-mat")

--~ for i, item in pairs(data.raw.item) do
--~ BioInd.show("Item", i)
--~ end


------------------------------------------------------------------------------------
-- Add icons to our prototypes
BioInd.BI_add_icons()
