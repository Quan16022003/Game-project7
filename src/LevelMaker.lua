LevelMaker = Class{}
function LevelMaker.CreateMap(mapLevel)
    local entities = {}
    local objects = {}
    local maps = {}

    local width = mapLevel.width
    local height = mapLevel.height

    for k, layer in pairs(mapLevel.layers) do
        if layer.type == "tilelayer" then
            --  Create Map
            local tiles = {}
            local firstgid = 1
            for k, tileset in pairs(mapLevel.tilesets) do
                if tileset.name == layer.class then
                    firstgid = tileset.firstgid
                    break
                end
            end
        
            local tilesNumber = layer.data
            for y = 1, height do
                table.insert(tiles, {})
                for x = 1, width do
                    table.insert(tiles[y], Tile(x,y, tilesNumber[(y-1)*width + x] - firstgid + 1))
                end
            end
            local map = TileMap(width, height, tiles, layer.class)
            maps[layer.name] = map
        elseif layer.class == "objects" then
            for k, object in pairs(layer.objects) do
                if object.name == "door" then
                    table.insert(objects, 
                        Door {
                            texture = 'door-idle',
                            x = object.x, y = object.y,
                            width = 46, height = 56,
                            frame = 1,
                            collidable = false
                        }
                    )
                elseif object.name == "box" then
                    table.insert(objects,
                        GameObject {
                            texture = 'box-idle',
                            x = object.x, y = object.y,
                            width = object.width, height = object.height,
                            frame = 1,
                            collidable = true,
                            hit = false,
                            solid = true
                        }
                    )
                end
            end
        end
    end
    local gameLevel = GameLevel(entities, objects, maps)
    return gameLevel
end

function LevelMaker.CreatePlayer(mapLevel)
    local player
    for k, layer in pairs(mapLevel.layers) do
        if layer.type == "objectgroup" and layer.class == "player" then
            local obj = layer.objects[1]
            player = Player {
                x = obj.x, y = obj.y,
                width = obj.width, height = obj.height,
                stateMachine = StateMachine {
                    ['idle'] = function() return PlayerIdleState(player) end,
                    ['run'] = function() return PlayerRunningState(player) end,
                    ['falling'] = function() return PlayerFallingState(player) end,
                    ['jump'] = function() return PlayerJumpState(player) end,
                    ['door-out'] = function() return PlayerDoorOutState(player) end,
                    ['door-in'] = function() return PlayerDoorInState(player) end
                }
            }
            player:changeState(obj.properties['state'])
            player.direction = obj.properties['direction']
        end
    end
    return player
end