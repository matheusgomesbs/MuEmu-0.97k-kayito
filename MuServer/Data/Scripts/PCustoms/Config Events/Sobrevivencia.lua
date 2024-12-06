-----------------------------------------
	-- Script:  Evento Sobrevivência
	-- Criador: Pedro Borges
	-- Skype: live:ppborges93
-----------------------------------------

--Configurações evento automatico
SOBRE_AUTO_SWITCH		= 0			-- 0 Desativa o evento automático
SOBRE_ANNOUNCE_MINUTES	= 0				-- Tempo em minutos que anunciará que o evento vai começar (0 inicia sem aviso)
SOBRE_TIME_CLOSE		= 15			-- Tempo em segundos que o move ficara aberto no evento automático
-- Configuração dos horários do evento automárico
--Para o evento inicar exatamente na hora desejada, coloque o horario do evento descontando o tempo de aviso em minutos.
--Ex: Se quer que o evento começe exatamente as 22:00 e com aviso de 5 minutos, agende o evento para 21:55

--Day of Week, Day, Hour, Minute
--Day of Week: 0 a 6: Domingo, segunda, terça, quarta, quinta, sexta, sabado
--Day of Week: -1 = Day
--Day = -1 = Horas e minutos.
SOBRE_DATA	= {
{_dayofweek = -1, _day = -1, _hour = 19, _minute = 52},
{_dayofweek = -1, _day = -1, _hour = 19, _minute = 54},
{_dayofweek = -1, _day = -1, _hour = 19, _minute = 56},
{_dayofweek = -1, _day = -1, _hour = 19, _minute = 58},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 02},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 04},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 06},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 08},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 10},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 12},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 14},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 16},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 18},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 20},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 22},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 24},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 26},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 28},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 30},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 32},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 34},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 36},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 38},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 40},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 42},
{_dayofweek = -1, _day = -1, _hour = 20, _minute = 44},
}

-- Configuração evento manual
SOBRE_COMMAND_SWITCH	= 1				-- 0 desativa o comando de abrir o evento
SOBRE_COMMAND_OPEN		= "/abrirsobre"	-- Comando para abrir o evento (Sintaxe: /comando <tempo>)
SOBRE_COMMAND_GO		= "/sobre"		-- Comando para entrar no evento

-- Configurações gerais do evento
SOBRE_MIN_PLAYERS		= 2				-- Quantidade minima de players para o evento acontecer.
SOBRE_LEVEL				= 1				-- Level minimo para participar do evento
SOBRE_VIP				= 0				-- Vip minimo para participar do evento
SOBRE_RESETS			= 0				-- Quantidade minima de resets para participar do evento
SOBRE_MRESETS			= 0				-- Quantidade minima de master resets para participar do evento

SOBRE_CLASSES_PERMITIDAS = { --classes que podem ir ao evento
[0] = false, -- SM, true permitido, false não permitido
[1] = true, -- BK, true permitido, false não permitido
[2] = false, -- ELF, true permitido, false não permitido
[3] = true, -- MG, true permitido, false não permitido
[4] = false, -- DL, true permitido, false não permitido
}

SOBRE_AREA = { -- area do evento, se sair dessa area, sera desclassificado.
Map		= 1,	-- Mapa
CoordX	= 155,	-- Coordenada X -- coordenada X para onde o player sera movido ao entrar no evento
CoordY	= 189,	-- Coordenada Y	-- coordenada Y para onde o player sera movido ao entrar no evento
CoordX1	= 154,	-- Coordenada X Menor
CoordY1	= 185,	-- Coordenada Y Menor
CoordX2	= 156,	-- Coordenada X Maior
CoordY2	= 190	-- Coordenada Y Maior
} 


-- Configuração do premio
SOBRE_PREMIO_NOME = "EventPoints"			-- Nome da moeda
SOBRE_PREMIO_VALOR = 7				-- Quantidade da moeda
SOBRE_PREMIO_TABELA = "CashShopData"	-- Tabela da moeda
SOBRE_PREMIO_COLUNA = "WCoinP"		-- Coluna da moeda
SOBRE_PREMIO_WHERE = "AccountID"	-- Identificador do player
SOBRE_PREMIO_TIPO = 0 				-- Tipo de identificador, 0 = login, 1 = nick

SOBRE_PREMIO_NOME = "Events"			-- Nome da moeda
SOBRE_PREMIO_VALOR = 7				-- Quantidade da moeda
SOBRE_PREMIO_TABELA = "MEMB_INFO"	-- Tabela da moeda
SOBRE_PREMIO_COLUNA = "Events"		-- Coluna da moeda
SOBRE_PREMIO_WHERE = "memb___id"	-- Identificador do player
SOBRE_PREMIO_TIPO = 0 				-- Tipo de identificador, 0 = login, 1 = nick

SOBRE_PONTO_VALOR = 1					-- Quantidade de pontos
SOBRE_PONTO_TABELA = "Character"		-- Tabela dos pontos
SOBRE_PONTO_COLUNA = "sobrevivencia"	-- Coluna dos pontos
SOBRE_PONTO_WHERE = "Name"				-- Identificador do player
SOBRE_PONTO_TIPO = 1 					-- Tipo de identificador, 0 = login, 1 = nick

SOBRE_PONTO2_VALOR = 1					-- Quantidade de pontos
SOBRE_PONTO2_TABELA = "Character"		-- Tabela dos pontos
SOBRE_PONTO2_COLUNA = "eventostotais"	-- Coluna dos pontos
SOBRE_PONTO2_WHERE = "Name"				-- Identificador do player
SOBRE_PONTO2_TIPO = 1 					-- Tipo de identificador, 0 = login, 1 = nick



