local price_aol = 10000

function onSay(player, words, param)
    if player:removeMoney(price_aol) then
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        player:addItem(2173, 1)
    else
        if player:withdrawMoney(price_aol) then
            if player:removeMoney(price_aol) then
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
                player:addItem(2173, 1)
            end
        else
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:sendCancelMessage("You don't have enought money. Not even in your bank!")
        end
    end

    return true
end