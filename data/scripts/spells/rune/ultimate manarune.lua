local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, 500)

local rune = Spell(SPELL_RUNE)

function rune.onCastSpell(creature, variant, isHotkey)
	if creature:getStorageValue(20000) == 1 then
		creature:sendTextMessage(MESSAGE_INFO_DESCR, 'You can not heal while being freezed.')
		return true
	end
	
	local manamax = creature:getMaxMana()
	local min = creature:getMaxMana() / 100 * 10
	local max = creature:getMaxMana() / 100 * 11
	--local mana_add = math.random((manamax * (min/100)), (manamax * (max/100)))
	
	local healmax = creature:getMaxHealth()
	local min2 = creature:getMaxHealth() / 100 * 10
	local max2 = creature:getMaxHealth() / 100 * 11
	
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
	
    if not variant then
        creature:sendTextMessage(MESSAGE_INFO_DESCR, "You may only use this on creatures!")
        return true
    end
	
	local foundCondition = creature:getCondition(CONDITION_EXHAUST_HEAL)
	if foundCondition and foundCondition:getEndTime() > os.mtime() then
		creature:sendTextMessage(MESSAGE_STATUS_SMALL, 'you are exhausted.')
		return false
	end

    local pos = variant:getPosition() 
	creature:addCondition(exhaust)
	creature:addMana(mana_add)
	creature:addHealth(heal_add)
	pos:sendMagicEffect(CONST_ME_HOLYAREA)
	local effect = 31
	Position(pos.x+2, pos.y+2, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x+2, pos.y-2, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x-2, pos.y-2, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x-2, pos.y+2, pos.z):sendDistanceEffect(pos, effect)
	Game.sendAnimatedText(''..math.floor(mana_add)..'', pos, 210)
	combat:execute(creature, variant)
end

rune:name("Ultimate Manarune")
rune:group("healing")
rune:runeId(2297)
rune:id(3)
rune:cooldown(1000)
rune:groupCooldown(1000)
rune:level(1)
rune:magicLevel(1)
rune:vocation()
rune:allowFarUse(true)
rune:isAggressive(false)
--rune:register()
