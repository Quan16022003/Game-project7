PlayerDoorOutState = Class{__includes = BaseState}

function PlayerDoorOutState:init(player)
    self.player = player
    self.player.texture = 'human-door-out'
    local animation = Animation {
        frames = {1,2,3,4,5,6,7,8},
        interval = 0.09
    }
    self.player.currentAnimation = animation
end

function PlayerDoorOutState:update(dt)
    self.player.currentAnimation:update(dt)
    if self.player.currentAnimation:getCurrentFrame() == 8 then
        self.player:changeState('idle')
    end
end