enemies = {} 

function spawn_enemy(x,y, endLocation)
    local enemy = {}
    enemy.start = x
    enemy.endlocation = endLocation
    enemy.x = x
    enemy.y = y 
    enemy.speed = 200
    enemy.direction = 1
    enemy.grid = anim8.newGrid(53,92,424,92)
    enemy.animation = anim8.newAnimation(enemy.grid('1-8',1),.1)
    table.insert(enemies,enemy)
end


function enemies_draw()
    for i,c in ipairs(enemies) do 
        c.animation:draw(sprite.dea_walking,c.x, c.y, nil, c.direction, 1, 53/2,92/2)
    end 
end 


function enemies_update(dt)   
    if gameState == 2 then 
        for i,enemy in ipairs(enemies) do 

                if enemy.x >= math.floor(enemy.endlocation) and enemy.direction == 1 then 
                    enemy.direction = -1
                end 

                if enemy.x <= math.floor(enemy.start) and enemy.direction == -1 then 
                    enemy.direction = 1
                end 


                if enemy.x <= enemy.endlocation and enemy.direction == 1 then 
                    enemy.x = enemy.x + enemy.speed * dt
                end 

                if enemy.x >=  enemy.start and enemy.direction == -1 then 
                    enemy.x = enemy.x - enemy.speed * dt
                end 


     

        end 
    end 
       
end 