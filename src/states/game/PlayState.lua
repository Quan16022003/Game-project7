PlayState = Class{__include = BaseState}

function PlayState:init()

end

function PlayState:enter(params)
    self.map = params.map
    self.level = LevelMaker.CreateMap(self.map)
    self.tileMap = self.level.tileMaps['ground']
    self.player = LevelMaker.CreatePlayer(self.map)
    self.player.map = self.tileMap
    self.player.level = self.level
    -- self.player:changeState('falling')
end

function PlayState:update(dt)
    self.level:clear()
    self.player:update(dt)
end

function PlayState:render()
    self.level:render()
    self.player:render()
    -- love.graphics.print(tostring(self.x), 10, 10)
end