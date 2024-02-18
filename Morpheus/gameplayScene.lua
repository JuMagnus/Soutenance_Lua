if pcall(require, "lldebugger") then
    require("lldebugger").start()
end
io.stdout:setvbuf("no")

local gameplay = {}

require("settings")
require("vecteur2")
local mTower = require("tower")
require("enemies")
require("bullets")
require("waves")
require("sidekick")


gameplay.load = function()

    music = love.audio.newSource("Sounds/gameplayMusic.mp3", "stream")
    laserSound = love.audio.newSource("Sounds/shoot.wav", "static")
    laserSoundClone = love.audio.newSource("Sounds/shoot.wav", "static")
    destroyedEnemy = love.audio.newSource("Sounds/destroyed.wav", "static")
    destroyedEnemyClone = love.audio.newSource("Sounds/destroyed.wav", "static")

    gameplay.upgradeWindow = love.graphics.newImage("Images/upgradeW.png")
    gameplay.upgradeOffsetX = gameplay.upgradeWindow:getWidth() * 0.5
    gameplay.upgradeOffsetY = gameplay.upgradeWindow:getHeight() * 0.5


    settings.load()
    mTower.load()
    loadSidekick()
    purgeEnemiesList()
    purgeBulletList()
    currentWave = 1
    waveLaunch(currentWave)

    isGamePaused = false
    currentState = "fighting"
    score = 0

    
end

gameplay.update = function(dt)
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
    if not music:isPlaying( ) then
		love.audio.play( music )
	end

    if currentState == "paused" then
        isGamePaused = true
    elseif currentState == "fighting" then
        isGamePaused = false
    elseif currentState == "dead" then
        music:stop()
        sceneManager.changeScene("gameOver")
    elseif currentState == "upgrade" then
        isGamePaused = true
    end

    if isGamePaused == false then
        mTower.aim(mouseX, mouseY)
        mTower.update(dt)
        mTower.shoot()  
        updateBullets(dt)
        updateEnemies(dt)
        updateSidekick(dt)
    end

    if mTower.hitPoints <= 0 then
        currentState = "dead"
    end

    if currentEnemies == 0 then
        currentState = "upgrade"
    end
end

gameplay.keypressed = function(key)
    mTower.keypressed(key)
    if key == "space" then
        if currentState == "upgrade" then
            waveLaunch(currentWave)
            upgradeSidekick()
            mTower.upgrade()
            currentState = "fighting"
        end
    end
    if key == "escape" and currentState == "fighting" then
        currentState = "dead"
    end
    if key == "p" and currentState == "fighting" then
        currentState = "paused"
    elseif key == "p" and currentState == "pausedState" then
        currentState = "fighting"
    end
end

gameplay.draw = function()

    settings.draw()
    mTower.draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(settings.customFont14)
    love.graphics.print(mTower.hitPoints,settings.screenCenterX-10,settings.screenCenterY-5)
    love.graphics.setColor(1, 1, 1)
    drawBullets()
    drawEnemies()
    drawSidekick()
    if currentState == "upgrade" then
        love.graphics.draw(gameplay.upgradeWindow,settings.screenCenterX,settings.screenCenterY,0,1,1,gameplay.upgradeOffsetX,gameplay.upgradeOffsetY)
        love.graphics.setFont(settings.customFont26)
        love.graphics.print("Vague "..currentWave, settings.screenCenterX-60, settings.screenCenterY-20)
        love.graphics.print("press SPACE ", settings.screenCenterX-85, settings.screenCenterY+20)
    end

end

return gameplay



