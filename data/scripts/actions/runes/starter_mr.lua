local manarune = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 250)

function manarune.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local min = 1000000
	local max = 1000000
	--local min = (player:getMaxMana() / 100) * 4
	--local max = (player:getMaxMana() / 100) * 6
	
	--if min < 100000 then
	--	min = 150000
	--end
	
	--if max < 200000 then
	--	max = 250000
	--end
	
	local mana_add = math.random(min, max)
	
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
	player:addMana(mana_add)
	--pos:sendMagicEffect(CONST_ME_HOLYAREA)
	pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	Game.sendAnimatedText(""..math.floor(mana_add).. "", pos, 112)
	player:say('MANARUNE', TALKTYPE_MONSTER_SAY)
	--player:sendTextMessage(MESSAGE_EVENT_DEFAULT, 'You have healed '..math.floor(mana_add)..' mana.')
    return true
end

manarune:id(2276)
manarune:allowFarUse(true)
manarune:register()
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------