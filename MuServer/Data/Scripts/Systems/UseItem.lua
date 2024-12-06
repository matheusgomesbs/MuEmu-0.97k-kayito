UseItem = {}

function UseItem.Init()
	GameServerFunctions.GameServerProtocol(UseItem.Protocol)
end

function UseItem.TryUse(player, slot)
	local pInv = Inventory.new(player:getIndex())
	
	local item = pInv:getIndex(slot)
	
	if item == GET_ITEM(14, 303) then
		local vip = player:getVip()
		
	
		if vip == 1 then
			DataBase.Query(string.format("UPDATE MEMB_INFO SET AccountExpireDate = AccountExpireDate+1 WHERE memb___id = '%s'", player:getAccountID()))
			SendMessage("Você recebeu 1 dia de VIP Prata", player:getIndex(), 1)
			DeleteItemCount(player:getIndex(), item, -1, 1)
		
		else
			if vip == 0 then
				DataBase.SetValue("MEMB_INFO", "vip", 1, "memb___id", player:getAccountID())
				player:setVip(1)
				DataBase.Query(string.format("UPDATE MEMB_INFO SET AccountExpireDate = (GETDATE()+1) WHERE memb___id = '%s'", player:getAccountID()))
				SendMessage("Você recebeu 1 dia de VIP Prata", player:getIndex(), 1)
				DeleteItemCount(player:getIndex(), item, -1, 1)
			end
		end
	end
	
	
	if item == GET_ITEM(14, 276) then
		DataBase.SetAddValue("Character", "christmaspoints", 1, "Name", player:getName())	
		DeleteItemCount(player:getIndex(), item, -1, 1)
		SendMessage("Você recebeu 1 Christmas Points", player:getIndex(), 1)
	end		
	
	if item == GET_ITEM(14, 226) then
		DataBase.SetAddValue("MEMB_INFO", "hpoints", 250, "memb___id", player:getAccountID())
		DeleteItemCount(player:getIndex(), item, -1, 1)
		SendMessage("Você recebeu 250 HPoints", player:getIndex(), 1)
	end		
	
	if item == GET_ITEM(14, 225) then
		DataBase.SetAddValue("MEMB_INFO", "hpoints", 500, "memb___id", player:getAccountID())
		DeleteItemCount(player:getIndex(), item, -1, 1)
		SendMessage("Você recebeu 500 HPoints", player:getIndex(), 1)
	end	
	
	if item == GET_ITEM(14, 224) then
		DataBase.SetAddValue("MEMB_INFO", "hpoints", 1000, "memb___id", player:getAccountID())
		DeleteItemCount(player:getIndex(), item, -1, 1)
		SendMessage("Você recebeu 1000 HPoints", player:getIndex(), 1)
	end		
		
	
end

function UseItem.Protocol(aIndex, Packet, PacketName)

	if Packet == 88 then
		local player = User.new(aIndex)
		if PacketName == string.format("1-%s-%d", player:getName(), aIndex) then
			local slot = GetBytePacket(PacketName, -1)
			ClearPacket(PacketName)
			UseItem.TryUse(player, slot)			
			return true
		end
	end
	
	return false
end

UseItem.Init()

return UseItem