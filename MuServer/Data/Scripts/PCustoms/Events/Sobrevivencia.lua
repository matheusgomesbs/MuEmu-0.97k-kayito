Sobrevivencia = {}

local aberto = false
local iniciado = false
local Participantes = {}
local minutesToStart = 0
local secondsToClose = 0
local timer = nil
local timerCheck = nil

function Sobrevivencia.Init()	
	Commands.Register(SOBRE_COMMAND_GO, Sobrevivencia.ComandoIr)
	GameServerFunctions.PlayerAttack(Sobrevivencia.BlockAttack)
	GameServerFunctions.PlayerDie(Sobrevivencia.PlayerDie)

	if SOBRE_COMMAND_SWITCH == 1 then		
		Commands.Register(SOBRE_COMMAND_OPEN, Sobrevivencia.ComandoAbrir)
	end
	
	if SOBRE_AUTO_SWITCH == 1 then
		for i in ipairs(SOBRE_DATA) do
			if SOBRE_DATA[i]._dayofweek ~= -1
			then
				Schedule.SetDayOfWeek(SOBRE_DATA[i]._dayofweek, SOBRE_DATA[i]._hour, SOBRE_DATA[i]._minute, Sobrevivencia.Start)
			elseif SOBRE_DATA[i]._day ~= -1
			then
				Schedule.SetDayAndHourAndMinute(SOBRE_DATA[i]._day, SOBRE_DATA[i]._hour, SOBRE_DATA[i]._minute, Sobrevivencia.Start)
			else
				Schedule.SetHourAndMinute(SOBRE_DATA[i]._hour, SOBRE_DATA[i]._minute, Sobrevivencia.Start)
			end
		end
	end
end

function Sobrevivencia.Start()
	if SOBRE_AUTO_SWITCH == 0 then return end
	
	if SOBRE_ANNOUNCE_MINUTES > 0 then
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 2, 0)
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 3, 0, SOBRE_ANNOUNCE_MINUTES)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 4, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 5, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)
		
		
		minutesToStart = SOBRE_ANNOUNCE_MINUTES
		timer = Timer.Repeater(60, 	SOBRE_ANNOUNCE_MINUTES, Sobrevivencia.Running)
	else
		aberto = true
		Sobrevivencia.RemovePlayers()
		timerCheck = Timer.Interval(2, Sobrevivencia.CheckUser)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 2, 0)
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 7, 0, SOBRE_TIME_CLOSE)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 8, 0)
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 9, 0, SOBRE_COMMAND_GO)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)
		secondsToClose = SOBRE_TIME_CLOSE
		timer = Timer.Repeater(1, SOBRE_TIME_CLOSE, Sobrevivencia.ComandoIrTimer)
	end
end

function Sobrevivencia.Running()
	minutesToStart = minutesToStart - 1
	if minutesToStart <= 0
	then
		Timer.Cancel(timer)
		timer = nil
		aberto = true
		Sobrevivencia.RemovePlayers()
		timerCheck = Timer.Interval(2, Sobrevivencia.CheckUser)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 2, 0)
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 7, 0, SOBRE_TIME_CLOSE)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 8, 0)
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 9, 0, SOBRE_COMMAND_GO)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)
		secondsToClose = SOBRE_TIME_CLOSE
		timer = Timer.Repeater(1, SOBRE_TIME_CLOSE, Sobrevivencia.ComandoIrTimer)	
	else
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 2, 0)
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 3, 0, SOBRE_ANNOUNCE_MINUTES)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 4, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 5, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)		
	end
end

function Sobrevivencia.ComandoAbrir(aIndex, Arguments)
	if SOBRE_COMMAND_SWITCH == 0 then return end
	
	local p = User.new(aIndex)
	if p:getAuthority() == 1 then return end

	local lang = p:getLanguage()
	
	if aberto or iniciado then
		SendMessage(SOBRE_MESSAGES[lang][10], aIndex, 1)
		return
	end
	
	local tempo = command:getNumber(Arguments, 1)
	
	if tempo <= 0 or tempo == nil then
		SendMessage(string.format(SOBRE_MESSAGES[lang][11], SOBRE_COMMAND_OPEN), aIndex, 1)
		return
	end
	
	aberto = true
	Sobrevivencia.RemovePlayers()
	timerCheck = Timer.Interval(2, Sobrevivencia.CheckUser)
	
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 2, 0)
	Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 7, 0, tempo)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 8, 0)
	Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 9, 0, SOBRE_COMMAND_GO)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)
	
	secondsToClose = tempo
	
	timer = Timer.Repeater(1, tempo, Sobrevivencia.ComandoIrTimer)		
