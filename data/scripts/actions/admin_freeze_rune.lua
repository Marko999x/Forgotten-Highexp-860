local config = {
	effect = 47,
	distanceEffect = 30,
	freezeStorage = 7212,
	color = TEXTCOLOR_LIGHTGREEN,
	time = 4000
}

local frostcharm = Action()

local condition = Condition(CONDITION_OUTFIT)
condition:setParameter(CONDITION_PARAM_TICKS, config.time)
condition:setOutfit({lookTypeEx = 7307})

local function unfreeze(cid)
    local player = Player(cid)
	if not player then return true end
    local pos = player:getPosition()
    pos:sendDistanceEffect(Position(pos.x+1, pos.y+1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x+1, pos.y-1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y-1, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-1, pos.y+1, pos.z), config.distanceEffect)
	
	pos:sendDistanceEffect(Position(pos.x, pos.y+2, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x, pos.y-2, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x-2, pos.y, pos.z), config.distanceEffect)
    pos:sendDistanceEffect(Position(pos.x+2, pos.y, pos.z), config.distanceEffect)
    --player:say("UNFROZEN", TALKTYPE_MONSTER_SAY)
	Game.sendAnimatedText('Melted', pos, config.color)
    pos:sendMagicEffect(config.effect)
    player:setMovementBlocked(false)
end

function frostcharm.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then return true end
    if not target:isPlayer() then
		player:sendCancelMessage('You can just freeze players')
        player:getPosition():sendMagicEffect(3)
        return false
    end
  
    if player:getExhaustion(config.freezeStorage) <= 0 then
        player:setExhaustion(config.freezeStorage, 15)
    else
        player:sendCancelMessage('You\'re exhausted for: '..player:getExhaustion(config.freezeStorage)..' seconds.')
        return true
    end
  
    local pos = target:getPosition()
	
	Position(pos.x, pos.y+2, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x, pos.y-2, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-2, pos.y, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x+2, pos.y, pos.z):sendDistanceEffect(pos, config.distanceEffect)
	
    Position(pos.x+1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x+1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-1, pos.y-1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    Position(pos.x-1, pos.y+1, pos.z):sendDistanceEffect(pos, config.distanceEffect)
    target:addCondition(condition)
    pos:sendMagicEffect(config.effect)
    target:setMovementBlocked(true)
	customTimer(pos, 4, config.color)
    addEvent(unfreeze, config.time, target.uid)
    return true
end

frostcharm:id(7289)
frostcharm:register()