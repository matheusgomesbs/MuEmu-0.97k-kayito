CVC = {}

function CVC.Init()

    if CVC_Config.Enabled then
        Commands.Register(CVC_Config.Command["Eng"].Open, CVC.CommandOpen)
        Commands.Register(CVC_Config.Command["Por"].Open, CVC.CommandOpen)
        Commands.Register(CVC_Config.Command["Spn"].Open, CVC.CommandOpen)
        Commands.Register(CVC_Config.Command["Eng"].Go, CVC.CommandGo)
        Commands.Register(CVC_Config.Command["Por"].Go, CVC.CommandGo)
        Commands.Register(CVC_Config.Command["Spn"].Go, CVC.CommandGo)
        Commands.Register(CVC_Config.Command["Eng"].Cancel, CVC.CommandCancel)
        Commands.Register(CVC_Config.Command["Por"].Cancel, CVC.CommandCancel)
        Commands.Register(CVC_Config.Command["Spn"].Cancel, CVC.CommandCancel)
        GameServerFunctions.PlayerLogout(CVC.PlayerLogout)
        GameServerFunctions.PlayerDie(CVC.PlayerDie)
        GameServerFunctions.PlayerAttack(CVC.PlayerAttack)
        CVC.Define()

        for i in ipairs(CVC_Config.Cron) do
            if CVC_Config.Cron[i].DayOfWeek ~= -1 then
                Schedule.SetDayOfWeek(CVC_Config.Cron[i].DayOfWeek, CVC_Config.Cron[i].Hour, CVC_Config.Cron[i].Minute, CVC.AutoStart)
            elseif CVC_Config.Cron[i].DayOfMonth ~= -1 then
                Schedule.SetDayAndHourAndMinute(CVC_Config.Cron[i].DayOfMonth, CVC_Config.Cron[i].Hour, CVC_Config.Cron[i].Minute, CVC.AutoStart)
            else
                Schedule.SetHourAndMinute(CVC_Config.Cron[i].Hour, CVC_Config.Cron[i].Minute, CVC.AutoStart)
            end
        end
    end
end

function CVC.AutoStart()
    if CVC_Config.TimeAnnounce > 0 then
        CVC.Counter.Announce = CVC_Config.TimeAnnounce
        CVC.Timer.Announce = Timer.Repeater(60, CVC_Config.TimeAnnounce, CVC.Announce)
    else
        if CVC.Status.Running then
            CVC.Define()
            return
        end
        
        CVC.Counter.Open = CVC_Config.TimeOpen
    
        CVC.Status.Running = true
        CVC.Status.Open = true
    
        Message.SendMessageGlobalMultLang(CVC_Config.Message, 3, 1)
        Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
        CVC.Timer.Open = Timer.Repeater(1, CVC_Config.TimeOpen, CVC.AnnounceEventOpen)
    end
end

function CVC.Announce()
    if CVC.Counter.Announce <= 0 then
        CVC.Timer.Announce = -1
        if CVC.Status.Running then
            CVC.Define()
            return
        end
        
        CVC.Counter.Open = CVC_Config.TimeOpen
    
        CVC.Status.Running = true
        CVC.Status.Open = true
    
        Message.SendMessageGlobalMultLang(CVC_Config.Message, 3, 1)
        Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
        CVC.Timer.Open = Timer.Repeater(1, CVC_Config.TimeOpen, CVC.AnnounceEventOpen)
    else
        Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 21, 0, CVC.Counter.Announce)
        CVC.Counter.Announce = CVC.Counter.Announce - 1
    end
end

function CVC.Define()
    CVC.Participantes = {}

    CVC.Counter = {
        Open = 0,
        Announce = 0,
    }
    CVC.Timer = {
        Open = -1,
        CheckArea = -1,
        Finish = -1,
        Announce = -1

    }
    CVC.Status = {
        Running = false,
        Open = false,
        Started = false
    }
end

