
local mTower = require("tower")


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


    bullet.pos = newVector(settings.screenCenterX, settings.screenCenterY)
    bullet.direction = newVector(x, y) - bullet.pos
    bullet.speed = 400
    bullet.color = mTower.color
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
    end


    table.insert(bullets, bullet)
end


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