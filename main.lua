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

    world = love.physics.newWorld(-1000, -1000, 1000, 1000)
    world:setCallbacks(collision, nil, nil, nil)

    leftPlayer = objects.Player:new(objects.Paddle:new(world, 20, "left"), objects.Keys:new("w", "s"))
    rightPlayer = objects.Player:new(objects.Paddle:new(world, 770, "right"), objects.Keys:new("up", "down"))

    leftWall = objects.VerticalWall:new(world, -5, 300, "left")
    rightWall = objects.VerticalWall:new(world, 800, 300, "right")
    roof = objects.HorizontalWall:new(world, 400, 0)
    floor = objects.HorizontalWall:new(world, 400, 600)

    ball = objects.Ball:new(world)

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
    end
end

function love.update(dt)
    move(leftPlayer)
    move(rightPlayer)

    world:update(dt)
end

function love.draw()
    -- TODO Encapsulate these.
    love.graphics.circle('fill',
                         ball.body:getX(), 
                         ball.body:getY(),
                         10)
    love.graphics.rectangle('fill',
                           leftPlayer.paddle.body:getX(), 
                           leftPlayer.paddle.body:getY(),
                           leftPlayer.paddle.constants.WIDTH,
                           leftPlayer.paddle.constants.HEIGHT)
    love.graphics.rectangle('fill',
                            rightPlayer.paddle.body:getX(),
                            rightPlayer.paddle.body:getY(),
                            rightPlayer.paddle.constants.WIDTH,
                            rightPlayer.paddle.constants.HEIGHT)
    love.graphics.print(score.left .. " - " .. score.right, 400, 300)
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
