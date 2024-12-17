local config = {
    talkAction = "!sex",
    talkExhausted = 3, -- seconds
    requireLevel = 100,

    probabilityOfHavingChildren = 5, -- 5%
    childrenItemIdFemale = 6579,
    childrenItemIdMale = 6579,

    probabilityOfCondomFailure = 10, -- 10%
    condomPrice = 100 -- gold coins
}

local cacheRequests = {}

if not Position.getTile then Position.getTile = Tile end
local function getPlayerCache(player)
    local playerId = player:getId()
    local playerCache = cacheRequests[playerId]
    if playerCache then
        return playerCache
    end

    cacheRequests[playerId] = {}
    return cacheRequests[playerId]
end

local function isAlreadyRequestPlayer(player, requestPlayer)
    return getPlayerCache(player)[requestPlayer:getId()]
end

local function getNextPlayer(player)
    local playerPosition = player:getPosition()
    playerPosition:getNextPosition(player:getDirection())
    local toTile = playerPosition:getTile()
    if toTile then
        local toPlayer = toTile:getBottomVisibleCreature(player)
        if toPlayer and toPlayer:isPlayer() then
            return toPlayer
        end
    end
end

local sendTM = function (player, message, ...)
    return player:sendTextMessage(MESSAGE_LOOT, string.format(message, ...))
end

local sendCM = function (player, message, ...)
    return player:sendCancelMessage(string.format(message, ...))
end

local dropFluid = function (position, fluidType, description)
    local tile = position:getTile()
    if tile then
        if not tile:getItemById(2016, fluidType) then
            local fluid = Game.createItem(2016, fluidType, position)
            fluid:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description)
            fluid:decay()
        end
    end
end

local payCondom = function (player)
    local bankBalance = player:getBankBalance()
    local moneyBalance = player:getMoney()
    local totalBalance = moneyBalance + bankBalance
    if totalBalance < config.condomPrice then
        return false
    end

    local resultMoney = moneyBalance - config.condomPrice
    player:removeMoney(config.condomPrice)
    if resultMoney < 0 then player:setBankBalance(bankBalance - math.abs(resultMoney)) end
    return true
end

local canPay = function (fromPlayer, toPlayer)
    local playerCache = getPlayerCache(fromPlayer)[toPlayer:getId()]
    if playerCache.bounty == 0 then
        return true
    end

    if (fromPlayer:getMoney() + fromPlayer:getBankBalance()) < playerCache.bounty then
        sendCM(fromPlayer, "You don't have enough money to bounty.")
        sendCM(toPlayer, "%s does not have enough money to pay.", fromPlayer:getName())
        return false
    end

    return true
end

local paySex = function (fromPlayer, toPlayer)
    local fromPayed, toPayed = canPay(fromPlayer, toPlayer), canPay(toPlayer, fromPlayer) 
    if not fromPayed and not toPayed then
        return false
    end

    local playerCache = getPlayerCache(fromPlayer)[toPlayer:getId()]
    if playerCache.bounty > 0 and fromPayed then
        local bankBalance = fromPlayer:getBankBalance()
        local moneyBalance = fromPlayer:getMoney()
        local totalBalance = moneyBalance + bankBalance
        local resultMoney = moneyBalance - playerCache.bounty
        fromPlayer:removeMoney(playerCache.bounty)
        if resultMoney < 0 then fromPlayer:setBankBalance(bankBalance - math.abs(resultMoney)) end
        toPlayer:setBankBalance(toPlayer:getBankBalance() + playerCache.bounty)
        sendTM(toPlayer, "Your bank balance has increased, you now have: %d gold coins.", playerCache.bounty)
    end

    playerCache = getPlayerCache(toPlayer)[fromPlayer:getId()]
    if playerCache.bounty > 0 and toPayed then
        local bankBalance = toPlayer:getBankBalance()
        local moneyBalance = toPlayer:getMoney()
        local totalBalance = moneyBalance + bankBalance
        local resultMoney = moneyBalance - playerCache.bounty
        toPlayer:removeMoney(playerCache.bounty)
        if resultMoney < 0 then toPlayer:setBankBalance(bankBalance - math.abs(resultMoney)) end
        fromPlayer:setBankBalance(fromPlayer:getBankBalance() + playerCache.bounty)
        sendTM(fromPlayer, "Your bank balance has increased, you now have: %d gold coins.", playerCache.bounty)
    end
    return true
end

