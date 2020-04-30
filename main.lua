function init()
    love.window.setMode(900,700)
    love.graphics.setBackgroundColor(0,214,255)
    world = love.physics.newWorld(0,620,false)
    world:setCallbacks(beginContact,endContact, preSolve, postSolve)

    
    gameState = 1
    myfont = love.graphics.newFont(30)
    timer = 0

    require('assetmanager')
    require('collectables')
    require('Libs.show')
    anim8 = require('Libs.anim8-master.anim8')
    sti = require("Libs.Simple-Tiled-Implementation-master/sti")
    cameraFile = require("Libs.hump-master.camera")
    cam = cameraFile()
    require('filehelper')
    require('player')
    require('helpers')
    require('map')
end 


function love.load()
    init()
    get_total_levels()

    platforms ={}
    saveData = {}
    saveData.bestTime = 999

    LoadSaveData()    
    resetPlayer()

    gameMap = sti(map_loader.levels[map_loader.current_level])

    draw_platforms()
    draw_collectables()
end

function love.update(dt)
    world:update(dt)
    playerUpdate(dt)
    gameMap:update(dt)
    CollectableUpdate(dt)

    cam:lookAt(player.body:getX(), love.graphics.getHeight() /2)

    for i,c in ipairs(collectables) do 
        c.animation:update(dt)
    end 

    if gameState == 2 then 
        timer = timer + dt 
    end 

    Load_Level() 

    if player.body:getY() > 2000 then 
        player.body:setPosition(100,100)
    end 
end 

function love.draw()
    cam:attach()

    gameMap:drawLayer(gameMap.layers[map_loader.layers.foreground])
    gameMap:drawLayer(gameMap.layers[map_loader.layers.scene])

    player.animation:draw(player.sprite, player.body:getX(),player.body:getY(),nil,player.direction,1,sprite.player_stand:getWidth()/2, sprite.player_stand:getHeight()/2)

    CollectableDraw() 


    cam:detach()

    if gameState == 1 then 
        love.graphics.setFont(myfont)
        love.graphics.printf("Press any key to begin!", 0, 50, love.graphics.getWidth(), "center")
        love.graphics.printf("Best Time " .. saveData.bestTime, 0, 150, love.graphics.getWidth(), "center")
    end 

    love.graphics.print("Time: " ..  math.floor(timer) ,  10, 660)
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


function beginContact(a,b,coll)
    player.grounded = true
end

function endContact(a,b,coll)
    player.grounded = false 
end 

