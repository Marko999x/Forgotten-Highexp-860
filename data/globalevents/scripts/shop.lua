local SHOP_MSG_TYPE = MESSAGE_INFO_DESCR

function onThink(interval)
    local intervalInSeconds = math.ceil(interval / 1000)
    local deliveryList = db.storeQuery("SELECT * FROM z_ots_comunication")
    if deliveryList ~= false then
        repeat
            local deliveryId = result.getNumber(deliveryList, "id")
            local player = Player(result.getString(deliveryList, "name"))
            if player then
                local itemId = result.getNumber(deliveryList, "param1")
                local itemCount = result.getNumber(deliveryList, "param2")
                local containerId = result.getNumber(deliveryList, "param3")
                local containerItemsCount = result.getNumber(deliveryList, "param4")
                local offerType = result.getString(deliveryList, "param5")
                local offerName = result.getString(deliveryList, "param6")

                if offerType == 'item' or offerType == 'container' then
                    local totalWeight = 0
                    if offerType == 'item' then
                        totalWeight = ItemType(itemId):getWeight(itemCount)
                    elseif offerType == 'container' then
                        local containerWeight = ItemType(containerId):getWeight()
                        local itemsWeight = containerItemsCount * ItemType(itemId):getWeight(itemCount)
                        totalWeight = containerWeight + itemsWeight
                    end

                    if player:getFreeCapacity() >= totalWeight then
                        local deliveredItem = nil
                        if offerType == 'item' then
                            -- stackable items may not be fully delivered, if added directly to player
                            -- so we must use virtual item and 'addItemEx'
                            local containerToDeliver = Game.createItem(itemId, itemCount)
                            deliveredItem = player:addItemEx(containerToDeliver, false)
                        elseif offerType == 'container' then
                            local containerToDeliver = Game.createItem(containerId, 1)
                            for i = 1, containerItemsCount do
                                containerToDeliver:addItem(itemId, itemCount)
                            end
                            deliveredItem = player:addItemEx(containerToDeliver, false)
                        end

                        if deliveredItem and (type(deliveredItem) ~= 'number' or deliveredItem == RETURNVALUE_NOERROR) then
                            player:sendTextMessage(SHOP_MSG_TYPE, 'You received >> ' .. offerName .. ' << from OTS shop.')
                            db.query("DELETE FROM `z_ots_comunication` WHERE `id` = " .. deliveryId)
                            db.query(
                                    "UPDATE `z_shop_history_item` SET `trans_state` = 'realized', " ..
                                            "`trans_real` = " .. os.time() .. " WHERE `id` = " .. deliveryId
                            )
                        else
                            player:sendTextMessage(SHOP_MSG_TYPE,
                                    '>> ' .. offerName .. ' << from OTS shop is waiting for you. ' ..
                                            'Please make place for this item in your backpack and wait ' ..
                                            intervalInSeconds .. ' seconds to get it.'
                            )
                        end
                    else
                        local totalWeightString = string.format("%0.2f", totalWeight / 100)
                        local freeCapacityString = string.format("%0.2f", player:getFreeCapacity() / 100)
                        player:sendTextMessage(SHOP_MSG_TYPE,
                                '>> ' .. offerName .. ' << from OTS shop is waiting for you. It weights ' ..
                                        totalWeightString .. ' oz., you have only ' .. freeCapacityString ..
                                        ' oz. free capacity. Put some items in depot and wait ' ..
                                        intervalInSeconds .. ' seconds to get it.'
                        )
                    end
                else
                    print('SHOP: invalid offer type: ' .. offerType)
                end
            end
        until not result.next(deliveryList)
        result.free(deliveryList)
    end
    return true
end