local tileLimit = 15
local protectionTileLimit = 15
local houseTileLimit = 15

local ec = EventCallback

function ec.onMoveItem(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    local tile = Tile(toPosition)
    if tile then
        local itemLimit = tile:getHouse() and houseTileLimit or tile:hasFlag(TILESTATE_PROTECTIONZONE) and protectionTileLimit or tileLimit
        if itemLimit > 0 and tile:getThingCount() > itemLimit and item:getType():getType() ~= ITEM_TYPE_MAGICFIELD then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot add more items on this tile.")
            return false
        end
    end
    return true
end

ec:register(-1)