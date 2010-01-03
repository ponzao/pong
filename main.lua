function love.load()
    text = "hello world"
    x = 400
    y = 300
    speed = 100
end

function love.update(dt)
    local isDown = love.keyboard.isDown
    if isDown("right") then
        x = x + (speed * dt)
    elseif isDown("left") then
        x = x - (speed * dt)
    end

    if isDown("down") then
        y = y + (speed * dt)
    elseif isDown("up") then
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
