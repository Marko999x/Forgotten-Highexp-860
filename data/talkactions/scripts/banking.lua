function onSay(player, words, param)
    if words == "!balance" then
        player:popupFYI("[Balance]: "..player:getBankBalance())
        return false
    
    elseif words == "!deposit" then
        if not param then
            player:sendCancelMessage("Usage: !deposit all / !deposit amount")
            return false
        end
        
        if param == "all" then
            local amount = player:getMoney()
            
            if not amount then
                player:sendCancelMessage("You do not have any gold to deposit.")
                return false
            end
            
            player:removeMoney(amount)
            local oldBalance = player:getBankBalance()
            player:setBankBalance(player:getBankBalance() + amount)
            player:popupFYI("[Old Balance]: "..oldBalance.."\n[New Balance]: "..player:getBankBalance())
            return false
        else
            local amount = tonumber(param)
            
            if amount < 0 or amount > 100000000 then
                player:sendCancelMessage("You can only deposit 1-100kk gold at a time.")
                return false
            end
			
			function Player.deposit(self, amount)
				if not self:removeMoney(amount) then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[BankSystem]: You dont have money with you.")
					return false
				end
				self:setBankBalance(self:getBankBalance() + amount)
				return true
			end
            
            if not player:removeMoney(amount) then
                player:sendCancelMessage("You do not have that much gold.")
                return false
            end
            
            local oldBalance = player:getBankBalance()
            player:setBankBalance(player:getBankBalance() + amount)
            player:popupFYI("[Old Balance]: "..oldBalance.."\n[New Balance]: "..player:getBankBalance())
            return false
        end
        
        
        
        
    end
    return false
end