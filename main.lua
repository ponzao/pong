function love.load()
    text = "hello world"
    speed = 500
    world = love.physics.newWorld(0, 0, 1600, 1200, 0, 0)
    
    ballBody = love.physics.newBody(world, 50, 50, 0, 0)
    ball = love.physics.newRectangleShape(ballBody, 0, 0, 70, 15)
    ballBody:setMassFromShapes()

    leftWallBody = love.physics.newBody(world, 0, 300)
    leftWall = love.physics.newRectangleShape(leftWallBody, 0, 0, 10, 600)
    
    rightWallBody = love.physics.newBody(world, 790, 300)
    rightWall = love.physics.newRectangleShape(rightWallBody, 0, 0, 10, 600)
    
    roofBody = love.physics.newBody(world, 400, 590)
    roof = love.physics.newRectangleShape(roofBody, 0, 0, 800, 10)
    
    floorBody = love.physics.newBody(world, 400, 0)
    floor = love.physics.newRectangleShape(floorBody, 0, 0, 800, 10)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    local x, y = ballBody:getPosition()
    if isDown("right") then
        ballBody:applyForce(20, 0, 20, 20)
    elseif isDown("left") then
        ballBody:applyForce(-20, 0, 20, 20)
    end

    if isDown("down") then
        ballBody:applyForce(0, 20, 20, 20)
    elseif isDown("up") then
        ballBody:applyForce(0, -20, 20, 20)
    end
    world:update(dt)
end

function love.draw()
    love.graphics.rectangle("line", 0, 0, 10, 600)
    love.graphics.rectangle("line", 790, 0, 10, 600)
    love.graphics.rectangle("line", 0, 590, 800, 10)
    love.graphics.rectangle("line", 0, 0, 800, 10)
    local x, y = ballBody:getPosition()
    love.graphics.print(text, x, y)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
