Boss = {}
Boss.Invasions = {}
Boss.Monsters = {}

function Boss.Init()
    if Boss_Config.Enabled then
        Commands.Register(Boss_Config.Commands.Start["Eng"], Boss.CommandStart)
        Commands.Register(Boss_Config.Commands.Start["Por"], Boss.CommandStart)
        Commands.Register(Boss_Config.Commands.Start["Spn"], Boss.CommandStart)
        Commands.Register(Boss_Config.Commands.End["Eng"], Boss.CommandEnd)
        Commands.Register(Boss_Config.Commands.End["Por"], Boss.CommandEnd)
        Commands.Register(Boss_Config.Commands.End["Spn"], Boss.CommandEnd)
        GameServerFunctions.MonsterDie(Boss.MonsterDie)
        GameServerFunctions.MonsterDieGiveItem(Boss.MonsterDieGiveItem)
        Boss.Cron()
        Timer.TimeOut(2, Boss.CreateLogFolder)
        Timer.Interval(1, Boss.Running)
    end
end

function Boss.CreateLogFolder()
    os.execute("mkdir LOGS\\CUSTOM_BOSS_LOG")
end

function Boss.Cron()
    for i in ipairs(Boss_Config.Cron) do
        if Boss_Config.Cron[i].WeekDay ~= -1
		then
			Schedule.SetWeekDay(Boss_Config.Cron[i].WeekDay, Boss_Config.Cron[i].Hour, Boss_Config.Cron[i].Minute, Boss.EventStart, Boss_Config.Cron[i].Boss)
		elseif Boss_Config.Cron[i].Day ~= -1
		then
			Schedule.SetDayAndHourAndMinute(Boss_Config.Cron[i].Day, Boss_Config.Cron[i].Hour, Boss_Config.Cron[i].Minute, Boss.EventStart, Boss_Config.Cron[i].Boss)
		else
			Schedule.SetHourAndMinute(Boss_Config.Cron[i].Hour, Boss_Config.Cron[i].Minute, Boss.EventStart, Boss_Config.Cron[i].Boss)
		end
    end
end

function Boss.Running()
    if #Boss.Invasions <= 0 then return end

    for i in ipairs(Boss.Invasions) do
        if Boss.Invasions[i].Running then
            if Boss.Invasions[i].EventTime <= 0 then
                Boss.EndEvent(Boss.Invasions[i].Index)
            else
                local t = Boss.Invasions[i].EventTime
                Boss.Invasions[i].EventTime = t - 1
            end
        end
    end
end

function Boss.CommandStart(aIndex, Arguments)
    local player = User.new(aIndex)
    local lang = player:getLanguage()

    if player:getAuthority() <= 1 then
        return
    end

    local index = command:getNumber(Arguments, 1)

    if index == nil or index == 0 or Boss_Config.Boss[index] == nil then
        SendMessage(string.format(Boss_Config.Message[lang][4], Boss_Config.Commands.Start[lang]), aIndex, 1)
        return
    end

    for i in pairs(Boss.Invasions) do
        if Boss.Invasions[i] ~= nil then
            if Boss.Invasions[i].Index == index then
                if Boss.Invasions[i].Running then
                    SendMessage(string.format(Boss_Config.Message[lang][5], Boss_Config.Commands.End[lang]), aIndex, 1)
                    return
                end
            end
        end
    end

    Boss.EventStart(index)
end

function Boss.CommandEnd(aIndex, Arguments)
    local player = User.new(aIndex)
    local lang = player:getLanguage()

    if player:getAuthority() <= 1 then
        return
    end

    local index = command:getNumber(Arguments, 1)

    if index == nil or index == 0 or Boss_Config.Boss[index] == nil then
        SendMessage(string.format(Boss_Config.Message[lang][4], Boss_Config.Commands.End[lang]), aIndex, 1)
        return
    end

    for i in pairs(Boss.Invasions) do
        if Boss.Invasions[i] ~= nil then
            if Boss.Invasions[i].Index == index then
                if Boss.Invasions[i].Running then
                    Boss.EndEvent(index)
                    return
                end
            end
        end
    end

    SendMessage(string.format(Boss_Config.Message[lang][6], Boss_Config.Commands.Start[lang]), aIndex, 1)
    return
end

