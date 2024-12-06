Batatinha = {}

function Batatinha.Init()
    if Batatinha_Config.Enabled then
        Commands.Register(Batatinha_Config.Comando.Abrir["Eng"], Batatinha.ComandoAbrir)
        Commands.Register(Batatinha_Config.Comando.Abrir["Por"], Batatinha.ComandoAbrir)
        Commands.Register(Batatinha_Config.Comando.Abrir["Spn"], Batatinha.ComandoAbrir)
        Commands.Register(Batatinha_Config.Comando.Cancelar["Eng"], Batatinha.ComandoCancelar)
        Commands.Register(Batatinha_Config.Comando.Cancelar["Por"], Batatinha.ComandoCancelar)
        Commands.Register(Batatinha_Config.Comando.Cancelar["Spn"], Batatinha.ComandoCancelar)
        Commands.Register(Batatinha_Config.Comando.Ir["Eng"], Batatinha.ComandoIr)
        Commands.Register(Batatinha_Config.Comando.Ir["Por"], Batatinha.ComandoIr)
        Commands.Register(Batatinha_Config.Comando.Ir["Spn"], Batatinha.ComandoIr)
        GameServerFunctions.RespawnUser(Batatinha.RespawnUser)
        GameServerFunctions.NpcTalk(Batatinha.NpcTalk)
        Batatinha.Define()
        Batatinha.Agenda()
    end
end

function Batatinha.Define()
    Batatinha.Tempo = {
        Evento = 0,
        Anuncio = Batatinha_Config.TempoAnuncio,
        Aberto = Batatinha_Config.TempoAberto
    }
    Batatinha.Status = {
        Running = false,
        Open = false,
        Started = false,
        State = 0
    }
    Batatinha.Timer = {
        Iniciar = -1,
        Contagem = -1,
        Anuncio = -1,
        CheckPlayers = -1,
        CheckPlayersWalking = -1,
        ForceEnd = -1
    }
    Batatinha.Participantes = {}
    Batatinha.Vencedores = {}
    Batatinha.Npc = -1
end

function Batatinha.Agenda()
    for i in ipairs(Batatinha_Config.Agenda) do
        if Batatinha_Config.Agenda[i].DiaDaSemana ~= -1 then
			Schedule.SetDayOfWeek(Batatinha_Config.Agenda[i].DiaDaSemana, Batatinha_Config.Agenda[i].Hora, Batatinha_Config.Agenda[i].Minuto, Batatinha.Anuncio)
		elseif Batatinha_Config.Agenda[i].Dia ~= -1 then
			Schedule.SetDayAndHourAndMinute(Batatinha_Config.Agenda[i].Dia, Batatinha_Config.Agenda[i].Hora, Batatinha_Config.Agenda[i].Minuto, Batatinha.Anuncio)
		else
			Schedule.SetHourAndMinute(Batatinha_Config.Agenda[i].Hora, Batatinha_Config.Agenda[i].Minuto, Batatinha.Anuncio)
		end
    end
end

function Batatinha.ComandoAbrir(aIndex, Arguments)
    local player = User.new(aIndex)
    local lang = player:getLanguage()
    
    if player:getAuthority() <= 1 then return end

    if Batatinha.Status.Open or Batatinha.Status.Running then
        SendMessage(string.format(Batatinha_Config.Message[lang][1], Batatinha_Config.Comando.Cancelar[lang]), aIndex, 1)
        return
    end

    local tempo = command:getNumber(Arguments, 1)

    if tempo == nil or tempo < 2 then
        SendMessage(string.format(Batatinha_Config.Message[lang][2], Batatinha_Config.Comando.Abrir[lang]), aIndex, 1)
        return
    end

    Message.SendMessageGlobalMultLangArgs(Batatinha_Config.Message, 3, 1, player:getName())

    Batatinha.Tempo.Aberto = tempo
    Batatinha.Status.Open = true
    Batatinha.Timer.Contagem = Timer.Repeater(1, tempo, Batatinha.ContarAbertura)
