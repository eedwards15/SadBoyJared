player = {}

player.startx = 0
player.starty = 0
player.speed = 200
player.direction = 1
player.body = nil 
player.shape = nil
player.fixture = nil
player.grounded = false 
player.sprite = sprite.player_sprite
player.frame = 0 
player.grid = anim8.newGrid(70,92,player.sprite:getWidth(),player.sprite:getHeight())
player.animation =  anim8.newAnimation(player.grid('1-1',1),.1)



function player_init()
    player.starty,player.startx = start_location() 
    player.body = love.physics.newBody(world,player.startx,player.starty, "dynamic")
    player.body:setFixedRotation(true)
    player.shape = love.physics.newRectangleShape(70,92)
    love.physics.newFixture(player.body,player.shape)
end 



function resetPlayer()
    -- local start = gameMap.layers["Start"].objects
    player.startx = 100
    player.starty = 100
end 


function playerUpdate(dt)
    
    if gameState == 2 then 
        if love.keyboard.isDown("left") then 
            player.body:setX(player.body:getX() - player.speed * dt) 
            player.direction = -1
            player.animation:update(dt)
        end 

        if love.keyboard.isDown("right") then 
            player.body:setX(player.body:getX()  + player.speed * dt) 
            player.direction = 1
            player.animation:update(dt)
        end 
    end 
       
end 