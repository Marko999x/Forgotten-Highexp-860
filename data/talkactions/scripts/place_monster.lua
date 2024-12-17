function onSay(player, words, param)
    --if not player:getGroup():getAccess() then
     --   return true
    --end

    if player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
        return false
    end
    local t = string.split(param, ",")
    if not t[1] then
            player:sendCancelMessage("Not valid monster name." )
     end
    local mobscount = tonumber(t[2])
    if mobscount == nil then
        mobscount = 1
    end
    local found = nil
    for i = 0,mobscount do
        if mobscount == i then
               break
        end
        local position = player:getPosition()
        local randX, randY, randZ
        local rangeFrom = player:getPosition()
        local rangeTo = player:getPosition()
           rangeTo.x = rangeFrom.x+2
           rangeTo.y=rangeFrom.y+2
           rangeFrom.x = rangeFrom.x - 2
           rangeFrom.y = rangeFrom.y - 2
        randX = math.random(rangeFrom.x, rangeTo.x)
        randY = math.random(rangeFrom.y, rangeTo.y)
           randZ = math.random(rangeFrom.z, rangeTo.z)
        local summonplace = Position(randX, randY, randZ)
        local monster = Game.createMonster(t[1], summonplace)
    end
        if monster ~= nil then
        local position = player:getPosition()
            summonplace:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            position:sendMagicEffect(CONST_ME_MAGIC_RED)
        else
            player:sendCancelMessage("There is not enough room.")
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    return false
end