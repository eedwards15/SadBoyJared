player = {}

player.startx = 100
player.starty = 100 
player.body = love.physics.newBody(world,player.startx,player.starty, "dynamic")
player.shape = love.physics.newRectangleShape(66,92)
player.fixture = love.physics.newFixture(player.body,player.shape)
player.speed = 200
player.grounded = false 
player.direction = 1
player.sprite = sprite.player_sprite
player.frame = 0 
player.grid = anim8.newGrid(72,97,player.sprite:getWidth(),player.sprite:getHeight())
player.animation =  anim8.newAnimation(player.grid('1-11',1),.1)
player.body:setFixedRotation(true)

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
    
    -- if player.grounded == true then 
    --     player.sprite = sprite.player_stand
    -- else 
    --     player.sprite = sprite.player_jump
    -- end

   
end 