ReiDoMu = {}
local open = false
local running = false
local started = false
local timerAberto = nil
local tempoAberto = 0
local Players = {}
local Spot = {}

function ReiDoMu.Init()
	
	if ReiDoMu_Define.Ativado then
		Commands.Register(ReiDoMu_Define.ComandoAbrir		, ReiDoMu.ComandoAbrir    )
		Commands.Register(ReiDoMu_Define.ComandoIr			, ReiDoMu.ComandoIr       )
		Commands.Register(ReiDoMu_Define.ComandoChamar		, ReiDoMu.ComandoChamar   )
		Commands.Register(ReiDoMu_Define.ComandoIniciar		, ReiDoMu.ComandoIniciar  )
		Commands.Register(ReiDoMu_Define.ComandoCancelar	, ReiDoMu.ComandoCancelar )
		Commands.Register(ReiDoMu_Define.ComandoFinaliar	, ReiDoMu.ComandoFim      )
		Commands.Register(ReiDoMu_Define.ComandoWin	    	, ReiDoMu.ComandoWin      )
		Commands.Register(ReiDoMu_Define.ComandoInfo		, ReiDoMu.ComandoInfo     )
		Commands.Register(ReiDoMu_Define.ComandoCorrigir 	, ReiDoMu.ComandoCorrigir )
	end
end

function ReiDoMu.ComandoIr(aIndex)
	if not open then return end
	
	local player = User.new(aIndex)
	local lang = player:getLanguage()


	if #Players >= ReiDoMu_Define.MaximoPlayers then
		if not ReiDoMu.HasKey(aIndex) then		
			SendMessage(ReiDoMu_Define.Message[lang][1], aIndex, 1)
			return
		end		
	end
	
	if not ReiDoMu.HasKey(aIndex) then		
		table.insert(Players, {Index = aIndex})
	end

	Teleport(aIndex, ReiDoMu_Define.Spawn.Mapa, ReiDoMu_Define.Spawn.X, ReiDoMu_Define.Spawn.Y)
	SendMessage(ReiDoMu_Define.Message[lang][2], aIndex, 1)
end

function ReiDoMu.ComandoAbrir(aIndex, Arguments)
	local player = User.new(aIndex)
	local lang = player:getLanguage()
	if player:getAuthority() == 1 then return end
	
				
	if not AuthorizarionAccount.CheckAuth(aIndex, Arguments) then
        return
    end
	
	if open or running then
		SendMessage(ReiDoMu_Define.Message[lang][3], aIndex, 1)
		return
	end
	
	tempoAberto = command:getNumber(Arguments, 1)
	
	if tempoAberto == nil or tempoAberto <= 0 then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][4], ReiDoMu_Define.ComandoAbrir), aIndex, 1)
		return
	end
	
	open = true
	SendMessageGlobal(string.format(ReiDoMu_Define.Message[lang][5], player:getName(), ReiDoMu_Define.ComandoIr), 1)
	timerAberto = Timer.Repeater(1, tempoAberto, ReiDoMu.Anunciar)	
end

function ReiDoMu.ComandoIniciar(aIndex)
	local player = User.new(aIndex)
	local lang = player:getLanguage()
	if player:getAuthority() == 1 then return end
	
	if not running then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][4], ReiDoMu_Define.ComandoAbrir), aIndex, 1)
		return
	end
	
	if started then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoChamar), aIndex, 1)
		return
	end
	
	started = true
	
	SendMessageGlobal(string.format("========================="), 0)
	SendMessageGlobal(string.format("[%s]", player:getName()), 0)
	Message.SendMessageGlobalMultLang(ReiDoMu_Define.Message, 7, 0)
	SendMessageGlobal(string.format("========================="), 0)
end

