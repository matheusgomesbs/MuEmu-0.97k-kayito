Saldo = {}

Saldo.Moedas = {
    [1] = {Table = "MEMB_INFO",       Column = "cash",           Where = "memb___id", IdType = 0},
    [2] = {Table = "MEMB_INFO",       Column = "hpoints",        Where = "memb___id", IdType = 0},
    [3] = {Table = "MEMB_INFO",       Column = "jcpoints",       Where = "memb___id", IdType = 0},
    [4] = {Table = "MEMB_INFO",       Column = "DonatePoints",   Where = "memb___id", IdType = 0},
    [5] = {Table = "MEMB_INFO",       Column = "HorasOn",        Where = "memb___id", IdType = 0},
    [6] = {Table = "CashShopData",    Column = "WCoinP",         Where = "AccountID", IdType = 0},
}

function Saldo.Init()
    Commands.Register("/saldo",  Saldo.AtualizaSaldo)
end


function Saldo.GetSaldo(aIndex, idMoeda)
    local player = User.new(aIndex)
    local playerInfo = {[0] = player:getAccountID(), [1] = player:getName()}

    if Saldo.Moedas[idMoeda] == nil then
        return -1
    end

    local valor = DataBase.GetValue(Saldo.Moedas[idMoeda].Table, Saldo.Moedas[idMoeda].Column, Saldo.Moedas[idMoeda].Where, playerInfo[Saldo.Moedas[idMoeda].IdType])
    return valor
end

function Saldo.AtualizaSaldo(aIndex)
   
    local moeda1 = Saldo.GetSaldo(aIndex, 1)
    local moeda2 = Saldo.GetSaldo(aIndex, 2)
    local moeda3 = Saldo.GetSaldo(aIndex, 3)
    local moeda4 = Saldo.GetSaldo(aIndex, 4)
    local moeda5 = Saldo.GetSaldo(aIndex, 5)
    local moeda6 = Saldo.GetSaldo(aIndex, 6)

    local PacketName = "UpdateSaldo"
    CreatePacket(PacketName, 0x099)
    SetDwordPacket(PacketName, moeda1)
    SetDwordPacket(PacketName, moeda2)
    SetDwordPacket(PacketName, moeda3)
    SetDwordPacket(PacketName, moeda4)
    SetDwordPacket(PacketName, moeda5)
    SetDwordPacket(PacketName, moeda6)
    SendPacket(PacketName, aIndex)
    ClearPacket(PacketName)
end

Saldo.Init()

return Saldo