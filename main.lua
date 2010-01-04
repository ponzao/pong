function love.load()
    text = "hello world"
    speed = 500
    world = love.physics.newWorld(800, 600)
    body = love.physics.newBody(world, 50, 50, 0, 0)
    ball = love.physics.newRectangleShape(body, 0, 0, 70, 15)
    body:setMassFromShapes()
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    local x, y = body:getPosition()
    if isDown("right") then
        body:applyForce(20, 0, 20, 20)
    elseif isDown("left") then
        body:applyForce(-20, 0, 20, 20)
    end

    if isDown("down") then
        body:applyForce(0, 20, 20, 20)
    elseif isDown("up") then
        body:applyForce(0, -20, 20, 20)
    end
    world:update(dt)
end

function love.draw()
    local x, y = body:getPosition()
    love.graphics.print(text, x, y)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