function ReiDoMu.ComandoChamar(aIndex)
	local gm = User.new(aIndex)
	local lang = gm:getLanguage()
	if gm:getAuthority() == 1 then return end
	
	if not running then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][4], ReiDoMu_Define.ComandoAbrir), aIndex, 1)
		return
	end
	
	if not started then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoIniciar), aIndex, 1)
		return
	end
	
	if Spot[1] ~= nil and Spot[2] ~= nil then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][8], ReiDoMu_Define.ComandoWin), aIndex, 1)
		return
	end
	
	if #Players <= 0 then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoFinaliar), aIndex, 1)
		return
	end
	local p1Index = 0
	local p2Index = 0
	local player1 = 0
	local player2 = 0
	if Spot[1] == nil then
		::back::
		if #Players <= 0 then
			SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoFinaliar), aIndex, 1)
			return
		end
		p1Index = Players[Utils.GetRandom(1, #Players, math.random(1, 10))].Index
		player1  = User.new(p1Index)
		ReiDoMu.RemovePlayer(p1Index)
		if player1:getConnected() ~= 3 then goto back end
		Spot[1] = p1Index
	else
		if player1 == 0 then
			player1 = User.new(Spot[1])
		end
	end
	
	if Spot[2] == nil then
		::back::
		if #Players <= 0 then
			SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoFinaliar), aIndex, 1)
			return
		end
		p2Index = Players[Utils.GetRandom(1, #Players, math.random(1, 10))].Index
		player2  = User.new(p2Index)
		ReiDoMu.RemovePlayer(p2Index)
		if player2:getConnected() ~= 3 then goto back end
		Spot[2] = p2Index
	else
		if player2 == 0 then
			player2 = User.new(Spot[2])
		end
	end
	
	Teleport(Spot[1], ReiDoMu_Define.Spot[1].Mapa, ReiDoMu_Define.Spot[1].X, ReiDoMu_Define.Spot[1].Y)
	Teleport(Spot[2], ReiDoMu_Define.Spot[2].Mapa, ReiDoMu_Define.Spot[2].X, ReiDoMu_Define.Spot[2].Y)

	SendMessageGlobal(string.format("[%s]", gm:getName()), 0)
	SendMessageGlobal(string.format("%s [x] %s", player1:getName(), player2:getName()), 0)
end

function ReiDoMu.ComandoWin(aIndex, Arguments)
	local gm = User.new(aIndex)
	local lang = gm:getLanguage()
	if gm:getAuthority() == 1 then return end
	
	if not running then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][4], ReiDoMu_Define.ComandoAbrir), aIndex, 1)
		return
	end
	
	if not started then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoIniciar), aIndex, 1)
		return
	end
	
	if Spot[1] == nil or Spot[2] == nil then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoChamar), aIndex, 1)
		return
	end
	
	local vencedor = command:getNumber(Arguments, 1)
		
	if vencedor == nil or vencedor < 1 or vencedor > 2 then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][8], ReiDoMu_Define.ComandoWin), aIndex, 1)
		SendMessage(string.format(ReiDoMu_Define.Message[lang][9], ReiDoMu_Define.ComandoInfo), aIndex, 1)
		return
	end
	
	local perdedor = 1
	if vencedor == 1 then
		perdedor = 2
	end
	
	Spot[3] = Spot[perdedor]
	Teleport(Spot[perdedor], 0, 125, 125)
	Spot[perdedor] = nil
	local player = User.new(Spot[vencedor])
	local guildnome = player:getGuildName()
	if guildnome ~= '' then
		SendMessageGlobal(string.format("%s [G]%s wins", player:getName(), guildnome), 0)
	else
		SendMessageGlobal(string.format("%s  wins", player:getName()), 0)
	end
end

function ReiDoMu.ComandoCorrigir(aIndex)
	local gm = User.new(aIndex)
	local lang = gm:getLanguage()
	if gm:getAuthority() == 1 then return end
	
	if not running then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][4], ReiDoMu_Define.ComandoAbrir), aIndex, 1)
		return
	end
	
	if not started then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoIniciar), aIndex, 1)
		return
	end
	
	if Spot[1] ~= nil and Spot[2] ~= nil then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][8], ReiDoMu_Define.ComandoWin), aIndex, 1)
		return
	end
	
	if Spot[3] == nil then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][8], ReiDoMu_Define.ComandoWin), aIndex, 1)
		return
	end
	
	if Spot[1] == nil then
		Spot[1] = Spot[3]
		Teleport(Spot[1], ReiDoMu_Define.Spot[1].Mapa, ReiDoMu_Define.Spot[1].X, ReiDoMu_Define.Spot[1].Y)
		Teleport(Spot[2], 0, 125, 125)
		Spot[2] = nil
		local player = User.new(Spot[1])
		SendMessageGlobal(string.format("[%s]", gm:getName()), 0)
		Message.SendMessageGlobalMultLang(ReiDoMu_Define.Message, 10, 0)
		local guildnome = player:getGuildName()
		if guildnome ~= '' then
			SendMessageGlobal(string.format("%s [G]%s wins", player:getName(), guildnome), 0)
		else
			SendMessageGlobal(string.format("%s  wins", player:getName()), 0)
		end
		
	end
	
	if Spot[2] == nil then
		Spot[2] = Spot[3]
		Teleport(Spot[2], ReiDoMu_Define.Spot[2].Mapa, ReiDoMu_Define.Spot[2].X, ReiDoMu_Define.Spot[2].Y)
		Teleport(Spot[1], 0, 125, 125)
		Spot[1] = nil
		local player = User.new(Spot[2])
		SendMessageGlobal(string.format("[%s]", gm:getName()), 0)
		Message.SendMessageGlobalMultLang(ReiDoMu_Define.Message, 10, 0)
		local guildnome = player:getGuildName()
		if guildnome ~= '' then
			SendMessageGlobal(string.format("%s [G]%s wins", player:getName(), guildnome), 0)
		else
			SendMessageGlobal(string.format("%s  wins", player:getName()), 0)
		end
	end
	
	Spot[3] = nil
