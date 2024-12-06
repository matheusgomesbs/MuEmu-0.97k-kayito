X1Premiado = {}

local running = false
local open = false
local Player1 = nil
local Player2 = nil
local timerAnuncio = nil
local tempoAnuncio = 0
local timerContagem = nil
local tempoContagem = 0
local timerRunning = nil
local pvpOn = false

function X1Premiado.Init()
	
	
	if not X1Premiado_Ativado then return end
	
	Commands.Register(X1Premiado_ComandoAbrir, X1Premiado.ComandoAbrir)
	Commands.Register(X1Premiado_ComandoCancelar, X1Premiado.ComandoCancelar)
	Commands.Register(X1Premiado_ComandoIr, X1Premiado.ComandoIr)
	GameServerFunctions.PlayerAttack(X1Premiado.PlayerAttack)
	GameServerFunctions.PlayerDie(X1Premiado.PlayerDie)
	GameServerFunctions.PlayerLogout(X1Premiado.PlayerLogout)
	
	for i in ipairs(X1Premiado_Agenda) do
		if X1Premiado_Agenda[i].DiaDaSemana ~= -1 then
			Schedule.SetDayOfWeek(X1Premiado_Agenda[i].DiaDaSemana, X1Premiado_Agenda[i].Hora, X1Premiado_Agenda[i].Minuto, X1Premiado.AbrirEvento, X1Premiado_TempoAberto)
		elseif X1Premiado_Agenda[i].DiaDoMes ~= -1 then
			Schedule.SetDayAndHourAndMinute(X1Premiado_Agenda[i].DiaDoMes, X1Premiado_Agenda[i].Hora, X1Premiado_Agenda[i].Minuto, X1Premiado.AbrirEvento, X1Premiado_TempoAberto)
		else
			Schedule.SetHourAndMinute(X1Premiado_Agenda[i].Hora, X1Premiado_Agenda[i].Minuto, X1Premiado.AbrirEvento, X1Premiado_TempoAberto)
		end
	end
end

function X1Premiado.ComandoCancelar(aIndex)
	local player = User.new(aIndex)
	
	if player:getAuthority() <= 1 then
		return
	end
	
	if not running and not open then
		SendMessage(string.format("Não existe X1 Premiado aberto"), aIndex, 1)
		SendMessage(string.format("Utilize %s tempo", X1Premiado_ComandoAbrir), aIndex, 1)
		return
	end
	
	running = false
	open = false
	pvpOn = false
	Player1 = nil
	Player2 = nil
	if timerAnuncio ~= nil then
		Timer.Cancel(timerAnuncio)
		timerAnuncio = nil
	end
	if timerContagem ~= nil then
		Timer.Cancel(timerContagem)
		timerContagem = nil
	end
	if timerRunning ~= nil then
		Timer.Cancel(timerRunning)
		timerRunning = nil
	end
	
	SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
	SendMessageGlobal(string.format("Evento cancelado"), 0)
	return
end

function X1Premiado.ComandoAbrir(aIndex, Arguments)
	local player = User.new(aIndex)
	
	if player:getAuthority() <= 1 then
		return
	end
		
	local tempo = command:getNumber(Arguments, 1, 0)
	
	if tempo == nil or tempo <= 0 then
		SendMessage(string.format("Utilize %s tempo", X1Premiado_ComandoAbrir), aIndex, 1)
		return
	end
	
	if open or running then
		SendMessage(string.format("Já existe um X1 premiado aberto", X1Premiado_ComandoAbrir), aIndex, 1)
		SendMessage(string.format("Utilize %s para cancelar", X1Premiado_ComandoCancelar), aIndex, 1)
		return
	end
	
	Teleport(aIndex, X1Premiado_Mapa, X1Premiado_GmSpot.X, X1Premiado_GmSpot.Y)
	X1Premiado.AbrirEvento(tempo)
end

function X1Premiado.AbrirEvento(tempo)
	if open or running then
		return
	end
	tempoAnuncio = tempo
	Player1 = nil
	Player2 = nil
	
	for aIndex = 13000, 13999 do
		local player = User.new(aIndex)
		if player:getConnected() == 3 then
			if player:getAuthority() <= 1 then
				if player:getMapNumber() == X1Premiado_Mapa then
					if player:getX() >= X1Premiado_Area.X1 and player:getX() <= X1Premiado_Area.X2 and player:getY() >= X1Premiado_Area.Y1 and player:getY() <= X1Premiado_Area.Y2 then
						Teleport(aIndex, 0, 125, 125)
					end
				end
			end
		end
	end
	
	open = true
	SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
	timerAnuncio = Timer.Repeater(1, tempoAnuncio, X1Premiado.AnunciarEvento)
end

