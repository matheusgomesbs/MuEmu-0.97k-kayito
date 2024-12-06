Race = {}

function Race.Init()

    if Race_Config.Enabled then
        Commands.Register(Race_Config.Command["Eng"].Open, Race.CommandOpen)
        Commands.Register(Race_Config.Command["Por"].Open, Race.CommandOpen)
        Commands.Register(Race_Config.Command["Spn"].Open, Race.CommandOpen)
        Commands.Register(Race_Config.Command["Eng"].Go, Race.CommandGo)
        Commands.Register(Race_Config.Command["Por"].Go, Race.CommandGo)
        Commands.Register(Race_Config.Command["Spn"].Go, Race.CommandGo)
        Commands.Register(Race_Config.Command["Eng"].Cancel, Race.CommandCancel)
        Commands.Register(Race_Config.Command["Por"].Cancel, Race.CommandCancel)
        Commands.Register(Race_Config.Command["Spn"].Cancel, Race.CommandCancel)
        GameServerFunctions.PlayerLogout(Race.PlayerLogout)
        GameServerFunctions.NpcTalk(Race.NpcTalk)
        GameServerFunctions.PlayerCanEquipItem(Race.EquipItem)
        Race.Define()

        for i in ipairs(Race_Config.Cron) do
            if Race_Config.Cron[i].DayOfWeek ~= -1 then
                Schedule.SetDayOfWeek(Race_Config.Cron[i].DayOfWeek, Race_Config.Cron[i].Hour, Race_Config.Cron[i].Minute, Race.AutoStart)
            elseif Race_Config.Cron[i].DayOfMonth ~= -1 then
                Schedule.SetDayAndHourAndMinute(Race_Config.Cron[i].DayOfMonth, Race_Config.Cron[i].Hour, Race_Config.Cron[i].Minute, Race.AutoStart)
            else
                Schedule.SetHourAndMinute(Race_Config.Cron[i].Hour, Race_Config.Cron[i].Minute, Race.AutoStart)
            end
        end
    end
end

function Race.AutoStart()
    if Race_Config.TimeAnnounce > 0 then
        Race.Counter.Announce = Race_Config.TimeAnnounce
        Race.Timer.Announce = Timer.Repeater(60, Race_Config.TimeAnnounce, Race.Announce)
    else
        if Race.Status.Running then
            Race.Define()
            return
        end
        
        Race.Counter.Open = Race_Config.TimeOpen
    
        Race.Status.Running = true
        Race.Status.Open = true
    
        Message.SendMessageGlobalMultLang(Race_Config.Message, 3, 1)
        Message.SendMessageGlobalMultLang(Race_Config.Message, 4, 0)
        Race.Timer.Open = Timer.Repeater(1, Race_Config.TimeOpen, Race.AnnounceEventOpen)
    end
end

function Race.Announce()
    if Race.Counter.Announce <= 0 then
        Race.Timer.Announce = -1
        if Race.Status.Running then
            Race.Define()
            return
        end
        
        Race.Counter.Open = Race_Config.TimeOpen
    
        Race.Status.Running = true
        Race.Status.Open = true
    
        Message.SendMessageGlobalMultLang(Race_Config.Message, 3, 1)
        Message.SendMessageGlobalMultLang(Race_Config.Message, 4, 0)
        Race.Timer.Open = Timer.Repeater(1, Race_Config.TimeOpen, Race.AnnounceEventOpen)
    else
        Message.SendMessageGlobalMultLangArgs(Race_Config.Message, 21, 0, Race.Counter.Announce)
        Race.Counter.Announce = Race.Counter.Announce - 1
    end
end

function Race.Define()
    Race.Participantes = {}

    Race.Npc = -1

    Race.Winners = 0

    Race.Counter = {
        Open = 0,
        Announce = 0,
    }
    Race.Timer = {
        Open = -1,
        CheckArea = -1,
        Finish = -1,
        Announce = -1

    }
    Race.Status = {
        Running = false,
        Open = false,
        AllowClickNpc = false
    }
end

function Race.CommandOpen(aIndex, Arguments)
    local player = User.new(aIndex)

    if player:getAuthority() <= 1 then return end

    local lang = player:getLanguage()

    if Race.Status.Running then
        SendMessage(string.format(Race_Config.Message[lang][1], Race_Config.Command[lang].Cancel), aIndex, 1)
        return
    end

    local t = command:getNumber(Arguments, 1)

    if t == nil or t < 5 then
        SendMessage(string.format(Race_Config.Message[lang][2], Race_Config.Command[lang].Open), aIndex, 1)
        return
    end
    
    Race.Counter.Open = t
    Race.Timer.CheckArea = Timer.Interval(1, Race.CheckArea)
    Race.Status.Running = true
    Race.Status.Open = true

    Message.SendMessageGlobalMultLang(Race_Config.Message, 3, 1)
    Message.SendMessageGlobalMultLang(Race_Config.Message, 4, 0)
    Race.Timer.Open = Timer.Repeater(1, t, Race.AnnounceEventOpen)
