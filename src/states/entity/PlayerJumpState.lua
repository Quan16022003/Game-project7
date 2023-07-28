--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player)
    self.player = player
    self.player.texture = 'human-jump'
    self.animation = Animation {
        frames = {1},
        interval = 1
    }
    self.player.currentAnimation = self.animation
end

function PlayerJumpState:enter(params)
    self.player.dy = PLAYER_JUMP_VELOCITY
end

function PlayerJumpState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + GRAVITY_AMOUNT
    self.player:moveY(dt)

    -- go into the falling state when y velocity is positive
    if self.player.dy >= 0 then
        self.player:changeState('falling')
    end

    self.player:moveY(dt)

    -- look at two tiles above our head and check for collisions; 3 pixels of leeway for getting through gaps
    local tileLeft = self.player.map:pointToTile(self.player.x + 3, self.player.y)
    local tileRight = self.player.map:pointToTile(self.player.x + self.player.width - 3, self.player.y)

    -- if we get a collision up top, go into the falling state immediately
    if (tileLeft and tileRight) and (tileLeft:collidable() or tileRight:collidable()) then
        self.player.dy = 0
        self.player.y = self.player.y + 1
        self.player:changeState('falling')
    -- else test our sides for blocks

    elseif love.keyboard.isDown('left') then 
        self.player.dx = - PLAYER_RUN_SPEED
        self.player.direction = 'left'
        self.player:moveX(dt)
        self.player:checkLeftCollisions()
    elseif love.keyboard.isDown('right') then
        self.player.dx = PLAYER_RUN_SPEED
        self.player.direction = 'right'
        self.player:moveX(dt)
        self.player:checkRightCollisions()
    end
end