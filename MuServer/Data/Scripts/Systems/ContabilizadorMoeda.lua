ContabilizadorCoin = {}
local Players = {}

function ContabilizadorCoin.Init()
	if ContabilizadorCoin_Ativado then
		GameServerFunctions.EnterCharacter(ContabilizadorCoin.PlayerJoin)
		GameServerFunctions.PlayerLogout(ContabilizadorCoin.PlayerLeft)
		ContabilizadorCoin.Load()
	end
end

function ContabilizadorCoin.Running(aIndex)
	local player = User.new(aIndex)
	local tipo = player:getAccountID()

	if Players[aIndex] ~= nil then
		Players[aIndex].Tempo = Players[aIndex].Tempo + 1
		if Players[aIndex].Tempo % 3600 == 0 then
			for index in ipairs(ContabilizadorCoinConfig) do
				local coin = ContabilizadorCoinConfig[index]
				DataBase.SetAddValue(coin.tabela, coin.column, coin.amountHour, coin.where, tipo)
			end

			Players[aIndex].Tempo = 0
			DataBase.SetValue(ContabilizadorCoin_Tabela, ContabilizadorCoin_ColunaTemp, 0, ContabilizadorCoin_Where, tipo)
		else
			if Players[aIndex].Tempo % 30 == 0 then
				DataBase.SetValue(ContabilizadorCoin_Tabela, ContabilizadorCoin_ColunaTemp, Players[aIndex].Tempo, ContabilizadorCoin_Where, tipo)
			end
		end
	end
end

function ContabilizadorCoin.PlayerLeft(aIndex)
	local player = User.new(aIndex)
	local playerLogin = player:getAccountID()

	if Players[aIndex] ~= nil then
		DataBase.SetValue(ContabilizadorCoin_Tabela, ContabilizadorCoin_ColunaTemp, Players[aIndex].Tempo, ContabilizadorCoin_Where, playerLogin)
		if Players[aIndex].Timer ~= -1 then
			Timer.Cancel(Players[aIndex].Timer)
		end
		Players[aIndex] = nil
	end
end

function ContabilizadorCoin.PlayerJoin(aIndex)
	local player = User.new(aIndex)
	local playerLogin = player:getAccountID()
    
	if Players[aIndex] == nil then
		table.insert(Players, aIndex)
		Players[aIndex] = {Tempo = 0, Timer = -1}
		local lastTime = DataBase.GetValue(ContabilizadorCoin_Tabela, ContabilizadorCoin_ColunaTemp, ContabilizadorCoin_Where, playerLogin)
		Players[aIndex].Tempo = lastTime
	else
		if Players[aIndex].Timer ~= -1 then
			Timer.Cancel(Players[aIndex].Timer)
			Players[aIndex].Timer = -1
		end

		local lastTime = DataBase.GetValue(ContabilizadorCoin_Tabela, ContabilizadorCoin_ColunaTemp, ContabilizadorCoin_Where, playerLogin)
		Players[aIndex].Tempo = lastTime
	end
	
	Players[aIndex].Timer = Timer.Interval(1, ContabilizadorCoin.Running, aIndex)
end

function ContabilizadorCoin.Load()
	for aIndex = 13000, 13999 do
		local player = User.new(aIndex)
		if player:getConnected() == 3 then
			local tipo = player:getAccountID()

			table.insert(Players, aIndex)
			Players[aIndex] = {Tempo = 0, Timer = -1}
			local lastTime = DataBase.GetValue(ContabilizadorCoin_Tabela, ContabilizadorCoin_ColunaTemp, ContabilizadorCoin_Where, tipo)
			Players[aIndex].Tempo = lastTime
			Players[aIndex].Timer = Timer.Interval(1, ContabilizadorCoin.Running, aIndex)
		end
	end
end

ContabilizadorCoin.Init()

return ContabilizadorCoin