--[[
Commands Configs
]]--
--Configurações Npc PkClear
PKCLEAR_NPC_SWITCH = 0
PKCLEAR_NPC = { {Class = 233, Map = 0, CoordX = 135, CoordY = 127, Dir = 5},
{Class = 233, Map = 2, CoordX = 220, CoordY = 132, Dir = 3} }

--Configurações comando /limparpk
PKCLEAR_COMMAND = "/limparpk"
PKCLEAR_SWITCH = 1
PKCLEAR_LEVEL = 1
PKCLEAR_RESETS = 0
PKCLEAR_MRESETS = 0
PKCLEAR_VIP = 0
PKCLEAR_MONEY = 1000000

--[[
Message Config
]]--
PK_CLEAR_MESSAGES = { }

PK_CLEAR_MESSAGES["Por"] = {
[1] = "[Sistema] Você não é PK nem HERO!",
[2] = "[Sistema] Você precisa estar acima do level %d",
[3] = "[Sistema] Você precisa de %d zen",
[4] = "[Sistema] Somente usuários vip podem usar este comando!",
[5] = "[Sistema] Você precisa de %d resets",
[6] = "[Sistema] Você precisa de %d M.Resets",
[7] = "[Sistema] Pk/Hero Limpo com sucesso.",
}

PK_CLEAR_MESSAGES["Eng"] = {
[1] = "[System] You are neither PK nor HERO!",
[2] = "[System] You need to be above level %d",
[3] = "[System] You need %d zen",
[4] = "[System] Only VIP users can use this command!",
[5] = "[System] You need %d resets",
[6] = "[System] You need %d M.Resets",
[7] = "[System] Pk / Hero successfully cleared.",
}

PK_CLEAR_MESSAGES["Spn"] = {
[1] = "[Sistema] ¡No eres PK ni HÉROE!",
[2] = "[Sistema] Debes estar por encima del nivel %d",
[3] = "[Sistema] Necesitas %d zen",
[4] = "[Sistema] ¡Solo los usuarios VIP pueden usar este comando!",
[5] = "[Sistema] Necesitas %d restablecimientos",
[6] = "[Sistema] Necesitas %d M.Resets",
[7] = "[System] Pk / Hero eliminado correctamente.",
}