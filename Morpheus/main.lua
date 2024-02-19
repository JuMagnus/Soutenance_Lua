io.stdout:setvbuf("no")


require("sceneManager")
require("settings")
require("vecteur2")
require("tower")
require("enemies")
require("bullets")
require("waves")
require("sidekick")


sceneManager.addScene("start", "startScene")
sceneManager.addScene("gameplay", "gameplayScene")
sceneManager.addScene("gameOver", "gameOverScene")

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