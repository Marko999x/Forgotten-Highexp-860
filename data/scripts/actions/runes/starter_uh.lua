local manarune = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 250)

function manarune.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local min = 2000000
	local max = 2000000
	--local min = (player:getMaxMana() / 100) * 10
	--local max = (player:getMaxMana() / 100) * 12
	
	--if min < 100000 then
	--	min = 150000
	--end
	
	--if max < 200000 then
	--	max = 250000
	--end
	
	local heal_add = math.random(min, max)
	
    local targetPlayer = Player(target)
    if not targetPlayer then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You may only use this on players!")
        return true
    end
	
	local foundCondition = player:getCondition(CONDITION_EXHAUST_HEAL)
	if foundCondition and foundCondition:getEndTime() > os.mtime() then
		--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'you are exhausted.')
		return true
	end

    local pos = player:getPosition() 
	player:addCondition(exhaust)
	player:addHealth(heal_add)
	--pos:sendMagicEffect(CONST_ME_HOLYAREA)
	pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	Game.sendAnimatedText(""..math.floor(heal_add).. "", pos, TEXTCOLOR_GREEN)
	player:say('HEALRUNE', TALKTYPE_MONSTER_SAY)
	--player:sendTextMessage(MESSAGE_EVENT_DEFAULT, 'You have healed '..math.floor(heal_add)..' mana.')
    return true
end

manarune:id(2272)
manarune:allowFarUse(true)
manarune:register()
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------