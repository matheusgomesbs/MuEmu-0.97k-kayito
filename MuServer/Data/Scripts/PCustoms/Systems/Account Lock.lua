AccountLock = {}

function AccountLock.Init()
    if AccountLock_Config.Enabled then
        GameServerFunctions.PlayerDropItem(AccountLock.DropItem)
        GameServerFunctions.PlayerTradeOk(AccountLock.Trade)
        GameServerFunctions.PlayerTradeXOk(AccountLock.Trade)
        GameServerFunctions.PlayerOpenShop(AccountLock.Shop)
        GameServerFunctions.PlayerSellItem(AccountLock.Sell)
    end
end

function AccountLock.DropItem(aIndex)
    local player = User.new(aIndex)
    local acc = player:getAccountID()
    local lang = player:getLanguage()

    if AccountLock_Config.Accounts[acc] ~= nil then
        if not AccountLock_Config.Accounts[acc].Drop then
            SendMessage(AccountLock_Config.Message[lang][1], aIndex, 1)
            Timer.TimeOut(1, ItemListSend, aIndex)
            return 1
        end
    end

    return 0
end

function AccountLock.Sell(aIndex)
    local player = User.new(aIndex)
    local acc = player:getAccountID()
    local lang = player:getLanguage()

    if AccountLock_Config.Accounts[acc] ~= nil then
        if not AccountLock_Config.Accounts[acc].Sell then
            SendMessage(AccountLock_Config.Message[lang][1], aIndex, 1)
            Timer.TimeOut(1, ItemListSend, aIndex)
            return 1
        end
    end

    return 0
end

function AccountLock.Trade(aIndex, bIndex)
    local player = User.new(aIndex)
    local acc = player:getAccountID()
    local lang = player:getLanguage()

    local player2 = User.new(bIndex)
    local acc2 = player2:getAccountID()
    local lang2 = player2:getLanguage()

    if AccountLock_Config.Accounts[acc] ~= nil then
        if not AccountLock_Config.Accounts[acc].Trade then
            SendMessage(AccountLock_Config.Message[lang][1], aIndex, 1)
            return 1
        end
    end

    if AccountLock_Config.Accounts[acc2] ~= nil then
        if not AccountLock_Config.Accounts[acc2].Trade then
            SendMessage(AccountLock_Config.Message[lang2][1], bIndex, 1)
            return 1
        end
    end

    return 0
end

function AccountLock.Shop(aIndex)
    local player = User.new(aIndex)
    local acc = player:getAccountID()
    local lang = player:getLanguage()

    if AccountLock_Config.Accounts[acc] ~= nil then
        if not AccountLock_Config.Accounts[acc].Shop then
            SendMessage(AccountLock_Config.Message[lang][1], aIndex, 1)
            return 1
        end
    end

    return 0
end

AccountLock.Init()

return AccountLock