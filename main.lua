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
    ball.shape:setFriction(0)
    ball.body:applyForce(5, 5, 0, 0)

    leftPaddle = {}
    leftPaddle.x, leftPaddle.y = 20, 300
    leftPaddle.body = love.physics.newBody(world, leftPaddle.x, leftPaddle.y, 2)
    leftPaddle.shape = love.physics.newRectangleShape(leftPaddle.body, 5, 50,
        10, 100)

    rightPaddle = {}
    rightPaddle.x, rightPaddle.y = 770, 300
    rightPaddle.body = love.physics.newBody(world, rightPaddle.x, rightPaddle.y, 2)
    rightPaddle.shape = love.physics.newRectangleShape(rightPaddle.body, 5, 50,
        10, 100)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    ball.x, ball.y = ball.body:getPosition()
    leftPaddle.x, leftPaddle.y = leftPaddle.body:getPosition()
    
    if isDown("left") then
        leftPaddle.body:applyForce(-5, 0, 0, 0)
    elseif isDown("right") then
        leftPaddle.body:applyForce(5, 0, 0, 0)
    end
    
    if isDown("down") then
        leftPaddle.body:applyForce(0, 5, 0, 0)
    elseif isDown("up") then
        leftPaddle.body:applyForce(0, -5, 0, 0)
    end
    world:update(dt)
end

function love.draw()
    love.graphics.rectangle("line", 0, 0, 10, 600)
    love.graphics.rectangle("line", 790, 0, 10, 600)
    love.graphics.rectangle("line", 0, 590, 800, 10)
    love.graphics.rectangle("line", 0, 0, 800, 10)
    love.graphics.circle("fill", ball.x, ball.y, 5, 16)
    love.graphics.rectangle("fill", leftPaddle.x, leftPaddle.y, 10, 100)
    love.graphics.rectangle("fill", rightPaddle.x, rightPaddle.y, 10, 100)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
