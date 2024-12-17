function onSay(cid, words, param)
    local player = Player(cid)
    if not player:getGroup():getAccess() then
        return true
    end

    local params = param:split(',')
    if not params[2] then
        player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('example: !check vipdays,name', words))
        return false
    end

    local targetName = params[2]:trim()
    local target = Player(targetName)
    if not target then
        player:sendCancelMessage(string.format('example: !check vipdays,name', targetName, words))
        return false
    end

    local action = params[1]:trim():lower()
    if action == 'vipdays' then
        local days = target:getVipDays()
        --player:sendCancelMessage('%s has %s vip day(s).', target:getName(), (days == 0xFFFF and 'infinite' or days)))
		player:popupFYI(''..target:getName()..' has '..target:getVipDays()..' vip days')
		return false
	end
end