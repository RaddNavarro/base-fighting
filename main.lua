--containers
player = {
    x = 400,
    y = 200,
    w = 100,
    h = 100,
    radius = 100,
    speed = 300,
}

platform = {
    x = 0,
    y = 400,
    w = 800,
    h = 100,
}

local  PIXELS_PER_METER = 100
--makes the world and gravity
local world = love.physics.newWorld(0,10 * PIXELS_PER_METER)

function love.load()
    player.body = love.physics.newBody(world,player.x,player.y,"dynamic")
    player.shape = love.physics.newCircleShape(player.radius)
    player.fixture = love.physics.newFixture(player.body, player.shape)
    player.body:setFixedRotation(true)

    platform.body = love.physics.newBody(world,platform.x,platform.y,"static")
    platform.shape = love.physics.newRectangleShape(platform.w/2, platform.h/2, platform.w, platform.h)
    platform.fixture = love.physics.newFixture(platform.body, platform.shape)
    platform.body:setFixedRotation(true)
end

function love.update(dt)

    world:update(dt)

    local deltaX,deltaY = player.body:getLinearVelocity()
    deltaX = 0
    
    if love.keyboard.isDown('d') then
        deltaX = player.speed
    elseif love.keyboard.isDown('a') then
        deltaX = - player.speed
    end

    if love.keyboard.isDown('s') then
        deltaY = player.speed
    elseif love.keyboard.isDown('w') then
        deltaY = - player.speed
    end
    
    player.body:setLinearVelocity(deltaX,deltaY)

    --set back to love.draw
    player.x, player.y = player.body:getPosition()
    platform.x, platform.y = platform.body:getPosition()
end

function love.draw()
    love.graphics.circle("fill", player.x, player.y, player.radius)
    love.graphics.rectangle("fill", platform.x, platform.y, platform.w, platform.h)

end