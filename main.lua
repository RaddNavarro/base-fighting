player = {
    x = 400,
    y = 200,
    w = 200,
    h = 200,
}

platform = {
    x = 400,
    y = 500,
    w = 300,
    h = 100,
}

function love.load()
    speed = 3
end

function love.update(dt)
    if love.keyboard.isDown('d') then
        player.x = player.x + speed
    end
    if love.keyboard.isDown('a') then
        player.x = player.x - speed
    end
    if love.keyboard.isDown('s') then
        player.y = player.y + speed
    end
    if love.keyboard.isDown('w') then
        player.y = player.y - speed
    end
    
end

function love.draw()
    love.graphics.circle("fill", player.x, player.y, 100)
    love.graphics.circle("fill", player.x, player.y, 100)
end