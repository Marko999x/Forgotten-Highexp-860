local action = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 1000)

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local min = 999999999
	local max = 999999999
	local mana_add = math.random(min, max)

	local foundCondition = player:getCondition(CONDITION_EXHAUST_HEAL)
	if foundCondition and foundCondition:getEndTime() > os.mtime() then
		--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'you are exhausted.')
		return true
	end
	
	player:addCondition(exhaust)
	player:addHealth(mana_add)
	player:getPosition():sendMagicEffect(math.random(1, 70))
	fromPosition:sendDistanceEffect(player:getPosition(), math.random(1, 42))
	Game.sendAnimatedText('+'..mana_add..'', player:getPosition(), TEXTCOLOR_GREEN)
    return true
end

action:aid(5300)
action:register()



local action = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 1000)

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local min = 999999999
	local max = 999999999
	local mana_add = math.random(min, max)

	local foundCondition = player:getCondition(CONDITION_EXHAUST_HEAL)
	if foundCondition and foundCondition:getEndTime() > os.mtime() then
		--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'you are exhausted.')
		return true
	end
	
	player:addCondition(exhaust)
	player:addMana(mana_add)
	player:getPosition():sendMagicEffect(math.random(1, 70))
	fromPosition:sendDistanceEffect(player:getPosition(), math.random(1, 42))
	Game.sendAnimatedText('+'..mana_add..'', player:getPosition(), 112)
    return true
end

action:aid(5301)
action:register()