CaT = {}
local running = false
local item = -1
local lugar = -1
local vencedor = -1
local catNpc = -1
local timerRunnig = -1
local timerFinish = -1

function CaT.Init()
	
	
	if not CaT_Ativado then return end
	Commands.Register(CaT_CommandOpen,CaT.ComandoAbrir)
	Commands.Register(CaT_CommandCancel,CaT.ComandoCancelar)
	GameServerFunctions.NpcTalk(CaT.NpcTalk)
	CaT.Agenda()
end

function CaT.Agenda()
	for i in ipairs(CaT_Agenda) do
		if CaT_Agenda[i].DiaDaSemana ~= -1 then
			Schedule.SetDayOfWeek(CaT_Agenda[i].DiaDaSemana, CaT_Agenda[i].Hora, CaT_Agenda[i].Minuto, CaT.AbrirEvento)
		elseif CaT_Agenda[i].DiaDoMes ~= -1 then
			Schedule.SetDayAndHourAndMinute(CaT_Agenda[i].DiaDoMes, CaT_Agenda[i].Hora, CaT_Agenda[i].Minuto, CaT.AbrirEvento)
		else
			Schedule.SetHourAndMinute(CaT_Agenda[i].Hora, CaT_Agenda[i].Minuto, CaT.AbrirEvento)
		end
	end
end

function CaT.AbrirEvento()
	if running then return end
	math.randomseed(os.clock()*os.time()/GetTick())
	lugar = CaT_Moves[math.random(1, #CaT_Moves)]
	item = CaT_Itens[math.random(1, #CaT_Itens)]
	
	catNpc = AddMonster(lugar.Mapa)
	
	if catNpc == -1 then
		LogAdd(string.format("Erro ao criar o NPC Caça ao Tesouro"))
		lugar = -1
		item = -1
		vencedor = -1
		return
	end
	local player = User.new(catNpc)
	
	SetMapMonster(catNpc, lugar.Mapa, lugar.X, lugar.Y)
	player:setDir( 2)
	SetMonster(catNpc, CaT_NpcClass)
	player:setType(3)
	
	running = true
	
	SendMessageGlobal(string.format("## Evento Caça ao Tesouro ##"), 0)
	SendMessageGlobal(string.format("%d %s", item.Quantidade, item.Nome), 0)
	SendMessageGlobal(string.format("~~>  %s  <~~", lugar.Nome), 0)
	
	timerFinish = Timer.TimeOut(CaT_TempoMaximo*60, CaT.FimEvento, 1)
	timerRunnig = Timer.Interval(15, CaT.Running)
	
	return	
end

function CaT.Running()	
	SendMessageGlobal(string.format("## Evento Caça ao Tesouro ##"), 0)
	SendMessageGlobal(string.format("%d %s", item.Quantidade, item.Nome), 0)
	SendMessageGlobal(string.format("~~>  %s  <~~", lugar.Nome), 0)
end

function CaT.NpcTalk(Npc, Player)
	if not running then return 0 end
	
	if Npc == catNpc then
		local pInv = Inventory.new(Player)

		local qtdItem = 0
		for slot = 12, 75 do
			if pInv:isItem(slot) ~= 0 then
				if pInv:getIndex(slot) == GET_ITEM(item.Section, item.Index) then
					if item.Level == -1 or pInv:getLevel(slot) == item.Level then
						qtdItem = qtdItem + 1
					end
				end
			end
		end
		
		if qtdItem >= item.Quantidade then
			local player = User.new(Player)
			vencedor = {Nome = player:getName(), Login = player:getAccountID()}
			running = false
			CaT.FimEvento()			
		end
		
		return 1
	end
	
	return 0
end

function CaT.FimEvento(tipo)
	running = false
	if type(vencedor) == "number" then
		SendMessageGlobal(string.format("## Evento Caça ao Tesouro ##"), 0)
		SendMessageGlobal(string.format(" "), 0)
		SendMessageGlobal(string.format("Não houve vencedor!"), 0)
		
	else
		DataBase.SetAddValue("MEMB_INFO", CaT_PremioMoeda.Coluna, CaT_PremioMoeda.Quantidade, "memb___id", vencedor.Login)
		DataBase.SetAddValue("Character", CaT_PremioPonto.Coluna, CaT_PremioPonto.Quantidade, "Name", vencedor.Nome)
		DataBase.SetAddValue("Character", CaT_PremioPonto2.Coluna, CaT_PremioPonto2.Quantidade, "Name", vencedor.Nome)
	
		SendMessageGlobal(string.format("## Evento Caça ao Tesouro ##"), 0)
		SendMessageGlobal(string.format("Vencedor: %s", vencedor.Nome), 0)
		SendMessageGlobal(string.format("Prêmio: %d %s", CaT_PremioMoeda.Quantidade, CaT_PremioMoeda.Nome), 0)
	end
	
	if tipo == 0 then
		Timer.Cancel(timerFinish)
	end
	timerFinish = -1
	Timer.Cancel(timerRunnig)
	timerRunnig = -1
	gObjDel(catNpc)
	lugar = -1
	item = -1
	vencedor = -1
	catNpc = -1
	return
end

function CaT.ComandoAbrir(aIndex)
	local player = User.new(aIndex)

	if player:getAuthority() == 1 then return end
	
	if running then
		SendMessage(string.format("Já existe um Caça ao Tesouro aberto"), aIndex, 1)
		SendMessage(string.format("Utilize %s para finalizar", CaT_CommandCancel), aIndex, 1)
		return
	end
	
	CaT.AbrirEvento()
	return
end

function CaT.ComandoCancelar(aIndex)
	local player = User.new(aIndex)

	if player:getAuthority() == 1 then return end
	
	if not running then
		SendMessage(string.format("Não existe um Caça ao Tesouro aberto"), aIndex, 1)
		SendMessage(string.format("Utilize %s para começar", CaT_CommandOpen), aIndex, 1)
		return
	end
	
	CaT.FimEvento()
	return
end

CaT.Init()

return CaT