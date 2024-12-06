Lojinha = {}

local Switch_Coin1 = 1
local Switch_Coin2 = 1
local Switch_Coin3 = 1
local Switch_Coin4 = 1

local PERSONAL_SHOP_COIN_TABLE = {}
PERSONAL_SHOP_COIN_TABLE[0] = 'MEMB_INFO'
PERSONAL_SHOP_COIN_TABLE[1] = 'MEMB_INFO'
PERSONAL_SHOP_COIN_TABLE[2] = 'MEMB_INFO'
PERSONAL_SHOP_COIN_TABLE[3] = 'MEMB_INFO'

local PERSONAL_SHOP_COIN_COLUMN = {}
PERSONAL_SHOP_COIN_COLUMN[0] = 'hpoints'
PERSONAL_SHOP_COIN_COLUMN[1] = 'cash'
PERSONAL_SHOP_COIN_COLUMN[2] = 'jcpoints'
PERSONAL_SHOP_COIN_COLUMN[3] = 'HorasOn'

local PERSONAL_SHOP_COIN_WHERE = {}
PERSONAL_SHOP_COIN_WHERE[0] = 'memb___id'
PERSONAL_SHOP_COIN_WHERE[1] = 'memb___id'
PERSONAL_SHOP_COIN_WHERE[2] = 'memb___id'
PERSONAL_SHOP_COIN_WHERE[3] = 'memb___id'

local PERSONAL_SHOP_COIN_NAME = {}
PERSONAL_SHOP_COIN_NAME[0] = 'Coin1'
PERSONAL_SHOP_COIN_NAME[1] = 'Coin2'
PERSONAL_SHOP_COIN_NAME[2] = 'Coin3'
PERSONAL_SHOP_COIN_NAME[3] = 'Coin4'

--[[ Functions ]]--
function Lojinha.CheckPersonalShopValue(aIndex, ItemIndex, Coin1, Coin2, Coin3, Coin4)
	local player = User.new(aIndex)
	local Account = player:getAccountID()

	if Switch_Coin1 == 1
	then
		if Coin1 > 0
		then
			local AccountCoin1 = DataBase.GetValue(PERSONAL_SHOP_COIN_TABLE[0], PERSONAL_SHOP_COIN_COLUMN[0], PERSONAL_SHOP_COIN_WHERE[0], Account)
			
			if(AccountCoin1 < Coin1)
			then
			  --  SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][9], AccountCoin1), aIndex, 1)
				return 25
			end
		end
	end
	
	if Switch_Coin2 == 1
	then
		if Coin2 > 0
		then
			local AccountCoin2 = DataBase.GetValue(PERSONAL_SHOP_COIN_TABLE[1], PERSONAL_SHOP_COIN_COLUMN[1], PERSONAL_SHOP_COIN_WHERE[1], Account)
			
			if(AccountCoin2 < Coin2)
			then
		 --    	SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][10], Coin2), aIndex, 1)
				return 26
			end
		end
	end
	
	if Switch_Coin3 == 1
	then
		if Coin3 > 0
		then
			local AccountCoin3 = DataBase.GetValue(PERSONAL_SHOP_COIN_TABLE[2], PERSONAL_SHOP_COIN_COLUMN[2], PERSONAL_SHOP_COIN_WHERE[2], Account)
			
			if(AccountCoin3 < Coin3)
			then
		    	--SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][11], Coin3), aIndex, 1)
				return 27
			end
		end
	end
	
	if Switch_Coin4 == 1
	then
		if Coin4 > 0
		then
			local AccountCoin4 = DataBase.GetValue(PERSONAL_SHOP_COIN_TABLE[3], PERSONAL_SHOP_COIN_COLUMN[3], PERSONAL_SHOP_COIN_WHERE[3], Account)
			
			if(AccountCoin4 < Coin4)
			then
			  -- SendMessage(string.format(PERSONAL_SHOP_MESSAGES[Language][12], Coin4), aIndex, 1)
				return 28
			end
		end
	end
	
	return 1
end

function Lojinha.PersonalShopAddValue(aIndex, Coin1, Coin2, Coin3, Coin4)
	local player = User.new(aIndex)
	local Account = player:getAccountID()

	if Switch_Coin1 == 1
	then
		if(Coin1 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_COIN_TABLE[0], PERSONAL_SHOP_COIN_COLUMN[0], Coin1, PERSONAL_SHOP_COIN_WHERE[0], Account)
		end
	end
	
	if Switch_Coin2 == 1
	then
		if(Coin2 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_COIN_TABLE[1], PERSONAL_SHOP_COIN_COLUMN[1], Coin2, PERSONAL_SHOP_COIN_WHERE[1], Account)
		end
	end
	
	if Switch_Coin3 == 1
	then
		if(Coin3 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_COIN_TABLE[2], PERSONAL_SHOP_COIN_COLUMN[2], Coin3, PERSONAL_SHOP_COIN_WHERE[2], Account)
		end
	end

	if Switch_Coin4 == 1
	then
		if(Coin4 > 0)
		then
			DataBase.SetAddValue(PERSONAL_SHOP_COIN_TABLE[3], PERSONAL_SHOP_COIN_COLUMN[3], Coin4, PERSONAL_SHOP_COIN_WHERE[3], Account)
		end
	end
end

function Lojinha.PersonalShopDecreaseValue(aIndex, Coin1, Coin2, Coin3, Coin4)
	local player = User.new(aIndex)
	local Account = player:getAccountID()

	if Switch_Coin1 == 1
	then
		if(Coin1 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_COIN_TABLE[0], PERSONAL_SHOP_COIN_COLUMN[0], Coin1, PERSONAL_SHOP_COIN_WHERE[0], Account)
		end
	end
	
	if Switch_Coin2 == 1
	then
		if(Coin2 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_COIN_TABLE[1], PERSONAL_SHOP_COIN_COLUMN[1], Coin2, PERSONAL_SHOP_COIN_WHERE[1], Account)
		end
	end
	
	if Switch_Coin3 == 1
	then
		if(Coin3 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_COIN_TABLE[2], PERSONAL_SHOP_COIN_COLUMN[2], Coin3, PERSONAL_SHOP_COIN_WHERE[2], Account)
		end
	end

	if Switch_Coin4 == 1
	then
		if(Coin4 > 0)
		then
			DataBase.SetDecreaseValue(PERSONAL_SHOP_COIN_TABLE[3], PERSONAL_SHOP_COIN_COLUMN[3], Coin4, PERSONAL_SHOP_COIN_WHERE[3], Account)
		end
	end
	
end

GameServerFunctions.PersonalShopCheckValue(Lojinha.CheckPersonalShopValue)
GameServerFunctions.PersonalShopAddValue(Lojinha.PersonalShopAddValue)
GameServerFunctions.PersonalShopDecreaseValue(Lojinha.PersonalShopDecreaseValue)


return Lojinha