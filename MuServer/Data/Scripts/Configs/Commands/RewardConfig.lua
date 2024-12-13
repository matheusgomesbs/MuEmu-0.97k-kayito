--[[
Commands Config
]]--
--Configura��es comando /bonus
REWARD_COMMAND = "/bonushallow"
REWARD_INVENTORY = 0
REWARD_SWITCH = 0
REWARD_COUNTS = 0 -- Vezes que o player pode usar o comando na conta!

--Class Classe que vai receber o b�nus, 0 - SM | 1 - BK | 2 - ELF | 3 - MG

REWARD_ITEMS = {
{Class = 0, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},
{Class = 0, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},
{Class = 0, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},


{Class = 1, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},
{Class = 1, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},
{Class = 1, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},


{Class = 2, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},
{Class = 2, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},
{Class = 2, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0},



{Class = 3, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0} ,
{Class = 3, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0} ,
{Class = 3, ItemSection = 14, ItemIndex = 272, Level = 0, Luck = 0, Skill = 0, Option = 0, Exc1 = 0, Exc2 = 0, Exc3 = 0, Exc4 = 0, Exc5 = 0, Exc6 = 0} }



--[[
Message Configs
]]--
REWARD_MESSAGES = { }

REWARD_MESSAGES["Por"] = {
[1] = "[Sistema] Voc� j� utilizou seu b�nus!",
[2] = "[Sistema] Seu invent�rio precisa estar vazio!",
[3] = "[Sistema] Sua recompensa foi colocado no invent�rio!",
[4] = "[Sistema] Pegue sua recompensa no ch�o!",
}

REWARD_MESSAGES["Eng"] = {
[1] = "[System] You already used your bonus!",
[2] = "[System] Your inventory must be empty!",
[3] = "[System] Your reward has been placed in the inventory!",
[4] = "[System] Get your reward on the floor!",
}

REWARD_MESSAGES["Spn"] = {
[1] = "[Sistema] �Ya usaste tu bonificaci�n!",
[2] = "[Sistema] �Tu inventario debe estar vac�o!",
[3] = "[Sistema] �Su recompensa ha sido colocada en el inventario!",
[4] = "[Sistema] �Obt�n tu recompensa en el piso!",
}