end

function Batatinha.ComandoCancelar(aIndex)
    local player = User.new(aIndex)
    local lang = player:getLanguage()
    
    if player:getAuthority() <= 1 then return end

    if not Batatinha.Status.Open and not Batatinha.Status.Running then
        SendMessage(string.format(Batatinha_Config.Message[lang][7], Batatinha_Config.Comando.Abrir[lang]), aIndex, 1)
        return
    end

    Batatinha.Cancelar()
end

function Batatinha.ComandoIr(aIndex)
    if not Batatinha.Status.Open then return end

    local player = User.new(aIndex)
    local pInv = Inventory.new(aIndex)
    local lang = player:getLanguage()
    local playerInfo = {[0] = player:getAccountID(), [1] = player:getName(), [2] = aIndex, [3] = lang, [4] = 0, [5] = 0, [6] = 0}
    
    if not Batatinha_Config.CanGoWithItens then
        for i = 0, 139 do
	    	if pInv:isItem(i) ~= 0
	    	then
	    		SendMessage(Batatinha_Config.Message[lang][26], aIndex, 1)
	    		return
	    	end
	    end

	    for i = 204, 235 do
	    	if pInv:isItem(i) ~= 0
	    	then
	    		SendMessage(Batatinha_Config.Message[lang][27], aIndex, 1)
	    		return
	    	end
	    end
    end
    
    if Batatinha.Participantes[aIndex] == nil then
        table.insert(Batatinha.Participantes, aIndex)
        Batatinha.Participantes[aIndex] = playerInfo
    end

    Teleport(aIndex, Batatinha_Config.Local.Move.Mapa, Batatinha_Config.Local.Move.X, Batatinha_Config.Local.Move.Y)
    AddEffect(aIndex, 1, 65, 1000, 0, 0, 0, 0)
    AddEffect(aIndex, 1, 55, 1000, 0, 0, 0, 0)
    AddEffect(aIndex, 1, 56, 1000, 0, 0, 0, 0)

    SendMessage(Batatinha_Config.Message[lang][9], aIndex, 1)
    SendMessage(Batatinha_Config.Message[lang][10], aIndex, 1)
    return
end

function Batatinha.Anuncio()
    if Batatinha_Config.TempoAnuncio > 0 then
        Batatinha.Tempo.Anuncio = Batatinha_Config.TempoAnuncio
        Batatinha.Timer.Anuncio = Timer.Repeater(60, Batatinha_Config.TempoAnuncio, Batatinha.ContarAnuncio)
    else
        Batatinha.Tempo.Aberto = Batatinha_Config.TempoAberto
        Batatinha.Status.Open = true
        Batatinha.Timer.Contagem = Timer.Repeater(1, Batatinha_Config.TempoAberto, Batatinha.ContarAbertura)
    end
end

function Batatinha.ContarAnuncio()
    if Batatinha.Tempo.Anuncio <= 0 then
        Batatinha.Timer.Anuncio = -1
        Batatinha.Tempo.Aberto = Batatinha_Config.TempoAberto
        Batatinha.Status.Open = true
        Batatinha.Timer.Contagem = Timer.Repeater(1, Batatinha_Config.TempoAberto, Batatinha.ContarAbertura)
    else
        Message.SendMessageGlobalMultLangArgs(Batatinha_Config.Message, 11, 0, Batatinha.Tempo.Anuncio)
        Batatinha.Tempo.Anuncio = Batatinha.Tempo.Anuncio - 1
    end
end

function Batatinha.ContarAbertura()
    if Batatinha.Tempo.Aberto <= 0 then
        Batatinha.Timer.Contagem = -1
        Batatinha.Status.Open = false
        Batatinha.Status.Running = true

        Batatinha.MostrarComandoIrFechado()
        Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 6, 0)
        Batatinha.Timer.Iniciar = Timer.TimeOut(5, Batatinha.Iniciar)
    else
        Batatinha.MostrarComandoIrAberto()
        Batatinha.Tempo.Aberto = Batatinha.Tempo.Aberto - 1
    end
