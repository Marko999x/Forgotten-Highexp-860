local rebornToPass = MoveEvent()

function rebornToPass.onStepIn(player, item, position, fromPosition)
	if not player then
		return true
	end
	local playerP = Tile(position):getTopCreature()
	if playerP then
		Tile(position():getItemById(1497):remove())
	end
	return true
end

--for i = 52501, 52540 do
--rebornToPass:aid(i)
--end

rebornToPass:type("stepin")
rebornToPass:register()
