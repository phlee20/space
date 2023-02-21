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

    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    -- draw background
    love.graphics.draw(gTextures['background'], gFrames['background'], 0, backgroundY)

    for i = 1, 1 do
        love.graphics.draw(gTextures['main'], gFrames['cursor'][i], 50, 100 * i)
        love.graphics.draw(gTextures['main'], gFrames['turret'][i], 150, 100 * i)
        love.graphics.draw(gTextures['main'], gFrames['ufo'][i], 250, 100 * i)
        love.graphics.draw(gTextures['main'], gFrames['wing'][i], 350, 100 * i)
    end

    push:finish()
end