end

function Batatinha.CancelarTimers()
    if Batatinha.Timer.Contagem ~= -1 then
        Timer.Cancel(Batatinha.Timer.Contagem)
    end

    if Batatinha.Timer.Iniciar ~= -1 then
        Timer.Cancel(Batatinha.Timer.Inicar)
    end

    if Batatinha.Timer.CheckPlayers ~= -1 then
        Timer.Cancel(Batatinha.Timer.CheckPlayers)
    end

    if Batatinha.Timer.CheckPlayersWalking ~= -1 then
        Timer.Cancel(Batatinha.Timer.CheckPlayersWalking)
    end

    if Batatinha.Timer.Contagem ~= -1 then
        Timer.Cancel(Batatinha.Timer.Contagem)
    end
end

function Batatinha.Cancelar()
    Batatinha.CancelarTimers()

    if Batatinha.CountPlayers() > 0 then
        for i, bIndex in ipairs(Batatinha.Participantes) do
            if Batatinha.Participantes[bIndex] ~= nil then
                RemoveEffect(Batatinha.Participantes[bIndex][2], 65)
                RemoveEffect(Batatinha.Participantes[bIndex][2], 55)
                RemoveEffect(Batatinha.Participantes[bIndex][2], 56)
                Teleport(Batatinha.Participantes[bIndex][2], 0, 125, 125)
            end
        end
    end

    Batatinha.DeleteNpc()
    Batatinha.Define()
    Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 8, 1)
end

function Batatinha.Iniciar()
    Batatinha.Timer.Iniciar = -1
    
    if Batatinha.CountPlayers() < Batatinha_Config.MinimoPlayers then
        Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 13, 0)
        Batatinha.Cancelar()
        return
    end
    Batatinha.UpdatePlayerPosition()
    Batatinha.Timer.CheckPlayers = Timer.Interval(1, Batatinha.CheckPlayers)
    Batatinha.Timer.CheckPlayersWalking = Timer.Interval(1, Batatinha.CheckPlayersWalking)
    Batatinha.Status.Started = true
    SendMessageGlobal("=========================================", 0)
    SendMessageGlobal("", 0)
    Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 12, 0)
    SendMessageGlobal("", 0)
    SendMessageGlobal("=========================================", 0)
    SendMessageGlobal("", 0)
    
    Batatinha.Npc = AddMonster(Batatinha_Config.Local.Npc.Mapa)

    if Batatinha.Npc == -1 then
        Batatinha.Cancelar()
        LogAdd("Batatinha 123 cancelado por falha ao criar o NPC")
        return
    end
    local npc = User.new(Batatinha.Npc)
    SetMapMonster(Batatinha.Npc, Batatinha_Config.Local.Npc.Mapa, Batatinha_Config.Local.Npc.X, Batatinha_Config.Local.Npc.Y)
	npc:setDir(Batatinha_Config.Npc.Dir)
	SetMonster(Batatinha.Npc, Batatinha_Config.Npc.Class)
	npc:setType(3)

    for i, bIndex in ipairs(Batatinha.Participantes) do
        if Batatinha.Participantes[bIndex] ~= nil then
            RemoveEffect(Batatinha.Participantes[bIndex][2], 65)
        end
    end
    Batatinha.Timer.ForceEnd = Timer.TimeOut(Batatinha_Config.Tempo*60, Batatinha.ForceEnd)
    Batatinha.Timer.Contagem = Timer.Interval(15, Batatinha.IniciarContagem)
end

function Batatinha.ForceEnd()
    if Batatinha.CountWinners() == 0 then
        Batatinha.EndWithNoWinners(1)
    else
        Batatinha.EndWithWinners(1)
    end
