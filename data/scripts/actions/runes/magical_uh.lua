local healrune = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 600)

function healrune.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(20000) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You can not heal while being freezed.')
		return true
	end
		
	local healmax = player:getMaxHealth()
	local min = player:getMaxHealth() / 100 * 40
	local max = player:getMaxHealth() / 100 * 40
	
	local heal_add = math.random(min, max)
	
    local targetPlayer = Player(target)
    if not targetPlayer then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You may only use this on players!")
        return true
    end
	
	local foundCondition = player:getCondition(CONDITION_EXHAUST_HEAL)
	if foundCondition and foundCondition:getEndTime() > os.mtime() then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, 'you are exhausted.')
		return true
	end

    local pos = targetPlayer:getPosition() 
	player:addCondition(exhaust)
	player:addHealth(heal_add)
	pos:sendMagicEffect(15)
	Game.sendAnimatedText(''..math.floor(heal_add)..'', pos, TEXTCOLOR_GREEN)
	--player:say('MANARUNE!', TALKTYPE_MONSTER_SAY)
    return true
end

healrune:id(2272)
healrune:allowFarUse(true)
healrune:register()