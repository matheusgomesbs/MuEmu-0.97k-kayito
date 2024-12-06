WarKill = {}

function WarKill.Init()
   
    
    if WarKill_Config.Ativado then
        Commands.Register(WarKill_Config.Comando.Abrir, WarKill.ComandoAbrir)
        Commands.Register(WarKill_Config.Comando.Iniciar, WarKill.ComandoIniciar)
        Commands.Register(WarKill_Config.Comando.Cancelar, WarKill.ComandoCancelar)
        Commands.Register(WarKill_Config.Comando.Ir, WarKill.ComandoIr)
        Commands.Register(WarKill_Config.Comando.Premiar, WarKill.ComandoPremiar)
        GameServerFunctions.PlayerAttack(WarKill.PlayerAttack)
        GameServerFunctions.PlayerDie(WarKill.PlayerDie)
        WarKill.Define()
    end
end

function WarKill.Define()
    WarKill_Config.Guild = {}
    WarKill_Config.Players = {}
    WarKill_Config.EventStatus = {
        Running = false,
        Started = false,
        Open = false,
        Waiting = false,
        Timer = 0,
        Time = WarKill_Config.Tempo,
        Repeat = 0,
        TimerPremiar = 0,
	TimerAnuncio = 0
    }
    WarKill_Config.GuildVencedora = {
        [1] = {Nome = "-", Pontos = -1, GM = ""},
        [2] = {Nome = "-", Pontos = -1, GM = ""},
        [3] = {Nome = "-", Pontos = -1, GM = ""},
    }
    WarKill_Config.TimerCheckUsers = 0
    WarKill_Config.GameMaster = 0
end

function WarKill.ComandoAbrir(aIndex, Arguments)
    local p = User.new(aIndex)
    if p:getAuthority() <= 1 then p = nil; return end

    local lang = p:getLanguage()

    p = nil

    if WarKill_Config.EventStatus.Running then 
        if WarKill_Config.EventStatus.Started then
            SendMessage(string.format(WarKill_Config.Message[lang][1].Text, WarKill_Config.Comando.Cancelar), aIndex, WarKill_Config.Message[lang][1].Color)   
            return
        end

        if not WarKill_Config.EventStatus.Started and not WarKill_Config.EventStatus.Waiting then
            SendMessage(string.format(WarKill_Config.Message[lang][28].Text, WarKill_Config.Comando.Iniciar), aIndex, WarKill_Config.Message[lang][28].Color)   
            return
        end

        if WarKill_Config.EventStatus.Waiting then
            SendMessage(string.format(WarKill_Config.Message[lang][19].Text, WarKill_Config.Comando.Premiar), aIndex, WarKill_Config.Message[lang][19].Color)   
            return
        end
    end

    local tempo = command:getNumber(Arguments, 1)
    
    if tempo == nil or tempo <= 0 then
        SendMessage(string.format(WarKill_Config.Message[lang][2].Text, WarKill_Config.Comando.Abrir), aIndex, WarKill_Config.Message[lang][2].Color)
        return
    end

    WarKill_Config.EventStatus.Running = true
    WarKill_Config.EventStatus.Open = true
    WarKill_Config.EventStatus.Repeat = tempo

    WarKill_Config.GameMaster = aIndex

    WarKill_Config.EventStatus.TimerAnuncio =  Timer.Repeater(1, tempo, WarKill.AnnounceOpen)
    return
end

