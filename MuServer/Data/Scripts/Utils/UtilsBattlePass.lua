UtilsBattlePass = {}

local packetUtilsNumber = 0x77
local packetUtilsNameEnter = "UtilsEnter_%s"
local packetUtilsNameBack = "UtilsBack_%s"

local names_vip = {}
names_vip[0] = "Free"
names_vip[1] = "Bronze"
names_vip[2] = "Silver"
names_vip[3] = "Gold"

function UtilsBattlePass.Init()
    GameServerFunctions.EnterCharacter(UtilsBattlePass.EnterCharacter)
    GameServerFunctions.PlayerLogout(UtilsBattlePass.LogoutCharacter)
end

function UtilsBattlePass.EnterCharacter(aIndex, makeLevel)
    local player = User.new(aIndex)
	local pNameEnter = string.format(packetUtilsNameEnter, player:getName())
    
    local vip = player:getVip()
    local vipName = names_vip[player:getVip()]
    local vipNameSize = string.len(names_vip[player:getVip()])
    local battlePassActive = DataBase.GetValue("BattlePass", "premiumPass", "memb___id", player:getAccountID())
    local expPass = DataBase.GetValue("BattlePass", "xpPass", "memb___id", player:getAccountID())
    local levelPass = DataBase.GetValue("BattlePass", "levelFree", "memb___id", player:getAccountID())

    CreatePacket(pNameEnter, packetUtilsNumber)

    SetBytePacket(pNameEnter, vip)
    SetBytePacket(pNameEnter, vipNameSize)
    SetCharPacketLength(pNameEnter, vipName, vipNameSize)
    SetDwordPacket(pNameEnter, expPass)
    SetBytePacket(pNameEnter, battlePassActive)
    SetBytePacket(pNameEnter, levelPass)

    SendPacket(pNameEnter, aIndex)

    ClearPacket(pNameEnter)

    if makeLevel then
        UtilsBattlePass.CheckLevelAndMakePremio(aIndex, expPass, levelPass)
    end
end

function UtilsBattlePass.LogoutCharacter(aIndex)
    local player = User.new(aIndex)
	local pNameBack = string.format(packetUtilsNameBack, player:getName())

    CreatePacket(pNameBack, packetUtilsNumber)
    SendPacket(pNameBack, aIndex)
    ClearPacket(pNameBack)
end

function UtilsBattlePass.AddExpPlayer(aIndexPlayer, value)
    local player = User.new(aIndexPlayer)
    
    DataBase.SetAddValue('BattlePass', 'xpPass', value, 'memb___id', player:getAccountID())
    
    UtilsBattlePass.EnterCharacter(aIndexPlayer, true)
end

function UtilsBattlePass.CreateItem(Account, Item, Itemlevel, iOp1, iOp2, iOp3, iExc, iAncient, iJoH, iSockCount, iSock1, iSock2, iSock3, iSock4, iSock5, DaysExpire, ItemTimeExpire)
	if ItemTimeExpire == nil then
		ItemTimeExpire = 0
	end

    if DaysExpire == nil then
        DaysExpire = 0
    end

	local query = string.format("INSERT INTO [dbo].[NPC_RESCUE_ITENS] ([Account],[ItemIndex],[Level],[Option1],[Option2],[Option3],[Exc],[Ancient],[JoH],[SockBonus],[Sock1],[Sock2],[Sock3],[Sock4],[Sock5],[Delivered],[ItemTimeExpire],[TimeExpire]) VALUES ('%s',%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,0,%d,DATEADD(day,%d,GETDATE()))", Account, Item, Itemlevel, iOp1, iOp2, iOp3, iExc, iAncient, iJoH, iSockCount, iSock1, iSock2, iSock3, iSock4, iSock5, ItemTimeExpire, DaysExpire)

	CreateAsyncQuery('NpcRescueInsertItem', query, -1, 0)
end

function UtilsBattlePass.CheckLevelAndMakePremio(aIndex, expPass, currentLevel)
    for index in ipairs(battlePass_configXPFromLevel) do
        local item = battlePass_configXPFromLevel[index]
        local exp = item.xpLevelPass
        local level = item.level
        
        if expPass >= exp then
            if level > currentLevel then
                UtilsBattlePass.MakeItemByLevel(aIndex, level)
            end
        end
    end
end

function UtilsBattlePass.MakeItemByLevel(aIndex, level)
    local player = User.new(aIndex)
    local login = player:getAccountID()
    local premium = DataBase.GetValue("BattlePass", "premiumPass", "memb___id", login)

    local freePassItem = battlePass_configItensDetailFree[level]
    local premiumPassItem = battlePass_configItensDetailPremium[level]

    DataBase.SetValue("BattlePass", "levelFree", level, "memb___id", login)
    if premium == 1 then
        DataBase.SetValue("BattlePass", "levelPremium", level, "memb___id", login)
    end

    if freePassItem ~= nil then 
        local item = freePassItem
        for _ = 1, item.Count do
            UtilsBattlePass.CreateItem(login, item.ItemIndex, item.Level, item.Op1, item.Op2, item.Life, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, item.DaysExpire, item.ItemTime)
        end
        SendMessage('[Passe Free] Você tem itens para retirar, vá até o Guardião de Brindes', aIndex, 1)
    end

    if premium == 1 then
        local item = premiumPassItem
        if premiumPassItem ~= nil then
            for _ = 1, item.Count do
                UtilsBattlePass.CreateItem(login, item.ItemIndex, item.Level, item.Op1, item.Op2, item.Life, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, item.DaysExpire, item.ItemTime)
            end
            SendMessage('[Passe Premium] Você tem itens para retirar, vá até o Guardião de Brindes', aIndex, 1)
        end
    end
    
    UtilsBattlePass.EnterCharacter(aIndex, false)
end

function UtilsBattlePass.MakeItemByLevelWithPremium(aIndex)
    local player = User.new(aIndex)
    local login = player:getAccountID()
    
    local levelFree = DataBase.GetValue("BattlePass", "levelFree", "memb___id", player:getAccountID())
    
    if levelFree > 0 then 
        for level = 1, levelFree do 
            local premiumPassItem = battlePass_configItensDetailPremium[level]
            local item = premiumPassItem
            if premiumPassItem ~= nil then
				for _ = 1, item.Count do
					UtilsBattlePass.CreateItem(login, item.ItemIndex, item.Level, item.Op1, item.Op2, item.Life, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, item.DaysExpire, item.ItemTime)
				end
            end
    
            DataBase.SetValue("BattlePass", "levelPremium", level, "memb___id", login)
        end
    
        SendMessage('[Passe Premium] Você adquiriu o passe premium, os itens dos demais level', aIndex, 1)
        SendMessage('[Passe Premium] Já estão no NPC Rescue', aIndex, 1)
        
        UtilsBattlePass.EnterCharacter(aIndex, false)
    end
end

UtilsBattlePass.Init()

return UtilsBattlePass