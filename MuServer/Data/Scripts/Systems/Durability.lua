Durability = { }

function Durability.Init()
    Commands.Register("/reparar",  Durability.Resposta)
end

function Durability.Resposta(aIndex, resposta)
	if CLEAR_INVENTORY_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	local Language = player:getLanguage()
	
	if resposta == 1 then
	    if player:getInterfaceUse() ~= 0 or player:getState() == 32 or player:getDieRegen() ~= 0 or player:getTeleport() ~= 0
	    then
	    	--SendMessage(string.format(LIMPAR_INVENTARIO_MESSAGES[Language][3]), aIndex, 38)
	    	--return
	    end
	    
	    local pInv = Inventory.new(aIndex)
	    local notEmpty = 0
	    
	    for i = 0, 15 do
	    	if pInv:isItem(i) == 1
	    	then
	    		notEmpty = notEmpty + 1
	    	end
	    end
	    
	    if notEmpty == 0
	    then
	    	SendMessage(string.format("O inventário está vázio"), aIndex, 38)
	    	return
	    end
	    
	    for i = 0, 15 do
	    	if pInv:isItem(i) == 1
	    	then
	    		pInv:setDurability(i, 255)
	    		pInv:convertItem(i)
	    		ItemListSend(aIndex)
	    	end
	    end
	end
end

function Durability.Protocol(aIndex, Packet, PacketName)
	
	if PacketName == "durability" then
	   local resposta = GetBytePacket(PacketName, -1)
	   ClearPacket(PacketName)
	   Durability.Resposta(aIndex, resposta)
	return true
	end
 

end

Durability.Init()

GameServerFunctions.GameServerProtocol(Durability.Protocol)

return Durability