io.stdout:setvbuf("no")

local start = {}

start.load = function()
    settings.load()
    towerPos = getTowerPos()
end

start.update = function()

end

start.draw = function()
    settings.draw()
    love.graphics.setFont(settings.titleFont)
    love.graphics.print("MORPHEUS",settings.screenCenterX-270,settings.screenCenterY-150)
    love.graphics.setFont(settings.customFont26)
    love.graphics.print("press SPACE to start",settings.screenCenterX-135,settings.screenCenterY)
    love.graphics.print("use MOUSE to shoot",settings.screenCenterX-135,settings.screenCenterY + 80)
    love.graphics.print("use SPACE to swap bullet color",settings.screenCenterX-210,settings.screenCenterY + 120)
    love.graphics.setFont(settings.customFont14)
    love.graphics.print("Music Credits : Alexandre Chaise",settings.screenCenterX-120,settings.screenHeight - 100)

end

start.keypressed = function(key)
    if key == "space" then
        sceneManager.changeScene("gameplay")
    end
end

return start

