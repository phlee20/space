--[[
    Space Invaders Remake

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

WINDOW_WIDTH = 480
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 480
VIRTUAL_HEIGHT = 720

BACKGROUND_SCROLL_SPEED = 60

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

    gTextures = {
        ['background'] = love.graphics.newImage('graphics/darkPurple.png'),
        ['main'] = love.graphics.newImage('graphics/sheet.png')
    }

    gTextures['background']:setWrap('repeat', 'repeat')
    
    gFrames = {
        ['background'] = GenerateBackground(gTextures['background'])
    }
    
    gSounds = {

    }

    gStateMachine = {

    }

    -- keep track of background scrolling on Y axis
    backgroundY = -512

    love.keyboard.keysPressed = {}

    local quads = {}

    file = io.open("graphics/sheet.csv", "r")

    line = file:read("*l")

    while line ~= nil do
        local quad = {}
        index = 1

        for value in string.gmatch(line, "([^,]+)") do
            quad[index] = value
            index = index + 1
        end
        table.insert(quads, quad)
        line = file:read("*l")
    end

    file:close()

    sprites = GenerateQuads(gTextures['main'], quads)

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function GenerateBackground(atlas)
        
    
    local quad = love.graphics.newQuad(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT * 2,
        atlas:getWidth(), atlas:getHeight()
    )
    return quad

end

function GenerateQuads(atlas, quads)
    local sprites = {}

    local counter = 1

    table.insert(sprites, love.graphics.newQuad(
            quads[10][2], quads[10][3], quads[10][4], quads[10][5], atlas:getDimensions()
    ))
--    for quad in quads do
--       table.insert(sprites[counter], love.graphics.newQuad(
--            quad[i][2], quad[i][3], quad[i][4], quad[i][5], atlas:getDimensions()
--        ))
--    end

    return sprites
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
    love.graphics.draw(gTextures['main'], sprites[1], 100, 100)

    push:finish()
end