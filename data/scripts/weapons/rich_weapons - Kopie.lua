local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 40)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 31)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 40000000
	local max = 50000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_WAND)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(12318)
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
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 40)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 28)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 50000000
	local max = 60000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_DISTANCE)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(7367)
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
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 40)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 25)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 6000000000
	local max = 7000000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_SWORD)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(12649)
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
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 7)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 26)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 6000000000
	local max = 7000000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_AXE)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(8926)
weapon:register()