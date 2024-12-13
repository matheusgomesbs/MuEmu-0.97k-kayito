BuyWare_Config = {
	-- true Ativa o comando, false desativa
	Enabled	= true,

	Command	= {
		["Eng"] = "/buyware",
		["Por"] = "/comprarbau",
		["Spn"] = "/comprarbau",
	},

	MaxVaults = {
		--[nivel vip] = m�ximo de baus que pode comprar
		[0] = 500,
		[1] = 500,
		[2] = 500,
	},

	Coin = {
		--[nivel vip] = dados da moeda e valor do bau
		[0] = {
			Name = "Cash",
			Price = 0,
			Table = "MEMB_INFO",
			Column = "cash",
			Where = "memb___id",
			IdType = 0 -- 0 Login, 1 Nick		
		},

		[1] = {
			Name = "Cash",
			Price = 0,
			Table = "MEMB_INFO",
			Column = "cash",
			Where = "memb___id",
			IdType = 0 -- 0 Login, 1 Nick		
		},

		[2] = {
			Name = "Cash",
			Price = 0,
			Table = "MEMB_INFO",
			Column = "cash",
			Where = "memb___id",
			IdType = 0 -- 0 Login, 1 Nick			
		},
	},

	Message = {
		["Eng"] = {
			[1] = " Voc� precisa de %d %s para comprar um ba� ",
			[2] = " Voc� atingiu o limite de ba�s dispon�veis ",
			[3] = " Ba� comprado com sucesso, foram descontados %d %s de sua conta "
		},
		["Por"] = {
			[1] = " Voc� precisa de %d %s para comprar um ba� ",
			[2] = " Voc� atingiu o limite de ba�s dispon�veis ",
			[3] = " Ba� comprado com sucesso, foram descontados %d %s de sua conta "
		},
		["Spn"] = {
			[1] = " Voc� precisa de %d %s para comprar um ba� ",
			[2] = " Voc� atingiu o limite de ba�s dispon�veis ",
			[3] = " Ba� comprado com sucesso, foram descontados %d %s de sua conta "
		},
	}
}

return BuyWare_Config