end

function Race.CommandCancel(aIndex)
    local player = User.new(aIndex)

    if player:getAuthority()  <= 1 then return end

    local lang = player:getLanguage()

    if not Race.Status.Running then
        SendMessage(string.format(Race_Config.Message[lang][7], Race_Config.Command[lang].Open), aIndex, 1)
        return
    end

    Race.EventCancel()
end

function Race.AnnounceEventOpen()   Race.Timer.CheckArea = Timer.Interval(1, Race.CheckArea)
    if Race.Counter.Open <= 0 then
        Race.Status.Open = false
        Race.Timer.Open = -1
        
        Timer.TimeOut(2, Race.EventStart)
    else
        if Race.Counter.Open > 1 then
            Race.SendMessageOpen(5, Race.Counter.Open)
        else
            Race.SendMessageOpen(6, Race.Counter.Open)
        end
        Race.Counter.Open = Race.Counter.Open - 1
    end
end

function Race.SendMessageOpen(key, t)
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
        local lang = GetLanguageObject(i)
		SendMessagePlayer(i, 0, string.format(Race_Config.Message[lang][key], Race_Config.Command[lang].Go, t))
		
		::continue::
	end
	
	collectgarbage()
end

function Race.EventCancel()
    Race.Status.Running = false

    if Race.Timer.Announce ~= -1 then
        Timer.Cancel(Race.Timer.Announce)
    end

    if Race.Timer.Open ~= -1 then
        Timer.Cancel(Race.Timer.Open)
    end

    if Race.Timer.Finish ~= -1 then
        Timer.Cancel(Race.Timer.Finish)
    end

    if Race.Timer.CheckArea ~= -1 then
        Timer.Cancel(Race.Timer.CheckArea)
    end

    if Race.Npc ~= -1 then
        gObjDel(Race.Npc)
    end

    for i in ipairs(Race.Participantes) do
        if Race.Participantes[i].Active then
            local player = User.new(Race.Participantes[i].Info[2])
            Teleport(Race.Participantes[i].Info[2], 0, 125, 125)

            if Race_Config.ResetSkills then
                local class = player:getClass()

			    for m in ipairs(Race_Config.ReturnSkills[class]) do
			    	local item = Race_Config.ReturnSkills[class][m]
			    	ItemSerialCreate(Race.Participantes[i].Info[2], 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
			    end
            end
        end
    end

    Message.SendMessageGlobalMultLang(Race_Config.Message, 8, 1)
    Message.SendMessageGlobalMultLang(Race_Config.Message, 8, 0)

    Race.Define()
end

function Race.EventStart()
    if Race.CountPlayers() <= 0 then
        Race.EventCancel()
        return
    end

    Race.Status.AllowClickNpc = true

    Race.Npc = AddMonster(Race_Config.Npc.Map)

    if Race.Npc == -1 then
        Race.EventCancel()
        LogAdd("Error creating Race NPC")
        return
    end

    local npc = User.new(Race.Npc)
    SetMapMonster(Race.Npc, Race_Config.Npc.Map, Race_Config.Npc.X, Race_Config.Npc.Y)
	npc:setDir(Race_Config.Npc.Dir)
	SetMonster(Race.Npc, Race_Config.Npc.Class)
	npc:setType(3)

    Message.SendMessageGlobalMultLang(Race_Config.Message, 13, 0)
    SendMessageGlobal("", 0)
    Message.SendMessageGlobalMultLang(Race_Config.Message, 14, 0)
    SendMessageGlobal("", 0)
    Message.SendMessageGlobalMultLang(Race_Config.Message, 13, 0)

    for i in ipairs(Race.Participantes) do
        if Race.Participantes[i].Active then
            Teleport(Race.Participantes[i].Info[2], Race_Config.Area.Start.Map, Race_Config.Area.Start.X, Race_Config.Area.Start.Y)
        end
    end
end

function Race.CommandGo(aIndex)
    local player = User.new(aIndex)
    local playerInfo = {[0] = player:getAccountID(), [1] = player:getName(), [2] = aIndex, [3] = player:getLanguage()}
    local pInv = Inventory.new(aIndex)

    if not Race.Status.Open then
        SendMessage(Race_Config.Message[playerInfo[3]][9], aIndex, 1)
        return
    end

   if player:getAuthority() > 1 then return end

    for i = 0, 139 do
        if i ~= 6 then
		    if pInv:isItem(i) ~= 0
		    then
		    	if pInv:getSection(i) ~= 11 then
                    SendMessage(Race_Config.Message[playerInfo[3]][11], aIndex, 1)
                    return
                end
		    end
        end
	end

	for i = 204, 235 do
		if pInv:isItem(i) ~= 0
		then
            if pInv:getSection(i) ~= 11 then
			    SendMessage(Race_Config.Message[playerInfo[3]][12], aIndex, 1)
			    return
            end
		end
	end

    if not Race.CheckIfIsPlayer(playerInfo[1]) then
        local temp = {Active = true, Position = -1, Info = playerInfo}
        table.insert(Race.Participantes, temp)
    end

    if Race_Config.ResetSkills then
        ResetSkills(aIndex)
    end

    Teleport(aIndex, Race_Config.Area.Wait.Map, Race_Config.Area.Wait.X, Race_Config.Area.Wait.Y)
    SendMessage(Race_Config.Message[playerInfo[3]][10], aIndex, 1)

end

function Race.CheckArea()
    if Race.Status.Running then
        for i in ipairs(Race.Participantes) do
            if Race.Participantes[i].Active then
                local player = User.new(Race.Participantes[i].Info[2])
                local map = player:getMapNumber()
                local x = player:getX()
                local y = player:getY()

                if map == Race_Config.Area.Total.Map then
                    if x >= Race_Config.Area.Total.X1 and x <= Race_Config.Area.Total.X2 then
                        if y >= Race_Config.Area.Total.Y1 and y <= Race_Config.Area.Total.Y2 then
                            goto continue
                        end
                    end
                end

                Race.Participantes[i].Active = false

                Teleport(Race.Participantes[i].Info[2], 0, 125, 125)

                if Race_Config.ResetSkills then
                    local class = player:getClass()

	    		    for m in ipairs(Race_Config.ReturnSkills[class]) do
	    		    	local item = Race_Config.ReturnSkills[class][m]
	    		    	ItemSerialCreate(Race.Participantes[i].Info[2], 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
	    		    end
                end

                SendMessage(Race_Config.Message[Race.Participantes[i].Info[3]][15], Race.Participantes[i].Info[2], 1)
            end

            ::continue::
        end
    end
end

function Race.CheckIfIsPlayer(Name)
    if #Race.Participantes == 0 then return false end

    for i in ipairs(Race.Participantes) do
        if Race.Participantes[i].Active then
            if Race.Participantes[i].Info[1] == Name then
                return true
            end
        end
    end

    return false
end

function Race.PlayerLogout(aIndex)
    if Race.Status.Running then
        for i in ipairs(Race.Participantes) do
            if Race.Participantes[i].Active then
                if Race.Participantes[i].Info[2] == aIndex then
                    local player = User.new(aIndex)
                    Race.Participantes[i].Active = false

                    Teleport(aIndex, 0, 125, 125)

                    if Race_Config.ResetSkills then
                        local class = player:getClass()

	    		        for m in ipairs(Race_Config.ReturnSkills[class]) do
	    		        	local item = Race_Config.ReturnSkills[class][m]
	    		        	ItemSerialCreate(Race.Participantes[i].Info[2], 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
	    		        end
                    end
                end
            end
        end
    end
end

function Race.NpcTalk(Npc, Player)
    if Race.Npc == -1 then return 0 end

    if Race.Status.Running then
        if Race.Status.AllowClickNpc then
            if Race.Npc == Npc then
                for i in ipairs(Race.Participantes) do
                    if Race.Participantes[i].Active then
                        if Race.Participantes[i].Info[2] == Player then
                            if Race.Winners < Race_Config.Winners then
                                Race.Winners = Race.Winners + 1
                                
                                ChatTargetSend(Npc, string.format(Race_Config.Message[Race.Participantes[i].Info[3]][16], Race.Winners), Player)
                                SendMessage(Race_Config.Message[Race.Participantes[i].Info[3]][17], Player, 1)
                                
                                if Race.Winners == 1 then
                                    Message.SendMessageGlobalMultLang(Race_Config.Message, 13, 0)
                                    SendMessageGlobal("", 0)
                                    Message.SendMessageGlobalMultLangArgs(Race_Config.Message, 18, 0, Race.Participantes[i].Info[1])
                                    SendMessageGlobal("", 0)
                                    Message.SendMessageGlobalMultLang(Race_Config.Message, 13, 0)
                                end
                                Race.Participantes[i].Active = false

                                Race.RewardPlayer(Race.Participantes[i].Info, Race.Winners)

                                if Race.Winners >= Race_Config.Winners then
                                    Race.FinishEvent()
                                else
                                    if Race.CountPlayers() <= 0 then
                                        Race.FinishEvent()
                                    end
                                end

                                return 1                              
                            else
                                Race.Status.AllowClickNpc = false
                                Race.FinishEvent()
                                return 1
                            end
                        
                        end
                    end
                end
            end
        end
    end

    return 0
end

function Race.RewardPlayer(playerInfo, Position)
    local player = User.new(playerInfo[2])
    if Race_Config.PrizeItem[Position] ~= nil then
        for g in ipairs(Race_Config.PrizeItem[Position]) do
            local item = Race_Config.PrizeItem[Position][g]
            CreateItemInventory(playerInfo[2], GET_ITEM(item.Section, item.Index), item.Level, item.Skill, item.Luck, item.Option, item.Exc, item.Ancient, item.JoH, item.SocketBonus, item.Sock1, item.Sock2, item.Sock3, item.Sock4, item.Sock5, item.ItemTime)
        end
    end

    if Race_Config.PrizeCoin[Position] ~= nil then
        for g in ipairs(Race_Config.PrizeCoin[Position]) do
            local coin = Race_Config.PrizeCoin[Position][g]
            DataBase.SetAddValue(coin.Table, coin.Column, coin.Amount, coin.Where, playerInfo[coin.IdType])
            SendMessage(string.format(Race_Config.Message[playerInfo[3]][19], coin.Amount, coin.Name), playerInfo[2], 1)
        end
    end

    if Race_Config.PrizeZen[Position] ~= nil and Race_Config.PrizeZen[Position] > 0 then
        player:setMoney(player:getMoney()+Race_Config.PrizeZen[Position])
        MoneySend(playerInfo[2])
        SendMessage(string.format(Race_Config.Message[playerInfo[3]][19], Race_Config.PrizeZen[Position], "Zen"), playerInfo[2], 1)
    end

    Teleport(playerInfo[2], 0, 125, 125)

    if Race_Config.ResetSkills then
        local class = player:getClass()
    
        for m in ipairs(Race_Config.ReturnSkills[class]) do
            local item = Race_Config.ReturnSkills[class][m]
            ItemSerialCreate(playerInfo[2], 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
        end
    end
end

function Race.CountPlayers()
    local count = 0

    for i in ipairs(Race.Participantes) do
        if Race.Participantes[i].Active then
            count = count + 1
        end
    end

    return count

end

function Race.FinishEvent()
    Race.Status.Running = false

    if Race.Timer.Announce ~= -1 then
        Timer.Cancel(Race.Timer.Announce)
    end

    if Race.Timer.Open ~= -1 then
        Timer.Cancel(Race.Timer.Open)
    end

    if Race.Timer.Finish ~= -1 then
        Timer.Cancel(Race.Timer.Finish)
    end

    if Race.Timer.CheckArea ~= -1 then
        Timer.Cancel(Race.Timer.CheckArea)
    end

    if Race.Npc ~= -1 then
        gObjDel(Race.Npc)
    end

    for i in ipairs(Race.Participantes) do
        if Race.Participantes[i].Active then
            local player = User.new(Race.Participantes[i].Info[2])
            Teleport(Race.Participantes[i].Info[2], 0, 125, 125)

            if Race_Config.ResetSkills then
                local class = player:getClass()

			    for m in ipairs(Race_Config.ReturnSkills[class]) do
			    	local item = Race_Config.ReturnSkills[class][m]
			    	ItemSerialCreate(Race.Participantes[i].Info[2], 236, 0, 0, GET_ITEM(item.Section, item.ID), 0, 0, 0, 0, 0, 0)
			    end
            end
        end
    end

    Message.SendMessageGlobalMultLang(Race_Config.Message, 20, 1)
    Message.SendMessageGlobalMultLang(Race_Config.Message, 20, 0)

    Race.Define()
end

function Race.EquipItem(aIndex, source, target)
    if not Race.Status.Running then return 0 end

    for i in ipairs(Race.Participantes) do
        if Race.Participantes[i].Active then
            if Race.Participantes[i].Info[2] == aIndex then
                if target == 6 then
                    return 0
                else
                    return 1
                end
            end
        end
    end
end

Race.Init()

return Race