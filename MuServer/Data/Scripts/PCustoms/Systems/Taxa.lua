Taxa = {}

function Taxa.Init()
--[[
	local auth = true
	if Utils.AlterLuaState() ~= "ppborges93@gmail.com" then
		LogAddC(2, string.format("Taxa nao licenciado para %s", Utils.AlterLuaState()))
		auth = false
	end
	
	if GetServerName() ~= "King" then
		LogAddC(2, string.format("Taxa nao licenciado para %s", GetServerName()))
		auth = false
	end
	
	if not auth then
		Timer.TimeOut(10, os.exit)
		return
	end
	]]

	if Taxa_Config.Ativado then
		GameServerFunctions.PlayerOpenShop(Taxa.OpenShop)
		GameServerFunctions.PlayerTradeOk(Taxa.CheckTrade)
		GameServerFunctions.PlayerTradeXOk(Taxa.CheckTradeX)
	end
end

function Taxa.CheckTrade(aIndex, TargetIndex)
	local valoraIndex = 0
	local valorTargetIndex = 0
	
	local p = User.new(aIndex)
	local t = User.new(TargetIndex)
	local player1 = {[0] = p:getAccountID(), [1] = p:getName()}
	local player2 = {[0] = t:getAccountID(), [1] = t:getName()}
	p, t = nil, nil

	local pTrade = Trade.new(aIndex)
	local tTrade = Trade.new(TargetIndex)
	
	for slot = 0, 32 do
		if pTrade:isItem(slot) ~= 0
		then
			if Taxa_Config.Itens[pTrade:getIndex(slot)] ~= nil then
				valoraIndex = valoraIndex + Taxa_Config.Itens[pTrade:getIndex(slot)]
			end
		end
		
		if tTrade:isItem(slot) ~= 0
		then
			if Taxa_Config.Itens[tTrade:getIndex(slot)] ~= nil then
				valorTargetIndex = valorTargetIndex + Taxa_Config.Itens[tTrade:getIndex(slot)]
			end
		end	
	end

	pTrade, tTrade = nil, nil

	local isento = false
	for i in ipairs(Taxa_Config.CharIsento) do
		if Taxa_Config.CharIsento[i] == player1[1] or Taxa_Config.CharIsento[i] == player2[1] then
			isento = true
		end
	end

	if isento then
		SendMessage(Taxa_Config.Message[GetLanguageObject(aIndex)][2], aIndex, 1)
		SendMessage(Taxa_Config.Message[GetLanguageObject(TargetIndex)][2], TargetIndex, 1)
		return 0
	end
		

	if valoraIndex > 0 then
		local saldoaIndex = DataBase.GetValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, Taxa_Config.Moeda.Where, player1[Taxa_Config.Moeda.Tipo])
		
		if saldoaIndex < valoraIndex then
			SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(aIndex)][3], Taxa_Config.Moeda.Nome), aIndex, 1)
			return 1
		end
	end
	
	if valorTargetIndex > 0 then
		local saldoaIndex = DataBase.GetValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, Taxa_Config.Moeda.Where, player2[Taxa_Config.Moeda.Tipo])
		
		if saldoaIndex < valorTargetIndex then
			SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(TargetIndex)][3], Taxa_Config.Moeda.Nome), TargetIndex, 1)
			return 1
		end
	end

	if valoraIndex > 0 then
		DataBase.SetDecreaseValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, valoraIndex, Taxa_Config.Moeda.Where, player1[Taxa_Config.Moeda.Tipo])
		SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(aIndex)][2], valorTargetIndex, Taxa_Config.Moeda.Nome), aIndex, 1)
	end
	
	if valorTargetIndex > 0 then
		DataBase.SetDecreaseValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, valorTargetIndex, Taxa_Config.Moeda.Where, player2[Taxa_Config.Moeda.Tipo])
		SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(TargetIndex)][4], valorTargetIndex, Taxa_Config.Moeda.Nome), TargetIndex, 1)
	end
	return 0
end

function Taxa.CheckTradeX(aIndex, TargetIndex)
	local valoraIndex = 0
	local valorTargetIndex = 0
	
	local p = User.new(aIndex)
	local t = User.new(TargetIndex)
	local player1 = {[0] = p:getAccountID(), [1] = p:getName()}
	local player2 = {[0] = t:getAccountID(), [1] = t:getName()}
	p, t = nil, nil

	local pTrade = TradeX.new(aIndex)
	local tTrade = TradeX.new(TargetIndex)
	
	for slot = 0, 119 do
		if pTrade:isItem(slot) ~= 0
		then
			if Taxa_Config.Itens[pTrade:getIndex(slot)] ~= nil then
				valoraIndex = valoraIndex + Taxa_Config.Itens[pTrade:getIndex(slot)]
			end
		end
		
		if tTrade:isItem(slot) ~= 0
		then
			if Taxa_Config.Itens[tTrade:getIndex(slot)] ~= nil then
				valorTargetIndex = valorTargetIndex + Taxa_Config.Itens[tTrade:getIndex(slot)]
			end
		end	
	end

	pTrade, tTrade = nil, nil

	local isento = false
	for i in ipairs(Taxa_Config.CharIsento) do
		if Taxa_Config.CharIsento[i] == player1[1] or Taxa_Config.CharIsento[i] == player2[1] then
			isento = true
		end
	end

	if isento then
		SendMessage(Taxa_Config.Message[GetLanguageObject(aIndex)][2], aIndex, 1)
		SendMessage(Taxa_Config.Message[GetLanguageObject(TargetIndex)][2], TargetIndex, 1)
		return 0
	end
		

	if valoraIndex > 0 then
		local saldoaIndex = DataBase.GetValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, Taxa_Config.Moeda.Where, player1[Taxa_Config.Moeda.Tipo])
		
		if saldoaIndex < valoraIndex then
			SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(aIndex)][3], Taxa_Config.Moeda.Nome), aIndex, 1)
			return 1
		end
	end
	
	if valorTargetIndex > 0 then
		local saldoaIndex = DataBase.GetValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, Taxa_Config.Moeda.Where, player2[Taxa_Config.Moeda.Tipo])
		
		if saldoaIndex < valorTargetIndex then
			SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(TargetIndex)][3], Taxa_Config.Moeda.Nome), TargetIndex, 1)
			return 1
		end
	end

	if valoraIndex > 0 then
		DataBase.SetDecreaseValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, valoraIndex, Taxa_Config.Moeda.Where, player1[Taxa_Config.Moeda.Tipo])
		SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(aIndex)][2], valorTargetIndex, Taxa_Config.Moeda.Nome), aIndex, 1)
	end
	
	if valorTargetIndex > 0 then
		DataBase.SetDecreaseValue(Taxa_Config.Moeda.Tabela, Taxa_Config.Moeda.Coluna, valorTargetIndex, Taxa_Config.Moeda.Where, player2[Taxa_Config.Moeda.Tipo])
		SendMessage(string.format(Taxa_Config.Message[GetLanguageObject(TargetIndex)][4], valorTargetIndex, Taxa_Config.Moeda.Nome), TargetIndex, 1)
	end
	return 0
end

function Taxa.OpenShop(aIndex)
	local pInv = Inventory.new(aIndex)
	for slot = 204, 235 do
		if pInv:isItem(slot) ~= 0 then
			if Taxa_Config.Itens[pInv:getIndex(slot)] ~= nil then
				SendMessage(Taxa_Config.Message[GetLanguageObject(aIndex)][1], aIndex, 1)
				pInv = nil
				return 1
			end
		end
	end

	pInv = nil
	return 0
end

Taxa.Init()

return Taxa