Ranking = {}

Ranking.PlayerDelay = {}

function Ranking.Init()
    GameServerFunctions.GameServerProtocol(Ranking.Protocol)
    GameServerFunctions.QueryAsyncProcess(Ranking.QueryAsyncProcess)
end

function Ranking.Protocol(aIndex, Packet, PacketName)
    if Packet ~= Ranking_Config.Packet then return false end
    
    local player = User.new(aIndex)
    local playerInfo = {[0] = player:getAccountID(), [1] = player:getName()}

    if PacketName == string.format("1-%s-%d", playerInfo[1], aIndex) then
        if Ranking.PlayerDelay[aIndex] ~= nil then 
            ClearPacket(PacketName)
            return true
        end

        table.insert(Ranking.PlayerDelay, aIndex)
        Ranking.PlayerDelay[aIndex] = 1

        local t = GetBytePacket(PacketName, -1)
        local categorie = GetBytePacket(PacketName, -1)
        ClearPacket(PacketName)
        local r = Ranking_Config.Categories[categorie]
        if r == nil then
            LogAdd("Bad config in Ranking system")
            return true
        end
        local query = ""
        if r.Time.Show then
            query = string.format("SELECT TOP 10 %s as Name, %s as Points, %s as Tempo FROM %s ORDER BY %s DESC, %s ASC", r.PlayerColumn, r.PointsColumn, r.Time.Column, r.Table, r.PointsColumn, r.PlayerColumn)
            if t == 0 then
                CreateAsyncQuery('RankingGetListOpenT', query, aIndex, 1)
            else
                CreateAsyncQuery('RankingGetListUpdateT', query, aIndex, 1)
            end
        else
            query = string.format("SELECT TOP 10 %s as Name, %s as Points FROM %s ORDER BY %s DESC, %s ASC", r.PlayerColumn, r.PointsColumn, r.Table, r.PointsColumn, r.PlayerColumn)
            if t == 0 then
                CreateAsyncQuery('RankingGetListOpen', query, aIndex, 1)
            else
                CreateAsyncQuery('RankingGetListUpdate', query, aIndex, 1)
            end
        end
        
        return true
    end
end

function Ranking.QueryAsyncProcess(queryName, identification, aIndex)
    if queryName ~= "RankingGetListOpen" and queryName ~= "RankingGetListUpdate" and queryName ~= "RankingGetListOpenT" and queryName ~= "RankingGetListUpdateT" then return end
    local t = {}

    if queryName == "RankingGetListOpenT" or queryName == "RankingGetListUpdateT" then
        for n = 1, 10 do
            local name = QueryAsyncGetValue(identification, 'Name')
            local points = tonumber(QueryAsyncGetValue(identification, 'Points'))
            local tempo = tonumber(QueryAsyncGetValue(identification, 'Tempo'))
            if name == nil or name == "nil" then break end

            table.insert(t, n)
            t[n] = {Name = name, Points = points, Tempo = tempo}
        end
    else
        for n = 1, 10 do
            local name = QueryAsyncGetValue(identification, 'Name')
            local points = tonumber(QueryAsyncGetValue(identification, 'Points'))
            if name == nil or name == "nil" then break end

            table.insert(t, n)
            t[n] = {Name = name, Points = points, Tempo = 0}
        end
    end
	
    QueryAsyncDelete(identification)

    local p = 2
    if queryName == "RankingGetListUpdate" or queryName == "RankingGetListUpdateT" then p = 3 end

    local player = User.new(aIndex)
    local playerInfo = {[0] = player:getAccountID(), [1] = player:getName()}

    local packetname = string.format("%d-%s-%d", p, playerInfo[1], aIndex)
    CreatePacket(packetname, Ranking_Config.Packet)
    SetBytePacket(packetname, #t)
    for n = 1, #t do
        local len = t[n].Name:len()
        SetBytePacket(packetname, len)
        SetCharPacketLength(packetname, t[n].Name, len)
        SetDwordPacket(packetname, t[n].Points)
        SetDwordPacket(packetname, t[n].Tempo)
    end
    SendPacket(packetname, aIndex)
    ClearPacket(packetname)
    Ranking.PlayerDelay[aIndex] = nil
    return 1
end


Ranking.Init()

return Ranking