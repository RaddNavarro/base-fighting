Ground = {}

grounds = {}

function Ground:load()
	if gameMap.layers["Ground"] then
		for i, obj in pairs(gameMap.layers["Ground"].objects) do
			local ground = {
				body = love.physics.newBody(World, obj.x, obj.y, "static"),
				shape = love.physics.newRectangleShape(obj.width / 2, obj.height / 2, obj.width, obj.height),
			}
			ground.fixture = love.physics.newFixture(ground.body, ground.shape)
			table.insert(grounds, ground)
		end
	end
end
