local auto_follow = TalkAction("!items")

function auto_follow.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
	local backpack = Game.createItem(1988, 1)

	
	return false
end

auto_follow:separator(" ") -- Separate arguments passed to the command by a space
auto_follow:register()