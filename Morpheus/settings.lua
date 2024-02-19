
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
    settings.music = love.audio.newSource("Sounds/gameplayMusic.mp3", "stream")
    settings.laserSound = love.audio.newSource("Sounds/shoot.wav", "static")
    settings.laserSoundClone = love.audio.newSource("Sounds/shoot.wav", "static")
    settings.destroyedEnemy = love.audio.newSource("Sounds/destroyed.wav", "static")
    settings.destroyedEnemyClone = love.audio.newSource("Sounds/destroyed.wav", "static")
    settings.upgradeWindow = love.graphics.newImage("Images/upgradeW.png")
    settings.upgradeOffsetX = settings.upgradeWindow:getWidth() * 0.5
    settings.upgradeOffsetY = settings.upgradeWindow:getHeight() * 0.5

end

settings.draw = function()
    love.graphics.draw(settings.background,0,0)
end

