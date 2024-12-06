DropBox_Config = {
	Enabled = false,

	Box = {
		[GET_ITEM(14, 272)] = {
			
		[1] = {Itens = true, Random = true, Group = false, Inventory = true, Vip = {[0] = true, [1] = true, [2] = true}},
		
		},

	},

	Group = { 

		[1] = {
			{Itens = 1, Rate = {[0] = 40, [1] = 40, [2] = 40}},
			{Itens = 2, Rate = {[0] = 40, [1] = 40, [2] = 40}},
		},
	},

	Itens = {
		[1] = {
			{Name = "troll",        Section = -1, Index = -1, LevelMin = 15, LevelMax = 15, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, MinSocket = 0, MaxSocket = 0, Time = 0, Rate = {[0] = 50, [1] = 50, [2] = 50}, ExtraItens = -1, Fireworks = false, Announce = true},
			{Name = "Short Sword",  Section = 12, Index = 233, LevelMin = 15, LevelMax = 15, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, MinSocket = 0, MaxSocket = 0, Time = 0, Rate = {[0] = 25, [1] = 25, [2] = 25}, ExtraItens = -1, Fireworks = true, Announce = false},
		},
	},

	ExtraItens = {
		[3] = {
			{Section = 0, Index = 2, RecalculateOptions = true, LevelMin = 0, LevelMax = 15, Skill = -1, Luck = -1, OptMin = 0, OptMax = 7, ExcMin = 0, ExcMax = 6, MinSocket = 0, MaxSocket = 5, Time = 0},
		},
		
	},

	Message = {
		["Eng"] = {
			[1] = "[Sistema] Seu inventário precisa estar vazio",
			[2] = "[Sistema] Feche outras janelas antes de dropar o item",
			[3] = "[Sistema] Seu plano vip não permite o drop desse item",
			[4] = "[%s] Voc� foi trolado ;)",
			[5] = "==============================",
			[6] = "[%s]",
			[7] = "%s dropou:",
			[8] = "%s",
			[9] = "%s foi trolado",
		},
		["Por"] = {
			[1] = "[Sistema] Seu invent�rio precisa estar vazio",
			[2] = "[Sistema] Feche outras janelas antes de dropar o item",
			[3] = "[Sistema] Seu plano vip n�o permite o drop desse item",
			[4] = "[%s] Voc� foi trolado ;)",
			[5] = "==============================",
			[6] = "[%s]",
			[7] = "%s dropou:",
			[8] = "%s",
			[9] = "%s foi trolado",
		},
		["Spn"] = {
			[1] = "[Sistema] Seu invent�rio precisa estar vazio",
			[2] = "[Sistema] Feche outras janelas antes de dropar o item",
			[3] = "[Sistema] Seu plano vip n�o permite o drop desse item",
			[4] = "[%s] Voc� foi trolado ;)",
			[5] = "==============================",
			[6] = "[%s]",
			[7] = "%s dropou:",
			[8] = "%s",
			[9] = "%s foi trolado",
		},
	}
}

return DropBox_Config