function CVC.CommandOpen(aIndex, Arguments)
    local player = User.new(aIndex)

    if player:getAuthority() <= 1 then return end

    local lang = player:getLanguage()

    if CVC.Status.Running then
        SendMessage(string.format(CVC_Config.Message[lang][1], CVC_Config.Command[lang].Cancel), aIndex, 1)
        return
    end

    local t = command:getNumber(Arguments, 1)

    if t == nil or t < 5 then
        SendMessage(string.format(CVC_Config.Message[lang][2], CVC_Config.Command[lang].Open), aIndex, 1)
        return
    end
    
    CVC.Counter.Open = t

    CVC.Status.Running = true
    CVC.Status.Open = true
    CVC.Timer.CheckArea = Timer.Interval(1, CVC.CheckArea)
    Message.SendMessageGlobalMultLang(CVC_Config.Message, 3, 1)
    Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
    CVC.Timer.Open = Timer.Repeater(1, t, CVC.AnnounceEventOpen)

    Teleport(aIndex, CVC_Config.Area.Watch.Map, CVC_Config.Area.Watch.X, CVC_Config.Area.Watch.Y)
end

function CVC.CommandCancel(aIndex)
    local player = User.new(aIndex)

    if player:getAuthority()  <= 1 then return end

    local lang = player:getLanguage()

    if not CVC.Status.Running then
        SendMessage(string.format(CVC_Config.Message[lang][7], CVC_Config.Command[lang].Open), aIndex, 1)
        return
    end

    CVC.EventCancel()
end

function CVC.AnnounceEventOpen()
    if CVC.Counter.Open <= 0 then
        CVC.Status.Open = false
        CVC.Timer.Open = -1

        if CVC.CountPlayers() < 2 then
            CVC.EventCancel()
            return
        end

        Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
        Message.SendMessageGlobalMultLang(CVC_Config.Message, 13, 0)
        SendMessageGlobal("", 0)
        Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 22, 0, CVC_Config.TimePrep)
        SendMessageGlobal("", 0)
        Message.SendMessageGlobalMultLang(CVC_Config.Message, 13, 0)
        
        Timer.TimeOut(CVC_Config.TimePrep*60, CVC.EventStart)
    else
        if CVC.Counter.Open > 1 then
            CVC.SendMessageOpen(5, CVC.Counter.Open)
        else
            CVC.SendMessageOpen(6, CVC.Counter.Open)
        end
        CVC.Counter.Open = CVC.Counter.Open - 1
    end
end

function CVC.SendMessageOpen(key, t)
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
        local lang = GetLanguageObject(i)
		SendMessagePlayer(i, 0, string.format(CVC_Config.Message[lang][key], CVC_Config.Command[lang].Go, t))
		
		::continue::
	end
	
	collectgarbage()
end

function CVC.EventCancel()
    CVC.Status.Running = false

    if CVC.Timer.Announce ~= -1 then
        Timer.Cancel(CVC.Timer.Announce)
    end

    if CVC.Timer.Open ~= -1 then
        Timer.Cancel(CVC.Timer.Open)
    end

    if CVC.Timer.Finish ~= -1 then
        Timer.Cancel(CVC.Timer.Finish)
    end

    if CVC.Timer.CheckArea ~= -1 then
        Timer.Cancel(CVC.Timer.CheckArea)
    end

    for i in ipairs(CVC.Participantes) do
        if CVC.Participantes[i].Active then            
            local player = User.new(CVC.Participantes[i].Info[2])
            local pInv = Inventory.new(CVC.Participantes[i].Info[2])
            for slot = 0, 139 do
                if pInv:isItem(slot) ~= 0 then
                    InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                    SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                end
            end
        
            for slot = 204, 235 do
                if pInv:isItem(slot) ~= 0 then
                    InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                    SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                end
            end
            ItemListSend(CVC.Participantes[i].Info[2])

            if CVC_Config.LevelUpPoints ~= -1 then
                player:setStrength(CVC.Participantes[i].Points.Str)
                player:setDexterity(CVC.Participantes[i].Points.Agi)
                player:setVitality(CVC.Participantes[i].Points.Vit)
                player:setEnergy(CVC.Participantes[i].Points.Ene)
                player:setLeaderShip(CVC.Participantes[i].Points.Cmd)
                player:setLevelUpPoint(CVC.Participantes[i].Points.LevelUp)
                LevelUpSend(CVC.Participantes[i].Info[2])
                RefreshCharacter(CVC.Participantes[i].Info[2])
                CalCharacter(CVC.Participantes[i].Info[2])
            end
    
            if CVC_Config.MasterSkillPoints ~= -1 then
                player:setMasterPoint(CVC.Participantes[i].Points.MPoints)
                player:setMasterLevel(CVC.Participantes[i].Points.MLevel)
                gObjRebuildMasterSkillTree(CVC.Participantes[i].Info[2])
                MasterLevelInfoSend(CVC.Participantes[i].Info[2])
                RefreshCharacter(CVC.Participantes[i].Info[2])
                CalCharacter(CVC.Participantes[i].Info[2])
            end
            Teleport(CVC.Participantes[i].Info[2], 0, 125, 125)
        end
    end

    Message.SendMessageGlobalMultLang(CVC_Config.Message, 8, 1)
    Message.SendMessageGlobalMultLang(CVC_Config.Message, 8, 0)

    CVC.Define()
