function love.load()
    text = "hello world"
    speed = 500
    world = love.physics.newWorld(800, 600)
    body = love.physics.newBody(world, 50, 50, 0, 0)
    ball = love.physics.newRectangleShape(body, 0, 0, 70, 15)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    local x, y = body:getPosition()
    if isDown("right") and x < 730 then
        x = x + (speed * dt)
    elseif isDown("left") and x > 0 then
        x = x - (speed * dt)
    end

    if isDown("down") and y < 600 then
        y = y + (speed * dt)
    elseif isDown("up") and y > 15 then
        y = y - (speed * dt)
    end
    body:setPosition(x, y)
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
