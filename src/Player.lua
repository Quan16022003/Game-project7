Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.score = 0
    self.enteredNextDoor = false
end

function Player:update(dt)
    -- if self.dx < 0 then
    --     self.dx = math.min(0, self.dx + PLAYER_RUN_SPEED/20)
    -- elseif self.dx > 0 then
    --     self.dx = math.max(0, self.dx - PLAYER_RUN_SPEED/20)
    -- end
    Entity.update(self, dt)
end

function Player:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
    math.floor(self.x)+self.width/2, math.floor(self.y), 0, self.direction == 'right' and 1 or -1, 1, 32, 14)
    -- love.graphics.setLineWidth(1)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.print(tostring(self:checkOnDoor()), 10, 10)
end

function Player:moveX(dt)
    self.x = self.x + self.dx*dt
end
function Player:moveY(dt)
    self.y = self.y + self.dy*dt
end

function Player:checkLeftCollisions(dt)
    -- check for left two tiles collision
    local tileTopLeft = self.map:pointToTile(self.x + 1, self.y + 1)
    local tileBottomLeft = self.map:pointToTile(self.x + 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if (tileTopLeft and tileBottomLeft) and (tileTopLeft:collidable() or tileBottomLeft:collidable()) then
        self.dx = 0
        self.x = (tileTopLeft.x - 1) * TILE_SIZE + tileTopLeft.width - 1
    else
        
        -- allow us to walk atop solid objects even if we collide with them
        self.y = self.y - 1
        local collidedObjects = self:checkObjectCollisions()
        self.y = self.y + 1

        -- reset X if new collided object
        if #collidedObjects > 0 then
            self.x = self.x + PLAYER_RUN_SPEED * dt
        end
    end
end

function Player:checkRightCollisions(dt)
    -- check for right two tiles collision
    local tileTopRight = self.map:pointToTile(self.x + self.width - 1, self.y + 1)
    local tileBottomRight = self.map:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if (tileTopRight and tileBottomRight) and (tileTopRight:collidable() or tileBottomRight:collidable()) then
        self.x = (tileTopRight.x - 1) * TILE_SIZE - self.width
        self.dx = 0
    else
        
        -- allow us to walk atop solid objects even if we collide with them
        self.y = self.y - 1
        local collidedObjects = self:checkObjectCollisions()
        self.y = self.y + 1

        -- reset X if new collided object
        if #collidedObjects > 0 then
            self.x = self.x - PLAYER_RUN_SPEED * dt
        end
    end
end

function Player:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.level.objects) do
        if object:collides(self) then
            if object.solid then
                table.insert(collidedObjects, object)
            elseif object.consumable then
                object.onConsume(self)
                table.remove(self.level.objects, k)
            end
        end
    end

    return collidedObjects
end

function Player:checkOnDoor()
    for k, object in pairs(self.level.objects) do
        if object:collides(self) then
            if object.class == "Door" then
                return true
            end
        end
    end 
    return false
end