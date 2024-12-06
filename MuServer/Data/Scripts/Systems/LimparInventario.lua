LimparInventario = { }


function LimparInventario.Resposta(aIndex, resposta)
	if CLEAR_INVENTORY_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if resposta == 1 then
	if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	then
		SendMessage(string.format(LIMPAR_INVENTARIO_MESSAGES[Language][3]), aIndex, 38)
		return
	end

	if player:getLock() > 0
	then
		SendMessage(string.format(LOCK_COMMAND_MESSAGES[Language][6]), aIndex, 38)
        return
	end

	local pInv = Inventory.new(aIndex)
	local notEmpty = 0
	
	for i = 12, 75 do
		if pInv:isItem(i) == 1
		then
			notEmpty = notEmpty + 1
		end
	end
	
	if notEmpty == 0
	then
		SendMessage(string.format(LIMPAR_INVENTARIO_MESSAGES[Language][1]), aIndex, 38)
		return
	end
	
	for i = 12, 75 do
		if pInv:isItem(i) == 1
		then
			InventoryDeleteItem(aIndex, i)
			SendInventoryDeleteItem(aIndex, i)
		end
	end
	
	SendMessage(string.format(LIMPAR_INVENTARIO_MESSAGES[Language][2]), aIndex, 37)
	
	end
end

function LimparInventario.Protocol(aIndex, Packet, PacketName)
	
	--if Packet ~= 0x7541 then return end
	
	if PacketName == "clearinv" then
	   local resposta = GetBytePacket(PacketName, -1)
	   ClearPacket(PacketName)
	   LimparInventario.Resposta(aIndex, resposta)
	return true
	end
 

end

GameServerFunctions.GameServerProtocol(LimparInventario.Protocol)

return LimparInventario