-- data/scripts/(optional)talkactions
-- admplayer.lua

local talkaction = TalkAction("/addshop")

function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    local price = tonumber(param)
    if not price or price <= 0 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Price must be higher than 0. Command use ex.: /addshop 50")
        return false
    end

    local lookPosition = player:getPosition()
    lookPosition:getNextPosition(player:getDirection())

    if not Tile(lookPosition) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "There is no tile in front of you.")
        return false
    end

    local topThing = Tile(lookPosition):getTopVisibleThing(player)
    if not topThing:isItem() then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "There is no item in front of you.")
        return false
    end

    local itemType = ItemType(topThing:getId())
    if not itemType:isMovable() then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Item in front of you is not movable.")
        return false
    end

    if itemType:isContainer() and topThing:getItem(0) then
        local containerId = itemType:getId()
        local containerItemCount = topThing:getCapacity()
        local firstItemInContainer = topThing:getItem(0)
        local itemId = firstItemInContainer:getId()
        local itemCount = firstItemInContainer:getCount()

        local offerName = (containerItemCount * itemCount) .. 'x ' .. firstItemInContainer:getName()
        local offerDescription = containerItemCount .. 'x You see ' .. firstItemInContainer:getDescription()

        db.query(
                'INSERT INTO `z_shop_offer` (`id`, `points`, `itemid1`, `count1`, `itemid2`, `count2`, ' ..
                        '`offer_type`, `offer_name`,`offer_description`) VALUES ' ..
                        '(NULL , ' .. price .. ', ' .. containerId .. ', ' .. containerItemCount .. ', ' ..
                        itemId .. ', ' .. itemCount .. ', \'container\', ' .. db.escapeString(offerName) ..
                        ', ' .. db.escapeString(offerDescription) .. ')'
        )
        player:sendTextMessage(
                MESSAGE_STATUS_WARNING,
                "Container >> " .. offerName .. " << added to SMS shop. Price set to " .. price .. " premium points."
        )

        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    else
        local itemId = itemType:getId()
        local itemCount = topThing:getCount()

        local offerName = itemCount .. 'x ' .. topThing:getName()
        local offerDescription = 'You see ' .. topThing:getDescription()

        db.query(
                'INSERT INTO `z_shop_offer` (`id`, `points`, `itemid1`, `count1`, `itemid2`, `count2`, ' ..
                        '`offer_type`, `offer_name`,`offer_description`) VALUES ' ..
                        '(NULL , ' .. price .. ', ' .. itemId .. ', ' .. itemCount .. ', ' ..
                        '0, 0, \'item\', ' .. db.escapeString(offerName) ..
                        ', ' .. db.escapeString(offerDescription) .. ')'
        )
        player:sendTextMessage(
                MESSAGE_STATUS_WARNING,
                "Item >> " .. offerName .. " << added to SMS shop. Price set to " .. price .. " premium points."
        )

        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    end

    return true
end

talkaction:separator(" ")
talkaction:register()
