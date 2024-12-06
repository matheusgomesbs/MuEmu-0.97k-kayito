--Coin1 = WcoinC
--Coin2 = EventPoints
--Coin3 = GlobinPoint

--if you want use jewel from JewelBank set 1 in ITEM_VALUE_COINX_JEWEL
--and set ITEM_VALUE_COINX_IDENTIFICATION like CacheName in config JewelBank 

ITEM_VALUE_COIN1_JEWEL = 0
ITEM_VALUE_COIN1_IDENTIFICATION = "ChaosPoints"

ITEM_VALUE_COIN2_JEWEL = 0
ITEM_VALUE_COIN2_IDENTIFICATION = "ChaosPoints"

ITEM_VALUE_COIN3_JEWEL = 0
ITEM_VALUE_COIN3_IDENTIFICATION = "ChaosPoints"

ITEM_VALUE_MESSAGES = {}

ITEM_VALUE_MESSAGES['Por'] = {
[1] = "você não possui %d WCoinC suficientes!",
[2] = "você não possui %d EventPoints suficientes!",
[3] = "você não possui %d GoblinPoint suficientes!",
[4] = "você recebeu por sua venda %d WCoinC",
[5] = "você recebeu por sua venda %d EventPoints",
[6] = "você recebeu por sua venda %d GoblinPoint",
[7] = "foi debitado %d WCoinC da sua conta",
[8] = "foi debitado %d EventPoints da sua conta",
[9] = "foi debitado %d GoblinPoint da sua conta",
}

ITEM_VALUE_MESSAGES['Eng'] = {
[1] = "You don't have enough %d WCoinC!",
[2] = "you don't have enough %d EventPoints!",
[3] = "You don't have enough %d GoblinPoint!",
[4] = "you received for your sale %d WCoinC",
[5] = "you received for your sale %d EventPoints",
[6] = "you received for your sale %d GoblinPoint",
[7] = "%d WCoinC has been debited from your account",
[8] = "%d EventPoints has been debited from your account",
[9] = "%d GoblinPoint has been debited from your account",
}

ITEM_VALUE_MESSAGES['Spn'] = {
[1] = "¡No tienes suficiente %d WCoinC!",
[2] = "¡no tienes suficiente %d EventPoints!",
[3] = "¡No tienes suficiente %d GoblinPoint!",
[4] = "recibió por su venta %d WCoinC",
[5] = "recibió por su venta %d EventPoints",
[6] = "recibiste por tu venta %d GoblinPoint",
[7] = "Se debitó %d WCoinC de su cuenta",
[8] = "Se debitó %d EventPoints de su cuenta",
[9] = "Se debitó %d GoblinPoint de su cuenta",
}

ItemValue = { }

function ItemBuyCheckCoins(aIndex, Coin1, Coin2, Coin3)
	local player = User.new(aIndex)
	
	local Coin1Check = 0
	local Coin2Check = 0
	local Coin3Check = 0
	
	if Coin1 > 0
	then
		if ITEM_VALUE_COIN1_JEWEL == 0
		then
			Coin1Check = player:getCoin1()
		else
			Coin1Check = player:getCacheInt(ITEM_VALUE_COIN1_IDENTIFICATION)
		end
	end
	
	if Coin2 > 0
	then
		if ITEM_VALUE_COIN2_JEWEL == 0
		then
			Coin2Check = player:getCoin2()
		else
			Coin2Check = player:getCacheInt(ITEM_VALUE_COIN2_IDENTIFICATION)
		end
	end
	
	if Coin3 > 0
	then
		if ITEM_VALUE_COIN3_JEWEL == 0
		then
			Coin3Check = player:getCoin3()
		else
			Coin3Check = player:getCacheInt(ITEM_VALUE_COIN3_IDENTIFICATION)
		end
	end

	player = nil
	
	return Coin1Check, Coin2Check, Coin3Check
end

