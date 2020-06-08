function init()
    love.window.setMode(320,240)
    love.window.setTitle("Sad Boy Jared")
    love.graphics.setBackgroundColor(0,214,255)

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
    cam:zoom(.22)
    require('filehelper')
    require('map')
    require('player')
    require('helpers')
    require('enemies')
    require('menu')
end 


function love.load()
    init()
    get_total_levels()

    saveData = {}
    saveData.bestTime = 999

    load_save_data()    


    table.insert(menu.buttons, newButton("Start Game", 
    function()
        gameState = 2
        HideMenu()
        timer = 0 
        love.graphics.setColor(255,255,255,1)

    end))
    table.insert(menu.buttons, newButton("Exit", function() love.event.quit(0) end))

    gameMap = sti(map_loader.levels[map_loader.current_level])
    load_level()

end

function love.update(dt)
    UpdateMenu()
    level_complete()

    world:update(dt)
    playerUpdate(dt)
    gameMap:update(dt)
    
    collectable_update(dt)
    enemies_update(dt)

    cam:lookAt(player.body:getX(), love.graphics.getHeight() /2)

    for i,c in ipairs(collectables) do 
        c.animation:update(dt)
    end 

    for i,c in ipairs(enemies) do 
        c.animation:update(dt)
    end 


    if gameState == 2 then 
        timer = timer + dt 
    end 


    if player.body:getY() > 1200 then 
        player.body:setPosition(100,100)
        audio.player.death:setVolume(1)
        audio.player.death:play()
    end 
end 

function love.draw()

    if gameState == 1 then 
        ShowMenu()
        DrawMenu()
    end 
    
    if gameState == 2 then 
        cam:attach()
        collectable_draw() 
        player.animation:draw(player.sprite, player.body:getX(),player.body:getY(),nil,player.direction,1,sprite.player_sprite:getWidth()/2, sprite.player_sprite:getHeight()/2)
        gameMap:drawLayer(gameMap.layers[map_loader.layers.foreground])
        gameMap:drawLayer(gameMap.layers[map_loader.layers.scene])
        enemies_draw() 
        cam:detach()

        love.graphics.print("Time: " ..  math.floor(timer) ,  10, 20)
        love.graphics.print("Found: " .. collectables.found, 230, 20)
        love.graphics.print("Total: " .. collectables.total, 400, 20)
    end 
end 

function love.keypressed(key,scancode,isrepeat)
    if key == "j" and player.grounded == true then 
        player.body:applyLinearImpulse(0,-2500)
        audio.player.jump:setVolume(1.3)
        audio.player.jump:play()
    end 

    if key == "escape" then 
        gameState = 1
    end 

    MenuKeyPressed(key)
end

function beginContact(a,b,coll)
    player.grounded = true
end

function endContact(a,b,coll)
    player.grounded = false 
end 

