PlayerDoorInState = Class{__includes = BaseState}

function PlayerDoorInState:init(player)
    self.player = player
    self.player.texture = 'human-door-in'
    local animation = Animation {
        frames = {1,2,3,4,5,6,7,8},
        interval = 0.09
    }
    self.player.currentAnimation = animation
end

function PlayerDoorInState:update(dt)
    self.player.currentAnimation:update(dt)
end