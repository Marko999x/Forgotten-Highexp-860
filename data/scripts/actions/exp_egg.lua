local action = Action()

local rates = {
	{range = {0, 49}, expAmount = 2543211, maxLevel = 717217},
	{range = {50, 99}, expAmount = 3043211, maxLevel = 717217},
	{range = {100, 149}, expAmount = 3543211, maxLevel = 834434},
	{range = {150, 199}, expAmount = 4043211, maxLevel = 834434},
	{range = {200, 249}, expAmount = 4543211, maxLevel = 951651},
	{range = {250, 299}, expAmount = 5043211, maxLevel = 951651},
	{range = {300, 349}, expAmount = 5543211, maxLevel = 1068868},
	{range = {350, 399}, expAmount = 6043211, maxLevel = 1068868},
	{range = {400, 449}, expAmount = 6543211, maxLevel = 1186085},
	{range = {450, 499}, expAmount = 7043211, maxLevel = 1186085},
	{range = {500, 599}, expAmount = 7043211, maxLevel = 1303302},
	{range = {600, 699}, expAmount = 7043211, maxLevel = 1420519},
	{range = {700, 799}, expAmount = 7043211, maxLevel = 1537736},
	{range = {800, 899}, expAmount = 7043211, maxLevel = 1654953},
	{range = {900, 999}, expAmount = 7043211, maxLevel = 1772170},
	{range = {1000, 1099}, expAmount = 7043211, maxLevel = 1889387},
	{range = {1100, 1199}, expAmount = 7043211, maxLevel = 2006604},
	{range = {1200, 1299}, expAmount = 7043211, maxLevel = 2123821},

}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	local rebornLvl = player:getReborn()
	for _, thing in pairs(rates) do
		if rebornLvl >= thing.range[1] and rebornLvl <= thing.range[2] then
			if player:getLevel() == thing.maxLevel then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have reached '..thing.maxLevel..' level (max level), please go to rebirth npc and start a new life.')
				return true
			end
			player:addExperience(thing.expAmount, true)
			player:say('You Gained 40000000000000000 Experience Points!', TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(28)
			break
		end
	end
	return true
end

action:id(6541)
action:register()
