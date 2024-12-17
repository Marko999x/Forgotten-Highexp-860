local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_MANASHIELD)
condition:setParameter(CONDITION_PARAM_TICKS, -1)

function onCastSpell(creature, variant)
combat:execute(creature, variant)
	if creature:hasCondition(CONDITION_MANASHIELD) == false then
		creature:addCondition(condition)
		creature:say("Magic Shield On!.", TALKTYPE_MONSTER_SAY)
	else
		creature:removeCondition(CONDITION_MANASHIELD)
		creature:say("Magic Shield Off!.", TALKTYPE_MONSTER_SAY)
	end
	return true
end