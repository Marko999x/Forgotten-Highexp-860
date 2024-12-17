local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 42)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 29)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 30000000
	local max = 35000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_WAND)

weapon.onUseWeapon = function(player, variant)
    combat:execute(player, variant)
	return true
end

weapon:id(7410)
weapon:vocation("druid", true, true)
weapon:vocation("elder druid", false, false)
weapon:vocation("mixed elder druid", false, false)
weapon:vocation("spin elder druid", false, false)
weapon:vocation("epic elder druid", false, false)
weapon:vocation("nova elder druid", false, false)
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
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 31)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 30000000
	local max = 35000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_WAND)

weapon.onUseWeapon = function(player, variant)
    combat:execute(player, variant)
	return true
end

weapon:id(7735)
weapon:vocation("sorcerer", true, true)
weapon:vocation("master sorcerer", false, false)
weapon:vocation("mixed master sorcerer", false, false)
weapon:vocation("spin master sorcerer", false, false)
weapon:vocation("epic master sorcerer", false, false)
weapon:vocation("nova master sorcerer", false, false)
weapon:vocation("hellborn master sorcerer", false, false)
weapon:register()
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})

local combat = Combat()
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 44)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 35)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 35000000
	local max = 40000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_DISTANCE)

local crystalBow = {}

weapon.onUseWeapon = function(player, variant)
	local playerGuid = player:getGuid()
	local timeAmount = crystalBow[playerGuid] -- exhaustTable name must be changed always to the current name you use for the table
	if timeAmount and timeAmount > os.time() then
		--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must wait " .. (timeAmount - os.time()) .. " seconds.")
		return true
	end
	local arrow = player:getSlotItem(CONST_SLOT_AMMO)
	if arrow and arrow.itemid == 2352 then
   		combat:execute(player, variant)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'This bow just works in combo with shiver arrow.')
		crystalBow[playerGuid] = os.time() + 5
	end
end

weapon:id(8858)
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
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 1)
--combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WHIRLWINDSWORD)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = 40000000
	local max = 45000000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local weapon = Weapon(WEAPON_AXE)

weapon.onUseWeapon = function(player, variant)
    return combat:execute(player, variant)
end

weapon:id(7407)
weapon:vocation("knight", true, true)
weapon:vocation("elite knight", false, false)
weapon:vocation("mixed elite knight", false, false)
weapon:vocation("spin elite knight", false, false)
weapon:vocation("epic elite knight", false, false)
weapon:vocation("nova elite knight", false, false)
weapon:vocation("hellborn elite knight", false, false)
weapon:register()