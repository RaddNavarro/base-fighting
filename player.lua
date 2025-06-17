Player = {}

message = ""


function Player:load()
    self.x = 100
    self.y = 200
    self.w = 100
    self.h = 100
    self.yVelocity = 0
    self.xVelocity = 0
    self.radius = 50
    self.maxSpeed = 500
    self.acceleration = 4000
    self.friction = 3500
    self.gravity = 1500
    self.tag = "player"
    self.isGrounded = false
    self.canDoubleJump = true
    self.jumpAmount = -500

    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newCircleShape(self.radius)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setUserData(self)


end

function Player:update(dt)
    self:syncPhysics()
    self:move(dt)
    self:applyGravity(dt)
end


function Player:move(dt)
    if love.keyboard.isDown("d") then
        if self.xVelocity < self.maxSpeed then
            if self.xVelocity + self.acceleration * dt < self.maxSpeed then
                
                self.xVelocity = self.xVelocity + self.acceleration * dt
            else
                self.xVelocity = self.maxSpeed
            end
        end
    elseif love.keyboard.isDown("a") then
        if self.xVelocity > -self.maxSpeed then
            if self.xVelocity - self.acceleration * dt > -self.maxSpeed then
                
                self.xVelocity = self.xVelocity - self.acceleration * dt
            else
                self.xVelocity = -self.maxSpeed
            end
        end
    else
        self:applyFriction(dt) 
    end
end

function Player:jump(key)
    if key == "space" then
        if self.isGrounded then
            self.yVelocity = self.jumpAmount
            self.isGrounded = false
        elseif self.canDoubleJump then
            self.yVelocity = self.jumpAmount 
            self.canDoubleJump = false
        end
    end
end

function Player:fastFall(key)
    if key == "s" and not self.isGrounded then
        if self.yVelocity < self.maxSpeed then
            -- 0.08 needs some fixing, it's better if its delta time
            if self.yVelocity + self.acceleration * 0.08 < self.maxSpeed then
                
                self.yVelocity = self.yVelocity + self.acceleration * 0.08
            else
                self.yVelocity = self.maxSpeed
            end
        end
    end
    
end

function Player:applyGravity(dt)
    if not self.isGrounded then
        self.yVelocity = self.yVelocity + self.gravity * dt
    end
end

function Player:applyFriction(dt)
    if self.xVelocity > 0 then
        if self.xVelocity - self.friction * dt > 0 then
            self.xVelocity = self.xVelocity - self.friction * dt  
        else
            self.xVelocity = 0
        end 
    elseif self.xVelocity < 0 then
        if self.xVelocity + self.friction * dt < 0 then
            self.xVelocity = self.xVelocity + self.friction * dt
        else
            self.xVelocity = 0
        end
    end
end


function Player:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()

    self.physics.body:setLinearVelocity(self.xVelocity, self.yVelocity)
end


function Player:beginContact(a, b, collision)
    if self.isGrounded then return end
    
    local normalX, normalY = collision:getNormal()
    
    if a == self.physics.fixture then
        if normalY > 0 then
            self:landed(collision)
        end
    elseif b == self.physics.fixture then
        if normalY < 0 then 
            self:landed(collision)
        end
    end
end

function Player:landed(collision)
    self.currentGroundCollision = collision
    self.yVelocity = 0
    self.isGrounded = true
    self.canDoubleJump = true
end

function Player:endContact(a, b, collision)
    if a == self.physics.fixture or b == self.physics.fixture then
        if self.currentGroundCollision == collision then
            self.isGrounded = false
        end
    end
end


function Player:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end