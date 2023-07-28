function love.load()
    require 'src/Dependencies'
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gTextures = {
        ['human-idle'] = love.graphics.newImage('Sprites/01-KingHuman/Idle.png'),
        ['human-run'] = love.graphics.newImage('Sprites/01-KingHuman/Run.png'),
        ['human-jump'] = love.graphics.newImage('Sprites/01-KingHuman/Jump.png'),
        ['human-fall'] = love.graphics.newImage('Sprites/01-KingHuman/Fall.png'),
        ['human-door-in'] = love.graphics.newImage('Sprites/01-KingHuman/DoorIn.png'),
        ['human-door-out'] = love.graphics.newImage('Sprites/01-KingHuman/DoorOut.png'),
        ['terrain'] = love.graphics.newImage('Sprites/14-TileSets/Terrain.png'),
        ['decoration'] = love.graphics.newImage('Sprites/14-TileSets/Decorations.png')
    }
    
    gFrames = {
        ['human-idle'] = GenerateQuads(gTextures['human-idle'], 78,58),
        ['human-run'] = GenerateQuads(gTextures['human-run'], 78,58),
        ['human-jump'] = GenerateQuads(gTextures['human-jump'], 78,58),
        ['human-fall'] = GenerateQuads(gTextures['human-fall'], 78,58),
        ['human-door-in'] = GenerateQuads(gTextures['human-door-in'], 78,58),
        ['human-door-out'] = GenerateQuads(gTextures['human-door-out'], 78,58),
        ['terrain'] = GenerateQuads(gTextures['terrain'], 32, 32),
        ['decoration'] = GenerateQuads(gTextures['decoration'], 32, 32)
    }

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end
    }

    gStateMachine:change('play', {
        map = MAP1
    })
    

    love.keyboard.keysPressed = {}
end

function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end


function love.update(dt)
    gStateMachine:update(dt)
    -- if Player.onground then
    --     if love.keyboard.isDown("space") then
    --         Player.dy = -150
    --         Player.onground = false
    --     end
    -- else
    --     Player.dy = Player.dy + GRAVITY
    --     Player.y = Player.y + Player.dy*dt

    --     local tileBottomLeft = tileMap:pointToTile(Player.x + 1, Player.y + Player.height)
    --     local tileBottomRight = tileMap:pointToTile(Player.x + Player.width - 1, Player.y + Player.height)
        
    --     if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) then
    --         Player.dy = 0
    --         Player.y = (tileBottomLeft.y - 1) * TILE_SIZE - Player.height
    --         Player.onground = true
    --     end
    -- end
    -- if love.keyboard.isDown("left") then
    --     Player.x = Player.x - PLAYER_SPEED*dt
    -- end
    -- if love.keyboard.isDown("right") then
    --     Player.x = Player.x + PLAYER_SPEED*dt
    -- end
    -- updateCamera()
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    -- love.graphics.translate(-CameraX, -CameraY)
    -- map:render()
    -- love.graphics.print(tostring(#gFrames['grounds']), 10, 10)
    -- love.graphics.print(tostring(#currentMap.layers), 50, 10)

    -- love.graphics.rectangle("fill", Player.x, Player.y, Player.width, Player.height)
    gStateMachine:render()
    push:finish()
end

-- function updateCamera()
--     CameraX = math.max(0, math.min(Player.x - (VIRTUAL_WIDTH/2 - Player.width/2), currentMap.width*TILE_SIZE - VIRTUAL_WIDTH))
--     CameraY = math.max(0, math.min(Player.y - (VIRTUAL_HEIGHT/2 - Player.height/2), currentMap.height*TILE_SIZE - VIRTUAL_HEIGHT))
-- end