-----------------------------------------
	-- Script:		Taxa
	-- Criador:		Pedro Borges
	-- Skype:		live:ppborges93
	-- WhatsApp:	+55 51 99507-8287
-----------------------------------------

Taxa_Config = {
	-- true ativa o sistema, false desativa
	Ativado = true,

	Moeda = {
		Tabela = "MEMB_INFO",
		Coluna = "jcpoints",
		Where = "memb___id",
		Nome = "JCPoints",
		Tipo = 0
	},

	Itens = {
		[GET_ITEM(0, 153)] = 75000000,
		[GET_ITEM(0, 154)] = 75000000,
		[GET_ITEM(0, 155)] = 75000000,
		[GET_ITEM(6, 271)] = 75000000,
		[GET_ITEM(7, 100)] = 75000000,
		[GET_ITEM(8, 100)] = 75000000,
		[GET_ITEM(9, 100)] = 75000000,
		[GET_ITEM(10, 100)] = 75000000,
		[GET_ITEM(11, 100)] = 75000000,
		[GET_ITEM(12, 332)] = 75000000,
		[GET_ITEM(12, 333)] = 75000000,
		[GET_ITEM(13, 299)] = 75000000,
		[GET_ITEM(15, 481)] = 75000000,
		[GET_ITEM(15, 482)] = 75000000,
		[GET_ITEM(15, 485)] = 75000000,
		[GET_ITEM(15, 486)] = 75000000,
		[GET_ITEM(15, 487)] = 75000000,
		
		[GET_ITEM(0, 181)] = 750,
		[GET_ITEM(0, 182)] = 750,
		[GET_ITEM(6, 285)] = 750,
		[GET_ITEM(7,  92)] = 750,
		[GET_ITEM(8,  92)] = 750,
		[GET_ITEM(9,  92)] = 750,
		[GET_ITEM(10, 92)] = 750,
		[GET_ITEM(11, 92)] = 750,
		[GET_ITEM(12, 359)] = 1750,
		[GET_ITEM(12, 360)] = 1750,
		
		[GET_ITEM(13, 316)] = 15000,
		[GET_ITEM(13, 317)] = 25000,
		
		[GET_ITEM(2,  107)] = 5000,
		[GET_ITEM(2,  108)] = 5000,
		[GET_ITEM(4,  216)] = 5000,
		[GET_ITEM(5,  80)]  = 5000,
		[GET_ITEM(6,  286)] = 5000,
		[GET_ITEM(7,  94)]  = 5000,
		[GET_ITEM(8,  94)]  = 5000,
		[GET_ITEM(9,  94)]  = 5000,
		[GET_ITEM(10, 94)]  = 5000,
		[GET_ITEM(11, 94)]  = 5000,
		[GET_ITEM(7,  95)]  = 5000,
		[GET_ITEM(8,  95)]  = 5000,
		[GET_ITEM(9,  95)]  = 5000,
		[GET_ITEM(10, 95)]  = 5000,
		[GET_ITEM(11, 95)]  = 5000,		
		[GET_ITEM(12, 361)]  = 7000,		
		[GET_ITEM(12, 362)]  = 7000,		
		[GET_ITEM(13, 318)]  = 9000,		
		[GET_ITEM(15, 112)]  = 3000,		
		[GET_ITEM(15, 113)]  = 3000,	
		
		[GET_ITEM(2, 109)]  = 7000,		
		[GET_ITEM(4, 217)]  = 7000,		
		[GET_ITEM(5, 81)]  = 7000,		
		[GET_ITEM(6, 287)]  = 7000,	
		[GET_ITEM(7,  96)]  = 7000,
		[GET_ITEM(8,  96)]  = 7000,
		[GET_ITEM(9,  96)]  = 7000,
		[GET_ITEM(10, 96)]  = 7000,
		[GET_ITEM(11, 96)]  = 7000,
		[GET_ITEM(7,  97)]  = 7000,
		[GET_ITEM(8,  97)]  = 7000,
		[GET_ITEM(9,  97)]  = 7000,
		[GET_ITEM(10, 97)]  = 7000,
		[GET_ITEM(11, 97)]  = 7000,			
		[GET_ITEM(12, 363)]  = 10000,			
		[GET_ITEM(12, 364)]  = 10000,			
		[GET_ITEM(13, 114)]  = 4000,			
		[GET_ITEM(13, 115)]  = 4000,			

	},

	CharIsento = {
		"Admin",
		"1111",
		"11111",
	},


	Message = {
		["Por"] = {
			[1] = "Não é permitido item com taxa na lojinha",
			[2] = "Negociação isenta de taxa!",
			[3] = "Você não possui %s suficientes para realizar a troca",
			[4] = "Você pagou %d %s para realizar a troca",
		},

		["Spn"] = {
			[1] = "Não é permitido item com taxa na lojinha",
			[2] = "Negociação isenta de taxa!",
			[3] = "Você não possui %s suficientes para realizar a troca",
			[4] = "Você pagou %d %s para realizar a troca",
		},

		["Eng"] = {
			[1] = "Taxed item is not allowed on Personal Store",
			[2] = "This trade was tax free",
			[3] = "You don't have enough %s for this trade",
			[4] = "you payed %d %s for this trade",
		},
	}
}

return Taxa_Config