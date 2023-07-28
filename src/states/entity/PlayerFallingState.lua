PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(player)
    self.player = player
    self.player.texture = 'human-fall'
    local animation = Animation {
        frames = {1},
        interval = 1
    }
    self.player.currentAnimation = animation
end

function PlayerFallingState:update(dt)
    self.player.dy = self.player.dy + GRAVITY_AMOUNT
    self.player:moveY(dt)

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
    local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

    -- if we get a collision beneath us, go into either walking or idle
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidable() or tileBottomRight:collidable()) then
        self.player.dy = 0
        
        -- set the player to be walking or idle on landing depending on input
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('run')
        else
            self.player:changeState('idle')
        end

        self.player.y = (tileBottomLeft.y - 1) * TILE_SIZE - self.player.height
    
    -- go back to start if we fall below the map boundary

    elseif love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.dx = -PLAYER_RUN_SPEED
        self.player:moveX(dt)
        self.player:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.dx = PLAYER_RUN_SPEED
        self.player:moveX(dt)
        self.player:checkRightCollisions(dt)
    end
end