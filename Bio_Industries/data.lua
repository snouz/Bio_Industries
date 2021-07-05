local BioInd = require('common')('Bio_Industries')

if not BI then BI = {} end
if not BI.Settings then BI.Settings = {} end

if not BI_Config then BI_Config = {} end
if not BI_Config.mod then BI_Config.mod = {} end
if not BI_Functions then BI_Functions = {} end
if not BI_Functions.lib then BI_Functions.lib = {} end

if not thxbob then thxbob = {} end
if not thxbob.lib then thxbob.lib = {} end

for var, name in pairs({
  Bio_Cannon = "BI_Bio_Cannon",
  BI_Bio_Fuel = "BI_Bio_Fuel",
  BI_Easy_Bio_Gardens = "BI_Easy_Bio_Gardens",
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
--~ BI.Settings.Bio_Cannon = settings.startup["BI_Bio_Cannon"].value
--~ BI.Settings.BI_Bio_Fuel = settings.startup["BI_Bio_Fuel"].value
--~ BI.Settings.BI_Easy_Bio_Gardens = settings.startup["BI_Easy_Bio_Gardens"].value
--~ BI.Settings.BI_Game_Tweaks_Stack_Size = settings.startup["BI_Game_Tweaks_Stack_Size"].value
--~ BI.Settings.BI_Game_Tweaks_Recipe = settings.startup["BI_Game_Tweaks_Recipe"].value
--~ BI.Settings.BI_Game_Tweaks_Tree = settings.startup["BI_Game_Tweaks_Tree"].value
--~ BI.Settings.BI_Game_Tweaks_Small_Tree_Collisionbox = settings.startup["BI_Game_Tweaks_Small_Tree_Collisionbox"].value
--~ BI.Settings.BI_Game_Tweaks_Player = settings.startup["BI_Game_Tweaks_Player"].value
--~ BI.Settings.BI_Game_Tweaks_Disassemble = settings.startup["BI_Game_Tweaks_Disassemble"].value
--~ BI.Settings.BI_Game_Tweaks_Bot = settings.startup["BI_Game_Tweaks_Bot"].value
--~ BI.Settings.BI_Solar_Additions = settings.startup["BI_Solar_Additions"].value

BioInd.show("BI.Settings.BI_Easy_Bio_Gardens", BI.Settings.BI_Easy_Bio_Gardens)
--~ BioInd.show("BI.Settings.BI_Game_Tweaks_Disassemble", BI.Settings.BI_Game_Tweaks_Disassemble)
--- Help Files
require ("libs.item-functions") -- From Bob's Libary
require ("libs.recipe-functions") -- From Bob's Libary
require ("libs.technology-functions") -- From Bob's Libary
require ("libs.functions") -- From Bob's Libary
require ("libs.category-functions") -- From Bob's Libary
require ("libs.bi_functions") -- Functions

require ("prototypes.category")


--- Bio Farm
require ("prototypes.Bio_Farm.entities")
require ("prototypes.Bio_Farm.item")
require ("prototypes.Bio_Farm.recipe")
require ("prototypes.Bio_Farm.liquids")
require ("prototypes.Bio_Farm.recipe-categories")
require ("prototypes.Bio_Farm.pipeConnectors")
require ("prototypes.Bio_Farm.technology")
require ("prototypes.Bio_Farm.tree_entities")

-- Bio Garden
require ("prototypes.Bio_Garden.entities")
require ("prototypes.Bio_Garden.item")
require ("prototypes.Bio_Garden.recipe")
require ("prototypes.Bio_Garden.recipe-categories")


--- Bio Solar Farm
require ("prototypes.Bio_Solar_Farm.entities")
require ("prototypes.Bio_Solar_Farm.item")
require ("prototypes.Bio_Solar_Farm.recipe")


--- Wood Products
require ("prototypes.Wood_Products.entities")
require ("prototypes.Wood_Products.item")
require ("prototypes.Wood_Products.recipe")


--- Dart Turret (Bio turret)
require ("prototypes.Bio_Turret.item-group")
require ("prototypes.Bio_Turret.damage-type")
require ("prototypes.Bio_Turret.item")
require ("prototypes.Bio_Turret.recipe")
require ("prototypes.Bio_Turret.entity")


--- Bio Cannon
-- Items Groups
require ("prototypes.Bio_Cannon.item-group")

-- Cannon
require ("prototypes.Bio_Cannon.item")
require ("prototypes.Bio_Cannon.recipe")
require ("prototypes.Bio_Cannon.entity")
require ("prototypes.Bio_Cannon.technology")

-- Projectiles
require ("prototypes.Bio_Cannon.projectiles-item")
require ("prototypes.Bio_Cannon.projectiles-recipe")
require ("prototypes.Bio_Cannon.projectiles-entity")


---- Add Bio Fuel & Plastic, etc.
require("prototypes.Bio_Fuel.item")
require("prototypes.Bio_Fuel.recipe")
require("prototypes.Bio_Fuel.entities")
require("prototypes.Bio_Fuel.technology")


------------------------------------------------------------------------------------
-- Alien Biomes will degrade tiles to "landfill" if more than 255 tiles are defined
-- in the game. We can register the musk-floor tiles with Alien Biomes so it will
-- try to prioritize the tiles if they exist.
alien_biomes_priority_tiles = alien_biomes_priority_tiles or {}
table.insert(alien_biomes_priority_tiles, "bi-solar-mat")