end

function Batatinha.IniciarContagem()
    if Batatinha.Status.Running then
        Batatinha.Status.State = 1
        SendMessageGlobal("", 0)
        SendMessageGlobal("", 0)
        SendMessageGlobal("", 0)
        SendMessageGlobal("", 0)
        SendMessageGlobal("", 0)
        Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 15, 0)
        Timer.TimeOut(3, Batatinha.Count1)
    end
end

function Batatinha.Count1()
    if Batatinha.Status.Running then
        Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 16, 0)
        Timer.TimeOut(3, Batatinha.Count2)
    end
end

function Batatinha.Count2()
    if Batatinha.Status.Running then
        Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 17, 0)
        Timer.TimeOut(2, Batatinha.Count3)
    end
end

function Batatinha.Count3()
    if Batatinha.Status.Running then
        Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 18, 0)
        Timer.TimeOut(2, Batatinha.Count4)
    end
end

function Batatinha.Count4()
    Batatinha.Timer.Contagem2 = -1
    if Batatinha.Status.Running then
        Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 19, 0)
        Timer.TimeOut(1,Batatinha.UpdatePlayerPosition)
    end
end

function Batatinha.MostrarComandoIrAberto()
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, 0, Batatinha_Config.Message[GetLanguageObject(i)][4]:format(Batatinha_Config.Comando.Ir[GetLanguageObject(i)],Batatinha.Tempo.Aberto))
		
		::continue::
	end
	
	collectgarbage()
end

function Batatinha.MostrarComandoIrFechado()
	for i = OBJECT_START_USER, MAX_OBJECT
	do
		if gObjIsConnectedGP(i) == 0
		then
			goto continue
		end
		
		SendMessagePlayer(i, 0, Batatinha_Config.Message[GetLanguageObject(i)][5]:format(Batatinha_Config.Comando.Ir[GetLanguageObject(i)]))
		
		::continue::
	end
	
	collectgarbage()
end

function Batatinha.DeleteNpc()
    if Batatinha.Npc ~= -1 then
        gObjDel(Batatinha.Npc)
    end
end

function Batatinha.CheckPlayers()
    if Batatinha.Status.Running then
        if Batatinha.CountPlayers() > 0 then
            for i, bIndex in ipairs(Batatinha.Participantes) do
                if Batatinha.Participantes[bIndex] ~= nil then
                    local player = User.new(Batatinha.Participantes[bIndex][2])
                    local map = player:getMapNumber()
                    local x = player:getX()
                    local y = player:getY()

                    if map == Batatinha_Config.Local.Area.Mapa then
                        if x >= Batatinha_Config.Local.Area.X1 and x <= Batatinha_Config.Local.Area.X2 then
                            if y >= Batatinha_Config.Local.Area.Y1 and y <= Batatinha_Config.Local.Area.Y2 then
                                player = nil
                                goto continue
                            end
                        end
                    end

                    RemoveEffect(Batatinha.Participantes[bIndex][2], 65)
                    RemoveEffect(Batatinha.Participantes[bIndex][2], 55)
                    RemoveEffect(Batatinha.Participantes[bIndex][2], 56)
                    Teleport(Batatinha.Participantes[bIndex][2], 0, 125, 125)
                    SendMessage(Batatinha_Config.Message[Batatinha.Participantes[bIndex][3]][14], Batatinha.Participantes[bIndex][2], 1)
                    Batatinha.Participantes[bIndex] = nil

                    ::continue::
                end
            end
        else
            if Batatinha.Status.Started then
                if Batatinha.CountWinners() == 0 then
                    Batatinha.EndWithNoWinners(0)
                else
                    Batatinha.EndWithWinners(0)
                end
            end
        end
    end
end

