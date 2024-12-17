local creatureEvent = CreatureEvent("creatureEventName")

local config = {
	["50"] = {storage = 20300, premiumPoints = 300}
}
function creatureEvent.onAdvance(player, skill, oldLevel, newLevel)
	local rebirth = config[player:getReborn()]
	
	return true
end

creatureEvent:register()
