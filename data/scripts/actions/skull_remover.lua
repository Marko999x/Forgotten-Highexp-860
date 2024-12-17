local skullRemover = Action()

function skullRemover.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if table.contains({SKULL_BLACK, SKULL_RED}, player:getSkull()) then
		player:setSkull(SKULL_NONE)
		player:setSkullTime(0)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your frags has been removed!")
		db.query("UPDATE player_deaths SET unjustified = 0 WHERE unjustified = 1 AND killed_by = " .. db.escapeString(player:getName()))
		item:remove(1)
	end
	return true
end

skullRemover:id(9969)
skullRemover:register()