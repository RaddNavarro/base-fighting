SCREEN_WIDTH = 900
SCREEN_HEIGHT = 600

lick = require "lick"
require("player")
require("platform")

lick.reset = true




function love.load()
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    Player:load()
    Platform:load()

    

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
    Platform:draw()

end