function X1Premiado.AnunciarEvento()
	if tempoAnuncio <= 0 then
		timerAnuncio = nil
		open = false
		SendMessageGlobal(string.format("%s fechou", X1Premiado_ComandoIr, tempoAnuncio), 0)		
		if Player1 == nil or Player2 == nil then
			SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
			SendMessageGlobal(string.format("Não houve participantes"), 0)
			return
		end
		running = true
		timerRunning = Timer.Interval(2, X1Premiado.Running)
		SendMessageGlobal(string.format(" "), 0)
		SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
		SendMessageGlobal(string.format("%s vs %s", Player1.Nome, Player2.Nome), 0)
		tempoContagem = 3
		timerContagem = Timer.Repeater(1, tempoContagem, X1Premiado.Contagem)
	else
		SendMessageGlobal(string.format("%s fecha em %d segundo(s)", X1Premiado_ComandoIr, tempoAnuncio), 0)
		tempoAnuncio = tempoAnuncio - 1
	end
end

function X1Premiado.Running()
	if running then
		for aIndex = 13000, 13999 do
			local player = User.new(aIndex)
			if Player1.Index ~= aIndex and Player2.Index ~= aIndex then
				if player:getConnected() == 3 then
					if player:getAuthority() <= 1 then
						if player:getMapNumber() == X1Premiado_Mapa then
							if player:getX() >= X1Premiado_Area.X1 and player:getX() <= X1Premiado_Area.X2 and player:getY() >= X1Premiado_Area.Y1 and player:getY() <= X1Premiado_Area.Y2 then
								Teleport(aIndex, 0, 125, 125)
							end
						end
					end
				end
			end
		end
		
		local player1 = User.new(Player1.Index)
		local player2 = User.new(Player2.Index)
		
		if player1:getConnected() ~= 3 or player2:getConnected() ~= 3 then
			goto cancelar
		end
		
		if player1:getMapNumber() ~= X1Premiado_Mapa or player2:getMapNumber() ~= X1Premiado_Mapa then
			goto cancelar
		else
			if player1:getX() >= X1Premiado_Area.X1 and player1:getX() <= X1Premiado_Area.X2 and player1:getY() >= X1Premiado_Area.Y1 and player1:getY() <= X1Premiado_Area.Y2 then
			
			else
				goto cancelar
			end
			if player2:getX() >= X1Premiado_Area.X1 and player2:getX() <= X1Premiado_Area.X2 and player2:getY() >= X1Premiado_Area.Y1 and player2:getY() <= X1Premiado_Area.Y2 then
			
			else
				goto cancelar
			end
		end
		
		goto fim
		
		::cancelar::
		running = false
		open = false
		pvpOn = false
		Player1 = nil
		Player2 = nil
		if timerAnuncio ~= nil then
			Timer.Cancel(timerAnuncio)
			timerAnuncio = nil
		end
		if timerContagem ~= nil then
			Timer.Cancel(timerContagem)
			timerContagem = nil
		end
		if timerRunning ~= nil then
			Timer.Cancel(timerRunning)
			timerRunning = nil
		end
		
		SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
		SendMessageGlobal(string.format("Evento cancelado"), 0)
		return
	end
	::fim::
end

function X1Premiado.ComandoIr(aIndex)
	if running or not open then
		SendMessage(string.format("Não existe X1 Premiado aberto"), aIndex, 1)
		return
	end
	
	if Player1 ~= nil and Player2 ~= nil then
		open = false
		SendMessage(string.format("Não há mais vagas no evento"), aIndex, 1)
		return
	end
	
	local player = User.new(aIndex)
	
	if not X1Premiado_ClassesPermitidas[player:getClass()] then
		SendMessage(string.format("Sua classe não é permitida no evento"), aIndex, 1)
		return
	end
	
	if Player1 == nil then
		Player1 = {Index = aIndex, Nome = player:getName(), Login = player:getAccountID()}
		Teleport(aIndex, X1Premiado_Mapa, X1Premiado_Player1Spot.X, X1Premiado_Player1Spot.Y)
		SendMessage(string.format("Você está participando do evento"), aIndex, 1)
		SendMessage(string.format("Fique atento as mensagens no Global"), aIndex, 1)
		return
	end
	
	if Player2 == nil then
		Player2 = {Index = aIndex, Nome = player:getName(), Login = player:getAccountID()}
		Teleport(aIndex, X1Premiado_Mapa, X1Premiado_Player2Spot.X, X1Premiado_Player2Spot.Y)
		SendMessage(string.format("Você está participando do evento"), aIndex, 1)
		SendMessage(string.format("Fique atento as mensagens no Global"), aIndex, 1)
		return
	end	
end

