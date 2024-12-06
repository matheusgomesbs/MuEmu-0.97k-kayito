Utils = {}

function Utils.AlterLuaState()
	local UserEmail = ""
	local file = io.open("DATA\\GameServerInfo - Common.dat", "r+")
	for line in file:lines() do
		local linha = string.split(line, " ")
		local key = linha[1]
		if key == "UserEmail" then
			UserEmail = string.gsub(linha[3], '"', "")
			break
		end
	end
	file:close()
	return UserEmail
end

function Utils.UserGetHWID(aIndex)
	local player = User.new(aIndex)
	local Acc = player:getAccountID()
	return DataBase.GetString("MEMB_STAT", "HWID", "memb___id", Acc)	
end

function Utils.ShuffleTable(t)
    for i = #t, 2, -1 do
        local j = Utils.GetRandom(1, i, 2)
        t[i], t[j] = t[j], t[i]
    end
end

function Utils.GetVip(aIndex)
	local player = User.new(aIndex)
	local Acc = player:getAccountID()
	local vip = DataBase.GetNumberByString(TABLE_VIP, COLUMN_VIP, WHERE_VIP, Acc)
	return vip
end

function Utils.GetPlayerInfo(player)
	local playerInfo = {[0] = player:getAccountID(), [1] = player:getName(), [2] = player:getIndex(), [3] = player:getLanguage(), [4] = player:getVip()}
	return playerInfo
end

