--[[
    Space Shooter Remake

    -- Player Class --

]]

Player = Class{}

SHIP_SPEED = 200

function Player:init()
    self.x = VIRTUAL_WIDTH / 2 - 50
    self.y = VIRTUAL_HEIGHT - 150

    self.dx = 0
    self.dy = 0

    self.width = 99
    self.height = 99

    self.skin = 1
end

function Player:update(dt)

    if love.keyboard.wasPressed('space') then
        table.insert(listOfLasers, Laser(self.x + self.width / 2, self.y))
    end

    if love.keyboard.isDown('left') then
        self.dx = -SHIP_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = SHIP_SPEED
    elseif love.keyboard.isDown('up') then
        self.dy = -SHIP_SPEED
    elseif love.keyboard.isDown('down') then
        self.dy = SHIP_SPEED
    else
        self.dx = 0
        self.dy = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    elseif self.dx > 0 then
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    elseif self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end

end

function Player:render()
    love.graphics.draw(gTextures['main'], gFrames['playerShip'][self.skin], self.x, self.y)
end