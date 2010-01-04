function love.load()
    world = love.physics.newWorld(-800, -600, 1600, 1200, 0, 0)

    x, y = 50, 50
    ballBody = love.physics.newBody(world, x, y, 1, 0)
    ball = love.physics.newCircleShape(ballBody, x, y, 1)

    world:setCallbacks(function(t) print("COLLISION") end)

    leftWallBody = love.physics.newBody(world, 50, 300)
    leftWall = love.physics.newRectangleShape(leftWallBody, 0, 0, 5, 800)
    
    rightWallBody = love.physics.newBody(world, 850, 300)
    rightWall = love.physics.newRectangleShape(rightWallBody, 0, 0, 5, 800)
    
    roofBody = love.physics.newBody(world, 400, 50)
    roof = love.physics.newRectangleShape(roofBody, 0, 0, 1000, 5)
    
    floorBody = love.physics.newBody(world, 400, 650)
    floor = love.physics.newRectangleShape(floorBody, 0, 0, 1000, 5)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    x, y = ballBody:getPosition()
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
    love.graphics.circle("fill", x, y, 1, 16)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
