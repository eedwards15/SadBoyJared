save_data = {} 
save_data.filename = "data.lua"


function load_save_data()
    if love.filesystem.exists("data.lua") then 
        local data =  love.filesystem.load("data.lua")
        data()
    end 
end 

function save_data()
    --love.filesystem.write(save_data.filename,table.show(saveData,"saveData"))
end 
