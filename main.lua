function love.load()
    world = love.physics.newWorld(1600, 1200)
    world:setCallbacks(function(a, b, c)
        if a == "left" or a == "right" then print(a,b,c) end
    end, nil, nil, nil)

    leftWall = {}
    leftWall.body = love.physics.newBody(world, 0, 300)
    leftWall.shape = love.physics.newRectangleShape(leftWall.body, 0, 0, 5, 600)
    leftWall.shape:setData("left")
    leftWall.shape:setFriction(0)
    
    rightWall = {}
    rightWall.body = love.physics.newBody(world, 800, 300)
    rightWall.shape = love.physics.newRectangleShape(rightWall.body, 0, 0, 5,
        600)
    rightWall.shape:setData("right")
    rightWall.shape:setFriction(0)
    
    roof = {}
    roof.body = love.physics.newBody(world, 400, 0)
    roof.shape = love.physics.newRectangleShape(roof.body, 0, 0, 800, 5)
    roof.shape:setFriction(0)
    
    floor = {}
    floor.body = love.physics.newBody(world, 400, 600)
    floor.shape = love.physics.newRectangleShape(floor.body, 0, 0, 800, 5)
    floor.shape:setFriction(0)

    ball = {}
    ball.body = love.physics.newBody(world, 400, 300, 1, 0)
    ball.shape = love.physics.newCircleShape(ball.body, 0, 0, 5)
    ball.shape:setRestitution(1)
    ball.body:applyImpulse(20, 5, 0, 0)

    speed = 250
    paddleHeight = 100

    leftPaddle = {}
    leftPaddle.body = love.physics.newBody(world, 20, 300, 10000, 0)
    leftPaddle.shape = love.physics.newRectangleShape(leftPaddle.body, 5, 50,
        10, paddleHeight)

    rightPaddle = {}
    rightPaddle.body = love.physics.newBody(world, 770, 300, 10000, 0)
    rightPaddle.shape = love.physics.newRectangleShape(rightPaddle.body, 5, 50,
        10, paddleHeight)
end

local function leftPlayer(dt)
    local isDown = love.keyboard.isDown
       
    if isDown("s") then
        leftPaddle.body:applyForce(0, 500000, 0, 0)
    elseif isDown("w") then
        leftPaddle.body:applyForce(0, -500000, 0, 0)
    end
end

local function rightPlayer(dt)
    local isDown = love.keyboard.isDown

    if isDown("down") then
        rightPaddle.body:applyForce(0, 500000, 0, 0)
    elseif isDown("up") then
        rightPaddle.body:applyForce(0, -500000, 0, 0)
    end
end

function love.update(dt)
    leftPlayer(dt)
    rightPlayer(dt)

    world:update(dt)
end

function love.draw()
    love.graphics.rectangle("line", 0, 0, 10, 600)
    love.graphics.rectangle("line", 790, 0, 10, 600)
    love.graphics.rectangle("line", 0, 590, 800, 10)
    love.graphics.rectangle("line", 0, 0, 800, 10)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), 5, 16)
    love.graphics.rectangle("fill", leftPaddle.body:getX(), 
        leftPaddle.body:getY(), 10, 100)
    love.graphics.rectangle("fill", rightPaddle.body:getX(),
        rightPaddle.body:getY(), 10, 100)
end

function love.keypressed(k)
    if k == "q" or k == "escape" then
        love.event.push("q")
    end
end