function Batatinha.EndWithNoWinners(t)
    Batatinha.Status.Running = false

    if t ~= 1 then
        Timer.Cancel(Batatinha.Timer.ForceEnd)
    end

    Batatinha.CancelarTimers()

    if Batatinha.CountPlayers() > 0 then
        for i, bIndex in ipairs(Batatinha.Participantes) do
            if Batatinha.Participantes[bIndex] ~= nil then
                RemoveEffect(Batatinha.Participantes[bIndex][2], 65)
                RemoveEffect(Batatinha.Participantes[bIndex][2], 55)
                RemoveEffect(Batatinha.Participantes[bIndex][2], 56)
                Teleport(Batatinha.Participantes[bIndex][2], 0, 125, 125)
            end
        end
    end

    Batatinha.DeleteNpc()
    Batatinha.Define()
    SendMessageGlobal("=========================================", 0)
    SendMessageGlobal("", 0)
    Message.SendMessageGlobalMultLang(Batatinha_Config.Message, 21, 0)
    SendMessageGlobal("", 0)
    SendMessageGlobal("=========================================", 0)
    SendMessageGlobal("", 0)
end

function Batatinha.EndWithWinners(t)
    Batatinha.Status.Running = false

    if t ~= 1 then
        Timer.Cancel(Batatinha.Timer.ForceEnd)
    end

    Batatinha.CancelarTimers()

    Batatinha.DeleteNpc()

    if Batatinha.CountPlayers() > 0 then
        for i, bIndex in ipairs(Batatinha.Participantes) do
            if Batatinha.Participantes[bIndex] ~= nil then
                Batatinha.KillPlayer(Batatinha.Participantes[bIndex][2])
            end
        end
    end
    
    local count = Batatinha.CountWinners()
    for v = 1, count do
        for i in ipairs(Batatinha_Config.Premio[v]) do
            local premio = Batatinha_Config.Premio[v][i]
            DataBase.SetAddValue(premio.Tabela, premio.Coluna, premio.Valor, premio.Where, Batatinha.Vencedores[v][premio.IdType])
            SendMessage(string.format(Batatinha_Config.Message[Batatinha.Vencedores[v][3]][25], premio.Valor, premio.Nome), Batatinha.Vencedores[v][2], 1)
        end
        for i in ipairs(Batatinha_Config.Ponto[v]) do
            local premio = Batatinha_Config.Ponto[v][i]
            DataBase.SetAddValue(premio.Tabela, premio.Coluna, premio.Valor, premio.Where, Batatinha.Vencedores[v][premio.IdType])
        end
    end
    local vencedor = Batatinha.Vencedores[1][1]
    Batatinha.Define()
    SendMessageGlobal("=========================================", 0)
    SendMessageGlobal("", 0)
    Message.SendMessageGlobalMultLangArgs(Batatinha_Config.Message, 24, 0, vencedor)
    SendMessageGlobal("", 0)
    SendMessageGlobal("=========================================", 0)
    SendMessageGlobal("", 0)
end

function Batatinha.UpdatePlayerPosition()
    if Batatinha.Status.Running then
        if Batatinha.CountPlayers() > 0 then
            for k, v in ipairs(Batatinha.Participantes) do
                if Batatinha.Participantes[v] ~= nil then
                    local player = User.new(Batatinha.Participantes[v][2])
                    Batatinha.Participantes[v][4] = player:getX()
                    Batatinha.Participantes[v][5] = player:getY()
                end
            end

            Batatinha.Status.State = 0
        end
    end
end

function Batatinha.CountPlayers()
    local count = 0
    for k, v in ipairs(Batatinha.Participantes) do
        if Batatinha.Participantes[v] ~= nil then
            count = count+1
        end
    end
    return count
end

function Batatinha.CountWinners()
    local count = 0
    for v in ipairs(Batatinha.Vencedores) do
        if Batatinha.Vencedores[v] ~= nil then
            count = count+1
        end
    end
    return count
end

