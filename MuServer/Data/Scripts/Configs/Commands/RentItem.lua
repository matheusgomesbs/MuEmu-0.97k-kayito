-----------------------------------------
	-- Script:		Aluguel de Item
	-- Criador:		Pedro Borges
-----------------------------------------

RentItem_Config = {
	Enabled = true,

	Command = {
		["Eng"] = "/rent",
		["Por"] = "/alugar",
		["Spn"] = "/alugar"
	},

	Coin = {
		[1] = {
			Name = "HPoints",
			Table = "MEMB_INFO",
			Column = "HPoints",
			Where = "memb___id",
			IdType = 0 -- 0 Login, 1 Nick	
		},
		[2] = {
			Name = "WCoinP",
			Table = "CashShopData",
			Column = "WCoinP",
			Where = "AccountID",
			IdType = 0 -- 0 Login, 1 Nick	
		},
		[3] = {
			Name = "Goblin Point",
			Table = "CashShopData",
			Column = "GoblinPoint",
			Where = "AccountID",
			IdType = 0 -- 0 Login, 1 Nick	
		},
	},

	Item = {
		--["identificador"] = {nomde do item, index da moeda, preço para alugar, ativa/desativa aluguel para o vip}
		-- identificador tem que ser minusculo. No jogo o player pode digitar de qualquer forma, apenas na configuração que é obrigatória ser minusculo
		-- exemplo de uso: /alugar dragon knight set
		["short sword"] = {Name = "Short Sword", Coin = 1, Price = 0, Vip = {[0] = true, [1] = true, [2] = true}},
		["dragon knight set"] = {Name = "Dragon Knight Set", Coin = 3, Price = 50, Vip = {[0] = false, [1] = true, [2] = true}},

	},

	Result = {
		["short sword"] = {
			{Section = 0, Index = 1, Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, TimeExpire = (86400*7)},
		},

		["dragon knight set"] = { -- TimerExpire em segundos, (86400*7) = 7 dias
			{Section = 7 , Index = 29, Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, TimeExpire = (86400*7)},
			{Section = 8 , Index = 29, Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, TimeExpire = (86400*7)},
			{Section = 9 , Index = 29, Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, TimeExpire = (86400*7)},
			{Section = 10, Index = 29, Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, TimeExpire = (86400*7)},
			{Section = 11, Index = 29, Level = 15, Op1 = 1, Op2 = 1, Life = 7, Exc = 63, Ancient = 0, JoH = 0, SocketBonus = 255, Sock1 = 255, Sock2 = 255, Sock3 = 255, Sock4 = 255, Sock5 = 255, TimeExpire = (86400*7)},
		},

	},

	Message = {
		["Eng"] = {
			[1] = " Item não localizado ",
			[2] = " Você precisa de %d %s para alugar o item ",
			[3] = " Seu invetário precisa estar vazio ",
			[4] = " Esse item não está disponível para o seu plano vip ",
			[5] = " Você alugou 1 %s por %d %s"
		},
		
		["Por"] = {
			[1] = " Item não localizado ",
			[2] = " Você precisa de %d %s para alugar o item ",
			[3] = " Seu invetário precisa estar vazio ",
			[4] = " Esse item não está disponível para o seu plano vip ",
			[5] = " Você alugou 1 %s por %d %s"
		},
		
		["Spn"] = {
			[1] = " Item não localizado ",
			[2] = " Você precisa de %d %s para alugar o item ",
			[3] = " Seu invetário precisa estar vazio ",
			[4] = " Esse item não está disponível para o seu plano vip ",
			[5] = " Você alugou 1 %s por %d %s"
		},
	}

}

return RentItem_Config