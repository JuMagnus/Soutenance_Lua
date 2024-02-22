
math.dist = function(x1,y1, x2,y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2) 
end

currentEnemies = 0

local enemiesList = {}

createEnemy = function(color)
    local enemy = {}

    enemy.sprites = {
        red = love.graphics.newImage("Images/redTriangle.png"),
        blue = love.graphics.newImage("Images/blueTriangle.png")
    }
        
    enemy.spriteWidth = enemy.sprites.red:getWidth()
    enemy.spriteHeight = enemy.sprites.red:getHeight()
        
    enemy.offset = {
        x = enemy.spriteWidth * 0.5,
        y = enemy.spriteHeight * 0.5
    }

    -- gather tower info for direction & distance
    enemy.towerPos = getTowerPos()
    enemy.towerOffset = getTowerOffset()

    -- set random spawn point
    local rand = love.math.random()
    local tempX = 0
    local tempY = 0

    if rand > 0 and rand <= 0.25 then
        tempX = love.math.random(0, settings.screenWidth)
        tempY =  0 - enemy.spriteHeight
    elseif rand > 0.25 and rand <= 0.50 then
        tempX = 0 - enemy.spriteWidth
        tempY =  love.math.random(0, settings.screenHeight)
    elseif rand > 0.50 and rand <= 0.75 then
        tempX = settings.screenWidth + enemy.spriteWidth
        tempY =  love.math.random(0, settings.screenHeight)
    elseif rand > 0.75 and rand <= 1 then
        tempX = love.math.random(0, settings.screenWidth)
        tempY =  settings.screenWidth + enemy.spriteHeight
    end

    enemy.pos = newVector(tempX, tempY)
    enemy.direction = enemy.towerPos - enemy.pos
    enemy.norm = enemy.direction.normalize()
    enemy.speed = love.math.random(50,70)
    enemy.hitPoints = 5
    if color == "red" then
        enemy.color = "red"
    elseif color == "blue" then
        enemy.color = "blue"
    end

    enemy.isFree = false
   
    enemy.update = function(dt)
        if #enemiesList ~= nil and enemy.isFree == false then
            enemy.pos = enemy.pos + enemy.norm * dt * enemy.speed
            enemy.dist = math.dist(enemy.pos.x,enemy.pos.y, enemy.towerPos.x,enemy.towerPos.y)
        end
        
        if #enemiesList ~= nil and enemy.dist < enemy.towerOffset and enemy.isFree == false then
            enemy.isFree = true
            currentEnemies = currentEnemies - 1
            takeDamage()
        end
    end

    enemy.draw = function()
        if #enemiesList ~= nil then
            if enemy.isFree == false then
                if enemy.color == "red" then
                    love.graphics.draw(enemy.sprites.red, enemy.pos.x, enemy.pos.y, 0, 1, 1, enemy.offset.x, enemy.offset.y)
                elseif enemy.color == "blue" then
                    love.graphics.draw(enemy.sprites.blue, enemy.pos.x, enemy.pos.y, 0, 1, 1, enemy.offset.x, enemy.offset.y)
                end
            end
        end
    end

    table.insert(enemiesList, enemy)

end

--global calling functions
updateEnemies = function(dt)
    for i=1,#enemiesList do
        enemiesList[i].update(dt)
    end
    
end

drawEnemies = function(dt)
    for i=#enemiesList, 1, -1 do
        enemiesList[i].draw()
    end
end

purgeEnemiesList = function()
    for i=#enemiesList, 1, -1 do
        table.remove(enemiesList, i)
    end
end


--getters
getEnemies = function()
    return enemiesList
end
