    sprite = {}
    sprite.coin_sheet = love.graphics.newImage("/Assets/Items/DevilLettuce/DevilsLettuce.png")
    sprite.player_jump = love.graphics.newImage("/sprites/player_jump.png")
    sprite.player_stand = love.graphics.newImage("/sprites/player_stand.png")
    sprite.player_sprite = love.graphics.newImage("/Assets/Player/player_1.png")
    sprite.dea_walking = love.graphics.newImage("/Assets/Enemies/DEA_Walking.png")

    audio = {}
    audio.player = {} 
    audio.player.jump = love.audio.newSource("/Assets/Audio/jump.wav", "static")
    audio.player.death  = love.audio.newSource("/Assets/Audio/Death.wav", "static")
    audio.player.death_dea = love.audio.newSource("/Assets/Audio/Meep - Distressed.wav","static")
    audio.player.pickup = love.audio.newSource("/Assets/Audio/126413__cabeeno-rossley__collect-special-coin.wav","static")
    audio.player.win = love.audio.newSource("/Assets/Audio/176748__onioneye__bong-hit.mp3", "static")