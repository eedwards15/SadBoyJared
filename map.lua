map_loader = {}
map_loader.current_level = 1
map_loader.total_levels = 0
map_loader.layers = {}
map_loader.layers.collectable = "Coins"
map_loader.layers.platform = "Platform"
map_loader.layers.foreground = "Foreground"
map_loader.layers.scene = "Scene"
map_loader.layers.start = "Start"
map_loader.layers.enemy_path = "EnemyPath"
map_loader.levels = {"maps/Level_1.lua","maps/Level_2.lua"}

platforms = {}

function start_location()
    for i, obj in pairs(gameMap.layers[map_loader.layers.start].objects) do
        return math.floor(obj.y), math.floor(obj.x)
    end 
end 

function draw_collectables()
    for i, obj in pairs(gameMap.layers[map_loader.layers.collectable].objects) do
        spawn_collectable(obj.x, obj.y)
    end 
end 

function draw_platforms()
    for i, obj in pairs(gameMap.layers[map_loader.layers.platform].objects) do
        spawn_platform(obj.x, obj.y, obj.width,obj.height)
    end 
end 

function remove_platforms()
    for i=#platforms,1,-1 do
        table.remove(platforms,i)
     end   
end 

function add_enemy()
    for i, obj in pairs(gameMap.layers[map_loader.layers.enemy_path].objects) do
        local height = math.floor( obj.y + (obj.height /2))
        local endloc = math.floor( obj.x + obj.width )
        spawn_enemy(obj.x, height, endloc)
    end 
end 

function spawn_platform(x,y,width,height)
    local platform = {}
    platform.body = love.physics.newBody(world,x,y,"static")
    platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height)
    platform.fixture = love.physics.newFixture(platform.body,platform.shape)
    platform.width = width
    platform.height = height
    table.insert(platforms,platform)
end 

function load_level()
    if #collectables == 0  and gameState == 2 then 

        audio.player.win:play()

        remove_enemies()
        remove_platforms()

        if map_loader.current_level < map_loader.total_levels then 
            map_loader.current_level = map_loader.current_level + 1
            gameMap = sti(map_loader.levels[map_loader.current_level])            
        end 


        world = love.physics.newWorld(0,620,false)
        world:setCallbacks(beginContact,endContact, preSolve, postSolve)
        player_init()



        draw_collectables()
        draw_platforms()
        add_enemy() 


        if timer < saveData.bestTime then 
            saveData.bestTime = math.floor(timer)
            save_data() 
        end 

        player.body:setPosition(100,100)
    end 

end

function get_total_levels()
    for index in pairs(map_loader.levels) do
        map_loader.total_levels = map_loader.total_levels  + 1
    end
end 