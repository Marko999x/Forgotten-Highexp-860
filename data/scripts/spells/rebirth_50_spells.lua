local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = 42,
	secondEffect = 40,
	thirdEffect = 40,
	
	firstDistanceEffect = 37,
	secondDistanceEffect = 0,
	thirdDistanceEffect = 0,
	
	firstMinDmg = 20000000,
	firstMaxDmg = 22000000,
	secondMinDmg = 20000000,
	secondMaxDmg = 22000000,
	thirdMinDmg = 20000000,
	thirdMaxDmg = 22000000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 2, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0}
}

local areaTwo = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 0, 1, 1, 1},
{1, 1, 0, 2, 0, 1, 1},
{1, 1, 1, 0, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0}
}

local areaThree = {
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 2, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 0, 0, 0}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1000000) 
	local max = config.firstMaxDmg + (reborn * 1100000) 
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1000000) 
	local max = config.firstMaxDmg + (reborn * 1100000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1000000)
	local max = config.firstMaxDmg + (reborn * 1100000)
	return -min, -max
end

local magicareaOne  = createCombatArea(areaOne)
local magicareaTwo  = createCombatArea(areaTwo)
local magicareaThree = createCombatArea(areaThree)

local combatOne = Combat()
local combatTwo = Combat()
local combatThree = Combat()

combatOne:setArea(magicareaOne)
combatTwo:setArea(magicareaTwo)
combatThree:setArea(magicareaThree)

combatOne:setParameter(COMBAT_PARAM_TYPE, config.firstType)
combatTwo:setParameter(COMBAT_PARAM_TYPE, config.secondType)
combatThree:setParameter(COMBAT_PARAM_TYPE, config.thirdType)

combatOne:setParameter(COMBAT_PARAM_EFFECT, config.firstEffect)
combatTwo:setParameter(COMBAT_PARAM_EFFECT, config.secondEffect)
combatThree:setParameter(COMBAT_PARAM_EFFECT, config.thirdEffect)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.firstDistanceEffect)
end

--function onTargetTile1(creature, position)
 --   creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
--end

--function onTargetTile2(creature, position)
 --   creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
--end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
--combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
--combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

local function firstCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatOne:execute(player, target)
end

local function secondCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatTwo:execute(player, target)
end

local function thridCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatThree:execute(player, target)
end

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(player, target)
	addEvent(thridCombat, 100, player:getId(), target)
	addEvent(secondCombat, 200, player:getId(), target)
	addEvent(firstCombat, 300, player:getId(), target)
	addEvent(thridCombat, 400, player:getId(), target)
	addEvent(secondCombat, 500, player:getId(), target)
	addEvent(firstCombat, 600, player:getId(), target)
	addEvent(thridCombat, 700, player:getId(), target)
	addEvent(secondCombat, 800, player:getId(), target)
	addEvent(firstCombat, 900, player:getId(), target)
    return true
end

spell:name("exevo hell attacks")
spell:words("exevo hell attacks")
spell:group("attack")
spell:isSelfTarget(false)
spell:vocation("mixed master sorcerer", "mixed elder druid", "spin master sorcerer", "spin elder druid", "epic master sorcerer", "epic elder druid", "nova master sorcerer", "nova elder druid", "hellborn master sorcerer", "hellborn elder druid")
spell:id(1)
spell:cooldown(1000)
spell:reborn(50)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
----------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = 49,
	secondEffect = 40,
	thirdEffect = 40,
	
	firstDistanceEffect = 9,
	secondDistanceEffect = 0,
	thirdDistanceEffect = 0,
	
	firstMinDmg = 24000000,
	firstMaxDmg = 26000000,
	secondMinDmg = 24000000,
	secondMaxDmg = 26000000,
	thirdMinDmg = 24000000,
	thirdMaxDmg = 26000000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 2, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0}
}

local areaTwo = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 0, 1, 1, 1},
{1, 1, 0, 2, 0, 1, 1},
{1, 1, 1, 0, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0}
}

local areaThree = {
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 2, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 0, 0, 0}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1200000) 
	local max = config.firstMaxDmg + (reborn * 1300000) 
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1200000) 
	local max = config.firstMaxDmg + (reborn * 1300000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1200000)
	local max = config.firstMaxDmg + (reborn * 1300000)
	return -min, -max
end

local magicareaOne  = createCombatArea(areaOne)
local magicareaTwo  = createCombatArea(areaTwo)
local magicareaThree = createCombatArea(areaThree)

local combatOne = Combat()
local combatTwo = Combat()
local combatThree = Combat()

combatOne:setArea(magicareaOne)
combatTwo:setArea(magicareaTwo)
combatThree:setArea(magicareaThree)

