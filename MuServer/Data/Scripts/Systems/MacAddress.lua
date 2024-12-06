RegisterHWID = {}

function RegisterHWID.MacAddressPlayer(aIndex, Mac)
	local player = User.new(aIndex)
	
	if player:getMacAddress() ~= Mac 
	then
		DataBase.SetString('MEMB_STAT', 'HWID', Mac, 'memb___id', player:getAccountID())
	end
end

GameServerFunctions.MacAddressPlayer(RegisterHWID.MacAddressPlayer)

return RegisterHWID