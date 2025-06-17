SCREEN_WIDTH = 900
SCREEN_HEIGHT = 600

lick = require "lick"
require("player")

lick.reset = true

local message = ""

local  PIXELS_PER_METER = 100
--makes the world and gravity




--containers
-- player = {
--     x = 100,
--     y = 200,
--     w = 100,
--     h = 100,
--     radius = 100,
--     speed = 900,
--     tag = "player",
--     isGrounded = false,
--     canDoubleJump = true,
--     jump = 500,
-- }

platform = {
    x = 0,
    y = 400,
    w = 800,
    h = 100,
    tag = "platform"
}




function love.load()
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    Player:load()

    platform.body = love.physics.newBody(World,platform.x,platform.y,"static")
    platform.shape = love.physics.newRectangleShape(platform.w/2, platform.h/2, platform.w, platform.h)
    platform.fixture = love.physics.newFixture(platform.body, platform.shape)
    platform.body:setFixedRotation(true)
    platform.fixture:setUserData(platform)

    --screens size
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {fullscreen = false, vsync = true})
end

function love.update(dt)

    World:update(dt)
    Player:update(dt)

end




function beginContact(a, b, collision)
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end

function love.keypressed(key)
    Player:jump(key)
    Player:fastFall(key)
end


function love.draw()

    Player:draw()
    love.graphics.rectangle("fill", platform.x, platform.y, platform.w, platform.h)
    love.graphics.print(message, 50, 50)


end