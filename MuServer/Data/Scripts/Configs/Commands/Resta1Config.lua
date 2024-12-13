-----------------------------------------
	-- Script:  Evento RESTA1viv�ncia
	-- Criador: Pedro Borges
	-- Skype: live:ppborges93
-----------------------------------------

--Configura��es comando
RESTA1_AUTO_SWITCH		= 0				-- 0 Desativa o evento autom�tico
RESTA1_COMMAND_SWITCH	= 1				-- 0 desativa o comando de abrir o evento

RESTA1_COMMAND_OPEN		= "/openresta1"	-- Comando para abrir o evento (Sintaxe: /comando <tempo>)
RESTA1_COMMAND_GO		= "/resta1"		-- Comando para entrar no evento
RESTA1_MIN_PLAYERS		= 2				-- Quantidade minima de players para o evento acontecer.
RESTA1_ANNOUNCE_MINUTES	= 1				-- Tempo em minutos que anunciar� que o evento vai come�ar (minimo 1)
RESTA1_TIME_CLOSE		= 15			-- Tempo em segundos que o move ficara aberto no evento autom�tico
RESTA1_LEVEL				= 1				-- Level minimo para participar do evento
RESTA1_VIP				= 0				-- Vip minimo para participar do evento
RESTA1_RESETS			= 0				-- Quantidade minima de resets para participar do evento
RESTA1_MRESETS			= 0				-- Quantidade minima de master resets para participar do evento

RESTA1_MAGIAS_BLOQUEADAS = {6, 15}

RESTA1_LOCATION	= {
Map		= 1,	-- Mapa onde ocorrer� o evento.
CoordX	= 19,	-- Coordenada X onde ocorrer� o evento.
CoordY	= 22	-- Coordenada Y onde ocorrer� o evento.
} 

RESTA1_AREA = {
Map		= 1,	-- Mapa onde ocorrer� o evento.
CoordX1	= 17,
CoordY1	= 22,
CoordX2	= 19,
CoordY2	= 24
} 



-- Configura��o da premia��o para o realizador do evento
RESTA1_STAFF_REWARD	= {
MoneyTable		= "CashShopData",		-- Tabela da moeda
MoneyColumn		= "WCoinP", 		-- Coluna da moeda
MoneyWhere		= "AccountID", 	    -- Indentificador da conta
MoneyAmmount	= 7,				-- Quantidade da moeda
MoneyName		= "EventPoints",		-- Nome da moeda
PointsTable		= "Character", 		-- Tabela dos pontos
PointsColumn	= "resta1",	-- Coluna dos pontos
PointsWhere		= "Name",			-- Identificador do Char
PointsAmmount	= 0					-- Quantidade
}

-- Configura��o da premia��o para o player vencedor do evento.
RESTA1_PLAYER_REWARD	= {
MoneyTable		= "CashShopData",		-- Tabela da moeda
MoneyColumn		= "WCoinP", 		-- Coluna da moeda
MoneyWhere		= "AccountID", 	    -- Indentificador da conta
MoneyAmmount	= 7,				-- Quantidade da moeda
MoneyName		= "EventPoints",		-- Nome da moeda
PointsTable		= "Character", 		-- Tabela dos pontos
PointsColumn	= "resta1",	-- Coluna dos pontos
PointsWhere		= "Name",			-- Identificador do Char
PointsAmmount	= 1					-- Quantidade
}

-- Configura��o dos hor�rios do evento autom�rico
--Para o evento inicar exatamente na hora desejada, coloque o horario do evento descontando o tempo de aviso em minutos.
--Ex: Se quer que o evento come�e exatamente as 22:00 e com aviso de 5 minutos, agende o evento para 21:55

--Day of Week, Day, Hour, Minute
--Day of Week: 0 a 6: Domingo, segunda, ter�a, quarta, quinta, sexta, sabado
--Day of Week: -1 = Day
--Day = -1 = Horas e minutos.
RESTA1_DATA	= {
{_dayofweek = -1, _day = -1, _hour = 07, _minute = 20},
{_dayofweek = -1, _day = -1, _hour = 06, _minute = 20},

}