end

function CVC.EventStart()
    if CVC.CountPlayers() < 2 then
        CVC.EventCancel()
        return
    end

    Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
    Message.SendMessageGlobalMultLang(CVC_Config.Message, 13, 0)
    SendMessageGlobal("", 0)
    Message.SendMessageGlobalMultLang(CVC_Config.Message, 14, 0)
    SendMessageGlobal("", 0)
    Message.SendMessageGlobalMultLang(CVC_Config.Message, 13, 0)

    CVC.Status.Started = true
end

function CVC.CommandGo(aIndex)
    local player = User.new(aIndex)
    local playerInfo = {[0] = player:getAccountID(), [1] = player:getName(), [2] = aIndex, [3] = player:getLanguage()}
    local pInv = Inventory.new(aIndex)

    if not CVC.Status.Open then
        SendMessage(CVC_Config.Message[playerInfo[3]][9], aIndex, 1)
        return
    end

   if player:getAuthority() > 1 then return end

    for i = 0, 139 do
		if pInv:isItem(i) ~= 0 then
            SendMessage(CVC_Config.Message[playerInfo[3]][11], aIndex, 1)
            return
		end
	end

	for i = 204, 235 do
		if pInv:isItem(i) ~= 0 then
            SendMessage(CVC_Config.Message[playerInfo[3]][12], aIndex, 1)
            return
		end
	end

    Teleport(aIndex, CVC_Config.Area.Spawn.Map, CVC_Config.Area.Spawn.X, CVC_Config.Area.Spawn.Y)
    
    if not CVC.CheckIfIsPlayer(playerInfo[1]) then
		local str = player:getStrength()
		local agi = player:getDexterity()
		local vit = player:getVitality()
		local ene = player:getEnergy()
		local cmd = player:getLeaderShip()
		local points = player:getLevelUpPoint()
		local mpoints = player:getMasterPoint()
        local mlevel = player:getMasterLevel()

        if CVC_Config.LevelUpPoints ~= -1 then
            player:setStrength(0)
			player:setDexterity(0)
			player:setVitality(0)
			player:setEnergy(0)
			player:setLeaderShip(0)
			player:setLevelUpPoint(CVC_Config.LevelUpPoints)
			LevelUpSend(aIndex)
			RefreshCharacter(aIndex)
			CalCharacter(aIndex)
		end

		if CVC_Config.MasterSkillPoints ~= -1 then
			player:setMasterPoint(CVC_Config.MasterSkillPoints)
			player:setMasterLevel(CVC_Config.MasterSkillPoints)
			gObjRebuildMasterSkillTree(aIndex)
			MasterLevelInfoSend(aIndex)
			RefreshCharacter(aIndex)
			CalCharacter(aIndex)
		end

        local playerPoints = {Str = str, Agi = agi, Vit = vit, Ene = ene, Cmd = cmd, LevelUp = points, MLevel = mlevel, MPoints = mpoints}
        
        local temp = {Active = true, Kills = 0, Info = playerInfo, Points = playerPoints}
        table.insert(CVC.Participantes, temp)
    end

    local class = player:getClass()
    
    if CVC_Config.Itens[class] ~= nil then
        for i in ipairs(CVC_Config.Itens[class]) do
            local item = CVC_Config.Itens[class][i]
            CreateItemInventory(aIndex, GET_ITEM(item.Section, item.Index), item.Level, item.Skill, item.Luck, item.Option, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, 0)
        end
    end

    SendMessage(CVC_Config.Message[playerInfo[3]][10], aIndex, 1)
