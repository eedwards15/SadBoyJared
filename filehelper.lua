
function LoadData()
    if love.filesystem.exists("data.lua") then 
        local data =  love.filesystem.load("data.lua")
        data()
    end 
end 

