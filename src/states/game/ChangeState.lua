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
                levelNumber = self.levelNumber
            })  
        end)
    end)
end

function ChangeState:update(dt)
    self.level:clear()
end

function ChangeState:render()
    self.level:render()
    self.player:render()

    love.graphics.setColor(rgba(57, 56, 82, self.alpha))
    love.graphics.circle('fill', self.player.x, self.player.y, self.width)

end

function ChangeState:exit()
end