end

function CVC.CheckArea()
    if CVC.Status.Running then
        for i in ipairs(CVC.Participantes) do
            if CVC.Participantes[i].Active then
                local player = User.new(CVC.Participantes[i].Info[2])
                local map = player:getMapNumber()
                local x = player:getX()
                local y = player:getY()

                if map == CVC_Config.Area.Total.Map then
                    if x >= CVC_Config.Area.Total.X1 and x <= CVC_Config.Area.Total.X2 then
                        if y >= CVC_Config.Area.Total.Y1 and y <= CVC_Config.Area.Total.Y2 then
                            goto continue
                        end
                    end
                end

                CVC.Participantes[i].Active = false

                local pInv = Inventory.new(CVC.Participantes[i].Info[2])
                for slot = 0, 139 do
                    if pInv:isItem(slot) ~= 0 then
                        InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                        SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                    end
                end
            
                for slot = 204, 235 do
                    if pInv:isItem(slot) ~= 0 then
                        InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                        SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                    end
                end
                ItemListSend(CVC.Participantes[i].Info[2])

                if CVC_Config.LevelUpPoints ~= -1 then
                    player:setStrength(CVC.Participantes[i].Points.Str)
                    player:setDexterity(CVC.Participantes[i].Points.Agi)
                    player:setVitality(CVC.Participantes[i].Points.Vit)
                    player:setEnergy(CVC.Participantes[i].Points.Ene)
                    player:setLeaderShip(CVC.Participantes[i].Points.Cmd)
                    player:setLevelUpPoint(CVC.Participantes[i].Points.LevelUp)
                    LevelUpSend(CVC.Participantes[i].Info[2])
                    RefreshCharacter(CVC.Participantes[i].Info[2])
                    CalCharacter(CVC.Participantes[i].Info[2])
                end
            
                if CVC_Config.MasterSkillPoints ~= -1 then
                    player:setMasterPoint(CVC.Participantes[i].Points.MPoints)
                    player:setMasterLevel(CVC.Participantes[i].Points.MLevel)
                    gObjRebuildMasterSkillTree(CVC.Participantes[i].Info[2])
                    MasterLevelInfoSend(CVC.Participantes[i].Info[2])
                    RefreshCharacter(CVC.Participantes[i].Info[2])
                    CalCharacter(CVC.Participantes[i].Info[2])
                end
                ItemListSend(CVC.Participantes[i].Info[2])
                Teleport(CVC.Participantes[i].Info[2], 0, 125, 125)

                SendMessage(CVC_Config.Message[CVC.Participantes[i].Info[3]][15], CVC.Participantes[i].Info[2], 1)
                
                if CVC.CountPlayers() < 2 then
                    if not CVC.Status.Open then
                        if CVC.Status.Started then
                            for g in ipairs(CVC.Participantes) do
                                if CVC.Participantes[g].Active then
                                    Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
                                    SendMessageGlobal("", 0)
                                    Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 18, 0, player:getName())
                                    Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 17, 0, CVC.Participantes[g].Kills)
                                    SendMessageGlobal("", 0)
                                    Message.SendMessageGlobalMultLang(CVC_Config.Message, 13, 0)

                                    CVC.RewardPlayer(CVC.Participantes[g].Info, CVC.Participantes[g].Points)
                                end
                            end

                            CVC.FinishEvent()
                        else
                            CVC.EventCancel()
                        end
                    end
                end
            end

            ::continue::
        end
    end
end

function CVC.CheckIfIsPlayer(Name)
    if #CVC.Participantes == 0 then return false end

    for i in ipairs(CVC.Participantes) do
        if CVC.Participantes[i].Active then
            if CVC.Participantes[i].Info[1] == Name then
                return true
            end
        end
    end

    return false
end

