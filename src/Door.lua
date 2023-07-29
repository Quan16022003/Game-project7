Door = Class{__includes = GameObject}

function Door:init(def)
    GameObject.init(self, def)
    self.class = "Door"
    self.state = "idle"
end

function Door:collides(target)
    return GameObject.collides(self,target)
end

function Door:open()
    self.texture = "door-opening"
    Timer.every(0.25, function() self.frame = self.frame + 1 end):limit(4)
end

function Door:close()
    self.texture = "door-closing" 
    Timer.every(0.25, function() self.frame = self.frame + 1 end):limit(2)
end

function Door:update(dt)
    if self.state == "closing" and self.frame == 3 then
        self.texture = "idle"
        self.frame = 1
        self.state = "idle"
    end
end
function Door:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame], self.x, self.y)
end