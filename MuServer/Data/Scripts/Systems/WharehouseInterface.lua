WharehouseInterface = {}

local wharehouseInterfaceSwitch = true
local packetName = 'WHouse_%s'
local vaultChange = 'WHouse_Change_%s'
local packetNumber = 0x66

function WharehouseInterface.Init()
    if wharehouseInterfaceSwitch then
        GameServerFunctions.PlayerVaultOpen(WharehouseInterface.OpenVault)
        GameServerFunctions.EnterCharacter(WharehouseInterface.EnterCharacter)
        GameServerFunctions.GameServerProtocol(WharehouseInterface.GameServerProtocol)
    end
end

function WharehouseInterface.EnterCharacter(aIndex)
    WharehouseInterface.SendPacket(aIndex)
end

function WharehouseInterface.OpenVault(aIndex)
    WharehouseInterface.SendPacket(aIndex)
end

function WharehouseInterface.GameServerProtocol(aIndex, packet, packetName)
	if packet ~= packetNumber then return false end
    local user = User.new(aIndex)
    local name = user:getName()

    local pNameOpenVault = string.format(vaultChange, name)
 
    if packetName == pNameOpenVault then 
        local vaultToChange = GetDwordPacket(packetName, -1)
        WharehouseInterface.ChangeVault(aIndex, vaultToChange)
		ClearPacket(packetName)
		return true
    end
end

function WharehouseInterface.SendPacket(aIndex)
    local player = User.new(aIndex)
    local name = player:getName()

    local ptName = string.format(packetName, name)

    local vaultCounts = DataBase.GetValue("warehouse", "VaultCounts", "AccountID", player:getAccountID())
    local vaultSelect = DataBase.GetValue("warehouse", "LastVaultID", "AccountID", player:getAccountID())

    CreatePacket(ptName, packetNumber)
    SetDwordPacket(ptName, vaultCounts)
    SetDwordPacket(ptName, vaultSelect)
    SendPacket(ptName, aIndex)
    ClearPacket(ptName)
end

function WharehouseInterface.ChangeVault(aIndex, numberVault)

	local player = User.new(aIndex)
	local Language = player:getLanguage()
	local Number = numberVault

	if Number < 0 then
		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][1]), aIndex, 1)
		return
	end
	
	if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0 then
		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][2]), aIndex, 1)
		return
	end
	
	if player:getLevel() < MULT_VAULT_LEVEL
	then
		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][3], MULT_VAULT_LEVEL), aIndex, 1)
		return
	end
	
	local money = player:getMoney()
	
	if money < MULT_VAULT_MONEY
	then
		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][4], MULT_VAULT_MONEY), aIndex, 1)
		return
	end
	
	local vip = DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, player:getAccountID())
	
	if vip < MULT_VAULT_VIP
	then
		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][5]), aIndex, 1)
		return
	end
	
	local Name = player:getName()

	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Name) < MULT_VAULT_RESETS
	then
		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][6], MULT_VAULT_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Name) < MULT_VAULT_MRESETS
	then
		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][7], MULT_VAULT_MRESETS), aIndex, 1)
		return
	end
	
	local vaults = -1
	
	player:setReqWarehouseOpen(1)
	
	if MULT_VAULT_TYPE == 1
	then
		vaults = MULT_VAULT_COUNT[vip]
		
		if vaults == -1 or vaults == nil
		then
			SendMessage(string.format(WAREHOUSE_MESSAGES[Language][8]), aIndex, 1)
			player:setReqWarehouseOpen(0)
			
			return
		end

		if Number > vaults
		then
			SendMessage(string.format(WAREHOUSE_MESSAGES[Language][9]), aIndex, 1)
			player:setReqWarehouseOpen(0)
			return
		end

		TrocarBauPlayer(aIndex, Number)

		DataBase.SetValue(TABLE_LAST_VAULT_ID_WAREHOUSE, COLUMN_LAST_VAULT_ID_WAREHOUSE, Number, WHERE_LAST_VAULT_ID_WAREHOUSE, player:getAccountID())

		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][10]), aIndex, 1)

		player:setReqWarehouseOpen(0)

        WharehouseInterface.OpenVaultChanged(aIndex)
	else
		vaults = DataBase.GetValue(TABLE_MULT_WAREHOUSE, COLUMN_MULT_WAREHOUSE, WHERE_MULT_WAREHOUSE, player:getAccountID())

		if vaults <= 0
		then
			SendMessage(string.format(WAREHOUSE_MESSAGES[Language][8]), aIndex, 1)
			player:setReqWarehouseOpen(0)

			return
		end

		if Number > vaults
		then
			SendMessage(string.format(WAREHOUSE_MESSAGES[Language][9]), aIndex, 1)
			player:setReqWarehouseOpen(0)

			return
		end

		TrocarBauPlayer(aIndex, Number)

		DataBase.SetValue(TABLE_LAST_VAULT_ID_WAREHOUSE, COLUMN_LAST_VAULT_ID_WAREHOUSE, Number, WHERE_LAST_VAULT_ID_WAREHOUSE, player:getAccountID())

		SendMessage(string.format(WAREHOUSE_MESSAGES[Language][10]), aIndex, 1)
		player:setReqWarehouseOpen(0)

        WharehouseInterface.OpenVaultChanged(aIndex)
	end
end

function WharehouseInterface.OpenVaultChanged(aIndex)
    WharehouseInterface.SendPacket(aIndex)

    local player = User.new(aIndex)

    player:setTargetShopNumber(100)
	player:setReqWarehouseOpen(1)
	player:setWarehouseCount(0)

	player:setInterfaceUse(1)
	player:setInterfaceType(6)
	player:setInterfaceState(0)

	GetWarehouseList(aIndex, player:getAccountID())
end

WharehouseInterface.Init()

return WharehouseInterface