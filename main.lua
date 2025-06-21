SCREEN_WIDTH = 960
SCREEN_HEIGHT = 640

lick = require("lick")
require("player")
require("platform")
require("map")

lick.reset = true

sti = require 'sti'
gameMap = sti('maps/testMap3.lua')
--local tiles = {
--  0, 1, 0, 0, 0, 0, 0, 0,
--  0, 0, 0, 0, 0, 0, 0, 0,
--  0, 0, 0, 0, 0, 0, 0, 0,
--  0, 0, 0, 0, 0, 0, 0, 0,
--  0, 1, 1, 1, 0, 0, 0, 0,
--  0, 0, 0, 0, 0, 0, 0, 0,
--  0, 0, 0, 0, 0, 0, 0, 0,
--  0, 0, 0, 0, 0, 0, 0, 0,
--}
--
--local gMap = Map:New(tiles, 8, 8)

function love.load()
	World = love.physics.newWorld(0, 0)
	World:setCallbacks(beginContact, endContact)
	Player:load()
--  oldWidth, oldHeight = love.graphics.getWidth(), love.graphics.getHeight()
--  newWidth, newHeight = 960, 640
--  love.window.setMode(newWidth, newHeight)
--  xScale = newWidth / oldWidth
--  yScale = newHeight / oldHeight

--	Platform:load()

	--screens size
  love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, { fullscreen = false, vsync = true })
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
--  dx = 800 / 2 / xScale
--  dy= 600 / 2 / yScale
--  love.graphics.scale(xScale, yScale)
--  love.graphics.print(love.graphics.getWidth() .. love.graphics.getHeight())
	Player:draw()
	-- Platform:draw()
	gameMap:draw()
	--gMap:Render()
end
