ChangeState = Class{__include = BaseState}

function ChangeState:init()
    self.alpha = 0
    self.width = 0
end

function ChangeState:enter(params)
    self.levelNumber = params.levelNumber
    self.level = params.level
    self.player = params.player
    Timer.tween(1,{
        [self] = {
            alpha = 1,
            width = VIRTUAL_WIDTH
        }
    }):finish(function()
        Timer.after(0.5, function()
            gStateMachine:change("play", {
                levelNumber = self.levelNumber + 1
            })  
        end)
    end)
    
    self.camera = {x=0, y=0}
    self:updateCamera()
end

function ChangeState:update(dt)
    self.level:clear()
    self:updateCamera()
end

function ChangeState:render()
    love.graphics.clear(rgba(57, 56, 82))
    love.graphics.translate(-math.floor(self.camera.x), -math.floor(self.camera.y))
    love.graphics.setColor(rgba(255, 255, 255))
    self.level:render()
    self.player:render()

    love.graphics.setColor(rgba(57, 56, 82, self.alpha))
    love.graphics.circle('fill', self.player.x, self.player.y, self.width)

end

function ChangeState:exit()
end

function ChangeState:updateCamera()
    self.camera.x = self.player.x - VIRTUAL_WIDTH/2
    self.camera.y = self.player.y - VIRTUAL_HEIGHT/2
end