end

function Sobrevivencia.CheckUser()
	for i, name in ipairs(Participantes) do
		local index = Participantes[name].Index
		local p = User.new(index)
		if p:getConnected() ~= 3 then
			RemoverTable(Participantes, name)
		end

		local lang = p:getLanguage()
		
		local userMap = p:getMapNumber()
		if userMap ~= SOBRE_AREA.Map then
			RemoverTable(Participantes, name)
			SendMessage(SOBRE_MESSAGES[lang][12], index, 1)
		end
		
		local userX = p:getX()
		local userY = p:getY()
		
		if userX < SOBRE_AREA.CoordX1 or userX > SOBRE_AREA.CoordX2 or userY < SOBRE_AREA.CoordY1 or userY > SOBRE_AREA.CoordY2 then
			RemoverTable(Participantes, name)
			Teleport(index, 0, 125, 125)
			SendMessage(SOBRE_MESSAGES[lang][13], index, 1)
			if #Participantes == 1 then
				Sobrevivencia.End()
				return
			end
		end	
	end
	
	if not aberto and iniciado then
		if CountTable(Participantes) == 1 then
			if timerCheck ~= nil then
				Timer.Cancel(timerCheck)
				timerCheck = nil
			end	
			Sobrevivencia.End()
		end
	end
end

function Sobrevivencia.RemovePlayers()
	for aIndex = 13000, 13999 do
		local p = User.new(aIndex)
		if p:getConnected() == 3
		then
			if p:getAuthority() == 1
			then
				if p:getMapNumber() == SOBRE_AREA.Map and p:getX() >= SOBRE_AREA.CoordX1 and p:getX() <= SOBRE_AREA.CoordX2 and p:getY() >= SOBRE_AREA.CoordY1 and p:getY() <= SOBRE_AREA.CoordY2
				then
					Teleport(aIndex, 0, 125, 125)
					SendMessage(SOBRE_MESSAGES[p:getLanguage()][14], aIndex, 1)
				end
			end
		end
	end
end

function Sobrevivencia.End()	
	local Nome = 0
	local Index = 0
	local Account = 0
	local Mortes = 0
	
	for i, name in ipairs(Participantes) do
		Nome = Participantes[name].Name
		Index = Participantes[name].Index
		Account = Participantes[name].Account
		Mortes = Participantes[name].Mortes
	end
	
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 4, 0)
	Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 15, 0, Nome)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 4, 0)
	Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 16, 0, Mortes)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)
	
	Teleport(Index, 0, 125, 125)
	local tp = ""
	if SOBRE_PREMIO_TIPO == 0 then tp = Account else tp = Nome end
	DataBase.SetAddValue(SOBRE_PREMIO_TABELA, SOBRE_PREMIO_COLUNA, SOBRE_PREMIO_VALOR, SOBRE_PREMIO_WHERE, tp)
	if SOBRE_PONTO_TIPO == 0 then tp = Account else tp = Nome end
	DataBase.SetAddValue(SOBRE_PONTO_TABELA, SOBRE_PONTO_COLUNA, SOBRE_PONTO_VALOR, SOBRE_PONTO_WHERE, tp)
	if SOBRE_PONTO2_TIPO == 0 then tp = Account else tp = Nome end
	DataBase.SetAddValue(SOBRE_PONTO2_TABELA, SOBRE_PONTO2_COLUNA, SOBRE_PONTO2_VALOR, SOBRE_PONTO2_WHERE, tp)
	local player = User.new(Index)
	SendMessage(string.format(SOBRE_MESSAGES[player:getLanguage()][17], SOBRE_PREMIO_VALOR, SOBRE_PREMIO_NOME), Index, 1)
	
	
	
	Sobrevivencia.Clear()
end

function Sobrevivencia.Clear()
	aberto = false
	iniciado = false
	Participantes = {}
	minutesToStart = 0
	secondsToClose = 0

	if timer ~= nil
	then
		Timer.Cancel(timer)
		timer = nil
	end

	if timerCheck ~= nil
	then
		Timer.Cancel(timerCheck)
		timerCheck = nil
	end
