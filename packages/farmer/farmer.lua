Crop = { name = "beetroots", harvestAge = 3 }
Farmer = { name = "Farmer", crop = Crop }

function Farmer:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Farmer:init(self)
    local isOriented = self.assertOrientation()

    if not isOriented then
        print("Failed to orient.")
    end

    return isOriented
end

function Farmer:assertOrientation(self)
    local didInspect, block = turtle.inspect()
    local didInspectUp, blockUp = turtle.inspectUp()
    local didInspectDown, blockDown = turtle.inspectDown()

    if didInspect and not didInspectUp and block.name == "minecraft:farmland" then
        -- Looking forward at farmland means we should be in water
        return turtle.up() and turtle.up() and self:assertOrientation()
    elseif not didInspectDown or blockDown.name == ("minecraft:" .. self.crop.name) then
        -- TODO: any crop, not specific
        return true
    end

    return false
end

function Farmer:startHarvest(self)
    if self:canHarvest() then
        self:harvest()
    else
        self:findNext()
    end

    return self:startHarvest()
end

function Farmer:harvest(self)
    return turtle.digDown() and turtle.suckDown() and turtle.placeDown()
end

function Farmer:findNext(self)
    for i = 1, 4 do
        if self:canHarvest(self) then
            return true
        end

        turtle.turnRight()
    end

    for i = 1, 4 do
        if self:canMove() then
            turtle.forward()
            turtle.suckDown()
            self:assertPlanted()
            return self:findNext()
        end

        turtle.turnRight()
    end

    return self:findNext()
end

function Farmer:canHarvest(self)
    local didInspect, block = turtle.inspectDown()

    return didInspect and block.name == ("minecraft:" .. self.crop.name) and block.state.age == self.crop.harvestAge
end

function Farmer:canMove(self)
    return turtle.inspect() == false
end

function Farmer:assertPlanted(self)
    local didInspect, block = turtle.inspectDown()

    return not didInspect and turtle.placeDown()
end

function main()
    local farmer = Farmer:new()

    return farmer:init() and farmer:startHarvest()
end

main()
