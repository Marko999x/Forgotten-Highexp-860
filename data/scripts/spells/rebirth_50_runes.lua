local arr = {
{0, 1, 1, 1, 0},
{1, 0, 1, 0, 1},
{1, 1, 3, 1, 1},
{1, 0, 1, 0, 1},
{0, 1, 1, 1, 0}
}


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1506)

function onGetFormulaValues(player, level, magicLevel)
	local minDmg = 30000000
	local maxDmg = 34000000
	local min = player:getMaxMana() / 100 * 30
	local max = player:getMaxMana() / 100 * 35
	return -min, -max
end

local area  = createCombatArea(arr)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, 5)
end

combat:setArea(area)
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell(SPELL_RUNE)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:name("Extreme Snake Rune")
spell:group("attack")
spell:runeId(2312)
spell:id(155)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:charges(1)
spell:magicLevel(1)
spell:isAggressive(true)
spell:allowFarUse(true)
spell:range(7)
spell:vocation("sorcerer", "master sorcerer", "mixed master sorcerer", "spin master sorcerer", "epic master sorcerer", "nova master sorcerer", "hellborn master sorcerer")
spell:register()

-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
local arr = {
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 3, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0}
}


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 43)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 8965)

function onGetFormulaValues(player, level, magicLevel)
	local minDmg = 26000000
	local maxDmg = 30000000
	local min = player:getMaxMana() / 100 * 27
	local max = player:getMaxMana() / 100 * 32
	return -min, -max
end

local area  = createCombatArea(arr)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, 37)
end

combat:setArea(area)
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell(SPELL_RUNE)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:name("Extreme Ice Rune")
spell:group("attack")
spell:runeId(2282)
spell:id(43)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:charges(1)
spell:magicLevel(1)
spell:isAggressive(true)
spell:allowFarUse(true)
spell:range(7)
spell:vocation("druid", "elder druid", "mixed elder druid", "spin elder druid", "epic elder druid", "nova elder druid", "hellborn elder druid")
spell:register()
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
local arr = {
{0, 1, 1, 1, 0},
{1, 0, 1, 0, 1},
{1, 1, 3, 1, 1},
{1, 0, 1, 0, 1},
{0, 1, 1, 1, 0}
}


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLY_DAMAGE)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_CREATEITEM, 1500)

function onGetFormulaValues(player, level, magicLevel)
	local minDmg = 34000000
	local maxDmg = 38000000
	local min = player:getMaxMana() / 100 * 60
	local max = player:getMaxMana() / 100 * 65
	return -min, -max
end

local area  = createCombatArea(arr)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, CONST_ANI_SMALLHOLY)
end

combat:setArea(area)
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell(SPELL_RUNE)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:name("Extreme Holy Rune")
spell:group("attack")
spell:runeId(2298)
spell:id(122)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:charges(1)
spell:magicLevel(1)
spell:isAggressive(true)
spell:allowFarUse(true)
spell:range(7)
spell:vocation("paladin", "royal paladin", "mixed royal paladin", "spin royal paladin", "epic royal paladin", "nova royal paladin", "hellborn royal paladin")
spell:register()
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
local arr = {
{0, 1, 1, 1, 0},
{1, 0, 0, 0, 1},
{1, 0, 3, 0, 1},
{1, 0, 0, 0, 1},
{0, 1, 1, 1, 0}
}


local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
--combat:setParameter(COMBAT_PARAM_CREATEITEM, 1500)

function onGetFormulaValues(player, level, magicLevel)
	local minDmg = 26000000
	local maxDmg = 30000000
	local min = player:getMaxHealth() / 100 * 34
	local max = player:getMaxHealth() / 100 * 38
	return -min, -max
end

local area  = createCombatArea(arr)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, 12)
end

combat:setArea(area)
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell(SPELL_RUNE)

function spell.onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

spell:name("Exreme Rock Rune")
spell:group("attack")
spell:runeId(2302)
spell:id(24)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:charges(1)
spell:magicLevel(1)
spell:isAggressive(true)
spell:allowFarUse(true)
spell:range(7)
spell:vocation("knight", "elite knight", "mixed elite knight", "spin elite knight", "epic elite knight", "nova elite knight", "hellborn elite knight")
spell:register()
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
