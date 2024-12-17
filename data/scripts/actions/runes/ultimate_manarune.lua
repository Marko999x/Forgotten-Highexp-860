local manarune = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 500)

function manarune.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(20000) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You can not heal while being freezed.')
		return true
	end
	
	local manamax = player:getMaxMana()
	local min = player:getMaxMana() / 100 * 10
	local max = player:getMaxMana() / 100 * 11
	--local mana_add = math.random((manamax * (min/100)), (manamax * (max/100)))
	
	local healmax = player:getMaxHealth()
	local min2 = player:getMaxHealth() / 100 * 10
	local max2 = player:getMaxHealth() / 100 * 11
	
	if min < 500000000 then
		min = 500000000
	end
	
	if max < 550000000 then
		max = 550000000
	end
	
	if min2 < 500000000 then
		min2 = 500000000
	end
	
	if max2 < 550000000 then
		max2 = 550000000
	end
	
	local mana_add = math.random(min, max)
	local heal_add = math.random(min2, max2)
	
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
	player:addHealth(heal_add)
	pos:sendMagicEffect(CONST_ME_HOLYAREA)
	local effect = 31
	Position(pos.x+2, pos.y+2, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x+2, pos.y-2, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x-2, pos.y-2, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x-2, pos.y+2, pos.z):sendDistanceEffect(pos, effect)
	Game.sendAnimatedText(''..math.floor(mana_add)..'', pos, 210)
	--player:say('MANARUNE!', TALKTYPE_MONSTER_SAY)
    return true
end

manarune:id(2297)
manarune:allowFarUse(true)
manarune:register()