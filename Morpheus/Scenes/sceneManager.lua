sceneManager = {}
local sceneList = {}


sceneManager.addScene = function(sceneName, source)
    sceneList[sceneName] = require(source)
end


sceneManager.changeScene = function(wantedScene)
    currentScene = sceneList[wantedScene]
    currentScene.load()
end

sceneManager.update = function(dt)
    currentScene.update(dt)
end

sceneManager.draw = function()
    currentScene.draw()
end

sceneManager.keypressed = function(key)
    currentScene.keypressed(key)
end


return sceneManager