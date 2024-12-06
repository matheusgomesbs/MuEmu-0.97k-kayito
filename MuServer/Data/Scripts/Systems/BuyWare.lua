BuyWare = {}

function BuyWare.Init()
	if BuyWare_Config.Enabled then
		Commands.Register(BuyWare_Config.Command["Eng"], BuyWare.Command)
		Commands.Register(BuyWare_Config.Command["Por"], BuyWare.Command)
		Commands.Register(BuyWare_Config.Command["Spn"], BuyWare.Command)
	end
end

function BuyWare.Command(aIndex)
	local player = User.new(aIndex)
	local vip = player:getVip()
	local lang = player:getLanguage()
	local playerInfo = {[0] = player:getAccountID(), [1] = player:getName()}
	if player:getInterfaceUse() ~= 0 or player:getInterfaceType() ~= 0 or player:getTeleport() ~= 0 or player:getDieRegen() ~= 0 then
		return
	end
	if BuyWare_Config.Coin[vip] == nil or BuyWare_Config.MaxVaults[vip] == nil then
		return
	end

	local coin = BuyWare_Config.Coin[vip]
	local balance = DataBase.GetValue(coin.Table, coin.Column, coin.Where, playerInfo[coin.IdType])
	
	if balance < coin.Price then
		SendMessage(string.format(BuyWare_Config.Message[lang][1], coin.Price, coin.Name), aIndex, 1)
		return
	end

	local vaultCount = DataBase.GetValue(TABLE_MULT_WAREHOUSE, COLUMN_MULT_WAREHOUSE, WHERE_MULT_WAREHOUSE, playerInfo[0])

	if vaultCount >= BuyWare_Config.MaxVaults[vip] then
		SendMessage(BuyWare_Config.Message[lang][2], aIndex, 1)
		return
	end

	DataBase.SetDecreaseValue(coin.Table, coin.Column, coin.Price, coin.Where, playerInfo[coin.IdType])

	DataBase.SetAddValue(TABLE_MULT_WAREHOUSE, COLUMN_MULT_WAREHOUSE, 1, WHERE_MULT_WAREHOUSE, playerInfo[0])

	SendMessage(string.format(BuyWare_Config.Message[lang][3], coin.Price, coin.Name), aIndex, 1)

	return
end

BuyWare.Init()

return BuyWare