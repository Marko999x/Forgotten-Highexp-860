local config = {
    ['Dragon'] = {effect = 10, text = 'You killed a dragon'},
    ['Demon'] = {effect = 10, text = 'You killed a dragon'}
}
    
local killMonster = CreatureEvent("effectOnKill")

function killMonster.onKill(creature, target)
    local monster = config[target:getName()]
    if monster then
        creature:sendTextMessage(MESSAGE_INFO_DESCR, monster.text)
        target:getPosition():sendMagicEffect(monster.effect)
    end
    return true
end

killMonster:type("kill")
killMonster:register()

local killMonsterLogin = CreatureEvent("killMonsterLogin")

function killMonsterLogin.onLogin(player)
    player:registerEvent("effectOnKill")
    return true
end

killMonsterLogin:register()