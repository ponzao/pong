function love.load()
    text = "hello world"
    x = 400
    y = 300
    speed = 500
    world = love.physics.newWorld(400, 300)
    body = love.physics.newBody(world, 30, 30, 100, 0)
    ball = love.physics.newCircleShape(body, 30, 30, 30)
end

function love.update(dt)
    local isDown = love.keyboard.isDown
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
end

function love.draw()
    love.graphics.print(text, x, y)
end

function love.keypressed(k)
    if k == "q" then
        love.event.push("q")
    end
end
