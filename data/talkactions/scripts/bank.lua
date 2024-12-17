function Player.deposit(self, amount)
    if not self:removeMoney(amount) then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You dont have money with you.")
        return false
    end
    self:setBankBalance(self:getBankBalance() + amount)
    return true
end
function Player.withdraw(self, amount)
    local balance = self:getBankBalance()
    if amount > balance or not self:addMoney(amount) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You dont have money in your bank account.")
        return false
    end
    self:setBankBalance(balance - amount)
    return true
end
function Player.depositMoney(self, amount)
    if not self:removeMoney(amount) then
        return false
    end
    self:setBankBalance(self:getBankBalance() + amount)
    return true
end
function onSay(player, words, param)
    local split = param:split(",")
    local balance = player:getBankBalance()
    if split[1] == nil then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: the commands are:\n !bank balance.n !bank withdraw, XXXX.\n !bank deposit, XXXX.\n!bank depositall.\n!bank transfer, amount, toPlayer.")
        return
    end
    --------------------------- Balance ---------------------------
    if split[1] == 'balance' then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: Your account balance is " .. balance .. ".")
    --------------------------- Deposit ---------------------------
    elseif split[1] == 'deposit' then
        local amount = tonumber(split[2])
        if not amount then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You need to put the amount of money to add.")
            return false
        end
        local amount = math.abs(amount)
        if amount > 0 and amount <= player:getMoney() then
            player:deposit(amount)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You added " .. amount .. " to your account, You can withdraw your money anytime you want to.\nYour account balance is " .. player:getBankBalance() .. ".")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You do not have enough money to deposit.")
        end
    --------------------------- Depositall ---------------------------
    elseif split[1] == 'depositall' then
        local amount = player:getMoney()
        local amount = math.abs(amount)
        if amount > 0 and amount == player:getMoney() then
            player:deposit(amount)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You added " .. amount .. " to your account, You can withdraw your money anytime you want to.\nYour account balance is " .. player:getBankBalance() .. ".")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You do not have enough money to deposit.")
        end
    --------------------------- Withdraw ---------------------------
    elseif split[1] == 'withdraw' then
        local amount = tonumber(split[2])
        if not amount then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You need to put the amount of money to withdraw.")
            return false
        end
        local amount = math.abs(amount)
        if amount > 0 and amount <= player:getBankBalance() then
            player:withdraw(amount)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: Here you are " .. amount .. " of your account, You can deposit your money anytime you want.\nYour account balance is " .. player:getBankBalance() .. ".")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You do not have enough money on your bank account.")
        end
    --------------------------- Withdrawall ---------------------------
    elseif split[1] == 'withdrawall' then
        local amount = player:getBankBalance()
        local amount = math.abs(amount)
        if amount > 0 and amount <= player:getBankBalance() then
            player:withdraw(amount)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: Here you are all your money on your account, You can deposit your money anytime you want.\nYour account balance is " .. player:getBankBalance() .. ".")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You do not have enough money on your bank account.")
        end
    --------------------------- Transfer ---------------------------
    elseif split[1] == 'transfer' then
        local data = param
        local s = data:split(", ")
        if s[2] == nil then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You need to put the amount of money")
            return false
        else
            if not tonumber(s[2]) then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You need to put the amount in numbers only.")
                return
            end
        end
        if s[3] == nill then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You need to put the player name")
            return false
        end
        local a = tonumber(s[2])
        local amount = math.abs(a)
        local getPlayer = Player(s[3])
        if getPlayer then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You seccesfully transferred " .. s[2] .. "\n to " .. s[3] .. " bank account.")
            player:transferMoneyTo(s[3], amount)
        else
            if not playerExists(s[3]) then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: A player with name: " .. s[3] .. " does not exists.")
                return false
            end
            if playerExists(s[3]) and player:transferMoneyTo(s[3], amount) then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You seccesfully transferred " .. s[2] .. "\n to " .. s[3] .. " bank account.")
            end
        end
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: Invalid param.")
    end
    return false
end