function X1Premiado.Contagem()
	if tempoContagem <= 0 then
		timerContagem = nil
		SendMessageGlobal(string.format("ATENÇÃO - JAH!", tempoContagem), 0)
		pvpOn = true
	else
		SendMessageGlobal(string.format("%d", tempoContagem), 0)
		tempoContagem = tempoContagem - 1
	end
end

function X1Premiado.PlayerAttack(aIndex, bIndex)
	if running or open then
		if Player1 ~= nil then
			if Player1.Index == aIndex or Player1.Index == bIndex then
				if not pvpOn then
					SendMessage(string.format("Aguarde a contagem do sistema"), aIndex, 1)
					return 1
				end
			end
		end
		
		if Player2 ~= nil then
			if Player2.Index == aIndex or Player2.Index == bIndex then
				if not pvpOn then
					SendMessage(string.format("Aguarde a contagem do sistema"), aIndex, 1)
					return 1
				end
			end
		end
	end
end

function X1Premiado.PlayerDie(aIndex, bIndex)
	if running then
		if Player1.Index == bIndex  and Player2.Index == aIndex then	
			Teleport(aIndex, 0, 125, 125)
			Teleport(bIndex, 0, 125, 125)
			X1Premiado.FimEvento(Player2)
			return
		end
		
		if Player2.Index == bIndex and Player1.Index == aIndex then
			Teleport(aIndex, 0, 125, 125)
			Teleport(bIndex, 0, 125, 125)
			X1Premiado.FimEvento(Player1)
			return
		end
	end
end

function X1Premiado.PlayerLogout(aIndex)
	if running then
		if Player1 ~= nil then
			if Player1.Index == aIndex then
				running = false
				open = false
				pvpOn = false
				Player1 = nil
				Player2 = nil
				if timerAnuncio ~= nil then
					Timer.Cancel(timerAnuncio)
					timerAnuncio = nil
				end
				if timerContagem ~= nil then
					Timer.Cancel(timerContagem)
					timerContagem = nil
				end
				if timerRunning ~= nil then
					Timer.Cancel(timerRunning)
					timerRunning = nil
				end
				
				SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
				SendMessageGlobal(string.format("Evento cancelado"), 0)
				return
			end
		end
		if Player2 ~= nil then
			if Player2.Index == aIndex then
				running = false
				open = false
				pvpOn = false
				Player1 = nil
				Player2 = nil
				if timerAnuncio ~= nil then
					Timer.Cancel(timerAnuncio)
					timerAnuncio = nil
				end
				if timerContagem ~= nil then
					Timer.Cancel(timerContagem)
					timerContagem = nil
				end
				if timerRunning ~= nil then
					Timer.Cancel(timerRunning)
					timerRunning = nil
				end
				
				SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
				SendMessageGlobal(string.format("Evento cancelado"), 0)
				return
			end
		end
		
	end
end

function X1Premiado.FimEvento(Vencedor)
	SendMessageGlobal(string.format(">> X1 PREMIADO <<"), 0)
	SendMessageGlobal(string.format("Vencedor: %s", Vencedor.Nome), 0)
	SendMessageGlobal(string.format("Prêmio: %d %s", X1Premiado_Premio.Valor, X1Premiado_Premio.Nome), 0)
	local player = User.new(Vencedor.Index)
	local tipo = ""
	if X1Premiado_Premio.Tipo == 0 then
		tipo = player:getAccountID()
	else
		tipo = player:getName()
	end	
	DataBase.SetAddValue(X1Premiado_Premio.Tabela, X1Premiado_Premio.Coluna, X1Premiado_Premio.Valor, X1Premiado_Premio.Where, tipo)
	
	if X1Premiado_Pontos.Tipo == 0 then
		tipo = player:getAccountID()
	else
		tipo = player:getName()
	end
	DataBase.SetAddValue(X1Premiado_Pontos.Tabela, X1Premiado_Pontos.Coluna, X1Premiado_Pontos.Valor, X1Premiado_Pontos.Where, tipo)
	
	if X1Premiado_Pontos2.Tipo == 0 then
		tipo = player:getAccountID()
	else
		tipo = player:getName()
	end
	DataBase.SetAddValue(X1Premiado_Pontos2.Tabela, X1Premiado_Pontos2.Coluna, X1Premiado_Pontos2.Valor, X1Premiado_Pontos2.Where, tipo)
	
	running = false
	open = false
	pvpOn = false
	Player1 = nil
	Player2 = nil
	if timerAnuncio ~= nil then
		Timer.Cancel(timerAnuncio)
		timerAnuncio = nil
	end
	if timerContagem ~= nil then
		Timer.Cancel(timerContagem)
		timerContagem = nil
	end
	if timerRunning ~= nil then
		Timer.Cancel(timerRunning)
		timerRunning = nil
	end
	
	return	
end

X1Premiado.Init()

return X1Premiado