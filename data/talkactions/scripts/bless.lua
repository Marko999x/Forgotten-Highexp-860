function addAllBlesses(cid)
    local player = Player(cid)
    for i = 1, 5 do
        player:addBlessing(i)
    end
end

function onSay(player, words, param)
   
    local totalBlessPrice = 100000
	
	for i = 1, 5 do
	if player:hasBlessing(i) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are alredy blessed!")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	end
    if player:removeMoney(totalBlessPrice) then
        addAllBlesses(player)      
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by all of five gods!")
    else
        if player:withdrawMoney(totalBlessPrice) then
            if player:removeMoney(totalBlessPrice) then
                addAllBlesses(player)
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by all of five gods!")
            else
                player:sendCancelMessage("You don't have enough money. You need " .. totalBlessPrice .. " to buy bless.", cid)
            end
        else
            player:sendCancelMessage("You don't have enough money. Not even in your bank account! You need " .. totalBlessPrice .. " to buy bless.", cid)
        end
    end
end