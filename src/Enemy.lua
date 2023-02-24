--[[
    Space Shooter Remake

    -- Enemy Class --

]]

Enemy = Class{}


function Enemy:init()
    self.x = VIRTUAL_WIDTH / 2 - 50
    self.y = 50

    self.dx = 0

    self.width = 99
    self.height = 99

    self.skin = 1
end

function Enemy:update(dt)


end

function Enemy:render()
    love.graphics.draw(gTextures['main'], gFrames['enemy'][self.skin], self.x, self.y)
end