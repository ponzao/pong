local Wall = {}
Wall.__index = Wall

function Wall:new(t)
    return setmetatable(t or {}, self)
end

local function createVerticalWall(world, x, y, data)
    local wall = {}
    wall.body = love.physics.newBody(world, x, y)
    wall.shape = love.physics.newRectangleShape(wall.body, 0, 0, 5, 600)
    wall.shape:setData(data)
    return wall
end

local function createHorizontalWall(world, x, y)
    local wall = {}
    wall.body = love.physics.newBody(world, x, y)
    wall.shape = love.physics.newRectangleShape(wall.body, 0, 0, 800, 5)
    wall.shape:setFriction(0)
    return wall
end

local function createPaddle(world, x, paddleConstants, imagePath, keys, side)
    local paddle = {}
    paddle.keys = keys
    paddle.side = side
    paddle.body = love.physics.newBody(world, x, paddleConstants.center,
        10000, 0)
    paddle.shape = love.physics.newRectangleShape(paddle.body, 4, 49,
        paddleConstants.width, paddleConstants.height)
    paddle.x = x
    paddle.image = love.graphics.newImage(imagePath)
    paddle.imageXDiff = math.floor(paddle.image:getWidth() / 2) - 4
    paddle.imageYDiff = math.floor(paddle.image:getHeight() / 2) - 49
    return paddle
end

local function reset(side)
    playing = false
    ball.body:setLinearVelocity(0, 0)
    if side == "left" then
        ball.body:setPosition(35, leftPaddle.body:getY() + 45)
    else
        ball.body:setPosition(755, rightPaddle.body:getY() + 45)
    end
    starter = side
end

local function collision(a)
    if a == "left" then
        score.right = score.right + 1
        reset("left")
    elseif a == "right" then
        score.left = score.left + 1
        reset("right")
    end
end

function love.load()
    playing = false
    altPressed = false
    score = { left = 0, right = 0 }

    world = love.physics.newWorld(800, 600)
    world:setCallbacks(collision, nil, nil, nil)

    leftWall = createVerticalWall(world, -5, 300, "left")
    rightWall = createVerticalWall(world, 800, 300, "right")
    roof = createHorizontalWall(world, 400, 0)
    floor = createHorizontalWall(world, 400, 600)

    ball = {}
    ball.radius = 4
    ball.body = love.physics.newBody(world, 0, 300, 1, 0)
    ball.shape = love.physics.newCircleShape(ball.body, 0, 0, ball.radius)
    ball.shape:setRestitution(1)
    ball.image = love.graphics.newImage("images/ball.png")
    ball.imageXDiff = math.floor(ball.image:getWidth() / 2) - ball.radius
    ball.imageYDiff = math.floor(ball.image:getHeight() / 2) - ball.radius

    paddle = { height = 100, width = 10, force = 250000, center = 250 }

    leftPaddle = createPaddle(world, 20, paddle, "images/paddle.png",
        { up = "w", down = "s" }, "left")
    rightPaddle = createPaddle(world, 770, paddle, "images/paddle.png",
        { up = "up", down = "down" }, "right")

    starter = "left"
    math.randomseed(os.time())
    if (math.random(1, 2) == 1) then
        reset("left")
    else
        reset("right")
    end
end

local function move(playerPaddle)
    local isDown = love.keyboard.isDown
       
    if isDown(playerPaddle.keys.down) then
        playerPaddle.body:applyForce(0, paddle.force, 0, 0)
    elseif isDown(playerPaddle.keys.up) then
        playerPaddle.body:applyForce(0, -paddle.force, 0, 0)
    end

    playerPaddle.body:setPosition(playerPaddle.x, playerPaddle.body:getY())
    if playing == false and starter == playerPaddle.side then
        ball.body:setY(playerPaddle.body:getY() + 45)
    end
end

function love.update(dt)
    move(leftPaddle)
    move(rightPaddle)

    world:update(dt)
end

function love.draw()
    love.graphics.draw(ball.image, ball.body:getX() - ball.imageXDiff, 
        ball.body:getY() - ball.imageYDiff)
    love.graphics.draw(leftPaddle.image, leftPaddle.body:getX() 
        - leftPaddle.imageXDiff, leftPaddle.body:getY()
        - leftPaddle.imageYDiff)
    love.graphics.draw(rightPaddle.image, rightPaddle.body:getX()
        - rightPaddle.imageXDiff, rightPaddle.body:getY() 
        - rightPaddle.imageYDiff)
    love.graphics.print(score.left .. " - " .. score.right, 400, 300)

    love.graphics.setColor(0, 0, 0)
    for i=600,0,-1 do 
        if math.random(0, 1) == 1 then
            love.graphics.rectangle("fill", 0, i, 800, 1)
        end
    end
    love.graphics.setColor(255, 255, 255, 255)
end

function love.keypressed(k)
    if k == " " and playing == false then
        playing = true
        if starter == "left" then
            ball.body:applyImpulse(-20, 0, 0, 0)
        else
            ball.body:applyImpulse(20, 0, 0, 0)
        end
    end
    
    if k == "lalt" then
        altPressed = true
    end

    if k == "q" or k == "escape" or (altPressed and k == "f4") then
        love.event.push("q")
    end
end

function love.keyreleased(k)
    if k == "lalt" then
        altPressed = false
    end
end
