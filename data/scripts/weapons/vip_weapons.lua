local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 38)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 36)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 65000000
	local max = 75000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_WAND)

weapon.onUseWeapon = function(player, variant)
    combat:execute(player, variant)
	return true
end

weapon:id(7958)
weapon:vocation("sorcerer", true, true)
weapon:vocation("druid", true, true)
weapon:vocation("master sorcerer", false, false)
weapon:vocation("elder druid", false, false)
weapon:vocation("mixed master sorcerer", false, false)
weapon:vocation("mixed elder druid", false, false)
weapon:vocation("spin master sorcerer", false, false)
weapon:vocation("spin elder druid", false, false)
weapon:vocation("epic master sorcerer", false, false)
weapon:vocation("epic elder druid", false, false)
weapon:vocation("nova master sorcerer", false, false)
weapon:vocation("nova elder druid", false, false)
weapon:vocation("hellborn master sorcerer", false, false)
weapon:vocation("hellborn elder druid", false, false)
weapon:register()
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 31)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 17)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 75000000
	local max = 85000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_DISTANCE)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(3965)
weapon:vocation("paladin", true, true)
weapon:vocation("royal paladin", false, false)
weapon:vocation("mixed royal paladin", false, false)
weapon:vocation("spin royal paladin", false, false)
weapon:vocation("epic royal paladin", false, false)
weapon:vocation("nova royal paladin", false, false)
weapon:vocation("hellborn royal paladin", false, false)
weapon:register()
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 0)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 110000000
	local max = 120000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_SWORD)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(8931)
--weapon:vocation("knight", true, true)
--weapon:vocation("elite knight", false, false)
--weapon:vocation("mixed elite knight", false, false)
--weapon:vocation("spin elite knight", false, false)
--weapon:vocation("epic elite knight", false, false)
--weapon:vocation("nova elite knight", false, false)
--weapon:vocation("hellborn elite knight", false, false)
weapon:register()
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 0)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 110000000
	local max = 120000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_AXE)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(8925)
weapon:register()