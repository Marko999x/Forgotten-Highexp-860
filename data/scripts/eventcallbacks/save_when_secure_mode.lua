local ec = EventCallback

ec.onTargetCombat = function(self, target)
	if self and self:isMonster() then
		return true
	end
    if self and self:hasSecureMode() then
		if target:isPlayer() then
			return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
		end
    end

    return RETURNVALUE_NOERROR
end

ec:register()