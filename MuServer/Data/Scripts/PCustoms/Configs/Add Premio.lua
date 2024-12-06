-----------------------------------------
	-- Script:		Add Prêmio
	-- Criador:		Pedro Borges
	-- Skype:		live:ppborges93
	-- WhatsApp:	+55 51 99507-8287
	-- Servidor:	King
-----------------------------------------

-- true ativa o comando, false desativa
AddPremio_Ativado = true

-- Comando para adicionar um premio. Sintaxe: /comando Nome_Do_Premio nick
AddPremio_Comando = "/add"

-- Coloque o nick do personagem que poderá usar o comando e o nível da permissão
AddPremio_NivelPermissao = {}
AddPremio_NivelPermissao["Admin"] = 10
AddPremio_NivelPermissao["SubAdmin"] = 10
AddPremio_NivelPermissao["Mano_GM"] = 5


-- para criar um prêmio, copie a linha AddPremio_Config["Nome_Do_Premio"] = {}
-- Dentro dos colchetes coloque o nome do premio que será digitado no comando (deve ser minúsculo e não pode ter espaços)
-- Dentro das chaves, coloque o nome, a IdPremio que será usada para identificar os itens, e o nivel de permissão para poder dar o premio
AddPremio_Config = {}
AddPremio_Config["box"] =         {Nome = "Mystery Reward",                IdPremio = 1,    NivelPermissao = 5,  TemValidade = 0, Dias = -1}
AddPremio_Config["box2"] =        {Nome = "Mystery Reward",                IdPremio = 7,    NivelPermissao = 10, TemValidade = 0, Dias = -1}
AddPremio_Config["box2"] =        {Nome = "Mystery Reward",                IdPremio = 7,    NivelPermissao = 5,  TemValidade = 0, Dias = -1}
AddPremio_Config["box"] =         {Nome = "Mystery Reward",                IdPremio = 1,    NivelPermissao = 10, TemValidade = 0, Dias = -1}
AddPremio_Config["novato"] =      {Nome = "Box Of War Reward",             IdPremio = 2,    NivelPermissao = 5,  TemValidade = 0, Dias = -1}
AddPremio_Config["novato"] =      {Nome = "Box Of War Reward",             IdPremio = 2,    NivelPermissao = 10, TemValidade = 0, Dias = -1}
AddPremio_Config["evento"] =      {Nome = "Mystery Reward",                IdPremio = 3,    NivelPermissao = 5,  TemValidade = 0, Dias = -1}
AddPremio_Config["new"] =         {Nome = "Necromancer Reward New player", IdPremio = 4,    NivelPermissao = 10, TemValidade = 0, Dias = -1}
AddPremio_Config["amuleto"] =     {Nome = "Amulet Reward",                 IdPremio = 10,   NivelPermissao = 10, TemValidade = 0, Dias = -1}
AddPremio_Config["ofwar"] =       {Nome = "Box Reward",                    IdPremio = 6,    NivelPermissao = 10, TemValidade = 0, Dias = -1}
AddPremio_Config["savithar"] =    {Nome = "Savithar Reward",               IdPremio = 11,   NivelPermissao = 10, TemValidade = 0, Dias = -1}


-- Para configurar os itens de um prèmio, copie a linha AddPremio_Itens[IdPremio] = {}
-- Dentro dos colchetes coloque o IdPremio configurado acima
-- Dentro das chaves adicione os itens conforme exemplo abaixo, sempre colocando uma virgula no final da linha
AddPremio_Itens = {} -- não repetir essa linha
--# INICIO DO PRÊMIO 1 #--

AddPremio_Itens[1] = {
	{Nome = "Mystery Reward", Section =  14, Id =  236, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
}

AddPremio_Itens[7] = {
	{Nome = "Mystery Reward", Section =  14, Id =  236, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Mystery Reward", Section =  14, Id =  236, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
}
AddPremio_Itens[3] = {
	{Nome = "Mystery Reward", Section =  14, Id =  236, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
}

AddPremio_Itens[2] = {
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Reward To Olympus", Section =  14, Id =  218, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},

}


AddPremio_Itens[4] = {
	{Nome = "Necromancer Sword",   Section =  0,   Id =  86, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Shield",  Section =  6,  Id =  230, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Helm",    Section =  7,  Id =  245, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Armor",   Section =  8,  Id =  245, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Pants",   Section =  9,  Id =  245, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Gloves",  Section =  10, Id =  245, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Boots",   Section =  11, Id =  245, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Cape",    Section =  12, Id =  255, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 0, Dias = -1},
	{Nome = "Necromancer Earring", Section =  15, Id =  400, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
	{Nome = "Necromancer Earring", Section =  15, Id =  401, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
}


AddPremio_Itens[5] = {
	{Nome = "Amulet Reward",   Section =  13,   Id =  222, Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 63, Excelente = 1, Dias = -1},
}	


AddPremio_Itens[6] = {
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},
	{Nome = "Box Reward", Section =  14, Id =  238, Level = 0, Durabilidade = 0, Skill = 0, Luck = 0, Opt = 0, Excelente = 0, Dias = -1},

}

AddPremio_Itens[11] = {
	{Nome = "Savithar Wing",                   Section =  12,  Id =  333,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Cape",                   Section =  12,  Id =  332,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	
	{Nome = "Savithar Helm",                   Section =  7,   Id =  100,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Armor",                  Section =  8,   Id =  100,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Pants",                  Section =  9,   Id =  100,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Gloves",                 Section =  10,  Id =  100,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Boots",                  Section =  11,  Id =  100,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	
	{Nome = "Savithar Sword",                  Section =  0,   Id =  153,   Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Knifer",                 Section =  0,   Id =  154,   Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Hammer",                 Section =  0,   Id =  155,   Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Shield",                 Section =  6,   Id =  271,   Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	
	{Nome = "Savithar Horse [RL]",          Section =  13,  Id =  299,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	
	{Nome = "Savithar Ring     [RL]",        Section =  15,  Id =  481,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Ring     [RL]",        Section =  15,  Id =  481,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Pendant  [RL]",        Section =  15,  Id =  482,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Earring  [R][RL]",     Section =  15,  Id =  486,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Earring  [L][RL]",     Section =  15,  Id =  487,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	{Nome = "Savithar Artifact [L][RL]",     Section =  15,  Id =  485,  Level = 15, Durabilidade = 255, Skill = 1, Luck = 1, Opt = 7, Excelente = 63, Dias = -1},
	
}
--# FIM DO PRÊMIO 1 #--