--[[
    Space Shooter Remake

    Author: Philip Lee

    -- Dependencies --

    A file to organize all of the global dependencies for our project, as
    well as the assets for our game, rather than pollute our main.lua file.
]]

--libraries
Class = require 'lib/class'
push = require 'lib/push'

-- used for timers and tweening
Timer = require 'lib/knife.timer'

-- utility
require 'src/Util'
require 'src/StateMachine'

-- game pieces


-- game states
require 'src/states/BaseState'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

BACKGROUND_SCROLL_SPEED = 60

-- XML/CSV data containing x and y coordinates and width and height of
-- images for our sprites on the main texture
gSheetData = loadSheetData()

-- load atlas textures
gTextures = {
    ['background'] = love.graphics.newImage('graphics/darkPurple.png'),
    ['main'] = love.graphics.newImage('graphics/sheet.png')
}

-- creates a repeating pattern background
gTextures['background']:setWrap('repeat', 'repeat')

-- generate quads for sprites
gFrames = {
    ['background'] = GenerateBackground(gTextures['background']),
    ['beam'] = GenerateQuads(gTextures['main'], gSheetData, 1, 9),
    ['bolt'] = GenerateQuads(gTextures['main'], gSheetData, 10, 12),
    ['button'] = GenerateQuads(gTextures['main'], gSheetData, 13, 16),
    ['cockpit'] = GenerateQuads(gTextures['main'], gSheetData, 17, 48),
    ['cursor'] = GenerateQuads(gTextures['main'], gSheetData, 49, 49),
    ['enemy'] = GenerateQuads(gTextures['main'], gSheetData, 50, 69),
    ['engine'] = GenerateQuads(gTextures['main'], gSheetData, 70, 74),
    ['fire'] = GenerateQuads(gTextures['main'], gSheetData, 75, 94),
    ['gun'] = GenerateQuads(gTextures['main'], gSheetData, 95, 105),
    ['laser'] = GenerateQuads(gTextures['main'], gSheetData, 106, 153),
    ['meteor'] = GenerateQuads(gTextures['main'], gSheetData, 154, 173),
    ['numeral'] = GenerateQuads(gTextures['main'], gSheetData, 174, 184),
    ['pill'] = GenerateQuads(gTextures['main'], gSheetData, 185, 188),
    ['playerLife'] = GenerateQuads(gTextures['main'], gSheetData, 189, 200),
    ['playerShip'] = GenerateQuads(gTextures['main'], gSheetData, 201, 221),
    ['powerup'] = GenerateQuads(gTextures['main'], gSheetData, 222, 237),
    ['scratch'] = GenerateQuads(gTextures['main'], gSheetData, 238, 240),
    ['shield'] = GenerateQuads(gTextures['main'], gSheetData, 241, 246),
    ['speed'] = GenerateQuads(gTextures['main'], gSheetData, 247, 247),
    ['star'] = GenerateQuads(gTextures['main'], gSheetData, 248, 253),
    ['thing'] = GenerateQuads(gTextures['main'], gSheetData, 254, 256),
    ['turret'] = GenerateQuads(gTextures['main'], gSheetData, 257, 258),
    ['ufo'] = GenerateQuads(gTextures['main'], gSheetData, 259, 262),
    ['wing'] = GenerateQuads(gTextures['main'], gSheetData, 263, 294)
}

gSounds = {

}

gStateMachine = {

}