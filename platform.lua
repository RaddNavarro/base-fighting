Platform = {}


platforms = {}


function Platform:load() 
    self:addPlatform(10, 10, 100, 400)
    self:addPlatform(100, 200, 400, 300)
    self:addPlatform(200, 300, 400, 300)
end

function Platform:update(dt)

end

function Platform:addPlatform(x, y, w, h)
    local platform = {
        x = x,
        y = y,
        w = w,
        h = h,
        tag = "platform",

        body = love.physics.newBody(World, x, y,"static"),
        shape = love.physics.newRectangleShape(w/2, h/2, w, h),

    }
    platform.fixture = love.physics.newFixture(platform.body, platform.shape)

    table.insert(platforms, platform)
end


function Platform:draw()
     for i = 1, #platforms do
        local platform = platforms[i]
        love.graphics.rectangle("fill", platform.x, platform.y, platform.w, platform.h)
     end
end