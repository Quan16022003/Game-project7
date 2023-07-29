PlayState = Class{__include = BaseState}

function PlayState:init()

end

function PlayState:enter(params)
    self.levelNumber = params.levelNumber
    self.level = LevelMaker.CreateMap(MAPS[self.levelNumber])
    self.player = LevelMaker.CreatePlayer(MAPS[self.levelNumber])
    self.player.map = self.level.tileMaps['ground']
    self.player.level = self.level

    self.isPlayed = false
    self.alpha = 1
    Timer.tween(1, {
        [self] = {alpha = 0}
    }):finish(function() self.isPlayed = true end)
end

function PlayState:update(dt)
    if self.isPlayed then
        self.level:clear()
        self.level:update(dt)
        self.player:update(dt)
        if self.player.enteredNextDoor == true then
            gStateMachine:change('change', {
                levelNumber = self.levelNumber,
                level = self.level,
                player = self.player
            })
        end
    end
end

function PlayState:render()
    love.graphics.setColor(rgba(255, 255, 255))
    self.level:render()
    self.player:render()
    
    love.graphics.setColor(rgba(57, 56, 82, self.alpha))
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function PlayState:exit()
end