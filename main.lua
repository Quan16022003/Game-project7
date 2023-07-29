require 'src/Dependencies'
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['change'] = function() return ChangeState() end
    }

    gStateMachine:change('play', {
        levelNumber = 1,
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
    Timer.update(dt)
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