local config = {
	effect = 47,
	distanceEffect = 30,
	freezeStorageCooldown = 20001,
    targetFreezeStorage = 20002,
	color = TEXTCOLOR_LIGHTGREEN,
	time = 2000
}

local frostcharm = Action()

local condition = Condition(CONDITION_OUTFIT)
condition:setParameter(CONDITION_PARAM_TICKS, config.time)
condition:setOutfit({lookTypeEx = 7307})

local function unfreeze(cid)
    local player = Player(cid)
	if not player then 
        return true 
    end
    local pos = player:getPosition()
    pos:sendDistanceEffect(Position(pos.x+1, pos.y+1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x+1, pos.y-1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y-1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y+1, pos.z), config.distanceEffect)
	pos:sendDistanceEffect(Position(pos.x, pos.y+2, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x, pos.y-2, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-2, pos.y, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x+2, pos.y, pos.z), config.distanceEffect)
	Game.sendAnimatedText('Melted', pos, config.color)
    pos:sendMagicEffect(config.effect)
    player:setMovementBlocked(false)
    player:setStorageValue(20000, 0)
end

function frostcharm.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then 
        return true 
    end
    if not target:isPlayer() or target == player then
		player:sendCancelMessage('You can only use this on another players.')
        player:getPosition():sendMagicEffect(3)
        return true
    end
    if player:getStorageValue(config.freezeStorageCooldown) > os.time() then
        player:sendCancelMessage('You can use freeze again in: '..player:getStorageValue(config.freezeStorageCooldown) - os.time()..' seconds.')
        return true
    end
    if target:getStorageValue(config.targetFreezeStorage) > os.time() then
        player:sendCancelMessage('You can freeze target again in: '..target:getStorageValue(config.targetFreezeStorage) - os.time()..' seconds.')
        return true
    end
    local pos = target:getPosition()
    -- Effect
	Position(pos.x, pos.y+2, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x, pos.y-2, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-2, pos.y, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x+2, pos.y, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x+1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x+1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    pos:sendMagicEffect(config.effect)
    target:addCondition(condition)
    target:setMovementBlocked(true)
    target:setStorageValue(config.targetFreezeStorage, os.time() + 15)
    target:setStorageValue(20000, 1)
	customTimer(pos, 2, config.color)
    player:setStorageValue(config.freezeStorageCooldown, os.time() + 10)
    addEvent(unfreeze, config.time, target.uid)
    return true
end

frostcharm:id(2309)
frostcharm:register()