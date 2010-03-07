local math = math
local love = love
local setmetatable = setmetatable

module("objects")

Player = {}
Player.__index = Player

function Player:new(paddle, keys)
    return setmetatable({ paddle = paddle, keys = keys }, self)
end

Keys = {}
Keys.__index = Keys

function Keys:new(up, down)
    return setmetatable({ up = up, down = down }, self)
end

Ball = {}
Ball.__index = Ball

function Ball:new(world)
    local body = love.physics.newBody(world, 0, 300, 1, 0)
    local shape = love.physics.newCircleShape(body, 0, 0, 4)
    shape:setRestitution(1)
    local image = love.graphics.newImage("images/ball.png")
    local imageXDiff = math.floor(image:getWidth() / 2) - 4
    local imageYDiff = math.floor(image:getHeight() / 2) - 4
    return setmetatable({ body = body, shape = shape, image = image,
        imageXDiff = imageXDiff, imageYDiff = imageYDiff }, self)
end

function Ball:moveRight()
    self.body:applyImpulse(-20, 0, 0, 0)
end

function Ball:moveLeft()
    self.body:applyImpulse(20, 0, 0, 0)
end

function Ball:followPaddle(paddle)
    self.body:setY(paddle.body:getY() + 45)
end

function Ball:attachToLeftPaddle(paddle)
    self.body:setPosition(35, paddle.body:getY() + 45)
end

function Ball:attachToRightPaddle(paddle)
    self.body:setPosition(755, paddle.body:getY() + 45)
end

function Ball:stop()
    self.body:setLinearVelocity(0, 0)
end

VerticalWall = {}
VerticalWall.__index = VerticalWall

function VerticalWall:new(world, x, y, data)
    local body  = love.physics.newBody(world, x, y)
    local shape = love.physics.newRectangleShape(body, 0, 0, 5, 600)
    shape:setData(data)
    return setmetatable({ body = body, shape = shape }, self)
end

HorizontalWall = {}
HorizontalWall.__index = HorizontalWall

function HorizontalWall:new(world, x, y)
    local body = love.physics.newBody(world, x, y)
    local shape = love.physics.newRectangleShape(body, 0, 0, 800, 5)
    shape:setFriction(0)
    return setmetatable({ body = body, shape = shape }, self)
end

Paddle = {}
Paddle.__index = Paddle
Paddle.constants = { HEIGHT = 100, WIDTH = 10, FORCE = 250000, CENTER = 250 }

function Paddle:new(world, x, side)
    local body = love.physics.newBody(world, x, self.constants.CENTER,
        10000, 0)
    local shape = love.physics.newRectangleShape(body, 4, 49,
        self.constants.WIDTH, self.constants.HEIGHT)
    local image = love.graphics.newImage("images/paddle.png")
    local imageXDiff = math.floor(image:getWidth() / 2) - 4
    local imageYDiff = math.floor(image:getHeight() / 2) - 49
    return setmetatable({ side = side, body = body,
        shape = shape, x = x, image = image, imageXDiff = imageXDiff,
        imageYDiff = imageYDiff }, self)
end

function Paddle:moveDown()
    self.body:applyForce(0, Paddle.constants.FORCE, 0, 0)
end

function Paddle:moveUp()
    self.body:applyForce(0, -Paddle.constants.FORCE, 0, 0)
end

function Paddle:holdPosition() -- XXX ?
    self.body:setPosition(self.x, self.body:getY())
end

Score = {}
Score.__index = Score

function Score:new()
    return setmetatable({ left = 0, right = 0 }, self)
end

function Score:leftWins()
    self.left = self.left + 1
end

function Score:rightWins()
    self.right = self.right + 1
end
