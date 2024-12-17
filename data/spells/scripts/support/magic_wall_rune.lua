local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_MAGICWALL)

function onCastSpell(creature, variant, isHotkey)
	customTimer(variant:getPosition(), 20, TEXTCOLOR_LIGHTGREEN)
	return combat:execute(creature, variant)
end
