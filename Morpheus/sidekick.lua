local mTower = require("tower")

local sidekick = {}

sidekick.load = function()
    sidekick.sprite = love.graphics.newImage("images/sidekick.png")
    sidekick.offset = sidekick.sprite:getWidth() * 0.5
end


sidekick.distance = 150
sidekick.angle = 0
sidekick.x = 0
sidekick.y = 0
sidekick.speed = 2
sidekick.rotationAngle = 0
sidekick.rotationSpeed = -10



sidekick.update = function(dt)
    sidekick.x = math.cos(sidekick.angle) * sidekick.distance + mTower.pos.x
    sidekick.y = math.sin(sidekick.angle) * sidekick.distance + mTower.pos.y
    sidekick.angle = sidekick.angle + dt * sidekick.speed
    sidekick.rotationAngle = sidekick.rotationAngle + dt * sidekick.rotationSpeed
end

sidekick.draw = function()
    love.graphics.draw(sidekick.sprite, sidekick.x, sidekick.y, sidekick.rotationAngle, 1, 1, sidekick.offset, sidekick.offset)
    --love.graphics.print(sidekick.speed,10,10)
end


loadSidekick = function()
    sidekick.load()
end

updateSidekick = function(dt)
    sidekick.update(dt)
end

drawSidekick = function()
    sidekick.draw()
end

getSidekick = function()
    return sidekick
end

upgradeSidekick = function()
    if sidekick.speed <= 3.2 then
        sidekick.speed = sidekick.speed * 1.05
    end
end


