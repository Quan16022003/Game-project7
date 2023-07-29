PlayerDoorInState = Class{__includes = BaseState}

function PlayerDoorInState:init(player)
    self.player = player
    self.player.texture = 'human-door-in'
    local animation = Animation {
        frames = {1,2,3,4,5,6,7,8},
        interval = 0.09
    }
    self.player.currentAnimation = animation
    self.door = self:getDoorObject()
    self.door:open()
end

function PlayerDoorInState:getDoorObject()
    for k, object in pairs(self.player.level.objects) do
        if object:collides(self.player) then
            if object.class == "Door" then
                return object
            end
        end
    end
    return nil
end

function PlayerDoorInState:update(dt)
    if self.door.frame == 5 then
        self.player.currentAnimation:update(dt)
        if self.player.currentAnimation:getCurrentFrame() == 8 then
            self.player.enteredNextDoor = true
        end
    end
end