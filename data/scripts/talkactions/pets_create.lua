local talkAction = TalkAction("!pet")

local config = {
	['1'] = {name = 'Young Sea Serpent', chance = 500, actionId = 32500, itemName = "test", itemDescription = "6000000000"},
	['2'] = {name = 'Slick Water Elemental', chance = 500, actionId = 32501, itemName = "test", itemDescription = "15000000000"},
	['3'] = {name = 'Mr Rabbit', chance = 500, actionId = 32502, itemName = "test", itemDescription = "40000000000"},
	['4'] = {name = 'Squirrel', chance = 500, actionId = 32503, itemName = "test", itemDescription = "40000000000"},
	['5'] = {name = 'Earth Overlord', chance = 500, actionId = 32504, itemName = "test", itemDescription = "15000000000"},
	['6'] = {name = 'Energy Overlord', chance = 500, actionId = 32505, itemName = "test", itemDescription = "15000000000"},
	['7'] = {name = 'Ice Overlord', chance = 500, actionId = 32506, itemName = "test", itemDescription = "15000000000"},
	['8'] = {name = 'The Masked Marauder', chance = 500, actionId = 32507, itemName = "test", itemDescription = "1000000000"},
	['9'] = {name = 'Worker Golem', chance = 500, actionId = 32508, itemName = "test", itemDescription = "1000000000"},
	['10'] = {name = 'Grizzly Da Bear', chance = 500, actionId = 32509, itemName = "test", itemDescription = "1000000000"},
	['11'] = {name = 'Fire Overlord', chance = 500, actionId = 32510, itemName = "test", itemDescription = "1000000000"},
}

function talkAction.onSay(player, words, param, type)
    local petTalk = config[param:lower()]
    local petItem = player:addItem(2345, 1, true)
    petItem:setActionId(petTalk.actionId)
    petItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, 'It contains a captured '..petTalk.name..', tammed by '..player:getName()..' \nMax HP['..petTalk.itemDescription..'].')
    return false
end

talkAction:accountType(ACCOUNT_TYPE_GOD)
talkAction:separator(" ")
talkAction:register()