combatOne:setParameter(COMBAT_PARAM_TYPE, config.firstType)
combatTwo:setParameter(COMBAT_PARAM_TYPE, config.secondType)
combatThree:setParameter(COMBAT_PARAM_TYPE, config.thirdType)

combatOne:setParameter(COMBAT_PARAM_EFFECT, config.firstEffect)
combatTwo:setParameter(COMBAT_PARAM_EFFECT, config.secondEffect)
combatThree:setParameter(COMBAT_PARAM_EFFECT, config.thirdEffect)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.firstDistanceEffect)
end

--function onTargetTile1(creature, position)
 --   creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
--end

--function onTargetTile2(creature, position)
 --   creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
--end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
----combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
--combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

local function firstCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatOne:execute(player, target)
end

local function secondCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatTwo:execute(player, target)
end

local function thridCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatThree:execute(player, target)
end

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(player, target)
	addEvent(thridCombat, 100, player:getId(), target)
	addEvent(secondCombat, 200, player:getId(), target)
	addEvent(firstCombat, 300, player:getId(), target)
	addEvent(thridCombat, 400, player:getId(), target)
	addEvent(secondCombat, 500, player:getId(), target)
	addEvent(firstCombat, 600, player:getId(), target)
	addEvent(thridCombat, 700, player:getId(), target)
	addEvent(secondCombat, 800, player:getId(), target)
	addEvent(firstCombat, 900, player:getId(), target)
    return true
end

spell:name("pally attacks")
spell:words("exevo pally attacks")
spell:group("attack")
spell:isSelfTarget(false)
spell:vocation("mixed royal paladin", "spin royal paladin", "epic royal paladin", "nova royal paladin", "hellborn royal paladin")
spell:id(1)
spell:cooldown(1000)
spell:reborn(50)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_FIREDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = CONST_ME_HITBYFIRE,
	secondEffect = 40,
	thirdEffect = 40,
	
	firstDistanceEffect = CONST_ANI_FIRE,
	secondDistanceEffect = 0,
	thirdDistanceEffect = 0,
	
	firstMinDmg = 16000000,
	firstMaxDmg = 18000000,
	secondMinDmg = 16000000,
	secondMaxDmg = 18000000,
	thirdMinDmg = 16000000,
	thirdMaxDmg = 18000000,
	
	magicLevel = 25
}

local areaOne = {
	{0, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 2, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0}
}

local areaTwo = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 0, 1, 1, 1},
{1, 1, 0, 2, 0, 1, 1},
{1, 1, 1, 0, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0}
}

local areaThree = {
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 2, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 0, 0, 0}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 800000) 
	local max = config.firstMaxDmg + (reborn * 900000) 
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 800000) 
	local max = config.firstMaxDmg + (reborn * 900000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 800000)
	local max = config.firstMaxDmg + (reborn * 900000)
	return -min, -max
end

local magicareaOne  = createCombatArea(areaOne)
local magicareaTwo  = createCombatArea(areaTwo)
local magicareaThree = createCombatArea(areaThree)

local combatOne = Combat()
local combatTwo = Combat()
local combatThree = Combat()

combatOne:setArea(magicareaOne)
combatTwo:setArea(magicareaTwo)
combatThree:setArea(magicareaThree)

combatOne:setParameter(COMBAT_PARAM_TYPE, config.firstType)
combatTwo:setParameter(COMBAT_PARAM_TYPE, config.secondType)
combatThree:setParameter(COMBAT_PARAM_TYPE, config.thirdType)

combatOne:setParameter(COMBAT_PARAM_EFFECT, config.firstEffect)
combatTwo:setParameter(COMBAT_PARAM_EFFECT, config.secondEffect)
combatThree:setParameter(COMBAT_PARAM_EFFECT, config.thirdEffect)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.firstDistanceEffect)
end

--function onTargetTile1(creature, position)
 --   creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
--end

--function onTargetTile2(creature, position)
 --   creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
--end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
--combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
----combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

local function firstCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatOne:execute(player, target)
end

local function secondCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatTwo:execute(player, target)
end

local function thridCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatThree:execute(player, target)
end

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(player, target)
	addEvent(firstCombat, 100, player:getId(), target)
	addEvent(firstCombat, 200, player:getId(), target)
	addEvent(firstCombat, 300, player:getId(), target)
    return true
end

spell:name("knight star")
spell:words("knight star")
spell:group("attack")
spell:isSelfTarget(false)
spell:vocation("mixed elite knight", "spin elite knight", "epic elite knight", "nova elite knight", "hellborn elite knight")
spell:id(1)
spell:cooldown(1000)
spell:reborn(50)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------