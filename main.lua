function love.load()
    love.window.setMode(900,700)
    love.graphics.setBackgroundColor(0,214,255)

    world = love.physics.newWorld(0,500,false)
    world:setCallbacks(beginContact,endContact, preSolve, postSolve)

    gameState =1
    myfont = love.graphics.newFont(30)
    timer = 0


    sprite = {}
    sprite.coin_sheet = love.graphics.newImage("sprites/coin_sheet.png")
    sprite.player_jump = love.graphics.newImage("sprites/player_jump.png")
    sprite.player_stand = love.graphics.newImage("sprites/player_stand.png")
    sprite.player_sprite = love.graphics.newImage("Assets/Player/p1_walk/spritesheet.png")

    require('coin')
    require('Libs.show')
    anim8 = require('Libs.anim8-master.anim8')
    sti = require("Libs.Simple-Tiled-Implementation-master/sti")
    cameraFile = require("Libs.hump-master.camera")
    cam = cameraFile()
    require('filehelper')
    require('player')


    platforms ={}

    saveData = {}
    saveData.bestTime = 999

    LoadData()

    gameMap = sti("maps/Level_1.lua")

     resetPlayer()
    for i, obj in pairs(gameMap.layers["Platform"].objects) do
        spawnPlatform(obj.x, obj.y, obj.width,obj.height)
    end 

    for i, obj in pairs(gameMap.layers["Coins"].objects) do
        spawnCoin(obj.x, obj.y)
    end 

end

function love.update(dt)
    world:update(dt)
    playerUpdate(dt)
    gameMap:update(dt)
    coinUpdate(dt)

    cam:lookAt(player.body:getX(), love.graphics.getHeight() /2)
    for i,c in ipairs(coins) do 
        c.animation:update(dt)
    end 

    if gameState == 2 then 
        timer = timer + dt 
    end 

    if #coins == 0  and gameState == 2 then 
        gameState = 1
        player.body:setPosition(100,100)

        if #coins == 0 then 
            for i, obj in pairs(gameMap.layers["Coins"].objects) do
                spawnCoin(obj.x, obj.y)
            end 

        end 

        if timer < saveData.bestTime then 
            saveData.bestTime = math.floor(timer)
            love.filesystem.write("data.lua",table.show(saveData,"saveData"))
        end 
    end 

    if player.body:getY() > 2000 then 
        player.body:setPosition(100,100)
    end 


end 

function love.draw()
    cam:attach()

    gameMap:drawLayer(gameMap.layers["Foreground"])
    gameMap:drawLayer(gameMap.layers["Scene"])


    player.animation:draw(player.sprite, player.body:getX(),player.body:getY(),nil,player.direction,1,sprite.player_stand:getWidth()/2, sprite.player_stand:getHeight()/2)


    for i,c in ipairs(coins) do 
        c.animation:draw(sprite.coin_sheet,c.x, c.y, nil, nil, nil, 20.5,21)
    end 

    cam:detach()

    if gameState == 1 then 
        love.graphics.setFont(myfont)
        love.graphics.printf("Press any key to begin!", 0, 50, love.graphics.getWidth(), "center")
        love.graphics.printf("Best Time " .. saveData.bestTime, 0, 150, love.graphics.getWidth(), "center")
    end 

    love.graphics.print("Time: " ..  math.floor(timer) ,  10, 660)
    love.graphics.print("Y: " ..  player.body:getY() ,  150, 660)
    
end 

function love.keypressed(key,scancode,isrepeat)
    if key == "space" and player.grounded == true then 
        player.body:applyLinearImpulse(0,-2500)
    end 

    if gameState == 1 then 
        gameState = 2
        timer = 0 
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

function beginContact(a,b,coll)
    player.grounded = true
end

function endContact(a,b,coll)
    player.grounded = false 
end 

function distanceBetween(x1,y1,x2,y2)
    return math.sqrt((y2-y1)^2 + (x2-x1)^2)
end