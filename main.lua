function love.load()
    world = love.physics.newWorld(800, 600)

    world:setCallbacks(function(t) print("COLLISION") end)

    leftWall = {}
    leftWall.body = love.physics.newBody(world, 0, 300)
    leftWall.shape = love.physics.newRectangleShape(leftWall.body, 0, 0, 5, 600)
    
    rightWall = {}
    rightWall.body = love.physics.newBody(world, 800, 300)
    rightWall.shape = love.physics.newRectangleShape(rightWall.body, 0, 0, 5,
        600)
    
    roof = {}
    roof.body = love.physics.newBody(world, 400, 0)
    roof.shape = love.physics.newRectangleShape(roof.body, 0, 0, 800, 5)
    
    floor = {}
    floor.body = love.physics.newBody(world, 400, 600)
    floor.shape = love.physics.newRectangleShape(floor.body, 0, 0, 800, 5)

    ball = {}
    ball.x, ball.y = 400, 300
    ball.body = love.physics.newBody(world, ball.x, ball.y, 1, 0)
    ball.shape = love.physics.newCircleShape(ball.body, 0, 0, 5)
    ball.shape:setRestitution(1)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    ball.x, ball.y = ball.body:getPosition()
    if isDown("right") then
        ball.body:applyForce(5, 0, 0, 0)
    elseif isDown("left") then
        ball.body:applyForce(-5, 0, 0, 0)
    end

    if isDown("down") then
        ball.body:applyForce(0, 5, 0, 0)
    elseif isDown("up") then
        ball.body:applyForce(0, -5, 0, 0)
    end
    world:update(dt)
end

function love.draw()
    love.graphics.rectangle("line", 0, 0, 10, 600)
    love.graphics.rectangle("line", 790, 0, 10, 600)
    love.graphics.rectangle("line", 0, 590, 800, 10)
    love.graphics.rectangle("line", 0, 0, 800, 10)
    love.graphics.circle("fill", ball.x, ball.y, 5, 16)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