local executeChildren = function (mother, father)
    local fatherCache = getPlayerCache(father)
    local fatherCondom = fatherCache[mother:getId()].condom and payCondom(father)
    local fatherCondomFailure = true
    if fatherCondom then
        fatherCondomFailure = config.probabilityOfCondomFailure >= math.random(100)
        if fatherCondomFailure then
            fatherCache[mother:getId()].condom = nil
            sendTM(father, "The condom has broken, there is a risk of getting %s pregnant, I hope she is taking care of herself.", mother:getName())
            father:getPosition():sendMagicEffect(CONST_ME_STUN)
            cacheRequests[father:getId()] = nil
        end
    end

    local motherCache = getPlayerCache(mother)
    local motherCondom = motherCache[father:getId()].condom and payCondom(mother)
    local motherCondomFailure = true
    if motherCondom then
        motherCondomFailure = config.probabilityOfCondomFailure >= math.random(100)
        if motherCondomFailure then
            motherCache[father:getId()].condom = nil
            sendTM(mother, "The condom has broken, there is a chance you could get pregnant unless %s is taking care of himself.", father:getName())
            mother:getPosition():sendMagicEffect(CONST_ME_STUN)
            cacheRequests[mother:getId()] = nil
        end
    end

    if (not fatherCondom and not motherCondom) or (fatherCondomFailure and motherCondomFailure) then
        if config.probabilityOfHavingChildren >= math.random(100) then
            local female = math.random(1, 2) == 1
            local children = Game.createItem(female and config.childrenItemIdFemale or config.childrenItemIdMale, 1)
            if children then
                children:setAttribute(ITEM_ATTRIBUTE_NAME, "Newborn Baby")
                children:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("%s of %s and %s.\nDate of birth: %s.",
                    female and "Daughter" or "Son",
                    father:getName(),
                    mother:getName(),
                    os.date("%c")))
                local result = mother:addItemEx(children)
                if result ~= RETURNVALUE_NOERROR then
                    mother:sendCancelMessage(result)
                    children:remove()
                end
            end
        end
    end
end

local positions = {
    [DIRECTION_NORTH] = DIRECTION_SOUTH,
    [DIRECTION_SOUTH] = DIRECTION_NORTH,
    [DIRECTION_EAST] = DIRECTION_WEST,
    [DIRECTION_WEST] = DIRECTION_EAST
}

local femaleSexPos = {"scissors", "fingering", "fisting", "licking"}
local maleSexPos = {"blowjob", "cunnilingus", "sword"}

