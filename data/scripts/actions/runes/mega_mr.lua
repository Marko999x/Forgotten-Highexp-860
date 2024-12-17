local manarune = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 250)

function manarune.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(20000) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You can not heal while being freezed.')
		return true
	end
	
	local min = player:getMaxMana() / 100 * 3
	local max = player:getMaxMana() / 100 * 4
	
	local min = 50000000
	local max = 50000000
	
	local mana_add = math.random(min, max)
	
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
	player:addMana(mana_add)
	pos:sendMagicEffect(15)
	Game.sendAnimatedText(''..math.floor(mana_add)..'', pos, 107)
	--player:say('MANARUNE!', TALKTYPE_MONSTER_SAY)
    return true
end

manarune:id(2270)
manarune:allowFarUse(true)
manarune:register()