function Batatinha.CheckPlayersWalking()
    if Batatinha.Status.Running then
        if Batatinha.Status.State ~= 1 then
            if Batatinha.CountPlayers() > 0 then
                for k, v in ipairs(Batatinha.Participantes) do
                    if Batatinha.Participantes[v] ~= nil then
                        local player = User.new(Batatinha.Participantes[v][2])
                        local x = player:getX()
                        local y = player:getY()
                        if Batatinha.Participantes[v][4] > x+1 or Batatinha.Participantes[v][4] < x-1 or Batatinha.Participantes[v][5] > y+1 or Batatinha.Participantes[v][5] < y-1 then
                            if Batatinha.Participantes[v][6] == 0 then
                                Batatinha.KillPlayer(Batatinha.Participantes[v][2])
                            end
                        end
                    end
                end
            end
        end
    end
end

function Batatinha.KillPlayer(aIndex)
    local player = User.new(aIndex)
    SkillSend(aIndex, 5, aIndex, 1)
    DamageSend(2, aIndex, 0, 5274261294, 0, 0)
	KillPlayer(aIndex)
	player:setKillerType(5)
    Batatinha.Participantes[aIndex][6] = 1
	Message.SendMessageGlobalMultLangArgs(Batatinha_Config.Message, 20, 0, player:getName())
	RemoveEffect(aIndex, 65)
    RemoveEffect(aIndex, 55)
    RemoveEffect(aIndex, 56)
end

function Batatinha.RespawnUser(aIndex)
    if Batatinha.Status.Running then
        if Batatinha.Participantes[aIndex] ~= nil then
            Teleport(aIndex, 0, 125, 125)
            Batatinha.Participantes[aIndex] = nil
        end
    end
end

function Batatinha.NpcTalk(Monster, aIndex)
    if Batatinha.Status.Running then
        if Batatinha.Status.Started then
            if Monster == Batatinha.Npc then
                if Batatinha.Participantes[aIndex] ~= nil then
                    local player = User.new(aIndex)
                    local map = player:getMapNumber()
                    local x = player:getX()
                    local y = player:getY()
                    if map == Batatinha_Config.Local.SafeArea.Mapa then
                        if x >= Batatinha_Config.Local.SafeArea.X1 and x <= Batatinha_Config.Local.SafeArea.X2 and y >= Batatinha_Config.Local.SafeArea.Y1 and y <= Batatinha_Config.Local.SafeArea.Y2 then
                            local count = Batatinha.CountWinners()
                            if count < Batatinha_Config.Vencedores then
                                ChatTargetSend(Monster, string.format(Batatinha_Config.Message[Batatinha.Participantes[aIndex][3]][22], count+1), aIndex)
                                SendMessage(string.format(Batatinha_Config.Message[Batatinha.Participantes[aIndex][3]][22], count+1), aIndex, 1)
                                SendMessage(Batatinha_Config.Message[Batatinha.Participantes[aIndex][3]][23], aIndex, 1)
                                Batatinha.AddWinner(aIndex)
                            end
                        else
                            if Batatinha_Config.EliminatePlayerIfNotInArea then
                                Batatinha.KillPlayer(aIndex)
                            end
                        end

                        return 1
                    end
                end
            end            
        end
    end
    return 0
end

function Batatinha.AddWinner(aIndex)
    local count = Batatinha.CountWinners()
    count = count+1
    table.insert(Batatinha.Vencedores, count)
    Batatinha.Vencedores[count] = Batatinha.Participantes[aIndex]
    Batatinha.Participantes[aIndex] = nil
    RemoveEffect(aIndex, 65)
    RemoveEffect(aIndex, 55)
    RemoveEffect(aIndex, 56)
    Timer.TimeOut(2, Teleport, aIndex, 0, 125, 125)
    
    if count == Batatinha_Config.Vencedores then
        Batatinha.EndWithWinners(0)
    end
end

Batatinha.Init()

return Batatinha