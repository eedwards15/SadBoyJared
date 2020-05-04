collectables = {}
collectables.found = 0 
collectables.total = 0 

function spawn_collectable(x,y)
    local collectable = {}
    collectable.x = x
    collectable.y = y 
    collectable.grid = anim8.newGrid(40,40,40,40)
    collectable.animation = anim8.newAnimation(collectable.grid('1-1',1),1)
    collectable.collected = false
    table.insert(collectables,collectable)
    collectables.total = collectables.total + 1
end

function collectable_update(dt)
    for i,collectable in ipairs(collectables) do 
        if distance_between(collectable.x,collectable.y,player.body:getX(),player.body:getY()) < 50 then
            collectable.collected = true
            audio.player.pickup:play()
        end 
    end 

    for i=#collectables,1,-1 do
        local c = collectables[i]
        if c.collected == true then 
            table.remove(collectables,i)
            collectables.found = collectables.found + 1
        end
    end   
end 

function collectable_draw()
    for i,c in ipairs(collectables) do 
        c.animation:draw(sprite.coin_sheet,c.x, c.y, nil, nil, nil, 20.5,21)
    end 
end 
