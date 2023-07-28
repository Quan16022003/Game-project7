GameLevel = Class{}

function GameLevel:init(entities, objects, tilemaps)
    self.entities = entities
    self.objects = objects
    self.tileMaps = tilemaps
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:update(dt)
    for k, tileMap in pairs(self.tileMaps) do
        tileMap:update(dt)
    end
    for k, tileMap in pairs(self.tileMaps) do
        tileMap:update(dt)
    end
    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    
    self.tileMaps['ground']:render()
    self.tileMaps['decoration']:render()
    
    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end