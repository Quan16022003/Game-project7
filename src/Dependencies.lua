--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/Constants'
require 'src/StateMachine'
require 'src/Utils'

-- game state
require 'src/states/BaseState'
require 'src/states/game/PlayState'

-- entity state
require 'src/states/entity/PlayerDoorOutState'
require 'src/states/entity/PlayerDoorInState'
require 'src/states/entity/PlayerFallingState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/PlayerRunningState'


-- general
require 'src/Animation'
require 'src/Entity'
require 'src/GameLevel'
require 'src/GameObject'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Tile'
require 'src/TileMap'

gTextures = {
    ['human-idle'] = love.graphics.newImage('Sprites/01-KingHuman/Idle.png'),
    ['human-run'] = love.graphics.newImage('Sprites/01-KingHuman/Run.png'),
    ['human-jump'] = love.graphics.newImage('Sprites/01-KingHuman/Jump.png'),
    ['human-fall'] = love.graphics.newImage('Sprites/01-KingHuman/Fall.png'),
    ['human-door-in'] = love.graphics.newImage('Sprites/01-KingHuman/DoorIn.png'),
    ['human-door-out'] = love.graphics.newImage('Sprites/01-KingHuman/DoorOut.png'),
    ['terrain'] = love.graphics.newImage('Sprites/14-TileSets/Terrain.png'),
    ['decoration'] = love.graphics.newImage('Sprites/14-TileSets/Decorations.png')
}

gFrames = {
    ['human-idle'] = GenerateQuads(gTextures['human-idle'], 78,58),
    ['human-run'] = GenerateQuads(gTextures['human-run'], 78,58),
    ['human-jump'] = GenerateQuads(gTextures['human-jump'], 78,58),
    ['human-fall'] = GenerateQuads(gTextures['human-fall'], 78,58),
    ['human-door-in'] = GenerateQuads(gTextures['human-door-in'], 78,58),
    ['human-door-out'] = GenerateQuads(gTextures['human-door-out'], 78,58),
    ['terrain'] = GenerateQuads(gTextures['terrain'], 32, 32),
    ['decoration'] = GenerateQuads(gTextures['decoration'], 32, 32)
}