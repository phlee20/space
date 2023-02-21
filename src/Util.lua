function GenerateBackground(atlas)
    local quad = love.graphics.newQuad(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT * 2,
        atlas:getWidth(), atlas:getHeight()
    )
    return quad
end

function GenerateQuads(atlas, quads, first, last)
    local sprites = {}

    for i = first, last do
        table.insert(sprites, love.graphics.newQuad(
                quads[i][2], quads[i][3], quads[i][4], quads[i][5], atlas:getDimensions()
        ))
    end

    return sprites
end