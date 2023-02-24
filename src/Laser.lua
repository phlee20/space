--[[
    Space Shooter Remake

    -- Laser Class --

]]

Laser = Class{}

LASER_SPEED = 500

function Laser:init(x, y)
    self.x = x
    self.y = y

    self.width = 9
    self.height = 54

    self.skin = 1

    self.dead = false
end

function Laser:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    -- if the above aren't true, they're overlapping
    return true
end

function Laser:update(dt)
    self.y = self.y  - LASER_SPEED * dt

    if self.y < 0 then
        self.dead = true
    end
end

function Laser:render()
    love.graphics.draw(gTextures['main'], gFrames['laser'][self.skin], self.x, self.y)
end