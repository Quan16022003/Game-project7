--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerRunningState = Class{__includes = BaseState}
function PlayerRunningState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1,2,3,4,5,6,7,8},
        interval = 0.09
    }
    self.player.currentAnimation = self.animation
    self.player.texture = 'human-run'
end

function PlayerRunningState:update(dt)
    self.player.currentAnimation:update(dt)

    if not (love.keyboard.isDown('left') or love.keyboard.isDown('right')) then
        self.player.dx = 0
        self.player:changeState('idle')
    else
        local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
        local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)
        self.player.y = self.player.y + 1

        local collidedObjects = self.player:checkObjectCollisions()

        self.player.y = self.player.y - 1

        -- check to see whether there are any tiles beneath us
        if #collidedObjects == 0 and (tileBottomLeft and tileBottomRight) and (not tileBottomLeft:collidable() and not tileBottomRight:collidable()) then
            self.player.dy = 0
            self.player:changeState('falling')
        else
            if love.keyboard.isDown('left') then 
                self.player.dx = - PLAYER_RUN_SPEED
                -- self.player.dx = math.max(self.player.dx - PLAYER_RUN_SPEED/5, -PLAYER_RUN_SPEED)
                self.player.direction = 'left'
                self.player:moveX(dt)
                self.player:checkLeftCollisions(dt)
            end
            if love.keyboard.isDown('right') then
                self.player.dx = PLAYER_RUN_SPEED
                -- self.player.dx = math.min(self.player.dx + PLAYER_RUN_SPEED/5, PLAYER_RUN_SPEED)
                self.player.direction = 'right'
                self.player:moveX(dt)
                self.player:checkRightCollisions(dt)
            end
        end
    end
    -- self.player.x = self.player.x + self.player.dx*dt
    if love.keyboard.wasPressed('space') then
        self.player:changeState('jump')
    end
end