end

function ReiDoMu.ComandoInfo(aIndex)
	local gm = User.new(aIndex)
	local lang = gm:getLanguage()
	if gm:getAuthority() == 1 then return end
	
	if not running then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][4], ReiDoMu_Define.ComandoAbrir), aIndex, 1)
		return
	end
	
	if Spot[1] == nil or Spot[2] == nil then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][11], #Players), aIndex, 1)
		return
	end
	local player1 = User.new(Spot[1])
	local player2 = User.new(Spot[2])
	SendMessage(string.format(ReiDoMu_Define.Message[lang][12]), aIndex, 1)
	SendMessage(string.format("%s [x] %s", player1:getName(), player2:getName()), aIndex, 1)
end

function ReiDoMu.ComandoFim(aIndex)
	local gm = User.new(aIndex)
	local lang = gm:getLanguage()
	if gm:getAuthority() == 1 then return end
	
	if not running then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][4], ReiDoMu_Define.ComandoAbrir), aIndex, 1)
		return
	end
	
	if not started then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoIniciar), aIndex, 1)
		return
	end
	
	if #Players > 0 then
		SendMessage(string.format(ReiDoMu_Define.Message[lang][6], ReiDoMu_Define.ComandoChamar), aIndex, 1)
		return
	end
	
	local vencedor = 1
	if Spot[vencedor] == nil then
		vencedor = 2
	end
	local player = User.new(Spot[vencedor])
	
	local tp = ""
	if ReiDoMu_Define.Premio_Tipo == 0 then
		tp = player:getAccountID()
	else
		tp = player:getName()
	end
	DataBase.SetAddValue(ReiDoMu_Define.Premio_Tabela, ReiDoMu_Define.Premio_Coluna, ReiDoMu_Define.Premio_Valor, ReiDoMu_Define.Premio_Where, tp)
	
	if ReiDoMu_Define.Ponto_Tipo == 0 then
		tp = player:getAccountID()
	else
		tp = player:getName()
	end
	DataBase.SetValue(ReiDoMu_Define.Ponto_Tabela, ReiDoMu_Define.Ponto_Coluna, 1, ReiDoMu_Define.Ponto_Where, tp)
	
	SendMessage(string.format(ReiDoMu_Define.Message[lang][13], ReiDoMu_Define.Premio_Valor, ReiDoMu_Define.Premio_Nome), Spot[vencedor], 1)
	SendMessageGlobal(string.format("========================="), 0)
	SendMessageGlobal(string.format("[%s]", gm:getName()), 0)
	Message.SendMessageGlobalMultLang(ReiDoMu_Define.Message, 14, 0)
	Message.SendMessageGlobalMultLangArgs(ReiDoMu_Define.Message, 15, 0, player:getName())
	SendMessageGlobal(string.format("========================="), 0)
	Teleport(Spot[vencedor], 0, 125, 125)
	open = false
	started = false
	running = false
	timerAberto = nil
	tempoAberto = 0
	Players = {}
	Spot = {}
end

function ReiDoMu.Anunciar()
	if tempoAberto <= 0 then
		open = false
		Timer.Cancel(timerAberto)
		timerAberto = nil
		
		if #Players < ReiDoMu_Define.MinimoPlayers then
			ReiDoMu.Cancelar()
			return
		end
		Message.SendMessageGlobalMultLangArgs(ReiDoMu_Define.Message, 16, 0, ReiDoMu_Define.ComandoIr)
		running = true
	else
		Message.SendMessageGlobalMultLangArgs(ReiDoMu_Define.Message, 17, 0, ReiDoMu_Define.ComandoIr, tempoAberto)
		tempoAberto = tempoAberto - 1
	end
end

function ReiDoMu.ComandoCancelar(aIndex)	
	local gm = User.new(aIndex)
	if gm:getAuthority() == 1 then return end
	
	if not running and not open then return end
	
	ReiDoMu.Cancelar()
end

function ReiDoMu.Cancelar()
	open = false
	started = false
	running = false
	if timerAberto ~= nil then
		Timer.Cancel(timerAberto)
		timerAberto = nil
	end
	tempoAberto = 0
	Players = {}
	Spot = {}
	
	Message.SendMessageGlobalMultLang(ReiDoMu_Define.Message, 18, 1)
end

function ReiDoMu.HasKey(aIndex)
	for i in ipairs(Players) do
		if Players[i].Index == aIndex then
			return true
		end
	end
	return false
end

function ReiDoMu.RemovePlayer(aIndex)
	for i in ipairs(Players) do
		if Players[i].Index == aIndex then
			table.remove(Players, i)
		end
	end
end

ReiDoMu.Init()

return ReiDoMu