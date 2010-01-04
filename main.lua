function love.load()
    world = love.physics.newWorld(800, 600)

    world:setCallbacks(function(t) print("COLLISION") end)

    leftWallBody = love.physics.newBody(world, 0, 300)
    leftWall = love.physics.newRectangleShape(leftWallBody, 0, 0, 5, 600)
    
    rightWallBody = love.physics.newBody(world, 800, 300)
    rightWall = love.physics.newRectangleShape(rightWallBody, 0, 0, 5, 600)
    
    roofBody = love.physics.newBody(world, 400, 0)
    roof = love.physics.newRectangleShape(roofBody, 0, 0, 800, 5)
    
    floorBody = love.physics.newBody(world, 400, 600)
    floor = love.physics.newRectangleShape(floorBody, 0, 0, 800, 5)

    ballX, ballY = 400, 300
    ballBody = love.physics.newBody(world, ballX, ballY, 1, 0)
    ball = love.physics.newCircleShape(ballBody, 0, 0, 1)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    ballX, ballY = ballBody:getPosition()
    if isDown("right") then
        ballBody:applyForce(5, 0, 0, 0)
    elseif isDown("left") then
        ballBody:applyForce(-5, 0, 0, 0)
    end

    if isDown("down") then
        ballBody:applyForce(0, 5, 0, 0)
    elseif isDown("up") then
        ballBody:applyForce(0, -5, 0, 0)
    end
    world:update(dt)
end

function love.draw()
    love.graphics.rectangle("line", 0, 0, 10, 600)
    love.graphics.rectangle("line", 790, 0, 10, 600)
    love.graphics.rectangle("line", 0, 590, 800, 10)
    love.graphics.rectangle("line", 0, 0, 800, 10)
    love.graphics.circle("fill", ballX, ballY, 1, 16)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