local executeSex = function (fromPlayer, toPlayer)
    if not paySex(fromPlayer, toPlayer) then
        return
    end

    local fromPosition, toPosition = fromPlayer:getPosition(), toPlayer:getPosition()
    local fs, ts = fromPlayer:getSex(), toPlayer:getSex()
    local fromName, toName = fromPlayer:getName(), toPlayer:getName()
    local fromDirection, toDirection = fromPlayer:getDirection(), toPlayer:getDirection()
    if fromDirection == toDirection then -- Of back
        if fs == PLAYERSEX_FEMALE and ts == PLAYERSEX_FEMALE then
            local sexPos = femaleSexPos[math.random(1, #femaleSexPos)]
            sendCM(fromPlayer, "You've %s %s ass.", sexPos, toName)
            sendCM(toPlayer, "%s has %s your ass.", fromName, sexPos)
            dropFluid(fromPosition, FLUID_WATER, string.format("%s Fluids.", fromName))
            dropFluid(toPosition, FLUID_WATER, string.format("%s Fluids.", fromName))
            fromPlayer:say("AWWW!") toPlayer:say("OWWW!")
        elseif fs == PLAYERSEX_MALE then
            sendCM(fromPlayer, "You have penetrated %s in the ass.", toName)
            sendCM(toPlayer, "%s has penetrated you in the ass.", fromName)
            dropFluid(toPosition, FLUID_MILK, string.format("%s Milk.", fromName))
            fromPlayer:say("OHHHH!") toPlayer:say("AWWWW!")
        else
            sendCM(fromPlayer, "You've sucked %s ass.", toName)
            sendCM(toPlayer, "%s has sucked your ass.", fromName)
            dropFluid(toPosition, FLUID_WATER, string.format("%s Fluids.", toName))
            fromPlayer:say("AWWW!") toPlayer:say("AWWWW!")
        end
    elseif positions[fromDirection] == toDirection then
        if fs == PLAYERSEX_FEMALE and ts == PLAYERSEX_FEMALE then
            local sexPos = femaleSexPos[math.random(1, #femaleSexPos)]
            sendCM(fromPlayer, "You have played %s with %s.", sexPos, toName)
            sendCM(toPlayer, "%s has played %s with you.", fromName, sexPos)
            dropFluid(fromPosition, FLUID_WATER, string.format("%s Fluids.", fromName))
            dropFluid(toPosition, FLUID_WATER, string.format("%s Fluids.", toName))
            fromPlayer:say("ASWWW!") toPlayer:say("ASWWW!")
        elseif fs == PLAYERSEX_MALE and ts == PLAYERSEX_MALE then
            local sexPos = maleSexPos[math.random(1, #maleSexPos)]
            sendCM(fromPlayer, "You have had a %s war with %s.", sexPos, toName)
            sendCM(toPlayer, "%s has had a %s war with you.", fromName, sexPos)
            dropFluid(fromPosition, FLUID_MILK, string.format("%s Milk.", fromName))
            dropFluid(toPosition, FLUID_MILK, string.format("%s Milk.", toName))
            fromPlayer:say("PSSS!") toPlayer:say("PSSS!")
        elseif fs == PLAYERSEX_MALE then
            sendCM(fromPlayer, "You have penetrated %s in the pussy.", toName)
            sendCM(toPlayer, "%s has penetrated you in the pussy.", fromName)
            dropFluid(toPosition, FLUID_MILK, string.format("%s Milk.", fromName))
            fromPlayer:say("OHHH OHHH!") toPlayer:say("CLAP CLAP ahh!")
            executeChildren(toPlayer, fromPlayer)
        else
            sendCM(fromPlayer, "%s has penetrated you in the pussy.", toName)
            sendCM(toPlayer, "You have penetrated %s in the pussy.", fromName)
            dropFluid(fromPosition, FLUID_MILK, string.format("%s Milk.", toName))
            fromPlayer:say("CLAP CLAP ahh!") toPlayer:say("OHHH OHHH!")
            executeChildren(fromPlayer, toPlayer)
        end
    else
        sendCM(fromPlayer, "%s is not at a good angle, but she has already been informed.", toName)
        sendCM(toPlayer, "%s is asking you to stand at a good angle for sex.", fromName)
        return
    end

    fromPosition:sendMagicEffect(CONST_ME_HEARTS)
    toPosition:sendMagicEffect(CONST_ME_HEARTS)
end

local talkAction = TalkAction(config.talkAction)
local exhausteds = {}

function talkAction.onSay(player, words, param, type)
    if player:getLevel() < config.requireLevel then
        sendCM(player, "Sex is only available to players level %s or higher.", config.requireLevel)
        return false
    end

    local condom = false
    local bounty = 0
    local totalBalance = player:getMoney() + player:getBankBalance()
    local split = param:splitTrimmed(",")
    for i, s in pairs(split) do
        local command = s:lower()
        if command == "condom" then
            if totalBalance < config.condomPrice then
                sendCM(player, "You don't have enough money to buy a condom.")
                return false
            end

            condom = true
        elseif command == "cancel" then
            cacheRequests[player:getId()] = nil
            sendCM(player, "All requests for sex have been cancelled.")
            return false
        elseif command:sub(1, 6) == "bounty" then
            local gold = tonumber(command:sub(8)) or 0
            if totalBalance < gold then
                sendCM(player, "You don't have enough money to bounty.")
                return false
            end

            bounty = gold
        end
    end

    local playerId = player:getId()
    local exhausted = exhausteds[playerId] or 0
    local now = os.time()
    if exhausted > now then
        sendCM(player, "You must wait %d seconds.", math.ceil(exhausted - now))
        return false
    end

    exhausteds[playerId] = now + config.talkExhausted
    local nextPlayer = getNextPlayer(player)
    if not nextPlayer then
        sendTM(player, "No user was found in front of you.")
        return false
    end

    if nextPlayer:getLevel() < config.requireLevel then
        sendCM(player, "Sex is only available to players level %s or higher, %s does not meet this requirement.", config.requireLevel, nextPlayer:getName())
        return false
    end

    if isAlreadyRequestPlayer(player, nextPlayer) then
        if not isAlreadyRequestPlayer(nextPlayer, player) then
            sendTM(player, "%s must accept your request in order to have sex.", nextPlayer:getName())
            return false
        end

        getPlayerCache(player)[nextPlayer:getId()] = {condom=condom,bounty=bounty}
        executeSex(player, nextPlayer)
        return false
    end

    local playerCache = getPlayerCache(player)
    playerCache[nextPlayer:getId()] = {condom=condom,bounty=bounty}
    if isAlreadyRequestPlayer(nextPlayer, player) then
        sendTM(player, "You have accepted %s request for sex.", nextPlayer:getName())
        executeSex(player, nextPlayer)
        return false
    end

    local playerName = player:getName()
    sendTM(player, "You have sent a sex request to user %s.", nextPlayer:getName())
    local bountyMessage, condomMessage = "", ""
    if condom then condomMessage = " with condom" end
    if bounty > 0 then
        bountyMessage = string.format("If you agree to sex with %s, %d gold coins are added to your bank account,", playerName, bounty)
    end
    sendTM(nextPlayer, "%s has sent you a request for sex%s,%s you can accept it with the command !sexy", playerName, condomMessage, bountyMessage)
    return false
end

talkAction:separator(" ")
talkAction:register()