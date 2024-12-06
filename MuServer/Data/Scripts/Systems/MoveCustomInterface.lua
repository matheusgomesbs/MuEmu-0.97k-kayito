MoveCustomInterface = {}

local MoveCustom_Packet = 0x48
local MoveCustomInterfaceSwitch = true

function MoveCustomInterface.Init()
    if MoveCustomInterfaceSwitch then 
        GameServerFunctions.GameServerProtocol(MoveCustomInterface.ClientProtocol)
	    math.randomseed(os.clock() * os.time()/7^9)
    end
end

function MoveCustomInterface.ClientProtocol(aIndex, packet, packetName)

    if packet == MoveCustom_Packet then
		if packetName == "GS_MoveCustom" then

			local mapSelect = GetCharPacketLength(packetName, -1, 10)
			local destination = GetCharPacketLength(packetName, -1, 10)
			local mapNumber = GetDwordPacket(packetName, -1)
			local cdX = GetDwordPacket(packetName, -1)
			local cdY = GetDwordPacket(packetName, -1)

			Teleport(aIndex, mapNumber, cdX, cdY)
					
			if destination ~= 'nil' then 
				SendMessage(string.format('Bem-vindo a %s | %s', mapSelect, destination), aIndex, 1)
			else 
				SendMessage(string.format('Bem-vindo a %s', mapSelect), aIndex, 1)
			end

            ClearPacket(packetName)
		end
	end
end

MoveCustomInterface.Init()

return MoveCustomInterface