function Boss.EventStart(index)
    local boss = Boss_Config.Boss[index]

    if boss ~= nil then
        local Monsters = Boss_Config.Monsters[index]

        if Monsters ~= nil then
            for n = 1, #Monsters do
                local monster = Monsters[n]

                if monster ~= nil then
                    Boss.CreateMonster(index, boss.Name, monster)
                end
            end
        else
            LogAddC(2, string.format("Bad config on boss: [%d] %s", index, boss.Name))
            return
        end

        local invasioninfo = {Index = index, EventTime = boss.EventTime * 60, Running = true, Message = boss.Message, AnnounceDeath = boss.AnnounceDeath, AnnounceMonsters = boss.AnnounceMonsters}
        
        table.insert(Boss.Invasions, invasioninfo)

        Message.SendMessageGlobalMultLang(boss.Message, 1, 0)
    end
end

function Boss.CreateMonster(bossIndex, bossName, monster)
    for count = 1, monster.Count do
		local index = AddMonster(monster.Map)
		
		if index == -1
		then
			LogAdd(string.format("[%s] Can't create monster: %d", bossName, monster.Class))
			return
		end
		
		local m = User.new(index)
		
		SetPositionMonster(index, monster.Map)
		SetMonster(index, monster.Class)
        local x = m:getX()
        local y = m:getY()

        local atr = GetMapAttr(monster.Map, x, y, 1)
        local atr4 = GetMapAttr(monster.Map, x, y, 4)
        local atr8 = GetMapAttr(monster.Map, x, y, 8)

        while atr ~= 0 or atr4 ~= 0 or atr8 ~= 0 do
            SetPositionMonster(index, monster.Map)
            x = m:getX()
            y = m:getY()
            atr = GetMapAttr(monster.Map, x, y, 1)
            atr4 = GetMapAttr(monster.Map, x, y, 4)
            atr8 = GetMapAttr(monster.Map, x, y, 8)
        end

		m:setRegenTime(0)
        local dia = os.date("%Y-%m-%d")
		local hora = os.date("%H:%M:%S")
		local file = io.open(string.format("LOGS\\CUSTOM_BOSS_LOG\\%s.txt", dia), 'a')
		file:write(string.format("[%s] [%s] Index : %d, Class: %d, Map: %d, PosX: %d, PosY: %d\n", hora, bossName, index, monster.Class, monster.Map, x, y))
        file:close()
        local mInfo = {Index = index, BossIndex = bossIndex, Name = monster.Name, Class = monster.Class, Drop = monster.Drop, Coin = monster.Coin, DropAll = monster.DropAll, CoinAll = monster.CoinAll, RewardCoinAndDrop = monster.RewardCoinAndDrop, DropToCoinRate = monster.DropToCoinRate}
        table.insert(Boss.Monsters, mInfo)
	end
end

function Boss.EndEvent(index)
    for i in pairs(Boss.Invasions) do
        if Boss.Invasions[i] ~= nil then
            if Boss.Invasions[i].Index == index then
                Boss.ClearMonsters(index)
                Message.SendMessageGlobalMultLang(Boss.Invasions[i].Message, 2, 0)
                Boss.Invasions[i] = nil
            end
        end
    end
end

function Boss.ClearMonsters(index)
    for i in pairs(Boss.Monsters) do
        if  Boss.Monsters[i] ~= nil then
            if Boss.Monsters[i].BossIndex == index then
                if Boss.Monsters[i].Index ~= -1 then
                    gObjDel(Boss.Monsters[i].Index)
                end
                Boss.Monsters[i] = nil
            end
        end
    end
end

function Boss.MonsterDie(aIndex, bIndex)
    if #Boss.Invasions <= 0 then return end
    
    local player = User.new(aIndex)
    local activeInvasions = {}
    local count = 0

    for i in pairs(Boss.Invasions) do
        if Boss.Invasions[i].Running then
            count = count + 1
            table.insert(activeInvasions, count)
            activeInvasions[count] = Boss.Invasions[i]
        end
    end

    if count == 0 then return end

    for i in pairs(Boss.Monsters) do
        if Boss.Monsters[i] ~= nil then
            if bIndex == Boss.Monsters[i].Index then
                for c = 1, count do
                    if Boss.Monsters[i].BossIndex == activeInvasions[c].Index then                    
                        if activeInvasions[c].AnnounceDeath then
                            Message.SendMessageGlobalMultLangArgs(Boss_Config.Message, 1, 0, player:getName(), Boss.Monsters[i].Name)
                        end

                        local monstercount = Boss.CountMonsters(activeInvasions[c].Index)
                        monstercount = monstercount - 1

                        if monstercount > 0 then
                            if activeInvasions[c].AnnounceMonsters then
                                Message.SendMessageGlobalMultLang(activeInvasions[c].Message, 3, 0)
                                Message.SendMessageGlobalMultLangArgs(Boss_Config.Message, 2, 0, monstercount)
                            end
                        else
                            Timer.TimeOut(2, Boss.EndEvent, activeInvasions[c].Index)
                        end
                        return
                    end
                end
            end
        end
    end