function CVC.PlayerLogout(aIndex)
    if CVC.Status.Running then
        for i in ipairs(CVC.Participantes) do
            if CVC.Participantes[i].Active then
                if CVC.Participantes[i].Info[2] == aIndex then
                    local player = User.new(aIndex)
                    CVC.Participantes[i].Active = false

                    local pInv = Inventory.new(CVC.Participantes[i].Info[2])
                    for slot = 0, 139 do
                        if pInv:isItem(slot) ~= 0 then
                            InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                            SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                        end
                    end
                
                    for slot = 204, 235 do
                        if pInv:isItem(slot) ~= 0 then
                            InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                            SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                        end
                    end
                    ItemListSend(CVC.Participantes[i].Info[2])
                
                    if CVC_Config.LevelUpPoints ~= -1 then
                        player:setStrength(CVC.Participantes[i].Points.Str)
                        player:setDexterity(CVC.Participantes[i].Points.Agi)
                        player:setVitality(CVC.Participantes[i].Points.Vit)
                        player:setEnergy(CVC.Participantes[i].Points.Ene)
                        player:setLeaderShip(CVC.Participantes[i].Points.Cmd)
                        player:setLevelUpPoint(CVC.Participantes[i].Points.LevelUp)
                        LevelUpSend(CVC.Participantes[i].Info[2])
                        RefreshCharacter(CVC.Participantes[i].Info[2])
                        CalCharacter(CVC.Participantes[i].Info[2])
                    end
                
                    if CVC_Config.MasterSkillPoints ~= -1 then
                        player:setMasterPoint(CVC.Participantes[i].Points.MPoints)
                        player:setMasterLevel(CVC.Participantes[i].Points.MLevel)
                        gObjRebuildMasterSkillTree(CVC.Participantes[i].Info[2])
                        MasterLevelInfoSend(CVC.Participantes[i].Info[2])
                        RefreshCharacter(CVC.Participantes[i].Info[2])
                        CalCharacter(CVC.Participantes[i].Info[2])
                    end
                    Teleport(CVC.Participantes[i].Info[2], 0, 125, 125)

                    if CVC.CountPlayers() < 2 then
                        if not CVC.Status.Open then
                            if CVC.Status.Started then
                                for g in ipairs(CVC.Participantes) do
                                    if CVC.Participantes[g].Active then
                                        Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
                                        SendMessageGlobal("", 0)
                                        Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 18, 0, player:getName())
                                        Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 17, 0, CVC.Participantes[g].Kills)
                                        SendMessageGlobal("", 0)
                                        Message.SendMessageGlobalMultLang(CVC_Config.Message, 13, 0)
    
                                        CVC.RewardPlayer(CVC.Participantes[g].Info, CVC.Participantes[g].Points)
                                    end
                                end
    
                                CVC.FinishEvent()
                            else
                                CVC.EventCancel()
                            end
                        end
                    end
                end
            end
        end
    end
end

