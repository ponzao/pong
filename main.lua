require("objects")

local function reset(side)
    playing = false
    ball:stop()
    if side == "left" then
        ball:attachToLeftPaddle(leftPaddle)
    else
        ball:attachToRightPaddle(rightPaddle)
    end
    starter = side
end

local function collision(a)
    if a == "left" then
        score:rightWins()
        reset("left")
    elseif a == "right" then
        score:leftWins()
        reset("right")
    end
end

function love.load()
    playing = false
    altPressed = false
    score = objects.Score:new()

    world = love.physics.newWorld(800, 600)
    world:setCallbacks(collision, nil, nil, nil)

    leftWall = objects.VerticalWall:new(world, -5, 300, "left")
    rightWall = objects.VerticalWall:new(world, 800, 300, "right")
    roof = objects.HorizontalWall:new(world, 400, 0)
    floor = objects.HorizontalWall:new(world, 400, 600)

    ball = objects.Ball:new(world)
    -- TODO Encapsulate keys.
    leftPaddle = objects.Paddle:new(world, 20, 
        { up = "w", down = "s" }, "left")
    rightPaddle = objects.Paddle:new(world, 770, 
        { up = "up", down = "down" }, "right")

    starter = "left"
    math.randomseed(os.time())
    if (math.random(1, 2) == 1) then
        reset("left")
    else
        reset("right")
    end
end

local function move(paddle)
    local isDown = love.keyboard.isDown
       
    if isDown(paddle.keys.down) then
        paddle:moveDown()
    elseif isDown(paddle.keys.up) then
        paddle:moveUp()
    end

    paddle:holdPosition() -- XXX ?
    if playing == false and starter == paddle.side then
        ball:followPaddle(paddle)
    end
end

function love.update(dt)
    move(leftPaddle)
    move(rightPaddle)

    world:update(dt)
end

function love.draw()
    -- TODO Encapsulate these.
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
    for i = 600, 0, -1 do 
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
            ball:moveRight()
        else
            ball:moveLeft()
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
