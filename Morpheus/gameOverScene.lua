io.stdout:setvbuf("no")

local gameOver = {}

require("settings")

gameOver.load = function()
    settings.load()
end

gameOver.update = function()

end

gameOver.draw = function()
    settings.draw()
    love.graphics.setFont(settings.titleFont)
    love.graphics.print("Game Over", settings.screenCenterX-270,settings.screenCenterY-90)
    love.graphics.setFont(settings.customFont26)
    love.graphics.print("Defeated Enemies : "..score, settings.screenCenterX-130,settings.screenCenterY + 50)
    love.graphics.print("Max Wave : "..currentWave-1, settings.screenCenterX-70,settings.screenCenterY + 100)
    love.graphics.print("press SPACE to start again", settings.screenCenterX-175,settings.screenCenterY + 150)
    love.graphics.print("press ESCAPE to quit game", settings.screenCenterX-175,settings.screenCenterY + 200)
end

gameOver.keypressed = function(key)
    if key == "space" then
        sceneManager.changeScene("gameplay")
    elseif key == "escape" then
        love.event.quit()
    end
end

return gameOver