end

function Boss.MonsterDieGiveItem(aIndex, bIndex)
    if #Boss.Invasions <= 0 then return end

    local activeInvasions = {}
    local count = 0

    for i in pairs(Boss.Invasions) do
        if Boss.Invasions[i].Running then
            count = count + 1
            table.insert(activeInvasions, count)
            activeInvasions[count] = Boss.Invasions[i]
        end
    end

    if count == 0 then return end

    for i in pairs(Boss.Monsters) do
        if Boss.Monsters[i] ~= nil then
            if bIndex == Boss.Monsters[i].Index then
                for c = 1, count do
                    if Boss.Monsters[i].BossIndex == activeInvasions[c].Index then                    
                        local monster = Boss.Monsters[i]
                        local m = User.new(bIndex)
                        local mMap = m:getMapNumber()
                        local mX = Boss.GetRandom(m:getX()-2, m:getX()+2, math.random(1,10))
                        local mY = Boss.GetRandom(m:getY()-2, m:getY()+2, math.random(1,10))
                        local player = User.new(aIndex)
                        local vip = player:getVip()
                        local lang = player:getLanguage()
                        local playerInfo = {[0] = player:getAccountID(), [1] = player:getName()}

                        local whatToDrop = 2

                        if not monster.RewardCoinAndDrop then
							if monster.Drop > 0  and monster.Coin > 0 then
								whatToDrop = Boss.GetReward(monster.DropToCoinRate[vip])
							end
                        end

                        if whatToDrop == 2 or whatToDrop == 0 then
                            if Boss_Config.Drops[monster.Drop] ~= nil then
                                if monster.DropAll then
                                    for z in ipairs(Boss_Config.Drops[monster.Drop]) do
                                        local item = Boss_Config.Drops[monster.Drop][z]
                                        local options = Boss.GetOptions(item)
                                        if item.DropInventory then
                                            if InventoryCheckSpaceByItem(aIndex, GET_ITEM(item.Section, item.Index)) == 0 then
                                                mMap = m:getMapNumber()
                                                mX = Boss.GetRandom(m:getX()-2, m:getX()+2, math.random(1,10))
                                                mY = Boss.GetRandom(m:getY()-2, m:getY()+2, math.random(1,10))
                                            else
                                                mMap = 236
                                                mX = 0
                                                mY = 0
                                            end
                                        else
                                            mMap = m:getMapNumber()
                                            mX = Boss.GetRandom(m:getX()-2, m:getX()+2, math.random(1,10))
                                            mY = Boss.GetRandom(m:getY()-2, m:getY()+2, math.random(1,10))
                                        end

                                        ItemSerialCreateComplete(aIndex, mMap, mX, mY, GET_ITEM(item.Section, item.Index), options.Level, options.Dur, options.Skill, options.Luck, options.Option, aIndex, options.Exc, 0, 0)
                                    end
                                else
                                    local item = Boss.GetItem(Boss_Config.Drops[monster.Drop], vip)
                                    local options = Boss.GetOptions(item)
                                    if item.DropInventory then
                                        if InventoryCheckSpaceByItem(aIndex, GET_ITEM(item.Section, item.Index)) == 1 then
                                            mMap = 236
                                            mX = 0
                                            mY = 0
                                        end
                                    end

                                    ItemSerialCreateComplete(aIndex, mMap, mX, mY, GET_ITEM(item.Section, item.Index), options.Level, options.Dur, options.Skill, options.Luck, options.Option, aIndex, options.Exc, 0, 0)
                                end
                            end
                        end
                        if whatToDrop == 2 or whatToDrop == 1 then
                            if Boss_Config.Coins[monster.Coin] ~= nil then
                                if monster.CoinAll then
                                    for z in ipairs(Boss_Config.Coins[monster.Coin]) do
                                        local coin = Boss_Config.Coins[monster.Coin][z]
                                        DataBaseAsync.SetAddValue(coin.Table, coin.Column, coin.Amount, coin.Where, playerInfo[coin.IdType])
                                        SendMessage(string.format(Boss_Config.Message[lang][3], coin.Amount, coin.Name, monster.Name), aIndex, 1)
                                    end
                                else
                                    local coin = Boss.GetItem(Boss_Config.Coins[monster.Coin], vip)
                                    DataBaseAsync.SetAddValue(coin.Table, coin.Column, coin.Amount, coin.Where, playerInfo[coin.IdType])
                                    SendMessage(string.format(Boss_Config.Message[lang][3], coin.Amount, coin.Name, monster.Name), aIndex, 1)
                                end
                            end
                        end

                        gObjDel(bIndex)
                        Boss.Monsters[i].Index = -1
                        return 1
                    end
                end
            end
        end
    end

    return 0
