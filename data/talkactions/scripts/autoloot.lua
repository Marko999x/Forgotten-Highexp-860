function onSay(player, words, param)
	if (param == '') then
		local list = player:getAutoLootList()

		if (not list) then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Your auto loot list is empty, usage: /autoloot [add/remove], [itemID/name]")
			return false
		end

		local text = "Your autoloot list: "

		for _, itemID in ipairs(list) do
			local itemType = ItemType(itemID)
			text = text ..'\n'.. itemType:getName() .. ' [ID: ' .. itemID .. '], '
		end

		player:sendTextMessage(MESSAGE_INFO_DESCR, text:sub(1, -3) .. '.')
		player:showTextDialog(4855, text:sub(1, -3) .. '.', false)
		return false
	end

	local params = param:split(",")

	if (not params[2]) then
		return player:sendTextMessage(MESSAGE_INFO_DESCR, "Missing itemID or name, usage: /autoloot [add/remove], [itemID/name]")
	end

	if (params[1] == 'add' or params[1] == 'remove') then
		local itemType = ItemType(params[2]:trim())

		if (itemType:getName() == '') then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "There is no item with that ID or name.")
			return false
		end

		if (params[1] == 'add') then
			if (player:addAutoLootItem(itemType:getId())) then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You're now auto looting " .. itemType:getName() .. ' [ID: ' .. itemType:getId() .. '].')
				return false
			end

			return not player:sendTextMessage(MESSAGE_INFO_DESCR, "You're already auto looting this item.")
		elseif (params[1] == 'remove') then
			if (player:removeAutoLootItem(itemType:getId())) then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You're not auto looting " .. itemType:getName() .. ' [ID: ' .. itemType:getId() .. '] anymore.')
				return false
			end

			player:sendTextMessage(MESSAGE_INFO_DESCR, "You're not auto looting this item.")
			return false
		end
	end

    player:sendTextMessage(MESSAGE_INFO_DESCR, "usage: /autoloot [add/remove], [itemID/name]")
	return false
end