function WarKill.ComandoIniciar(aIndex)
    local p = User.new(aIndex)
    if p:getAuthority() <= 1 then p = nil; return end

    local lang = p:getLanguage()

    p = nil

    if not WarKill_Config.EventStatus.Running then
        SendMessage(string.format(WarKill_Config.Message[lang][7].Text, WarKill_Config.Comando.Abrir), aIndex, WarKill_Config.Message[lang][7].Color)   
        return
    end

    if WarKill_Config.EventStatus.Started then
        SendMessage(string.format(WarKill_Config.Message[lang][12].Text), aIndex, WarKill_Config.Message[lang][12].Color)   
        return
    end

    if WarKill_Config.EventStatus.Waiting then
        SendMessage(string.format(WarKill_Config.Message[lang][15].Text, WarKill_Config.Comando.Premiar, WarKill_Config.Comando.Cancelar), aIndex, WarKill_Config.Message[lang][15].Color)   
        return
    end

    if WarKill_Config.GMObrigatorio then
        for a, G_Name in ipairs(WarKill_Config.Guild) do
            local gmOn = false
            for b, bIndex in ipairs(WarKill_Config.Players) do
                if WarKill_Config.Players[bIndex].Guild == WarKill_Config.Guild[G_Name].Nome then
                    if WarKill_Config.Players[bIndex].Tipo[1] == WarKill_Config.Guild[G_Name].GM then
                        gmOn = true
                    end
                end
            end
            if not gmOn then
                for b, bIndex in ipairs(WarKill_Config.Players) do
                    if WarKill_Config.Players[bIndex].Guild == WarKill_Config.Guild[G_Name].Nome then
                        Teleport(bIndex, 0, 125, 125)
                        SendMessage(string.format(WarKill_Config.Message[WarKill_Config.Players[bIndex].Lang][26].Text), aIndex, WarKill_Config.Message[WarKill_Config.Players[bIndex].Lang][26].Color)
                        table.remove(WarKill_Config.Players, b)
                    end
                end
                table.remove(WarKill_Config.Guild, a)
            end            
        end
    end

    if #WarKill_Config.Guild < 2 then
        WarKill.Define()
        SendMessage(string.format(WarKill_Config.Message[lang][11].Text), aIndex, WarKill_Config.Message[lang][11].Color)
        return
    end

    WarKill_Config.TimerCheckUsers = Timer.Interval(2, WarKill.CheckUsers)
    WarKill_Config.EventStatus.Timer = Timer.TimeOut(WarKill_Config.Tempo*60, WarKill.EndEvent, 0)
    WarKill_Config.EventStatus.Started = true

    SendMessageGlobal(string.format("===~> War Kill <~==="), 0)
    SendMessageGlobal(string.format(" "), 0)
    WarKill.SendMessageGlobal(13)
    SendMessageGlobal(string.format(" "), 0)
    SendMessageGlobal(string.format("=================="), 0)
    return
end

function WarKill.ComandoCancelar(aIndex)
    local p = User.new(aIndex)
    if p:getAuthority() <= 1 then p = nil; return end

    local lang = p:getLanguage()

    p = nil

    if not WarKill_Config.EventStatus.Running then
        SendMessage(string.format(WarKill_Config.Message[lang][7].Text, WarKill_Config.Comando.Abrir), aIndex, WarKill_Config.Message[lang][7].Color)   
        return
    end

    if WarKill_Config.TimerCheckUsers ~= 0 then
        Timer.Cancel(WarKill_Config.TimerCheckUsers)
    end

    if WarKill_Config.EventStatus.TimerPremiar ~= 0 then
        Timer.Cancel(WarKill_Config.EventStatus.TimerPremiar)
    end
    
    if  WarKill_Config.EventStatus.TimerAnuncio ~= 0 then
	 Timer.Cancel(WarKill_Config.EventStatus.TimerAnuncio)
    end

    WarKill.Define()

    SendMessage(string.format(WarKill_Config.Message[lang][8].Text), aIndex, WarKill_Config.Message[lang][8].Color)   
    return
end

function WarKill.ComandoIr(aIndex)
    local p = User.new(aIndex)
    local lang = p:getLanguage()
    local guild = p:getGuildName()
    local name = p:getName()
    local acc = p:getAccountID()
    p = nil

    if not WarKill_Config.EventStatus.Open then return end

    if guild:len() <= 0 then
        SendMessage(string.format(WarKill_Config.Message[lang][9].Text), aIndex, WarKill_Config.Message[lang][9].Color)   
        return
    end

    local gmaster = DataBase.GetString("Guild", "G_Master", "G_Name", guild)
    if WarKill_Config.Guild[guild] == nil then
        table.insert(WarKill_Config.Guild, guild)
        WarKill_Config.Guild[guild] = {Nome = guild, Pontos = 0, GM = gmaster}
    end

    if  WarKill_Config.Players[aIndex] == nil then
        table.insert(WarKill_Config.Players, aIndex)
        WarKill_Config.Players[aIndex] = {Tipo = {[0] = acc, [1] = name}, Lang = lang, Guild = guild}
    end

    Teleport(aIndex, WarKill_Config.Local.Move.Mapa, WarKill_Config.Local.Move.X, WarKill_Config.Local.Move.Y)
    SendMessage(string.format(WarKill_Config.Message[lang][10].Text), aIndex, WarKill_Config.Message[lang][10].Color) 
    return