function Utils.GetSuccessByRate(rate)
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
		
	if Count[Utils.GetRandom(1, #Count, math.random(1, 100))] == 1 then return true else return false end	
end

function Utils.GetItem(x , y)
	if x > 15 or x < 0 or y < 0 or y > 512 then return -1 end
	return x * 512 + y
end

function Utils.GetOption(Item)
	local level = Utils.GetRandom(Item.LevelMin, Item.LevelMax, math.random(1, 100))
	local skill = Item.Skill
	if skill == -1 then
		skill = Utils.GetRandom(0, 1, math.random(1, 100))
	end
	local luck = Item.Luck
	if luck == -1 then
		luck = Utils.GetRandom(0, 1, math.random(1, 100))
	end
	local dur = Utils.GetRandom(Item.DurMin, Item.DurMax, math.random(1, 100))
	local opt = Utils.GetRandom(Item.OptMin, Item.OptMax, math.random(1, 100))
	local exc = Utils.GetExcelente(Item.ExcMin, Item.ExcMax)
	
	return {Level = level, Skill = skill, Luck = luck, Dur = dur, Option = opt, Exc = exc}
end

function Utils.IsInventoryEmpty(aIndex)
	local PlayerInventory = Inventory.new(aIndex)
	for slot = 12, 75 do
		if PlayerInventory:isItem(slot) ~= 0 then return false end
	end
	
	return true
end

function Utils.GetRandom(x, y, z)
	math.randomseed(os.time() * os.clock() * z)
	for i = 1, z do
		math.random()
	end
	return math.random(x, y)
end

function Utils.InventoryGetItemTable(aIndex, Slot)
	local PlayerInventory = Inventory.new(aIndex)
	local tabela = {Nome = "Sword Of Death", Serial = 0, Index = 50, Section = 0, Level = 15, Skill = 1, Luck = 1, Option = 7, Exc = 63, Ancient = 1, Harmony = 1}
	
	tabela.Nome		= PlayerInventory:getName(Slot)
	tabela.Serial	= PlayerInventory:getSerial(Slot)
	tabela.Index	= PlayerInventory:getIndex2(Slot)
	tabela.Section	= PlayerInventory:getSection(Slot)
	tabela.Level	= PlayerInventory:getLevel(Slot)
	tabela.Exc		= PlayerInventory:getItemTable(Slot, 1)
	tabela.Skill	= PlayerInventory:getItemTable(Slot, 2)
	tabela.Luck		= PlayerInventory:getItemTable(Slot, 3)
	tabela.Option	= PlayerInventory:getItemTable(Slot, 4)
	tabela.Ancient	= PlayerInventory:getItemTable(Slot, 5)
	
	return tabela
end

function Utils.TradeGetItemTable(aIndex, Slot)
	local pTrade = Trade.new(aIndex)
	local tabela = {Nome = "", Serial = 0, Index = 0, Section = 0, Level = 0, Skill = 0, Luck = 0, Option = 0, Exc = 0, Ancient = 0, Harmony = 0}
	
	tabela.Nome		= pTrade:getName(Slot)
	tabela.Serial	= pTrade:getSerial(Slot)
	tabela.Section, tabela.Index	= Utils.GetItemByIndex(pTrade:getIndex(Slot))
	tabela.Level	= pTrade:getLevel(aIndex, Slot)
	tabela.Exc		= pTrade:getItemTable(Slot, 1)
	tabela.Skill	= pTrade:getItemTable(Slot, 2)
	tabela.Luck		= pTrade:getItemTable(Slot, 3)
	tabela.Option	= pTrade:getItemTable(Slot, 4)
	tabela.Ancient	= pTrade:getItemTable(Slot, 5)
	
	return tabela
end

function Utils.WarehouseGetItemTable(aIndex, Slot)
	local pWareHouse = WareHouse.new(aIndex)
	local tabela = {Nome = "", Serial = 0, Index = 0, Section = 0, Level = 0, Skill = 0, Luck = 0, Option = 0, Exc = 0, Ancient = 0, Harmony = 0}
	
	tabela.Nome		= pWareHouse:getName(Slot)
	tabela.Serial	= pWareHouse:getSerial(Slot)
	tabela.Index	= pWareHouse:getIndex2(Slot)
	tabela.Section	= pWareHouse:getSection(Slot)
	tabela.Level	= pWareHouse:getLevel(Slot)
	tabela.Exc		= pWareHouse:getItemTable(Slot, 1)
	tabela.Skill	= pWareHouse:getItemTable(Slot, 2)
	tabela.Luck		= pWareHouse:getItemTable(Slot, 3)
	tabela.Option	= pWareHouse:getItemTable(Slot, 4)
	tabela.Ancient	= pWareHouse:getItemTable(Slot, 5)
	
	return tabela
end

function Utils.ChaosBoxGetItemTable(aIndex, Slot)
	local pChaosBox = ChaosBox.new(aIndex)
	local tabela = {Nome = "", Serial = 0, Index = 0, Section = 0, Level = 0, Skill = 0, Luck = 0, Option = 0, Exc = 0, Ancient = 0, Harmony = 0}
	
	tabela.Nome		= pChaosBox:getName(Slot)
	tabela.Serial	= pChaosBox:getSerial(Slot)
	tabela.Section, tabela.Index	= Utils.GetItemByIndex(pChaosBox:getIndex(Slot))
	tabela.Level	= pChaosBox:getLevel(Slot)
	tabela.Exc		= pChaosBox:getItemTable(Slot, 1)
	tabela.Skill	= pChaosBox:getItemTable(Slot, 2)
	tabela.Luck		= pChaosBox:getItemTable(Slot, 3)
	tabela.Option	= pChaosBox:getItemTable(Slot, 4)
	tabela.Ancient	= pChaosBox:getItemTable(Slot, 5)
	
	return tabela
end

function Utils.GetItemByIndex(Index)	
	for section = 0, 15 do
		local id = Index - 512 * section
		if id >= 0 and id <= 512 then
			return section, id
		end
	end
end

function Utils.GetExcelente(Min, Max)
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
			local rand = Utils.GetRandom(1, #ExcTable, math.random(1, 100))
			local pick = ExcTable[rand] 
			exc = exc + pick
			table.remove(ExcTable, rand)
		end	
	end
	
	if Max > Min
	then
		local MaxOptions = Max - Min
		for i = 1, MaxOptions do
			if Utils.GetSuccessByRate(50)
			then
				local rand = Utils.GetRandom(1, #ExcTable, math.random(1, 100))
				local pick = ExcTable[rand] 
				exc = exc + pick
				table.remove(ExcTable, rand)
			end
		end
	end
	
	return exc
end

function Utils.ExcToTable(exc)
    local t = {}       
    for i = 1, 6 do
        t[i] = math.fmod(exc, 2)
        exc = math.floor((exc - t[i]) / 2)
    end
    return t
end

function Utils.TableToExc(t)
	local id = 6
	local nt = {}
	for i in ipairs(t) do
		nt[id] = t[i]
		id = id - 1
	end	
	local a = ""
	for i in ipairs(nt) do
		a = a..nt[i]
	end
	local exc = tonumber(a,2)
	return exc
end