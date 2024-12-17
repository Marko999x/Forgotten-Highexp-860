local action = Action()

local config = {
    [1] = {spell = "music frozendrive"},
    [2] = {spell = "music frozendrive"},
    [3] = {spell = "exevo holy falls"},
    [4] = {spell = "hell deathdrive"},
    [5] = {spell = "music frozendrive"},
    [6] = {spell = "music frozendrive"},
    [7] = {spell = "exevo holy falls"},
    [8] = {spell = "music frozendrive"},
    [9] = {spell = "music frozendrive"},
    [10] = {spell = "exevo holy falls"},
    [11] = {spell = "hell deathdrive"},
    [12] = {spell = "music frozendrive"},
    [13] = {spell = "music frozendrive"},
    [14] = {spell = "exevo holy falls"},
    [15] = {spell = "music frozendrive"},
    [16] = {spell = "music frozendrive"},
    [17] = {spell = "exevo holy falls"},
    [18] = {spell = "hell deathdrive"},
    [19] = {spell = "music frozendrive"},
    [20] = {spell = "music frozendrive"},
    [21] = {spell = "exevo holy falls"},
    [22] = {spell = "music frozendrive"},
    [23] = {spell = "music frozendrive"},
    [24] = {spell = "exevo holy falls"},
    [25] = {spell = "hell deathdrive"},
    [26] = {spell = "music frozendrive"},
    [27] = {spell = "music frozendrive"},
    [28] = {spell = "exevo holy falls"},
}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
    local vocSpell = config[player:getVocation():getId()]
	if not vocSpell then
		return true
	end
	if player:hasLearnedSpell(vocSpell.spell) then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'You alredy learned '..vocSpell.spell..' spell.')
		return true
	end
	player:learnSpell(vocSpell.spell)
	player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Congratz! You learned '..vocSpell.spell..' spell!')
	player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	return true
end

action:uid(52942)
action:register()
-------------------------------------------------------------------------------------------------------------