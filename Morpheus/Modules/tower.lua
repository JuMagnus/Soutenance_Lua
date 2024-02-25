

local tower = {}

tower.load = function()
    tower.sprites = {
        tower = love.graphics.newImage("Images/base.png"),
        blueGun = love.graphics.newImage("Images/blueGun.png"),
        redGun = love.graphics.newImage("Images/redGun.png"),
        reticleBlue = love.graphics.newImage("Images/reticleBlue.png"),
        reticleRed = love.graphics.newImage("Images/reticleRed.png")
    }
    tower.offset = {
        x = tower.sprites.tower:getWidth() * 0.5,
        y = tower.sprites.tower:getHeight() * 0.5,
        reticleX = tower.sprites.reticleBlue:getWidth() * 0.5,
        reticleY = tower.sprites.reticleBlue:getHeight() * 0.5
    }

    tower.pos = newVector((love.graphics.getWidth() * 0.5), (love.graphics.getHeight() * 0.5))
    tower.angle = 0
    tower.gunAngle = 0
    tower.moveSpeed = 120 + (120 * (0.01 * currentWave))
    tower.color = "blue"
    tower.hitPoints = 20
    tower.fireRate = 1
    tower.shootingTimer = 0
    tower.reticleAngle = 0
    tower.invincibility = false
end

tower.aim = function(mouseX,mouseY)
    tower.gunAngle = math.atan2((mouseY - tower.pos.y), (mouseX - tower.pos.x))
end  

tower.shoot = function()
    if love.mouse.isDown(1) and tower.shootingTimer <= 0 then
        tower.shootingTimer = tower.fireRate
        newBullet(mouseX, mouseY)
        if not settings.laserSound:isPlaying( ) then
            settings.laserSound:play()
        else
            settings.laserSoundClone:play()
        end
    end 
end

tower.update = function(dt)
    if love.keyboard.isScancodeDown("w") then
        if tower.pos.y - tower.offset.x > 0 then
            tower.pos.y = tower.pos.y - dt * tower.moveSpeed
        end
    end
    if love.keyboard.isScancodeDown("s") then
        if tower.pos.y + tower.offset.x < settings.screenHeight then
            tower.pos.y = tower.pos.y + dt * tower.moveSpeed
        end
    end
    if love.keyboard.isScancodeDown("a") then
        if tower.pos.x - tower.offset.x > 0 then
            tower.pos.x = tower.pos.x - dt * tower.moveSpeed
        end
    end
    if love.keyboard.isScancodeDown("d") then
        if tower.pos.x + tower.offset.x < settings.screenWidth then
            tower.pos.x = tower.pos.x + dt * tower.moveSpeed
        end
    end
    
    
    
    tower.shootingTimer = tower.shootingTimer - dt
    tower.aim(mouseX,mouseY)
    tower.shoot()
    checkCollisions()
end

tower.draw = function()
    love.graphics.print("tower speed = "..tower.moveSpeed,10,90)
    love.graphics.print("fire rate = "..tower.fireRate,10,30)
    love.graphics.draw(tower.sprites.tower, tower.pos.x, tower.pos.y, tower.angle, 1, 1, tower.offset.x, tower.offset.y)
    if tower.color == "blue" then
        love.graphics.draw(tower.sprites.blueGun, tower.pos.x, tower.pos.y, tower.gunAngle, 1, 1, tower.offset.x, tower.offset.y)
        love.graphics.draw(tower.sprites.reticleBlue, mouseX, mouseY, tower.reticleAngle, 1, 1, tower.offset.reticleX, tower.offset.reticleY)
    elseif tower.color == "red" then
        love.graphics.draw(tower.sprites.redGun, tower.pos.x, tower.pos.y, tower.gunAngle, 1, 1, tower.offset.x, tower.offset.y)
        love.graphics.draw(tower.sprites.reticleRed, mouseX, mouseY, tower.reticleAngle, 1, 1, tower.offset.reticleX, tower.offset.reticleY)
    end
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(settings.customFont14)
    love.graphics.print(tower.hitPoints,tower.pos.x-10,tower.pos.y-5)
    love.graphics.setColor(1, 1, 1)
    
end

tower.keypressed = function(key)

    if key == "space" and tower.color == "blue" then
       tower.color = "red"
    elseif key == "space" and tower.color == "red" then
        tower.color = "blue"
    end

end

tower.takeDamage = function()
    tower.hitPoints = tower.hitPoints - 1
end

tower.upgrade = function()
    if towerHitPoints < 20 then
        tower.hitPoints = tower.hitPoints + 1
    end
    tower.fireRate = tower.fireRate * 0.95
end

--calling functions
checkCollisions = function()
    local enemies = getEnemies()
    local bullets = getBullets()
    local sidekick = getSidekick()
    local bulletState = false

    for _, enemy in ipairs(enemies) do
        for __, bullet in ipairs(bullets) do
            local distance = math.sqrt((enemy.pos.x - bullet.pos.x)^2 + (enemy.pos.y - bullet.pos.y)^2)
            local totalRadius = enemy.offset.x + bullet.offset.x
            if distance <= totalRadius and enemy.isFree == false and bullet.color == enemy.color and bullet.isFree == false then
                enemy.hitpoints = enemy.hitpoints - 1
                if not settings.destroyedEnemy:isPlaying( ) then
                    settings.destroyedEnemy:play()
                else
                    settings.destroyedEnemyClone:play()
                end
                if enemy.hitpoints == 0 then
                    enemy.isFree = true
                    currentEnemies = currentEnemies - 1
                    score = score + 1
                end
                bullet.isFree = true

            end
        end
        local distance = math.sqrt((enemy.pos.x - sidekick.x)^2 + (enemy.pos.y - sidekick.y)^2)
        local totalRadius = enemy.offset.x + sidekick.offset
        if distance <= totalRadius and enemy.isFree == false and enemy.hitBySidekick == false then
            enemy.hitpoints = enemy.hitpoints - 1
            enemy.hitBySidekick = true
            if not settings.destroyedEnemy:isPlaying( ) then
                settings.destroyedEnemy:play()
            else
                settings.destroyedEnemyClone:play()
            end
            if enemy.hitpoints == 0 then
                enemy.isFree = true
                currentEnemies = currentEnemies - 1
                score = score + 1
            end
        end
        if distance > totalRadius and enemy.isFree == false and enemy.hitBySidekick == true then
            enemy.hitBySidekick = false
        end
    end

end

loadTower = function()
    tower.load()
end

updateTower = function(dt)
    tower.update(dt)
end

drawTower = function()
    tower.draw()
end

keypressedTower = function(key)
    tower.keypressed(key)
end

upgradeTower = function()
    tower.upgrade()
end

--setters & getters
takeDamage = function()
    tower.takeDamage()
end

getTowerHitpoints = function()
    return tower.hitPoints
end

getTowerColor = function()
    return tower.color
end

getTowerOffset = function()
    return tower.offset.x
end

getTowerPos = function()
    return tower.pos
end