function CVC.RewardPlayer(playerInfo, playerPoints)
    local player = User.new(playerInfo[2])

    local pInv = Inventory.new(playerInfo[2])
    for slot = 0, 139 do
        if pInv:isItem(slot) ~= 0 then
            InventoryDeleteItem(playerInfo[2], slot)
            SendInventoryDeleteItem(playerInfo[2], slot)
        end
    end
        
    for slot = 204, 235 do
        if pInv:isItem(slot) ~= 0 then
            InventoryDeleteItem(playerInfo[2], slot)
            SendInventoryDeleteItem(playerInfo[2], slot)
        end
    end
    ItemListSend(playerInfo[2])

    if CVC_Config.LevelUpPoints ~= -1 then
        player:setStrength(playerPoints.Str)
        player:setDexterity(playerPoints.Agi)
        player:setVitality(playerPoints.Vit)
        player:setEnergy(playerPoints.Ene)
        player:setLeaderShip(playerPoints.Cmd)
        player:setLevelUpPoint(playerPoints.LevelUp)
        LevelUpSend(playerInfo[2])
        RefreshCharacter(playerInfo[2])
        CalCharacter(playerInfo[2])
    end

    if CVC_Config.MasterSkillPoints ~= -1 then
        player:setMasterPoint(playerPoints.MPoints)
        player:setMasterLevel(playerPoints.MLevel)
        gObjRebuildMasterSkillTree(playerInfo[2])
        MasterLevelInfoSend(playerInfo[2])
        RefreshCharacter(playerInfo[2])
        CalCharacter(playerInfo[2])
    end

    if CVC_Config.PrizeItem ~= nil then
        for g in ipairs(CVC_Config.PrizeItem) do
            local item = CVC_Config.PrizeItem[g]
            CreateItemInventory(playerInfo[2], GET_ITEM(item.Section, item.Index), item.Level, item.Skill, item.Luck, item.Option, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, item.ItemTime)
        end
    end

    if CVC_Config.PrizeCoin ~= nil then
        for g in ipairs(CVC_Config.PrizeCoin) do
            local coin = CVC_Config.PrizeCoin[g]
            DataBase.SetAddValue(coin.Table, coin.Column, coin.Amount, coin.Where, playerInfo[coin.IdType])
            SendMessage(string.format(CVC_Config.Message[playerInfo[3]][19], coin.Amount, coin.Name), playerInfo[2], 1)
        end
    end

    if CVC_Config.PrizeZen ~= nil and CVC_Config.PrizeZen > 0 then
        player:setMoney(player:getMoney()+CVC_Config.PrizeZen)
        MoneySend(playerInfo[2])
        SendMessage(string.format(CVC_Config.Message[playerInfo[3]][19], CVC_Config.PrizeZen, "Zen"), playerInfo[2], 1)
    end

    ItemListSend(playerInfo[2])

    Teleport(playerInfo[2], 0, 125, 125)
end

function CVC.PlayerAttack(aIndex, bIndex)
    if CVC.Status.Running then
        if not CVC.Status.Started then
            local player = User.new(aIndex)
            local player2 = User.new(bIndex)

            if CVC.CheckIfIsPlayer(player:getName()) or CVC.CheckIfIsPlayer(player2:getName()) then
                SendMessage(CVC_Config.Message[player:getLanguage()][23], aIndex, 1)
                return 1
            end
        end
    end

    return 0
end

function CVC.PlayerDie(aIndex, bIndex)
    if CVC.Status.Running then
        if CVC.Status.Started then
            local player = User.new(aIndex)
            local player2 = User.new(bIndex)
            if CVC.CheckIfIsPlayer(player:getName()) and CVC.CheckIfIsPlayer(player2:getName()) then
                
                for i in ipairs(CVC.Participantes) do
                    if CVC.Participantes[i].Info[2] == aIndex then
                        CVC.Participantes[i].Kills = CVC.Participantes[i].Kills + 1
                    end

                    if CVC.Participantes[i].Info[2] == bIndex then
                        CVC.Participantes[i].Active = false
                        CVC.RemovePlayer(CVC.Participantes[i].Info, CVC.Participantes[i].Points)
                    end
                end

                Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 16, 0, player:getName(), player2:getName())
                
                if CVC.CountPlayers() == 1 then
                    for i in ipairs(CVC.Participantes) do
                        if CVC.Participantes[i].Active then
                            Message.SendMessageGlobalMultLang(CVC_Config.Message, 4, 0)
                            SendMessageGlobal("", 0)
                            Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 18, 0, player:getName())
                            Message.SendMessageGlobalMultLangArgs(CVC_Config.Message, 17, 0, CVC.Participantes[i].Kills)
                            SendMessageGlobal("", 0)
                            Message.SendMessageGlobalMultLang(CVC_Config.Message, 13, 0)

                            CVC.RewardPlayer(CVC.Participantes[i].Info, CVC.Participantes[i].Points)
                        end
                    end

                    CVC.FinishEvent()
                end
            end
        end
    end
end

