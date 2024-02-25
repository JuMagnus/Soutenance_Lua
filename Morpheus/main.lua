io.stdout:setvbuf("no")


require("Scenes/sceneManager")
require("Modules/settings")
require("Modules/vecteur2")
require("Modules/tower")
require("Modules/enemies")
require("Modules/bullets")
require("Modules/waves")
require("Modules/sidekick")


sceneManager.addScene("start", "Scenes/startScene")
sceneManager.addScene("gameplay", "Scenes/gameplayScene")
sceneManager.addScene("gameOver", "Scenes/gameOverScene")

love.load = function()
    sceneManager.changeScene("start")
end

love.update = function(dt)
  sceneManager.update(dt)
end

love.draw = function()
  sceneManager.draw()
end

love.keypressed = function(key)
  sceneManager.keypressed(key)
end