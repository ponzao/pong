require("objects")

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

    leftWall = objects.VerticalWall:new(world, -5, 300, "left")
    rightWall = objects.VerticalWall:new(world, 800, 300, "right")
    roof = objects.HorizontalWall:new(world, 400, 0)
    floor = objects.HorizontalWall:new(world, 400, 600)

    ball = objects.Ball:new(world)
    leftPaddle = objects.Paddle:new(world, 20, "images/paddle.png",
        { up = "w", down = "s" }, "left")
    rightPaddle = objects.Paddle:new(world, 770, "images/paddle.png",
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
        playerPaddle.body:applyForce(0, objects.Paddle.constants.FORCE, 0, 0)
    elseif isDown(playerPaddle.keys.up) then
        playerPaddle.body:applyForce(0, -objects.Paddle.constants.FORCE, 0, 0)
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