SOBRE_MESSAGES = {
	["Eng"] = {
		[1] = "× »»»»» Survivor ««««« ×",
		[2] = "starts in:",
		[3] = "%d minute(s)",
		[4] = "«•»",
		[5] = "Get Ready!",
		[6] = "× »»»»»»»»»»»»» • ««««««««««««« ×",
		[7] = "%d sec.",
		[8] = "Type to enter the event:",
		[9] = "%s",
		[10] = "[Survivor] Wait for the end of the current event",
		[11] = "[Survivor] Use %s <time>",
		[12] = "[Survivor] You left the event",
		[13] = "[Survivor] You left the event area",
		[14] = "[Survivor] You don't have permission to stay in this area",
		[15] = "Winner: %s",
		[16] = "Killed %d players",
		[17] = "[Sistema] You received %d %s.",
		[18] = "Event Cancelled!",
		[19] = "Reason:",
		[20] = "[ Lack of participants ]",
		[21] = "Wait the next event.",
		[22] = "Event started!",
		[23] = "Wait for the winner announcement.",
		[24] = "[Survivor] No event open",
		[25] = "[Survivor] You have to be on level %d",
		[26] = "[Survivor] Only VIP users can use the command!",
		[27] = "[Survivor] You need %d resets",
		[28] = "[Survivor] You need %d M.Resets",
		[29] = "[Survivor] Your class is not allowed on this event",
		[30] = "[Survivor] You are already in the event.",
		[31] = "[Survivor] You were moved.",
		[32] = "Do not move or disconnect or you will be removed from the event",
		[33] = "[Survivor] Wait for the event to start.",
		[34] = "[Survivor] %s killed %s",
		[35] = "[Survivor] %s killed you",
	},
	["Por"] = {
		[1] = "× »»»»» Evento Sobrevivência ««««« ×",
		[2] = "Início em:",
		[3] = "%d minuto(s)",
		[4] = "«•»",
		[5] = "Prepare-se!",
		[6] = "× »»»»»»»»»»»»» • ««««««««««««« ×",
		[7] = "%d seg.",
		[8] = "Para participar digite:",
		[9] = "%s",
		[10] = "[Sobre] Aguarde o fim do evento atual.",
		[11] = "[Sobre] Use %s <tempo>",
		[12] = "[Sobrevivência] Você saiu do evento.",
		[13] = "[Sobrevivência] Você saiu da área do evento.",
		[14] = "[Sobrevivência] Você nao tem permissao para ficar nessa area.",
		[15] = "Vencedor: %s",
		[16] = "Matou %d players",
		[17] = "[Sistema] Você recebeu %d %s.",
		[18] = "Evento Cancelado!",
		[19] = "Motivo:",
		[20] = "[ Falta de participantes ]",
		[21] = "Aguarde o próximo.",
		[22] = "Evento Iniciado!",
		[23] = "Aguarde o Anúncio do  vencedor.",
		[24] = "[Sobrevivência] Nenhum evento aberto",
		[25] = "[Sobrevivência] Você precisa estar acima do level %d",
		[26] = "[Sobrevivência] Somente usuários vip podem usar este comando!",
		[27] = "[Sobrevivência] Você precisa de %d resets",
		[28] = "[Sobrevivência] Você precisa de %d M.Resets",
		[29] = "[Sobrevivência] Sua classe não é permitida no evento.",
		[30] = "[Sobrevivência] Você já está participando.",
		[31] = "[Sobrevivência] Você foi movido.",
		[32] = "Não mova ou relogue ou será desclassificado.",
		[33] = "[Sobrevivência] Aguarde o inicio do evento.",
		[34] = "[Sobre] %s matou %s",
		[35] = "[Sobrevivência]Você foi morto por %s",
	},
	["Spn"] = {
		[1] = "× »»»»» Evento Sobrevivência ««««« ×",
		[2] = "Início em:",
		[3] = "%d minuto(s)",
		[4] = "«•»",
		[5] = "Prepare-se!",
		[6] = "× »»»»»»»»»»»»» • ««««««««««««« ×",
		[7] = "%d seg.",
		[8] = "Para participar digite:",
		[9] = "%s",
		[10] = "[Sobre] Aguarde o fim do evento atual.",
		[11] = "[Sobre] Use %s <tempo>",
		[12] = "[Sobrevivência] Você saiu do evento.",
		[13] = "[Sobrevivência] Você saiu da área do evento.",
		[14] = "[Sobrevivência] Você nao tem permissao para ficar nessa area.",
		[15] = "Vencedor: %s",
		[16] = "Matou %d players",
		[17] = "[Sistema] Você recebeu %d %s.",
		[18] = "Evento Cancelado!",
		[19] = "Motivo:",
		[20] = "[ Falta de participantes ]",
		[21] = "Aguarde o próximo.",
		[22] = "Evento Iniciado!",
		[23] = "Aguarde o Anúncio do  vencedor.",
		[24] = "[Sobrevivência] Nenhum evento aberto",
		[25] = "[Sobrevivência] Você precisa estar acima do level %d",
		[26] = "[Sobrevivência] Somente usuários vip podem usar este comando!",
		[27] = "[Sobrevivência] Você precisa de %d resets",
		[28] = "[Sobrevivência] Você precisa de %d M.Resets",
		[29] = "[Sobrevivência] Sua classe não é permitida no evento.",
		[30] = "[Sobrevivência] Você já está participando.",
		[31] = "[Sobrevivência] Você foi movido.",
		[32] = "Não mova ou relogue ou será desclassificado.",
		[33] = "[Sobrevivência] Aguarde o inicio do evento.",
		[34] = "[Sobre] %s matou %s",
		[35] = "[Sobrevivência]Você foi morto por %s",
	},
}