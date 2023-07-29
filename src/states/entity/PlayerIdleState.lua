--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player

    self.animation = Animation {
        frames = {1,2,3,4,5,6,7,8,9,10,11},
        interval = 0.09
    }

    self.player.currentAnimation = self.animation
    self.player.texture = 'human-idle'
end

function PlayerIdleState:update(dt)
    self.player.currentAnimation:update(dt)

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.player:changeState('run')
    end

    if love.keyboard.wasPressed('space') then
        self.player:changeState('jump')
    end
    if love.keyboard.wasPressed('o') then
        -- local doorObject = self:getDoorObject()
        -- if doorObject == true then
        --     self.player:changeState('door-in')        
        -- end
        local door = self.player:checkOnDoor()
        if door ~= nil then
            self.player:changeState('door-in')        
        end
 
    end
end

