local menu_simulations = {}


menu_simulations.bioindustries_1 =
{
  checkboard = false,
  save = "__Bio_Industries__/menu-simulations/menu-simulation-bioindustries_1.zip",
  length = 60 * 10,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.camera_zoom = 1
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0
  ]],
  update =
  [[
  ]]
}
menu_simulations.bioindustries_2 =
{
  checkboard = false,
  save = "__Bio_Industries__/menu-simulations/menu-simulation-bioindustries_2.zip",
  length = 60 * 7,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.camera_zoom = 1
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0
  ]],
  update =
  [[
  ]]
}

menu_simulations.bioindustries_3 =
{
  checkboard = false,
  save = "__Bio_Industries__/menu-simulations/menu-simulation-bioindustries_3.zip",
  length = 60 * 7,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.camera_zoom = 1
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0
  ]],
  update =
  [[
  ]]
}


return menu_simulations