function ItemBuyDecreaseCoins(aIndex, Coin1, Coin2, Coin3)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	local Coin1Decrease = 0
	local Coin2Decrease = 0
	local Coin3Decrease = 0

	local Jewel1Decrease = 0
	local Jewel2Decrease = 0
	local Jewel3Decrease = 0
	
	if Coin1 > 0
	then
		if ITEM_VALUE_COIN1_JEWEL == 0
		then
			Coin1Decrease = Coin1
		else
			Jewel1Decrease = Coin1
		end

		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][7], Coin1), aIndex, 1)
	end
	
	if Coin2 > 0
	then
		if ITEM_VALUE_COIN2_JEWEL == 0
		then
			Coin2Decrease = Coin2
		else
			Jewel2Decrease = Coin2
		end

		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][8], Coin2), aIndex, 1)
	end
	
	if Coin3 > 0
	then
		if ITEM_VALUE_COIN3_JEWEL == 0
		then
			Coin3Decrease = Coin3
		else
			Jewel3Decrease = Coin3
		end

		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][9], Coin3), aIndex, 1)
	end

	if Coin1Decrease > 0 or Coin2Decrease > 0  or Coin3Decrease > 0
	then
		RemoveCoins(player:getIndex(), Coin1Decrease, Coin2Decrease, Coin3Decrease)
	end

	if Jewel1Decrease > 0
	then
		JewelBank.DecreaseJewel(player, Jewel1Decrease, ITEM_VALUE_COIN1_IDENTIFICATION)
	end

	if Jewel2Decrease > 0
	then
		JewelBank.DecreaseJewel(player, Jewel2Decrease, ITEM_VALUE_COIN2_IDENTIFICATION)
	end

	if Jewel3Decrease > 0
	then
		JewelBank.DecreaseJewel(player, Jewel3Decrease, ITEM_VALUE_COIN3_IDENTIFICATION)
	end
	
	player = nil
end

function ItemSellAddCoins(aIndex, Coin1, Coin2, Coin3)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	local AddCoin1 = 0
	local AddCoin2 = 0
	local AddCoin3 = 0

	local AddJewel1 = 0
	local AddJewel2 = 0
	local AddJewel3 = 0
	
	if Coin1 > 0
	then
		if ITEM_VALUE_COIN1_JEWEL == 0
		then
			AddCoin1 = Coin1
		else
			AddJewel1 = Coin1
		end

		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][4], Coin1), aIndex, 1)
	end
	
	if Coin2 > 0
	then
		if ITEM_VALUE_COIN2_JEWEL == 0
		then
			AddCoin2 = Coin2
		else
			AddJewel2 = Coin2
		end

		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][5], Coin2), aIndex, 1)
	end
	
	if Coin3 > 0
	then
		if ITEM_VALUE_COIN3_JEWEL == 0
		then
			AddCoin3 = Coin3
		else
			AddJewel3 = Coin3
		end 

		SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][6], Coin3), aIndex, 1)
	end

	if AddCoin1 > 0 or AddCoin2 > 0 or AddCoin3 > 0
	then
		AddCoins(player:getIndex(), AddCoin1, AddCoin2, AddCoin3)
	end

	if AddJewel1 > 0
	then
		JewelBank.AddJewel(player, AddJewel1, ITEM_VALUE_COIN1_IDENTIFICATION)
	end

	if AddJewel2 > 0
	then
		JewelBank.AddJewel(player, AddJewel2, ITEM_VALUE_COIN2_IDENTIFICATION)
	end

	if AddJewel3 > 0
	then
		JewelBank.AddJewel(player, AddJewel3, ITEM_VALUE_COIN3_IDENTIFICATION)
	end
	
	player = nil
end

function ItemBuyBuyError(aIndex, CoinsNeed, Coin)
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	SendMessage(string.format(ITEM_VALUE_MESSAGES[Language][Coin], CoinsNeed), aIndex, 1)
	
	player = nil
end

return ItemValue