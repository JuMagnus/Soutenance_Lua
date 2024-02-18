
settings = {}

settings.load = function()
   
    love.mouse.setVisible(false)
    settings.screenCenterX = love.graphics.getWidth() * 0.5
    settings.screenCenterY = love.graphics.getHeight() * 0.5
    settings.screenWidth = love.graphics.getWidth()
    settings.screenHeight = love.graphics.getHeight()
    settings.background = love.graphics.newImage("Images/background.png")
    settings.titleFont = love.graphics.newFont("Fonts/OriginTech.otf", 96)
    settings.customFont26 = love.graphics.newFont("Fonts/goodTimingBd.otf", 26)
    settings.customFont14 = love.graphics.newFont("Fonts/goodTimingBd.otf", 14)

end

settings.draw = function()
    love.graphics.draw(settings.background,0,0)
end

