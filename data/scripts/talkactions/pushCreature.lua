local talkAction = TalkAction("!push")

function talkAction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    local targetPosition = player:getPosition()
    targetPosition:getNextPosition(player:getDirection())

    local tile = Tile(targetPosition)
    if not tile then
        return false
    end

    local creature = tile:getTopCreature()
    if not creature then
        player:sendCancelMessage("There's no one in front of you.")
        return false
    end

    local dirOffset = Position.directionOffset[player:getDirection()]

    local finalPosition = findNextFreePosition(targetPosition, Position(
        targetPosition.x + (dirOffset.x * 3),
        targetPosition.y + (dirOffset.y * 3),
        targetPosition.z
    ))

    if not finalPosition then
        player:sendCancelMessage("Cannot kick player")
        position:sendMagicEffect(3)
        return
    end

    creature:teleportTo(finalPosition)
    print(4)
    player:getPosition():sendDistanceEffect(finalPosition, 12)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    return false
end

function findNextFreePosition(fromPosition, toPosition)
    local toTile = Tile(toPosition)

    if toTile and not toTile:getHouse() and toTile:isWalkable() then
        return toTile:getPosition()
    end

    local xSteps = ((fromPosition.x < toPosition.x and -1) or 1)
    local ySteps = ((fromPosition.y < toPosition.y and -1) or 1)

    for x = toPosition.x, fromPosition.x, xSteps do
        for y = toPosition.y, fromPosition.y, ySteps do
            local possibleTile = Tile(x, y, fromPosition.z)
            if possibleTile and possibleTile:isWalkable() then
                return possibleTile:getPosition()
            end
        end
    end

    return nil
end

--talkAction:accountType(ACCOUNT_TYPE_GOD)
--talkAction:access(true)
--talkAction:separator(" ")
talkAction:register()
