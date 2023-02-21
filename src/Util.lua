--[[
    Space Shooter Remake

    -- Utilities --

    Author: Philip Lee

    Helper functions for writing Space Shooter.
]]

--[[
    Generates a background quad, double the height of the screen to allow for scrolling 
]]
function GenerateBackground(atlas)
    local quad = love.graphics.newQuad(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT * 2,
        atlas:getWidth(), atlas:getHeight()
    )
    return quad
end

--[[
    Generates all the quads for the game given an 'atlas'.
    Takes the XML sheet data and a start and end position value to the corresponding
    lines for the sprite type.
]]
function GenerateQuads(atlas, quads, first, last)
    local sprites = {}

    for i = first, last do
        table.insert(sprites, love.graphics.newQuad(
                quads[i][2], quads[i][3], quads[i][4], quads[i][5], atlas:getDimensions()
        ))
    end

    return sprites
end

--[[
    Parses CSV data on texture into a table
]]
function loadSheetData()
    local quads = {}

    file = io.open("graphics/sheet.csv", "r")

    -- read first line
    line = file:read("*l")

    -- read data until no lines remain
    while line ~= nil do
        local quad = {}
        index = 1

        -- split string by the occurence of commas
        for value in string.gmatch(line, "([^,]+)") do
            quad[index] = value
            index = index + 1
        end
        table.insert(quads, quad)

        -- read next line
        line = file:read("*l")
    end

    file:close()

    return quads 
end