end

function WarKill.PlayerAttack(aIndex)
    if WarKill_Config.EventStatus.Running then
        if not WarKill_Config.EventStatus.Started and not WarKill_Config.EventStatus.Waiting then
            if WarKill_Config.Players[aIndex] ~= nil then
                local lang = GetLanguageObject(aIndex)
                SendMessage(WarKill_Config.Message[lang][20].Text, aIndex, WarKill_Config.Message[lang][20].Color)
                return 1 
            end
        end
    end
    return 0
end

function WarKill.PlayerDie(aIndex, bIndex)
    if WarKill_Config.EventStatus.Running then
        if not WarKill_Config.EventStatus.Started or WarKill_Config.EventStatus.Waiting then
            goto fim
        end

        if WarKill_Config.Players[aIndex] == nil or WarKill_Config.Players[bIndex] == nil then 
            goto fim
        end

        local p1 = User.new(aIndex)
        local p1Inv = Inventory.new(aIndex)
        local lang = p1:getLanguage()
        local name = p1:getName()
        local guild = p1:getGuildName()
        local isGM = false
        local index = p1Inv:getIndex(0)
        local serial = p1Inv:getSerial(0)
        p1 = nil
        p1Inv = nil
        if name == WarKill_Config.Guild[guild].GM then
            isGM = true
        end        
        local playerMatou = {Name = name, Lang = lang, Guild = guild, IsGM = isGM, Index = index, Serial = serial}

        local p2 = User.new(bIndex)
        local p2Inv = Inventory.new(bIndex)
        lang = p2:getLanguage()
        name = p2:getName()
        guild = p2:getGuildName()
        isGM = false
        index = p2Inv:getIndex(0)
        serial = p2Inv:getSerial(0)
        p2 = nil
        p2Inv = nil
        if name == WarKill_Config.Guild[guild].GM then
            isGM = true
        end        
        local playerMorreu = {Name = name, Lang = lang, Guild = guild, IsGM = isGM, Index = index, Serial = serial}

        WarKill.SendMessageGlobalKill(playerMatou.Guild, playerMatou.Name, playerMorreu.Guild, playerMorreu.Name)

        if playerMatou.Guild == playerMorreu.Guild then
            local pontos = WarKill_Config.Pontos.PerdeAoMorrer.Membro
            if playerMorreu.IsGM then
                pontos = WarKill_Config.Pontos.PerdeAoMorrer.GM
            end

            pontos = pontos*2

            if WarKill_Config.Guild[playerMorreu.Guild].Pontos < pontos then
                WarKill_Config.Guild[playerMorreu.Guild].Pontos = 0
            else
                WarKill_Config.Guild[playerMorreu.Guild].Pontos = WarKill_Config.Guild[playerMorreu.Guild].Pontos - pontos
            end

            SendMessage(string.format(WarKill_Config.Message[playerMatou.Lang][22].Text, pontos), aIndex, WarKill_Config.Message[playerMatou.Lang][22].Color)
            SendMessage(string.format(WarKill_Config.Message[playerMorreu.Lang][22].Text, pontos), bIndex, WarKill_Config.Message[playerMorreu.Lang][22].Color)
        else
            local pontosPerder = WarKill_Config.Pontos.PerdeAoMorrer.Membro
            local pontosGanhar = WarKill_Config.Pontos.GanhaAoMatar.Membro
            if playerMorreu.IsGM then
                pontosPerder = WarKill_Config.Pontos.PerdeAoMorrer.GM
                pontosGanhar = WarKill_Config.Pontos.GanhaAoMatar.GM
            end
            if playerMatou.IsGM then
                pontosGanhar = pontosGanhar*2
                pontosPerder = pontosPerder*2
            end

            if WarKill_Config.Guild[playerMorreu.Guild].Pontos < pontosPerder then
                WarKill_Config.Guild[playerMorreu.Guild].Pontos = 0
            else
                WarKill_Config.Guild[playerMorreu.Guild].Pontos = WarKill_Config.Guild[playerMorreu.Guild].Pontos - pontosPerder
            end

            WarKill_Config.Guild[playerMatou.Guild].Pontos = WarKill_Config.Guild[playerMatou.Guild].Pontos + pontosGanhar

            SendMessage(string.format(WarKill_Config.Message[playerMatou.Lang][23].Text, pontosGanhar), aIndex, WarKill_Config.Message[playerMatou.Lang][23].Color)
            SendMessage(string.format(WarKill_Config.Message[playerMorreu.Lang][22].Text, pontosPerder), bIndex, WarKill_Config.Message[playerMorreu.Lang][23].Color)

            if WarKill_Config.ContadorDeMortes[playerMatou.Index] ~= nil then
                InsertDeath(aIndex, 0, WarKill_Config.ContadorDeMortes[playerMatou.Index].GanhaAoMatar)
                UpdateDeath(aIndex)
            end

            if WarKill_Config.ContadorDeMortes[playerMorreu.Index] ~= nil then
                local kills = DataBase.GetNumberByNumber("DeathSystem", "Deaths", "m_Serial", playerMorreu.Serial)
                local remover = WarKill_Config.ContadorDeMortes[playerMorreu.Index].PerdeAoMorrer
                if kills < WarKill_Config.ContadorDeMortes[playerMorreu.Index].PerdeAoMorrer then
                    remover = kills                    
                end
                DecreaseDeath(bIndex, 0, remover)
                UpdateDeath(bIndex)
            end
        end
    end
    ::fim::