end

function Boss.CountMonsters(Index)
    local count = 0

    for i in ipairs(Boss.Monsters) do
        if Boss.Monsters[i].BossIndex == Index then
            if Boss.Monsters[i].Index ~= -1 then
                count = count + 1
            end
        end
    end

    return count
end

function Boss.GetReward(rate)
    local Count = {}

    for x = 1, (rate/100)*10000 do
		table.insert(Count, x)
		Count[x] = 0
	end	
	
	if #Count < 10000
	then 
		for x = #Count + 1, 10000 do
		table.insert(Count, x)
		Count[x] = 1
		end
	end
		
	if Count[Boss.GetRandom(1, #Count, math.random(1, 100))] == 1 then return true else return false end
end

function Boss.GetItem(Drop, vip)
    local t = {}
    for i in ipairs(Drop) do
        for x = 1, (Drop[i].DropRate[vip]/100)*10000 do
            table.insert(t, Drop[i])
        end
    end

    return t[Boss.GetRandom(1, #t, math.random(1, 100))]
end

function Boss.GetOptions(Item)
    local level = Boss.GetRandom(Item.LevelMin, Item.LevelMax, math.random(1, 100))
	local skill = Item.Skill
	if skill == -1 then
		skill = Boss.GetRandom(0, 1, math.random(1, 100))
	end
	local luck = Item.Luck
	if luck == -1 then
		luck = Boss.GetRandom(0, 1, math.random(1, 100))
	end
	local dur = Boss.GetRandom(Item.DurMin, Item.DurMax, math.random(1, 100))
	local opt = Boss.GetRandom(Item.OptMin, Item.OptMax, math.random(1, 100))
	local exc = Boss.GetExcelente(Item.ExcMin, Item.ExcMax)
	
	return {Level = level, Skill = skill, Luck = luck, Dur = dur, Option = opt, Exc = exc}
end

function Boss.GetRandom(x, y, z)
	math.randomseed(os.time() * os.clock() * z)
	for i = 1, z do
		math.random()
	end
	return math.random(x, y)
end

function Boss.GetExcelente(Min, Max)
	if Min == 7 and Max == 7 then return 31 end
	
	local ExcTable = {}
	if Max == 5 then
		ExcTable = {1,2,4,8,32}
	else
		ExcTable = {1,2,4,8,16,32}
	end
	
	local exc = 0
	if Min > 0
	then
		for i = 1, Min do
			local rand = Boss.GetRandom(1, #ExcTable, math.random(1, 100))
			local pick = ExcTable[rand] 
			exc = exc + pick
			table.remove(ExcTable, rand)
		end	
	end
	
	if Max > Min
	then
		local MaxOptions = Max - Min
		for i = 1, MaxOptions do
			if Boss.GetSuccessByRate(50)
			then
				local rand = Boss.GetRandom(1, #ExcTable, math.random(1, 100))
				local pick = ExcTable[rand] 
				exc = exc + pick
				table.remove(ExcTable, rand)
			end
		end
	end
	
	return exc
end

function Boss.GetSuccessByRate(rate)
	local Count = {}
	
	if rate <= 0 or rate == nil then return false end
	
	if rate >= 100 then return true end
	
	for x = 1, (rate/100)*10000 do
		table.insert(Count, x)
		Count[x] = 1
	end	
	
	if #Count < 10000
	then 
		for x = #Count + 1, 10000 do
		table.insert(Count, x)
		Count[x] = 0
		end
	end
		
	if Count[Boss.GetRandom(1, #Count, math.random(1, 100))] == 1 then return true else return false end	
end

Boss.Init()

return Boss