TileMap = Class{}

function TileMap:init(width, height, tiles, texture)
    self.width = width
    self.height = height
    self.tiles = tiles or {}
    self.texture = texture
end

--[[
    If our tiles were animated, this is potentially where we could iterate over all of them
    and update either per-tile or per-map animations for appropriately flagged tiles!
]]
function TileMap:update(dt)

end

--[[
    Returns the x, y of a tile given an x, y of coordinates in the world space.
]]
function TileMap:pointToTile(x, y)
    if x < 0 or x > self.width * TILE_SIZE or y < 0 or y > self.height * TILE_SIZE then
        return nil
    end
    
    return self.tiles[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

function TileMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            if self.tiles[y][x].id > 0 then
                self.tiles[y][x]:render(self.texture)
            end
        end
    end
end