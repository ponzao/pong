require("objects")

local function reset(side)
    playing = false
    ball:stop()
    if side == "left" then
        ball:attachToLeftPaddle(leftPlayer.paddle)
    else
        ball:attachToRightPaddle(rightPlayer.paddle)
    end
    starter = side
end

local function collision(a)
    if a == "left" then
        score:rightWins()
        --reset("left")
    elseif a == "right" then
        score:leftWins()
        --reset("right")
    end
end

function love.load()
    playing = false
    altPressed = false
    score = objects.Score:new()

    world = love.physics.newWorld(800, 600)
    world:setCallbacks(collision, nil, nil, nil)

    leftPlayer = objects.Player:new(objects.Paddle:new(world, 20, "left"), objects.Keys:new("w", "s"))
    rightPlayer = objects.Player:new(objects.Paddle:new(world, 770, "right"), objects.Keys:new("up", "down"))

    leftWall = objects.VerticalWall:new(world, -5, 300, "left")
    rightWall = objects.VerticalWall:new(world, 800, 300, "right")
    roof = objects.HorizontalWall:new(world, 400, 0)
    floor = objects.HorizontalWall:new(world, 400, 600)

    ball = objects.Ball:new(world)
    ball2 = objects.Ball:new(world)
    ball3 = objects.Ball:new(world)
    ball4 = objects.Ball:new(world)

    starter = "left"
    math.randomseed(os.time())
    if (math.random(1, 2) == 1) then
        reset("left")
    else
        reset("right")
    end
end

local function move(player)
    player:updatePosition()

    -- TODO this doesn't really make sense
    if playing == false and starter == player.paddle.side then
        ball:followPaddle(player.paddle)
        ball2:followPaddle(player.paddle)
        ball3:followPaddle(player.paddle)
        ball4:followPaddle(player.paddle)
    end
end

function love.update(dt)
    move(leftPlayer)
    move(rightPlayer)

    world:update(dt)
end

function love.draw()
    -- TODO Encapsulate these.
    love.graphics.draw(ball.image, ball.body:getX() - ball.imageXDiff, 
        ball.body:getY() - ball.imageYDiff)
    love.graphics.draw(ball2.image, ball2.body:getX() - ball2.imageXDiff, 
        ball2.body:getY() - ball2.imageYDiff)
    love.graphics.draw(ball3.image, ball3.body:getX() - ball3.imageXDiff, 
        ball3.body:getY() - ball3.imageYDiff)
    love.graphics.draw(ball4.image, ball4.body:getX() - ball4.imageXDiff, 
        ball4.body:getY() - ball4.imageYDiff)
    love.graphics.draw(leftPlayer.paddle.image, leftPlayer.paddle.body:getX() 
        - leftPlayer.paddle.imageXDiff, leftPlayer.paddle.body:getY()
        - leftPlayer.paddle.imageYDiff)
    love.graphics.draw(rightPlayer.paddle.image, rightPlayer.paddle.body:getX()
        - rightPlayer.paddle.imageXDiff, rightPlayer.paddle.body:getY() 
        - rightPlayer.paddle.imageYDiff)
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
            ball2:moveRight()
            ball3:moveRight()
            ball4:moveRight()
        else
            ball:moveLeft()
            ball2:moveLeft()
            ball3:moveLeft()
            ball4:moveLeft()
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
