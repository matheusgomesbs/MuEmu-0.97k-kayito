Quiz_Config = {
	-- true ativa o envento, false desativa
	Ativado = false,

	-- COmando para responder a pergunta
	ComandoResposta = "/quiz",
	
	-- Comando para iniciar um quiz aleatório
	ComandoAbrir = "/abrirquiz",

	-- Comando para cancelar um quiz aberto
	ComandoCancelar = "/fimquiz",

 	-- tempo em minutos que o evento fica aberto, se ninguem responder ele encerrará automaticamente
	TimeOut = 1, 

	-- Pontuações do evento
	Premio = {
		{Quantidade = 10, Tabela = "CashShopData", Coluna = "HPoints", Where = "AccountID", Tipo = 0},
		{Quantidade = 1 , Tabela = "Character", Coluna = "quiz" , Where = "Name"     , Tipo = 1},
		{Quantidade = 1 , Tabela = "Character", Coluna = "honra", Where = "Name"     , Tipo = 1},
	},

	-- Perguntas e respostas
	Perguntas = {
		-------------------------------- pregunta 1
		{
			Pergunta = {
				["Por"] = "Qual a capital do Brasil?",
				["Eng"] = "Qual a capital do Brasil?",
				["Spn"] = "Qual a capital do Brasil?",
			},
			Resposta = {
				["Por"] = "Brasilia",
				["Eng"] = "Brasilia",
				["Spn"] = "Brasilia",
			},
		},

		-------------------------------- pregunta 2
		{
			Pergunta = {
				["Eng"] = "Quanto é 2+1x0? (Responda com número)",
				["Spn"] = "Quanto é 2+1x0? (Responda com número)",
				["Por"] = "Quanto é 2+1x0? (Responda com número)",
			},
			Resposta = {
				["Por"] = "2",
				["Eng"] = "2",
				["Spn"] = "2",
			},
		},

	},

	-- Agenda do evento automatico
	Cron = {
		{DiaSemana = -1, Dia = -1, Hora = 00, Minuto = 23},
	},

	Mensagens = {
		["Por"] = {
			[1] = "====== QUIZ AUTOMÁTICO ======",
			[2] = "Utilize %s para responder",
			[3] = "Vencedor: %s",
			[4] = "Resposta: %s",
			[5] = "[Sistema] Resposta incorreta",
			[6] = "[Sistema] Parabéns! Você acertou a resposta",
			[7] = "Não houve vencedor",
			[8] = "[Sistema] Você recebeu sua premiação",
		},
		["Eng"] = {
			[1] = "====== QUIZ AUTOMÁTICO ======",
			[2] = "Utilize %s para responder",
			[3] = "Vencedor: %s",
			[4] = "Resposta: %s",
			[5] = "[Sistema] Resposta incorreta",
			[6] = "[Sistema] Parabéns! Você acertou a resposta",
			[7] = "Não houve vencedor",
			[8] = "[Sistema] Você recebeu sua premiação",
		},
		["Spn"] = {
			[1] = "====== QUIZ AUTOMÁTICO ======",
			[2] = "Utilize %s para responder",
			[3] = "Vencedor: %s",
			[4] = "Resposta: %s",
			[5] = "[Sistema] Resposta incorreta",
			[6] = "[Sistema] Parabéns! Você acertou a resposta",
			[7] = "Não houve vencedor",
			[8] = "[Sistema] Você recebeu sua premiação",
		},
	}
}

return Quiz_Config