end

function WarKill.CheckUsers()
    if not WarKill_Config.EventStatus.Started then
        Timer.Cancel(WarKill_Config.TimerCheckUsers)
        WarKill_Config.TimerCheckUsers = 0
        return
    end
    
    for k, aIndex in ipairs(WarKill_Config.Players) do
        if WarKill_Config.Players[aIndex] == nil then goto continue end

        if gObjIsConnectedGP(aIndex) == 0 then
            goto continue
        end

        local p = User.new(aIndex)
        local map = p:getMapNumber()
        local x = p:getX()
        local y = p:getY()
        local lang = p:getLanguage()
        p = nil

        if map == WarKill_Config.Local.Area.Mapa then
            if x >= WarKill_Config.Local.Area.Inicio.X and x <= WarKill_Config.Local.Area.Fim.X then
                if y >= WarKill_Config.Local.Area.Inicio.Y and y <= WarKill_Config.Local.Area.Fim.Y then
                    goto continue
                end
            end
        end

        if WarKill_Config.GMObrigatorio then
            if WarKill_Config.Guild[WarKill_Config.Players[aIndex].Guild].GM == WarKill_Config.Players[aIndex].Tipo[1] then
                WarKill.SendMessageGlobalArg(27, WarKill_Config.Players[aIndex].Guild)
                for z, bIndex in ipairs(WarKill_Config.Players) do
                    if WarKill_Config.Players[aIndex].Tipo[1] ~= WarKill_Config.Players[bIndex].Tipo[1] then
                        if WarKill_Config.Players[bIndex].Guild == WarKill_Config.Players[aIndex].Guild then
                            Teleport(bIndex, 0, 125, 125)
                            SendMessage(string.format(WarKill_Config.Message[WarKill_Config.Players[bIndex].Lang][26].Text), aIndex, WarKill_Config.Message[WarKill_Config.Players[bIndex].Lang][26].Color)
                            table.remove(WarKill_Config.Players, z)
                        end
                    end
                end

                for z, guild in ipairs(WarKill_Config.Guild) do
                    if guild == WarKill_Config.Players[aIndex].Guild then
                        table.remove(WarKill_Config.Guild, z)
                    end
                end
                
            end
        end

        Teleport(aIndex, 0, 125, 125)
        SendMessage(string.format(WarKill_Config.Message[lang][14].Text), aIndex, WarKill_Config.Message[lang][14].Color)
        table.remove(WarKill_Config.Players, k)
        ::continue::
    end

    if #WarKill_Config.Guild < 2 then
        WarKill.EndEvent(1)
    end
end

