local addRebornScript = TalkAction("/addreborn")
function addRebornScript.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    local split = param:splitTrimmed(",")
    local target = Player(split[1])
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    local amount = tonumber(split[2])
    if not amount or amount < 1 then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
    target:doReborn(amount, false)
    return false
end

addRebornScript:separator(" ")
addRebornScript:register()
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
local addLevelScript = TalkAction("/addlevel")
function addLevelScript.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    local split = param:splitTrimmed(",")
    local target = Player(split[1])
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    local amount = tonumber(split[2])
    if not amount or amount < 1 then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
    target:addLevel(amount)
    return false
end

addLevelScript:separator(" ")
addLevelScript:register()
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
local removeLevel = TalkAction("/removeexp")

function removeLevel.onSay(player, words, param)
	if player:getAccountType() == 6 then
		local targetPlayer = Player(param)
		if not targetPlayer then
			player:sendCancelMessage('player does not exists')
		return false
	end
	
	targetPlayer:removeExperience(100000)
	end
	return false
end

removeLevel:separator(" ")
removeLevel:register()
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
local addRebornScript = TalkAction("/removereborn")
function addRebornScript.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    local split = param:splitTrimmed(",")
    local target = Player(split[1])
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    local amount = tonumber(split[2])
    if not amount or amount < 1 then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
    target:doReborn(-amount, false)
    return false
end

addRebornScript:separator(" ")
addRebornScript:register()
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
local changeRebornScript = TalkAction("/changereborn")
function changeRebornScript.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    local split = param:splitTrimmed(",")
    local target = Player(split[1])
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    local amount = tonumber(split[2])
    if not amount or amount < 1 then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
    target:setReborn(player:getReborn() + amount)
    return false
end

changeRebornScript:separator(" ")
changeRebornScript:register()