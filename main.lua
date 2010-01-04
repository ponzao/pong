function love.load()
    world = love.physics.newWorld(-800, -600, 1600, 1200, 0, 0)
    
    x, y = 50, 50
    ballBody = love.physics.newBody(world, x, y, 10, 0)
    ball = love.physics.newCircleShape(ballBody, x, y, 1)

    world:setCallbacks(function(t) print("COLLISION") end)
--[[
    leftWallBody = love.physics.newBody(world, 0, 300)
    leftWall = love.physics.newRectangleShape(leftWallBody, 0, 0, 10, 600)
    ]]
    
    rightWallBody = love.physics.newBody(world, 790, 300)
    rightWall = love.physics.newRectangleShape(rightWallBody, 0, 600, 3, 60)

    roofBody = love.physics.newBody(world, 400, 60)
    roof = love.physics.newRectangleShape(roofBody, 0, 0, 800, 3)

    floorBody = love.physics.newBody(world, 400, 800)
    floor = love.physics.newRectangleShape(floorBody, 0, 0, 800, 3)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    x, y = ballBody:getPosition()
    if isDown("right") then
        ballBody:applyForce(50, 0, 20, 20)
    elseif isDown("left") then
        ballBody:applyForce(-50, 0, 20, 20)
    end

    if isDown("down") then
        ballBody:applyForce(0, 50, 20, 20)
    elseif isDown("up") then
        ballBody:applyForce(0, -50, 20, 20)
    end
    world:update(dt)
end

function love.draw()
    love.graphics.circle("fill", x, y, 1, 16)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
