local outfitConfig = {
	[1000] = {outfitMale = 10, outfitFemale = 12, storage = 10000},
	[1001] = {outfitMale = 11, outfitFemale = 13, storage = 10001},
}

local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	local outfitScript = outfitConfig[item:getActionId()]
	if not outfitScript then
		return true
	end
	if player:getStorageValue(outfitScript.storage) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy used that statue.')
		return true
	end
	player:addOutfit(outfitScript.outfitMale, 3)
	player:addOutfit(outfitScript.outfitFemale, 3)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have received a new outfit.')
	player:setStorageValue(outfitScript.storage, 1)
	return true
end

for k, v in pairs(outfitConfig) do
	action:aid(k)
end

--action:register()
------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------
local mountConfig = {
	[2000] = {mountId = 10, storage = 20000},
	[2001] = {mountId = 10, storage = 20001},
}

local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	local mountScript = mountConfig[item:getActionId()]
	if not mountScript then
		return true
	end
	if player:getStorageValue(mountScript.storage) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy used that statue.')
		return true
	end
	player:addMount(mountScript.mountId)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have received a new mount.')
	player:setStorageValue(mountScript.storage, 1)
	return true
end

for k, v in pairs(mountConfig) do
	action:aid(k)
end

--action:register()