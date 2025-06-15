SCREEN_WIDTH = 900
SCREEN_HEIGHT = 600

lick = require "lick"
lick.reset = true

local message = ""

local  PIXELS_PER_METER = 100
--makes the world and gravity
local world = love.physics.newWorld(0,10 * PIXELS_PER_METER)



function OnCollisionEnter(a, b, contact)
    local object1, object2 = a:getUserData(), b:getUserData()

    if object1 and object2 then
        object2.canDoubleJump = false
        -- message = object1.tag .. " collided with " .. object2.tag .. " player can " .. tostring(object2.canDoubleJump) 
        object2.isGrounded = true
    end
end


function OnCollisionExit(a, b, contact)
    local object1, object2 = a:getUserData(), b:getUserData()

    if object1 and object2 then
        object2.canDoubleJump = true
        -- message = object1.tag .. " out of " .. object2.tag .. " player can " .. tostring(object2.canDoubleJump) 
        object2.isGrounded = false
    end
end


world:setCallbacks(OnCollisionEnter, OnCollisionExit)

--containers
player = {
    x = 100,
    y = 200,
    w = 100,
    h = 100,
    radius = 100,
    speed = 900,
    tag = "player",
    isGrounded = true,
    canDoubleJump = false,
    jump = 500,
}

platform = {
    x = 0,
    y = 400,
    w = 800,
    h = 100,
    tag = "platform"
}




function love.load()
    player.body = love.physics.newBody(world,player.x,player.y,"dynamic")
    player.shape = love.physics.newCircleShape(player.radius)
    player.fixture = love.physics.newFixture(player.body, player.shape)
    player.body:setFixedRotation(true)
    player.fixture:setUserData(player)

    platform.body = love.physics.newBody(world,platform.x,platform.y,"static")
    platform.shape = love.physics.newRectangleShape(platform.w/2, platform.h/2, platform.w, platform.h)
    platform.fixture = love.physics.newFixture(platform.body, platform.shape)
    platform.body:setFixedRotation(true)
    platform.fixture:setUserData(platform)

    --screens size
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {fullscreen = false, vsync = true})
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
    elseif love.keyboard.isDown('space') and player.isGrounded then
        deltaY = - player.jump

        if player.canDoubleJump == true then
            deltaY = - player.jump
        end
    end

    
    
    player.body:setLinearVelocity(deltaX,deltaY)

    --set back to love.draw
    player.x, player.y = player.body:getPosition()
    platform.x, platform.y = platform.body:getPosition()
end

function love.draw()
    love.graphics.circle("fill", player.x, player.y, player.radius)
    love.graphics.rectangle("fill", platform.x, platform.y, platform.w, platform.h)

    love.graphics.print(message, 50, 50)

end