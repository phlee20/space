
function love.load()
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

    gTexture = love.graphics.newImage('graphics/sheet.png')

    sprites = GenerateQuads(gTexture, quads)

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

function love.draw()
    love.graphics.draw(gTexture, sprites[1], 100, 100)
end