--[[Map System]]--

MapSystem = {}

local MAP_SYSTEM_SWITCH = 0

--[[
-- 1 Não pode
-- 0 Pode
--]]

CONFIG_MAPS = {}

CONFIG_MAPS[0] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[1] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[2] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[3] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[4] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[5] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[6] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[7] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[8] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[9] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[10] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[11] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[12] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[13] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[14] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[15] = {BlockTrade = 0 , War = 0}
CONFIG_MAPS[16] = {BlockTrade = 0 , War = 0}

function MapSystem.Init()
	if MAP_SYSTEM_SWITCH == 0
	then
		return
	end
	
	--Detect Send Trade
	GameServerFunctions.PlayerSendTrade(MapSystem.CanUseTrade)
	--Detect Send War
	GameServerFunctions.DeclareWar(MapSystem.DeclareWar)
end

function MapSystem.CanUseTrade(aIndex, TargetIndex)
	local mapInfo = CONFIG_MAPS[GetMapObject(aIndex)]

	if mapInfo ~= nil
	then
		if mapInfo.BlockTrade == 1
		then
			return 1
		end
	end
	
	return 0
end

function MapSystem.DeclareWar(aIndex)
	local mapInfo = CONFIG_MAPS[GetMapObject(aIndex)]

	if mapInfo ~= nil
	then
		if mapInfo.War == 1
		then
			return 1
		end
	end
	
	return 0
end

MapSystem.Init()

return MapSystem