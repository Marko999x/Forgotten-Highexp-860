local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = CONST_ME_YALAHARIGHOST,
	secondEffect = CONST_ME_YALAHARIGHOST,
	thirdEffect = CONST_ME_YALAHARIGHOST,
	
	firstDistanceEffect = CONST_ANI_HOLY,
	secondDistanceEffect = CONST_ANI_HOLY,
	thirdDistanceEffect = CONST_ANI_HOLY,
	
	firstMinDmg = 24000000,
	firstMaxDmg = 26000000,
	secondMinDmg = 24000000,
	secondMaxDmg = 26000000,
	thirdMinDmg = 24000000,
	thirdMaxDmg = 26000000,
	
	magicLevel = 25,
	rebornMin = 900000,
	rebornMax = 1100000
}

local areaOne = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 2, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaTwo = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 2, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaThree = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 2, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
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
	addEvent(secondCombat, 150, player:getId(), target)
	addEvent(thridCombat, 300, player:getId(), target)
    return true
end

spell:name("ghost star")
spell:words("ghost star")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("epic master sorcerer", "nova master sorcerer", "hellborn master sorcerer")
spell:id(119)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(200)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = CONST_ME_WATERSPLASH,
	secondEffect = CONST_ME_WATERSPLASH,
	thirdEffect = CONST_ME_WATERSPLASH,
	
	firstDistanceEffect = CONST_ANI_HOLY,
	secondDistanceEffect = CONST_ANI_HOLY,
	thirdDistanceEffect = CONST_ANI_HOLY,
	
	firstMinDmg = 22000000,
	firstMaxDmg = 24000000,
	secondMinDmg = 22000000,
	secondMaxDmg = 24000000,
	thirdMinDmg = 22000000,
	thirdMaxDmg = 24000000,
	
	magicLevel = 25,
	rebornMin = 800000,
	rebornMax = 1000000
}

local areaOne = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 2, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaTwo = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 2, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaThree = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 2, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
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
	addEvent(secondCombat, 150, player:getId(), target)
	addEvent(thridCombat, 300, player:getId(), target)
    return true
end

spell:name("water star")
spell:words("water star")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("epic elder druid", "nova elder druid", "hellborn elder druid")
spell:id(43)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(200)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_HOLYDAMAGE,

	firstEffect = CONST_ME_HOLYDAMAGE,
	secondEffect = CONST_ME_HOLYDAMAGE,
	thirdEffect = CONST_ME_HOLYDAMAGE,
	
	firstDistanceEffect = CONST_ANI_FLAMMINGARROW,
	secondDistanceEffect = CONST_ANI_FLAMMINGARROW,
	thirdDistanceEffect = CONST_ANI_FLAMMINGARROW,
	
	firstMinDmg = 26000000,
	firstMaxDmg = 28000000,
	secondMinDmg = 26000000,
	secondMaxDmg = 28000000,
	thirdMinDmg = 26000000,
	thirdMaxDmg = 28000000,
	
	magicLevel = 25,
	rebornMin = 1100000,
	rebornMax = 1300000
}

local areaOne = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 0, 1, 0, 1, 1, 0},
	{1, 1, 1, 0, 1, 0, 1, 1, 1},
	{1, 0, 1, 1, 1, 1, 1, 0, 1},
	{1, 1, 1, 1, 2, 1, 1, 1, 1},
	{1, 0, 1, 1, 1, 1, 1, 0, 1},
	{1, 1, 1, 0, 1, 0, 1, 1, 1},
	{0, 1, 1, 0, 1, 0, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaTwo = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 0, 1, 0, 1, 1, 0},
	{1, 1, 1, 0, 1, 0, 1, 1, 1},
	{1, 0, 1, 1, 1, 1, 1, 0, 1},
	{1, 1, 1, 1, 2, 1, 1, 1, 1},
	{1, 0, 1, 1, 1, 1, 1, 0, 1},
	{1, 1, 1, 0, 1, 0, 1, 1, 1},
	{0, 1, 1, 0, 1, 0, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaThree = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 0, 1, 0, 1, 1, 0},
	{1, 1, 1, 0, 1, 0, 1, 1, 1},
	{1, 0, 1, 1, 1, 1, 1, 0, 1},
	{1, 1, 1, 1, 2, 1, 1, 1, 1},
	{1, 0, 1, 1, 1, 1, 1, 0, 1},
	{1, 1, 1, 0, 1, 0, 1, 1, 1},
	{0, 1, 1, 0, 1, 0, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
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
	addEvent(secondCombat, 400, player:getId(), target)
	addEvent(thridCombat, 800, player:getId(), target)
    return true
end

spell:name("supreme con gran mas")
spell:words("supreme con gran mas")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("epic royal paladin", "nova royal paladin", "hellborn royal paladin")
spell:id(154)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(200)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_PHYSICALDAMAGE,
	secondType = COMBAT_PHYSICALDAMAGE,
	thirdType = COMBAT_PHYSICALDAMAGE,

	firstEffect = CONST_ME_HITAREA,
	secondEffect = CONST_ME_HITAREA,
	thirdEffect = CONST_ME_HITAREA,
	
	firstDistanceEffect = CONST_ANI_WHIRLWINDCLUB,
	secondDistanceEffect = CONST_ANI_WHIRLWINDCLUB,
	thirdDistanceEffect = CONST_ANI_WHIRLWINDCLUB,
	
	firstMinDmg = 18000000,
	firstMaxDmg = 20000000,
	secondMinDmg = 18000000,
	secondMaxDmg = 20000000,
	thirdMinDmg = 18000000,
	thirdMaxDmg = 20000000,
	
	magicLevel = 25,
	rebornMin = 700000,
	rebornMax = 900000
}

local areaOne = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 2, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaTwo = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 2, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local areaThree = {
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 2, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.rebornMin)
	local max = config.firstMaxDmg + (reborn * config.rebornMax)
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
	addEvent(secondCombat, 100, player:getId(), target)
	addEvent(thridCombat, 200, player:getId(), target)
    return true
end

spell:name("exori mas gran")
spell:words("exori mas gran")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("epic elite knight", "nova elite knight", "hellborn elite knight")
spell:id(19)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(200)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
----------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
