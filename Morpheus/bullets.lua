
local bullets = {}

newBullet = function(x, y)
    local bullet = {}

    bullet.sprites = {
        blueBullet = love.graphics.newImage("Images/blueDot.png"),
        redBullet = love.graphics.newImage("Images/redDot.png")
    }

    bullet.offset = {
        x = bullet.sprites.blueBullet:getWidth() * 0.5,
        y = bullet.sprites.blueBullet:getHeight() * 0.5
    }
    bullet.spawnPos = getTowerPos()
    bullet.pos = newVector(bullet.spawnPos.x, bullet.spawnPos.y)
    bullet.direction = newVector(x, y) - bullet.pos
    bullet.speed = 400 + (400 * (0.01 * currentWave))
    bullet.color = getTowerColor()
    bullet.isFree = false

    bullet.update = function (dt)
        if bullet.isFree == false then
            bullet.direction = bullet.direction.normalize()
            bullet.pos = bullet.pos + bullet.direction * dt * bullet.speed
        end
    end

    bullet.draw = function()
        if bullet.isFree ==false then
            if bullet.color == "blue"  then
                love.graphics.draw(bullet.sprites.blueBullet, bullet.pos.x, bullet.pos.y, 0, 1, 1, bullet.offset.x, bullet.offset.y)
            elseif bullet.color == "red" then
                love.graphics.draw(bullet.sprites.redBullet, bullet.pos.x, bullet.pos.y, 0, 1, 1, bullet.offset.x, bullet.offset.y)
            end
        end
        love.graphics.print(bullets[1].speed,10,70)
    end

    bullet.upgrade = function()
        if bullet.speed <= 600 then
            bullet.speed = bullet.speed * 1.02
        end
    end


    table.insert(bullets, bullet)
end

--global calling functions
updateBullets = function(dt)
    for i=1,#bullets do        
        bullets[i].update(dt)
    end
end

drawBullets = function()
    for i=1,#bullets do        
        bullets[i].draw()

    end
    
end

purgeBulletList = function()
    for i=#bullets, 1, -1 do
        table.remove(bullets, i)
    end
end

getBullets = function()
    return bullets
end

upgradeBullets = function()
    bullet.upgrade()
end

