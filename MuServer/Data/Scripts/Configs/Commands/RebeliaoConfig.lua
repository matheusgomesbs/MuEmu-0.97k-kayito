-----------------------------------------
	-- Script:  Rebelião
	-- Criador: Pedro Borges
	-- Skype: live:ppborges93
-----------------------------------------

--Configurações comando
REB_AUTO_SWITCH		= 0				     -- 0 Desativa o evento automático
REB_COMMAND_SWITCH	= 1				     -- 0 desativa o comando de abrir o evento

REB_COMMAND_OPEN		= "/openreb"	 -- Comando para abrir o evento (Sintaxe: /comando <tempo>)
REB_COMMAND_GO		= "/rebeliao"        -- Comando para entrar no evento
REB_MIN_PLAYERS		= 2				     -- Quantidade minima de players para o evento acontecer.
REB_ANNOUNCE_MINUTES	= 1			     -- Tempo em minutos que anunciará que o evento vai começar (minimo 1)
REB_TIME_CLOSE		= 15			     -- Tempo em segundos que o move ficara aberto no evento automático
REB_LEVEL				= 100		     -- Level minimo para participar do evento
REB_VIP				= 0				     -- Vip minimo para participar do evento
REB_RESETS			= 0				     -- Quantidade minima de resets para participar do evento
REB_MRESETS			= 0				     -- Quantidade minima de master resets para participar do evento

REB_MAGIAS_BLOQUEADAS = {6, 15}

REB_LOCATION	= {
Map		= 2,	-- Mapa onde ocorrerá o evento.
CoordX	= 25,	-- Coordenada X onde ocorrerá o evento.
CoordY	= 62	-- Coordenada Y onde ocorrerá o evento.
} 

REB_AREA = {
Map		= 2,	-- Mapa onde ocorrerá o evento.
CoordX1	= 13,
CoordY1	= 56,
CoordX2	= 31,
CoordY2	= 67
} 

-- Configuração da premiação para o realizador do evento
REB_STAFF_REWARD	= {
MoneyTable		= "MEMB_INFO",		-- Tabela da moeda
MoneyColumn		= "HPoints", 		    -- Coluna da moeda
MoneyWhere		= "memb___id", 	    -- Indentificador da conta
MoneyAmmount	= 30,				-- Quantidade da moeda
MoneyName		= "HPoints",		    -- Nome da moeda
PointsTable		= "Character", 		-- Tabela dos pontos
PointsColumn	= "rebeliao",	    -- Coluna dos pontos
PointsWhere		= "Name",			-- Identificador do Char
PointsAmmount	= 1					-- Quantidade
}


-- Configuração da premiação para o player vencedor do evento.
REB_PLAYER_REWARD	= {
MoneyTable		= "MEMB_INFO",		-- Tabela da moeda
MoneyColumn		= "HPoints",			-- Coluna da moeda
MoneyWhere		= "memb___id",		-- Indentificador da conta
MoneyAmmount	= 25,				-- Quantidade da moeda
MoneyName		= "HPoints",		    -- Nome da moeda
PointsTable		= "Character",		-- Tabela dos pontos
PointsColumn	= "rebeliao",	    -- Coluna dos pontos
PointsWhere		= "Name",			-- Identificador do Char
PointsAmmount	= 1					-- Quantidade
}

-- Configuração dos horários do evento automárico
--Para o evento inicar exatamente na hora desejada, coloque o horario do evento descontando o tempo de aviso em minutos.
--Ex: Se quer que o evento começe exatamente as 22:00 e com aviso de 5 minutos, agende o evento para 21:55

--Day of Week, Day, Hour, Minute
--Day of Week: 0 a 6: Domingo, segunda, terça, quarta, quinta, sexta, sabado
--Day of Week: -1 = Day
--Day = -1 = Horas e minutos.
REB_DATA	= {
--{_dayofweek = -1, _day = -1, _hour = 08, _minute = 20},
--{_dayofweek = -1, _day = -1, _hour = 08, _minute = 35},

}