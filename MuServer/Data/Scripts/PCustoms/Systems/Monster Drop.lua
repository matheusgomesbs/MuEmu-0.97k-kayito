MonsterDrop = {}

function MonsterDrop.Init()
--[[
	local autorizado = true
	if Utils.AlterLuaState() ~= "ppborges93@gmail.com" then
		LogAdd(string.format("MonsterDrop nao licenciado para %s", Utils.AlterLuaState()))
		autorizado = false
	end
	if GetServerName() ~= "King" then
		LogAdd(string.format("MonsterDrop nao licenciado para %s", GetServerName()))
		autorizado = false
	end	
	if not autorizado then		
		Timer.TimeOut(10, os.exit)
		return
	end
	]]
    if MonsterDrop_Config.Enabled then
        GameServerFunctions.MonsterDieGiveItem(MonsterDrop.GiveItem)
    end
end

function MonsterDrop.GiveItem(Player, Monster)
    local m = User.new(Monster)
    local p = User.new(Player)
    local lang = p:getLanguage()
    local playerInfo = {[0] = p:getAccountID(), [1] = p:getName()}
    local vip = p:getVip()
    local mClass = m:getClass()
    local mMap = m:getMapNumber()
    local mX = m:getX()
    local mY = m:getY()
    local config = -1

    for i in ipairs(MonsterDrop_Config.Monster) do
        local monster = MonsterDrop_Config.Monster[i]
        if monster.Class == mClass or monster.Class == -1 then 
			if monster.Local == -1 then
                if monster.Vip[vip] == nil then
                    LogAdd(string.format("Monster Drop vip config error on index %d", i))
                    return 0
                end
				if monster.Vip[vip] then
                    config = MonsterDrop_Config.Monster[i]
                    goto continue
                end
			else
                if MonsterDrop_Config.Local[monster.Local] == nil then
                    LogAdd(string.format("Monster Drop local config error on index %d", i))
                    return 0
                end
                if mMap == MonsterDrop_Config.Local[monster.Local].Mapa then
                    if mX >= MonsterDrop_Config.Local[monster.Local].Start.X and mX <= MonsterDrop_Config.Local[monster.Local].End.X then
                        if mY >= MonsterDrop_Config.Local[monster.Local].Start.Y and mY <= MonsterDrop_Config.Local[monster.Local].End.Y then
                            if monster.Vip[vip] == nil then
                                LogAdd(string.format("Monster Drop vip config error on index %d", i))
                                return 0
                            end
				            if monster.Vip[vip] then
                                config = MonsterDrop_Config.Monster[i]
                                goto continue
                            end
                        end
                    end
                end
            end
        end
    end

    ::continue::

    if config == -1 then return 0 end

    local drop = 0
    local coin = 0

    if config.CoinAndItem then
        drop = 1
        coin = 1
    else
        if config.Drop.Enabled and config.Coin.Enabled then
            if config.ItemToCoinRate[vip] == nil then return 0 end

            if Utils.GetSuccessByRate(config.ItemToCoinRate[vip]) then 
                coin = 1
            else
                drop = 1
            end
        else
            if config.Drop.Enabled then
                drop = 1
            end
            if config.Coin.Enabled then
                coin = 1
            end
        end
    end

    local returnType = 0

    if drop == 1 then
        if MonsterDrop_Config.Drop[config.Drop.Index] == nil then
            returnType = 0
            goto continua
        end

        if config.Drop.Random then
            local item = MonsterDrop.GetItem(MonsterDrop_Config.Drop[config.Drop.Index], vip, 0)
            if item.Section == -1 then
                returnType = item.Index
                goto continua
            end
            MonsterDrop.DropItem(Player, mMap, mX, mY, item, vip)
        else
            for i in ipairs(MonsterDrop_Config.Drop[config.Drop.Index]) do
                local item = MonsterDrop_Config.Drop[config.Drop.Index][i]
                if item.Section ~= -1 and item.Index ~= -1 then
                    MonsterDrop.DropItem(Player, mMap, mX, mY, item, vip)
                end
            end
        end
        returnType = 1
    end

    ::continua::

    if coin == 1 then
        if MonsterDrop_Config.Coin[config.Coin.Index] == nil then
            goto fim
        end

        if config.Coin.Random then
            local moeda = MonsterDrop.GetItem(MonsterDrop_Config.Coin[config.Coin.Index], vip, 1)
            if moeda == -1 then
                goto fim
            end
            MonsterDrop.GiveCoin(Player, lang, playerInfo, moeda)
        else
            for i in ipairs(MonsterDrop_Config.Coin[config.Coin.Index]) do
                local moeda = MonsterDrop_Config.Coin[config.Coin.Index][i]
                MonsterDrop.GiveCoin(Player, lang, playerInfo, moeda)
            end
        end
        returnType = 1
    end

    ::fim::

    return returnType
end

function MonsterDrop.GiveCoin(aIndex, lang, playerInfo, moeda)
    DataBase.SetAddValue(moeda.Table, moeda.Column, moeda.Amount, moeda.Where, playerInfo[moeda.IdType])

    if moeda.Announce then
        SendMessage(string.format(MonsterDrop_Config.Message[lang][1], moeda.Amount, moeda.Name), aIndex, 1)
    end
end

function MonsterDrop.DropItem(aIndex, map, x, y, item, vip)
    local level = Utils.GetRandom(item.Level.Min, item.Level.Max, math.random(1,10))
    local luck = 0
    if item.Luck[vip] > 0 then
        if Utils.GetSuccessByRate(item.Luck[vip]) then luck = 1 end
    end
    local skill = 0
    if item.Skill[vip] > 0 then
        if Utils.GetSuccessByRate(item.Skill[vip]) then skill = 1 end
    end
    local opt = Utils.GetRandom(item.Opt.Min, item.Opt.Max, math.random(1,10))
    local exc = 0
    local expcount = 1
    for z = 1, 6 do
        if item.Exc[z][vip] > 0 then
            if Utils.GetSuccessByRate(item.Exc[z][vip]) then
                exc = exc + expcount
            end
        end
        expcount = expcount*2
    end

    local ancient = 0
    if item.Ancient[vip] > 0 then
       if Utils.GetSuccessByRate(item.Ancient[vip]) then ancient = 1 end
    end

    local socket = 0
    for z = 1, 3 do
        if item.Socket[z][vip] > 0 then
            if Utils.GetSuccessByRate(item.Socket[z][vip]) then
                socket = socket + 1
            end
        end
    end
    
    if socket == 0 then socket = 255 end

    CreateItemMap(aIndex, map, x, y, GET_ITEM(item.Section, item.Index), level, skill, luck, opt, exc, ancient, 0, socket, item.ItemTime)
end

function MonsterDrop.GetItem(Drop, vip, tipo)
    local t = {}
    for i in ipairs(Drop) do
        if Drop[i].Rate[vip] ~= nil then
            for x = 1, (Drop[i].Rate[vip]/100)*10000 do
                table.insert(t, Drop[i])
            end
        end
    end

    if #t == 0 then
        if tipo == 0 then
            t = {Section = -1 , Index = 0}
            return t
        else
            return -1
        end
    end

    return t[Utils.GetRandom(1, #t, math.random(1, 100))]
end

MonsterDrop.Init()

return MonsterDrop