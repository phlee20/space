--[[
    Space Shooter Remake

    Author: Philip Lee

    -- insert description

    Credit for graphics (amazing work!):
    --

    Credit for music (great loop):
    --

]]

-- initialize our nearest-neighbor filter
love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src/Dependencies'

--[[
    Called once at the beginning of the game to set up game objects,
    variables, etc. and prepare the game world.
]]
function love.load()

    love.window.setTitle('Space Invaders')

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
        canvas = true
    })

    player = Player()
    enemy = Enemy()
    listOfLasers = {}

    -- keep track of background scrolling on Y axis
    backgroundY = -512

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)

    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    -- scroll background, used across all states
    backgroundY = backgroundY + BACKGROUND_SCROLL_SPEED * dt

    -- if we've scrolled the entire image, reset background
    if backgroundY >= 0 then
        backgroundY = -512
    end

    player:update(dt)

    for k, laser in pairs(listOfLasers) do
        laser:update(dt)
        
        if laser:collides(enemy) then
            laser.dead = true
        end

        if laser.dead then
            table.remove(listOfLasers, k)
        end
    end

    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    -- draw background
    love.graphics.draw(gTextures['background'], gFrames['background'], 0, backgroundY)

    player:render()
    enemy:render()
    for k, laser in pairs(listOfLasers) do
        laser:render()
    end

    push:finish()
end