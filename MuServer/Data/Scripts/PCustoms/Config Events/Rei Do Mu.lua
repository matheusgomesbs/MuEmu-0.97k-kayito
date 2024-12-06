-----------------------------------------
	-- Script:		Rei Do mu
-----------------------------------------
ReiDoMu_Define = {}


ReiDoMu_Define.Ativado = true

ReiDoMu_Define.ComandoAbrir		    = "/abrirreidomu"	-- Comando para abrir o evento  /comando tempo
ReiDoMu_Define.ComandoIr			= "/reidomu"		-- comando para participar do evento
ReiDoMu_Define.ComandoIniciar	    = "/rminiciar"		-- comando para inciar o evento, usado apos o termino do tempo od comando abrir
ReiDoMu_Define.ComandoChamar		= "/rmproximo"		-- comando para chamar a proxima luta
ReiDoMu_Define.ComandoCancelar	    = "/rmcancelar"		-- comando para cancelar o evento
ReiDoMu_Define.ComandoFinaliar	    = "/rmfim"			-- comando para finaliza o evento e premiar o vencedor
ReiDoMu_Define.ComandoWin		    = "/rmwin"			-- comando para finalizar uma luta  /comando 1/2
ReiDoMu_Define.ComandoInfo		    = "/rminfo"			-- comando para saber a posição para usar o comando win e quando nao houver luta, mostra quantos players restam no evento
ReiDoMu_Define.ComandoCorrigir	    = "/rmcorrigir"		-- comando para corrigir o resultado de uma luta

ReiDoMu_Define.MinimoPlayers = 2		                -- minimo de players para o evento ocorrer
ReiDoMu_Define.MaximoPlayers = 10	                    -- maximo de players, após atingir esse limite nenhum player pode entrar no evento

ReiDoMu_Define.Spawn = {Mapa = 6, X = 195, Y = 195}     -- coordenada para onde os players que participarão do evento serão movidos
ReiDoMu_Define.Spot = {}
ReiDoMu_Define.Spot[1] = {Mapa = 6, X = 215, Y = 195}   -- coordenada do lutador 1
ReiDoMu_Define.Spot[2] = {Mapa = 6, X = 217, Y = 195}   -- coordenada do lutador 2

ReiDoMu_Define.Premio_Tabela	= "CashShopData"		-- tabela no sql da moeda premio
ReiDoMu_Define.Premio_Coluna	= "hpoints"			    -- coluna no sql da moeda premio
ReiDoMu_Define.Premio_Where		= "AccountID"		    -- coluna de identificação do player
ReiDoMu_Define.Premio_Tipo		= 0					    -- tipo de identificador. Login: 0, Nick: 1
ReiDoMu_Define.Premio_Nome		= "HPoints"			    -- nome da moeda
ReiDoMu_Define.Premio_Valor		= 50				    -- valor a ser creditado ao player

ReiDoMu_Define.Premio_Tabela	= "MEMB_INFO"		    -- tabela no sql da moeda premio
ReiDoMu_Define.Premio_Coluna	= "Events"			    -- coluna no sql da moeda premio
ReiDoMu_Define.Premio_Where		= "memb___id"		    -- coluna de identificação do player
ReiDoMu_Define.Premio_Tipo		= 0					    -- tipo de identificador. Login: 0, Nick: 1
ReiDoMu_Define.Premio_Nome		= "Events"			    -- nome da moeda
ReiDoMu_Define.Premio_Valor		= 1				        -- valor a ser creditado ao player

ReiDoMu_Define.Ponto_Tabela	= "Character"		        -- tabela no sql da moeda premio
ReiDoMu_Define.Ponto_Coluna	= "ReiDoPvP"			    -- coluna no sql da moeda premio
ReiDoMu_Define.Ponto_Where		= "Name"		        -- coluna de identificação do player
ReiDoMu_Define.Ponto_Tipo		= 1					    -- tipo de identificador. Login: 0, Nick: 1

ReiDoMu_Define.Message = {
	["Eng"] = {
		[1] = "Não há mais vagas no evento",
		[2] = "Você está participando do evento",
		[3] = "Já exsite um evento Rei Do Mu aberto",
		[4] = "Use %s <tempo>",
		[5] = "%s abriu %s",
		[6] = "Use %s",
		[7] = "Evento Rei Do Mu iniciado",
		[8] = "Use %s posição",
		[9] = "Para saber a posição use %s",
		[10] = "Correção:",
		[11] = "Restam %d jogadores no evento",
		[12] = "Posição 1 [x] Posição 2",
		[13] = "Você recebeu %d %s",
		[14] = "Prêmio do Evento Rei Do Mu",
		[15] = "Adicionado para < %s >",
		[16] = "%s fechou",
		[17] = "%s fecha em %d segundo(s)",
		[18] = "Evento Rei Do Mu cancelado",
	},

	["Por"] = {
		[1] = "Não há mais vagas no evento",
		[2] = "Você está participando do evento",
		[3] = "Já exsite um evento Rei Do Mu aberto",
		[4] = "Use %s <tempo>",
		[5] = "%s abriu %s",
		[6] = "Use %s",
		[7] = "Evento Rei Do Mu iniciado",
		[8] = "Use %s posição",
		[9] = "Para saber a posição use %s",
		[10] = "Correção:",
		[11] = "Restam %d jogadores no evento",
		[12] = "Posição 1 [x] Posição 2",
		[13] = "Você recebeu %d %s",
		[14] = "Prêmio do Evento Rei Do Mu",
		[15] = "Adicionado para < %s >",
		[16] = "%s fechou",
		[17] = "%s fecha em %d segundo(s)",
		[18] = "Evento Rei Do Mu cancelado",
	},

	["Spn"] = {
		[1] = "Não há mais vagas no evento",
		[2] = "Você está participando do evento",
		[3] = "Já exsite um evento Rei Do Mu aberto",
		[4] = "Use %s <tempo>",
		[5] = "%s abriu %s",
		[6] = "Use %s",
		[7] = "Evento Rei Do Mu iniciado",
		[8] = "Use %s posição",
		[9] = "Para saber a posição use %s",
		[10] = "Correção:",
		[11] = "Restam %d jogadores no evento",
		[12] = "Posição 1 [x] Posição 2",
		[13] = "Você recebeu %d %s",
		[14] = "Prêmio do Evento Rei Do Mu",
		[15] = "Adicionado para < %s >",
		[16] = "%s fechou",
		[17] = "%s fecha em %d segundo(s)",
		[18] = "Evento Rei Do Mu cancelado",
	},
}

return ReiDoMu_Define