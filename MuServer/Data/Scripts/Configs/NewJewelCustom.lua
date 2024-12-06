-- true ativa o sistema, false desativa
NewJewelCustom_Ativado = true

-- Mensagem quando tem sucesso na utiliza��o da j�ia (caso queira usar o nome da joia basta colocar %s)
NewJewelCustom_MensagemSucesso = " A Liberacao foi Concedida  "

-- Mensagem quando falha na utiliza��o da j�ia (caso queira usar o nome da joia basta colocar %s)
NewJewelCustom_MensagemFalha = " A Liberacao Falhou "

-- Mensagem quando a j�ia n�o pode ser usada pelo niveld e vip do player
NewJewelCustom_MensagemVIp = " Você não pode usar essa Joia "

-- Index para identificar no NewJewelCustom_ItemOriginal
-- Nome da jóia
-- grupo no item.txt
-- id no item.txt
-- level da joia (-1 qualquer level)
-- Nivel de vip para poder usar a joia (true pode, false nao pode) (0 = free, 1 = vip 1, 2 = vip 2)
-- Taxa de sucesso por vip de 0.01 a 100 (0 = free, 1 = vip 1, 2 = vip 2)

NewJewelCustom_Config = {
	{Index = 1, Nome = "Silver Key Unlock",  Grupo = 14, Id = 262, Level = -1, Vip = {[0] = true, [1] = true, [2] = true}, Sucesso = {[0] = 50, [1] = 50, [2] = 50}},
	{Index = 2, Nome = "Gold Key Unlock", 	 Grupo = 14, Id = 263, Level = -1, Vip = {[0] = true, [1] = true, [2] = true}, Sucesso = {[0] = 100, [1] = 100, [2] = 100}}
}

-- Index do NewJewelCustom_Config
-- Index para identificar no NewJewelCustom_ItemNovo
-- grupo do item no item.txt
-- id do item no item.txt
-- level do item (-1 qualquer level)


NewJewelCustom_ItemOriginal = {
	{Index = 1, ItemNovo = 1, Grupo = 7,  Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 2, Grupo = 8,  Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 3, Grupo = 9,  Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 4, Grupo = 10, Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 5, Grupo = 11, Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},

-- 02 BLACK
	{Index = 1, ItemNovo = 6,  Grupo = 7,  Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 7,  Grupo = 8,  Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 8,  Grupo = 9,  Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 9,  Grupo = 10, Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 1, ItemNovo = 10, Grupo = 11, Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},	

-- FENRIR	
	{Index = 2, ItemNovo = 11, Grupo = 0,  Id = 161, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	
	
	{Index = 2, ItemNovo = 1, Grupo = 7,  Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 2, Grupo = 8,  Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 3, Grupo = 9,  Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 4, Grupo = 10, Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 5, Grupo = 11, Id = 107, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},

-- 02 BLACK
	{Index = 2, ItemNovo = 6,  Grupo = 7,  Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 7,  Grupo = 8,  Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 8,  Grupo = 9,  Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 9,  Grupo = 10, Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},
	{Index = 2, ItemNovo = 10, Grupo = 11, Id = 108, Level = -1, Excelente = false, CriarItemNexSeFalhar = false, DeletarSeFalhar = false},	
}

NewJewelCustom_NovoItemSeDeletar = {
	Grupo = 0, Id = 20, LevelMin = 0, LevelMax = 0, DurMin = 0, DurMax = 0, Skill = 0, Luck = 0, OptMin = 0, OptMax = 0, ExcMin = 0, ExcMax = 0, Quantidade = 1, Dias = -1, Extras = true
}

NewJewelCustom_NovoItemSeDeletarExtras = {
	{ Grupo = 0, Id = 20, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1}
}

-- ItemNovo do NewJewelCustom_ItemOriginal
-- Grupo do item no item.txt
-- Id do item no item.txt
-- Level Minimo (0 a 15)
-- Level Maximo (0 a 15)
-- Durabilidade Minima (0 a 255)
-- Durabilidade Maxima (0 a 255)
-- Skill - 0 n�o, 1 sim, -1 aleat�rio
-- Luck - 0 n�o, 1 sim, -1 aleat�rio
-- Option Minima (0 a 7)
-- Option Maxima (0 a 7)
-- Excelente Minimo (0 a 6)
-- Excelente Maximo (0 a 6)
-- Quantidade para criar (minimo 1)
-- Dias - -1 para item normal, a partir de 1 quantidade de dias do item temporario
-- Index para identificar no NewJewelCustom_ItemNovoExtra (-1 para nao criar itens extras)
NewJewelCustom_ItemNovo = {
-- 08 BLACK 
	{Index = 1, Grupo = 7,  Id = 105, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 2, Grupo = 8,  Id = 105, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 3, Grupo = 9,  Id = 105, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 4, Grupo = 10, Id = 105, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 5, Grupo = 11, Id = 105, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	
-- 02 BLACK
	{Index = 6,  Grupo = 7,  Id = 106, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 7,  Grupo = 8,  Id = 106, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 8,  Grupo = 9,  Id = 106, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 9,  Grupo = 10, Id = 106, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
	{Index = 10, Grupo = 11, Id = 106, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},

-- HORN OF FENRIR BLACK V2
	{Index = 11,  Grupo = 13,  Id = 300, LevelMin = 15, LevelMax = 15, DurMin = 255, DurMax = 255, Skill = 1, Luck = 1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1, Extras = -1},
}


-- Extras do NewJewelCustom_ItemNovo
-- Grupo do item no item.txt
-- Id do item no item.txt
-- Level Minimo (0 a 15)
-- Level Maximo (0 a 15)
-- Durabilidade Minima (0 a 255)
-- Durabilidade Maxima (0 a 255)
-- Skill - 0 n�o, 1 sim, -1 aleat�rio
-- Luck - 0 n�o, 1 sim, -1 aleat�rio
-- Option Minima (0 a 7)
-- Option Maxima (0 a 7)
-- Excelente Minimo (0 a 6)
-- Excelente Maximo (0 a 6)
-- Quantidade para criar (minimo 1)
-- Dias - -1 para item normal, a partir de 1 quantidade de dias do item temporario
NewJewelCustom_ItemNovoExtra = {
	{Index = 133, Grupo = 0, Id = 21, LevelMin = 0, LevelMax = 15, DurMin = 0, DurMax = 255, Skill = -1, Luck = -1, OptMin = 7, OptMax = 7, ExcMin = 6, ExcMax = 6, Quantidade = 1, Dias = -1},
}