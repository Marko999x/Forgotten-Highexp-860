SETS_TEXT = ""

function onSay(player, words, param)
	if SETS_TEXT == "" then
		local text = "=============================\n ========== Item Sets ==========\n============================="

		for i = 1, #ITEM_SETS do
			local itemSet = ITEM_SETS[i]
			text = string.format("%s\n\n[%s]\n\nParts:", text, itemSet.name)
			for _, part in ipairs(itemSet.parts) do
				local tempItem = Game.createItem(part.item, 1)
				local itemName =
					tempItem:getName():gsub(
					"(%a)(%a+)",
					function(a, b)
						return string.upper(a) .. string.lower(b)
					end
				)
				text = string.format("%s\n- %s", text, itemName)
				tempItem:remove()
			end
			text = string.format("%s\n\nBonuses:", text)
			text = text .. formatSetBonuses(itemSet.bonuses)
		end
		SETS_TEXT = text
	end

	player:showTextDialog(6103, SETS_TEXT)
end

function formatSetBonuses(bonuses)
	local text = ""
	for _, bonusParts in ipairs(bonuses) do
		text = string.format("%s\n%d / %d", text, _, #bonuses)
		for _, bonus in ipairs(bonusParts) do
			if bonus.type.combatType == BONUS_TYPES.TRIGGER then
				text = string.format("%s\n- %d%% chance to cast %s dealing %d-%d damage", text, bonus.chance, bonus.type.name, bonus.min, bonus.max)
			else
				text = string.format("%s\n- %s +%d%s", text, bonus.type.name, bonus.value, bonus.type.percentage == true and "%" or "")
			end
		end
		text = string.format("%s\n--------------------------------------------", text)
	end
	return text
end
