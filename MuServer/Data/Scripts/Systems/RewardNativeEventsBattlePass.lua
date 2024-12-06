
RewardNativeEventsBattlePass = {}

local RewardNativBattlePassSwitch = true
local RewardNativBattlePassMessage = {}
RewardNativBattlePassMessage['Por'] = {
    [1] = '[Reward Event] Você recebeu %d de XP do Passe de Batalha',
}

RewardNativBattlePassMessage['Eng'] = {
    [1] = '[Reward Event] Você recebeu %d de XP do Passe de Batalha',
}

RewardNativBattlePassMessage['Spn'] = {
    [1] = '[Reward Event] Você recebeu %d de XP do Passe de Batalha',
}

--Type 1 = BC, 2 = CC, 3 = DS
local RewardNativeBattlePassEvent = {}
RewardNativeBattlePassEvent[1] = { --BC
    [0] = 100, --Free
    [1] = 100, --Vip 1
    [2] = 100, --Vip 2
}

RewardNativeBattlePassEvent[2] = { --CC
    [0] = 7, --Free
    [1] = 7, --Vip 1
    [2] = 7, --Vip 2
}

RewardNativeBattlePassEvent[3] = { --DS
    [0] = 7, --Free
    [1] = 7, --Vip 1
    [2] = 7, --Vip 2
}

function RewardNativeEventsBattlePass.Init()
    if RewardNativBattlePassSwitch then
        RewardNativeEventsBattlePass.Register()
    end
end

function RewardNativeEventsBattlePass.Register()
    GameServerFunctions.ReceiveEventReward(RewardNativeEventsBattlePass.ReceiveEventReward)
end

function RewardNativeEventsBattlePass.ReceiveEventReward(aIndex, EventType)
    local player = User.new(aIndex)
    local language = player:getLanguage()
    local accountType = player:getVip()

    local message = RewardNativBattlePassMessage[language]
    local event = RewardNativeBattlePassEvent[EventType]

    LogAddC(2, string.format("Evento %d", EventType))
    LogAddC(2, string.format("aIndex %d", aIndex))
    
    if event ~= nil then
        local eventRewardVip = event[accountType]
        if eventRewardVip ~= nil then
            UtilsBattlePass.AddExpPlayer(aIndex, eventRewardVip)
            SendMessage(string.format(message[1], eventRewardVip), aIndex, 1)
        else
            LogAddC(2, string.format("Tipo de conta %d não foi encontrado ou configurado", accountType))
        end
    else
        LogAddC(2, string.format("EventType %d não foi configurado", EventType))
    end
end

RewardNativeEventsBattlePass.Init()

return RewardNativeEventsBattlePass