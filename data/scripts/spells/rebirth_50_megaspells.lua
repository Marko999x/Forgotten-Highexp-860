local config = {

	firstType = COMBAT_ENERGYDAMAGE,
	secondType = COMBAT_ENERGYDAMAGE,
	thirdType = COMBAT_ENERGYDAMAGE,

	firstEffect = 38,
	secondEffect = 38,
	thirdEffect = 38,
	
	firstDistanceEffect = 36,
	secondDistanceEffect = 36,
	thirdDistanceEffect = 36,
	
	firstMinDmg = 8000000,
	firstMaxDmg = 10000000,
	secondMinDmg = 8000000,
	secondMaxDmg = 10000000,
	thirdMinDmg = 8000000,
	thirdMaxDmg = 10000000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaTwo = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaThree = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = player:getMaxMana() / 100 * 8
	local max = player:getMaxMana() / 100 * 9
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7) 
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7)
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
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

function onTargetTile1(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
end

function onTargetTile2(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

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
	addEvent(firstCombat, 1, player:getId(), target)
    addEvent(firstCombat, 200, player:getId(), target)
    addEvent(firstCombat, 400, player:getId(), target)
    return true
end

spell:name("mega vis")
spell:words("mega vis")
spell:group("attack")
spell:needLearn(true)
spell:needCasterTargetOrDirection(true)
--spell:isSelfTarget(false)
spell:needDirection(true)
spell:vocation("sorcerer", "master sorcerer", "mixed master sorcerer", "spin master sorcerer", "epic master sorcerer", "nova master sorcerer", "hellborn master sorcerer")
spell:id(23)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:manaPercent(1)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_ICEDAMAGE,
	secondType = COMBAT_ICEDAMAGE,
	thirdType = COMBAT_ICEDAMAGE,

	firstEffect = 44,
	secondEffect = 44,
	thirdEffect = 44,
	
	firstDistanceEffect = 37,
	secondDistanceEffect = 37,
	thirdDistanceEffect = 37,
	
	firstMinDmg = 8000000,
	firstMaxDmg = 10000000,
	secondMinDmg = 8000000,
	secondMaxDmg = 10000000,
	thirdMinDmg = 8000000,
	thirdMaxDmg = 10000000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaTwo = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaThree = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = player:getMaxMana() / 100 * 7
	local max = player:getMaxMana() / 100 * 8
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7) 
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7)
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
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

function onTargetTile1(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
end

function onTargetTile2(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

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
	addEvent(firstCombat, 1, player:getId(), target)
    addEvent(firstCombat, 200, player:getId(), target)
    addEvent(firstCombat, 400, player:getId(), target)
    return true
end

spell:name("mega frigo")
spell:words("mega frigo")
spell:group("attack")
spell:needLearn(true)
spell:needCasterTargetOrDirection(true)
--spell:isSelfTarget(false)
spell:needDirection(true)
spell:vocation("druid", "elder druid", "mixed elder druid", "spin elder druid", "epic elder druid", "nova elder druid", "hellborn elder druid")
spell:id(112)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:manaPercent(1)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = 50,
	secondEffect = 50,
	thirdEffect = 50,
	
	firstDistanceEffect = 31,
	secondDistanceEffect = 31,
	thirdDistanceEffect = 31,
	
	firstMinDmg = 10000000,
	firstMaxDmg = 12000000,
	secondMinDmg = 10000000,
	secondMaxDmg = 12000000,
	thirdMinDmg = 10000000,
	thirdMaxDmg = 12000000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaTwo = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaThree = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = player:getMaxMana() / 100 * 16
	local max = player:getMaxMana() / 100 * 17
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7) 
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7)
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
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

function onTargetTile1(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
end

function onTargetTile2(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

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
	addEvent(firstCombat, 1, player:getId(), target)
    addEvent(firstCombat, 200, player:getId(), target)
    addEvent(firstCombat, 400, player:getId(), target)
    return true
end

spell:name("mega holy")
spell:words("mega holy")
spell:group("attack")
spell:needLearn(true)
spell:needCasterTargetOrDirection(true)
--spell:isSelfTarget(false)
spell:needDirection(true)
spell:vocation("paladin", "royal paladin", "mixed royal paladin", "spin royal paladin", "epic royal paladin", "nova royal paladin", "hellborn royal paladin")
spell:id(124)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:manaPercent(1)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = 52,
	secondEffect = 52,
	thirdEffect = 52,
	
	firstDistanceEffect = 42,
	secondDistanceEffect = 42,
	thirdDistanceEffect = 42,
	
	firstMinDmg = 6000000,
	firstMaxDmg = 8000000,
	secondMinDmg = 6000000,
	secondMaxDmg = 8000000,
	thirdMinDmg = 8000000,
	thirdMaxDmg = 6000000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaTwo = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

local areaThree = {
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 3, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0},
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = player:getMaxMana() / 100 * 38
	local max = player:getMaxMana() / 100 * 44
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7) 
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 7)
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 7)
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

function onTargetTile1(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
end

function onTargetTile2(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

local function firstCombat(cid, target)
    local caster = Player(cid)
    if not caster then return end
    return combatOne:execute(caster, target)
end

local function secondCombat(cid, target)
    local caster = Player(cid)
    if not caster then return end
    return combatTwo:execute(caster, target)
end

local function thridCombat(cid, target)
    local caster = Player(cid)
    if not caster then return end
    return combatThree:execute(caster, target)
end

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(caster, target)
	addEvent(firstCombat, 1, caster:getId(), target)
    addEvent(firstCombat, 200, caster:getId(), target)
    addEvent(firstCombat, 400, caster:getId(), target)
    return true
end

spell:name("mega gran")
spell:words("mega gran")
spell:group("attack")
spell:needLearn(true)
spell:needCasterTargetOrDirection(true)
--spell:isSelfTarget(true)
spell:needDirection(true)
spell:vocation("knight", "elite knight", "mixed elite knight", "spin elite knight", "epic elite knight", "nova elite knight", "hellborn elite knight")
spell:id(24)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(50)
spell:manaPercent(1)
spell:blockWalls(true)
spell:register()
--------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------

