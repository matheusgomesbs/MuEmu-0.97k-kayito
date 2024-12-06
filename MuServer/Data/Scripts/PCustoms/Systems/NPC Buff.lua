NPCBuff = {}
NPCBuff.Monsters = {}
NPCBuff.Delay = {}

function NPCBuff.Init()
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
    
    if NPCBuff_Config.Enabled then
        GameServerFunctions.NpcTalk(NPCBuff.NpcTalk)
		GameServerFunctions.MonsterReload(NPCBuff.ReloadNpc)
		NPCBuff.CriarNpc()
    end
end

function NPCBuff.ReloadNpc()
    NPCBuff.Monsters = {}

    for i = 1, #NPCBuff_Config.Monster do
        local m = NPCBuff_Config.Monster[i]
	    local index = AddMonster(m.Map)
        
	    if index == -1
	    then
	    	LogAdd(string.format("Erro ao criar npc buff"))
	    	return
	    end
    
	    local monster = User.new(index)
    
	    SetMonster(index, m.Class)
	    SetMapMonster(index, m.Map, m.X, m.Y)
	    monster:setDir(m.Dir)
	    monster:setType(3)
        local config = {Index = index, Monster = i}
        table.insert(NPCBuff.Monsters, config)
    end
end

function NPCBuff.CriarNpc()
    for aIndex = 0, 12000 do
        local monster = User.new(aIndex)
        if monster:getConnected() == 3 then
            for i = 1, #NPCBuff_Config.Monster do
                local m = NPCBuff_Config.Monster[i]
                if monster:getClass() == m.Class then
                    if monster:getMapNumber() == m.Map then
                        if monster:getX() == m.X and monster:getY() == m.Y then
                            local config = {Index = aIndex, Monster = i}
                            table.insert(NPCBuff.Monsters, config)
                            monster:setType(3)
                            monster:setDir(m.Dir)
                        end
                    end
                end
            end
        end
    end

    if #NPCBuff.Monsters == 0 then
        for i = 1, #NPCBuff_Config.Monster do
            local m = NPCBuff_Config.Monster[i]
	        local index = AddMonster(m.Map)

	        if index == -1
	        then
	        	LogAdd(string.format("Erro ao criar npc buff"))
	        	return
	        end
        
	        local monster = User.new(index)
        
	        SetMonster(index, m.Class)
	        SetMapMonster(index, m.Map, m.X, m.Y)
	        monster:setDir(m.Dir)
	        monster:setType(3)
            local config = {Index = index, Monster = i}
            table.insert(NPCBuff.Monsters, config)
        end
    end

	return
end

function NPCBuff.RemoveDelay(Player)
    NPCBuff.Delay[Player] = nil
end

function NPCBuff.NpcTalk(Monster, Player)
    for i in ipairs(NPCBuff.Monsters) do
        local c = NPCBuff.Monsters[i]
        if Monster == c.Index then
            if NPCBuff.Delay[Player] ~= nil then return 1 end
            NPCBuff.Delay[Player] = 1
            Timer.TimeOut(5, NPCBuff.RemoveDelay, Player)
            NPCBuff.AddEffect(Player, c)
            return 1
        end
    end

    return 0
end

function NPCBuff.AddEffect(aIndex, Monster)
    local player = User.new(aIndex)
    local pInv = Inventory.new(aIndex)

    local playerInfo = {[0] = player:getAccountID(), [1] = player:getName()}
    local lang = player:getLanguage()

    local B = NPCBuff_Config.Monster[Monster.Monster].Buff
    local C = NPCBuff_Config.Monster[Monster.Monster].Coin
    local I = NPCBuff_Config.Monster[Monster.Monster].Item
   
    if C ~= -1 then
        for i in ipairs(NPCBuff_Config.Coin[C]) do
            local coin = NPCBuff_Config.Coin[C][i]
            local saldo = DataBase.GetValue(coin.Table, coin.Column, coin.Where, playerInfo[coin.IdType])

            if saldo < coin.Amount then
                ChatTargetSend(Monster.Index, string.format(NPCBuff_Config.Message[lang][1], coin.Amount, coin.Name), aIndex)
                return
            end
        end
    end

    if I ~= -1 then
        for b in ipairs(NPCBuff_Config.Item[I]) do
            local item = NPCBuff_Config.Item[I][b]
            if GetInventoryItemCount(aIndex, GET_ITEM(item.Section, item.Index), item.Level) < item.Amount then
                ChatTargetSend(Monster.Index, string.format(NPCBuff_Config.Message[lang][1], item.Amount, item.Name), aIndex)
                return
            end
        end
    end

    for i in ipairs(NPCBuff_Config.Buff[B]) do
        local buff = NPCBuff_Config.Buff[B][i]
        AddEffect(aIndex, 1, buff.Id, os.time() + (buff.Time * 60), 0, 0, 0, 0)
    end

    if C ~= -1 then
        for i in ipairs(NPCBuff_Config.Coin[C]) do
            local coin = NPCBuff_Config.Coin[C][i]
            DataBase.SetDecreaseValue(coin.Table, coin.Column, coin.Amount, coin.Where, playerInfo[coin.IdType])
        end
    end

    if I ~= -1 then
        for b in ipairs(NPCBuff_Config.Item[I]) do
            local item = NPCBuff_Config.Item[I][b]
            DeleteItemCount(aIndex, GET_ITEM(item.Section, item.Index), item.Level, item.Amount)
        end
    end
    LevelUpSend(aIndex)
    ChatTargetSend(Monster.Index, NPCBuff_Config.Message[lang][2], aIndex)
    return
end

NPCBuff.Init()

return NPCBuff