collectables = {}

function SpawnCollectable(x,y)
    local collectable = {}
    collectable.x = x
    collectable.y = y 
    collectable.grid = anim8.newGrid(41,42,123,126)
    collectable.animation = anim8.newAnimation(collectable.grid('1-3',1,'1-3',2,'1-2',3),0.08)
    collectable.collected = false
    table.insert(collectables,collectable)
end

function CollectableUpdate(dt)
    for i,collectable in ipairs(collectables) do 
        if distanceBetween(collectable.x,collectable.y,player.body:getX(),player.body:getY()) < 50 then
            collectable.collected = true
        end 
    end 

    for i=#collectables,1,-1 do
        local c = collectables[i]
        if c.collected == true then 
            table.remove(collectables,i)
        end
    end 
    
end 