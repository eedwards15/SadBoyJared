map_loader = {}
map_loader.current_level = 1
map_loader.total_levels = 0
map_loader.layers = {}
map_loader.layers.collectable = "Coins"
map_loader.layers.platform = "Platform"
map_loader.layers.foreground = "Foreground"
map_loader.layers.scene = "Scene"



map_loader.levels = {"maps/Level_1.lua"}


function draw_collectables()
    for i, obj in pairs(gameMap.layers[map_loader.layers.collectable].objects) do
        SpawnCollectable(obj.x, obj.y)
    end 
end 

function draw_platforms()
    for i, obj in pairs(gameMap.layers[map_loader.layers.platform].objects) do
        spawnPlatform(obj.x, obj.y, obj.width,obj.height)
    end 
end 


function spawnPlatform(x,y,width,height)
    local platform = {}
    platform.body = love.physics.newBody(world,x,y,"static")
    platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height)
    platform.fixture = love.physics.newFixture(platform.body,platform.shape)
    platform.width = width
    platform.height = height
    table.insert(platforms,platform)
end 

function Load_Level()
    if #collectables == 0  and gameState == 2 then 
        gameState = 1
        player.body:setPosition(100,100)

        if map_loader.current_level < map_loader.total_levels then 
            map_loader.current_level = map_loader.current_level + 1
            gameMap = sti(map_loader.levels[map_loader.current_level])
        end 

        if #collectables == 0 then 
            draw_collectables()
            draw_platforms()
        end 

        if timer < saveData.bestTime then 
            saveData.bestTime = math.floor(timer)
            saveData() 
        end 
    end 

end

function get_total_levels()
    for index in pairs(map_loader.levels) do
        map_loader.total_levels = map_loader.total_levels  + 1
    end
end 