end

function Sobrevivencia.ComandoIrTimer()
	secondsToClose = secondsToClose - 1
	
	if secondsToClose <= 0 then
		Timer.Cancel(timer)
		timer = nil
		aberto = false
		
		if CountTable(Participantes) < SOBRE_MIN_PLAYERS
		then
			Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
			Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 18, 0)
			Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 19, 0)
			Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 20, 0)
			Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 21, 0)
			Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)		
					
			if #Participantes > 0 then
				for i, Nome in ipairs(Participantes) do
					Teleport(Participantes[Nome].Index, 0, 125, 125)
				end
			end
			
			Sobrevivencia.Clear()
			return
		end
	
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 4, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 22, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 4, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 23, 0)
		Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)
		iniciado = true
		return 0
	end
	
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 1, 0)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 2, 0)
	Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 7, 0, secondsToClose)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 8, 0)
	Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 9, 0, SOBRE_COMMAND_GO)
	Message.SendMessageGlobalMultLang(SOBRE_MESSAGES, 6, 0)
end

function Sobrevivencia.ComandoIr(aIndex, Arguments)
	local p = User.new(aIndex)
	local lang = p:getLanguage()

	if not aberto then
		SendMessage(SOBRE_MESSAGES[lang][24], aIndex, 1)
		return
	end
	
	local Login = p:getAccountID()
	local Nome = p:getName()
	
	if p:getLevel() < SOBRE_LEVEL then
		SendMessage(string.format(SOBRE_MESSAGES[lang][25], SOBRE_LEVEL), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_VIP, COLUMN_VIP, WHERE_VIP, Login) < SOBRE_VIP
	then
		SendMessage(SOBRE_MESSAGES[lang][26], aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_RESET, COLUMN_RESET[0], WHERE_RESET, Nome) < SOBRE_RESETS
	then
		SendMessage(string.format(SOBRE_MESSAGES[lang][27], SOBRE_RESETS), aIndex, 1)
		return
	end
	
	if DataBase.GetValue(TABLE_MRESET, COLUMN_MRESET[0], WHERE_MRESET, Nome) < SOBRE_MRESETS
	then
		SendMessage(string.format(SOBRE_MESSAGES[lang][28], SOBRE_MRESETS), aIndex, 1)
		return
	end
	
	if not SOBRE_CLASSES_PERMITIDAS[p:getClass()] then
		SendMessage(SOBRE_MESSAGES[lang][29], aIndex, 1)
		return
	end
	
	if has_key(Participantes, Nome) then
		SendMessage(SOBRE_MESSAGES[lang][30], aIndex, 1)
		return
	end	
	
	InsertKey(Participantes, Nome)
	Participantes[Nome] = {Name = Nome, Index = aIndex, Account = Login, Mortes = 0}
	Teleport(aIndex, SOBRE_AREA.Map, SOBRE_AREA.CoordX, SOBRE_AREA.CoordY)
	SendMessage(SOBRE_MESSAGES[lang][31], aIndex, 1)
	SendMessage(SOBRE_MESSAGES[lang][32], aIndex, 1)
end	

function Sobrevivencia.BlockAttack(aIndex, TargetIndex)	
	local p = User.new(aIndex)
	local p2 = User.new(TargetIndex)
	
	if has_key(Participantes, p:getName()) and has_key(Participantes, p2:getName()) then
		if not iniciado then
			SendMessage(SOBRE_MESSAGES[p:getLanguage()][33], aIndex, 1)
			return 1
		end
	end
end

function Sobrevivencia.PlayerDie(aIndex, TargetIndex)
	if not iniciado then return end
	local p = User.new(aIndex)
	local p2 = User.new(TargetIndex)
	local nome1 = p:getName()
	local nome2 = p2:getName()
	if has_key(Participantes, nome1) and has_key(Participantes, nome2) then
		Participantes[nome1].Mortes = Participantes[nome1].Mortes + 1
		RemoverTable(Participantes, nome2)
		Message.SendMessageGlobalMultLangArgs(SOBRE_MESSAGES, 34, 0, nome1, nome2)
		SendMessage(string.format(SOBRE_MESSAGES[p2:getLanguage()][35], nome1), TargetIndex, 1)
	end
end

Sobrevivencia.Init()

return Sobrevivencia