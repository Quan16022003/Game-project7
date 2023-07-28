Tile = Class{}

function Tile:init(x,y,id)
    self.x = x
    self.y = y
    self.id = id
    self.width = TILE_SIZE
    self.height = TILE_SIZE
end

function Tile:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render(texture)
    love.graphics.draw(gTextures[texture], gFrames[texture][self.id],
        (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end