function WarKill.Premiar(from)
    if from == 1 then
        Timer.Cancel(WarKill_Config.EventStatus.TimerPremiar)
    end
	
	
    DataBase.SetAddValue(WarKill_Config.Premio.Guild[1].Tabela, WarKill_Config.Premio.Guild[1].Coluna, WarKill_Config.Premio.Guild[1].Quantidade, WarKill_Config.Premio.Guild[1].Where, WarKill_Config.GuildVencedora[1].Nome)
    DataBase.SetAddValue(WarKill_Config.Premio.Guild[2].Tabela, WarKill_Config.Premio.Guild[2].Coluna, WarKill_Config.Premio.Guild[2].Quantidade, WarKill_Config.Premio.Guild[2].Where, WarKill_Config.GuildVencedora[2].Nome)
    DataBase.SetAddValue(WarKill_Config.Premio.Guild[3].Tabela, WarKill_Config.Premio.Guild[3].Coluna, WarKill_Config.Premio.Guild[3].Quantidade, WarKill_Config.Premio.Guild[3].Where, WarKill_Config.GuildVencedora[3].Nome)
 

    for k, bIndex in ipairs(WarKill_Config.Players) do
	if WarKill_Config.Players[bIndex] ~= nil then
        for i = 1, 3 do
            if WarKill_Config.Players[bIndex].Guild == WarKill_Config.GuildVencedora[i].Nome then
                local premio = WarKill_Config.Premio.Membro[i]
                if WarKill_Config.Players[bIndex].Tipo[1] == WarKill_Config.GuildVencedora[i].GM then
                    premio = WarKill_Config.Premio.GM[i]
                end
                DataBase.SetAddValue(premio.Tabela, premio.Coluna, premio.Quantidade, premio.Where, WarKill_Config.Players[bIndex].Tipo[premio.Tipo])
                SendMessage(string.format(WarKill_Config.Message[WarKill_Config.Players[bIndex].Lang][24].Text, premio.Quantidade, premio.Nome), bIndex, WarKill_Config.Message[WarKill_Config.Players[bIndex].Lang][24].Color)
            end
        end
	end
    end

    WarKill.Define()
    return
end

function WarKill.ComandoPremiar(aIndex)
    local p = User.new(aIndex)
    if p:getAuthority() <= 1 then p = nil; return end
    local lang = p:getLanguage()
    p = nil

    if not WarKill_Config.EventStatus.Running then
        SendMessage(string.format(WarKill_Config.Message[lang][7].Text, WarKill_Config.Comando.Abrir), aIndex, WarKill_Config.Message[lang][7].Color)   
        return
    end

    if WarKill_Config.EventStatus.Started or not WarKill_Config.EventStatus.Waiting then
        SendMessage(string.format(WarKill_Config.Message[lang][25].Text, WarKill_Config.Comando.Cancelar), aIndex, WarKill_Config.Message[lang][25].Color)   
        return
    end

    WarKill.Premiar(1)
    
    SendMessage("Premiação entregue", aIndex, 1) 
  
end

