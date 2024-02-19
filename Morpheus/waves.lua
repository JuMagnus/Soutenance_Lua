


local wavesComposition = {
    {1, 2, 2},
    {2, 4, 2},
    {3, 4, 3},
    {4, 4, 4},
    {5, 6, 6},
    {6, 8, 6},
    {7, 8, 8},
    {8, 8, 9},
    {9, 12, 12},
    {10, 12, 12},
    {11, 13, 13},
    {12, 13, 13},
    {13, 15, 13},
    {14, 15, 15},
    {15, 9, 9},
    {16, 18, 18},
    {17, 15, 15},
    {18, 16, 15},
    {19, 16, 16},
    {20, 30, 0},
    {21, 0, 30},
    {22, 16, 16},
    {23, 17, 17},
    {24, 19, 19},
    {25, 21, 21},
    {26, 23, 23},
    {27, 25, 25},
    {28, 27, 27},
    {29, 29, 29},
    {30, 40, 40}
}

waveLaunch = function(j)
    purgeEnemiesList()
    purgeBulletList()
    for i=1,wavesComposition[j][2] do
        createEnemy("red")
        currentEnemies = currentEnemies + 1
    end
    for i=1,wavesComposition[j][3] do
        createEnemy("blue")
        currentEnemies = currentEnemies + 1
    end
    currentWave = currentWave + 1
end




--waves.windowSprite = love.graphics.newImage("Images/window.png")