function CVC.RemovePlayer(playerInfo, playerPoints)
    local player = User.new(playerInfo[2])

    local pInv = Inventory.new(playerInfo[2])
    for slot = 0, 139 do
        if pInv:isItem(slot) ~= 0 then
            InventoryDeleteItem(playerInfo[2], slot)
            SendInventoryDeleteItem(playerInfo[2], slot)
        end
    end

    for slot = 204, 235 do
        if pInv:isItem(slot) ~= 0 then
            InventoryDeleteItem(playerInfo[2], slot)
            SendInventoryDeleteItem(playerInfo[2], slot)
        end
    end
    ItemListSend(playerInfo[2])

    if CVC_Config.LevelUpPoints ~= -1 then
        player:setStrength(playerPoints.Str)
        player:setDexterity(playerPoints.Agi)
        player:setVitality(playerPoints.Vit)
        player:setEnergy(playerPoints.Ene)
        player:setLeaderShip(playerPoints.Cmd)
        player:setLevelUpPoint(playerPoints.LevelUp)
        LevelUpSend(playerInfo[2])
        RefreshCharacter(playerInfo[2])
        CalCharacter(playerInfo[2])
    end

    if CVC_Config.MasterSkillPoints ~= -1 then
        player:setMasterPoint(playerPoints.MPoints)
        player:setMasterLevel(playerPoints.MLevel)
        gObjRebuildMasterSkillTree(playerInfo[2])
        MasterLevelInfoSend(playerInfo[2])
        RefreshCharacter(playerInfo[2])
        CalCharacter(playerInfo[2])
    end
    ItemListSend(playerInfo[2])
    Teleport(playerInfo[2], 0, 125, 125)
end

function CVC.CountPlayers()
    local count = 0

    for i in ipairs(CVC.Participantes) do
        if CVC.Participantes[i].Active then
            count = count + 1
        end
    end

    return count

end

function CVC.FinishEvent()
    CVC.Status.Running = false

    if CVC.Timer.Announce ~= -1 then
        Timer.Cancel(CVC.Timer.Announce)
    end

    if CVC.Timer.Open ~= -1 then
        Timer.Cancel(CVC.Timer.Open)
    end

    if CVC.Timer.Finish ~= -1 then
        Timer.Cancel(CVC.Timer.Finish)
    end

    if CVC.Timer.CheckArea ~= -1 then
        Timer.Cancel(CVC.Timer.CheckArea)
    end

    for i in ipairs(CVC.Participantes) do
        if CVC.Participantes[i].Active then
            local player = User.new(CVC.Participantes[i].Info[2])
            local pInv = Inventory.new(CVC.Participantes[i].Info[2])
            for slot = 0, 139 do
                if pInv:isItem(slot) ~= 0 then
                    InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                    SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                end
            end
        
            for slot = 204, 235 do
                if pInv:isItem(slot) ~= 0 then
                    InventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                    SendInventoryDeleteItem(CVC.Participantes[i].Info[2], slot)
                end
            end
            ItemListSend(CVC.Participantes[i].Info[2])

            if CVC_Config.LevelUpPoints ~= -1 then
                player:setStrength(CVC.Participantes[i].Points.Str)
                player:setDexterity(CVC.Participantes[i].Points.Agi)
                player:setVitality(CVC.Participantes[i].Points.Vit)
                player:setEnergy(CVC.Participantes[i].Points.Ene)
                player:setLeaderShip(CVC.Participantes[i].Points.Cmd)
                player:setLevelUpPoint(CVC.Participantes[i].Points.LevelUp)
                LevelUpSend(CVC.Participantes[i].Info[2])
                RefreshCharacter(CVC.Participantes[i].Info[2])
                CalCharacter(CVC.Participantes[i].Info[2])
            end
    
            if CVC_Config.MasterSkillPoints ~= -1 then
                player:setMasterPoint(CVC.Participantes[i].Points.MPoints)
                player:setMasterLevel(CVC.Participantes[i].Points.MLevel)
                gObjRebuildMasterSkillTree(CVC.Participantes[i].Info[2])
                MasterLevelInfoSend(CVC.Participantes[i].Info[2])
                RefreshCharacter(CVC.Participantes[i].Info[2])
                CalCharacter(CVC.Participantes[i].Info[2])
            end
            ItemListSend(CVC.Participantes[i].Info[2])
            Teleport(CVC.Participantes[i].Info[2], 0, 125, 125)
        end
    end

    Message.SendMessageGlobalMultLang(CVC_Config.Message, 20, 1)

    CVC.Define()
end

CVC.Init()

return CVC