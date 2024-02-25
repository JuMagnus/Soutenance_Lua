


local wavesComposition = {
    {1, 2, 2},
    {2, 4, 2},
    {3, 4, 4},
    {4, 8, 8},
    {5, 14, 14},
    {6, 15, 15},
    {7, 20, 20},
    {8, 21, 21},
    {9, 22, 22},
    {10, 25, 25},
    {11, 30, 30},
    {12, 32, 32},
    {13, 33, 33},
    {14, 34, 34},
    {15, 35, 35},
    {16, 36, 36},
    {17, 37, 37},
    {18, 38, 38},
    {19, 39, 39},
    {20, 40, 40},
    {21, 41, 42},
    {22, 42, 42},
    {23, 43, 43},
    {24, 44, 44},
    {25, 45, 45},
    {26, 46, 46},
    {27, 47, 47},
    {28, 48, 48},
    {29, 49, 49},
    {30, 60, 60}
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