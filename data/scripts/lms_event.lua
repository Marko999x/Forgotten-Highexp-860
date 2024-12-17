local topArenaGlobal = GlobalEvent("TopArenaEvent")

local config = {
    timeStart = "03:25:30",
    teleportPosition = Position(779, 664, 7),
    setDestinationTeleport = Position(668, 614, 7),
    teleportAid = 32104,
    minRebirth = 50,
    topArenaTable = {},
    topLeftCorner = Position(2005, 2012, 9),
    bottomRightCorner = Position(2039, 2045, 9),
}

function topArenaGlobal.onTime(interval)
    for _, player in ipairs(Game.getPlayers()) do
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'TOP Arena Event will start in 3min! Join the teleport in events room.')
        addEvent(function() player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'TOP Arena Event will start in 2min! Join the teleport in Events room.') end, 3000)
        addEvent(function() player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'TOP Arena Event will start in 1min! Join the teleport in Events room.') end, 4000)
        addEvent(function() player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'TOP Arena Event has started, good luck to everyone.') end, 5000)
    end
    local teleport = Game.createItem(1387, 1, config.teleportPosition)
    teleport:setDestination(config.setDestinationTeleport)
    teleport:setActionId(config.teleportAid)
    addEvent(function()
        local teleportItem = Tile(config.teleportPosition):getItemById(1387)
        if teleportItem then
            teleportItem:remove()
        end
    end, 6000)
    return true
end

topArenaGlobal:time(config.timeStart)
topArenaGlobal:register()
------------------------------------------------------------------------------------------------------------------------
local moveEvent = MoveEvent()

function moveEvent.onStepIn(creature, item, pos, fromPosition)
    if player:getReborn() < config.minRebirth then
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Only player above rebirth 50 can join top arena event.')
        return true
    end
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You joined the top arena event.')
    
    return true
end

moveEvent:aid(config.teleportAid)
moveEvent:register()