function WarKill.EndEvent(from)
    if from == 1 then
        Timer.Cancel(WarKill_Config.EventStatus.Timer)
    end

    Timer.Cancel(WarKill_Config.TimerCheckUsers)
    WarKill_Config.TimerCheckUsers = 0
    WarKill_Config.EventStatus.Started = false
    WarKill_Config.EventStatus.Waiting = true
    WarKill_Config.EventStatus.TimerPremiar = Timer.TimeOut(2*60, WarKill.Premiar, 0)

    local pontos = 0
    for k, G_Name in ipairs(WarKill_Config.Guild) do
        if WarKill_Config.Guild[G_Name].Pontos > pontos then
            WarKill_Config.GuildVencedora[1].Nome = WarKill_Config.Guild[G_Name].Nome
            WarKill_Config.GuildVencedora[1].Pontos = WarKill_Config.Guild[G_Name].Pontos
            WarKill_Config.GuildVencedora[1].GM = WarKill_Config.Guild[G_Name].GM
	    pontos = WarKill_Config.Guild[G_Name].Pontos
        end
    end

    pontos = 0
    for k, G_Name in ipairs(WarKill_Config.Guild) do
        if WarKill_Config.Guild[G_Name].Pontos > pontos and WarKill_Config.Guild[G_Name].Nome ~= WarKill_Config.GuildVencedora[1].Nome then
            WarKill_Config.GuildVencedora[2].Nome = WarKill_Config.Guild[G_Name].Nome
            WarKill_Config.GuildVencedora[2].Pontos = WarKill_Config.Guild[G_Name].Pontos
            WarKill_Config.GuildVencedora[2].GM = WarKill_Config.Guild[G_Name].GM
	    pontos = WarKill_Config.Guild[G_Name].Pontos
        end
    end

    pontos = 0
    for k, G_Name in ipairs(WarKill_Config.Guild) do
        if WarKill_Config.Guild[G_Name].Pontos > pontos and WarKill_Config.Guild[G_Name].Nome ~= WarKill_Config.GuildVencedora[1].Nome and WarKill_Config.Guild[G_Name].Nome ~= WarKill_Config.GuildVencedora[2].Nome then
            WarKill_Config.GuildVencedora[3].Nome = WarKill_Config.Guild[G_Name].Nome
            WarKill_Config.GuildVencedora[3].Pontos = WarKill_Config.Guild[G_Name].Pontos
            WarKill_Config.GuildVencedora[3].GM = WarKill_Config.Guild[G_Name].GM
	    pontos = WarKill_Config.Guild[G_Name].Pontos
        end
    end
    
    SendMessageGlobal(string.format("===~> War Kill <~==="), 0)
    WarKill.SendMessageGlobal(18)
    SendMessageGlobal(string.format("1º - %s: %d" ,WarKill_Config.GuildVencedora[1].Nome, WarKill_Config.GuildVencedora[1].Pontos), 0)
    SendMessageGlobal(string.format("2º - %s: %d" ,WarKill_Config.GuildVencedora[2].Nome, WarKill_Config.GuildVencedora[2].Pontos), 0)
    SendMessageGlobal(string.format("3º - %s: %d" ,WarKill_Config.GuildVencedora[3].Nome, WarKill_Config.GuildVencedora[3].Pontos), 0)
    SendMessageGlobal(string.format("=================="), 0)

    for k, aIndex in ipairs(WarKill_Config.Players) do
        if gObjIsConnectedGP(aIndex) ~= 0 then
            Teleport(aIndex, 0, 125, 125)
        end
    end

    if gObjIsConnectedGP(WarKill_Config.GameMaster) ~= 0 then
        local lang = GetLanguageObject(WarKill_Config.GameMaster)
        SendMessage(string.format(WarKill_Config.Message[lang][19].Text, WarKill_Config.Comando.Premiar), WarKill_Config.GameMaster, WarKill_Config.Message[lang][19].Color)
    end
    return
end

function WarKill.AnnounceOpen()
    if WarKill_Config.EventStatus.Repeat > 0 then
        SendMessageGlobal(string.format("===~> War Kill <~==="), 0)
        SendMessageGlobal(string.format(" "), 0)
        WarKill.SendMessageGlobalArg(3, WarKill_Config.Comando.Ir)
        SendMessageGlobal(string.format(" "), 0)
        WarKill.SendMessageGlobalArg(4,  WarKill_Config.EventStatus.Repeat)
        SendMessageGlobal(string.format("=================="), 0)
    else
        SendMessageGlobal(string.format("===~> War Kill <~==="), 0)
        SendMessageGlobal(string.format(" "), 0)
        WarKill.SendMessageGlobalArg(5, WarKill_Config.Comando.Ir)
        SendMessageGlobal(string.format(" "), 0)
        WarKill.SendMessageGlobalArg(6)
        SendMessageGlobal(string.format("=================="), 0)
        WarKill_Config.EventStatus.Open = false
	WarKill_Config.EventStatus.TimerAnuncio = 0
    end
    WarKill_Config.EventStatus.Repeat = WarKill_Config.EventStatus.Repeat - 1
end

function WarKill.SendMessageGlobalArg(id, arg)
    for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, 0, string.format(WarKill_Config.Message[GetLanguageObject(i)][id].Text, arg))
		
		::continue::
	end
	
	collectgarbage()
end

function WarKill.SendMessageGlobalKill(guildMatou, nomeMatou, guildMorreu, nomeMorreu)
    for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, 0, string.format(WarKill_Config.Message[GetLanguageObject(i)][21].Text, guildMatou, nomeMatou, guildMorreu, nomeMorreu))
		
		::continue::
	end
	
	collectgarbage()
end

function WarKill.SendMessageGlobal(id)
    for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, 0, string.format(WarKill_Config.Message[GetLanguageObject(i)][id].Text))
		
		::continue::
	end
	
	collectgarbage()
end

WarKill.Init()

return WarKill