local ec = EventCallback

ec.onLookInBattleList = function(self, creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		description = description .. "\nHealth: ".. creature:getHealth() .." / ".. creature:getMaxHealth()..""
		if creature:isPlayer() and creature:getMaxMana() > 0 then
			description = description .. ", Mana: ".. creature:getMana() .." / ".. creature:getMaxMana() ..""
		end

		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			description = string.format("%s\nIP: %s", description, Game.convertIpToString(creature:getIp()))
		end
	end
	return description
end

ec:register()
