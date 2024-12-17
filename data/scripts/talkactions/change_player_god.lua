-- data/scripts/(optional)talkactions
-- admplayer.lua

local creative = TalkAction("/creative")

function creative.onSay(player, words)
    if player:getAccountType() == 6 then
        local position = player:getPosition()
        player:setGroup(Group(6))
        position:sendMagicEffect(14)
        player:remove()
    end
    return false
end

creative:separator(" ")
creative:register()

local survival = TalkAction("/survival")

function survival.onSay(player, words)
    if player:getAccountType() == 6 then
        local position = player:getPosition()
        player:setGroup(Group(1))
        position:sendMagicEffect(13)
        player:remove()
    end
    return false
end

survival:register()