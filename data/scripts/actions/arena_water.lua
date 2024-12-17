local action = Action()

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 200)

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local amount = 999999999999

	local foundCondition = player:getCondition(CONDITION_EXHAUST_HEAL)
	if foundCondition and foundCondition:getEndTime() > os.mtime() then
		--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'you are exhausted.')
		return true
	end
	
	player:addHealth(amount)
	player:addMana(amount)
	fromPosition:sendMagicEffect(2)
	player:say('Ahhh..Mana..Ahhhhhhhhh', TALKTYPE_MONSTER_SAY)
	--Game.sendAnimatedText('+'..mana_add..'', player:getPosition(), TEXTCOLOR_GREEN)
    return true
end

action:aid(5302)
action:register()