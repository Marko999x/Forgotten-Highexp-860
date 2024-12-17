function comparePosition(pos1, pos2)
    return (pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z) and true or false
end

local position = false
function onSay(cid, words, param)
    local player = Player(cid)
     if not player:getGroup():getAccess() then
      return true
     end

     if player:getAccountType() < ACCOUNT_TYPE_GOD then
      return false
     end

    local lookPosition = player:getPosition()
    lookPosition:getNextPosition(player:getDirection())

    local pos,c = lookPosition,position

        if param == "clear" then
            position = false
            return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Clear.")
        elseif param then
            if tonumber(param) then
                local tp = Game.createItem(1387, 1, pos)
                tp:setActionId(tonumber(param))
                position = false
                return true
            end
        end

        if not(position) or not(comparePosition(position,pos)) then
            if position == false then
                position = pos
                return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("The teleporter's position was set. [X: %i, Y: %i, Z: %i]",pos.x, pos.y, pos.z)) and lookPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
            end

            position = false
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("The teleporter was set up. From:[X: %i, Y: %i, Z: %i] To:[X: %i, Y: %i, Z: %i]",c.x, c.y, c.z, pos.x, pos.y, pos.z))
            lookPosition:sendMagicEffect(CONST_ME_MAGIC_RED)

            local tp = Game.createItem(1387, 1,c)
            tp:setDestination(pos)
        end
        return player:sendCancelMessage("The teleport position can't be the position where the teleporter is.") and player:getPosition():sendMagicEffect(CONST_ME_POFF)
end