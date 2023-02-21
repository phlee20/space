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

    local sheetData = loadSheetData()

    gTextures = {
        ['background'] = love.graphics.newImage('graphics/darkPurple.png'),
        ['main'] = love.graphics.newImage('graphics/sheet.png')
    }

    gTextures['background']:setWrap('repeat', 'repeat')
    
    gFrames = {
        ['background'] = GenerateBackground(gTextures['background']),
        ['beam'] = GenerateQuads(gTextures['main'], sheetData, 1, 9),
        ['bolt'] = GenerateQuads(gTextures['main'], sheetData, 10, 12),
        ['button'] = GenerateQuads(gTextures['main'], sheetData, 13, 16),
        ['cockpit'] = GenerateQuads(gTextures['main'], sheetData, 17, 48),
        ['cursor'] = GenerateQuads(gTextures['main'], sheetData, 49, 49),
        ['enemy'] = GenerateQuads(gTextures['main'], sheetData, 50, 69),
        ['engine'] = GenerateQuads(gTextures['main'], sheetData, 70, 74),
        ['fire'] = GenerateQuads(gTextures['main'], sheetData, 75, 94),
        ['gun'] = GenerateQuads(gTextures['main'], sheetData, 95, 105),
        ['laser'] = GenerateQuads(gTextures['main'], sheetData, 106, 153),
        ['meteor'] = GenerateQuads(gTextures['main'], sheetData, 154, 173),
        ['numeral'] = GenerateQuads(gTextures['main'], sheetData, 174, 184),
        ['pill'] = GenerateQuads(gTextures['main'], sheetData, 185, 188),
        ['playerLife'] = GenerateQuads(gTextures['main'], sheetData, 189, 200),
        ['playerShip'] = GenerateQuads(gTextures['main'], sheetData, 201, 221),
        ['powerup'] = GenerateQuads(gTextures['main'], sheetData, 222, 237),
        ['scratch'] = GenerateQuads(gTextures['main'], sheetData, 238, 240),
        ['shield'] = GenerateQuads(gTextures['main'], sheetData, 241, 246),
        ['speed'] = GenerateQuads(gTextures['main'], sheetData, 247, 247),
        ['star'] = GenerateQuads(gTextures['main'], sheetData, 248, 253),
        ['thing'] = GenerateQuads(gTextures['main'], sheetData, 254, 256),
        ['turret'] = GenerateQuads(gTextures['main'], sheetData, 257, 258),
        ['ufo'] = GenerateQuads(gTextures['main'], sheetData, 259, 262),
        ['wing'] = GenerateQuads(gTextures['main'], sheetData, 263, 294)
    }
    
    gSounds = {

    }

    gStateMachine = {

    }

    -- keep track of background scrolling on Y axis
    backgroundY = -512

    love.keyboard.keysPressed = {}
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
        love.graphics.draw(gTextures['main'], gFrames['speed'][i], 50, 100 * i)
        love.graphics.draw(gTextures['main'], gFrames['turret'][i], 150, 100 * i)
        love.graphics.draw(gTextures['main'], gFrames['ufo'][i], 250, 100 * i)
        love.graphics.draw(gTextures['main'], gFrames['wing'][i], 350, 100 * i)
    end

    push:finish()
end

function loadSheetData()
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

    return quads 
end